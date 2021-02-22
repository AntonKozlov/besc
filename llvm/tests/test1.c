int a;

int main() {
    if (a == 0) {
        for (;;) {
            continue;
        }
    } else {
        return 1;
    }
    return 0;
}