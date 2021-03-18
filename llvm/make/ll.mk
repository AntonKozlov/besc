c_files := $(patsubst ./%,%,$(shell find ./ -type f -name '*.c'))
files = $(patsubst %.c,tmp/%/$(1)/code.ll,$(c_files))

opt_flags := --debugify-each
opt := opt -S $(opt_flags)
analyze := opt -analyze $(opt_flags)

ll_base_files := $(call files,base)
$(ll_base_files): tmp/%/base/code.ll: %.c
	$(mkdir) && clang -emit-llvm -S $^ -o $@

ll_noattr_files := $(call files,noattr)
$(ll_noattr_files): tmp/%/noattr/code.ll: tmp/%/base/code.ll tmp/bin/remove_attrs
	$(mkdir) && $(lastword $^) $(firstword $^) > $@

ll_o1_files := $(call files,o1)
$(ll_o1_files): tmp/%/o1/code.ll: tmp/%/noattr/code.ll
	$(mkdir) && $(opt) -O1 $^ -o $@

ll_not_o1_files := $(call files,not_o1)
$(ll_not_o1_files): tmp/%/not_o1/code.ll: tmp/%/noattr/code.ll not_o1.bash
	$(mkdir) && bash $(lastword $^) $(opt_flags) -S $(firstword $^) > $@

ll_loops_files := $(call files,loops)
$(ll_loops_files): tmp/%/loops/code.ll: tmp/%/o1/code.ll tmp/bin/loops
	$(mkdir) && $(lastword $^) $(firstword $^) > $@

ll_files := $(ll_base_files) $(ll_noattr_files) $(ll_o1_files) $(ll_not_o1_files) $(ll_loops_files)

analyze_scev_rules := $(patsubst tmp/%.ll,analyze.scev.%,$(ll_files))
$(analyze_scev_rules): analyze.scev.%: tmp/%/base/code.ll
	$(analyze) -scalar-evolution $^

cfg_files := $(patsubst %/code.ll,%/cfg.dot,$(ll_files))
$(cfg_files) : %/cfg.dot : %/code.ll
	$(mkdir) && (cd $(dir $@) && $(analyze) -dot-cfg code.ll) && $(touch)

.PHONY: $(analyze_scev_rules)
