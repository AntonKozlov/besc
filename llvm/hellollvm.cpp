#include "llvm/IR/Metadata.h"
#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Pass.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/CodeGen/TargetOpcodes.h"
#include "llvm/IR/InstVisitor.h"
#include <map>
#include <iostream>
#include <vector>

using namespace llvm;
using namespace std;

map <Block, int> Color;

bool CycleFound = false;

map<int, vector <int> > d;

bool dfs(int start){
	int s;
	Color[start] = 1;
	const auto found1 = d.find(start);
	if (found1 == d.cend()){
		s = -1;
	} else {
		s = found1->first;
	}
	if (s != -1){
		for(int u : d[start]){
			if (Color[u] == 0){
				dfs(u);
			}
			else if (Color[u] == 1){
				CycleFound = true;
			}
		}
	}
	Color[start] = 2;
	return CycleFound;
}

  struct BranchInstVisitor : public InstVisitor<BranchInstVisitor>{
	  unsigned Count;
	  BranchInstVisitor() : Count(0){}
	  void visitBranchInst(BranchInst &BI){
		  Count++;
		  errs() << "BI found" << Count << BI <<"\n";
		  for(unsigned i = 0; i < BI.getNumSuccessors(); i++){
			  errs() << BI.getParent() << " -> " << BI.getSuccessor(i) <<"\n";
			  ///if (Color[BI.getSuccesor(i)] == 0){
				 /// dfs(BI.getSuccesor(i));
			 /// }
		  }
	  }
  };

int main(int argc, char **argv) {
	int z;
	unsigned n, a, b, i;
	for (int j = 0; j < Count_num_of_BI; j++){
	n = BI.getNumSuccessors();
	vector <unsigned> k;
		for(i = 0; i < n; i++){
		    a = BI.getParent();
		    b = BI.getSuccessor(i);
		    k = d.find(a)->second;
		    k.push_back(b);
		    d[a] = k;
		    const auto found = Color.find(a);
		    if (found == Color.cend()){
		        Color[a] = 0;
		    }
		}
	}
		for (int i = 1; i < n+1; i++){
				const auto found = Color.find(i);
				if (found == Color.cend()){
					z = 0;
				} else {
				z = found->first;
				}
				if (z == 0){
					dfs(i);
				}

			}
			cout << CycleFound;


  if (argc < 2) {
    errs() << "Usage: " << argv[0] << " <IR file>\n";
    return 1;
  }

  // Parse the input LLVM IR file into a module.
  SMDiagnostic Err;
  LLVMContext Context;
  std::unique_ptr<Module> Mod(parseIRFile(argv[1], Err, Context));
  if (!Mod) {
    Err.print(argv[0], errs());
    return 1;
  }

  // Go over all named mdnodes in the module
  //for (Module::const_named_metadata_iterator I = Mod->named_metadata_begin(),
                                             //E = Mod->named_metadata_end();
       //I != E; ++I) {
    //outs() << "Found MDNode:\n";
    // These dumps only work with LLVM built with a special cmake flag enabling
    // dumps.
    // I->dump();

    //for (unsigned i = 0, e = I->getNumOperands(); i != e; ++i) {
      //Metadata *Op = I->getOperand(i);
      //if (auto *N = dyn_cast<MDNode>(Op)) {
        //outs() << "  Has MDNode operand:\n  ";
        // N->dump();
        //outs() << "  " << N->getNumOperands() << " operands\n";
      //}
    //}
  //}
  BranchInstVisitor BIV;
  for(Module::iterator FI = Mod->begin(), FE = Mod->end(); FI != FE; ++FI){
	  outs() << "Found function:\n";
	  Function& f = *FI;
	  for(Function::iterator BI = f.begin(), BE = f.end(); BI != BE; ++BI){
		  outs() << "  Found block:\n";
		  BasicBlock& BB = *BI;
		  BIV.visit(BB);
	  }
  }
  BranchInstVisitor BIV;
  BIV.visit(*Mod);


  return 0;
}
}
