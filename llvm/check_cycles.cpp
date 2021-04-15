#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/BasicBlock.h"

#include <iostream>
#include <vector>
#include <set>
#include <map>

using namespace llvm;
using namespace std;

typedef string TracePoint;
typedef unsigned int Vertex;
typedef vector<vector<Vertex>> AdjacencyList;
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


class Graph : public InstVisitor<Graph>
{

private:
    inline static FunName tracePointFunName = FunName("besc_tracepoint");

    map<BasicBlock *, Vertex> vertex;
    AdjacencyList alist;
    map<Vertex, Vertex> calledFun;
    map<TracePoint, Vertex> label;
    size_t amtVertices = 0;

public:
    // without this line it isn't compiled
    Graph() {}

    Graph(Module &M) { visit(M); }

    size_t amountVertices() { return amtVertices; }

    vector<Vertex> getAdjacentVertices(Vertex v) { return alist[v]; }

    Vertex* getCalledFun(Vertex v)
    {
        auto to_ptr = calledFun.find(v);
        if (to_ptr == calledFun.end())
            return nullptr;
        else
            return new Vertex(to_ptr->second);
    }

    Vertex* vertexFromTracePoint(TracePoint tp)
    {
        auto v_ptr = label.find(tp);
        if (v_ptr == label.end())
            return nullptr;
        else
            return new Vertex(v_ptr->second);
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
                auto funName = FunName(CI->getCalledFunction()->getName().str());

                if (funName == tracePointFunName)
                {
                    label[getTracePoint(CI)] = vertex[BB];
                }
                else
                {
                    calledFun[vertex[BB]] = vertex[&CI->getCalledFunction()->getEntryBlock()];
                }
            }
        }
    }

