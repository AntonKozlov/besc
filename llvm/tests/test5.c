#include "tracing.h"


int main() {
    for (int i = 0; i < 5; i++) {
        besc_tracepoint("1");
        int a = 0;
        if (a) a++;
        else a--;
        besc_tracepoint("2");
    }
}
