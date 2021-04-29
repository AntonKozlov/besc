#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/BasicBlock.h"

#include "types.h"
#include "bounded_loops.h"
#include "utils.h"
#include "split_blocks.cpp"

#include <iostream>
#include <vector>
#include <set>
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

// create graph of Module
class GraphCreator : public InstVisitor<GraphCreator>
{

private:
    Graph graph;
    map<BasicBlock *, Vertex> blockIdx;
    map<BasicBlock *, BasicBlock *> calledFun;
    map<TracePoint, BasicBlock *> label;
    unsigned int amtBlocks = 0;
    inline static string tracePointFunName = "besc_tracepoint";

public:
    GraphCreator(Module &M) { visit(M); }

    Graph getGraph() { return graph; }

    map<BasicBlock *, Vertex> getBlockIdx() { return blockIdx; }

    map<Vertex, Vertex> getCalledFun() {
        auto middle_map = mapApply(blockIdx, calledFun);
        return mapUnion(middle_map, blockIdx);
    }

    map<TracePoint, Vertex> getLabel() { return mapUnion(label, blockIdx); }

    void visitBasicBlock(BasicBlock& BB_)
    {
        cout << "BB.parent.name = " << BB_.getParent()->getName().str() << endl;
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
                    label[getTracePoint(CI)] = BB;
                }
                else
                {
                    cout << "calledFun[BB].called.name = " << CI->getCalledFunction()->getName().str() << endl;
                    calledFun[BB] = &CI->getCalledFunction()->getEntryBlock();
                }
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
    map<Vertex, Vertex> calledFun;

    vector<Color> color;
    vector<Vertex> dfs_stack;
    vector<DfsStatus> status;
    vector < vector<Vertex> > bounded_loops;

    Vertex final_v;

public:
    CyclesChecker(Graph& graph_,
                  map<Vertex, Vertex>& calledFun_,
                  vector < vector<Vertex> > bounded_loops_)
    {
        graph = graph_;
        calledFun = calledFun_;
        bounded_loops = bounded_loops_;
    }

    DfsStatus check(Vertex start_v_, Vertex final_v_)
    {
        clear();
        final_v = final_v_;
        dfs(start_v_);
        return status[start_v_];
    }

private:
    bool check_bounded_loop(Vertex cycle_entry)
    {
        auto entry_it = std::find(dfs_stack.rbegin(), dfs_stack.rend(), cycle_entry);
        assert(entry_it != dfs_stack.rend());

        // https://stackoverflow.com/a/2037917
        std::vector<Vertex> loop(
            (entry_it + 1).base(), 
            dfs_stack.end()
        );

        // std::cout << "FOUND Loop: "; 
        // for (auto v: loop) {
        //     std::cout << v << " ";
        // }
        // std::cout << std::endl;

        for (auto bounded_loop: bounded_loops) {
            if (compareVertexLists(loop, bounded_loop)) {
                // std::cout << ">>>> BOUNDED!!!" << std::endl;
                return true;
            }
        }

        return false;
    }

    void clear() {
        color.assign(graph.size(), White);
        dfs_stack.clear();
        status.assign(graph.size(), DfsStatus());
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
        status[v].avoided_final_tp = graph[v].empty();
        status[v].loop_on_trace_found = false;
        status[v].real_loop_found = false;
        color[v] = Grey;
        dfs_stack.push_back(v);

        if (calledFun.find(v) != calledFun.end())
        {
            auto to = calledFun[v];

            if (color[to] == White)
            {
                // calling function
                dfs(to);
            }

            if (color[to] == Grey)
            {
                // recursion found
                if (!check_bounded_loop(to)) {
                    for (auto w = dfs_stack.rbegin(); *w != to; w++)
                    {
                        status[*w].loop_on_trace_found = true;
                        status[*w].real_loop_found = true;
                    }
                    status[to].loop_on_trace_found = true;
                    status[to].real_loop_found = true;
                }
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

        for (Vertex to : graph[v])
        {
            if (color[to] == White)
            {
                dfs(to);
            }

            if (color[to] == Grey)
            {
                if (!check_bounded_loop(to)) {
                    for (auto w = dfs_stack.rbegin(); *w != to; w++)
                    {
                        status[*w].loop_on_trace_found = true;
                        status[*w].real_loop_found = true;
                    }
                    status[to].loop_on_trace_found = true;
                    status[to].real_loop_found = true;
                }
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
    runO1OptimizationPass(M);
    SearchingState state = SearchingState();

    auto BS = BlocksSplitter();
    BS.split(M);

    auto GC = GraphCreator(M);
    auto graph = GC.getGraph();
    auto calledFun = GC.getCalledFun();
    auto label = GC.getLabel();
    auto blockIdx = GC.getBlockIdx();

    printGraph(graph, calledFun);

    state.StartTPNotFound = label.find(start_tp) == label.end();
    state.FinalTPNotFound = label.find(final_tp) == label.end();

    // Early return to avoid pointless loops finding, etc.
    if (state.StartTPNotFound || state.FinalTPNotFound)
    {
        return state;
    }

    // Iterate over all functions in the module, 
    // extract loops and their corresponding groups of basic blocks
    // and convert them to Vertex loops
    vector < vector<Vertex> > bounded_loops = {};
    for (auto &fun : M) {
        auto block_groups = extractBlocksGroupedByLoops(fun);
        for (auto group: block_groups) {
            vector<Vertex> vertex_loop = {};
            for (auto block: group) {
                vertex_loop.push_back(blockIdx[block]);
            }
            bounded_loops.push_back(vertex_loop);
        }
        // for (auto blocks : block_groups) {
        //     std::cout << "BLOCK GROUP" << std::endl;
        //     llvm::outs() << "New group \n";
        //     for (auto block : blocks) {
        //         llvm::outs() << "start block \n";
        //         llvm::outs() << *block << "\n";
        //         llvm::outs() << "end block \n";
        //     }
        // }
    }

    // std::cout << "Loops: " << bounded_loops.size() << std::endl;
    // for (auto loop: bounded_loops) {
    //     std::cout << "Loop: "; 
    //     for (auto v: loop) {
    //         std::cout << v << " ";
    //     }
    //     std::cout << std::endl;
    // }

    // auto manager = llvm::AnalysisManager<llvm::Module>();
    // auto print_pass = llvm::PrintModulePass(llvm::outs());
    // void(print_pass.run(M, manager));

    auto start_v = label[start_tp];
    auto final_v = label[final_tp];

    // LoopsFinder still has to collect info about final tp reachability,
    // so we reuse it as a side effect.
    auto cyclesChecker = CyclesChecker(graph, calledFun, bounded_loops);
    auto ccStatus = cyclesChecker.check(start_v, final_v);

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
