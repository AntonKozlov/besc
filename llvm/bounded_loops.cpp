#include <llvm/IR/PassManager.h>
#include <llvm/IR/Attributes.h>
#include <llvm/IR/Module.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Dominators.h>
#include <llvm/Analysis/LoopInfo.h>
#include <llvm/IR/GlobalValue.h>
#include <llvm/IR/IRPrintingPasses.h>
#include <llvm/Passes/PassBuilder.h>
#include <llvm/ADT/Optional.h>
#include <llvm/Pass.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/IR/Dominators.h>
#include <llvm/Analysis/LoopInfo.h>
#include <llvm/IR/GlobalValue.h>
#include <llvm/Analysis/CallGraph.h>
#include <llvm/Analysis/ScalarEvolution.h>
#include <llvm/Analysis/ScalarEvolutionExpressions.h>
#include <llvm/Analysis/AssumptionCache.h>
#include <llvm/Analysis/TargetLibraryInfo.h>

#include <functional>
#include <iostream>

void runO1OptimizationPass(llvm::Module &module) {
    auto empty_attr_list = llvm::AttributeList();
    auto pass_builder = llvm::PassBuilder{};

    auto loop_manager = llvm::LoopAnalysisManager{};
    auto cgscc_manager = llvm::CGSCCAnalysisManager{};
    auto mod_manager = llvm::ModuleAnalysisManager{};
    auto fa_manager = llvm::FunctionAnalysisManager{};

    pass_builder.registerModuleAnalyses(mod_manager);
    pass_builder.registerCGSCCAnalyses(cgscc_manager);
    pass_builder.registerFunctionAnalyses(fa_manager);
    pass_builder.registerLoopAnalyses(loop_manager);
    pass_builder.crossRegisterProxies(loop_manager, fa_manager, cgscc_manager, mod_manager);

    auto fp_manager = pass_builder.buildFunctionSimplificationPipeline(
        llvm::PassBuilder::OptimizationLevel::O1,
        llvm::PassBuilder::ThinLTOPhase::None,
        true
    );

    for (auto &fun : module.getFunctionList()) {
        if (fun.hasExactDefinition()) {
            fun.setAttributes(empty_attr_list);
            fp_manager.run(fun, fa_manager);
        }
    }
}

std::vector <std::vector<llvm::BasicBlock * >> extractBlocksGroupedByLoops(llvm::Function &fun) {
    std::vector <std::vector<llvm::BasicBlock * >> blocks_groups;

    if (fun.getBasicBlockList().size() == 0) {
        return blocks_groups;
    }

    auto dt = llvm::DominatorTree(fun);
    auto loop_info = llvm::LoopInfo(dt);
    auto ac = llvm::AssumptionCache(fun);
    auto tlii = llvm::TargetLibraryInfoImpl();
    auto tli = llvm::TargetLibraryInfo(tlii);
    auto se = llvm::ScalarEvolution(fun, tli, ac, dt, loop_info);

    std::function<bool(llvm::Loop * )> process_loop = [&](llvm::Loop *loop) {
        auto backedge_taken = se.getBackedgeTakenCount(loop);
        auto max_backedge_taken = se.getConstantMaxBackedgeTakenCount(loop);
        auto trip_multiple = se.getSmallConstantTripMultiple(loop);

        bool has_unbounded_subloop = false;
        for (auto *subloop : loop->getSubLoops()) {
            if (!process_loop(subloop)) {
                has_unbounded_subloop = true;
            }
        }

        if (has_unbounded_subloop) {
            return false;
        }

        if (backedge_taken->getSCEVType() != llvm::scCouldNotCompute
            && max_backedge_taken->getSCEVType() != llvm::scCouldNotCompute
            && trip_multiple > 1)
        {
            blocks_groups.push_back(loop->getBlocksVector());
            return true;
        }

        return false;

//        auto buf = std::string();
//        llvm::raw_string_ostream stream(buf);
//        stream << "backedge_taken:";
//        backedge_taken->print(stream);
//        stream << " max_backedge_taken:";
//        max_backedge_taken->print(stream);
//        stream << " trip_multiple:" << trip_multiple;
//
//        auto *md = llvm::MDNode::get(context, llvm::MDString::get(context, stream.str().data()));
//        loop->getHeader()->getInstList().front().setMetadata("besc.loop.info", md);
    };

    for (auto *loop : loop_info) {
        process_loop(loop);
    }

    return blocks_groups;
}


// -----------------------
//      Usage example:
// -----------------------

//int main(int argc, char **argv) {
//    llvm::SMDiagnostic err;
//    llvm::LLVMContext context;
//    auto module_ptr = llvm::parseIRFile(argv[1], err, context);
//    auto &module = *module_ptr;
//
//    // Running O1 optimization pass to convert all loops in the module into some correct form
//    runO1OptimizationPass(module);
//
//    // Iterate over all functions in the module, extract loops and their corresponding groups of basic blocks
//    for (auto &fun : module) {
//        auto block_groups = extractBlocksGroupedByLoops(fun);
//        for (auto blocks : block_groups) {
//            llvm::outs() << "------------ \n";
//            llvm::outs() << "  New loop   \n";
//            llvm::outs() << "------------ \n\n";
//            for (auto block : blocks) {
//                llvm::outs() << " --- start block --- \n";
//                llvm::outs() << *block << "\n";
//                llvm::outs() << " ---- end block ---- \n\n\n";
//            }
//            llvm::outs() << "\n";
//        }
//    }
//
//    auto manager = llvm::AnalysisManager<llvm::Module>();
//    auto print_pass = llvm::PrintModulePass(llvm::outs());
//    void(print_pass.run(module, manager));
//
//    return 0;
//}
