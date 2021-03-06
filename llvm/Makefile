.PRECIOUS : tests/%.ll

all : check_cycles test

test : check_cycles

check_cycles : check_cycles.cpp
	$(CXX) -O3 -Wall -std=c++14 $(shell llvm-config --cxxflags --ldflags --libs --system-libs) $< -o $@

TESTS=$(patsubst tests/%.c,%,$(wildcard tests/*.c))

test: $(TESTS:%=do-%)

tests/%.ll : tests/%.c
	clang -Wno-implicit-function-declaration -emit-llvm -S $< -o $@

do-% : tests/%.ll
	true

do-test3 : tests/test3.ll
	./check_cycles $< 1 2

clean:
	rm -f *.o check_cycles tests/*.ll
