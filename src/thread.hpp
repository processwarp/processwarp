#pragma once

#include <vector>
#include <map>
#include <memory>

#include "definitions.hpp"
#include "lib/picojson.h"
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
    enum Status : uint8_t {
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
    const vtid_t tid;
    /** Accessor to binded memory */
    std::unique_ptr<VMemory::Accessor> memory;
    /** */
    WrappedComplexOperator complex_operator;
    /** */
    dev_id_t owner;
    /// status of vm
    Status status;
    /// thread-id to join(0:none, 1:detached)
    vtid_t join_waiting;

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
    void update_info();
    
    /**
     * 型依存の演算インスタンスを取得する。
     * @param type 方に割り当てたアドレス。
     * @return 型依存の演算インスタンス。
     */
    WrappedOperator* get_operator(vaddr_t type);

    /**
     * Write out thread data to memory.
     */
    void write_out();

  private:
    /**
     * Constructor with thread-id.
     * @param addr Address of thread data.
     * @param tid Thread-id of this thread.
     * @param memory 
     */
    Thread(vtid_t tid, std::unique_ptr<VMemory::Accessor> memory);
  };
}
