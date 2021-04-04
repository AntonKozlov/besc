#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/IR/DerivedTypes.h"

#include <map>
#include <iostream>
#include <vector>
#include <string>

using namespace llvm;
using namespace std;


struct BESCVisitor : public InstVisitor<BESCVisitor> {

    Module *M;
    int index = 0;
    string prefix = ".tp.str.";

    BESCVisitor(Module &M) {
        this->M = &M;
    };

    GlobalVariable* initGlobalVariable(LLVMContext& context, const StringRef& func_tp_name) {
        return new GlobalVariable(
            *this->M, 
            ArrayType::get(Type::getInt8Ty(context), func_tp_name.size() + 1), 
            true, 
            GlobalValue::PrivateLinkage, 
            ConstantDataArray::getString(
                context, 
                func_tp_name, 
                true
            ), 
            this->prefix + to_string(this->index++)
        );
    }

    void visitFunction(Function &F) {
        if (F.getName().str() != "besc_tracepoint" && !F.empty() && this->M->getGlobalVariable(this->prefix + to_string(this->index), true) == NULL) {
            Instruction &firstInst = F.getEntryBlock().front();
            LLVMContext &context = F.getEntryBlock().getContext();
            Instruction &lastBlockInst = F.getBasicBlockList().back().back();

            string func_name = F.getName().str();
            string func_entry = func_name + "_entry";
            string func_exit = func_name + "_exit";

            Value* offset = ConstantInt::get(Type::getInt64Ty(context), 0);

            Type *ret_type = Type::getVoidTy(context);
            Type *arg_type = Type::getInt8PtrTy(context);
            FunctionType *func_type = FunctionType::get(ret_type, {arg_type}, false);

            Type* arg_entry_type = ArrayType::get(Type::getInt8Ty(context), func_entry.size() + 1);
            Type* arg_exit_type = ArrayType::get(Type::getInt8Ty(context), func_exit.size() + 1);

            FunctionCallee besc_tp = this->M->getOrInsertFunction("besc_tracepoint", func_type);

            Value* arg_ptr_entry = ConstantExpr::getInBoundsGetElementPtr(arg_entry_type, this->initGlobalVariable(context, func_entry), {offset, offset});
            this->M->getOrInsertGlobal(this->prefix + to_string(this->index - 1), arg_entry_type);
            CallInst::Create(besc_tp, ArrayRef<Value *>({arg_ptr_entry}), Twine(""), &firstInst);

            Value* arg_ptr_exit = ConstantExpr::getInBoundsGetElementPtr(arg_exit_type, this->initGlobalVariable(context, func_exit), {offset, offset});
            this->M->getOrInsertGlobal(this->prefix + to_string(this->index - 1), arg_exit_type);
            CallInst::Create(besc_tp, ArrayRef<Value *>({arg_ptr_exit}), Twine(""), &lastBlockInst);
        }
    }
};

int main(int argc, char **argv) {
    if (argc < 2 || 3 < argc) {
        cerr << "Usage: " << argv[0] << " <input IR file> [<output file>]\n";
        return 1;
    }

    SMDiagnostic Err;
    LLVMContext Context;
    unique_ptr <Module> Mod(parseIRFile(argv[1], Err, Context));
    if (!Mod) {
        Err.print(argv[0], errs());
        return 1;
    }

    BESCVisitor visitor(*Mod);
    visitor.visit(*Mod);

    std::error_code EC;
    raw_ostream *out = new raw_fd_ostream(argv[argc - 1], EC, sys::fs::OpenFlags());
    Mod->print(*out, nullptr);

    return 0;
}
