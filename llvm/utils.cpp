#include "llvm/IR/BasicBlock.h"

#include "types.h"

#include <iostream>

bool compareVertexLists(
    std::vector<Vertex> VertexList1,
    std::vector<Vertex> VertexList2)
{
    if (VertexList1.size() != VertexList2.size())
    {
        return false;
    }

    auto VertexList1Doubled = VertexList1;
    auto old_count = VertexList1Doubled.size();
    for (int i = 0; i < old_count; i++)
    {
        VertexList1Doubled.push_back(VertexList1Doubled[i]);
    }

    int i;
    for (i = 0; i < VertexList1Doubled.size(); i++)
    {
        if (VertexList1Doubled[i] == VertexList2[0])
        {
            break;
        }
    }
    if (i == VertexList1Doubled.size())
    {
        return false;
    }
    else
    {
        if (VertexList1Doubled.size() - i < VertexList2.size())
            return false;

        return std::equal(
            VertexList2.begin(),
            VertexList2.end(),
            VertexList1Doubled.begin() + i);
    }
}

// Left it here just in case
bool compareBlocks(const llvm::BasicBlock *BBL,
                   const llvm::BasicBlock *BBR)
{
    if (BBL->getName().str() != BBR->getName().str())
    {
        return false;
    }

    llvm::BasicBlock::const_iterator it_l = BBL->begin();
    llvm::BasicBlock::const_iterator it_r = BBR->begin();

    while ((it_l != BBL->end()) && (it_r != BBR->end()))
    {
        // std::cout << "enter body" << std::endl;

        const llvm::Instruction *I_l = &*it_l;
        const llvm::Instruction *I_r = &*it_r;

        if (!I_l->isIdenticalTo(I_r))
        {
            return false;
        }

        ++it_l;
        ++it_r;
    }

    return true;
}

// Way to access FunctionComparator, just in case

// #include "llvm/Transforms/Utils/FunctionComparator.h"
// #include "llvm/ADT/APFloat.h"
// #include "llvm/ADT/APInt.h"
// #include "llvm/ADT/ArrayRef.h"
// #include "llvm/ADT/Hashing.h"
// #include "llvm/ADT/SmallPtrSet.h"
// #include "llvm/ADT/SmallVector.h"
// #include "llvm/IR/Attributes.h"

// #include "llvm/IR/Constant.h"
// #include "llvm/IR/Constants.h"
// #include "llvm/IR/DataLayout.h"
// #include "llvm/IR/DerivedTypes.h"
// #include "llvm/IR/Function.h"
// #include "llvm/IR/GlobalValue.h"
// #include "llvm/IR/InlineAsm.h"
// #include "llvm/IR/InstrTypes.h"
// #include "llvm/IR/Instruction.h"
// #include "llvm/IR/Instructions.h"
// #include "llvm/IR/LLVMContext.h"
// #include "llvm/IR/Metadata.h"
// #include "llvm/IR/Module.h"
// #include "llvm/IR/Operator.h"
// #include "llvm/IR/Type.h"
// #include "llvm/IR/Value.h"
// #include "llvm/Support/Casting.h"
// #include "llvm/Support/Compiler.h"
// #include "llvm/Support/Debug.h"
// #include "llvm/Support/ErrorHandling.h"
// #include "llvm/Support/raw_ostream.h"

// #include "llvm/IR/LLVMContext.h"

// llvm::LLVMContext &getGlobalContext() {
//     static llvm::LLVMContext context;
//     return context;
// }

// llvm::GlobalNumberState *getGlobalNumberState() {
//     static llvm::GlobalNumberState gns;
//     return &gns;
// }

// MyComparator(): FunctionComparator(
//     llvm::Function::Create(
//         llvm::FunctionType::get(llvm::Type::getVoidTy(getGlobalContext()), llvm::ArrayRef< llvm::Type * >(), false),
//         llvm::GlobalValue::LinkageTypes::ExternalLinkage,
//         0
//     ),
//     llvm::Function::Create(
//         llvm::FunctionType::get(llvm::Type::getVoidTy(getGlobalContext()), llvm::ArrayRef< llvm::Type * >(), false),
//         llvm::GlobalValue::LinkageTypes::ExternalLinkage,
//         0
//     ),
//     getGlobalNumberState()
// ){}
