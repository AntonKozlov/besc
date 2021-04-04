#include "tracing.h"

void f() {
    besc_tracepoint("f_entry");
    int b = 3;
    while (b > 2) b++;
    besc_tracepoint("f_exit");
}

void g() {
    besc_tracepoint("g_entry");
    int c = 5;
    besc_tracepoint("g_1");
    c += 15 * 8;
    besc_tracepoint("g_exit");
}

void h() {
    besc_tracepoint("h_entry");
    h();
    besc_tracepoint("h_exit");
}

void q() {
    besc_tracepoint("q_entry");
    int d = 14*6+5-11*7;
    if (d == -18) {
        besc_tracepoint("q_1");
        return;
    }
    besc_tracepoint("q_2");
    g();
    besc_tracepoint("q_exit");
}

int main() {
    besc_tracepoint("main_entry");
    f();
    besc_tracepoint("main_1");
    g();
    besc_tracepoint("main_2");
    h();
    besc_tracepoint("main_3");
    q();
    besc_tracepoint("main_exit");
    return 0;
}
