#pragma once

#include "definitions.hpp"

namespace usagi {
  /**
   * 呼び出し階層クラス。
   */
  class CallInfo {
  public:
    /** 呼び出した関数のスタック上の位置(絶対) */
    unsigned int func;
    /** スタックトップ(絶対) */
    unsigned int top;

    /** 戻り値の設定先 */
    unsigned int pos_ret;

    /** スタックベース */
    unsigned int base;
    /** プログラムカウンタ */
    unsigned int saved_pc;
  };
}
