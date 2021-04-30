.PRECIOUS : tests/%.ll

all : in_docker

docker_image_name = besc
docker_image_file = .docker_image
docker_container_workdir = /besc/llvm

$(docker_image_file) : Dockerfile
	docker build -t $(docker_image_name) .
	touch $@

in_docker : .docker_image
	docker run \
        --rm \
        -v $(shell pwd):$(docker_container_workdir) \
        -w $(docker_container_workdir) \
        $(docker_image_name) make without_docker

without_docker : test

blddir := build

cpp_files := $(wildcard *.cpp)

CXXFLAGS=-O3 -Wall -std=c++14 $(shell llvm-config --cxxflags)

exe := check_cycles hellollvm insert_tracepoints

$(blddir)/check_cycles : $(blddir)/bounded_loops.o $(blddir)/utils.o

$(blddir)/. :
	mkdir -p $@

$(cpp_files:%.cpp=$(blddir)/%.o) : $(blddir)/%.o : %.cpp | $(blddir)/.
	$(CXX) $(CXXFLAGS) -c -o $@ $<

$(exe:%=$(blddir)/%) : $(blddir)/% : $(blddir)/%.o
	$(CXX) $(CXXFLAGS) -o $@ $^ $(shell llvm-config --ldflags --libs --system-libs)

test : $(patsubst tests/%.c,do-%,$(wildcard tests/*.c))

tests/%.ll : tests/%.c $(blddir)/insert_tracepoints
	clang -Wno-implicit-function-declaration -emit-llvm -S $< -o $@
	./$(blddir)/insert_tracepoints $@
	#./$(blddir)/split_blocks $@

run_check_cycles := $(blddir)/check_cycles
test-rules = do-$(1) : tests/$(1).ll $(blddir)/check_cycles

# Tests that require rework due to the loop detection algo changes are commented 
$(call test-rules,test1)
	# $(run_check_cycles) $< main_entry 2 ; [ $$? = 3 ]
	# $(run_check_cycles) $< main_entry main_exit ; [ $$? = 2 ]

$(call test-rules,test2)
	$(run_check_cycles) $< main_entry 1
	# $(run_check_cycles) $< main_entry 3 ; [ $$? = 3 ]
	# $(run_check_cycles) $< main_entry main_exit ; [ $$? = 2 ]

$(call test-rules,test3)
	$(run_check_cycles) $< main_entry 1
	# $(run_check_cycles) $< 1 main_entry ; [ $$? = 5 ]
	$(run_check_cycles) $< 4 main_exit
	$(run_check_cycles) $< main_exit 4 ; [ $$? = 5 ]
	# $(run_check_cycles) $< main_entry main_exit ; [ $$? = 2 ]

$(call test-rules,test4)
	$(run_check_cycles) $< main_entry main_exit

$(call test-rules,test5)
	$(run_check_cycles) $< 1 2
	# $(run_check_cycles) $< 2 1 ; [ $$? = 1 ]
	# $(run_check_cycles) $< main_entry 1 ; [ $$? = 1 ]
	# $(run_check_cycles) $< 2 main_exit ; [ $$? = 2 ]
	# $(run_check_cycles) $< main_entry main_exit ; [ $$? = 2 ]

$(call test-rules,test6)
	$(run_check_cycles) $< 1 2 ; [ $$? = 1 ]
	$(run_check_cycles) $< 2 1 ; [ $$? = 1 ]
	$(run_check_cycles) $< main_entry 1 ; [ $$? = 1 ]
	$(run_check_cycles) $< 2 main_exit ; [ $$? = 2 ]
	$(run_check_cycles) $< main_entry main_exit ; [ $$? = 2 ]

$(call test-rules,test7)
	# $(run_check_cycles) $< main_entry main_exit ; [ $$? = 2 ]
	# $(run_check_cycles) $< main_entry 4 ; [ $$? = 3 ]
	$(run_check_cycles) $< main_entry 1 ; [ $$? = 1 ]
	$(run_check_cycles) $< 3 main_exit
	$(run_check_cycles) $< 3 2

$(call test-rules,test8)
	# $(run_check_cycles) $< main_entry f_entry
	# $(run_check_cycles) $< main_entry f_exit ; [ $$? = 2 ]
	# $(run_check_cycles) $< main_entry main_1 ; [ $$? = 2 ]
	$(run_check_cycles) $< main_1 g_entry
	$(run_check_cycles) $< main_1 g_1
	$(run_check_cycles) $< main_1 g_exit
	$(run_check_cycles) $< main_1 main_2
	# $(run_check_cycles) $< main_2 h_entry
	# $(run_check_cycles) $< main_2 h_exit ; [ $$? = 2 ]
	# $(run_check_cycles) $< main_2 main_3 ; [ $$? = 2 ]
	$(run_check_cycles) $< main_3 q_entry
	# $(run_check_cycles) $< main_3 q_1 ; [ $$? = 1 ]
	# $(run_check_cycles) $< main_3 q_2 ; [ $$? = 1 ]
	$(run_check_cycles) $< q_2 g_entry
	$(run_check_cycles) $< q_2 g_1
	$(run_check_cycles) $< q_2 g_exit
	$(run_check_cycles) $< q_2 q_exit
	# $(run_check_cycles) $< q_1 g_1 ; [ $$? = 5 ]
	$(run_check_cycles) $< main_3 main_exit
	# $(run_check_cycles) $< main_entry main_exit ; [ $$? = 2 ]

$(call test-rules,test9)
	$(run_check_cycles) $< main_entry main_exit
	$(run_check_cycles) $< main_1 main_2
	$(run_check_cycles) $< main_3 main_4
	$(run_check_cycles) $< main_1 main_3 ; [ $$? = 5 ]
	$(run_check_cycles) $< main_1 main_4 ; [ $$? = 5 ]
	# $(run_check_cycles) $< main_entry f_1


clean :
	sudo rm -rf $(blddir) tests/*.ll

deep_clean : clean
	docker rmi $(docker_image_name)
	rm -f $(docker_image_file)
