
#include <cstdio>
#include <cstdlib>
#include <exception>
#include <iostream>
#include <map>
#include <memory>

#include <emscripten.h>
#include <emscripten/bind.h>

#include "lib/picojson.h"
#include "convert.hpp"
#include "vmachine.hpp"
#include "vmemory.hpp"

using namespace processwarp;
using namespace emscripten;

/**
 * VMachineDelegate implement using Emscripten.
 */
class WebfrontDelegate : public VMachineDelegate, public VMemoryDelegate {
  // Call when send data to other device.
  void send_machine_data(const vpid_t& pid,
			 const dev_id_t& dst,
			 const std::string& data) override {
    std::stringstream asm_code;
    asm_code << "send_machine_data('" << pid << "',"
	     << "'" << dst << "',"
	     << static_cast<const void*>(data.data()) << ","
	     << data.size() << ");";
    emscripten_run_script(asm_code.str().c_str());
  }

  // Call when send memory data to other device.
  void send_memory_data(const std::string& name,
			const dev_id_t& dst,
			const std::string& data) override {
    std::stringstream asm_code;
    asm_code << "send_memory_data('" << name << "',"
	     << "'" << dst << "',"
	     << static_cast<const void*>(data.data()) << ","
	     << data.size() << ");";
    emscripten_run_script(asm_code.str().c_str());
  }

  // Call when change process and thread status running on this virtual machine.
  void send_sync_proc_list(const std::vector<ProcessTree>& procs) override {
    picojson::array js_procs;
    
    for (auto& proc : procs) {
      picojson::object js_proc;
      js_proc.insert(std::make_pair("pid", Convert::vpid2json(proc.pid)));
      js_proc.insert(std::make_pair("name", picojson::value(proc.name)));

      picojson::object js_threads;
      for (auto& thread : proc.threads) {
	js_threads.insert(std::make_pair(Convert::vtid2str(thread.first),
					 Convert::devid2json(thread.second)));
      }
      js_proc.insert(std::make_pair("threads", picojson::value(js_threads)));
    }
    std::string js = picojson::value(js_procs).serialize();
    std::stringstream asm_code;
    asm_code << "send_sync_proc_list('" << js << "');";
    emscripten_run_script(asm_code.str().c_str());
  }

  // Call when context switch of process.
  void on_switch_proccess(const vpid_t& pid) override {
    std::stringstream asm_code;

    if (pid.empty()) {
      emscripten_run_script("unwind_process();");

    } else {
      asm_code << "switch_process('" << pid << "');";
      emscripten_run_script(asm_code.str().c_str());
    }
  }

  // Call when process was finish.
  void on_finish_proccess(const vpid_t& pid) override {
    std::stringstream asm_code;
    asm_code << "finish_process('" << pid << "');";
    emscripten_run_script(asm_code.str().c_str());
  }

  // Call when rise error.
  void on_error(const vpid_t& pid, const std::string& message) override {
    std::stringstream asm_code;
    asm_code << "error_process('" << pid << "');";
    emscripten_run_script(asm_code.str().c_str());
  }

  // Call when new process is arrive.
  bool judge_new_process(const std::string& name,
			 const dev_id_t& src_device,
			 const std::string& src_account) override {
    std::stringstream asm_code;
    asm_code << "judge_new_process('" << name
	     << "', '" << src_device
	     << "', '" << src_account << "');";
    int r = emscripten_run_script_int(asm_code.str().c_str());
    return r != 0;
  }
};

/** Empty libraries because don't use dlsym on Emscripten. */
static std::vector<void*> LIBS;
static std::map<std::string, std::string> lib_filter;

/** Instance of delegate. */
WebfrontDelegate delegate;
/** Instance of virtual machine. */
std::unique_ptr<VMachine> vm;

/** Main loop for Emscripten. */
static void ems_loop() {
  if (vm.get() != nullptr) {
    vm->loop();
  }
}

void init_lib_filter() {
  static const char* API_NAME_PAIR[][2] = {
    {"printf", "printf"}
  };

  for (unsigned int i = 0; i < sizeof(API_NAME_PAIR) / sizeof(API_NAME_PAIR[0]); i ++) {
    lib_filter.insert(std::make_pair(API_NAME_PAIR[i][0], API_NAME_PAIR[i][1]));
  }
}

void recv_machine_data(const vpid_t& pid,
		       const dev_id_t& src,
		       const dev_id_t& dst,
		       const std::string& data) {
  if (dst == vm->device_id ||
      (dst == DEV_BROADCAST && src != vm->device_id)) {
    assert(src != vm->device_id);
    vm->recv_machine_data(pid, data);
  }
}

void recv_memory_data(const std::string& name,
		      const dev_id_t& src,
		      const dev_id_t& dst,
		      const std::string& data) {
  if (dst == vm->device_id ||
      (dst == DEV_BROADCAST && src != vm->device_id)) {
    assert(src != vm->device_id);
    vm->vmemory.recv_memory_data(name, data);
  }
}

void recv_sync_proc_list(const std::string& js_str) {
  picojson::value js_tmp;
  std::istringstream is(js_str);
  std::string err = picojson::parse(js_tmp, is);
  if (!err.empty()) {
    /// @todo error
    assert(false);
  }

  std::vector<ProcessTree> procs;
  for (auto& it_proc : js_tmp.get<picojson::array>()) {
    picojson::object& js_proc = it_proc.get<picojson::object>();    
    ProcessTree proc;

    proc.pid  = Convert::json2vpid(js_proc.at("pid"));
    proc.name = js_proc.at("name").get<std::string>();

    picojson::object& js_threads = js_proc.at("threads").get<picojson::object>();
    for (auto& it_thread : js_threads) {
      proc.threads.insert(std::make_pair(Convert::str2vtid(it_thread.first),
					 Convert::json2devid(it_thread.second)));
    }
    procs.push_back(proc);
  }

  vm->recv_sync_proc_list(procs);
}

void set_device_id(const dev_id_t& device_id) {
  vm.reset(new VMachine(delegate, delegate, device_id, LIBS, lib_filter));
}

void exit_process(const vpid_t& pid) {
  vm->exit_process(pid);
}

void warp_process(const vpid_t& pid, const dev_id_t& device_id) {
  vtid_t tmp = 1; ///< TODO
  vm->warp_process(pid, tmp, device_id);
}

/**
 * Entry point for Emscripten.
 * This function must not return.
 * @return return code.
 */
int main() {
  init_lib_filter();
  // set main loop for Emscripten
  emscripten_set_main_loop(ems_loop, 0, true);
  
  return EXIT_SUCCESS;
}

EMSCRIPTEN_BINDINGS(mod) {
  function("recv_machine_data", &recv_machine_data);
  function("recv_memory_data",  &recv_memory_data);
  function("recv_sync_proc_list", &recv_sync_proc_list);
  function("set_device_id",  &set_device_id);
  function("exit_process",   &exit_process);
  function("warp_process",   &warp_process);
}
