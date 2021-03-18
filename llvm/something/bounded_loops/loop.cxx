#include <llvm/IR/PassManager.h>
#include <llvm/IR/Attributes.h>
#include <llvm/IR/Module.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Dominators.h>
#include <llvm/Analysis/LoopInfo.h>
#include <llvm/IR/GlobalValue.h>
#include <llvm/IR/IRPrintingPasses.h>
#include <llvm/Passes/PassBuilder.h>

#include <iostream>

int main(int argc, char **argv) {
    llvm::SMDiagnostic err;
    llvm::LLVMContext context;
    auto module_ptr = llvm::parseIRFile(argv[1], err, context);
    auto& module = *module_ptr;

    auto empty_attr_list = llvm::AttributeList();
    auto manager = llvm::AnalysisManager<llvm::Module>();
    auto fn_manager = llvm::AnalysisManager<llvm::Function>();

    auto pass_builder = llvm::PassBuilder();
    // not exactly O1
    auto o1_fn_pass = pass_builder.buildFunctionSimplificationPipeline(llvm::PassBuilder::OptimizationLevel::O1, llvm::PassBuilder::ThinLTOPhase::None);

    for (auto& fun : module.getFunctionList()) {
        fun.setAttributes(empty_attr_list);
        o1_fn_pass.run(fun, fn_manager);
    }

    auto print_pass = llvm::PrintModulePass(llvm::outs());
    void(print_pass.run(module, manager));

    return 0;
}
