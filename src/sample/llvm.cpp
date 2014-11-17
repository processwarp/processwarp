

#include <iostream>

#include <llvm/AsmParser/Parser.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/Support/ManagedStatic.h>
#include <llvm/Support/SourceMgr.h>
#include <memory>

using namespace llvm;

int main(int argc, char* argv[]) {
  LLVMContext& context = getGlobalContext();
  SMDiagnostic error;

  std::unique_ptr<Module> module = ParseAssemblyFile(argv[1], error, context);

  std::cout << "global" << std::endl;
  for (auto gl = module->global_begin(); gl != module->global_end(); gl ++) {
    std::cout << "  " << gl->getValueName() << "\t" << gl->getName().str() << std::endl;
  }

  std::cout << "function" << std::endl;
  for (auto fn = module->begin(); fn != module->end(); fn ++) {
    std::cout << "  " << fn->getValueName() << "\t" << fn->getName().str() << std::endl;
  }

  std::cout << "alias" << std::endl;
  for (auto al = module->alias_begin(); al != module->alias_end(); al ++) {
    std::cout << "  " << al->getValueName() << "\t" << al->getName().str() << std::endl;
  }
  
  llvm_shutdown();
}
