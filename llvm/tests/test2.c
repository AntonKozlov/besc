#include "tracing.h"


int a;

int main() {
    besc_tracepoint("main_entry");
    if (a == 0) {
        a = 6;
    } else {
        a = 4;
    }
    besc_tracepoint("2");
    if (a == 3) {
        a = 5;
        return 0;
    }
    besc_tracepoint("3");
    while (a == 3) {};
    besc_tracepoint("main_exit");
    return a;
}
