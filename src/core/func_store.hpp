#pragma once

#include <vector>

#include "definitions.hpp"
#include "symbols.hpp"
#include "value.hpp"

namespace usagi {
  /**
   * 関数クラス。
   */
  class FuncStore {
  public:
    /// 通常の関数で利用するメンバ
    struct NormalProp {
      /// 可変長引数かどうか
      bool is_var_arg;
      /// 引数の数
      unsigned int arg_num;
      /// 関数で利用する変数の数
      unsigned int val_num;
      /// 命令配列
      std::vector<instruction_t> code;
      /// 定数配列
      std::vector<Value> k;
    };

    /// 関数のタイプ
    const FuncType type;
    /// 関数名称
    const Symbols::Symbol& name;

    /// 通常の関数で利用するメンバ
    const NormalProp normal_prop;
    
    // VM組み込み関数で利用するメンバ
    /// VM組み込み関数のポインタ
    const intrinsic_func_t intrinsic;

    // ライブラリなど外部の関数の場合利用するメンバ
    /// ライブラリなど外部の関数のポインタ
    external_func_t external;

    /**
     * 通常の関数のコンストラクタ。
     * @param name_ 関数名称
     * @param normal_prop_ 通常の関数のプロパティ
     */
    FuncStore(const Symbols::Symbol& name_,
	      const NormalProp& normal_prop_);

    /**
     * VM組み込み関数のコンストラクタ。
     * @param name_ 関数名称
     * @param intrinsic_ VM組み込み関数へのポインタ
     */
    FuncStore(const Symbols::Symbol& name_,
	      const intrinsic_func_t intrinsic_);

    /**
     * 外部の関数のコンストラクタ。
     */
    FuncStore(const Symbols::Symbol& name_);
  };
}
