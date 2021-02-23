#pragma once

extern void *rootfs;

struct fddrv;
struct inode;
struct fd;

struct inode {
	unsigned long ino;
	unsigned short major;
	unsigned short minor;
};

struct fddrv {
	int (*open)(struct fd *fd);
	int (*read)(struct fd *fd, void *buf, size_t sz);
	int (*write)(struct fd *fd, const void *buf, size_t sz);
	int (*close)(struct fd *fd);
};

struct fd {
	struct fddrv *drv;
	struct inode *ino;
	unsigned long off;
	int refcnt;
};

int fd_ref(struct fd *fd, int add);

