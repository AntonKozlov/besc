int main() {
    besc_tracepoint_1();
    if (rand()) {
        for (int i = 0; i < 5; ++i) {
            besc_tracepoint_3();
        }
    } else {
        return 1;
    }
    besc_tracepoint_2();
    return 0;
}
