#include "tracing.h"


int a;

int main() {
    if (a == 0) {
        a = 6;
    } else {
        a = 4;
    }
    besc_tracepoint("1");
    if (a == 3) {
        a = 5;
        return 0;
    }
    besc_tracepoint("2");
    while (a == 3) {};
    besc_tracepoint("3");
    return a;
}
