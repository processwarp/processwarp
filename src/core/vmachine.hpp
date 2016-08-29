#pragma once

#include <picojson.h>

#include <map>
#include <memory>
#include <queue>
#include <string>
#include <utility>
#include <vector>

#include "dynamic_library.hpp"
#include "packet.hpp"
#include "process.hpp"
#include "vmemory.hpp"

namespace processwarp {
class BuiltinGuiDelegate;
class VMachine;

/**
 * Delegate for VMachine-class.
 */
class VMachineDelegate {
 public:
  virtual ~VMachineDelegate();

  virtual void vmachine_on_invoke_thread(VMachine& vm, vtid_t tid) = 0;
  virtual void vmachine_finish(VMachine& vm) = 0;
  virtual void vmachine_error(VMachine& vm, const std::string& message) = 0;
  virtual void vmachine_send_packet(VMachine& vm, const Packet& packet) = 0;
};

/**
 * VMachine for set of processes.
 */
class VMachine : private ProcessDelegate, public PacketControllerDelegate {
 public:
  /** VMachine's node-id. */
  const NodeID my_nid;
  /** Virtual memory for this virtual machine. */
  VMemory vmemory;

  VMachine(VMachineDelegate& delegate_,
           VMemoryDelegate& memory_delegate,
           const NodeID& my_nid_,
           const std::vector<DynamicLibrary::lib_handler_t>& libs_,
           const std::map<std::string, std::string>& lib_filter_);
  void initialize(const vpid_t& pid, const vtid_t& root_tid, vaddr_t proc_addr,
                  const std::string& name);
  void execute(vtid_t tid);
  void heartbeat();
  void recv_packet(const Packet& packet);
  Process& get_process();
  void regist_builtin_func(const std::string& name, builtin_func_t func, int i64);
  void regist_builtin_func(const std::string& name, builtin_func_t func, void* ptr);

  std::unique_ptr<VMemory::Accessor> process_assign_accessor(const vpid_t& pid) override;
  void process_change_thread_set(Process& process) override;
  void process_on_invoke_thread(Process& process, vtid_t tid) override;

 private:
  Lock::Mutex mutex_execute;
  /** Event assignee */
  VMachineDelegate& delegate;
  /** Loaded external libraries for ffi. */
  const std::vector<DynamicLibrary::lib_handler_t>& libs;
  /**
   * Map of API name call from and call for that can access.
   * Key:API nam call from application.
   * Value:API name call for OS.
   */
  const std::map<std::string, std::string>& lib_filter;
  /** Process instance. */
  std::unique_ptr<Process> process;
  /** Map of API name and built-in function pointer and parameter. */
  std::map<std::string, std::pair<builtin_func_t, BuiltinFuncParam>> builtin_funcs;

  PacketController packet_controller;

  void initialize_builtin();

  void packet_controller_on_recv(const Packet& packet) override;
  void packet_controller_send(const Packet& packet) override;

  /// @todo Clean up unused thread information.
  void recv_command_heartbeat_vm(const Packet& packet);
  void recv_command_require_warp_thread(const Packet& packet);
  void recv_command_warp_thread(const Packet& packet);

  void send_command_heartbeat_vm();
  void send_command_warp_thread(Thread& thread);
};
}  // namespace processwarp
