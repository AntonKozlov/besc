int a;

int fn() {
    return main();
}

int main() {
    if (a == 0) {
        fn();
    } else {
        return 1;
    }
    return 0;
}