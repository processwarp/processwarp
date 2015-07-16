#pragma once

#include <vector>
#include <map>
#include <memory>

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
    /// information of call stack
    typedef std::vector<std::unique_ptr<StackInfo>> StackInfos;
    /// Type of function list that will be called at befor or/and after warp.
    typedef std::vector<vaddr_t> FuncsAtWarp;
    /// Type of warp parameter.
    typedef std::map<vm_int_t, vm_int_t> WarpParameter;

    /** status of vm */
    enum Status {
      NORMAL,
      PASSIVE,

      WAIT_WARP,
      BEFOR_WARP,
      WARP,
      AFTER_WARP,

      JOIN_WAIT,
      ERROR,
      FINISH,
    };

    /// thread-id
    vtid_t tid;
    /// status of vm
    Status status;
    /** Accessor to binded memory */
    std::unique_ptr<VMemory::Accessor> memory;
    /// information of call stack
    StackInfos stackinfos;
    /// Functions that will be called at befor warp.
    FuncsAtWarp funcs_at_befor_warp;
    /// Functions that will be called at after warp.
    FuncsAtWarp funcs_at_after_warp;
    /// Warp parameter
    WarpParameter warp_parameter;

    /// stack size when befor warp
    vm_uint_t warp_stack_size;
    vm_uint_t warp_call_count;
    
    static const vtid_t JOIN_NONE       = 0x0;
    static const vtid_t DETACHED_THREAD = 0x1;
    static const vtid_t ROOT_THREAD     = 0xF;

    /// thread-id to join(0:none, 1:detached)
    vtid_t join_waiting;

    WrappedComplexOperator complex_operator;

    WrappedOperator* const OPERATORS[0x36];

    /**
     * Constructor with thread-id.
     * @param tid Thread-id of this thread.
     * @param memory 
     */
    Thread(vtid_t tid, std::unique_ptr<VMemory::Accessor> memory);

    /**
     * 型依存の演算インスタンスを取得する。
     * @param type 方に割り当てたアドレス。
     * @return 型依存の演算インスタンス。
     */
    WrappedOperator* get_operator(vaddr_t type);
  };
}
