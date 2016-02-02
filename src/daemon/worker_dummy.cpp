
#include <dlfcn.h>

#include <cassert>
#include <fstream>
#include <iostream>
#include <string>

#include "router.hpp"
#include "worker_dummy.hpp"

namespace processwarp {
#ifdef WORKER_DUMMY
/**
 * WorkerDummy instance getter as singleton pattern.
 * @return The singleton instance of WorkerDummy class.
 */
WorkerDummy& WorkerDummy::get_instance() {
  static WorkerDummy instance;
  return instance;
}

/**
 * Initialize for WorkerDummy.
 * Read configuration file and setup loop for VM.
 * @param loop_ libuv's loop for WorkerDummy.
 * @param pipe_path_ Not used.
 * @param config_file Config filename to pass worker.
 */
void WorkerDummy::initialize(uv_loop_t* loop_, const std::string& pipe_path_,
                             const std::string& config_file) {
  loop = loop_;
  read_config(config_file);
  initialize_loop();
}

/**
 * Create new vm that is run in the same process with backend process.
 * @param pid Process-id for new vm.
 * @param root_tid Root thread-id for new vm.
 * @param proc_addr Address of process information for new vm.
 * @param master_nid Node-id of master node for new vm.
 */
void WorkerDummy::create_vm(const vpid_t& pid, vtid_t root_tid, vaddr_t proc_addr,
                            const nid_t& master_nid) {
  assert(vms.find(pid) == vms.end());

  Router& router = Router::get_instance();

  std::unique_ptr<VMachine> vm(new VMachine(*this, *this,
                                            router.get_my_nid(), libs, lib_filter));
  vm->initialize(pid, root_tid, proc_addr, master_nid);
  vm->initialize_gui(*this);

  vms.insert(std::make_pair(pid, std::move(vm)));
}

/**
 * When relay command is require, do it to target module in dummy module's vm .
 * @param packet Command packet.
 */
void WorkerDummy::relay_command(const CommandPacket& packet) {
  auto it_vm = vms.find(packet.pid);
  if (it_vm == vms.end()) return;
  VMachine& vm = *it_vm->second;

  switch (packet.module) {
    case Module::MEMORY: {
      vm.vmemory.recv_command(packet);
    } break;

    case Module::VM: {
      vm.recv_command(packet);
    } break;

    default: {
      /// @todo error
      assert(false);
    }
  }
}

/**
 * When vmachine require send command, relay it to router direct, instead of through backend.
 * @param vm Caller instance.
 * @param dst_nid Destination node-id.
 * @param module Target module.
 * @param command Command string.
 * @param param Parameter for command.
 */
void WorkerDummy::vmachine_send_command(VMachine& vm, const nid_t& dst_nid, Module::Type module,
                                        const std::string& command, picojson::object& param) {
  assert(param.find("command") == param.end());

  param.insert(std::make_pair("command", picojson::value(command)));

  vpid_t pid;
  for (auto& it_vm : vms) {
    if (it_vm.second.get() == &vm) {
      pid = it_vm.first;
    }
  }
  assert(!pid.empty());

  CommandPacket packet = {
    pid,
    dst_nid,
    SpecialNID::NONE,
    module,
    param
  };

  Router& router = Router::get_instance();
  router.relay_command(packet);
}

void WorkerDummy::vmachine_finish(VMachine& vm) {
  /// @todo
  assert(false);
}

void WorkerDummy::vmachine_finish_thread(VMachine& vm, const vtid_t& tid) {
  /// @todo
  assert(false);
}

void WorkerDummy::vmachine_error(VMachine& vm, const std::string& message) {
  /// @todo
  assert(false);
}

/**
 * When vmemory require send command, relay it to router direct, instead of through backend.
 * @param memory Caller instance.
 * @param dst_nid Destination node-id.
 * @param module Target module.
 * @param command Command string.
 * @param param Parameter for command.
 */
void WorkerDummy::vmemory_send_command(VMemory& memory, const nid_t& dst_nid,
                                       Module::Type module, const std::string& command,
                                       picojson::object& param) {
  assert(param.find("command") == param.end());

  param.insert(std::make_pair("command", picojson::value(command)));

  vpid_t pid;
  for (auto& it_vm : vms) {
    if (&(it_vm.second->vmemory) == &memory) {
      pid = it_vm.first;
      break;
    }
  }
  assert(!pid.empty());

  CommandPacket packet = {
    pid,
    dst_nid,
    SpecialNID::NONE,
    module,
    param
  };

  Router& router = Router::get_instance();
  router.relay_command(packet);
}

/**
 * When vmemory tell update memory image by another node, relay this event to vm.
 * @param memory Caller instance.
 * @param addr Address updated.
 */
void WorkerDummy::vmemory_recv_update(VMemory& memory, vaddr_t addr) {
  vpid_t pid;
  for (auto& it_vm : vms) {
    if (&(it_vm.second->vmemory) == &memory) {
      pid = it_vm.first;
      break;
    }
  }

  VMachine& vm = *vms.at(pid);
  vm.on_recv_update(addr);
}

/**
 * When vmemory require send command, relay it to router direct, instead of through backend.
 * @param proc Caller instance.
 * @param dst_nid Destination node-id.
 * @param module Target module.
 * @param command Command string.
 * @param param Parameter for command.
 */
void WorkerDummy::builtin_gui_send_command(Process& proc, const nid_t& dst_nid,
                                           Module::Type module, const std::string& command,
                                           picojson::object& param) {
  assert(param.find("command") == param.end());

  param.insert(std::make_pair("command", picojson::value(command)));

  CommandPacket packet = {
    proc.pid,
    dst_nid,
    SpecialNID::NONE,
    module,
    param
  };

  Router& router = Router::get_instance();
  router.relay_command(packet);
}

/**
 * When real process is idle, execute vm instructions.
 * @param handle
 */
void WorkerDummy::on_idle(uv_idle_t* handle) {
  WorkerDummy& THIS = *reinterpret_cast<WorkerDummy*>(handle->data);

  for (auto& it_vm : THIS.vms) {
    it_vm.second->execute();
  }
}

/**
 * Initialize virtual machine execute loop.
 * By using libuv, it can call virtual machine loop method while CPU is idle.
 */
void WorkerDummy::initialize_loop() {
  int r;

  r = uv_idle_init(loop, &idle);
  if (r) {
    /// @todo error
    fprintf(stderr, "idle init %s\n", uv_err_name(r));
    assert(false);
  }

  idle.data = this;
  r = uv_idle_start(&idle, WorkerDummy::on_idle);
  if (r) {
    /// @todo error
    fprintf(stderr, "idle start %s\n", uv_err_name(r));
    assert(false);
  }
}

/**
 * Read configure from file and setup libs and api filter.
 * @param config_file File name of configuration.
 */
void WorkerDummy::read_config(const std::string& config_file) {
  std::ifstream ifs(config_file);
  picojson::value v;
  if (!ifs.is_open()) {
    /// @todo error
    assert(false);
  }
  std::string err = picojson::parse(v, ifs);
  ifs.close();
  if (!err.empty()) {
    /// @todo error
    assert(false);
  }
  picojson::object& config = v.get<picojson::object>();

  // Load dynamic link libraries.
  if (config.find("libs") != config.end()) {
    const picojson::array& lib_paths = config.at("libs").get<picojson::array>();
    for (auto lib : lib_paths) {
      void* dl_handle = dlopen(lib.get<std::string>().c_str(), RTLD_LAZY);
      if (!dl_handle) {
        throw_error_message(Error::EXT_LIBRARY, dlerror());
      }
      libs.push_back(dl_handle);
    }
  }

  // Load api filter.
  if (config.find("lib-filter") != config.end()) {
    const picojson::array& filter_files =
        config.at("lib-filter").get<picojson::array>();
    for (auto filter : filter_files) {
      std::ifstream ifs(filter.get<std::string>());
      if (!ifs.is_open()) {
        throw_error_message(Error::CONFIGURE, filter.get<std::string>());
      }
      picojson::value v;
      std::string err = picojson::parse(v, ifs);
      ifs.close();
      if (!err.empty()) {
        throw_error_message(Error::CONFIGURE, err);
      }

      picojson::object& o = v.get<picojson::object>();
      for (auto& it : o) {
        lib_filter.insert(std::make_pair(it.first,
                                         it.second.get<std::string>()));
      }
    }
  }
}

#endif  // ifdef WORKER_DUMMY
}  // namespace processwarp
