
#include <cstdio>
#include <cstdlib>
#include <exception>
#include <iostream>
#include <map>

#include <emscripten.h>
#include <emscripten/bind.h>

#include "controller.hpp"
#include "convert.hpp"

using namespace processwarp;
using namespace emscripten;

/**
 * ControllerDelegate implement using Emscripten.
 */
class WebfrontDelegate : public ControllerDelegate {
  // Call when send data to other device.
  void send_warp_data(const vpid_t& pid,
		      const vtid_t& tid,
		      const dev_id_t& dst_device_id,
		      const std::string& data) override {
    std::stringstream asm_code;
    asm_code << "send_warp_data('" << pid << "',"
	     << "'" << tid << "',"
	     << "'" << dst_device_id << "',"
	     << static_cast<const void*>(data.data()) << ","
	     << data.size() << ");";
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
};

/** Empty libraries because don't use dlsym on Emscripten. */
static std::vector<void*> LIBS;
static std::map<std::string, std::string> lib_filter;

/** Instance of delegate. */
WebfrontDelegate delegate;
/** Instance of controller. */
Controller controller(delegate);

/** Main loop for Emscripten. */
static void ems_loop() {
  controller.loop();
}

void init_lib_filter() {
  static const char* API_NAME_PAIR[][2] = {
    {"printf", "printf"}
  };

  for (unsigned int i = 0; i < sizeof(API_NAME_PAIR) / sizeof(API_NAME_PAIR[0]); i ++) {
    lib_filter.insert(std::make_pair(API_NAME_PAIR[i][0], API_NAME_PAIR[i][1]));
  }
}

bool recv_warp_data(const vpid_t& pid, std::string tid, const std::string& data) {
  return controller.recv_warp_data(pid, Convert::str2vtid(tid), data);
}

void set_device_id(const dev_id_t& device_id) {
  controller.device_id = device_id;
}

void create_process(const vpid_t& pid) {
  controller.create_process(pid, LIBS, lib_filter);
}

void delete_process(const vpid_t& pid) {
  controller.delete_process(pid);
}

void exit_process(const vpid_t& pid) {
  controller.exit_process(pid);
}

void warp_process(const vpid_t& pid, const dev_id_t& device_id) {
  vtid_t tmp = 1; ///< TODO
  controller.warp_process(pid, tmp, device_id);
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
  function("recv_warp_data", &recv_warp_data);
  function("set_device_id",  &set_device_id);
  function("create_process", &create_process);
  function("delete_process", &delete_process);
  function("exit_process",   &exit_process);
  function("warp_process",   &warp_process);
}
