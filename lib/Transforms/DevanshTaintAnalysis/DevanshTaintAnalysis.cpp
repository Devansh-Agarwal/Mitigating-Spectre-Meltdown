//                     The LLVM Compiler Infrastructure
//===----------------------------------------------------------------------===//
//
// This file implements basic Taint analysyis
//
//===----------------------------------------------------------------------===//

#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/Debug.h"
#include "llvm/IR/Value.h"
#include "llvm/IR/Use.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/IRBuilder.h"
#include "string"
#include "vector"
#include "algorithm"


using namespace llvm;

/*

  Basic code flow design :
  Define what is considered as tainted(not considering the propogated taints).
  Find those initial taints in the code.(1 Pass through IR)
    -- store all the instructions that can possibly have a taint.
    -- process those statements
  Propogate those taints in a soup like fashion unless no more taints are found.(X number of pass through Ir)
    -- while(true){d-u chain, u-d chain}
  Check for br. conditions which have a tainted memory instruction
    -- collect tainted br
    -- check br labels block if they tainted memory access.
  Add lfence before the tainted branch instruction.
    -- insert function declaration "declare void @llvm.x86.sse2.lfence() #2
    -- insert function call "call void @llvm.x86.sse2.lfence()" before tainted branches.
*/



using namespace llvm;



namespace {
         // using namespace llvm;
  struct DevanshTaintAnalysis : public ModulePass 
  {

        // 
       // using namespace std;
       static char ID; // Pass identification, replacement for typeid
    
//-----------------------------------------------------------------------------------------            
      /*
      Defining Initial Taint types:
      1) scanf
      */
//-----------------------------------------------------------------------------------------                
      
      
      DevanshTaintAnalysis() : ModulePass(ID) {}
      
 // Initial tain utility function --------------------------------------------------------------------     
       bool isScanf(CallInst * inst) 
       {
         Function *Func  = inst->getCalledFunction();          
         return (Func->getName()).contains("scanf") == 1 ;
       }
//Collecting all scanf instructions ------------------------------------------------------------------         
       void collectScanfInst(Module& M, std:: vector<Instruction *>& scanfInst  )
       {
        for(Function& F : M)
        {
          for(auto& bb : F)
          {

            for(auto& ins : bb )
            {
              
              if(isa<CallInst>(&ins))
              {
              CallInst* temp = llvm::dyn_cast<CallInst>(&ins);
                if(isScanf(temp))
                {
                  if(find(scanfInst.begin(), scanfInst.end(), &ins) ==scanfInst.end())
                    scanfInst.push_back(&ins);
                }
              }
            }
          }
        }
         return;
       }

//----------------------------------------------------------------------------------------------------

//Copy Vectors----------------------------------------------------------------------------------------

       void copyInitialToAllTaintsVector(std:: vector<Instruction *>& initialTaintdef,std:: vector<Instruction *> & allTaintedInst)
       {
        for(Instruction * ins : initialTaintdef)
        {
          allTaintedInst.push_back(ins);
        }
       }

//----------------------------------------------------------------------------------------------------      

//Find initial Taints caused by scanf ----------------------------------------------------------------
      
