
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
void VMachineDelegate::send_vm_data(const vpid_t& pid,
				    const vtid_t& tid,
				    const dev_id_t& dst_device_id,
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
    auto it_proc = procs.begin();
    while (it_proc != procs.end()) {
      pid  = it_proc->first;
      proc = it_proc->second.get();

      auto it_thread = proc->active_threads.begin();
      while(it_thread != proc->active_threads.end()) {
	try {
	  tid    = *it_thread;
	  thread = &proc->get_thread(tid);
	  
	  if (thread->status == Thread::NORMAL ||
	      thread->status == Thread::WAIT_WARP ||
	      thread->status == Thread::BEFOR_WARP ||
	      thread->status == Thread::AFTER_WARP) {
	  
	    delegate.on_switch_proccess(pid);
	    // run thread
	    proc->execute(tid, 100);

	  } else if (thread->status == Thread::WARP) {
	    do_warp_process(pid);
	  
	  } else if (thread->status == Thread::ERROR) {
	    delegate.on_error(pid, "");
	
	  } else if (thread->status == Thread::FINISH) {
	    delegate.on_finish_thread(pid, tid);

	    if (tid == proc->root_tid) {
	      delegate.on_finish_proccess(pid);
	      it_proc = procs.erase(it_proc);
	      // continue double loop
	      goto next_proc;

	    } else {
	      it_thread = proc->active_threads.erase(it_thread);
	      proc->threads.erase(tid);
	      proc->proc_memory->free(tid);
	      continue;
	    }
	  }
	} catch (VMemory::WaitingException& e) {
	  // Skip thread because waiting to update memroy data.
	}

	it_thread ++;
      }

      it_proc ++;
    next_proc:
      ;
    }
    
  } catch (Error& e) {
    delegate.on_error(pid, "");
    thread->status = Thread::FINISH;
    
  }
#ifdef NDEBUG
  catch (std::exception& e) {
    delegate.on_error(pid, e.what());
    thread->status = Thread::FINISH;
    
  } catch (...) {
    delegate.on_error(pid, "unknown exception");
    thread->status = Thread::FINISH;
  }
#endif
  
  delegate.on_switch_proccess("");
}
    
// Pass data from other device.
void VMachine::recv_packet(const vpid_t& pid,
			   const vtid_t& tid,
			   const std::string& data) {
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
      recv_process_warp(pid, json);
    
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

// Create empty process.
void VMachine::create_process(const vpid_t& pid, const vtid_t& root_tid, vaddr_t proc_addr) {
  assert(procs.find(pid) == procs.end());
  procs.insert(std::make_pair(pid, std::move(Process::alloc
					     (*this, pid, root_tid, libs, lib_filter, builtin_funcs, proc_addr))));
  procs.at(pid)->setup();
}

// Delete process.
void VMachine::delete_process(const vpid_t& pid) {
  if (procs.find(pid) == procs.end()) return;
  procs.erase(pid);
  warp_dest.erase(pid);
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

// Start warp process.
void VMachine::warp_process(const vpid_t& pid,
			    const vtid_t& tid,
			    const dev_id_t& dst_device_id) {
  warp_dest[pid] = dst_device_id;
  // Change vm's status for setup to warp.
  if (tid == ALL_THREAD) {
    for (auto& it : procs.at(pid)->active_threads) {
      procs.at(pid)->setup_warpin(it, dst_device_id);
    }

  } else {
    procs.at(pid)->setup_warpin(tid, dst_device_id);
  }
}

// @inheritDoc
std::unique_ptr<VMemory::Accessor> VMachine::assign_accessor(const vpid_t& pid) {
  return std::move(vmemory.get_accessor(Convert::vpid2str(pid)));
}

// Dump and send data to warp process. 
void VMachine::do_warp_process(const vpid_t& pid) {
  /// TODO:
  assert(false);
  /*
  Process& proc    = *procs.at(pid);
  VMemory::Accessor& memory = *proc.proc_memory;
  
  // Dump process.
  Convert convert(proc);
  Convert::Related related;
  picojson::object body;
  picojson::object dump;
  picojson::object threads;
  body.insert(std::make_pair("cmd", picojson::value(std::string("warp"))));
  body.insert(std::make_pair("pid", Convert::vpid2json(pid)));
  body.insert(std::make_pair("root_tid", Convert::vtid2json(proc.root_tid)));
  for (auto& it : proc.threads) {
    threads.insert(std::make_pair(Convert::vtid2str(it.first),
				  convert.export_thread(*it.second, related)));
  }
  body.insert(std::make_pair("threads", picojson::value(threads)));

  std::set<vaddr_t> all = proc.vmemory.get_alladdr();
  for (auto it : all) {
    // Don't export null instance.
    if (it == VADDR_NULL || it == VADDR_NON) continue;
    // Don't export build in instance.
    if (proc.builtin_addrs.find(it) != proc.builtin_addrs.end()) continue;
    
    dump.insert(std::make_pair(Util::vaddr2str(it), convert.export_store(it, related)));
    // Free allocated data.
    if (!VMemory::addr_is_func(it) && !VMemory::addr_is_type(it)) {
      vmemory.free(it);
    }
  }
  body.insert(std::make_pair("dump", picojson::value(dump)));

  std::string data = picojson::value(body).serialize();
  delegate.send_warp_data(pid, 1, warp_dest.at(pid), data);

  warp_dest.erase(pid);
  for (auto& it_thread : proc.threads) {
    it_thread.second->status = Thread::PASSIVE;
  }
  */
}

void VMachine::recv_process_warp(const vpid_t& pid, picojson::object& json) {
  /// TODO
  assert(false);
  /*
  Process& proc = *procs.at(pid);
  VMemory& vmemory = proc.vmemory;
  Convert convert(proc);
  
  // Expand transported instance data.
  picojson::object dump = json.at("dump").get<picojson::object>();
  for (auto it : dump) {
    if(!vmemory.addr_is_used(Util::str2vaddr(it.first))) {
      convert.import_store(Util::str2vaddr(it.first), it.second);
    }
  }

  // Expand thread data.
  for (auto& it : json.at("threads").get<picojson::object>()) {
    convert.import_thread(Util::hex_str2num<vtid_t>(it.first), it.second);
  }
  
  proc.setup_warpout(1);
  
  // Turn on proc.
  for (auto& it_thread : proc.threads) {
    it_thread.second->status = Thread::NORMAL;
  }
  */
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
