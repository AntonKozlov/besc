
include ../../make/base.mk

base := ../../tmp/something

$(base)/bin/loop: loop.cxx
	$(mkdir) && $(ccxx) -o $@ $^


segfault: $(base)/bin/loop
	make --directory=../.. tmp/data/loops/simple_small/base/code.ll && $(base)/bin/loop $(base)/data/loops/simple_small/base/code.ll
