build:
	clang++ -O3 -Wall -std=c++14 check_cycles.cpp -o check_cycles `llvm-config --cxxflags --ldflags --libs --system-libs`

test:
	./check_cycles tests/test1.ll
	./check_cycles tests/test2.ll

clean:
	rm -f *.o check_cycles
