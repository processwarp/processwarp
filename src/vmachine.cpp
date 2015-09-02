
#include <ctime>
#include <random>

#include "builtin_bit.hpp"
#ifdef ENABLE_GLFW3
#include "builtin_glfw3.hpp"
#endif
#include "builtin_libc.hpp"
#include "builtin_memory.hpp"
#include "builtin_overflow.hpp"
#include "builtin_posix.hpp"
#include "builtin_va_arg.hpp"
#include "builtin_warp.hpp"

#include "convert.hpp"
#include "definitions.hpp"
#include "error.hpp"
#include "vmachine.hpp"
#include "vmemory.hpp"

using namespace processwarp;

// Destructor for virtual.
VMachineDelegate::~VMachineDelegate() {
  // Do nothing.
}
    
// Call when send data to other device.
void VMachineDelegate::send_machine_data(const vpid_t& pid,
					 const dev_id_t& dst,
					 const std::string& data) {
  // Do nothing.
}
    
// Call when context switch of process.
void VMachineDelegate::on_switch_proccess(const vpid_t& pid) {
  // Do nothing.
}

// Call when process was finish.
void VMachineDelegate::on_finish_proccess(const vpid_t& pid) {
  // Do nothing.
}

// Call when a thread was finish.
void VMachineDelegate::on_finish_thread(const vpid_t& pid, const vtid_t& tid) {
  // Do nothing.
}

// Call when rise error.
void VMachineDelegate::on_error(const vpid_t& pid,
				const std::string& message) {
  // Do nothing.
}

// Constractor with delegate.
VMachine::VMachine(VMachineDelegate& delegate_,
		   VMemoryDelegate& memory_delegate,
		   const dev_id_t& device_id_,
		   const std::vector<void*>& libs_,
		   const std::map<std::string, std::string>& lib_filter_) :
  device_id(device_id_),
  delegate(delegate_),
  vmemory(memory_delegate, device_id_),
  libs(libs_),
  lib_filter(lib_filter_) {
  // Do nothing.
}

