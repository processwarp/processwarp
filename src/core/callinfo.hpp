#pragma once

#include <vector>

#include "definitions.hpp"
#include "value.hpp"

namespace usagi {
  /**
   * 呼び出し階層クラス。
   */
  class CallInfo {
  public:
    /** 呼び出した関数のスタック上の位置(絶対) */
    unsigned int func;
    /** スタックトップ(絶対) */
    //unsigned int top;

    /** 戻り値の設定先(絶対) */
    unsigned int pos_ret;

    /** スタックベース(絶対) */
    unsigned int base;

    /** プログラムカウンタ */
    unsigned int pc;

    /** 可変長引数 */
    std::vector<Value> var_arg;
  };
}
