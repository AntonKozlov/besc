int a;
int main(){
	if (a == 0){
		return 0;
	}
	else {
		return 1;
	}
	return 0;
}

static void fn() {
	while(1);
}

int testfn_fail() {
	besc_tracepoint("tp1");
	fn();
	besc_tracepoint("tp2");
	return 1;
}

int test1_fail() {
	besc_tracepoint("tp1");
	if (rand()) {
		besc_tracepoint("tp2");
	}
}

int test2_fail() {
	besc_tracepoint("tp1");
	if (rand()) {
		while(1);
	}
	besc_tracepoint("tp2");
}

int test3_fail() {
	besc_tracepoint("tp1");
	while(1);
	besc_tracepoint("tp2");
}

int test4_fail() {
	besc_tracepoint("tp1");
	if (0) {
		while(1);
	}
	besc_tracepoint("tp2");
}
