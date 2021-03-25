#include <llvm/IR/Module.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>

#include <iostream>

#include "utils.hxx"

int main(int argc, char **argv) {
    llvm::SMDiagnostic err;
    llvm::LLVMContext context;
    auto module = llvm::parseIRFile(argv[1], err, context);

    source_printer printer(".", std::cout);

    int idx = 0;
    for (auto& fn : *module) {
        for (auto& bb : fn) {
            for (auto& inst : bb) {
                std::cout << "Instruction " << idx << std::endl;
                printer.print_code_point(inst);
                std::cout << std::endl;
                idx += 1;
            }
        }
    }

    return 0;
}
