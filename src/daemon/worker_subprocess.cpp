
#include <dlfcn.h>
#include <sys/types.h>
#include <unistd.h>

#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>

#include "constant.hpp"
#include "daemon_mid.hpp"
#include "logger.hpp"
#include "worker_subprocess.hpp"

namespace processwarp {
/**
 * Actual entry process, passed by main.
 * Scan command line options and change run mode by option,
 * and pass the process to main loop.
 * @param argc Count of command line option.
 * @param argv Strings of command line options.
 * @return Exit status.
 */
int WorkerSubprocess::entry(int argc, char* argv[]) {
  std::string pipe_path = read_options(argc, argv);
  initialize(uv_default_loop());
  connect_pipe(pipe_path);

#ifndef WITH_WORKER_DEBUG
  return uv_run(loop, UV_RUN_DEFAULT);
#else
  return EXIT_SUCCESS;
#endif
}

/**
 * When connect pipe to backend, send connect_worker command and
 * tell virtual-process-id that this worker assigned.
 */
void WorkerSubprocess::on_connect() {
  picojson::object packet;
  packet.insert(std::make_pair("command", picojson::value(std::string("connect_worker"))));
  packet.insert(std::make_pair("pid", Convert::vpid2json(my_pid)));
  send_data(packet);
}

/**
 * When receive data from backend, call capable methods by command.
 * If command is "scheduler_command", call capable methods by sub-command.
 * @param data Packet receive from backend.
 */
void WorkerSubprocess::on_recv_data(const picojson::object& data) {
  std::string command = data.at("command").get<std::string>();

  if (command == "relay_packet") {
    recv_relay_packet(data);

  } else if (command == "connect_worker") {
    recv_connect_worker(data);

  } else {
    /// @todo
    assert(false);
  }
}

void WorkerSubprocess::vmachine_finish(VMachine& vm) {
  /// @todo
  assert(false);
}

void WorkerSubprocess::vmachine_finish_thread(VMachine& vm, const vtid_t& tid) {
  /// @todo
  assert(false);
}

void WorkerSubprocess::vmachine_error(VMachine& vm, const std::string& message) {
  /// @todo
  assert(false);
}

/**
 * When vmachine require send packet, relay it to backend.
 * @param vm Caller instance.
 * @param packet A packet to send.
 */
void WorkerSubprocess::vmachine_send_packet(VMachine& vm, const Packet& packet) {
  send_relay_packet(packet);
}

/**
 * When vmemory require send packet, relay it to backend.
 * @param memory Caller instance.
 * @param packet A packet to send.
 */
void WorkerSubprocess::vmemory_send_packet(VMemory& memory, const Packet& packet) {
  send_relay_packet(packet);
}

/**
 * When vmemory tell update memory image by another node, relay this event to vm.
 * @param memory Caller instance.
 * @param addr Address updated.
 */
void WorkerSubprocess::vmemory_recv_update(VMemory& memory, vaddr_t addr) {
  assert(vm.get() != nullptr);

  vm->on_recv_update(addr);
}

/**
 * When real process is idle, execute vm instructions.
 * @param handle
 */
void WorkerSubprocess::on_idle(uv_idle_t* handle) {
  WorkerSubprocess& THIS = *reinterpret_cast<WorkerSubprocess*>(handle->data);

  THIS.vm->execute();
}

/**
 * Get options by reading command line arguments.
 * @param argc Count of command line arguments.
 * @param argv Values of command line arguments.
 * @return Pipe path.
 */
std::string WorkerSubprocess::read_options(int argc, char* argv[]) {
  assert(argc == 3);

  my_pid = Convert::str2vpid(argv[2]);

  return std::string(argv[1]);
}

/**
 * Initialize dynamic link libraries by reading configurations.
 * @param config Configurations that is passed by the backed process.
 */
void WorkerSubprocess::initialize_libs(const picojson::array& config) {
  for (auto lib : config) {
    DynamicLibrary::lib_handler_t lib_handler =
      DynamicLibrary::open_lib(lib.get<std::string>());
    libs.push_back(lib_handler);
  }
}

/**
 * Initialize library filter.
 * Virtual-processes are able to call allowed apis these are listed in library filter.
 * @param config Configurations that is passed by the backed process.
 */
void WorkerSubprocess::initialize_lib_filter(const picojson::array& config) {
  for (auto filter : config) {
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

/**
 * Create new instance of virtual machine. And initialize this virtual machine.
 * @param root_tid Root thread-id for a process that it execute in the new vm.
 * @param proc_addr Address of the process infromation is stored.
 * @param master_nid Node-id that is owner of the process. 
 * @param name Process name.
 */
void WorkerSubprocess::initialize_vm(vtid_t root_tid, vaddr_t proc_addr,
                                     const NodeID& master_nid, const std::string name) {
  assert(vm.get() == nullptr);

  vm.reset(new VMachine(*this, *this, my_nid, libs, lib_filter));
  vm->initialize(my_pid, root_tid, proc_addr, master_nid, name);
}

/**
 * Initialize virtual machine execute loop.
 * By using libuv, it can call virtual machine loop method while CPU is idle.
 */
void WorkerSubprocess::initialize_loop() {
  int r;

  r = uv_idle_init(loop, &idle);
  if (r) {
    /// @todo error
    Logger::err(DaemonMid::L3007, "uv_idle_init", uv_err_name(r));
    assert(false);
  }

  idle.data = this;
  r = uv_idle_start(&idle, WorkerSubprocess::on_idle);
  if (r) {
    /// @todo error
    Logger::err(DaemonMid::L3007, "uv_idle_start", uv_err_name(r));
    assert(false);
  }
}

/**
 * When receive connect_worker, read configuration from packet,
 * and create a virtual machine, start libuv's loop.
 * @param content Packet content that contain configuration to a new virtual machine.
 */
void WorkerSubprocess::recv_connect_worker(const picojson::object& content) {
  // Save my node-id.
  my_nid = NodeID::from_json(content.at("my_nid"));

  // Load dynamic link libraries.
  if (content.find("libs") != content.end()) {
    initialize_libs(content.at("libs").get<picojson::array>());
  }

  // Load api filter.
  if (content.find("lib_filter") != content.end()) {
    initialize_lib_filter(content.at("lib_filter").get<picojson::array>());
  }

  // Create virtual machine.
  initialize_vm(Convert::json2vtid(content.at("root_tid")),
                Convert::json2vaddr(content.at("proc_addr")),
                NodeID::from_json(content.at("master_nid")),
                content.at("name").get<std::string>());
  initialize_loop();
}

/**
 * When receive relay_packet, pass a packet to target module (must be MEMORY or VM).
 * @param content A Packet.
 */
void WorkerSubprocess::recv_relay_packet(const picojson::object& content) {
  Packet packet = {
    Convert::json2int<uint32_t>(content.at("packet_id")),
    content.at("packet_command").get<std::string>(),
    Convert::json2int<PacketMode::Type>(content.at("mode")),
    Convert::json2int<Module::Type>(content.at("dst_module")),
    Convert::json2int<Module::Type>(content.at("src_module")),
    Convert::json2vpid(content.at("pid")),
    NodeID::from_json(content.at("dst_nid")),
    NodeID::from_json(content.at("src_nid")),
    content.at("content").get<picojson::object>()
  };

  switch (packet.dst_module) {
    case Module::MEMORY: {
      vm->vmemory.recv_packet(packet);
    } break;

    case Module::VM: {
      vm->recv_packet(packet);
    } break;

    default: {
      /// @todo error
      assert(false);
    }
  }
}

/**
 * Relay packet to backend.
 * @param packet A packet to relay.
 */
void WorkerSubprocess::send_relay_packet(const Packet& packet) {
  picojson::object data;

  data.insert(std::make_pair("command", picojson::value(std::string("relay_packet"))));
  data.insert(std::make_pair("packet_id", Convert::int2json(packet.packet_id)));
  data.insert(std::make_pair("packet_command", picojson::value(packet.command)));
  data.insert(std::make_pair("mode", Convert::int2json(packet.mode)));
  data.insert(std::make_pair("dst_module", Convert::int2json(packet.dst_module)));
  data.insert(std::make_pair("src_module", Convert::int2json(packet.src_module)));
  data.insert(std::make_pair("pid", Convert::vpid2json(packet.pid)));
  data.insert(std::make_pair("dst_nid", packet.dst_nid.to_json()));
  data.insert(std::make_pair("src_nid", packet.src_nid.to_json()));
  data.insert(std::make_pair("content", picojson::value(packet.content)));

  send_data(data);
}
}  // namespace processwarp

/**
 * Entry point, call actual entry process.
 * @param argc Count of command line option.
 * @param argv Strings of command line options.
 * @return Exit status.
 */
#ifndef WITH_WORKER_DEBUG
int main(int argc, char* argv[]) {
  processwarp::WorkerSubprocess THIS;

  processwarp::Logger::dbg(processwarp::DaemonMid::L3010, getpid());
  return THIS.entry(argc, argv);
}
#endif
