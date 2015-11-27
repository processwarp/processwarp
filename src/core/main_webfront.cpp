
#include <emscripten.h>
#include <emscripten/bind.h>

#include <picojson.h>

#include <cstdio>
#include <cstdlib>
#include <exception>
#include <iostream>
#include <map>
#include <memory>
#include <string>
#include <vector>

#include "convert.hpp"
#include "vmachine.hpp"
#include "vmemory.hpp"

namespace processwarp {

/**
 * VMachineDelegate implement using Emscripten.
 */
class MainWebfront : public VMachineDelegate, public VMemoryDelegate {
 public:
  /** Empty libraries because don't use dlsym on Emscripten. */
  std::vector<void*> LIBS;
  std::map<std::string, std::string> lib_filter;
  /** Instance of virtual machine. */
  std::unique_ptr<VMachine> vm;

  /**
   * Initialize lib filter.
   * Convert list to map of api name in vm and ffi.
   */
  void init_lib_filter() {
    static const char* API_NAME_PAIR[][2] = {
      {"printf", "printf"},
      {"puts",   "puts"}
    };

    for (unsigned int i = 0;
         i < sizeof(API_NAME_PAIR) / sizeof(API_NAME_PAIR[0]); i ++) {
      lib_filter.insert(std::make_pair(API_NAME_PAIR[i][0],
                                       API_NAME_PAIR[i][1]));
    }
  }

  /**
   * Initialize instance.
   * Call all initialize methods.
   */
  void init() {
    init_lib_filter();
  }

  /**
   * Setup instance of virtual machine with device-id.
   */
  void set_device_id(const dev_id_t& device_id) {
    vm.reset(new VMachine(*this, *this, device_id, LIBS, lib_filter));
    vm->setup_builtin();
  }


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
      js_procs.push_back(picojson::value(js_proc));
    }
    std::string js = picojson::value(js_procs).serialize();
    std::stringstream asm_code;
    asm_code << "send_sync_proc_list('" << js << "');";
    emscripten_run_script(asm_code.str().c_str());
  }

  /**
   * Call when memory is update by other node.
   * Relay event to instance of virtual-machine.
   */
  void on_recv_update(const std::string& name, vaddr_t addr) override {
    if (vm.get() != nullptr) {
      vm->on_recv_update(Convert::str2vpid(name), addr);
    }
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

  // Call when get login account information.
  std::string get_account() override {
    std::stringstream asm_code;
    asm_code << "get_account();";
    return emscripten_run_script_string(asm_code.str().c_str());
  }
};

/** Instance of delegate. */
MainWebfront webfront;

/** Main loop for Emscripten. */
static void ems_loop() {
  if (webfront.vm.get() != nullptr) {
    webfront.vm->loop();
  }
}

void recv_machine_data(const vpid_t& pid,
                       const dev_id_t& src,
                       const dev_id_t& dst,
                       const std::string& data) {
  if (dst == webfront.vm->device_id ||
      (dst == DEV_BROADCAST && src != webfront.vm->device_id)) {
    assert(src != webfront.vm->device_id);
    webfront.vm->recv_machine_data(pid, data);
  }
}

void recv_memory_data(const std::string& name,
                      const dev_id_t& src,
                      const dev_id_t& dst,
                      const std::string& data) {
  if (dst == webfront.vm->device_id ||
      (dst == DEV_BROADCAST && src != webfront.vm->device_id)) {
    assert(src != webfront.vm->device_id);
    webfront.vm->vmemory.recv_memory_data(name, data);
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

    picojson::object& js_threads =
        js_proc.at("threads").get<picojson::object>();
    for (auto& it_thread : js_threads) {
      proc.threads.insert
          (std::make_pair(Convert::str2vtid(it_thread.first),
                          Convert::json2devid(it_thread.second)));
    }
    procs.push_back(proc);
  }

  webfront.vm->recv_sync_proc_list(procs);
}

void set_device_id(const dev_id_t& device_id) {
  webfront.set_device_id(device_id);
}

void quit_process(const vpid_t& pid) {
  webfront.vm->terminate_process(pid);
}

void request_warp_thread(const std::string& pid,
                         const std::string& tid,
                         const dev_id_t& dst_device) {
  webfront.vm->request_warp_thread(Convert::str2vpid(pid),
                                   Convert::str2vtid(tid),
                                   Convert::str2devid(dst_device));
}
}  // namespace processwarp

/**
 * Entry point for Emscripten.
 * This function must not return.
 * @return return code.
 */
int main() {
  processwarp::webfront.init();
  // set main loop for Emscripten
  emscripten_set_main_loop(processwarp::ems_loop, 0, true);

  return EXIT_SUCCESS;
}

EMSCRIPTEN_BINDINGS(mod) {
  emscripten::function("recv_machine_data", &processwarp::recv_machine_data);
  emscripten::function("recv_memory_data",  &processwarp::recv_memory_data);
  emscripten::function("recv_sync_proc_list", &processwarp::recv_sync_proc_list);
  emscripten::function("request_warp_thread", &processwarp::request_warp_thread);
  emscripten::function("set_device_id",  &processwarp::set_device_id);
  emscripten::function("quit_process",   &processwarp::quit_process);
}
