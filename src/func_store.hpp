#pragma once

#include <memory>
#include <vector>

#include "definitions.hpp"
#include "symbols.hpp"
#include "vmemory.hpp"

namespace processwarp {
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
    const builtin_func_t builtin;
    /// 組み込み関数に渡す固定パラメータ
    const BuiltinFuncParam builtin_param;

    // ライブラリなど外部の関数の場合利用するメンバ
    /// ライブラリなど外部の関数のポインタ
    external_func_t external;

    /**
     * Allocate a new normal function to memory.
     * @param memory The memory to allocate.
     * @param addr address to allocate.
     * @param name Function name.
     * @param ret_type Type of return value.
     * @param arg_num Number of argument.
     * @param is_var_arg True if be variable-length argument.
     * @param normal_prop Properties of normal function.
     */
    static void alloc_normal(VMemory::Accessor& memory,
			     vaddr_t addr,
			     const Symbols::Symbol& name,
			     vaddr_t ret_type,
			     unsigned int arg_num,
			     bool is_var_arg,
			     const NormalProp& normal_prop);

    /**
     * Allocate a new external function to memory.
     * @param memory The memory to allocate.
     * @param addr Address to allocate.
     * @param name Function name.
     * @param ret_type Type of return value.
     * @param arg_num Number of argument.
     * @param is_var_arg True if be variable-length argument.
     */
    static void alloc_external(VMemory::Accessor& memory,
			       vaddr_t addr,
			       const Symbols::Symbol& name,
			       vaddr_t ret_type,
			       unsigned int arg_num,
			       bool is_var_arg);

    /**
     * Read out function information from memory.
     * @param proc Process using function information.
     * @param addr Address saving function infromation.
     * @return Function information.
     */
    static std::unique_ptr<FuncStore> read(Process& proc, vaddr_t addr);

  private:
    /**
     *
     */
    FuncStore(vaddr_t addr,
	      FuncType type,
	      const Symbols::Symbol& name,
	      vaddr_t ret_type,
	      unsigned int arg_num,
	      bool is_var_arg,
	      const NormalProp& normal_prop,
	      const builtin_func_t& builtin,
	      const BuiltinFuncParam& builtin_param);
  };
}