        void getInitialTaintsByScanf(std:: vector<Instruction *>& scanfInst, std:: vector<Instruction *>& initialTaintdef)
        {
          for(Instruction* ins : scanfInst)
          {
            int flag = 1;
            for(Use &U  : ins->operands())
            {
                
                // Value* z = U.get();
                //  dbgs() << "-----" << *z << "\n";                 
                if(flag == 1 || U == *((ins->operands().end())-1))
                {
                  flag = 0;
                  continue;
                }
                Value* v = U.get();
                Instruction *insTemp ;
                if((insTemp = dyn_cast<Instruction>(v)))
                  {
                    if((find(initialTaintdef.begin(), initialTaintdef.end(), insTemp) == initialTaintdef.end()))
                    {  
                      initialTaintdef.push_back(insTemp);
                    }
                  }
            
            }
            flag =  1;
          }  
        }

//----------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------

//Find all tainted Instructions Intra Procdeural------------------------------------------------------
        void getAllTaintedInstIntraProcedural(std:: vector<Instruction *> & allTaintedInst)
        {
          bool flag = true;
          while(flag)
          {
            flag = false;
            for(Instruction * ins : allTaintedInst)
            {
              for(User * U : ins->users())
              {
                Instruction * tempInst;
                if((tempInst = dyn_cast<Instruction>(U)))
                {
                    if((find(allTaintedInst.begin(), allTaintedInst.end(), tempInst) == allTaintedInst.end()))
                  {  
                      
                      allTaintedInst.push_back(tempInst);
                      flag = true;
                      for(Use &U1  : tempInst->operands())
                      {
                          
                          Value* v = U1.get();
                          Instruction *insTemp3 ;
                          if((insTemp3 = dyn_cast<Instruction>(v)))
                            {
                              if((find(allTaintedInst.begin(), allTaintedInst.end(), insTemp3) == allTaintedInst.end()))
                            {  
                                allTaintedInst.push_back(insTemp3);
                            }
                            }
                      
                      }
                  }
                }
              }
            }
          }
        }  

//----------------------------------------------------------------------------------------------------


//Interprocedural Taint propogation-------------------------------------------------------------------
        void getInitialTaintedInstInterProcedural(std:: vector<Instruction *> & allTaintedInst, Module &M)
        {
          for(Function&F : M)
          {
            for(auto& bb : F)
            {

              for(auto& ins : bb )
              {
                int count = 0, count2 =0; 
                if(isa<CallInst>(&ins))
                {
                  if(find(allTaintedInst.begin(),allTaintedInst.end(), &ins) != allTaintedInst.end() )
                  {
                    CallInst* temp = llvm::dyn_cast<CallInst>(&ins);

                    if(!isScanf(temp))
                    {
                      Function * tempFunc = (temp->getCalledFunction());
                      for(Use &U  : ins.operands())
                      {
                        Value* v = U.get();
                        Instruction *insTemp ;
                        if((insTemp  = dyn_cast<Instruction>(v)))
                        {
                          if(find(allTaintedInst.begin(),allTaintedInst.end(), insTemp) != allTaintedInst.end())
                          { 
                            count = 0;
                            for(auto & bb : *tempFunc)
                            {
                              for(auto & ins: bb)
                              {
                                if(count == count2 )
                                {
                                  if(find(allTaintedInst.begin(),allTaintedInst.end(), &ins) == allTaintedInst.end())
                                  {
                                    allTaintedInst.push_back(&ins);
                                    for(User * Us : ins.users())
                                    {
                                      Instruction * tempInst2;
                                      if((tempInst2 = dyn_cast<Instruction>(Us)))
                                      {
                                          if((find(allTaintedInst.begin(), allTaintedInst.end(), tempInst2) == allTaintedInst.end()))
                                        {  
                                            allTaintedInst.push_back(tempInst2);
                                        }
                                      }
                                    }
                                  }
                                  
                                } 
                                count ++ ;
                              }
                            }
                          }
                          count2 ++;
                        }

                      }
                      //dbgs() << *funcName << "\n";
                    }
                    // if(isScanf(temp))
                    // {
                    //   if(find(scanfInst.begin(), scanfInst.end(), &ins) ==scanfInst.end())
                    //     scanfInst.push_back(&ins);
                    // } 
                  }
              
                }
              }
            }
          }
        }
//----------------------------------------------------------------------------------------------------        

//Soup to detect all the taints in called functions---------------------------------------------------        
        void getAllTaintedInstInterProcedural(std:: vector<Instruction *> & allTaintedInst)
        {
          bool flag = true;
          while(flag)
          {
            flag = false;
            for(Instruction * ins : allTaintedInst)
            {
              for(User * U : ins->users())
              {
                Instruction * tempInst;
                if((tempInst = dyn_cast<Instruction>(U)))
                {
                    if((find(allTaintedInst.begin(), allTaintedInst.end(), tempInst) == allTaintedInst.end()))
                  {  
                    allTaintedInst.push_back(tempInst);
                    flag = true;
                    for(Use &U1  : tempInst->operands())
                    {
                        
                      Value* v = U1.get();
                      Instruction *insTemp3 ;
                      if((insTemp3 = dyn_cast<Instruction>(v)))
                        {
                          if((find(allTaintedInst.begin(), allTaintedInst.end(), insTemp3) == allTaintedInst.end()))
                          {  
                            allTaintedInst.push_back(insTemp3);
                          }
                        }
                    
                    }
                  }
                }
              }
            }
          }
        }

//----------------------------------------------------------------------------------------------------

//Find tainted branches-------------------------------------------------------------------------------  

