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
    /** スタックトップ(絶対) */
    //unsigned int top;

    /** 戻り値の設定先(絶対) */
    unsigned int pos_ret;

    /** スタックベース(絶対) */
    unsigned int base;

    /** プログラムカウンタ */
    unsigned int pc;

    /** 最終jump位置 */
    unsigned int phi;

    /** 可変長引数 */
    std::vector<Value> var_arg;
  };
}
