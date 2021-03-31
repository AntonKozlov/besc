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
typedef unsigned Vertex;
typedef vector<vector<Vertex>> Graph;

// status of trace searching
class SearchingState
{
public:
    bool StartTPNotFound;    // can't find function "{name_fun_tp}{start_tp}"
    bool FinalTPNotFound;    // can't find function "{name_fun_tp}{final_tp}"
    bool FinalTPUnreachable; // there isn't a path from start_tp to final_tp
    bool LoopFound;          // there is loop in path between start_tp and final_tp
    bool FinalTPAvoidable;   // there is path from start_tp, but doesn't reach final_tp

    SearchingState() : StartTPNotFound(false),
                       FinalTPNotFound(false),
                       FinalTPUnreachable(false),
                       LoopFound(false),
                       FinalTPAvoidable(false) {}

    int to_int()
    {
        return StartTPNotFound * 16 +
               FinalTPNotFound * 8 +
               FinalTPUnreachable * 4 +
               LoopFound * 2 +
               FinalTPAvoidable;
    }
};

template <class T1, class T2, class T3>
map<T1, T3> mapUnion(map<T1, T2> &map_1, map<T2, T3> &map_2)
{
    map<T1, T3> res_map;
    for (auto [key_1, key_2] : map_1)
    {
        if (map_2.find(key_2) != map_2.end())
        {
            res_map[key_1] = map_2[key_2];
        }
    }
    return res_map;
}

// create graph of Module
class GraphCreator : public InstVisitor<GraphCreator>
{

private:
    Graph graph;
    map<BasicBlock *, Vertex> blockIdx;
    unsigned amtBlocks;

public:
    GraphCreator() : amtBlocks(0) {}

    Graph create(Module &M)
    {
        visit(M);
        return graph;
    }

    map<BasicBlock *, Vertex> getBlockIdx() { return blockIdx; }

    void visitBranchInst(BranchInst &BI)
    {
        BasicBlock *from = BI.getParent();
        for (BasicBlock *to : BI.successors())
        {
            for (BasicBlock *bb : {from, to})
            {
                // if bb is not found in blockIdx
                if (blockIdx.find(bb) == blockIdx.end())
                {
                    blockIdx[bb] = amtBlocks;
                    amtBlocks++;
                    graph.push_back({});
                }
            }
            graph[blockIdx[from]].push_back(blockIdx[to]);
        }
    }
};

// find tracepoints in Module
class TracePointFinder : public InstVisitor<TracePointFinder>
{

private:
    map<TracePoint, BasicBlock *> tracepoints;
    inline static string tp_prefix = "besc_tracepoint_";

public:
    TracePointFinder() {}

    map<TracePoint, Vertex> find(Module &M, map<BasicBlock *, Vertex> &blockIdx)
    {
        visit(M);
        return mapUnion(tracepoints, blockIdx);
    }

    void visitCallInst(CallInst &CI)
    {
        BasicBlock *curBlock = CI.getParent();
        string name_fun = CI.getCalledFunction()->getName().str();
        if (name_fun.substr(0, tp_prefix.length()) == tp_prefix)
        {
            TracePoint tp = name_fun.substr(tp_prefix.length());
            tracepoints[tp] = curBlock;
        }
    }
};

// TODO: add priority output
// pretty print of SearchingState
ostream &operator<<(ostream &out, const SearchingState state)
{
    string str = "";
    str += "Start tracepoint was not found : " + (string)(state.StartTPNotFound ? "true" : "false") + "\n";
    str += "Final tracepoint was not found : " + (string)(state.FinalTPNotFound ? "true" : "false") + "\n";
    str += "There is no path between start tracepoint and final tracepoint : " + (string)(state.FinalTPUnreachable ? "true" : "false") + "\n";
    str += "There is a loop in trace between start tracepoint and final tracepoint : " + (string)(state.LoopFound ? "true" : "false") + "\n";
    str += "There is a path from start tracepoint, that doesn't reach final tracepoint : " + (string)(state.FinalTPAvoidable ? "true" : "false") + "\n";
    return out << str;
}

// find loops in graph
class LoopsFinder
{

private:
    enum Color
    {
        White,
        Grey,
        Black,
    };

