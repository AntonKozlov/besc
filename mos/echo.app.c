#include <string.h>
#include "syscall.h"

int main(int argc, char *argv[]) {
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


