#include "tracing.h"


int a = 5;

int main() {
    besc_tracepoint("1");
    if (a == 3) {
        if (a == 4) {
            for (int i = 0; i < 5; ++i) {
                besc_tracepoint("3");
            }
        }
    } else {
        a = 6;
        besc_tracepoint("4");
    }
    besc_tracepoint("2");
    return 0;
}
