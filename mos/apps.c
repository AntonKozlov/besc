
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

#include <time.h>
#include <sys/time.h>

#include <unistd.h>
#include <fcntl.h>
#include <elf.h>
#include <sys/mman.h>

#include "syscall.h"
#include "util.h"

#define SHELL_BUILTIN (1 << 0)

#define APPS_X(X) \
	X(retcode, SHELL_BUILTIN) \
	X(readmem, SHELL_BUILTIN) \
	X(echo,    0) \
	X(sleep,   0) \
	X(burn,    0) \

#define DECLARE(X, FLAGS) static int app_ ## X(int, char *[]);
APPS_X(DECLARE)
#undef DECLARE

static int g_retcode;

static const struct app {
	const char *name;
	int (*fn)(int, char *[]);
	int flags;
} app_list[] = {
#define ELEM(X, FLAGS) { # X, app_ ## X, FLAGS },
	APPS_X(ELEM)
#undef ELEM
};

struct execargs {
	int argc;
	char** argv;
	const struct app *app;
};

static void exectramp(void* arg) {
	struct execargs *ea = arg;
	int code = ea->app->fn(ea->argc, ea->argv);
	os_exit(code);
}

static void exec(int argc, char *argv[]) {
	const struct app *app = NULL;
	for (int i = 0; i < ARRAY_SIZE(app_list); ++i) {
		if (!strcmp(argv[0], app_list[i].name)) {
			app = &app_list[i];
			break;
		}
	}

	if (!app) {
		printf("Unknown command\n");
		return;
	}

	if (app->flags & SHELL_BUILTIN) {
		g_retcode = app->fn(argc, argv);
		return;
	}

	struct execargs args = {
		.argc = argc,
		.argv = argv,
		.app = app,
	};
	int pid = os_clone(exectramp, &args);
	os_wait(pid, &g_retcode);
}

static int app_echo(int argc, char *argv[]) {
	for (int i = 1; i < argc; ++i) {
		printf("%s%c", argv[i], i == argc - 1 ? '\n' : ' ');
	}
	return argc - 1;
}

static int app_retcode(int argc, char *argv[]) {
	printf("%d\n", g_retcode);
	return 0;
}

static int app_readmem(int argc, char *argv[]) {
	unsigned long ptr;
	if (1 != sscanf(argv[1], "%lu", &ptr)) {
		printf("cannot parse address\n");
		return 1;
	}

	printf("%d\n", *(int*)ptr);
	return 0;
}

#if 0
static int app_sysecho(int argc, char *argv[]) {
	for (int i = 1; i < argc - 1; ++i) {
		os_write(1, argv[i], strlen(argv[i]));
		os_write(1, " ", 1);
	}
	if (1 < argc) {
		os_write(1, argv[argc - 1], strlen(argv[argc - 1]));
		os_write(1, "\n", 1);
	}
	return argc - 1;
}
#endif

static long refstart;
static long reftime(void) {
	struct timespec ts;
	clock_gettime(CLOCK_MONOTONIC, &ts);
	return ts.tv_sec * 1000 + ts.tv_nsec / 1000000;
}
static void print(int id, const char *msg) {
	printf("app1 id %d %s reftime %ld\n",
			id, msg, reftime() - refstart);
	fflush(stdout);
}

static void burnproc(void *arg) {
	int id = (unsigned long)arg & 0xff;
	unsigned long toburn = (unsigned long)arg >> 8;
	while (1)  {
		print(id, "burn");
		for (volatile int i = 100000 * toburn; 0 < i; --i) {
		}
	}
}

static int app_burn(int argc, char* argv[]) {
	int id = atoi(argv[1]);
	int toburn = atoi(argv[2]);
	int pid = os_clone(burnproc, (void*)((unsigned long)toburn << 8 | id));
	printf("burn pid %d\n", pid);
	return 0;
}

static int app_sleep(int argc, char* argv[]) {
	int id = atoi(argv[1]);
	int tosleep = atoi(argv[2]);
	while (1)  {
		print(id, "sleep");
		os_sleep(tosleep);
	}
}

static int shell(int argc, char* argv[]) {
	char line[256];
	while (fgets(line, sizeof(line), stdin)) {
		const char *comsep = "\n;";
		char *stcmd;
		char *cmd = strtok_r(line, comsep, &stcmd);
		while (cmd) {
			const char *argsep = " \t";
			char *starg;
			char *arg = strtok_r(cmd, argsep, &starg);

			if (arg[0] == '#') {
				break;
			}

			char *argv[256];
			int argc = 0;
			while (arg) {
				argv[argc++] = arg;
				arg = strtok_r(NULL, argsep, &starg);
			}
			argv[argc] = NULL;

			if (!argc) {
				break;
			}

			exec(argc, argv);

			cmd = strtok_r(NULL, comsep, &stcmd);
		}
	}
}

void init(void) {
	refstart = reftime();
	char* shellargs[] = { "shell", NULL };
	shell(1, shellargs);
}
