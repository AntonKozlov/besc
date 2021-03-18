mkdir = mkdir -p $(dir $@)
touch = $(mkdir) && touch $@

llvm_flags := $(shell llvm-config --cxxflags --ldflags --libs --system-libs)
ccxx := clang++ -Wall -g $(llvm_flags)
