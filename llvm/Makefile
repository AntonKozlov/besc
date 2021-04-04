.PRECIOUS : tests/%.ll

all : split_blocks check_cycles test

test : check_cycles

docker-image-name = besc
docker-container-workdir = /besc/llvm

.docker-image : Dockerfile
	docker build -t $(docker-image-name) .
	touch .docker-image

in-docker : .docker-image
	docker run \
        --rm \
        -v $(shell pwd):$(docker-container-workdir) \
        -w $(docker-container-workdir) \
        $(docker-image-name) make

check_cycles : check_cycles.cpp
	$(CXX) -O3 -Wall -std=c++14 $< $(shell llvm-config --cxxflags --ldflags --libs --system-libs) -o $@

insert_tracepoints : insert_tracepoints.cpp
	$(CXX) -O3 -Wall -std=c++14 $< $(shell llvm-config --cxxflags --ldflags --libs --system-libs) -o $@

split_blocks : split_blocks.cpp
	$(CXX) -O3 -Wall -std=c++14 $< $(shell llvm-config --cxxflags --ldflags --libs --system-libs) -o $@

TESTS=$(patsubst tests/%.c,%,$(wildcard tests/*.c))

test: $(TESTS:%=do-%)

tests/%.ll : tests/%.c
	clang -Wno-implicit-function-declaration -emit-llvm -S $< -o $@
	./split_blocks $@

test-rules = do-$1 : tests/$1.ll check_cycles

$(call test-rules,%)
	./check_cycles $< main_entry main_exit

$(call test-rules,test1)
	./check_cycles $< main_entry main_exit ; [ $$? = 3 ]

$(call test-rules,test2)
	./check_cycles $< main_entry 2
	./check_cycles $< main_entry main_exit ; [ $$? = 3 ]

$(call test-rules,test3)
	./check_cycles $< main_entry 1
	./check_cycles $< 1 main_entry ; [ $$? = 5 ]
	./check_cycles $< 4 main_exit
	./check_cycles $< main_exit 4 ; [ $$? = 5 ]
	./check_cycles $< main_entry main_exit ; [ $$? = 2 ]

$(call test-rules,test5)
	./check_cycles $< 1 2
	./check_cycles $< 2 1 ; [ $$? = 1 ]
	./check_cycles $< main_entry 1 ; [ $$? = 1 ]
	./check_cycles $< 2 main_exit ; [ $$? = 2 ]
	./check_cycles $< main_entry main_exit ; [ $$? = 2 ]

$(call test-rules,test6)
	./check_cycles $< 1 2 ; [ $$? = 1 ]
	./check_cycles $< 2 1 ; [ $$? = 1 ]
	./check_cycles $< main_entry 1 ; [ $$? = 1 ]
	./check_cycles $< 2 main_exit ; [ $$? = 2 ]
	./check_cycles $< main_entry main_exit ; [ $$? = 2 ]

$(call test-rules,test7)
	./check_cycles $< main_entry main_exit ; [ $$? = 3 ]
	./check_cycles $< main_entry 1 ; [ $$? = 1 ]
	./check_cycles $< 3 main_exit
	./check_cycles $< 3 2

$(call test-rules,test8)
	./check_cycles $< main_entry f_entry
	./check_cycles $< main_entry f_exit ; [ $$? = 2 ]
	./check_cycles $< main_entry main_1 ; [ $$? = 2 ]
	./check_cycles $< main_1 g_entry
	./check_cycles $< main_1 g_1
	./check_cycles $< main_1 g_exit
	./check_cycles $< main_1 main_2
	./check_cycles $< main_2 h_entry
	./check_cycles $< main_2 h_exit ; [ $$? = 2 ]
	./check_cycles $< main_2 main_3 ; [ $$? = 2 ]
	./check_cycles $< main_3 q_entry
	./check_cycles $< main_3 q_1 ; [ $$? = 1 ]
	./check_cycles $< main_3 q_2 ; [ $$? = 1 ]
	./check_cycles $< q_2 g_entry
	./check_cycles $< q_2 g_1
	./check_cycles $< q_2 g_exit
	./check_cycles $< q_2 q_exit
	./check_cycles $< q_1 g_1 ; [ $$? = 5 ]
	./check_cycles $< main_3 main_exit
	./check_cycles $< main_entry main_exit ; [ $$? = 2 ]

$(call test-rules,test9)
	./check_cycles $< main_entry main_exit
	./check_cycles $< main_1 main_2
	./check_cycles $< main_3 main_4
	./check_cycles $< main_1 main_3 ; [ $$? = 5 ]
	./check_cycles $< main_1 main_4 ; [ $$? = 5 ]
	./check_cycles $< main_entry f_1

clean:
	rm -f *.o check_cycles tests/*.ll

clean-docker : clean
	docker rmi $(docker-image-name)
	rm -f .docker-image
