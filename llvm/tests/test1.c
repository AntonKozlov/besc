int main() {
    besc_tracepoint_main_entry();
    if (rand()) {
        for (int i = 0; i < 5; ++i) {
            besc_tracepoint_3();
        }
    } else {
        return 1;
    }
    besc_tracepoint_main_exit();
    return 0;
}