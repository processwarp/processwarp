#pragma once

#include <memory>
#include <vector>

#include "func_store.hpp"
#include "type_store.hpp"
#include "types.hpp"
#include "wrapped_operator.hpp"

namespace processwarp {
/**
 * 呼び出し階層クラス。
 */
class StackInfo {
 public:
  const vaddr_t addr;
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
   * Allocate a now stack-information on memory.
   * @param memory
   * @param func
   * @param ret_addr
   * @param normal_pc
   * @Param unwind_pc
   * @param stack
   * @return A address stack-information assigned.
   */
  static vaddr_t alloc(VMemory::Accessor& memory,
                       vaddr_t func,
                       vaddr_t ret_addr,
                       unsigned int normal_pc,
                       unsigned int unwind_pc,
                       vaddr_t stack);

  /**
   * Read out stack-informaition from memory and generate instance.
   * @param memory
   * @param addr
   * @return A instance generate by memory.
   */
  static std::unique_ptr<StackInfo> read(VMemory::Accessor& memory, vaddr_t addr);

  /**
   * Read and update stack-information for this instance.
   * @param memory
   */
  void read(VMemory::Accessor& memory);

  /**
   * Write out stack-information to memory.
   * @param memory
   */
  void write(VMemory::Accessor& memory);

  /**
   * Free all memory area bind to this stack without a area bind to this instance.
   * @param memory
   */
  void destroy(VMemory::Accessor& memory);

 private:
  /**
   * コンストラクタ。
   * @param addr
   * @param func 関数
   * @param ret_addr return格納先
   * @param normal_pc unwindなしに関数が終了した場合にpcに設定する値
   * @param unwind_pc unwindが発生した場合にpcに設定する値
   * @param stack_ スタック領域
   */
  StackInfo(vaddr_t addr,
            vaddr_t func,
            vaddr_t ret_addr,
            unsigned int normal_pc,
            unsigned int unwind_pc,
            vaddr_t stack);

  /**
   * Read and update stack-information for this instance.
   * @param js_stackinfo
   */
  void read(const picojson::object& js_object);
};
}  // namespace processwarp
