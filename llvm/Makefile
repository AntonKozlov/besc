.PRECIOUS : tests/%.ll

all : split_blocks check_cycles test

test : check_cycles

check_cycles : check_cycles.cpp
	$(CXX) -O3 -Wall -std=c++14 $< $(shell llvm-config --cxxflags --ldflags --libs --system-libs) -o $@

split_blocks : split_blocks.cpp
	$(CXX) -O3 -Wall -std=c++14 $< $(shell llvm-config --cxxflags --ldflags --libs --system-libs) -o $@

TESTS=$(patsubst tests/%.c,%,$(wildcard tests/*.c))

test: $(TESTS:%=do-%)

tests/%.ll : tests/%.c
	clang -Wno-implicit-function-declaration -emit-llvm -S $< -o $@

test-rules = do-$1 : tests/$1.ll check_cycles

$(call test-rules,%)
	./check_cycles $< main_entry main_exit

$(call test-rules,test1)
	./check_cycles $< main_entry main_exit ; [ $$? = 4 ]

$(call test-rules,test2)
	./check_cycles $< main_entry 2
	./check_cycles $< main_entry main_exit ; [ $$? = 4 ]

$(call test-rules,test3)
	./check_cycles $< main_entry 22
	./check_cycles $< main_entry main_exit ; [ $$? = 4 ]

clean:
	rm -f *.o check_cycles tests/*.ll
