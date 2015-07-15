#pragma once

#include <memory>
#include <vector>

#include "definitions.hpp"
#include "func_store.hpp"
#include "type_store.hpp"
#include "wrapped_operator.hpp"

namespace processwarp {
  /**
   * 呼び出し階層クラス。
   */
  class StackInfo {
  public:
    /// 関数
    const vaddr_t func;
    /// 関数領域のキャッシュ
    std::unique_ptr<FuncStore> func_store;

    /// return格納先
    const vaddr_t ret_addr;

    /// unwindなしに関数が終了した場合にpcに設定する値
    const unsigned int normal_pc;
    /// unwindが発生した場合にpcに設定する値
    const unsigned int unwind_pc;

    /// スタック領域
    const vaddr_t stack;

    /// allocaで確保された領域
    std::vector<vaddr_t> alloca_addrs;

    /// 可変長引数を格納した領域アドレス
    vaddr_t var_arg;

    /// プログラムカウンタ
    unsigned int pc;
    /// φ動作用カウンタ
    unsigned int phi0;
    unsigned int phi1;

    /// 操作対象の型
    vaddr_t type;
    /// 操作対象の型のキャッシュ
    WrappedOperator* type_operator;
    /// 操作対象の型のキャッシュ
    std::unique_ptr<TypeStore> type_store;
    
    /// アライメント
    vm_int_t alignment;

    /// 格納先アドレス
    vaddr_t output;

    /// 値レジスタ
    vaddr_t value;

    /// アドレスレジスタ
    vaddr_t address;

    /**
     * コンストラクタ。
     * @param func_ 関数
     * @param ret_addr_ return格納先
     * @param normal_pc_ unwindなしに関数が終了した場合にpcに設定する値
     * @param unwind_pc_ unwindが発生した場合にpcに設定する値
     * @param stack_ スタック領域
     */
    StackInfo(vaddr_t func_,
	      vaddr_t ret_addr_,
	      unsigned int normal_pc_,
	      unsigned int unwind_pc_,
	      vaddr_t stack_);

  };
}