        void getTaintedBranches(std:: vector<Instruction *> & allTaintedInst,  std:: vector<Instruction *>& taintedBrInst)
        {
          for(Instruction * ins : allTaintedInst)
          {
            bool flag = false;
            if(isa<BranchInst> (ins))
            {
              BranchInst * brInstTemp;
              dbgs()<< ins << "\n";
              if((brInstTemp = dyn_cast<BranchInst>(ins)))
              {
              
                
                for(BasicBlock* bb : brInstTemp->successors())
                {
                    for(auto&  insTemp : *bb)
                    {                  
                      if(isa<LoadInst>(&insTemp) || isa<StoreInst>(&insTemp) )
                        {
                          if(find(allTaintedInst.begin(), allTaintedInst.end(), &insTemp) != allTaintedInst.end()) 
                          {
                            if(find(taintedBrInst.begin(), taintedBrInst.end(), ins) == taintedBrInst.end())
                            {
                              taintedBrInst.push_back(ins);
                            }
                            flag = true;
                            break;
                          }
                        }
                    }
                    if(flag)
                      break;
                }
              }
              flag = false;
            }
          }
        }

//----------------------------------------------------------------------------------------------------

//Insert lfence---------------------------------------------------------------------------------------

        void insertFence(Module & M, std:: vector<Instruction *>& taintedBrInst)
        {
          M.getOrInsertFunction("llvm.x86.sse2.lfence",Type::getVoidTy 	(M.getContext()));
          for(Instruction * ins: taintedBrInst)
          {
              CallInst::Create(M.getFunction("llvm.x86.sse2.lfence"),"",ins);
          } 
        }


//----------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------        
        
        bool runOnModule(Module &M) override {

// taint related statements vector--------------------------------------------------------------------     
         std:: vector<Instruction *> scanfInst;  
         std:: vector<Instruction *> initialTaintdef;
         std:: vector<Instruction *> allTaintedInst;
         std:: vector<Instruction *> taintedBrInst;
//---------------------------------------------------------------------------------------------------- 



         collectScanfInst(M, scanfInst);     


         getInitialTaintsByScanf(scanfInst, initialTaintdef);

         copyInitialToAllTaintsVector(initialTaintdef,allTaintedInst);

         getAllTaintedInstIntraProcedural(allTaintedInst);        

       

         getInitialTaintedInstInterProcedural(allTaintedInst, M);
          
         getAllTaintedInstInterProcedural(allTaintedInst);
        
         getTaintedBranches(allTaintedInst, taintedBrInst);

         insertFence(M, taintedBrInst);

//----------------------------------------------------------------------------------------------------

         M.dump();
         return true;
    }
  };
}

char DevanshTaintAnalysis::ID = 0;
static RegisterPass<DevanshTaintAnalysis> X("DevanshTaintAnalysis", "TaintAnalysis");
//Debug helper code-----------------------------------------------------------------------------------
        // for(Function&F : M)
        // {
        //   if(F.getName() == "number")
        //   {
        //     for(BasicBlock& bb : F)
        //     {
        //       for(Instruction & ins : bb)
        //       {
        //         if(find(allTaintedInst.begin(), allTaintedInst.end(), &ins) != allTaintedInst.end())
        //         {
        //           dbgs() << ins << "\n";
        //         }
        //       }
        //     }
        //   }
        // }
//-----------------------------------------------------------------------------------------------------
        // for(Instruction* ins : allTaintedInst)
        // {
        //   dbgs() << *ins << "\n";
        // }        
//-----------------------------------------------------------------------------------------------------        
        // FunctionType *FT = FunctionType::get(Type::getVoidTy 	(M.getContext()) 	, false);
        // Function * fenceFunc = Function::Create(FT, Function::ExternalLinkage,"llvm.x86.sse2.lfence",M);
        //     dbgs() <<*fenceFunc;
//-----------------------------------------------------------------------------------------------------


//-----------------------------------------------------------------------------------------------------                