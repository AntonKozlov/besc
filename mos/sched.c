#define _GNU_SOURCE

#include <assert.h>
#include <signal.h>
#include <string.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>

#include "kernel.h"
#include "ctx.h"
#include "pool.h"

/* AMD64 Sys V ABI, 3.2.2 The Stack Frame:
The 128-byte area beyond the location pointed to by %rsp is considered to
be reserved and shall not be modified by signal or interrupt handlers */
#define SYSV_REDST_SZ 128

extern void init(void);
extern void exittramp(void);

static int sched_gettime(void);
static void timer_bottom(struct hctx *hctx);

struct task {
	char stack[8192];
	struct ctx ctx;

	entry_t cloneentry;
	void *clonearg;
	struct task *wait;

	int exited;
	int priority;
	int waketime;
	struct task *next;
} __attribute__((aligned(16)));

static volatile int time;
static int tick_period;

static struct task *current;
static int current_start;
static struct task *runq;
static struct task *waitq;

static struct task idle;
static struct task taskstorage[16];
static struct pool taskpool = POOL_INITIALIZER_ARRAY(taskstorage);

static sigset_t irqs;

static struct timeval initv;


void irq_disable(void) {
	sigprocmask(SIG_BLOCK, &irqs, NULL);
}

void irq_enable(void) {
	sigprocmask(SIG_UNBLOCK, &irqs, NULL);
}

static int prio_cmp(struct task *t1, struct task *t2) {
	return t1->priority - t2->priority;
}

static void policy_run(struct task *t) {
	struct task **c = &runq;

	while (*c && prio_cmp(*c, t) <= 0) {
		c = &(*c)->next;
	}
	t->next = *c;
	*c = t;
}

static void hctx_push(greg_t *regs, unsigned long val) {
	regs[REG_RSP] -= sizeof(unsigned long);
	*(unsigned long *) regs[REG_RSP] = val;
}

static void hctx_call(greg_t *regs, void (*bottom)(struct hctx*)) {
	unsigned long *savearea = (unsigned long *)(regs[REG_RSP] - SYSV_REDST_SZ);

	*--savearea = regs[REG_RIP];
	*--savearea = regs[REG_EFL];
	*--savearea = regs[REG_RBP];
	*--savearea = regs[REG_R15];
	*--savearea = regs[REG_R14];
	*--savearea = regs[REG_R13];
	*--savearea = regs[REG_R12];
	*--savearea = regs[REG_R11];
	*--savearea = regs[REG_R10];
	*--savearea = regs[REG_R9];
	*--savearea = regs[REG_R8];
	*--savearea = regs[REG_RDI];
	*--savearea = regs[REG_RSI];
	*--savearea = regs[REG_RDX];
	*--savearea = regs[REG_RCX];
	*--savearea = regs[REG_RBX];
	*--savearea = regs[REG_RAX];

	regs[REG_RBX] = regs[REG_RDI] = (unsigned long)savearea;
	regs[REG_RSP] = (unsigned long)savearea - 16;
	*(unsigned long *)(regs[REG_RSP] -= sizeof(unsigned long)) = (unsigned long)exittramp;
	regs[REG_RIP] = (unsigned long)bottom;
}

static void alrmtop(int sig, siginfo_t *info, void *ctx) {
	ucontext_t *uc = (ucontext_t *) ctx;
	greg_t *regs = uc->uc_mcontext.gregs;
	hctx_call(regs, timer_bottom);
}

static void doswitch(void) {
	struct task *old = current;
	current = runq;
	runq = current->next;

	current_start = sched_gettime();
	ctx_switch(&old->ctx, &current->ctx);
}

static void clonetramp(void) {
	irq_enable();
	current->cloneentry(current->clonearg);
	irq_disable();
	sys_exit(1);
}

int sys_clone(entry_t entry, void *arg) {
	struct task *t = pool_alloc(&taskpool);
	ctx_make(&t->ctx, clonetramp, t->stack + sizeof(t->stack) - 16);
	t->cloneentry = entry;
	t->clonearg = arg;
	t->wait = NULL;
	t->exited = 0;
	t->priority = current->priority;
	policy_run(t);
	return t - taskstorage;
}

