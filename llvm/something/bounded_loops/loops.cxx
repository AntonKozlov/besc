#include <llvm/ADT/Optional.h>
#include <llvm/IR/IRPrintingPasses.h>
#include <llvm/Pass.h>
#include <llvm/IR/PassManager.h>
#include <llvm/IR/Module.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Dominators.h>
#include <llvm/Analysis/LoopInfo.h>
#include <llvm/IR/GlobalValue.h>
#include <llvm/Analysis/CallGraph.h>
#include <llvm/Analysis/ScalarEvolution.h>
#include <llvm/Analysis/ScalarEvolutionExpressions.h>
#include <llvm/Analysis/AssumptionCache.h>
#include <llvm/Analysis/TargetLibraryInfo.h>

#include <iostream>
#include <functional>

int main(int argc, char **argv) {
    llvm::LLVMContext context;
    auto err = llvm::SMDiagnostic();
    auto module_ptr = llvm::parseIRFile(argv[1], err, context);
    auto& module = *module_ptr;

    auto predicates = llvm::SCEVUnionPredicate();

    for (auto& fun : module) {
        if (fun.getBasicBlockList().size() == 0) {
            continue;
        }
        auto dt = llvm::DominatorTree(fun);
        auto loop_info = llvm::LoopInfo(dt);
        auto ac = llvm::AssumptionCache(fun);
        auto tlii = llvm::TargetLibraryInfoImpl();
        auto tli = llvm::TargetLibraryInfo(tlii);
        auto se = llvm::ScalarEvolution(fun, tli, ac, dt, loop_info);

        std::function<void(llvm::Loop*)> add_metadata = [&](llvm::Loop* loop) {
            auto backedge_taken = se.getBackedgeTakenCount(loop);
            auto max_backedge_taken = se.getConstantMaxBackedgeTakenCount(loop);
            auto predicated_backedge_taken = se.getPredicatedBackedgeTakenCount(loop, predicates);
            auto trip_multiple = se.getSmallConstantTripMultiple(loop);

            auto buf = std::string();
            llvm::raw_string_ostream stream(buf);

            stream << "backedge_taken:";
            backedge_taken->print(stream);
            stream << " max_backedge_taken:";
            max_backedge_taken->print(stream);
            stream << " predicated_backedge_taken:";
            predicated_backedge_taken->print(stream);
            stream << " trip_multiple:" << trip_multiple;

            auto* md = llvm::MDNode::get(context, llvm::MDString::get(context, stream.str().data()));
            loop->getHeader()->getInstList().front().setMetadata("besc.loop.info", md);

            for (auto* subloop : loop->getSubLoops()) {
                add_metadata(subloop);
            }
        };

        for (auto* loop : loop_info) {
            add_metadata(loop);
        }
    }

    auto manager = llvm::AnalysisManager<llvm::Module>();
    auto print_pass = llvm::PrintModulePass(llvm::outs());
    void(print_pass.run(module, manager));

    return 0;
}
