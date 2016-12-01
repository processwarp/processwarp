#pragma once

#if !defined(NDEBUG) && !defined(EMSCRIPTEN)
#  if defined(__clang__) && (__clang_major__ > 3 || (__clang_major__ == 3 && __clang_minor__ >= 6))
#    pragma clang diagnostic push
#    pragma clang diagnostic ignored "-Wredundant-move"
#    include <llvm/IR/Constants.h>
#    pragma clang diagnostic pop
#  else
#    include <llvm/IR/Constants.h>
#  endif
#  include <llvm/IR/DerivedTypes.h>
#  include <llvm/IR/Module.h>
#  include <llvm/IR/Instructions.h>
#  include <llvm/IR/LLVMContext.h>
#  include <llvm/IR/Value.h>
#  include <llvm/IR/ValueSymbolTable.h>
#  include <llvm/AsmParser/Parser.h>
#  include <llvm/Support/ManagedStatic.h>
#  include <llvm/Support/SourceMgr.h>
#endif

namespace processwarp {
namespace LlvmUtil {

#if !defined(ENABLE_LLVM) || defined(NDEBUG) || defined(EMSCRIPTEN)
#define save_llvm_instruction(I)  //
#define print_llvm_instruction()  //
#else
extern const llvm::Instruction* llvm_instruction;
#define save_llvm_instruction(I) LlvmUtil::llvm_instruction = (I)
#define print_llvm_instruction() LlvmUtil::llvm_instruction->dump();
#endif

}  // namespace LlvmUtil
}  // namespace processwarp
