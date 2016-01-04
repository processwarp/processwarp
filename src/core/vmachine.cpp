
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

#include "convert.hpp"
#include "definitions.hpp"
#include "error.hpp"
#include "finally.hpp"
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
   * @param delegate Events assignee.
   * @param memory_delegate 
   * @param nid This virtual machine's node-id.
   * @param libs Loaded external libraries for ffi.
   * @param lib_filter Map of API name call from and call for that can access.
   */
VMachine::VMachine(VMachineDelegate& delegate_,
                   VMemoryDelegate& memory_delegate,
                   const nid_t& my_nid_,
                   const std::vector<void*>& libs_,
                   const std::map<std::string, std::string>& lib_filter_) :
    my_nid(my_nid_),
    vmemory(memory_delegate, my_nid_),
    delegate(delegate_),
    libs(libs_),
    lib_filter(lib_filter_) {
}

/**
 * Create empty process.
 * @param pid New process's process-id.
 * @param root_tid Root thread-id.
 * @param addr 
 */
void VMachine::initialize(const vpid_t& pid, const vtid_t& root_tid,
                          vaddr_t proc_addr, const nid_t& master_nid) {
  assert(process.get() == nullptr);
  process = std::move(Process::alloc(*this, pid, root_tid, libs, lib_filter,
                                     builtin_funcs, proc_addr, master_nid));
  process->setup();
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
  vtid_t tid;
  Thread* thread;
  Finally finally;

  try {
    if (loop_queue.empty()) {
      // Make list of process and threads temporary.
      std::clock_t now = clock();

      /// @todo migrate method anywhere
      for (auto& it_waiting : process->waiting_warp_result) {
        if (it_waiting.second + MEMORY_REQUIRE_INTERVAL < now) {
          send_warp(process->get_thread(it_waiting.first));
          it_waiting.second = now;
        }
      }

      // Reload thread information from memory.
      auto it_thread = process->threads.begin();
      while (it_thread != process->threads.end()) {
        if (process->active_threads.find(it_thread->first) != process->active_threads.end()) {
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

    print_debug("loop pid=%s tid=%016" PRIx64 " status=%d\n",
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
      print_debug("loop finish status=%d\n", thread->status);

    } else if (thread->status == Thread::WARP) {
      process->waiting_warp_result.insert(std::make_pair(thread->tid, std::clock()));
      process->active_threads.erase(thread->tid);
      send_warp(*thread);

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

      // update_proc_list();
    }
  } catch (Interrupt& e) {
    // Skip thread because waiting to update memroy data.
    assert(e.type == Interrupt::MEMORY_REQUIRE);
    vaddr_t waiting_addr = static_cast<InterruptMemoryRequire&>(e).addr;
    print_debug("memory need:%s\n", Convert::vaddr2str(waiting_addr).c_str());
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
 * @param content A JSON that contain a command string adn any parameter.
 */
void VMachine::recv_command(const picojson::object& content) {
  const std::string& command = content.at("command").get<std::string>();

  if (command == "warpout") {
    warpout_thread(Convert::json2vtid(content.at("tid")));

  } else {
    /// @todo error
    assert(false);
  }
}

/**
 * Pass data from other node.
 * @param data Received load data.
 */
void VMachine::recv_packet(const std::string& data) {
  try {
    picojson::value v;
    std::istringstream is(data);
    std::string err = picojson::parse(v, is);
    if (!err.empty()) {
      std::cerr << err << std::endl;
      assert(false);
      /// @todo error
    }

    picojson::object json = v.get<picojson::object>();

    // select command
    std::string command = json.at("command").get<std::string>();
    if (command == "warp") {
      // recv_warp(json);
      assert(false);

    } else if (command == "warp_request") {
      // recv_warp_request(json);
      assert(false);

    } else if (command == "terminate") {
      recv_terminate(json);

    } else {
      assert(false);
      /// @todo error
    }

    return;
  } catch (Error& e) {
    std::cerr << e.reason << ":" << e.mesg << std::endl;
  }
#ifdef NDEBUG
  catch (std::exception& e) {
    std::cerr << e.what() << std::endl;
  } catch (...) {
    std::cerr << "unknown exception" << std::endl;
  }
#endif

  assert(false);
  /// @todo error
}

/**
 * Change status of process in order to terminate.
 * After terminate process, resources of process are free automatic.
 */
void VMachine::terminate() {
  if (process->active_threads.find(process->root_tid) != process->active_threads.end()) {
    process->terminate();

  } else {
    send_terminate();
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

void VMachine::warpout_thread(vtid_t tid) {
  process->warp_out_thread(tid);
}

/**
 * Change thread status to warp thread.
 * @param tid Target thread-id.
 * @param dst_node Warp destination node-id.
 */
void VMachine::request_warp_thread(const vtid_t tid, const nid_t& dst_node) {
  if (process->active_threads.find(tid) != process->active_threads.end()) {
    Thread& thread = process->get_thread(tid);
    thread.setup_warpin(dst_node);
    thread.write();
    thread.memory->write_out();

  } else {
    // send_warp_request(tid, dst_node);
    assert(false);
  }
}

std::unique_ptr<VMemory::Accessor> VMachine::process_assign_accessor(const vpid_t& pid) {
  return std::move(vmemory.get_accessor(Convert::vpid2str(pid)));
}

void VMachine::process_change_thread_set(Process& proc) {
  // update_proc_list();
}

/**
 * If recv this packet and this node contain target process and thread,
 * change status to warp thread.
 * @param json
 */
/*
void VMachine::recv_warp_request(picojson::object& json) {
  const vtid_t tid = Convert::json2vtid(json.at("tid"));
  const nid_t dst_node = Convert::json2nid(json.at("dst"));

  auto it_proc = procs.find(pid);
  if (it_proc != procs.end() &&
      (it_proc->second->active_threads.find(tid)) !=
      it_proc->second->active_threads.end()) {
    Thread& thread = it_proc->second->get_thread(tid);
    thread.setup_warpin(dst_node);
    thread.write();
    thread.memory->write_out();
  }
}
*/

/**
 * If recv this packet and this node have root-thread of target process,
 * Change status of root-thread in order to terminate process.
 */
void VMachine::recv_terminate(picojson::object& json) {
  if (process->active_threads.find(process->root_tid) != process->active_threads.end()) {
    process->terminate();
  }
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
 * Change flag to FINISH for all defunct thread.
 * @param sv_procs
 */
void VMachine::kill_defunct_thread(const ProcessTree& sv_proc) {
  if (sv_proc.threads.find(process->root_tid) == sv_proc.threads.end()) {
    // Change flag to FINISH for all threads if root-thread was not exist yet.
    for (auto& tid : process->active_threads) {
      Thread& thread = process->get_thread(tid);
      thread.status = Thread::FINISH;
      thread.join_waiting = JOIN_WAIT_DETACHED;
      thread.write();
      thread.memory->write_out();
    }
  }

  /// @todo Change flag to FINISH for all threads if process was not exist yet.
  assert(false);
}

/**
 * Delete process if active-threads in this node were not exist.
 * @param sv_procs
 */
/*
void VMachine::clean_defunct_processe(const std::vector<ProcessTree>& sv_procs) {
  auto it_proc = procs.begin();
  while (it_proc != procs.end()) {
    if (it_proc->second->active_threads.size() == 0) {
      it_proc = procs.erase(it_proc);

    } else {
      it_proc++;
    }
  }
}
*/

/*
 * Delete memory space if process in all nodes was not exist.
 * @param sv_procs
 */
/*
void VMachine::clean_defunct_memoryspace(const std::vector<ProcessTree>& sv_procs) {
  auto it_space = vmemory.spaces.begin();
  while (it_space != vmemory.spaces.end()) {
    vpid_t pid = Convert::str2vpid(it_space->first);

    bool is_find = false;
    for (auto& it_sv_proc : sv_procs) {
      if (it_sv_proc.pid == pid) {
        is_find = true;
        break;
      }
    }

    if (!is_find &&
        procs.find(pid) == procs.end()) {
      it_space = vmemory.spaces.erase(it_space);

    } else {
      it_space++;
    }
  }
}
*/

/**
 * Convert json to machine data packet and send to destination node.
 * @param dst_nid
 * @param command
 * @param packet
 */
void VMachine::send_packet(const nid_t& dst_nid, const std::string& command,
                           picojson::object& packet) {
  packet.insert(std::make_pair("command", picojson::value(command)));
  packet.insert(std::make_pair("src_nid", Convert::nid2json(my_nid)));

  delegate.vmachine_send_packet(*this, dst_nid, picojson::value(packet).serialize());
}

/**
 * This request means to warp thread to target node.
 * This method regist thread-id to pool and loop method check
 * target thread's status to change.
 * @param thread
 */
void VMachine::send_warp(Thread& thread) {
  picojson::object packet;

  packet.insert(std::make_pair("root_tid", Convert::vtid2json(process->root_tid)));
  packet.insert(std::make_pair("proc_addr", Convert::vaddr2json(process->addr)));
  packet.insert(std::make_pair("master_nid", Convert::nid2json
                               (process->proc_memory->get_master(process->addr))));
  packet.insert(std::make_pair("name", picojson::value(process->name)));
  packet.insert(std::make_pair("tid", Convert::vtid2json(thread.tid)));
  packet.insert(std::make_pair("dst_nid", Convert::nid2json(thread.warp_dst)));
  packet.insert(std::make_pair("src_nid", Convert::nid2json(my_nid)));

  send_packet(thread.warp_dst, "warp", packet);
}

/**
 * This request means to broadcast request of warp a thread.
 * @param tid
 * @param dst_node
 */
/*
void VMachine::send_warp_request(const vtid_t tid, const nid_t& dst_nid) {
  picojson::object packet;

  packet.insert(std::make_pair("cmd", picojson::value(std::string("warp_request"))));
  packet.insert(std::make_pair("tid", Convert::vtid2json(tid)));
  packet.insert(std::make_pair("dst_nid", Convert::nid2json(dst_nid)));

  send_packet(SpecialNID::BROADCAST, "warp_request", packet);
}
*/

/**
 * This request means to broadcast request of terminateing process.
 */
void VMachine::send_terminate() {
  picojson::object packet;

  // Nothing for payload.

  send_packet(SpecialNID::BROADCAST, "terminate", packet);
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

// Make new process-tree and send to server.
/*
void VMachine::update_proc_list() {
  std::vector<ProcessTree> packet;

  for (auto& proc : procs) {
    ProcessTree pt;
    pt.pid = proc.second->pid;

    for (auto& thread : proc.second->active_threads) {
      pt.threads.insert(std::make_pair(thread, nid));
    }

    packet.push_back(pt);
  }

  delegate.send_sync_proc_list(packet);
}
*/
}  // namespace processwarp
