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

string name_fun_tp = "besc_tracepoint_";
int name_fun_tp_len = name_fun_tp.length();

enum class SearchingState {
    StartTPNotFound,
    FinalTPNotFound,
    CantReach,
    LoopFound,
    MaybeCantReach,
    Success
};

struct DfsStatus {
    bool reached_final_tp = false;
    bool always_reached_final_tp = true;
    bool loop_found = false;
    bool visited = false;
    bool not_visited = true;
};

TracePoint start_tp, final_tp;
BasicBlock *start_bb, *final_bb;
map<BasicBlock *, vector < BasicBlock * >> graph;
map<TracePoint, BasicBlock * > block_with_tp;
map<BasicBlock *, DfsStatus> status;

ostream& operator<<(ostream& out, const SearchingState state){
    string str;
    switch(state) {
        case SearchingState::StartTPNotFound:
            str = "Tracepoint \"" + start_tp + "\" was not found"; break;
        case SearchingState::FinalTPNotFound:
            str = "Tracepoint \"" + final_tp + "\" was not found"; break;
        case SearchingState::CantReach:
            str = "There isn't trace between tracepoint \"" + start_tp + "\" and tracepoint \"" + final_tp + "\""; break;
        case SearchingState::LoopFound:
            str = "There is loop in trace between tracepoint \"" + start_tp + "\" and tracepoint \"" + final_tp + "\""; break;
        case SearchingState::MaybeCantReach:
            str = "There is trace which starts from tracepoint \"" + start_tp + "\", but doesn't go through tracepoint \"" + final_tp + "\""; break;
        case SearchingState::Success:
            str = "OK"; break;
    }
    return out << str;
}

void dfs(BasicBlock *bb) {
    if (bb == final_bb)
        return;
    status[bb].not_visited = false;
    for (auto to : graph[bb]) {
        if (status[to].not_visited) {
            dfs(to);
        } else if ( ! status[to].visited) {
            status[bb].loop_found = true;
        }
        if (status[to].visited) {
            if (status[to].reached_final_tp) {
                status[bb].loop_found |= status[to].loop_found;
                status[bb].reached_final_tp = true;
                status[bb].always_reached_final_tp &= status[to].always_reached_final_tp;
            } else {
                status[bb].always_reached_final_tp = false;
            }
        }
    }
    status[bb].visited = true;
}

SearchingState findLoopInTrace() {
    if (block_with_tp.find(start_tp) == block_with_tp.end())
        return SearchingState::StartTPNotFound;
    start_bb = block_with_tp[start_tp];

    if (block_with_tp.find(final_tp) == block_with_tp.end())
        return SearchingState::FinalTPNotFound;
    final_bb = block_with_tp[final_tp];
    
    for (auto [block, _] : graph)
        status[block] = DfsStatus();
    
    status[final_bb].reached_final_tp = true;

    dfs(start_bb);
    
    if ( ! status[start_bb].reached_final_tp)
        return SearchingState::CantReach;
    if (status[start_bb].loop_found)
        return SearchingState::LoopFound;
    if ( ! status[start_bb].always_reached_final_tp)
        return SearchingState::MaybeCantReach;
    return SearchingState::Success;
}

struct BranchInstVisitor : public InstVisitor<BranchInstVisitor> {
    unsigned count;

    BranchInstVisitor() : count(0) {}

    void visitBranchInst(BranchInst &BI) {
        count++;
        cout << "BranchInst found: " << count << "\n";
        for (unsigned i = 0; i < BI.getNumSuccessors(); i++) {
            BasicBlock *from = BI.getParent(), *to = BI.getSuccessor(i);
            cout << from << " -> " << to << endl;
            if (graph.find(from) == graph.end()) {
                vector < BasicBlock * > adj = {to};
                graph.insert(make_pair(from, adj));
            } else {
                graph[from].push_back(to);
            }
            if (graph.find(to) == graph.end()) {
                vector < BasicBlock * > adj = {};
                graph.insert(make_pair(to, adj));
            }
        }
    }

    void visitCallInst(CallInst &CI) {
        BasicBlock *curBlock = CI.getParent();
        string name_fun = CI.getCalledFunction()->getName().str();
        if (name_fun.substr(0, name_fun_tp_len) == name_fun_tp) {
            TracePoint tp = name_fun.substr(name_fun_tp_len);
            block_with_tp[tp] = curBlock;
            cout << "Tracepoint found: \"" << tp << "\" in " << curBlock << endl;
        }
    }
};

int main(int argc, char **argv) {
    if (argc != 4) {
        cerr << "Usage: " << argv[0] << " <IR file> <Start tracepoint> <Final tracepoint>\n";
        return 1;
    }

    // Define start and final tracepoints
    start_tp = TracePoint(argv[2]);
    final_tp = TracePoint(argv[3]);

    // Parse the input LLVM IR file into a module.
    SMDiagnostic Err;
    LLVMContext Context;
    unique_ptr <Module> Mod(parseIRFile(argv[1], Err, Context));
    if (!Mod) {
        Err.print(argv[0], errs());
        return 1;
    }

    // Visit all the branch instances and build an oriented graph
    BranchInstVisitor BIV;
    BIV.visit(*Mod);

    // Run searching of loop in trace
    cout << findLoopInTrace() << endl;

    return 0;
}
