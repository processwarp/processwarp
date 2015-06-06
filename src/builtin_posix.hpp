#pragma once

#include "definitions.hpp"

namespace processwarp {
  /**
   * POSIXライブラリのうち、LLVM組み込みとして用意するもの。
   */
  class BuiltinPosix {
  public:
    /**
     * __assert_fail(assertの内部実装)関数。
     * srcから取り出すパラメタは以下のとおり。
     * vaddr_t(const) assertion
     * vaddr_t(const) file
     * i32 line
     * vaddr_t(const) function
     */
    static bool __assert_fail(VMachine& vm, Thread& th, BuiltinFuncParam p,
			      vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * VMにライブラリを登録する。
     * @param vm 登録対象のVM
     */
    static void regist(VMachine& vm);
  };
}
