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


exec_files_dir = build

define compile_exec_file
$(1) = $(exec_files_dir)/$(1)
run_$(1) = $$($(1))
$(1)_file = $(1).cpp
$$($(1)) : $$($(1)_file)
	mkdir -p $(exec_files_dir)
	g++ -O3 -Wall -std=c++14 $$($(1)_file) $(shell llvm-config --cxxflags --ldflags --libs --system-libs) -o $$($(1))

endef

cpp_files := $(wildcard *.cpp)
cpp_file_names := $(patsubst %.cpp,%,$(cpp_files))

$(eval $(foreach cpp_file_name,$(cpp_file_names),$(call compile_exec_file,$(cpp_file_name))))


test : $(patsubst tests/%.c,do-%,$(wildcard tests/*.c))

tests/%.ll : tests/%.c $(split_blocks) $(insert_tracepoints)
	clang -Wno-implicit-function-declaration -emit-llvm -S $< -o $@
	$(run_insert_tracepoints) $@
	$(run_split_blocks) $@

test-rules = do-$(1) : tests/$(1).ll $(check_cycles)


$(call test-rules,test1)
	$(run_check_cycles) $< main_entry 2 ; [ $$? = 3 ]
	$(run_check_cycles) $< main_entry main_exit ; [ $$? = 2 ]

$(call test-rules,test2)
	$(run_check_cycles) $< main_entry 1
	$(run_check_cycles) $< main_entry 3 ; [ $$? = 3 ]
	$(run_check_cycles) $< main_entry main_exit ; [ $$? = 2 ]

$(call test-rules,test3)
	$(run_check_cycles) $< main_entry 1
	$(run_check_cycles) $< 1 main_entry ; [ $$? = 5 ]
	$(run_check_cycles) $< 4 main_exit
	$(run_check_cycles) $< main_exit 4 ; [ $$? = 5 ]
	$(run_check_cycles) $< main_entry main_exit ; [ $$? = 2 ]

$(call test-rules,test4)
	$(run_check_cycles) $< main_entry main_exit

$(call test-rules,test5)
	$(run_check_cycles) $< 1 2
	$(run_check_cycles) $< 2 1 ; [ $$? = 1 ]
	$(run_check_cycles) $< main_entry 1 ; [ $$? = 1 ]
	$(run_check_cycles) $< 2 main_exit ; [ $$? = 2 ]
	$(run_check_cycles) $< main_entry main_exit ; [ $$? = 2 ]

$(call test-rules,test6)
	$(run_check_cycles) $< 1 2 ; [ $$? = 1 ]
	$(run_check_cycles) $< 2 1 ; [ $$? = 1 ]
	$(run_check_cycles) $< main_entry 1 ; [ $$? = 1 ]
	$(run_check_cycles) $< 2 main_exit ; [ $$? = 2 ]
	$(run_check_cycles) $< main_entry main_exit ; [ $$? = 2 ]

$(call test-rules,test7)
	$(run_check_cycles) $< main_entry main_exit ; [ $$? = 2 ]
	$(run_check_cycles) $< main_entry 4 ; [ $$? = 3 ]
	$(run_check_cycles) $< main_entry 1 ; [ $$? = 1 ]
	$(run_check_cycles) $< 3 main_exit
	$(run_check_cycles) $< 3 2

$(call test-rules,test8)
	$(run_check_cycles) $< main_entry f_entry
	$(run_check_cycles) $< main_entry f_exit ; [ $$? = 2 ]
	$(run_check_cycles) $< main_entry main_1 ; [ $$? = 2 ]
	$(run_check_cycles) $< main_1 g_entry
	$(run_check_cycles) $< main_1 g_1
	$(run_check_cycles) $< main_1 g_exit
	$(run_check_cycles) $< main_1 main_2
	$(run_check_cycles) $< main_2 h_entry
	$(run_check_cycles) $< main_2 h_exit ; [ $$? = 2 ]
	$(run_check_cycles) $< main_2 main_3 ; [ $$? = 2 ]
	$(run_check_cycles) $< main_3 q_entry
	$(run_check_cycles) $< main_3 q_1 ; [ $$? = 1 ]
	$(run_check_cycles) $< main_3 q_2 ; [ $$? = 1 ]
	$(run_check_cycles) $< q_2 g_entry
	$(run_check_cycles) $< q_2 g_1
	$(run_check_cycles) $< q_2 g_exit
	$(run_check_cycles) $< q_2 q_exit
	$(run_check_cycles) $< q_1 g_1 ; [ $$? = 5 ]
	$(run_check_cycles) $< main_3 main_exit
	$(run_check_cycles) $< main_entry main_exit ; [ $$? = 2 ]

$(call test-rules,test9)
	$(run_check_cycles) $< main_entry main_exit
	$(run_check_cycles) $< main_1 main_2
	$(run_check_cycles) $< main_3 main_4
	$(run_check_cycles) $< main_1 main_3 ; [ $$? = 5 ]
	$(run_check_cycles) $< main_1 main_4 ; [ $$? = 5 ]
	$(run_check_cycles) $< main_entry f_1


clean :
	sudo rm -rf $(exec_files_dir) tests/*.ll

deep_clean : clean
	docker rmi $(docker_image_name)
	rm -f $(docker_image_file)
