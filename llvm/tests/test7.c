#include "tracing.h"

void f() {
    besc_tracepoint("f_entry");
    int b = 5;
    besc_tracepoint("2");
    b++;
    besc_tracepoint("f_exit");
}

int main() {
    besc_tracepoint("main_entry");
    if (rand()) {
        for (int i = 0; i < 5; ++i) {
            besc_tracepoint("1");
        }
    } else {
        return 1;
    }
    besc_tracepoint("3");
    f();
    besc_tracepoint("main_exit");
    return 0;
}
