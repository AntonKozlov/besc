
tmp/bin/loops: something/bounded_loops/loops.cxx
	$(mkdir) && $(ccxx) -o $@ $^
tmp/bin/remove_attrs: something/remove_attrs.cxx
	$(mkdir) && $(ccxx) -o $@ $^
