#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/BasicBlock.h"

#include <map>
#include <iostream>
#include <vector>

using namespace llvm;
using namespace std;


enum class VertexState {
    Visited, Visiting, NotVisited
};

map<BasicBlock *, VertexState> states;
map<BasicBlock *, vector < BasicBlock * >>
graph;

bool cycle_found = false;

void dfs(BasicBlock *start) {
    states[start] = VertexState::Visiting;
    for (auto to : graph[start]) {
        if (states[to] == VertexState::Visiting) {
            cycle_found = true;
        } else if (states[to] == VertexState::NotVisited) {
            dfs(to);
        }
    }
}

struct BranchInstVisitor : public InstVisitor<BranchInstVisitor> {
    unsigned count;

    BranchInstVisitor() : count(0) {}

    void visitBranchInst(BranchInst &BI) {
        count++;
        cerr << "BranchInst found: " << count << "\n";
        for (unsigned i = 0; i < BI.getNumSuccessors(); i++) {
            BasicBlock *from = BI.getParent(), *to = BI.getSuccessor(i);
            cerr << from << " -> " << to << endl;
            if (graph.find(from) == graph.end()) {
                vector < BasicBlock * > adj = {to};
                graph.insert(make_pair(from, adj));
                states[from] = VertexState::NotVisited;
            } else {
                graph[from].push_back(to);
            }
        }
    }
};

int main(int argc, char **argv) {
    if (argc < 2) {
        cerr << "Usage: " << argv[0] << " <IR file>\n";
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

    // Visit all the branch instructions and build an oriented graph
    BranchInstVisitor BIV;
    BIV.visit(*Mod);

    // Launch DFS to find a cycle
    for (auto const&[v, _] : graph) {
        if (states[v] == VertexState::NotVisited) {
            dfs(v);
        }
    }

    if (cycle_found) {
        cout << "Found cycles.\n" << endl;
    } else {
        cout << "Cycles were not found.\n" << endl;
    }

    return 0;
}
