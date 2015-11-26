
#include <vector>

#include "builtin_memory.hpp"

namespace processwarp {

// llvm.lifetime.start関数。
BuiltinPostProc::Type BuiltinMemory::lifetime_start(Process& proc, Thread& thread,
                                                    BuiltinFuncParam p, vaddr_t dst,
                                                    std::vector<uint8_t>& src) {
  // 何もしない
  return BuiltinPostProc::NORMAL;
}

// llvm.lifetime.end関数。
BuiltinPostProc::Type BuiltinMemory::lifetime_end(Process& proc, Thread& thread,
                                                  BuiltinFuncParam p, vaddr_t dst,
                                                  std::vector<uint8_t>& src) {
  // 何もしない
  return BuiltinPostProc::NORMAL;
}

// llvm.invariant.start関数。
BuiltinPostProc::Type BuiltinMemory::invariant_start(Process& proc, Thread& thread,
                                                     BuiltinFuncParam p, vaddr_t dst,
                                                     std::vector<uint8_t>& src) {
  // 何もしない
  return BuiltinPostProc::NORMAL;
}

// llvm.invariant.end関数。
BuiltinPostProc::Type BuiltinMemory::invariant_end(Process& proc, Thread& thread,
                                                   BuiltinFuncParam p, vaddr_t dst,
                                                   std::vector<uint8_t>& src) {
  // 何もしない
  return BuiltinPostProc::NORMAL;
}

// VMにライブラリを登録する。
void BuiltinMemory::regist(VMachine& vm) {
  vm.regist_builtin_func("llvm.lifetime.start", BuiltinMemory::lifetime_start, 0);
  vm.regist_builtin_func("llvm.lifetime.end", BuiltinMemory::lifetime_end, 0);

  vm.regist_builtin_func("llvm.invariant.start", BuiltinMemory::invariant_start, 0);
  vm.regist_builtin_func("llvm.invariant.end", BuiltinMemory::invariant_end, 0);
}
}  // namespace processwarp
