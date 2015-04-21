#pragma once

#include <vector>

#include "definitions.hpp"
#include "symbols.hpp"

namespace usagi {
  /**
   * 関数クラス。
   */
  class FuncStore {
  public:
    /// 通常の関数で利用するメンバ
    struct NormalProp {
      /// 関数で利用するスタックサイズ
      unsigned int stack_size;
      /// 命令配列
      std::vector<instruction_t> code;
      /// 定数領域
      vaddr_t k;
    };

    /// アドレス
    const vaddr_t addr;
    /// 関数のタイプ
    const FuncType type;
    /// 関数名称
    const Symbols::Symbol& name;
    /// 戻り値の型
    const vaddr_t ret_type;
    /// 引数の数
    const unsigned int arg_num;
    /// 可変長引数かどうか
    const bool is_var_arg;

    /// 通常の関数で利用するメンバ
    const NormalProp normal_prop;
    
    // VM組み込み関数で利用するメンバ
    /// VM組み込み関数のポインタ
    const intrinsic_func_t intrinsic;
    /// 組み込み関数に渡す固定パラメータ
    const IntrinsicFuncParam intrinsic_param;

    // ライブラリなど外部の関数の場合利用するメンバ
    /// ライブラリなど外部の関数のポインタ
    external_func_t external;

    /**
     * 通常の関数のコンストラクタ。
     * @param addr_ 割り当てアドレス
     * @param name_ 関数名称
     * @param ret_type_ 戻り値の型
     * @param arg_num_ 引数の数
     * @param is_var_arg_ 可変長引数かどうか
     * @param normal_prop_ 通常の関数のプロパティ
     */
    FuncStore(vaddr_t addr_,
	      const Symbols::Symbol& name_,
	      vaddr_t ret_type_,
	      unsigned int arg_num_,
	      bool is_var_arg_,
	      const NormalProp& normal_prop_);

    /**
     * VM組み込み関数のコンストラクタ。
     * @param addr_ 割り当てアドレス
     * @param name_ 関数名称
     * @param ret_type_ 戻り値の型
     * @param arg_num_ 引数の数
     * @param is_var_arg_ 可変長引数かどうか
     * @param intrinsic_ VM組み込み関数へのポインタ
     * @param intrinsic_param_ VM組み込み関数へ渡す固定パラメタ
     */
    FuncStore(vaddr_t addr_,
	      const Symbols::Symbol& name_,
	      vaddr_t ret_type_,
	      unsigned int arg_num_,
	      bool is_var_arg_,
	      const intrinsic_func_t intrinsic_,
	      const IntrinsicFuncParam intrinsic_param_);

    /**
     * 外部の関数のコンストラクタ。
     * @param addr_ 割り当てアドレス
     * @param name_ 関数名称
     * @param ret_type_ 戻り値の型
     * @param arg_num_ 引数の数
     * @param is_var_arg_ 可変長引数かどうか
     */
    FuncStore(vaddr_t addr_,
	      const Symbols::Symbol& name_,
	      vaddr_t ret_type_,
	      unsigned int arg_num_,
	      bool is_var_arg_);
  };
}
