#include "tracing.h"


int main() {
    if (rand()) {
        for (int i = 0; i < 5; ++i) {
            besc_tracepoint("1");
        }
    } else {
        return 1;
    }
    besc_tracepoint("2");
    return 0;
}
