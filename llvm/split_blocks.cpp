#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/BasicBlock.h"

#include <iostream>
#include <vector>
#include <map>

using namespace llvm;
using namespace std;


// split blocks by calling functions
class BlocksSplitter : public InstVisitor<BlocksSplitter> {

public:
    BlocksSplitter() {}

    void split(Module& M) {
        visit(M);
    }

    void visitBasicBlock(BasicBlock& BB) {
        auto I = BB.begin();
        ++I; // we mustn't do anything with the first instruction
        for (; I != BB.end(); I++) {
            if (isa<CallInst>(*I)) {
                visitBasicBlock(*BB.splitBasicBlock(I));
                return;
            }
        }
    }
};

/*int main(int argc, char **argv) {
    if (argc < 2 || 3 < argc) {
        cerr << "Usage: " << argv[0] << " <input IR file> [<output file>]\n";
        return 1;
    }

    // Parse the input LLVM IR file into a module.
    SMDiagnostic Err;
    LLVMContext Context;
    unique_ptr <Module> Mod(parseIRFile(argv[1], Err, Context));
    if (!Mod) {
        Err.print(argv[0], errs());
        return 1;
    }

    auto BS = BlocksSplitter();
    BS.split(*Mod);

    std::error_code EC;
    raw_ostream *out = new raw_fd_ostream(argv[argc - 1], EC, sys::fs::OpenFlags());
    Mod->print(*out, nullptr);

    return 0;
}*/
