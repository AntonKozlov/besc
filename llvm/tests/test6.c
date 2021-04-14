#include "tracing.h"


int a = 0;

int main() {
    while(a != 2) {
        besc_tracepoint("1");
        if (a) a++;
        else a--;
        if (a == 1) break;
        besc_tracepoint("2");
    }
}
