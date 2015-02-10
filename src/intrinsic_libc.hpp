#pragma once

#include "definitions.hpp"

namespace usagi {
  /**
   * 標準Cライブラリのうち、LLVM組み込みとして用意するもの。
   */
  class IntrinsicLibc {
  public:
    /**
     * memcpy関数。
     * srcから取り出すパラメタは以下のとおり。
     * vaddr_t dst コピー先。
     * vaddr_t src コピー元。
     * T len コピーサイズ。
     * int32_t align アライメント。
     * int8_t isvolation 実行順番の制約(VMでは実行順番を入れ替えないので無視する)。
     */
    static void memcpy(VMachine& vm, Thread& th, IntrinsicFuncParam p,
		       vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * memset関数。
     * srcから取り出すパラメタは以下のとおり。
     * vaddr_t dst 設定先。
     * i8 val 設定値。
     * T len 設定サイズ。
     * int32_t align アライメント。
     * int8_t isvolation 実行順番の制約(VMでは実行順番を入れ替えないので無視する)。
     */
    static void memset(VMachine& vm, Thread& th, IntrinsicFuncParam p,
		       vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * VMにライブラリを登録する。
     * @param vm 登録対象のVM
     */
    static void regist(VMachine& vm);
  };
}
