build:
	clang++ -O3 -Wall -std=c++14 check_cycles.cpp -o check_cycles.o `llvm-config --cxxflags --ldflags --libs --system-libs`

test:
	clang -emit-llvm -S tests/test1.c -o tests/test1.ll
	clang -emit-llvm -S tests/test2.c -o tests/test2.ll
	clang -emit-llvm -S tests/test3.c -o tests/test3.ll
	./check_cycles.o tests/test1.ll
	./check_cycles.o tests/test2.ll
	./check_cycles.o tests/test3.ll

clean:
	rm -rf *.o tests/*.ll
