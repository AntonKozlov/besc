int a = 0;

int main() {
    besc_tracepoint_main_entry();
    while(a != 2) {
        besc_tracepoint_1();
        if (a) a++;
        else a--;
        if (a == 1) break;
        besc_tracepoint_2();
    }
    besc_tracepoint_main_exit();
}
