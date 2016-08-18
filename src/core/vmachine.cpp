
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
#include "interrupt.hpp"
#include "interrupt_memory_require.hpp"
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
    vmemory(memory_delegate, my_nid),
    delegate(delegate_),
    libs(libs_),
    lib_filter(lib_filter_),
    packet_controller(Module::VM) {
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
  packet_controller.initialize(this);
  vmemory.initialize(pid);

  process = Process::alloc(*this, pid, root_tid, libs, lib_filter, builtin_funcs,
                           proc_addr, master_nid);
  process->setup();
  process->name = name;

  BuiltinGui::regist(*this, packet_controller);

  initialize_builtin();
}

/**
 * Main loop.
 */
void VMachine::execute(vtid_t tid) {
#ifndef NDEBUG
  {
    Lock::Guard guard(process->mutex_threads);
    assert(process->active_threads.find(tid) != process->active_threads.end());
  }
#endif
  std::time_t now = std::time(nullptr);
  Thread* thread = nullptr;

  while (1) {
    try {
      // Get instance of thread.
      thread = &process->get_thread(tid);

      VMemory::Accessor::LeaderKey thread_leader_key = thread->memory->keep_leader(tid);
      Finally finally;
      finally.add([&]{
          thread->write();
          thread->memory->write_out();
        });

      Logger::dbg_vm(CoreMid::L1001, "loop pid=%s tid=%016" PRIx64 " status=%d",
                     process->pid.c_str(), tid, thread->status);

      // Setting of warpuot to thread if need.
      NodeID warp_dst_nid;
      {
        Lock::Guard guard(process->mutex_require_warp_threads);
        auto it_warp = process->require_warp_threads.find(tid);
        if (it_warp != process->require_warp_threads.end()) {
          warp_dst_nid = it_warp->second;
          process->require_warp_threads.erase(it_warp);
        }
      }

      if (warp_dst_nid != NodeID::NONE && thread->require_warp(warp_dst_nid)) {
        thread->write();
        thread->memory->write_out();
      }

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
        {
          Lock::Guard guard(process->mutex_waiting_warp_result);
          process->waiting_warp_result.insert(std::make_pair(thread->tid, now));
        }
        {
          Lock::Guard guard(process->mutex_threads);
          process->active_threads.erase(thread->tid);
        }
        send_command_warp_thread(*thread);
        thread_leader_key.reset();
        {
          Lock::Guard guard(process->mutex_waiting_warp_result);
          while (process->waiting_warp_result.find(tid) != process->waiting_warp_result.end()) {
            process->cond_waiting_warp_result.wait(process->mutex_waiting_warp_result);
          }
        }

      } else if (thread->status == Thread::ERROR) {
        delegate.vmachine_error(*this, "");
        return;

      } else if (thread->status == Thread::FINISH) {
        thread_leader_key.reset();
        if (process->destroy_thread(*thread)) {
          finally.clear();
        }

        if (tid == process->root_tid) {
          delegate.vmachine_finish(*this);
        }
        return;
      }
    } catch (Interrupt& e) {
      // Skip thread because waiting to update memroy data.
      assert(e.type == Interrupt::MEMORY_REQUIRE);
      vaddr_t waiting_addr = static_cast<InterruptMemoryRequire&>(e).addr;
      Logger::dbg_mem(CoreMid::L1002, "memory need (addr=%s)",
                      Convert::vaddr2str(waiting_addr).c_str());
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
}

void VMachine::heartbeat() {
  send_command_heartbeat_vm();
}

/**
 * When receive packet, call capable method with it.
 * @param packet A packet.
 */
void VMachine::recv_packet(const Packet& packet) {
  packet_controller.recv(packet);
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
  return vmemory.get_accessor();
}

/**
 * When changed a list of threads in this vm, send list of threads by heartbeat_vm command.
 * @param proc Caller instance.
 */
void VMachine::process_change_thread_set(Process& proc) {
  send_command_heartbeat_vm();
}

void VMachine::process_on_invoke_thread(Process& process, vtid_t tid) {
  delegate.vmachine_on_invoke_thread(*this, tid);
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
 * When receive general command, relay it to capable method.
 * @param packet A packet.
 */
void VMachine::packet_controller_on_recv(const Packet& packet) {
  if (packet.command == "require_warp_thread") {
    recv_command_require_warp_thread(packet);

  } else if (packet.command == "warp_thread") {
    recv_command_warp_thread(packet);

  } else {
    /// @todo error
    assert(false);
  }
}

/**
 * When send packet event has happen on PacketController, relay it to delegate.
 * @param packet A packet to relay.
 */
void VMachine::packet_controller_send(const Packet& packet) {
  delegate.vmachine_send_packet(*this, packet);
}

/**
 * When receive heartbeat_vm command, remove thread-id from waiting list if exisiting.
 * @param packet Command packet.
 */
void VMachine::recv_command_heartbeat_vm(const Packet& packet) {
  if (packet.src_nid == my_nid) return;

  for (auto& it_thread : packet.content.at("threads").get<picojson::array>()) {
    vtid_t tid = Convert::json2vtid(it_thread);
    {
      Lock::Guard guard(process->mutex_waiting_warp_result);
      process->waiting_warp_result.erase(tid);
      process->cond_waiting_warp_result.notify_all();
    }

    {
      Lock::Guard guard(process->mutex_threads);
      if (process->active_threads.find(tid) != process->active_threads.end()) {
        /// @todo error
        assert(false);
      }
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

  process->require_warp(tid, target_nid);
}

/**
 * When receive warp_thread command, activate thread and tell it to another node by
 * sending heartbeat_vm thread.
 * @param packet Command packet.
 */
void VMachine::recv_command_warp_thread(const Packet& packet) {
  vtid_t tid = Convert::json2vtid(packet.content.at("tid"));
  process->warp_out_thread(tid);
  delegate.vmachine_on_invoke_thread(*this, tid);
  send_command_heartbeat_vm();
}

/**
 * Send heartbeat_vm command to tell thread list having this VM module.
 */
void VMachine::send_command_heartbeat_vm() {
  // List up activate thread.
  picojson::array threads;
  {
    Lock::Guard guard(process->mutex_threads);
    for (auto& it_thread : process->threads) {
      Thread& thread = *it_thread.second;
      Lock::Guard guard(thread.mutex);

      if (thread.status == Thread::NORMAL ||
          thread.status == Thread::AFTER_WARP ||
          thread.status == Thread::JOIN_WAIT) {
        threads.push_back(Convert::vtid2json(it_thread.first));
      }
    }
  }

  picojson::object param;
  param.insert(std::make_pair("name", picojson::value(process->name)));
  param.insert(std::make_pair("threads", picojson::value(threads)));
  packet_controller.send("heartbeat_vm", Module::SCHEDULER, true,
                         process->pid, NodeID::THIS, param);
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
                              (process->proc_memory->get_leader(process->addr).to_json())));
  param.insert(std::make_pair("name", picojson::value(process->name)));
  param.insert(std::make_pair("tid", Convert::vtid2json(thread.tid)));
  param.insert(std::make_pair("dst_nid", thread.warp_dst.to_json()));
  param.insert(std::make_pair("src_nid", my_nid.to_json()));

  packet_controller.send("warp_thread", Module::SCHEDULER, true,
                         process->pid, thread.warp_dst, param);
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
