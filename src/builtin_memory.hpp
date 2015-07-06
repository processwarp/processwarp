#pragma once

#include "definitions.hpp"

namespace processwarp {
  /**
   * メモリ利用マーク関連のLLVM組み込み関数。
   */
  class BuiltinMemory {
  public:
    /**
     * llvm.lifetime.start関数。
     * メモリに使用中マークを付ける。
     * srcから取り出すパラメタは以下のとおり。
     * i64 サイズ
     * i8* ポインタ
     */
    static BuiltinPost lifetime_start(VMachine& vm, Thread& th, BuiltinFuncParam p,
				      vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * llvm.lifetime.end関数。
     * メモリの使用中マークを外す。
     * srcから取り出すパラメタは以下のとおり。
     * i64 サイズ
     * i8* ポインタ
     */
    static BuiltinPost lifetime_end(VMachine& vm, Thread& th, BuiltinFuncParam p,
				    vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * llvm.invariant.start関数。
     * メモリの書き換え不能マークを付ける。
     * srcから取り出すパラメタは以下のとおり。
     * i64 サイズ
     * i8* ポインタ
     */
    static BuiltinPost invariant_start(VMachine& vm, Thread& th, BuiltinFuncParam p,
				       vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * llvm.invariant.end関数。
     * メモリの書き換え不能マークを外す。
     * srcから取り出すパラメタは以下のとおり。
     * i64 サイズ
     * i8* ポインタ
     */
    static BuiltinPost invariant_end(VMachine& vm, Thread& th, BuiltinFuncParam p,
				     vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * VMにライブラリを登録する。
     * @param vm 登録対象のVM
     */
    static void regist(VMachine& vm);
  };
}
