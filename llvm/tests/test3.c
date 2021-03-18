int a = 5;

int main() {
    besc_tracepoint_main_entry();
    besc_tracepoint_22();
    if (a == 3) {
        if (a == 4) {
            for (int i = 0; i < 5; ++i) {
                besc_tracepoint_3();
            }
        }
    } else {
        a = 6;
        besc_tracepoint_4();
    }
    besc_tracepoint_2();
    besc_tracepoint_main_exit();
    return 0;
}
