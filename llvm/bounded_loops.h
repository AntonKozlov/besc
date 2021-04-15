#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Function.h>
#include <vector>

void runO1OptimizationPass(llvm::Module &module);

std::vector <std::vector<llvm::BasicBlock * >> extractBlocksGroupedByLoops(llvm::Function &fun);