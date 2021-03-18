#include <llvm/IR/PassManager.h>
#include <llvm/IR/Attributes.h>
#include <llvm/IR/Module.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/IRPrintingPasses.h>
#include <llvm/Passes/PassBuilder.h>

#include <iostream>

int main(int argc, char **argv) {
    llvm::SMDiagnostic err;
    llvm::LLVMContext context;
    auto module_ptr = llvm::parseIRFile(argv[1], err, context);
    auto& module = *module_ptr;

    auto empty_attr_list = llvm::AttributeList();

    for (auto& fun : module.getFunctionList()) {
        fun.setAttributes(empty_attr_list);
    }

    auto manager = llvm::AnalysisManager<llvm::Module>();
    auto print_pass = llvm::PrintModulePass(llvm::outs());
    void(print_pass.run(module, manager));

    return 0;
}
