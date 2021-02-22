clang \
  $(llvm-config --cxxflags --ldflags --libs --system-libs) \
  hellollvm.cpp -o hellollvm
