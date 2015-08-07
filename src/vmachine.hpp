#pragma once

#include <map>
#include <memory>
#include <string>
#include <vector>

#include "lib/picojson.h"

#include "process.hpp"
#include "vmemory.hpp"

namespace processwarp {
  /**
   * Delegate for VMachine-class.
   */
  class VMachineDelegate {
  public:
    /**
     * Destructor for virtual.
     */
    virtual ~VMachineDelegate();
    
    /**
     * Call when send data to other device.
     * @param pid Target pid.
     * @param dst Destination device-id.
     * @param data Load data.
     */
    virtual void send_machine_data(const vpid_t& pid,
				   const dev_id_t& dst,
				   const std::string& load) = 0;
    
    /**
     * Call when context switch of process.
     * @param pid Target pid. Empty (length == 0) when switch to controller's process.
     */
    virtual void on_switch_proccess(const vpid_t& pid);

    /**
     * Call when process was finish.
     * @param pid Target pid.
     */
    virtual void on_finish_proccess(const vpid_t& pid);

    /**
     * Call when a thread was finish.
     * @param pid Target pid.
     * @param tid Target tid.
     */
    virtual void on_finish_thread(const vpid_t& pid, const vtid_t& tid);

    /**
     * Call when rise error.
     * @param pid Target pid.
     * @param message Error message.
     */
    virtual void on_error(const vpid_t& pid,
			  const std::string& message) = 0;

    /**
     * Call when new process is arrive.
     * @param name Program name.
     * @param src_device
     * @param src_account
     */
    virtual bool judge_new_process(const std::string& name,
				   const dev_id_t& src_device,
				   const std::string& src_account) = 0;
  };
  
  /**
   * VMachine for set of processes.
   */
  class VMachine : private ProcessDelegate {
  public:
    /** This virtual machine's device-id. */
    const dev_id_t device_id;

    /**
     * Constractor with delegate.
     * @param delegate Events assignee.
     * @param memory_delegate 
     * @param device_id This virtual machine's device-id.
     * @param libs Loaded external libraries for ffi.
     * @param lib_filter Map of API name call from and call for that can access.
     */
    VMachine(VMachineDelegate& delegate,
	     VMemoryDelegate& memory_delegate,
	     const dev_id_t& device_id,
	     const std::vector<void*>& libs,
	     const std::map<std::string, std::string>& lib_filter);

    /**
     * Main loop.
     */
    void loop();
    
    /**
     * Pass data from other device.
     * @param pid Target pid.
     * @param data Received load data.
     */
    void recv_machine_data(const vpid_t& pid,
			   const std::string& data);
    
    /**
     * Create empty process.
     * @param pid New process's process-id.
     * @param root_tid Root thread-id.
     * @param addr 
     */
    void join_process(const vpid_t& pid, const vtid_t& root_tid,
		      vaddr_t proc_addr, const dev_id_t& master_dev_id);

    /**
     * Delete process.
     * @param pid Target pid.
     */
    void delete_process(const vpid_t& pid);

    /**
     * Start exiting process.
     * Resource remain after exit. Need to call delete_process after all.
     * @param pid Target pid.
     */
    void exit_process(const vpid_t& pid);

    /**
     * Get process instance by process-id.
     * @param pid Target process's id.
     * @return Process instance.
     */
    Process& get_process(const vpid_t& pid);

    /**
     * Check whether process has contain in this device.
     * @param pid Target process-id.
     * @return True if process has contain.
     */
    bool have_process(const vpid_t& pid);

    /**
     * Regist built-in function to virtual machine.
     * @param name Function name (if C++ name then demangled).
     * @param func Point to buint-in function bound name.
     * @param i64 Parameter to pass to builtin-function.
     */
    void regist_builtin_func(const std::string& name, builtin_func_t func, int i64);

    /**
     * Regist built-in function to virtual machine.
     * @param name Function name (if C++ name then demangled).
     * @param func Point to buint-in function bound name.
     * @param ptr Parameter to pass to builtin-function.
     */
    void regist_builtin_func(const std::string& name, builtin_func_t func, void* ptr);

    /**
     * Setup virtual machine.
     * Regist built-in function to virtual machine.
     */
    void setup_builtin();

    /**
     * Start warp process.
     * Resource remain after warp. Need to call delete_process after all.
     * @param pid Target pid.
     * @param tid Target thread-id.
     * @param dst_device_id Warp destination.
     */
    void warp_process(const vpid_t& pid,
		      const vtid_t& tid,
		      const dev_id_t& dst_device_id);

  protected:
    /**
     * @inheritDoc
     */
    std::unique_ptr<VMemory::Accessor> assign_accessor(const vpid_t& pid) override;

  private:
    /** Event assignee */
    VMachineDelegate& delegate;

  public:
    /** Virtual memory for this virtual machine. */
    VMemory vmemory;

  private:
    /** Loaded external libraries for ffi. */
    const std::vector<void*>& libs;
    /**
     * Map of API name call from and call for that can access.
     * Key:API nam call from application.
     * Value:API name call for OS.
     */
    const std::map<std::string, std::string>& lib_filter;

    /** Map of pid and process. */
    std::map<vpid_t, std::unique_ptr<Process>> procs;

    /** Map of API name and built-in function pointer and parameter. */
    std::map<std::string, std::pair<builtin_func_t, BuiltinFuncParam>> builtin_funcs;

    /** Map of pid and warp destination device-ids. */
    std::map<vpid_t, dev_id_t> warp_dest;

    /**
     * Dump and send data to warp process. 
     * @param pid Target pid.
     */
    void do_warp_process(const vpid_t& pid);

    void recv_warp(const vpid_t& pid, picojson::object& json);
  };
}
