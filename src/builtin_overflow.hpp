#pragma once

#include "definitions.hpp"

namespace processwarp {
  class BuiltinOverflow {
  public:
    /**
     * VMにライブラリを登録する。
     * @param vm 登録対象のVM
     */
    static void regist(VMachine& vm);

    /**
     * overflowが検出可能な符号あり加算関数。
     * srcから取り出すパラメタは以下のとおり。
     * T a
     * T b
     * 戻り値は以下のとおり。
     * T 計算結果
     * i1 overflowを検出した場合1が設定される
     */
    static BuiltinPost sadd(VMachine& vm, Thread& th, BuiltinFuncParam p,
			    vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * overflowが検出可能な符号あり乗算関数。
     * srcから取り出すパラメタは以下のとおり。
     * T a
     * T b
     * 戻り値は以下のとおり。
     * T 計算結果
     * i1 overflowを検出した場合1が設定される
     */
    static BuiltinPost smul(VMachine& vm, Thread& th, BuiltinFuncParam p,
			    vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * overflowが検出可能な符号あり減算関数。
     * srcから取り出すパラメタは以下のとおり。
     * T a
     * T b
     * 戻り値は以下のとおり。
     * T 計算結果
     * i1 overflowを検出した場合1が設定される
     */
    static BuiltinPost ssub(VMachine& vm, Thread& th, BuiltinFuncParam p,
			    vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * overflowが検出可能な符号なし加算関数。
     * srcから取り出すパラメタは以下のとおり。
     * T a
     * T b
     * 戻り値は以下のとおり。
     * T 計算結果
     * i1 overflowを検出した場合1が設定される
     */
    static BuiltinPost uadd(VMachine& vm, Thread& th, BuiltinFuncParam p,
			    vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * overflowが検出可能な符号なし乗算関数。
     * srcから取り出すパラメタは以下のとおり。
     * T a
     * T b
     * 戻り値は以下のとおり。
     * T 計算結果
     * i1 overflowを検出した場合1が設定される
     */
    static BuiltinPost umul(VMachine& vm, Thread& th, BuiltinFuncParam p,
			    vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * overflowが検出可能な符号なし減算関数。
     * srcから取り出すパラメタは以下のとおり。
     * T a
     * T b
     * 戻り値は以下のとおり。
     * T 計算結果
     * i1 overflowを検出した場合1が設定される
     */
    static BuiltinPost usub(VMachine& vm, Thread& th, BuiltinFuncParam p,
			    vaddr_t dst, std::vector<uint8_t>& src);
  };
}
