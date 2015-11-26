#pragma once

#include <vector>

#include "definitions.hpp"
#include "process.hpp"
#include "vmachine.hpp"

namespace processwarp {
/**
 * LLVM built-in bit manipulation operations.
 * @see <a href="http://llvm.org/docs/LangRef.html#bit-manipulation-intrinsics">LLVM Language Reference Manual</a>
 */
class BuiltinBit {
 public:
  /**
   * byte-swap関数。
   * srcから取り出すパラメタは以下のとおり。
   * T 変換元の数値。
   */
  static BuiltinPostProc::Type bswap(Process& proc, Thread& thread,
                                     BuiltinFuncParam p, vaddr_t dst,
                                     std::vector<uint8_t>& src);

  /**
   * VMにライブラリを登録する。
   * @param vm 登録対象のVM
   */
  static void regist(VMachine& vm);
};
}  // namespace processwarp
