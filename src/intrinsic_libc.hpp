#pragma once

#include "definitions.hpp"

namespace usagi {
  /**
   * 標準Cライブラリのうち、LLVM組み込みとして用意するもの。
   */
  class IntrinsicLibc {
  public:
    /**
     * atexit関数。
     * 失敗時はerrnoを設定する仕様だが、その判定が無いため現在常に成功する。
     * srcから取り出すパラメタは以下のとおり。
     * vaddr_t func プログラム終了時に呼び出す関数
     * dstへ書き込む値は以下のとおり。
     * i32 成功時0 失敗時-1
     */
    static bool atexit(VMachine& vm, Thread& th, IntrinsicFuncParam p,
		       vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * exit関数。
     * srcから取り出すパラメタは以下のとおり。
     * i32 終了コード。
     */
    static bool exit(VMachine& vm, Thread& th, IntrinsicFuncParam p,
		     vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * memcpy関数。
     * srcから取り出すパラメタは以下のとおり。
     * vaddr_t dst コピー先。
     * vaddr_t src コピー元。
     * T len コピーサイズ。
     * int32_t align アライメント。
     * int8_t isvolation 実行順番の制約(VMでは実行順番を入れ替えないので無視する)。
     */
    static bool memcpy(VMachine& vm, Thread& th, IntrinsicFuncParam p,
		       vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * memmove関数。
     * srcから取り出すパラメタは以下のとおり。
     * vaddr_t dst 移動先。
     * vaddr_t src 移動元。
     * T len 移動サイズ。
     * int32_t align アライメント。
     * int8_t isvolation 実行順番の制約(VMでは実行順番を入れ替えないので無視する)。
     */
    static bool memmove(VMachine& vm, Thread& th, IntrinsicFuncParam p,
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
    static bool memset(VMachine& vm, Thread& th, IntrinsicFuncParam p,
		       vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * VMにライブラリを登録する。
     * @param vm 登録対象のVM
     */
    static void regist(VMachine& vm);
  };
}
