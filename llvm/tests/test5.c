#include "tracing.h"


int main() {
    besc_tracepoint("main_entry");
    for (int i = 0; i < 5; i++) {
        besc_tracepoint("1");
        int a = 0;
        if (a) a++;
        else a--;
        besc_tracepoint("2");
    }
    besc_tracepoint("main_exit");
}
