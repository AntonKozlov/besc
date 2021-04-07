base := tmp/something

$(base)/bin/loop: something/bounded_loops/loop.cxx
	$(mkdir) && $(ccxx) -o $@ $^

segfault: $(base)/bin/loop tmp/data/loops/simple_small/base/code.ll
	$(base)/bin/loop tmp/data/loops/simple_small/base/code.ll
