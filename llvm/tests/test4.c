int a;

int main() {
    besc_tracepoint_main_entry();
    if (a == 0) {
        a = 6;
    } else {
        a = 4;
    }
    if (a == 3) {
        a = 5;
    }
    besc_tracepoint_main_exit();
    return a;
}