private:
    void addVertex(BasicBlock *BB)
    {
        if (vertex.find(BB) == vertex.end())
        {
            vertex[BB] = amtVertices++;
            alist.push_back({});
        }
    }

    void addEdge(BasicBlock *fromBB, BasicBlock *toBB)
    {
        alist[vertex[fromBB]].push_back(vertex[toBB]);
    }

    TracePoint getTracePoint(CallInst *CI) {
        auto llvm_operand = cast<ConstantExpr>(CI->getArgOperand(0));
        auto func_operand = cast<GlobalVariable>(llvm_operand->getOperand(0));
        auto llvm_array   = cast<ConstantDataArray>(func_operand->getInitializer());
        auto llvm_string  = llvm_array->getAsString();
        auto argument     = llvm_string.str();
        argument.resize(argument.size() - 1); // remove trailing '\00'
        return TracePoint(argument);
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
public:
    struct DfsStatus
    {
        bool reached_final_tp;
        bool avoided_final_tp;
        bool loop_on_trace_found;
        bool real_loop_found;
    };

private:
    enum Color
    {
        White,
        Grey,
        Black,
    };

    Graph graph;

    vector<Color> color;
    vector<Vertex> dfs_stack;
    vector<DfsStatus> status;

    Vertex final_v;

public:
    CyclesChecker(Graph& graph_)
    {
        graph = graph_;
    }

    DfsStatus check(Vertex start_v_, Vertex final_v_)
    {
        clear();
        final_v = final_v_;
        dfs(start_v_);
        return status[start_v_];
    }

private:
    void clear() {
        color.assign(graph.amountVertices(), White);
        dfs_stack.clear();
        status.assign(graph.amountVertices(), DfsStatus());
    }

    void dfs(Vertex v)
    {
        if (v == final_v)
        {
            status[v].reached_final_tp = true;
            status[v].avoided_final_tp = false;
            status[v].loop_on_trace_found = false;
            status[v].real_loop_found = false;
            color[v] = Black;
            return;
        }

        status[v].reached_final_tp = false;
        status[v].avoided_final_tp = graph.getAdjacentVertices(v).empty();
        status[v].loop_on_trace_found = false;
        status[v].real_loop_found = false;
        color[v] = Grey;
        dfs_stack.push_back(v);

        if (auto to_ptr = graph.getCalledFun(v))
        {
            auto to = *to_ptr;

            if (color[to] == White)
            {
                // calling function
                dfs(to);
            }

            if (color[to] == Grey)
            {
                // recursion found
                for (auto w = dfs_stack.rbegin(); *w != to; w++)
                {
                    status[*w].loop_on_trace_found = true;
                    status[*w].real_loop_found = true;
                }
                status[to].loop_on_trace_found = true;
                status[to].real_loop_found = true;
            }

            if (color[to] == Black)
            {
                if (status[to].reached_final_tp)
                {
                    // we already found `final_v' and don't need to do anything after, so
                    // we just must take right status from `to'
                    status[v] = status[to];
                    color[v] = Black;
                    return;
                }
                else
                {
                    // there isn't `final_v' in "subgraph" of called function, but, unlike
                    // usual edges, if some loop in called function (or in called function
                    // of called function etc.) is found, we must set both
                    // `loop_on_trace_found' and `real_loop_found' to `true' because:
                    //
                    // 1) if there is `final_v' in some brunch of this vertex, we must say
                    // that we have found loop on trace between start_v and final_v
                    //
                    // 2) if there isn't `final_v' in any brunch of this vertex, we
                    // mustn't say that we have found loop, and we actually won't say that
                    // because in this case information about loop from
                    // `loop_on_trace_found' won't spread to parent vertices
                    status[v].loop_on_trace_found = status[to].real_loop_found;
                    status[v].real_loop_found = status[to].real_loop_found;
                }
            }
        }

        for (Vertex to : graph.getAdjacentVertices(v))
        {
            if (color[to] == White)
            {
                dfs(to);
            }

            if (color[to] == Grey)
            {
                // You can modify that part of dfs to mark cycles and retrieve
                // info about them
                for (auto w = dfs_stack.rbegin(); *w != to; w++)
                {
                    status[*w].loop_on_trace_found = true;
                    status[*w].real_loop_found = true;
                }
                status[to].loop_on_trace_found = true;
                status[to].real_loop_found = true;
            }

            if (color[to] == Black)
            {
                if (status[to].reached_final_tp)
                {
                    // we have found `final_v' in current brunch of this vertex, so we
                    // just update status of `v' with `|=' operator because usual edges
                    // are brunches from `br' instruction and we want to know if there is
                    // some brunch with such property (for example for `real_loop_found'
                    // field there is some brunch with loop)
                    status[v].reached_final_tp = true;
                    status[v].avoided_final_tp |= status[to].avoided_final_tp;
                    status[v].loop_on_trace_found |= status[to].loop_on_trace_found;
                    status[v].real_loop_found |= status[to].real_loop_found;
                }
                else
                {
                    // here we must update information:
                    //
                    // 1) `avoided_final_tp' because we can found vertex without any
                    // output edges (we don't set `true' immediately because we can't
                    // arrive such vertex when we are in loop, for example)
                    //
                    // 2) `real_loop_found' because this field is `true' if we have found
                    // some loop and it doesn't matter where
                    status[v].avoided_final_tp |= status[to].avoided_final_tp;
                    status[v].real_loop_found |= status[to].real_loop_found;
                }
            }
        }

        dfs_stack.pop_back();
        color[v] = Black;
    }
};

// main function of searching loop in trace between start_tp and final_tp
SearchingState runSearch(Module &M, TracePoint start_tp, TracePoint final_tp)
{
    SearchingState state = SearchingState();

    auto graph = Graph(M);

    auto start_v = graph.vertexFromTracePoint(start_tp);
    auto final_v = graph.vertexFromTracePoint(final_tp);

    state.StartTPNotFound = start_v == nullptr;
    state.FinalTPNotFound = final_v == nullptr;

    // Early return to avoid pointless loops finding, etc.
    if (state.StartTPNotFound || state.FinalTPNotFound)
    {
        return state;
    }

    // LoopsFinder still has to collect info about final tp reachability,
    // so we reuse it as a side effect.
    // TODO: save results in LoopsFinder and use them here
    auto cyclesChecker = CyclesChecker(graph);
    auto ccStatus = cyclesChecker.check(*start_v, *final_v);

    state.LoopFound = ccStatus.loop_on_trace_found;
    state.FinalTPUnreachable = ! ccStatus.reached_final_tp;
    state.FinalTPAvoidable = ccStatus.avoided_final_tp;
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
