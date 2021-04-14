#include "tracing.h"

void f() {
    besc_tracepoint("f_1");
}

int main() {
    if (rand()) {
        besc_tracepoint("main_1");
        f();
        besc_tracepoint("main_2");
    } else {
        besc_tracepoint("main_3");
        f();
        besc_tracepoint("main_4");
    }
    return 0;
}
