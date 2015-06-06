#pragma once

#include "definitions.hpp"

namespace processwarp {
  /**
   *
   */
  class BuiltinBit {
  public:
    /**
     * byte-swap関数。
     * srcから取り出すパラメタは以下のとおり。
     * T 変換元の数値。
     */
    static bool bswap(VMachine& vm, Thread& th, BuiltinFuncParam p,
		      vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * VMにライブラリを登録する。
     * @param vm 登録対象のVM
     */
    static void regist(VMachine& vm);
  };
}
