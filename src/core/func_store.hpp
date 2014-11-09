#pragma once

#include <map>
#include <memory>

#include "definitions.hpp"
#include "symbols.hpp"
#include "value.hpp"

namespace usagi {
  /**
   * 関数クラス。
   */
  class FuncStore {
  public:
    /// 可変長引数かどうか
    bool is_var_arg;
    /// 引数の数
    unsigned int arg_num;
    /// 関数で利用する変数の数
    unsigned int  val_num;
    /// 命令配列
    std::unique_ptr<instruction_t[]> code;
    /// 定数
    std::unique_ptr<Value[]> k;

    /**
     * コンストラクタ。
     */
    FuncStore();
  };
}
