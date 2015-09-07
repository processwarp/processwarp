#pragma once

#include <map>
#include <memory>
#include <string>
#include <queue>
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
				   const std::string& data) = 0;
    
    /**
     * Call when change process and thread status running on this virtual machine.
     * @param procs
     */
    virtual void send_sync_proc_list(const std::vector<ProcessTree>& procs) = 0;

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

    /**
     * Call when get login account information.
     */
    virtual std::string get_account() = 0;
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
     * Tell memory is update by other node.
     * @param pid Target process.
     * @param addr Updated page address.
     */
    void on_recv_update(const vpid_t& pid, vaddr_t addr);
    
    /**
     * Pass data from other device.
     * @param pid Target pid.
     * @param data Received load data.
     */
    void recv_machine_data(const vpid_t& pid,
			   const std::string& data);

    /**
     * Call when recv sync proc list message from server.
     */
    void recv_sync_proc_list(const std::vector<ProcessTree>& procs);
    
    /**
     * Create empty process.
     * @param pid New process's process-id.
     * @param root_tid Root thread-id.
     * @param addr 
     */
    void join_process(const vpid_t& pid, const vtid_t& root_tid,
		      vaddr_t proc_addr, const dev_id_t& master_dev_id);

    /**
     * Change status of process in order to terminate.
     * After terminate process, resources of process are free automatic.
     * @param pid Target pid.
     */
    void terminate_process(const vpid_t& pid);

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
     * Make new process-tree and send to server.
     */
    void update_proc_list();

    /**
     * Change thread status to warp thread.
     * @param pid Target process-id.
     * @param tid Target thread-id.
     * @param dst_device Warp destination device-id.
     */
    void request_warp_thread(const vpid_t& pid,
			     const vtid_t tid,
			     const dev_id_t& dst_device);

  protected:
    /**
     * @inheritDoc
     */
    std::unique_ptr<VMemory::Accessor> assign_accessor(const vpid_t& pid) override;

    /**
     */
    void on_change_thread_set(Process& proc) override;

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

    /** */
    std::queue<std::pair<vpid_t, vtid_t>> loop_queue;

    /**
     * Change flag to FINISH for all defunct thread.
     * @param sv_procs
     */
    void kill_defunct_thread(const std::vector<ProcessTree>& sv_procs);

    /**
     * Delete process if active-threads in this node were not exist.
     * @param sv_procs
     */
    void clean_defunct_processe(const std::vector<ProcessTree>& sv_procs);

    /*
     * Delete memory space if process in all nodes was not exist.
     * @param sv_procs
     */
    void clean_defunct_memoryspace(const std::vector<ProcessTree>& sv_procs);

    /**
     * Convert json to machine data packet and send to destination device.
     * @param name
     * @param dst_device
     * @param cmd
     * @param data
     */
    void send_packet(const std::string& name, const dev_id_t& dst_device,
		     const std::string& cmd, picojson::object& data);

    void recv_warp(const vpid_t& pid, picojson::object& json);

    /**
     * If recv this packet and this device contain target process and thread,
     * change status to warp thread.
     * @param pid
     * @param json
     */
    void recv_warp_request(const vpid_t& pid, picojson::object& json);


    /**
     * If recv this packet and this node have root-thread of target process,
     * Change status of root-thread in order to terminate process.
     */
    void recv_terminate(const vpid_t& pid, picojson::object& json);

    /**
     * This request means to warp thread to target device.
     * This method regist thread-id to pool and loop method check
     * target thread's status to change.
     * @param proc
     * @param thread
     */
    void send_warp(Process& proc, Thread& thread);
    
    /**
     * This request means to broadcast request of warp a thread.
     * @param pid
     * @param tid
     * @param dst_device
     */
    void send_warp_request(const vpid_t& pid, const vtid_t tid,
			   const dev_id_t& dst_device);

    /**
     * This request means to broadcast request of terminateing process.
     * @param pid Target process-id.
     */
    void send_terminate(const vpid_t& pid);
  };
}
