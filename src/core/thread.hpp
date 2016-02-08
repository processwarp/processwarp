#pragma once

#include <picojson.h>

#include <vector>
#include <map>
#include <memory>
#include <utility>

#include "definitions.hpp"
#include "stackinfo.hpp"
#include "type_store.hpp"
#include "wrapped_operator.hpp"

namespace processwarp {
/**
 * Structure of thread.
 */
class Thread {
 public:
  /// Type of function list that will be called at befor or/and after warp.
  typedef std::vector<vaddr_t> FuncsAtWarp;
  /// Type of warp parameter.
  typedef std::map<vm_int_t, vm_int_t> WarpParameter;

  /** status of vm */
  enum Status : uint8_t {
    NORMAL,

        WAIT_WARP,
        BEFOR_WARP,
        WARP,
        AFTER_WARP,

        JOIN_WAIT,
        ERROR,
        FINISH,
        };

  /// thread-id
  const vtid_t tid;
  /** Accessor to binded memory */
  std::unique_ptr<VMemory::Accessor> memory;
  /** */
  WrappedComplexOperator complex_operator;
  /** */
  nid_t owner;
  /// status of vm
  Status status;
  /// thread-id to join(0:none, 1:detached)
  vtid_t join_waiting;

  /// information of call stack
  std::map<vaddr_t, std::unique_ptr<StackInfo>> stackinfos;
  std::vector<vaddr_t> stack;

  /// Functions that will be called at befor warp.
  FuncsAtWarp funcs_at_befor_warp;
  /// Functions that will be called at after warp.
  FuncsAtWarp funcs_at_after_warp;
  /// Warp parameter
  WarpParameter warp_parameter;

  /// stack size when befor warp
  vm_uint_t warp_stack_size;
  vm_uint_t warp_call_count;
  ///
  nid_t warp_dst;

  WrappedOperator* const OPERATORS[0x36];

  /**
   * Allocate thread on memory.
   * @param memory
   */
  static std::pair<vtid_t, std::unique_ptr<Thread>>
      alloc(std::unique_ptr<VMemory::Accessor> memory, vtid_t tid = VADDR_NULL);

  /**
   * Read out thread information from memory.
   * @param addr
   * @param memory
   */
  static std::unique_ptr<Thread> read(vtid_t tid,
                                      std::unique_ptr<VMemory::Accessor> memory);

  /**
   * Read out and update thread information on instance.
   */
  void read();

  /**
   * Write out thread information to memory.
   */
  void write();

  /**
   * 型依存の演算インスタンスを取得する。
   * @param type 方に割り当てたアドレス。
   * @return 型依存の演算インスタンス。
   */
  WrappedOperator* get_operator(vaddr_t type);

  /**
   * Get stack-information by index of stack.
   * If idx is negative, idx is stack's top + idx (stack top is -1).
   * @param idx
   * @return A instance of stack-information.
   */
  StackInfo& get_stackinfo(int idx);

  /**
   * Remoev stack-information at stack top.
   */
  void pop_stack();

  /**
   * Push new stack-information at stack top (without instance).
   * @param addr Address stack-information assigned.
   */
  void push_stack(vaddr_t addr);

  /**
   * Push new stack-information at stack top (with instance).
   * @param addr Address stack-information assigned.
   * @param top
   */
  void push_stack(vaddr_t addr, std::unique_ptr<StackInfo> top);

  /**
   * Prepare to warp out.
   */
  void setup_warpout();

  bool require_warp(const nid_t& target_nid);

 private:
  /**
   * Constructor with thread-id.
   * @param addr Address of thread data.
   * @param tid Thread-id of this thread.
   * @param memory 
   */
  Thread(vtid_t tid, std::unique_ptr<VMemory::Accessor> memory);
};
}  // namespace processwarp
