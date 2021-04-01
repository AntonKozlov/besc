#include "tracing.h"


int main() {
    besc_tracepoint("main_entry");
    if (rand()) {
        for (int i = 0; i < 5; ++i) {
            besc_tracepoint("3");
        }
    } else {
        return 1;
    }
    besc_tracepoint("main_exit");
    return 0;
}
