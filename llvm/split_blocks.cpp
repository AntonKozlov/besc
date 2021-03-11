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

typedef string TracePoint;


class SimpleVisitor : public InstVisitor<SimpleVisitor> {

public:
    void visitBasicBlock(BasicBlock &bb) {
        for (auto i = bb.begin(); i != bb.end();) {
            Instruction *Inst = &*i++;
            bb.printAsOperand(errs(), false); 
            cout << " " << Inst->getOpcodeName() << endl;
        }
    }
};


class SplittingVisitor : public InstVisitor<SplittingVisitor> {

public:
    void visitBasicBlock(BasicBlock &bb) {
        for (auto i = bb.begin(); i != bb.end();) {
            Instruction *Inst = &*i++;
            bb.splitBasicBlock(i);
            break;
            bb.printAsOperand(errs(), false); 
            cout << " " << Inst->getOpcodeName() << endl;
        }
    }
};


int main_(Module& M) {
    auto SV = SimpleVisitor();
    auto SpV = SplittingVisitor();
    SV.visit(M);
    cout << endl;
    SpV.visit(M);
    cout << endl;
    SV.visit(M);
    return 0;
}


int main(int argc, char **argv) {
    // if (argc != 4) {
    //     cerr << "Usage: " << argv[0] << " <IR file> <Start tracepoint> <Final tracepoint>\n";
    //     return 1;
    // }

    // Parse the input LLVM IR file into a module.
    SMDiagnostic Err;
    LLVMContext Context;
    unique_ptr <Module> Mod(parseIRFile(argv[1], Err, Context));
    if (!Mod) {
        Err.print(argv[0], errs());
        return 1;
    }
    main_(*Mod);

    // dump module
    // const char *Path = "simple.s"; 
    // int ans = LLVMWriteBitcodeToFile(Mod, Path);   
    return 0;
}