int sys_wait(int pid, int *codeptr) {
	irq_disable();
	struct task *t = &taskstorage[pid];
	assert(t->wait == NULL);
	t->wait = current;
	while (!t->exited) {
		doswitch();
	}
	*codeptr = t->exited >> 1;
	pool_free(&taskpool, t);
	irq_enable();
	return 0;
}

int sys_exit(int code) {
	irq_disable();
	current->exited = code << 1 | 1;
	if (current->wait) {
		policy_run(current->wait);
	}
	doswitch();
}

static void timer_bottom(struct hctx *hctx) {
	time += tick_period;

	while (waitq && waitq->waketime <= sched_gettime()) {
		struct task *t = waitq;
		waitq = waitq->next;
		policy_run(t);
	}

	if (tick_period <= sched_gettime() - current_start) {
		irq_disable();
		policy_run(current);
		doswitch();
		irq_enable();
	}
}

static int timer_cnt(void) {
	struct itimerval it;
	getitimer(ITIMER_REAL, &it);
	return 1000 * (initv.tv_sec - it.it_value.tv_sec)
		+ (initv.tv_usec - it.it_value.tv_usec) / 1000;
}

static int sched_gettime(void) {
	int cnt1 = timer_cnt();
	int time1 = time;
	int cnt2 = timer_cnt();
	int time2 = time;

	return (cnt1 <= cnt2) ?
		time1 + cnt2 :
		time2 + cnt2;
}


extern void timer_init_period() {
	initv.tv_sec  = tick_period / 1000;
	initv.tv_usec = tick_period * 1000;

	const struct itimerval setup_it = {
		.it_value    = initv,
		.it_interval = initv,
	};

	if (-1 == setitimer(ITIMER_REAL, &setup_it, NULL)) {
		perror("setitimer");
	}

	struct sigaction act = {
		.sa_sigaction = alrmtop,
		.sa_flags = SA_RESTART | SA_ONSTACK,
	};
	sigemptyset(&act.sa_mask);

	if (-1 == sigaction(SIGALRM, &act, NULL)) {
		perror("signal set failed");
		exit(1);
	}
}

int sys_sleep(int ms) {

#if 0
	if (!ms) {
		irq_disable();
		policy_run(current);
		doswitch();
		irq_enable();
		return;
	}
#endif

	current->waketime = sched_gettime() + ms;

	int curtime;
	while ((curtime = sched_gettime()) < current->waketime) {
		irq_disable();
		struct task **c = &waitq;
		while (*c && (*c)->waketime < current->waketime) {
			c = &(*c)->next;
		}
		current->next = *c;
		*c = current;

		doswitch();
		irq_enable();
	}
}

void inittramp(void) {
	init();
	doswitch();
}

static void sched_run(int period_ms) {
	sigemptyset(&irqs);
	sigaddset(&irqs, SIGALRM);

	sigset_t none;
	sigemptyset(&none);

	irq_disable();

	{
		struct task *t = pool_alloc(&taskpool);
		ctx_make(&t->ctx, inittramp, t->stack + sizeof(t->stack) - 16);
		policy_run(t);
	}

	tick_period = period_ms;
	timer_init_period();

	current = &idle;
	current->priority = 256;

	policy_run(current);
	doswitch();

	while (1) {
		sigsuspend(&none);
	}

	irq_enable();
}

static void segvtop(int sig, siginfo_t *info, void *ctx) {
	ucontext_t *uc = (ucontext_t *) ctx;
	greg_t *regs = uc->uc_mcontext.gregs;

	uint16_t *ins = (uint16_t *)regs[REG_RIP];
	if (*ins != 0x81cd) {
		abort();
	}

	regs[REG_RIP] += 2;

	hctx_call(regs, syscall_bottom);
}

int main(int argc, char *argv[]) {
	struct sigaction act = {
		.sa_sigaction = segvtop,
		.sa_flags = SA_RESTART,
	};
	sigemptyset(&act.sa_mask);

	if (-1 == sigaction(SIGSEGV, &act, NULL)) {
		perror("signal set failed");
		return 1;
	}

	sched_run(100);
	return 0;
}
