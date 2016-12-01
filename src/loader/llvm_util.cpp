#include "llvm_util.hpp"

namespace processwarp {
namespace LlvmUtil {

#if defined(ENABLE_LLVM) && !defined(NDEBUG) && !defined(EMSCRIPTEN)
const llvm::Instruction* llvm_instruction;
#endif

}  // namespace LlvmUtil
}  // namespace processwarp
