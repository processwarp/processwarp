#pragma once

#include "definitions.hpp"
#include "process.hpp"

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
    static BuiltinPost bswap(Process& proc, Thread& th, BuiltinFuncParam p,
			     vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * VMにライブラリを登録する。
     * @param vm 登録対象のVM
     */
    static void regist(Process& vm);
  };
}