// Main loop.
void VMachine::loop() {
  vpid_t pid;
  vtid_t tid;
  Process* proc;
  Thread*  thread;

  try {
    if (loop_queue.empty()) {
      // Make list of process and threads temporary.
      std::clock_t now = clock();
      for (auto& it_proc : procs) {
	pid  = it_proc.first;
	proc = it_proc.second.get();
	
	// @todo migrate method anywhere 
	for (auto& it_waiting : proc->waiting_warp_result) {
	  if (it_waiting.second + MEMORY_REQUIRE_INTERVAL < now) {
	    send_warp(*proc, proc->get_thread(it_waiting.first));
	    it_waiting.second = now;
	  }
	}

	for (auto& tid : proc->active_threads) {
	  loop_queue.push(std::make_pair(pid, tid));
	}
      }
      // Return if thread to run is empty.
      if (loop_queue.empty()) return;
    }
    
    pid = loop_queue.front().first;
    tid = loop_queue.front().second;
    loop_queue.pop();

    // Get instance of process.
    auto it_proc = procs.find(pid);
    if (it_proc == procs.end()) {
      return;
    } else {
      proc = it_proc->second.get();
    }

    // Skip if thread waiting to update memory.
    if (proc->waiting_addr.find(tid) != proc->waiting_addr.end()) {
      return;
    }

    // Get instance of thread.
    auto it_thread = proc->active_threads.find(tid);
    if (it_thread == proc->active_threads.end()) {
      return;
    } else {
      thread = &proc->get_thread(tid);
    }
    
    print_debug("loop pid=%s tid=%016" PRIx64 " status=%d\n",
		pid.c_str(), tid, thread->status);
    
    // Setting of warpuot to thread if need.
    if (proc->waiting_warp_setup.find(tid) != proc->waiting_warp_setup.end()) {
      thread->setup_warpout();
      proc->waiting_warp_setup.erase(tid);
    }

    if (thread->status == Thread::NORMAL ||
	thread->status == Thread::WAIT_WARP ||
	thread->status == Thread::BEFOR_WARP ||
	thread->status == Thread::AFTER_WARP) {
	  
      delegate.on_switch_proccess(pid);
      // run thread
      proc->execute(tid, 100);
      print_debug("loop finish status=%d\n", thread->status);

    } else if (thread->status == Thread::WARP) {
      proc->waiting_warp_result.insert(std::make_pair(thread->tid, std::clock()));
      proc->active_threads.erase(thread->tid);
      send_warp(*proc, *thread);
	  
    } else if (thread->status == Thread::ERROR) {
      delegate.on_error(pid, "");
	
    } else if (thread->status == Thread::FINISH) {
      delegate.on_finish_thread(pid, tid);

      if (tid == proc->root_tid) {
	delegate.on_finish_proccess(pid);
	it_proc = procs.erase(it_proc);
	update_proc_list();
	assert(false);

      } else {
	proc->active_threads.erase(tid);
	proc->threads.erase(tid);
	proc->proc_memory->free(tid);
	update_proc_list();
	assert(false);
      }
    }

  } catch (Interrupt& e) {
    // Skip thread because waiting to update memroy data.
    assert(e.type == Interrupt::MEMORY_REQUIRE);
    vaddr_t waiting_addr = static_cast<InterruptMemoryRequire&>(e).addr;
    print_debug("memory need:%s\n", Convert::vaddr2str(waiting_addr).c_str());
    if (waiting_addr != VADDR_NULL) {
      proc->waiting_addr.insert(std::make_pair(tid, waiting_addr));
    }
    
  } catch (Error& e) {
    delegate.on_error(pid, "");
    thread->status = Thread::FINISH;
    
#ifdef NDEBUG
  } catch (std::exception& e) {
    delegate.on_error(pid, e.what());
    thread->status = Thread::FINISH;
    
  } catch (...) {
    delegate.on_error(pid, "unknown exception");
    thread->status = Thread::FINISH;
#endif
  }
  
  delegate.on_switch_proccess("");
}

// Tell memory is update by other node.
void VMachine::on_recv_update(const vpid_t& pid, vaddr_t addr) {
  assert(addr == VMemory::get_upper_addr(addr));
  
  auto it_proc = procs.find(pid);
  if (it_proc != procs.end()) {
    Process& proc = *it_proc->second.get();
    auto it_waiting = proc.waiting_addr.begin();
    while(it_waiting != proc.waiting_addr.end()) {
      if (it_waiting->second == addr) {
	it_waiting = proc.waiting_addr.erase(it_waiting);

      } else {
	it_waiting ++;
      }
    }
    
  } else {
    /// @todo
    assert(false);
  }
}
    
