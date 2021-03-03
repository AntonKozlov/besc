#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"
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
    states[start] = VertexState::Visited;
}

struct BESCVisitor : public InstVisitor<BESCVisitor> {
    BESCVisitor() {};

    void visitBranchInst(BranchInst &BI) {
        for (unsigned i = 0; i < BI.getNumSuccessors(); i++) {
            BasicBlock *from = BI.getParent(), *to = BI.getSuccessor(i);

            errs() << from << " -branch-> " << to << "\n";

            if (graph.find(from) == graph.end()) {
                vector < BasicBlock * > adj = {to};
                graph.insert(make_pair(from, adj));
            } else {
                graph[from].push_back(to);
            }
        }
    }

    void visitCallInst(CallInst &CI) {
        BasicBlock *from = CI.getParent();
        BasicBlock *to = &CI.getCalledFunction()->getEntryBlock();

        errs() << from << " --call--> " << to << "\n";

        if (graph.find(from) == graph.end()) {
            vector < BasicBlock * > adj = {to};
            graph.insert(make_pair(from, adj));
        } else {
            graph[from].push_back(to);
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

    // Visit all the branch instances and build an oriented graph
    BESCVisitor visitor;
    visitor.visit(*Mod);

    // Prepare states of vertices (colors)
    for (auto const&[vertex, _] : graph) {
        states[vertex] = VertexState::NotVisited;
    }

    // Launch DFS to find a cycle
    for (auto const&[vertex, _] : graph) {
        if (states[vertex] == VertexState::NotVisited) {
            dfs(vertex);
            if (cycle_found)
                break;
        }
    }

    if (cycle_found) {
        cout << "Found branch cycle.\n" << endl;
    } else {
        cout << "Branch cycles were not found.\n" << endl;
    }

    return 0;
}
