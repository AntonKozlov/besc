#include "tracing.h"

void f() {
    int b = 3;
    while (b > 2) b++;
}

void g() {
    int c = 5;
    besc_tracepoint("g_1");
    c += 15 * 8;
}

void h() {
    h();
}

void q() {
    int d = 14*6+5-11*7;
    if (d == -18) {
        besc_tracepoint("q_1");
        return;
    }
    besc_tracepoint("q_2");
    g();
}

int main() {
    f();
    besc_tracepoint("main_1");
    g();
    besc_tracepoint("main_2");
    h();
    besc_tracepoint("main_3");
    q();
    return 0;
}
