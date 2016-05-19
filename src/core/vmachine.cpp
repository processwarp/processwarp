
#include <ctime>
#include <map>
#include <random>
#include <set>
#include <string>
#include <tuple>
#include <vector>

#include "builtin_bit.hpp"
#include "builtin_gui.hpp"
#include "builtin_libc.hpp"
#include "builtin_memory.hpp"
#include "builtin_overflow.hpp"
#include "builtin_posix.hpp"
#include "builtin_va_arg.hpp"
#include "builtin_warp.hpp"

#include "constant.hpp"
#include "convert.hpp"
#include "core_mid.hpp"
#include "error.hpp"
#include "finally.hpp"
#include "logger.hpp"
#include "type.hpp"
#include "vmachine.hpp"
#include "vmemory.hpp"

namespace processwarp {

/**
 * Simple destructor for vtable.
 */
VMachineDelegate::~VMachineDelegate() {
}

/**
 * Constractor with delegate.
 * @param delegate_ Events assignee.
 * @param memory_delegate Events assignee for VMemory in this vm.
 * @param my_nid_ This virtual machine's node-id.
 * @param libs_ Loaded external libraries for ffi.
 * @param lib_filter_ Map of API name call from and call for that can access.
 */
VMachine::VMachine(VMachineDelegate& delegate_,
                   VMemoryDelegate& memory_delegate,
                   const NodeID& my_nid_,
                   const std::vector<DynamicLibrary::lib_handler_t>& libs_,
                   const std::map<std::string, std::string>& lib_filter_) :
    my_nid(my_nid_),
    vmemory(memory_delegate, my_nid_),
    delegate(delegate_),
    libs(libs_),
    lib_filter(lib_filter_),
    last_heartbeat(0) {
}

/**
 * Create empty process.
 * @param pid New process's process-id.
 * @param root_tid Root thread-id.
 * @param proc_addr Address where are meta informations assigned.
 * @param master_nid Node-id that process's root thread running.
 * @param name Process name for new vm.
 */
void VMachine::initialize(const vpid_t& pid, const vtid_t& root_tid, vaddr_t proc_addr,
                          const NodeID& master_nid, const std::string& name) {
  assert(process.get() == nullptr);
  process = Process::alloc(*this, pid, root_tid, libs, lib_filter, builtin_funcs,
                           proc_addr, master_nid);
  process->setup();
  process->name = name;
  initialize_builtin();
}

/**
 * Enable GUI.
 * Regist GUI API's with pass delegate instance.
 * @param delegate GUI delegate instance.
 */
void VMachine::initialize_gui(BuiltinGuiDelegate& delegate) {
  BuiltinGui::regist(*this, delegate);
}

/**
 * Main loop.
 */
void VMachine::execute() {
  std::time_t now = std::time(nullptr);
  vtid_t tid;
  Thread* thread;
  Finally finally;

  try {
    if (loop_queue.empty()) {
      // Make list of process and threads temporary.

      /// @todo migrate method anywhere
      for (auto& it_waiting : process->waiting_warp_result) {
        if (it_waiting.second + MEMORY_REQUIRE_INTERVAL < now) {
          send_command_warp_thread(process->get_thread(it_waiting.first));
          it_waiting.second = now;
        }
      }

      // Reload thread information from memory.
      auto it_thread = process->threads.begin();
      while (it_thread != process->threads.end()) {
        if (process->active_threads.find(it_thread->first) != process->active_threads.end() ||
            process->waiting_warp_result.find(it_thread->first) !=
            process->waiting_warp_result.end()) {
          it_thread->second->read();
          it_thread++;

        } else {
          it_thread = process->threads.erase(it_thread);
        }
      }

      for (auto& tid : process->active_threads) {
        loop_queue.push(tid);
      }

      // Return if thread to run is empty.
      if (loop_queue.empty()) return;
    }

    tid = loop_queue.front();
    loop_queue.pop();

    // Skip if thread waiting to update memory.
    if (process->waiting_addr.find(tid) != process->waiting_addr.end()) {
      return;
    }

    // Get instance of thread.
    auto it_thread = process->active_threads.find(tid);
    if (it_thread == process->active_threads.end()) {
      return;
    } else {
      thread = &process->get_thread(tid);
    }

    VMemory::Accessor::MasterKey thread_master_key = thread->memory->keep_master(tid);
    finally.add([&]{
        thread->write();
        thread->memory->write_out();
      });

    Logger::dbg_vm(CoreMid::L1001, "loop pid=%s tid=%016" PRIx64 " status=%d",
                   process->pid.c_str(), tid, thread->status);

    // Setting of warpuot to thread if need.
    if (process->waiting_warp_setup.find(tid) != process->waiting_warp_setup.end()) {
      thread->setup_warpout();
      process->waiting_warp_setup.erase(tid);
    }

    if (thread->status == Thread::NORMAL ||
        thread->status == Thread::WAIT_WARP ||
        thread->status == Thread::BEFOR_WARP ||
        thread->status == Thread::AFTER_WARP) {
      // run thread
      process->execute(*thread, 100);
      Logger::dbg_vm(CoreMid::L1001, "loop finish status=%d", thread->status);

    } else if (thread->status == Thread::WARP) {
      process->waiting_warp_result.insert(std::make_pair(thread->tid, now));
      process->active_threads.erase(thread->tid);
      send_command_warp_thread(*thread);

    } else if (thread->status == Thread::ERROR) {
      delegate.vmachine_error(*this, "");

    } else if (thread->status == Thread::FINISH) {
      thread_master_key.reset();
      if (process->destroy_thread(*thread)) {
        finally.clear();
      }

      delegate.vmachine_finish_thread(*this, tid);
      if (tid == process->root_tid) {
        delegate.vmachine_finish(*this);
      }
    }

    // Send heartbeat, per interval.
    if ((now - last_heartbeat) > HEARTBEAT_INTERVAL) {
      last_heartbeat = now;
      send_command_heartbeat_vm();
    }
  } catch (Interrupt& e) {
    // Skip thread because waiting to update memroy data.
    assert(e.type == Interrupt::MEMORY_REQUIRE);
    vaddr_t waiting_addr = static_cast<InterruptMemoryRequire&>(e).addr;
    Logger::dbg_mem(CoreMid::L1002, "memory need (addr=%s)",
                    Convert::vaddr2str(waiting_addr).c_str());
    if (waiting_addr != VADDR_NULL) {
      process->waiting_addr.insert(std::make_pair(tid, waiting_addr));
    }
  } catch (Error& e) {
    thread->status = Thread::FINISH;
    delegate.vmachine_error(*this, "");

#ifdef NDEBUG
  } catch (std::exception& e) {
    thread->status = Thread::FINISH;
    delegate.vmachine_error(*this, e.what());
  } catch (...) {
    thread->status = Thread::FINISH;
    delegate.vmachine_error(*this, "unknown exception");
#endif
  }
}

/**
 * Tell memory is update by other node.
 * @param addr Updated page address.
 */
void VMachine::on_recv_update(vaddr_t addr) {
  assert(addr == VMemory::get_upper_addr(addr));

  auto it_waiting = process->waiting_addr.begin();
  while (it_waiting != process->waiting_addr.end()) {
    if (it_waiting->second == addr) {
      it_waiting = process->waiting_addr.erase(it_waiting);

    } else {
      it_waiting++;
    }
  }
}

/**
 * When receive command from other module in this node, read command and call capable method with parameter.
 * @param packet Command packet.
 */
void VMachine::recv_command(const Packet& packet) {
  const std::string& command = packet.content.at("command").get<std::string>();

  if (command == "heartbeat_vm") {
    recv_command_heartbeat_vm(packet);

  } else if (command == "require_warp_thread") {
    recv_command_require_warp_thread(packet);

  } else if (command == "warp_thread") {
    recv_command_warp_thread(packet);

  } else {
    /// @todo error
    assert(false);
  }
}

/**
 * Get process instance.
 * @return Process instance.
 */
Process& VMachine::get_process() {
  assert(process.get() != nullptr);

  return *process;
}

std::unique_ptr<VMemory::Accessor> VMachine::process_assign_accessor(const vpid_t& pid) {
  return vmemory.get_accessor(Convert::vpid2str(pid));
}

/**
 * When changed a list of threads in this vm, send list of threads by heartbeat_vm command.
 * @param proc Caller instance.
 */
void VMachine::process_change_thread_set(Process& proc) {
  send_command_heartbeat_vm();
}

/**
 * Regist built-in function to virtual machine.
 * @param name Function name (if C++ name then demangled).
 * @param func Point to buint-in function bound name.
 * @param i64 Parameter to pass to builtin-function.
 */
void VMachine::regist_builtin_func(const std::string& name,
                                   builtin_func_t func, int i64) {
  BuiltinFuncParam param;
  param.i64 = i64;
  builtin_funcs.insert(std::make_pair(name, std::make_pair(func, param)));
}

/**
 * Regist built-in function to virtual machine.
 * @param name Function name (if C++ name then demangled).
 * @param func Point to buint-in function bound name.
 * @param ptr Parameter to pass to builtin-function.
 */
void VMachine::regist_builtin_func(const std::string& name,
                                   builtin_func_t func, void* ptr) {
  BuiltinFuncParam param;
  param.ptr = ptr;
  builtin_funcs.insert(std::make_pair(name, std::make_pair(func, param)));
}

/**
 * When receive heartbeat_vm command, remove thread-id from waiting list if exisiting.
 * @param packet Command packet.
 */
void VMachine::recv_command_heartbeat_vm(const Packet& packet) {
  if (packet.src_nid == my_nid) return;

  for (auto& it_thread : packet.content.at("threads").get<picojson::array>()) {
    vtid_t tid = Convert::json2vtid(it_thread);
    process->waiting_warp_result.erase(tid);
    /// @todo remove from threads?

    if (process->active_threads.find(tid) != process->active_threads.end()) {
      /// @todo error
      assert(false);
    }
  }
}

/**
 * When receive require_warp_thread command, setup to warp thread.
 * @param packet Command packet, containing target thread-id and node-id.
 */
void VMachine::recv_command_require_warp_thread(const Packet& packet) {
  vtid_t tid = Convert::json2vtid(packet.content.at("tid"));
  const NodeID& target_nid = NodeID::from_json(packet.content.at("target_nid"));
  assert(target_nid != NodeID::NONE);

  if (process->active_threads.find(tid) != process->active_threads.end()) {
    Thread& thread = process->get_thread(tid);
    if (thread.require_warp(target_nid)) {
      thread.write();
      thread.memory->write_out();
    }
  }
}

/**
 * When receive warp_thread command, activate thread and tell it to another node by
 * sending heartbeat_vm thread.
 * @param packet Command packet.
 */
void VMachine::recv_command_warp_thread(const Packet& packet) {
  vtid_t tid = Convert::json2vtid(packet.content.at("tid"));
  process->warp_out_thread(tid);
  send_command_heartbeat_vm();
}

/**
 * Send command to another module or node through backend and server if need.
 * @param pid Process-id bundled to packet.
 * @param dst_nid Destination node-id.
 * @param module Target module.
 * @param command Command string.
 * @param param Parameter for command.
 */
void VMachine::send_command(const vpid_t& pid, const NodeID& dst_nid, Module::Type module,
                            const std::string& command, picojson::object& param) {
  assert(param.find("command") == param.end() ||
         param.at("command").get<std::string>() == command);

  param.insert(std::make_pair("command", picojson::value(command)));
#warning TODO
  // delegate.vmachine_send_command(*this, {pid, dst_nid, NodeID::NONE, module, param});
}

/**
 * Send heartbeat_vm command to tell thread list having this VM module.
 */
void VMachine::send_command_heartbeat_vm() {
  // List up activate thread.
  picojson::array threads;
  for (auto& it_thread : process->threads) {
    Thread& thread = *it_thread.second;
    if (thread.status == Thread::NORMAL ||
        thread.status == Thread::AFTER_WARP ||
        thread.status == Thread::JOIN_WAIT) {
      threads.push_back(Convert::vtid2json(it_thread.first));
    }
  }

  picojson::object param;
  param.insert(std::make_pair("name", picojson::value(process->name)));
  param.insert(std::make_pair("threads", picojson::value(threads)));
  send_command(process->pid, NodeID::BROADCAST, Module::VM, "heartbeat_vm", param);
  send_command(process->pid, NodeID::BROADCAST, Module::SCHEDULER, "heartbeat_vm", param);
}

/**
 * Send warp_thread command to SCHEDULER at warp destination node.
 * @param thread Target thread to warp.
 */
void VMachine::send_command_warp_thread(Thread& thread) {
  assert(thread.warp_dst != NodeID::NONE);

  picojson::object param;
  param.insert(std::make_pair("root_tid", Convert::vtid2json(process->root_tid)));
  param.insert(std::make_pair("proc_addr", Convert::vaddr2json(process->addr)));
  param.insert(std::make_pair("master_nid",
                              (process->proc_memory->get_master(process->addr).to_json())));
  param.insert(std::make_pair("name", picojson::value(process->name)));
  param.insert(std::make_pair("tid", Convert::vtid2json(thread.tid)));
  param.insert(std::make_pair("dst_nid", thread.warp_dst.to_json()));
  param.insert(std::make_pair("src_nid", my_nid.to_json()));

  send_command(process->pid, thread.warp_dst, Module::SCHEDULER, "warp_thread", param);
}

/**
 * Regist built-in function to virtual machine.
 */
void VMachine::initialize_builtin() {
  BuiltinBit::regist(*this);
  BuiltinLibc::regist(*this);
  BuiltinMemory::regist(*this);
  BuiltinOverflow::regist(*this);
  BuiltinPosix::regist(*this);
  BuiltinVaArg::regist(*this);
  BuiltinWarp::regist(*this);
}
}  // namespace processwarp
