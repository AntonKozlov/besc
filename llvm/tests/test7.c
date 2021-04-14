#include "tracing.h"

void f() {
    int b = 5;
    besc_tracepoint("2");
    b++;
}

int main() {
    if (rand()) {
        for (int i = 0; i < 5; ++i) {
            besc_tracepoint("1");
        }
    } else {
        return 1;
    }
    besc_tracepoint("3");
    f();
    besc_tracepoint("4");
    return 0;
}
