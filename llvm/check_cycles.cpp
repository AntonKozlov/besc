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
typedef unsigned int Vertex;
typedef vector<vector<Vertex>> Graph;
typedef unsigned int Index;
typedef Index Size;
typedef string FunName;

// status of trace searching
class SearchingState
{
public:
    bool StartTPNotFound;    // can't find function "{tp_prefix}{start_tp}"
    bool FinalTPNotFound;    // can't find function "{tp_prefix}{final_tp}"
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
map<T1, T3> mapUnion(map<T1, T2>& map_1, map<T2, T3>& map_2)
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

template <class T1, class T2, class T3>
map<T2, T3> mapApply(map<T1, T2>& map_1, map<T1, T3>& map_2)
{
    map<T2, T3> res_map;
    for (auto [key, value] : map_2)
    {
        if (map_1.find(key) != map_1.end())
        {
            res_map[map_1[key]] = value;
        }
    }
    return res_map;
}

template <class T1>
vector<T1 *> mapToVector(map<Index, T1>& map_, Size size)
{
    auto res_vec = vector<T1 *>(size, nullptr);
    for (auto [key, value] : map_)
        res_vec[key] = &value;
    return res_vec;
}

// create graph of Module
class GraphCreator : public InstVisitor<GraphCreator>
{

private:
    Graph graph;
    map<BasicBlock *, Vertex> blockIdx;
    map<BasicBlock *, FunName> calledFun;
    unsigned int amtBlocks = 0;

public:
    GraphCreator(Module &M) { visit(M); }

    Graph getGraph() { return graph; }

    map<BasicBlock *, Vertex> getBlockIdx() { return blockIdx; }

    vector<FunName *> getCalledFun()
    {
        auto calledFun_ = mapApply(blockIdx, calledFun);
        return mapToVector(calledFun_, amtBlocks);
    }

    void visitBasicBlock(BasicBlock& BB_)
    {
        auto *BB = &BB_;
        addVertex(BB);
        for (auto I = BB->begin(); I != BB->end(); I++)
        {
            if (auto *BI = dyn_cast<BranchInst>(I))
            {
                for (BasicBlock *nextBB : BI->successors())
                {
                    addVertex(nextBB);
                    addEdge(BB, nextBB);
                }
            }
            else if (auto *CI = dyn_cast<CallInst>(I))
            {
                calledFun[BB] = FunName(CI->getCalledFunction()->getName().str());
            }
        }
    }

private:
    void addVertex(BasicBlock *BB)
    {
        if (blockIdx.find(BB) == blockIdx.end())
        {
            blockIdx[BB] = amtBlocks++;
            graph.push_back({});
        }
    }

    void addEdge(BasicBlock *fromBB, BasicBlock *toBB)
    {
        graph[blockIdx[fromBB]].push_back(blockIdx[toBB]);
    }
};

// split blocks by calling functions
class BlocksSplitter : public InstVisitor<BlocksSplitter>
{

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

// find tracepoints in Module
class TracePointFinder : public InstVisitor<TracePointFinder> {

private:
    map<TracePoint, BasicBlock *> tracepoints;
    inline static string tracePointFunName = "besc_tracepoint";

public:
    TracePointFinder() {}

    TracePoint* getTracePoint(Instruction& I) {
        auto *CI          = dyn_cast<CallInst>(&I);
        if (CI == nullptr) return nullptr;
        auto calledFunPtr = CI->getCalledFunction();
        string funName    = calledFunPtr->getName().str();
        if (funName != tracePointFunName) return nullptr;
        auto llvm_operand = cast<ConstantExpr>(CI->getArgOperand(0));
        auto func_operand = cast<GlobalVariable>(llvm_operand->getOperand(0));
        auto llvm_array   = cast<ConstantDataArray>(func_operand->getInitializer());
        auto llvm_string  = llvm_array->getAsString();
        string argument   = llvm_string.str();
        argument.resize(argument.size() - 1); // remove trailing '\00'
        return new TracePoint(argument);
    }

    map<TracePoint, Vertex> find(Module &M, map<BasicBlock *, Vertex> &blockIdx)
    {
        visit(M);
        return mapUnion(tracepoints, blockIdx);
    }

    void visitCallInst(CallInst& CI) { 
        BasicBlock *curBlock = CI.getParent();
        TracePoint *tp = getTracePoint(CI);
        if (tp != nullptr)
            tracepoints[*tp] = curBlock;
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
class CyclesChecker
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
        bool reached_final_tp;
        bool avoided_final_tp;
        bool loop_found;
        Color color = White;
    };
    Graph graph;
    vector<Vertex> dfs_stack;
    map<TracePoint, Vertex> labels;

public:
    vector<DfsStatus> status;

    CyclesChecker(Graph &graph_, map<TracePoint, Vertex> &labels_)
    {
        graph = graph_;
        labels = labels_;
    }

    void check(TracePoint start_tp, TracePoint final_tp)
    {
        clear();
        dfs(labels[start_tp], labels[final_tp]);
    }

private:
    void clear() {
        status.assign(graph.size(), DfsStatus());
    }

    void dfs(Vertex v, Vertex final_v)
    {
        if (v == final_v)
        {
            status[v].reached_final_tp = true;
            status[v].avoided_final_tp = false;
            status[v].color = Black;
            return;
        }

        status[v].reached_final_tp = false;
        status[v].avoided_final_tp = graph[v].empty();
        status[v].loop_found = false;
        status[v].color = Grey;
        dfs_stack.push_back(v);
        for (Vertex to : graph[v])
        {
            if (status[to].color == White)
            {
                dfs(to, final_v);
            }

            if (status[to].color == Grey)
            {
                // You can modify that part of dfs to mark cycles and retrieve
                // info about them
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
                    status[v].reached_final_tp = true;
                    status[v].loop_found |= status[to].loop_found;
                }
                status[v].avoided_final_tp |= status[to].avoided_final_tp;
            }
        }
        dfs_stack.pop_back();
        status[v].color = Black;
    }
};

// main function of searching loop in trace between start_tp and final_tp
SearchingState runSearch(Module &M, TracePoint start_tp, TracePoint final_tp)
{
    SearchingState state = SearchingState();
    auto BS = BlocksSplitter();
    BS.split(M);

    auto GC = GraphCreator(M);
    auto graph = GC.getGraph();
    auto blockIdx = GC.getBlockIdx();
    auto labels = TracePointFinder().find(M, blockIdx);

    state.StartTPNotFound = labels.find(start_tp) == labels.end();
    state.FinalTPNotFound = labels.find(final_tp) == labels.end();

    // Early return to avoid pointless loops finding, etc.
    if (state.StartTPNotFound || state.FinalTPNotFound)
    {
        return state;
    }

    // LoopsFinder still has to collect info about final tp reachability,
    // so we reuse it as a side effect.
    // TODO: save results in LoopsFinder and use them here
    auto cyclesChecker = CyclesChecker(graph, labels);
    cyclesChecker.check(start_tp, final_tp);

    state.LoopFound = cyclesChecker.status[labels[start_tp]].loop_found;
    state.FinalTPUnreachable = ! cyclesChecker.status[labels[start_tp]].reached_final_tp;
    state.FinalTPAvoidable = cyclesChecker.status[labels[start_tp]].avoided_final_tp;
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
    SearchingState ret = runSearch(*Mod, start_tp, final_tp);
    cout << ret << endl;
    return ret.to_int();
}
