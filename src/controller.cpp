
#include "controller.hpp"
#include "convert.hpp"
#include "definitions.hpp"
#include "error.hpp"
#include "vmemory.hpp"

using namespace processwarp;

// Destructor for virtual.
ControllerDelegate::~ControllerDelegate() {
  // Do nothing.
}
    
// Call when send data to other device.
void ControllerDelegate:: send_warp_data(const std::string& pid,
					 const std::string& tid,
					 const std::string& dst_device_id,
					 const std::string& data) {
  // Do nothing.
}
    
// Call when context switch of process.
void ControllerDelegate::on_switch_proccess(const std::string& pid) {
  // Do nothing.
}

// Call when process was finish.
void ControllerDelegate::on_finish_proccess(const std::string& pid) {
  // Do nothing.
}

// Call when rise error.
void ControllerDelegate::on_error(const std::string& pid,
				  const std::string& message) {
  // Do nothing.
}

// Constractor with delegate.
Controller::Controller(ControllerDelegate& _delegate) :
  delegate(_delegate) {
  // Do nothing.
}

// Main loop.
void Controller::loop() {
  std::string pid;
  try {
    auto it = procs.begin();
    while (it != procs.end()) {
      pid = it->first;
      VMachine& vm = *it->second;

      if (vm.status == VMachine::ACTIVE ||
	  vm.status == VMachine::WAIT_WARP ||
	  vm.status == VMachine::BEFOR_WARP ||
	  vm.status == VMachine::AFTER_WARP) {

	delegate.on_switch_proccess(pid);
	// Execute llvm cycle.
	vm.execute(100);

      } else if (vm.status == VMachine::WARP) {
	do_warp_process(pid);
	
      } else if (vm.status == VMachine::ERROR) {
	delegate.on_error(pid, "");
	
      } else if (vm.status == VMachine::FINISH) {
	delegate.on_finish_proccess(pid);
	it = procs.erase(it);
	continue;
      }
      it ++;
    }
    
  } catch (Error e) {
    delegate.on_error(pid, "");
    
  } catch (std::exception e) {
    delegate.on_error(pid, e.what());
    
  } catch (...) {
    delegate.on_error(pid, "unknown exception");
  }
  
  delegate.on_switch_proccess("");
}
    
// Pass data from other device.
bool Controller::recv_warp_data(const std::string& pid,
				const std::string& tid,
				const std::string& data) {
  try {
    picojson::value v;
    std::istringstream is(data);
    std::string err = picojson::parse(v, is);
    if (!err.empty()) {
      std::cerr << err << std::endl;
      return false;
    }
    
    picojson::object json = v.get<picojson::object>();

    // select cmd
    std::string cmd = json.at("cmd").get<std::string>();
    if (cmd == "warp") {
      recv_process_warp(pid, json);
    
    } else {
      assert(false);
      return false;
    }

    return true;
    
  } catch (Error e) {
    std::cerr << e.reason << ":" << e.mesg << std::endl;
    return false;
    
  } catch (std::exception e) {
    std::cerr << e.what() << std::endl;
    return false;
    
  } catch (...) {
    std::cerr << "unknown exception" << std::endl;
    return false;
  }
}

// Create empty process.
void Controller::create_process(const std::string& pid,
				std::vector<void*> libs,
				const std::map<std::string, std::string>& lib_filter) {
  assert(procs.find(pid) == procs.end());
  procs.insert(std::make_pair(pid, std::shared_ptr<VMachine>
			      (new VMachine(libs, lib_filter))));
  procs.at(pid)->setup();
}

// Delete process.
void Controller::delete_process(const std::string& pid) {
  if (procs.find(pid) == procs.end()) return;
  procs.erase(pid);
  warp_dest.erase(pid);
}

// Start exiting process.
void Controller::exit_process(const std::string& pid) {
  if (procs.find(pid) == procs.end()) return;
  procs.at(pid)->exit();
}

// Start warp process.
void Controller::warp_process(const std::string& pid,
			      const std::string& dst_device_id) {
  warp_dest[pid] = dst_device_id;
  // Change vm's status for setup to warp.
  procs.at(pid)->setup_warpin(device_id);
}

// Dump and send data to warp process. 
void Controller::do_warp_process(std::string pid) {
  VMachine& vm      = *procs.at(pid);
  VMemory&  vmemory = vm.vmemory;
  
  // Dump process.
  Convert convert(vm);
  Convert::Related related;
  picojson::object body;
  picojson::object dump;
  body.insert(std::make_pair("cmd", picojson::value(std::string("warp"))));
  body.insert(std::make_pair("pid", picojson::value(pid)));
  // body.insert(std::make_pair("to", picojson::value(device_id)));
  body.insert(std::make_pair("thread", convert.export_thread(*(vm.threads.back()), related)));
  std::set<vaddr_t> all = vm.vmemory.get_alladdr();
  for (auto it : all) {
    // Don't export null instance.
    if (it == VADDR_NULL || it == VADDR_NON) continue;
    // Don't export build in instance.
    if (vm.builtin_addrs.find(it) != vm.builtin_addrs.end()) continue;
    
    dump.insert(std::make_pair(Util::vaddr2str(it), convert.export_store(it, related)));
    // Free allocated data.
    if (!VMemory::addr_is_func(it) && !VMemory::addr_is_type(it)) {
      vmemory.free(it);
    }
  }
  body.insert(std::make_pair("dump", picojson::value(dump)));

  std::string data = picojson::value(body).serialize();
  delegate.send_warp_data(pid, "1", warp_dest.at(pid), data);

  warp_dest.erase(pid);
  vm.status = VMachine::PASSIVE;
}

void Controller::recv_process_warp(std::string pid, picojson::object& json) {
  VMachine& vm      = *procs.at(pid);
  VMemory&  vmemory = vm.vmemory;
  Convert convert(vm);
  
  // Expand transported instance data.
  picojson::object dump = json.at("dump").get<picojson::object>();
  for (auto it : dump) {
    if(!vmemory.addr_is_used(Util::str2vaddr(it.first))) {
      convert.import_store(Util::str2vaddr(it.first), it.second);
    }
  }

  // Expand thread data.
  convert.import_thread(json.at("thread"));
  
  vm.setup_warpout();
  
  // Turn on vm.
  vm.status = VMachine::ACTIVE;
}
