#pragma once

#include <vector>

#include "process.hpp"
#include "types.hpp"
#include "vmachine.hpp"

namespace processwarp {
/**
 * 標準Cライブラリのうち、LLVM組み込みとして用意するもの。
 */
class BuiltinLibc {
 public:
  /**
   * atexit関数。
   * 失敗時はerrnoを設定する仕様だが、その判定が無いため現在常に成功する。
   * srcから取り出すパラメタは以下のとおり。
   * vaddr_t func プログラム終了時に呼び出す関数
   * dstへ書き込む値は以下のとおり。
   * i32 成功時0 失敗時-1
   */
  static BuiltinPostProc::Type atexit(Process& proc, Thread& thread, BuiltinFuncParam p,
                                      vaddr_t dst, std::vector<uint8_t>& src);

  /**
   * calloc関数。データ領域の確保とクリアを行う。
   * srcから取り出すパラメタは以下のとおり。
   * size_t count 要素数
   * size_t size 要素サイズ
   * 戻り値は以下のとおり。
   * void* 確保した領域のアドレス
   */
  static BuiltinPostProc::Type calloc(Process& proc, Thread& thread, BuiltinFuncParam p,
                                      vaddr_t dst, std::vector<uint8_t>& src);

  /**
   * exit関数。
   * srcから取り出すパラメタは以下のとおり。
   * i32 終了コード。
   */
  static BuiltinPostProc::Type exit(Process& proc, Thread& thread, BuiltinFuncParam p,
                                    vaddr_t dst, std::vector<uint8_t>& src);

  /**
   * free関数。指定データ領域を開放する。
   * srcから取り出すパラメタは以下のとおり。
   * vaddr_t ptr 開放するデータ領域。
   */
  static BuiltinPostProc::Type free(Process& proc, Thread& thread, BuiltinFuncParam p,
                                    vaddr_t dst, std::vector<uint8_t>& src);

  /**
   * longjmp関数。保存されたスタックコンテキストへの非局所的なジャンプ。
   * srcから取り出すパラメタは以下のとおり。
   * jmp_buf env
   * int val setjmpの返り値として戻す値。
   */
  static BuiltinPostProc::Type longjmp(Process& proc, Thread& thread, BuiltinFuncParam p,
                                       vaddr_t dst, std::vector<uint8_t>& src);

  /**
   * malloc関数。データ領域の確保を行う。
   * srcから取り出すパラメタは以下のとおり。
   * size_t size 領域サイズ
   * 戻り値は以下のとおり。
   * void* 確保した領域のアドレス
   */
  static BuiltinPostProc::Type malloc(Process& proc, Thread& thread, BuiltinFuncParam p,
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
  static BuiltinPostProc::Type memcpy(Process& proc, Thread& thread, BuiltinFuncParam p,
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
  static BuiltinPostProc::Type memmove(Process& proc, Thread& thread, BuiltinFuncParam p,
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
  static BuiltinPostProc::Type memset(Process& proc, Thread& thread, BuiltinFuncParam p,
                                      vaddr_t dst, std::vector<uint8_t>& src);

  /**
   * realloc関数。データ領域の再確保を行う。
   * srcから取り出すパラメタは以下のとおり。
   * vaddr_t ptr
   * size_t size 領域サイズ
   * 戻り値は以下のとおり。
   * void* 確保した領域のアドレス
   */
  static BuiltinPostProc::Type realloc(Process& proc, Thread& thread, BuiltinFuncParam p,
                                       vaddr_t dst, std::vector<uint8_t>& src);

  /**
   * setjmp関数。非局所的なジャンプのために、スタックコンテキストを保存する。
   * srcから取り出すパラメタは以下のとおり。
   * jmp_buf env
   * 戻り値は以下のとおり
   * int 直接の戻り値は0、longjmpが呼び出された場合はlongjmpの引数に渡した値。
   */
  static BuiltinPostProc::Type setjmp(Process& proc, Thread& thread, BuiltinFuncParam p,
                                      vaddr_t dst, std::vector<uint8_t>& src);

  /**
   * strtol関数。文字列を数値に変換する。
   * srcから取り出すパラメタは以下のとおり。
   * vaddr_t nptr
   * vaddr_t endptr
   * i32 base
   * 戻り値は以下のとおり
   * i64
   */
  static BuiltinPostProc::Type strtol(Process& proc, Thread& thread, BuiltinFuncParam p,
                                      vaddr_t dst, std::vector<uint8_t>& src);

  static BuiltinPostProc::Type time(Process& proc, Thread& thread, BuiltinFuncParam p,
                                    vaddr_t dst, std::vector<uint8_t>& src);

  /**
   * VMにライブラリを登録する。
   * @param vm 登録対象のVM
   */
  static void regist(VMachine& vm);
};
}  // namespace processwarp
