#include "tracing.h"

void f() {
    besc_tracepoint("f_entry");
    besc_tracepoint("f_1");
    besc_tracepoint("f_exit");
}

int main() {
    besc_tracepoint("main_entry");
    if (rand()) {
        besc_tracepoint("main_1");
        f();
        besc_tracepoint("main_2");
    } else {
        besc_tracepoint("main_3");
        f();
        besc_tracepoint("main_4");
    }
    besc_tracepoint("main_exit");
    return 0;
}
