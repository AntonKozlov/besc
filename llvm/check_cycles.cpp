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


// create graph of Module
class GraphCreator : public InstVisitor<GraphCreator> {

private:
    Graph graph;
    map<BasicBlock *, Vertex> blockIdx;
    unsigned amtBlocks;
    inline static vector<Vertex> empty_vector = {};

public:
    GraphCreator() : amtBlocks(0) {}

    Graph create(Module& M) {
        visit(M);
        return graph;
    }

    map<BasicBlock *, Vertex> getBlockIdx() {return blockIdx;}

    void visitBranchInst(BranchInst& BI) {
        for (unsigned i = 0; i < BI.getNumSuccessors(); i++) {
            BasicBlock *from = BI.getParent(), *to = BI.getSuccessor(i);
            for (BasicBlock *bb : {from, to}) {
                if (blockIdx.find(bb) == blockIdx.end()) {
                    blockIdx[bb] = amtBlocks;
                    amtBlocks++;
                    graph.push_back(empty_vector);
                }
            }
            graph[blockIdx[from]].push_back(blockIdx[to]);
        }
    }
};


// find tracepoints in Module
class TracePointFinder : public InstVisitor<TracePointFinder> {

private:
    map<TracePoint, BasicBlock *> tracepoints;
    inline static string name_fun_tp = "besc_tracepoint";

    template<class T1, class T2, class T3>
    map<T1, T3> mapUnion(map<T1, T2>& map_1, map<T2, T3>& map_2) {
        map<T1, T3> res_map;
        for (auto [key_1, key_2] : map_1) {
            if (map_2.find(key_2) != map_2.end()) {
                res_map[key_1] = map_2[key_2];
            }
        }
        return res_map;
    }

public:
    TracePointFinder() {}

    map<TracePoint, Vertex> find(Module& M, map<BasicBlock *, Vertex>& blockIdx) {
        visit(M);
        return mapUnion(tracepoints, blockIdx);
    }

    string getTracepointName(CallInst& CI) {
        string argument = cast<ConstantDataArray>(
                cast<GlobalVariable>(
                    cast<ConstantExpr>(
                        CI.getArgOperand(0)
                    )->getOperand(0)
                )->getInitializer()
            )->getAsString()
            .str();
        return argument.substr(0, argument.size() - 1); // remove trailing '\00'
    }

    void visitCallInst(CallInst& CI) {
        BasicBlock *curBlock = CI.getParent();
        string name_fun = CI.getCalledFunction()->getName().str();
        if (name_fun == name_fun_tp) {
            TracePoint tp = getTracepointName(CI);
            cout << tp << endl;
            tracepoints[tp] = curBlock;
        }
    }
};

// find loops in graph
class LoopsFinder {

private:
    enum class VertexStatus {
        NotVisited,
        Visiting,
        Visited
    };
    Graph graph;
    unsigned N;
    vector<VertexStatus> status;
    unsigned time;
    vector<unsigned> timein;
    vector<Vertex> up;

public:
    LoopsFinder(Graph& graph_) {
        graph = graph_;
        N = graph.size();
        status.assign(N, VertexStatus::NotVisited);
        time = 0;
        timein.resize(N);
        up.resize(N);
    }

    vector<bool> find() {
        dfs(0); // TODO, while I suggest that 0 is start block of main()
        vector<bool> in_loop(N);
        for (Vertex v = 0; v < N; v++)
            in_loop[v] = (up[v] <= timein[v]);
        return in_loop;
    }

private:
    void dfs(Vertex v) {
        timein[v] = ++time;
        up[v] = timein[v] + 1;
        status[v] = VertexStatus::Visiting;
        for (Vertex to : graph[v]) {
            if (status[to] == VertexStatus::Visiting) {
                up[v] = min(up[v], timein[to]);
            }
            else if (status[to] == VertexStatus::NotVisited) {
                dfs(to);
                up[v] = min(up[v], up[to]);
            }
        }
        status[v] = VertexStatus::Visited;
    }
};


// find path between start_tp and final_tp
class PathFinder {

private:
    Graph graph;
    unsigned N;
    map<TracePoint, Vertex> labels;
    vector<bool> used;

public:
    PathFinder(Graph& graph_, map<TracePoint, Vertex>& labels_) {
        graph = graph_;
        N = graph.size();
        labels = labels_;
    }

    bool find(TracePoint start_tp, TracePoint final_tp) {
        used.assign(N, false);
        return dfs(labels[start_tp], labels[final_tp]);
    }

private:
    bool dfs(Vertex v, Vertex final_v) {
        used[v] = true;
        if (v == final_v)
            return true;
        for (Vertex to : graph[v]) {
            if (used[to]) {}
            else {
                if (dfs(to, final_v)) return true;
            }
        }
        return false;
    }
};


