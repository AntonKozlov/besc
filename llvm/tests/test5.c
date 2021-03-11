int main() {
    besc_tracepoint_main_entry();
    for (int i = 0; i < 5; i++) {
        besc_tracepoint_1();
        int a = 0;
        if (a) a++;
        else a--;
        besc_tracepoint_2();
    }
    besc_tracepoint_main_exit();
}
