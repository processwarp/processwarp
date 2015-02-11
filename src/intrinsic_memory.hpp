#pragma once

#include "definitions.hpp"

namespace usagi {
  /**
   * メモリ利用マーク関連のLLVM組み込み関数。
   */
  class IntrinsicMemory {
  public:
    /**
     * llvm.lifetime.start関数。
     * メモリに使用中マークを付ける。
     * srcから取り出すパラメタは以下のとおり。
     * i64 サイズ
     * i8* ポインタ
     */
    static bool lifetime_start(VMachine& vm, Thread& th, IntrinsicFuncParam p,
			       vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * llvm.lifetime.end関数。
     * メモリの使用中マークを外す。
     * srcから取り出すパラメタは以下のとおり。
     * i64 サイズ
     * i8* ポインタ
     */
    static bool lifetime_end(VMachine& vm, Thread& th, IntrinsicFuncParam p,
			     vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * llvm.invariant.start関数。
     * メモリの書き換え不能マークを付ける。
     * srcから取り出すパラメタは以下のとおり。
     * i64 サイズ
     * i8* ポインタ
     */
    static bool invariant_start(VMachine& vm, Thread& th, IntrinsicFuncParam p,
				vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * llvm.invariant.end関数。
     * メモリの書き換え不能マークを外す。
     * srcから取り出すパラメタは以下のとおり。
     * i64 サイズ
     * i8* ポインタ
     */
    static bool invariant_end(VMachine& vm, Thread& th, IntrinsicFuncParam p,
			      vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * VMにライブラリを登録する。
     * @param vm 登録対象のVM
     */
    static void regist(VMachine& vm);
  };
}
