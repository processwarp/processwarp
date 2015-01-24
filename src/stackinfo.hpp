#pragma once

#include <vector>

#include "definitions.hpp"
#include "type_based.hpp"

namespace usagi {
  class FuncStore;
  class DataStore;
  class TypeStore;

  /**
   * 呼び出し階層クラス。
   */
  class StackInfo {
  public:
    /// 関数
    const vaddr_t func;
    /// 関数領域のキャッシュ
    FuncStore& func_cache;

    /// return格納先
    const vaddr_t ret_addr;

    /// unwindなしに関数が終了した場合にpcに設定する値
    const unsigned int normal_pc;
    /// unwindが発生した場合にpcに設定する値
    const unsigned int unwind_pc;

    /// スタック領域
    const vaddr_t stack;
    /// スタック領域のキャッシュ(実アドレスへのポインタ)
    DataStore& stack_cache;

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
    TypeBased* type_cache1;
    /// 操作対象の型のキャッシュ
    TypeStore* type_cache2;
    
    /// アライメント
    vm_int_t alignment;

    /// 格納先アドレス
    vaddr_t output;
    /// 格納先キャッシュ
    uint8_t* output_cache;

    /// 値レジスタ
    vaddr_t value;
    /// 値レジスタキャッシュ
    uint8_t* value_cache;

    /// アドレスレジスタ
    vaddr_t address;
    /// アドレスレジスタキャッシュ
    uint8_t* address_cache;

    /**
     * コンストラクタ。
     * @param func_ 関数
     * @param ret_addr_ return格納先
     * @param stack_ スタック領域
     */
    StackInfo(FuncStore& func_,
	      vaddr_t ret_addr_,
	      unsigned int normal_pc_,
	      unsigned int unwind_pc_,
	      DataStore& stack_);
  };
}
