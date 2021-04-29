#include "llvm/IR/BasicBlock.h"

#include "types.h"

#include <map>

void printGraph(Graph &graph, std::map<Vertex, Vertex> &calledFun);

bool compareVertexLists(
    std::vector<Vertex> VertexList1,
    std::vector<Vertex> VertexList2);

bool compareBlocks(const llvm::BasicBlock *BBL,
                   const llvm::BasicBlock *BBR);