    struct DfsStatus
    {
        bool reached_final_tp = false;
        bool loop_found = false;
        Color color = White;
    };
    Graph graph;
    vector<DfsStatus> status;
    vector<Vertex> dfs_stack;
    map<TracePoint, Vertex> labels;

public:
    LoopsFinder(Graph &graph_, map<TracePoint, Vertex> &labels_)
    {
        graph = graph_;
        labels = labels_;
        status.assign(graph.size(), DfsStatus());
    }

    pair<bool, bool> find(TracePoint start_tp, TracePoint final_tp)
    {
        dfs(labels[start_tp], labels[final_tp]);
        return {status[labels[start_tp]].loop_found,
                status[labels[start_tp]].reached_final_tp};
    }

private:
    void dfs(Vertex v, Vertex final_v)
    {
        if (v == final_v)
        {
            status[v].reached_final_tp = true;
            status[v].color = Black;
            return;
        }

        status[v].color = Grey;
        dfs_stack.push_back(v);
        for (auto to : graph[v])
        {
            if (status[to].color == White)
            {
                dfs(to, final_v);
            }

            if (status[to].color == Grey)
            {
                for (auto w = dfs_stack.rbegin(); *w != to; w++)
                {
                    status[*w].loop_found = true;
                }
                status[to].loop_found = true;
            }

            if (status[to].color == Black)
            {
                if (status[to].reached_final_tp)
                {
                    status[v].loop_found |= status[to].loop_found;
                    status[v].reached_final_tp = true;
                }
            }
        }
        dfs_stack.pop_back();
        status[v].color = Black;
    }
};

// find path from start_tp which doesn't reach final_tp
class FinalTPAvoidableChecker
{

private:
    Graph graph;
    unsigned N;
    map<TracePoint, Vertex> labels;
    vector<bool> used;

public:
    FinalTPAvoidableChecker(Graph &graph_, map<TracePoint, Vertex> &labels_)
    {
        graph = graph_;
        N = graph.size();
        labels = labels_;
    }

    bool check(TracePoint start_tp, TracePoint final_tp)
    {
        used.assign(N, false);
        return dfs(labels[start_tp], labels[final_tp]);
    }

private:
    bool dfs(Vertex v, Vertex final_v)
    {
        used[v] = true;
        if (v == final_v)
            return false;
        if (graph[v].empty())
            return true;
        for (Vertex to : graph[v])
        {
            if (!used[to] and dfs(to, final_v))
            {
                return true;
            }
        }
        return false;
    }
};

// main function of searching loop in trace between start_tp and final_tp
SearchingState *runSearch(Module &M, TracePoint start_tp, TracePoint final_tp)
{
    SearchingState *state = new SearchingState();
    auto GC = GraphCreator();
    Graph graph = GC.create(M);

    auto blockIdx = GC.getBlockIdx();
    auto labels = TracePointFinder().find(M, blockIdx);

    state->StartTPNotFound = labels.find(start_tp) == labels.end();
    state->FinalTPNotFound = labels.find(final_tp) == labels.end();

    // LoopsFinder still has to collect info about final tp reachability,
    // so we reuse it as a side effect.
    auto result = LoopsFinder(graph, labels).find(start_tp, final_tp);
    state->LoopFound = result.first;
    state->FinalTPUnreachable = !result.second;

    state->FinalTPAvoidable = FinalTPAvoidableChecker(graph, labels).check(start_tp, final_tp);
    return state;
}

int main(int argc, char **argv)
{
    if (argc != 4)
    {
        cerr << "Usage: " << argv[0] << " <IR file> <Start tracepoint> <Final tracepoint>\n";
        return 1;
    }

    // Define start and final tracepoints
    TracePoint start_tp = TracePoint(argv[2]);
    TracePoint final_tp = TracePoint(argv[3]);

    // Parse the input LLVM IR file into a module.
    SMDiagnostic Err;
    LLVMContext Context;
    unique_ptr<Module> Mod(parseIRFile(argv[1], Err, Context));
    if (!Mod)
    {
        Err.print(argv[0], errs());
        return 1;
    }

    // Run searching of loop in trace
    SearchingState *ret = runSearch(*Mod, start_tp, final_tp);
    cout << (*ret) << endl;
    return ret->to_int();
}