// Pass data from other device.
void VMachine::recv_machine_data(const vpid_t& pid, const std::string& data) {
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

    // select cmd
    std::string cmd = json.at("cmd").get<std::string>();
    if (cmd == "warp") {
      recv_warp(pid, json);

    } else if (cmd == "warp_request") {
      recv_warp_request(pid, json);
    
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

// Call when recv sync proc list message from server.
void VMachine::recv_sync_proc_list(const std::vector<ProcessTree>& sv_procs) {
  std::set<std::tuple<vpid_t, vtid_t>> sv_set;
  for (auto& sv_proc : sv_procs) {
    // Update process name.
    auto it_vm_proc = procs.find(sv_proc.pid);
    Process* proc = nullptr;
    if (it_vm_proc != procs.end()) {
      proc = it_vm_proc->second.get();
      proc->name = sv_proc.name;
    }

    for (auto& sv_thread : sv_proc.threads) {
      // Collect pid and tid of server.
      if (sv_thread.second == device_id) {
	sv_set.insert(std::make_tuple(sv_proc.pid, sv_thread.first));

      } else if (proc != nullptr &&
		 proc->waiting_warp_result.find(sv_thread.first) !=
		 proc->waiting_warp_result.end()) {
	// Remove thread if warp was success.
	proc->waiting_warp_result.erase(sv_thread.first);
	proc->threads.erase(sv_thread.first);
      }
    }
  }

  // Collect pid and tid of virtual machine.
  std::set<std::tuple<vpid_t, vtid_t>> vm_set;
  for (auto& vm_proc : procs) {
    for (auto& vm_thread : vm_proc.second->active_threads) {
      vm_set.insert(std::make_tuple(vm_proc.first, vm_thread));
    }
  }

  // If not equal pid and tid between server and virtual machine, then update process list.
  if (sv_set != vm_set) update_proc_list();
}

// Create empty process.
void VMachine::join_process(const vpid_t& pid, const vtid_t& root_tid,
			    vaddr_t proc_addr, const dev_id_t& master_dev_id) {
  assert(procs.find(pid) == procs.end());
  procs.insert(std::make_pair(pid, std::move(Process::alloc
					     (*this, pid, root_tid, libs, lib_filter,
					      builtin_funcs, proc_addr, master_dev_id))));
  procs.at(pid)->setup();
}

// Delete process.
void VMachine::delete_process(const vpid_t& pid) {
  if (procs.find(pid) == procs.end()) return;
  procs.erase(pid);
}

// Start exiting process.
void VMachine::exit_process(const vpid_t& pid) {
  if (procs.find(pid) == procs.end()) return;
  procs.at(pid)->exit();
}

// Get process instance by process-id.
Process& VMachine::get_process(const vpid_t& pid) {
  return *procs.at(pid);
}

// Check whether process has contain in this device.
bool VMachine::have_process(const vpid_t& pid) {
  return (procs.find(pid) != procs.end());
}

// Change thread status to warp thread.
void VMachine::request_warp_thread(const vpid_t& pid,
				   const vtid_t tid,
				   const dev_id_t& dst_device) {
  auto it_proc = procs.find(pid);
  if (it_proc != procs.end() &&
      (it_proc->second->active_threads.find(tid)) !=
      it_proc->second->active_threads.end()) {
    it_proc->second->get_thread(tid).setup_warpin(dst_device);

  } else {
    send_warp_request(pid, tid, dst_device);
  }
}

// @inheritDoc
std::unique_ptr<VMemory::Accessor> VMachine::assign_accessor(const vpid_t& pid) {
  return std::move(vmemory.get_accessor(Convert::vpid2str(pid)));
}

//
void VMachine::on_change_thread_set(Process& proc) {
  update_proc_list();
}

void VMachine::recv_warp(const vpid_t& pid, picojson::object& json) {
  const vtid_t root_tid = Convert::json2vtid(json.at("root_tid"));
  const vaddr_t proc_addr = Convert::json2vaddr(json.at("proc_addr"));
  const dev_id_t master_device = Convert::json2devid(json.at("master_device"));
  const std::string name = json.at("name").get<std::string>();
  const vtid_t tid = Convert::json2vtid(json.at("tid"));
  const dev_id_t dst_device = Convert::json2devid(json.at("dst_device"));
  const dev_id_t src_device = Convert::json2devid(json.at("src_device"));
  const std::string src_account = json.at("src_account").get<std::string>();
  
  if (device_id != dst_device ||
      !delegate.judge_new_process(name, src_device, src_account)) {
    /// @todo reject
    assert(false);
    return;
  }

  if (!have_process(pid))
    join_process(pid, root_tid, proc_addr, master_device);

  get_process(pid).warp_out_thread(tid);
}

// If recv this packet and this device contain target process and thread,
// change status to warp thread.
void VMachine::recv_warp_request(const vpid_t& pid, picojson::object& json) {
  const vtid_t tid = Convert::json2vtid(json.at("tid"));
  const dev_id_t dst_device = Convert::json2devid(json.at("dst"));
  
  auto it_proc = procs.find(pid);
  if (it_proc != procs.end() &&
      (it_proc->second->active_threads.find(tid)) !=
      it_proc->second->active_threads.end()) {
    it_proc->second->get_thread(tid).setup_warpin(dst_device);
  }
}

// Regist built-in function to virtual machine.
void VMachine::regist_builtin_func(const std::string& name,
				   builtin_func_t func, int i64) {
  BuiltinFuncParam param;
  param.i64 = i64;
  builtin_funcs.insert(std::make_pair(name, std::make_pair(func, param)));
}

// Regist built-in function to virtual machine.
void VMachine::regist_builtin_func(const std::string& name,
				   builtin_func_t func, void* ptr) {
  BuiltinFuncParam param;
  param.ptr = ptr;
  builtin_funcs.insert(std::make_pair(name, std::make_pair(func, param)));
}

// Convert json to machine data packet and send to destination device.
void VMachine::send_packet(const std::string& name, const dev_id_t& dst_device,
			   const std::string& cmd, picojson::object& data) {
  data.insert(std::make_pair("cmd", picojson::value(cmd)));
  data.insert(std::make_pair("src", Convert::devid2json(device_id)));

  delegate.send_machine_data(name, dst_device, picojson::value(data).serialize());
}

// This request means to warp thread to target device.
void VMachine::send_warp(Process& proc, Thread& thread) {
  picojson::object packet;

  packet.insert(std::make_pair("root_tid", Convert::vtid2json(proc.root_tid)));
  packet.insert(std::make_pair("proc_addr", Convert::vaddr2json(proc.addr)));
  packet.insert(std::make_pair("master_device", Convert::devid2json
			       (proc.proc_memory->get_master(proc.addr))));
  packet.insert(std::make_pair("name", picojson::value(proc.name)));
  packet.insert(std::make_pair("tid", Convert::vtid2json(thread.tid)));
  packet.insert(std::make_pair("dst_device", Convert::devid2json(thread.warp_dst)));
  packet.insert(std::make_pair("src_device", Convert::devid2json(device_id)));
  packet.insert(std::make_pair("src_account", picojson::value(delegate.get_account())));
  
  send_packet(proc.pid, thread.warp_dst, "warp", packet);
}

// This request means to broadcast request of warp a thread.
void VMachine::send_warp_request(const vpid_t& pid, const vtid_t tid,
				 const dev_id_t& dst_device) {
  picojson::object packet;

  packet.insert(std::make_pair("cmd", picojson::value(std::string("warp_request"))));
  //packet.insert(std::make_pair("pid", Convert::vpid2json(pid)));
  packet.insert(std::make_pair("tid", Convert::vtid2json(tid)));
  packet.insert(std::make_pair("dst", Convert::devid2json(dst_device)));
  
  send_packet(pid, DEV_BROADCAST, "warp_request", packet);
}

// Setup virtual machine.
void VMachine::setup_builtin() {
  // VMの組み込み関数をロード
  BuiltinBit::regist(*this);
#ifdef ENABLE_GLFW3
  BuiltinGlfw3::regist(*this);
#endif
  BuiltinLibc::regist(*this);
  BuiltinMemory::regist(*this);
  BuiltinOverflow::regist(*this);
  BuiltinPosix::regist(*this);
  BuiltinVaArg::regist(*this);
  BuiltinWarp::regist(*this);
}

// Make new process-tree and send to server.
void VMachine::update_proc_list() {
  std::vector<ProcessTree> packet;

  for (auto& proc : procs) {
    ProcessTree pt;
    pt.pid = proc.second->pid;
    
    for (auto& thread : proc.second->active_threads) {
      pt.threads.insert(std::make_pair(thread, device_id));
    }

    packet.push_back(pt);
  }

  delegate.send_sync_proc_list(packet);
}
