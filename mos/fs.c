
#include <stddef.h>
#include "string.h"

/*#include "init.h"*/
#include "pool.h"
/*#include "sched.h"*/
/*#include "kernel/util.h"*/
/*#include "hal/dbg.h"*/

#include "fs.h"
/*#include "ksys.h"*/

static inline unsigned long align(unsigned long v, unsigned mask) {
        return (v + mask) & ~mask;
}

static struct inode inodestorage[8];
static struct pool inopool = POOL_INITIALIZER_ARRAY(inopool, inodestorage);

static struct fd fdstorage[8];
static struct pool fdpool = POOL_INITIALIZER_ARRAY(fdpool, fdstorage);

struct cpio_old_hdr {
	unsigned short   c_magic;
	unsigned short   c_dev;
	unsigned short   c_ino;
	unsigned short   c_mode;
	unsigned short   c_uid;
	unsigned short   c_gid;
	unsigned short   c_nlink;
	unsigned short   c_rdev;
	unsigned short   c_mtime[2];
	unsigned short   c_namesize;
	unsigned short   c_filesize[2];
};

static const char *cpio_name(const struct cpio_old_hdr *ch) {
	return (const char*)ch + sizeof(struct cpio_old_hdr);
}

static const void *cpio_content(const struct cpio_old_hdr *ch) {
	return cpio_name(ch) + align(ch->c_namesize, 1);
}

static unsigned long cpio_filesize(const struct cpio_old_hdr *ch) {
	return (ch->c_filesize[0] << 16) | ch->c_filesize[1];
}

static const struct cpio_old_hdr *cpio_next(const struct cpio_old_hdr *ch) {
	return (const struct cpio_old_hdr *)
		((char*)cpio_content(ch) + align(cpio_filesize(ch), 1));
}

static unsigned int cpio_rmajor(const struct cpio_old_hdr *ch) {
	return ch->c_rdev >> 8;
}

#if 0
static unsigned int cpio_rminor(const struct cpio_old_hdr *ch) {
	return ch->c_rdev & 0xff;
}
#endif

static struct inode *fs_find(const char *path) {
	const struct cpio_old_hdr *start = kernel_root_cpio;
	const struct cpio_old_hdr *found = NULL;

	const struct cpio_old_hdr *cph = start;
	while (strcmp(cpio_name(cph), "TRAILER!!!")) {
		if (!strcmp(cpio_name(cph), path)) {
			found = cph;
			break;
		}
		cph = cpio_next(cph);
	}
	if (!found) {
		return NULL;
	}

	struct inode *ino = pool_alloc(&inopool);
	ino->ino = (char*)found - (char*)start;
	ino->major = cpio_rmajor(cph);

	return ino;
}

static void fs_release(struct inode *ino) {
	pool_free(&inopool, ino);
}

static int fd_add(struct fd *fd) {
	struct sched_task *t = sched_current();

	for (int i = 0; i < ARRAY_SIZE(t->fdtable); ++i) {
		if (!t->fdtable[i]) {
			t->fdtable[i] = fd;
			return i;
		}
	}

	return -1;
}

static int fsopen(struct fd *fd) {
	return 0;
}

static int fsread(struct fd *fd, void *buf, size_t sz) {
	struct cpio_old_hdr *ch = (struct cpio_old_hdr *)
		((char*)kernel_root_cpio + fd->ino->ino);
	int rs = min(sz, cpio_filesize(ch) - fd->off);
	memcpy(buf, cpio_content(ch) + fd->off, rs);
	fd->off += rs;
	return rs;
}

static int fswrite(struct fd *fd, const void *buf, size_t sz) {
	return -1;
}

static int fsclose(struct fd *fd) {
	return 0;
}

static struct fddrv fsfddrv = {
	.open = fsopen,
	.read = fsread,
	.write = fswrite,
	.close = fsclose,
};


static int dbgopen(struct fd *fd) {
	return 0;
}

static int dbgread(struct fd *fd, void *buf, size_t sz) {
	return dbg_in(buf, sz);
}

static int dbgwrite(struct fd *fd, const void *buf, size_t sz) {
	dbg_out(buf, sz);
	return 0;
}

static int dbgclose(struct fd *fd) {
	return 0;
}

static struct fddrv dbgfddrv = {
	.open = dbgopen,
	.read = dbgread,
	.write = dbgwrite,
	.close = dbgclose,
};

static struct fddrv *major2fddrv[] = {
	[0] = &fsfddrv,
	[4] = &dbgfddrv,
};

int sys_open(const char *path) {
	struct inode *ino = fs_find(path);
	if (!ino) {
		goto err_find;
	}

	struct fd *fd = pool_alloc(&fdpool);
	if (!fd) {
		goto err_alloc;
	}

	if (ARRAY_SIZE(major2fddrv) <= ino->major || major2fddrv[ino->major] == NULL) {
		goto err_nodrv;
	}
	fd->ino = ino;
	fd->drv = major2fddrv[ino->major];
	fd->off = 0;
	fd->refcnt = 1;

	if (fd->drv->open(fd)) {
		goto err_open;
	}

	int f = fd_add(fd);
	if (f < 0) {
		goto err_add;
	}
	return f;

err_add:
	fd->drv->close(fd);
err_open:
	pool_free(&fdpool, fd);
err_nodrv:
err_alloc:
	fs_release(ino);
err_find:
	return -1;
}

int sys_close(int f) {
	struct sched_task *t = sched_current();
	struct fd *fd = t->fdtable[f];
	if (!fd) {
		return -1;
	}

	if (--fd->refcnt) {
		return 0;
	}
	t->fdtable[f] = NULL;

	int ret = fd->drv->close(fd);
	fs_release(fd->ino);
	pool_free(&fdpool, fd);
	return ret;
}

int sys_read(int f, void *buf, size_t sz) {
	struct fd *fd = sched_current()->fdtable[f];
	if (!fd) {
		return -1;
	}

	return fd->drv->read(fd, buf, sz);
}

int sys_write(int f, const void *buf, size_t sz) {
	struct fd *fd = sched_current()->fdtable[f];
	if (!fd) {
		return -1;
	}

	return fd->drv->write(fd, buf, sz);
}
