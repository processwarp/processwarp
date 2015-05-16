
#include <cstdio>
#include <cstdlib>
#include <exception>
#include <iostream>
#include <map>

#include <emscripten.h>
#include <emscripten/bind.h>

#include "convert.hpp"
#include "definitions.hpp"
#include "error.hpp"
#include "vmachine.hpp"

using namespace processwarp;
using namespace emscripten;

//#ifndef __EMSCRIPTEN__

// EMSCRIPTENではdlsymを使わないので空にする
static std::vector<void*> LIBS;
static std::string device_id;

struct Process {
  // VM per process
  std::unique_ptr<VMachine> vm;
  //
  std::string warp_dest_device_id;
};

// List of processes
static std::map<std::string, Process> processes;

void warp_process(std::string pid);

// main loop for Emscripten
static void ems_loop() {
  std::string pid;
  try {
    for (auto it = processes.begin(); it != processes.end(); it ++) {
      pid = it->first;
      VMachine& vm = *(it->second.vm);
      if (vm.status == VMachine::ACTIVE ||
	  vm.status == VMachine::WAIT_WARP ||
	  vm.status == VMachine::BEFOR_WARP ||
	  vm.status == VMachine::AFTER_WARP) {
	// tell context switch for javascript
	std::stringstream asm_code;
	asm_code << "switch_process('" << pid << "');";
	emscripten_run_script(asm_code.str().c_str());
	// execute llvm cycle
	vm.execute(100);

      } else if (vm.status == VMachine::WARP) {
	warp_process(pid);
	
      } else if (vm.status == VMachine::ERROR) {
	// tell process finished for javascript
	std::stringstream asm_code;
	asm_code << "error_process('" << pid << "');";
	emscripten_run_script(asm_code.str().c_str());
	
      } else if (vm.status == VMachine::FINISH) {
	// tell process finished for javascript
	std::stringstream asm_code;
	asm_code << "release_process('" << pid << "');";
	emscripten_run_script(asm_code.str().c_str());
      }
    }
    
  } catch (Error e) {
    // tell exception for javascript
    std::stringstream asm_code;
    asm_code << "error_process('" << pid << "');";
    emscripten_run_script(asm_code.str().c_str());
    
  } catch (std::exception e) {
    std::cerr << e.what() << std::endl;
    
  } catch (...) {
    std::cerr << "unknown exception" << std::endl;
  }
  
  // tell unwind for javascript
  emscripten_run_script("unwind_process();");
}


void recv_process_warp(std::string pid, picojson::object& json) {
  Process& process = processes.at(pid);
  Convert  convert(*process.vm);

  // 転送されたインスタンスを展開
  picojson::object dump = json.at("dump").get<picojson::object>();
  for (auto it = dump.begin(); it != dump.end(); it ++) {
    convert.import_store(Util::str2vaddr(it->first), it->second);
  }

  // スレッドを展開
  convert.import_thread(json.at("thread"));
  
  process.vm->setup_warpout();
  
  // ステータスを変更して実行状態に
  process.vm->status = VMachine::ACTIVE;
}

bool recv_warp_data(const std::string& data) {
  try {
    picojson::value v;
    std::istringstream is(data);
    std::string err = picojson::parse(v, is);
    if (!err.empty()) {
      std::cerr << err << std::endl;
      exit(EXIT_FAILURE);
    }
    
    picojson::object json = v.get<picojson::object>();

    assert(json.find("pid") != json.end());
    std::string pid = json.at("pid").get<std::string>();
  
    // select cmd
    std::string cmd = json.at("cmd").get<std::string>();
    if (cmd == "warp") {
      recv_process_warp(pid, json);
    
    } else {
      assert(false);
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

void set_device_id(std::string _device_id) {
  device_id = _device_id;
}

void create_process(std::string pid) {
  // 同じプロセスは作らないはず
  assert(processes.find(pid) == processes.end());
  Process& process = processes[pid];
  process.vm.reset(new VMachine(LIBS));
  process.vm->setup();
}

void delete_process(std::string pid) {
  // プロセスが存在する場合削除
  if (processes.find(pid) != processes.end()) {
    processes.erase(pid);
  }
}

void setup_exit(std::string pid) {
  if (processes.find(pid) == processes.end()) return;
  Process& process = processes.at(pid);
  VMachine& vm     = *(process.vm);
  vm.exit();
}

void setup_warp(std::string pid, std::string device_id) {
  Process& process = processes.at(pid);
  process.warp_dest_device_id = device_id;
  // Change vm's status for setup to warp.
  process.vm->setup_warpin(device_id);
}

void warp_process(std::string pid) {
  Process&  process = processes.at(pid);
  VMachine& vm      = *(process.vm);
  
  // プログラムをダンプ
  Convert convert(vm);
  Convert::Related related;
  picojson::object body;
  picojson::object dump;
  body.insert(std::make_pair("cmd",    picojson::value(std::string("warp"))));
  body.insert(std::make_pair("pid",    picojson::value(pid)));
  //body.insert(std::make_pair("to",     picojson::value(device_id)));
  body.insert(std::make_pair("thread", convert.export_thread(*(vm.threads.back()), related)));
  std::set<vaddr_t> all = vm.vmemory.get_alladdr();
  for (auto it = all.begin(); it != all.end(); it ++) {
    // NULLはexportしない
    if (*it == VADDR_NULL || *it == VADDR_NON) continue;
    // VM組み込みのアドレスはexportしない
    if (vm.intrinsic_addrs.find(*it) != vm.intrinsic_addrs.end()) continue;
    
    dump.insert(std::make_pair(Util::vaddr2str(*it), convert.export_store(*it, related)));
  }
  body.insert(std::make_pair("dump", picojson::value(dump)));

  std::string data = picojson::value(body).serialize();
  std::stringstream asm_code;
  asm_code << "send_warp_data('" << pid << "', "
	   << "'" << process.warp_dest_device_id << "', "
	   << static_cast<const void*>(data.data()) << ", "
	   << data.size() << ");";
  emscripten_run_script(asm_code.str().c_str());

  vm.status = VMachine::PASSIVE;
}

/**
 * Entry point for Emscripten.
 * This function must not return.
 * @return return code
 */
int main() {
  // set main loop for Emscripten
  emscripten_set_main_loop(ems_loop, 0, true);
  
  return EXIT_SUCCESS;
}

EMSCRIPTEN_BINDINGS(mod) {
  function("recv_warp_data", &recv_warp_data);
  function("set_device_id",  &set_device_id);
  function("create_process", &create_process);
  function("delete_process", &delete_process);
  function("setup_exit",     &setup_exit);
  function("setup_warp",     &setup_warp);
}

//#endif
