#pragma once

#include <vector>

#include "process.hpp"
#include "types.hpp"
#include "vmachine.hpp"

namespace processwarp {
class BuiltinOverflow {
 public:
  /**
   * overflowが検出可能な符号あり加算関数。
   * srcから取り出すパラメタは以下のとおり。
   * T a
   * T b
   * 戻り値は以下のとおり。
   * T 計算結果
   * i1 overflowを検出した場合1が設定される
   */
  static BuiltinPostProc::Type sadd(Process& proc, Thread& thread, BuiltinFuncParam p,
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
  static BuiltinPostProc::Type smul(Process& proc, Thread& thread, BuiltinFuncParam p,
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
  static BuiltinPostProc::Type ssub(Process& proc, Thread& thread, BuiltinFuncParam p,
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
  static BuiltinPostProc::Type uadd(Process& proc, Thread& thread, BuiltinFuncParam p,
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
  static BuiltinPostProc::Type umul(Process& proc, Thread& thread, BuiltinFuncParam p,
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
  static BuiltinPostProc::Type usub(Process& proc, Thread& thread, BuiltinFuncParam p,
                                    vaddr_t dst, std::vector<uint8_t>& src);

  /**
   * VMにライブラリを登録する。
   * @param vm 登録対象のVM
   */
  static void regist(VMachine& vm);
};
}  // namespace processwarp