// find loop in path between start_tp and final_tp
class LoopInPathFinder {

private:
    Graph graph;
    unsigned N;
    map<TracePoint, Vertex> labels;
    vector<bool> in_loop;
    vector<bool> used;

public:
    LoopInPathFinder(Graph& graph_, map<TracePoint, Vertex>& labels_, vector<bool>& in_loop_) {
        graph = graph_;
        N = graph.size();
        labels = labels_;
        in_loop = in_loop_;
    }

    bool find(TracePoint start_tp, TracePoint final_tp) {
        used.assign(N, false);
        return dfs(labels[start_tp], labels[final_tp]);
    }

private:
    bool dfs(Vertex v, Vertex final_v) {
        used[v] = true;
        if (in_loop[v])
            return true;
        if (v == final_v)
            return false;
        for (Vertex to : graph[v]) {
            if (used[to]) {}
            else {
                if (dfs(to, final_v)) return true;
            }
        }
        return false;
    }
};


// find path from start_tp which doesn't reach final_tp
class NotPathFinder {

private:
    Graph graph;
    unsigned N;
    map<TracePoint, Vertex> labels;
    vector<bool> used;

public:
    NotPathFinder(Graph& graph_, map<TracePoint, Vertex>& labels_) {
        graph = graph_;
        N = graph.size();
        labels = labels_;
    }

    bool find(TracePoint start_tp, TracePoint final_tp) {
        used.assign(N, false);
        return dfs(labels[start_tp], labels[final_tp]);
    }

private:
    bool dfs(Vertex v, Vertex final_v) {
        used[v] = true;
        if (v == final_v)
            return false;
        if (graph[v].empty())
            return true;
        for (Vertex to : graph[v]) {
            if (used[to]) {}
            else {
                if (dfs(to, final_v)) return true;
            }
        }
        return false;
    }
};


// status of trace searching
enum class SearchingState {
    Success,
    StartTPNotFound, // can't find function "{name_fun_tp}{start_tp}"
    FinalTPNotFound, // can't find function "{name_fun_tp}{final_tp}"
    CantReach, // there isn't path from start_tp to final_tp
    LoopFound, // there is loop in path between start_tp and final_tp
    MaybeCantReach, // there is path from start_tp, but doesn't reach final_tp
};

// pretty print of SearchingState
ostream& operator<<(ostream& out, const SearchingState state){
    string str;
    switch(state) {
        case SearchingState::Success:
            str = "OK"; break;
        case SearchingState::StartTPNotFound:
            str = "Tracepoint start tracepoint was not found"; break;
        case SearchingState::FinalTPNotFound:
            str = "Tracepoint final tracepoint was not found"; break;
        case SearchingState::CantReach:
            str = "There isn't path between start tracepoint and final tracepoint"; break;
        case SearchingState::LoopFound:
            str = "There is loop in trace between start tracepoint and final tracepoint"; break;
        case SearchingState::MaybeCantReach:
            str = "There is path from start tracepoint, but doesn't reach final tracepoint"; break;
    }
    return out << str;
}

// main function of searching loop in trace between start_tp and final_tp
SearchingState main_(Module& M, TracePoint start_tp, TracePoint final_tp) {
    auto GC = GraphCreator();
    auto graph = GC.create(M);
    auto blockIdx = GC.getBlockIdx();
    auto labels = TracePointFinder().find(M, blockIdx);
    auto in_loop = LoopsFinder(graph).find();
    if (labels.find(start_tp) == labels.end())
        return SearchingState::StartTPNotFound;
    if (labels.find(final_tp) == labels.end())
        return SearchingState::FinalTPNotFound;
    if ( ! PathFinder(graph, labels).find(start_tp, final_tp))
        return SearchingState::CantReach;
    if (LoopInPathFinder(graph, labels, in_loop).find(start_tp, final_tp))
        return SearchingState::LoopFound;
    if (NotPathFinder(graph, labels).find(start_tp, final_tp))
        return SearchingState::MaybeCantReach;
    return SearchingState::Success;
}


int main(int argc, char **argv) {
    if (argc != 4) {
        cerr << "Usage: " << argv[0] << " <IR file> <Start tracepoint> <Final tracepoint>\n";
        return 1;
    }

    // Define start and final tracepoints
    auto start_tp = TracePoint(argv[2]);
    auto final_tp = TracePoint(argv[3]);

    // Parse the input LLVM IR file into a module.
    SMDiagnostic Err;
    LLVMContext Context;
    unique_ptr <Module> Mod(parseIRFile(argv[1], Err, Context));
    if (!Mod) {
        Err.print(argv[0], errs());
        return 1;
    }

    // Run searching of loop in trace
    SearchingState ret = main_(*Mod, start_tp, final_tp);

    cout << ret << endl;;
    return static_cast<int>(ret);
}
