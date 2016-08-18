
#include <dlfcn.h>
#include <sys/types.h>
#include <unistd.h>

#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>
#include <tuple>

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
  std::string pipe_path;
  std::string message_fname;
  std::tie(pipe_path, message_fname) = read_options(argc, argv);

  initialize_logger(message_fname);
  processwarp::Logger::dbg(processwarp::DaemonMid::L3010, getpid());

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
  {
    Lock::Guard guard(mutex_send_que);
    send_data(packet);
  }
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

void WorkerSubprocess::vmachine_error(VMachine& vm, const std::string& message) {
  /// @todo
  assert(false);
}

void WorkerSubprocess::vmachine_on_invoke_thread(VMachine& vm, vtid_t tid) {
  {
    Lock::Guard guard(mutex_wait_invoke);
    wait_invoke.insert(tid);
  }
  uv_async_send(&async_wait_invoke);
}

void WorkerSubprocess::on_timer_heartbeat(uv_timer_t* handle) {
  WorkerSubprocess& THIS = *reinterpret_cast<WorkerSubprocess*>(handle->data);

  THIS.vm->heartbeat();
}

void WorkerSubprocess::on_timer_routine(uv_timer_t* handle) {
  WorkerSubprocess& THIS = *reinterpret_cast<WorkerSubprocess*>(handle->data);

  THIS.vm->vmemory.beat_routine();
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

void WorkerSubprocess::on_async_send_que(uv_async_t* handle) {
  WorkerSubprocess& THIS = *reinterpret_cast<WorkerSubprocess*>(handle->data);
  Lock::Guard guard(THIS.mutex_send_que);

  for (auto& send_obj : THIS.send_que) {
    THIS.send_data(send_obj);
  }
  THIS.send_que.clear();
}

void WorkerSubprocess::on_async_wait_invoke(uv_async_t* handle) {
  WorkerSubprocess& THIS = *reinterpret_cast<WorkerSubprocess*>(handle->data);
  Lock::Guard guard(THIS.mutex_wait_invoke);

  for (vtid_t tid : THIS.wait_invoke) {
    assert(THIS.threads.find(tid) == THIS.threads.end());
    THIS.threads.insert(std::make_pair(tid,
                                       std::thread([=, &THIS]{ on_invoke_thread(THIS, tid); })));
  }
  THIS.wait_invoke.clear();
}

void WorkerSubprocess::on_async_wait_join(uv_async_t* handle) {
  WorkerSubprocess& THIS = *reinterpret_cast<WorkerSubprocess*>(handle->data);
  Lock::Guard guard(THIS.mutex_wait_join);

  for (vtid_t tid : THIS.wait_join) {
    THIS.threads.at(tid).join();
    THIS.threads.erase(tid);
  }
  THIS.wait_join.clear();
}

void WorkerSubprocess::on_invoke_thread(WorkerSubprocess& THIS, vtid_t tid) {
  THIS.vm->execute(tid);

  {
    Lock::Guard guard(THIS.mutex_wait_join);
    THIS.wait_join.insert(tid);
  }
  uv_async_send(&THIS.async_wait_join);
}

/**
 * Get options by reading command line arguments.
 * @param argc Count of command line arguments.
 * @param argv Values of command line arguments.
 * @return Pipe path.
 */
std::tuple<std::string, std::string>  WorkerSubprocess::read_options(int argc, char* argv[]) {
  assert(argc == 4);

  my_pid = Convert::str2vpid(argv[3]);

  return std::tuple<std::string, std::string>(std::string(argv[1]), std::string(argv[2]));;
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
 * Initialize logger.
 */
void WorkerSubprocess::initialize_logger(const std::string& message_fname) {
#ifndef WITH_WORKER_DEBUG
#ifndef WITH_LOG_STDOUT
  logger.initialize("native");
#endif
  Logger::set_logger_delegate(&logger);

  Message::load(message_fname);
#endif
}

/**
 * Initialize virtual machine execute loop.
 */
void WorkerSubprocess::initialize_loop() {
  int r;

  async_send_que.data = this;
  r = uv_async_init(loop, &async_send_que, on_async_send_que);
  if (r) {
    /// @todo error
    Logger::err(DaemonMid::L3007, "uv_async_init", uv_err_name(r));
    assert(false);
  }

  async_wait_invoke.data = this;
  r = uv_async_init(loop, &async_wait_invoke, on_async_wait_invoke);
  if (r) {
    /// @todo error
    Logger::err(DaemonMid::L3007, "uv_async_init", uv_err_name(r));
    assert(false);
  }

  async_wait_join.data = this;
  r = uv_async_init(loop, &async_wait_join, on_async_wait_join);
  if (r) {
    /// @todo error
    Logger::err(DaemonMid::L3007, "uv_async_init", uv_err_name(r));
    assert(false);
  }
}

void WorkerSubprocess::initialize_timer() {
  uv_timer_init(loop, &heartbeat_timer);
  heartbeat_timer.data = this;
  uv_timer_start(&heartbeat_timer, WorkerSubprocess::on_timer_heartbeat,
                 0, HEARTBEAT_INTERVAL * 1000);

  uv_timer_init(loop, &routine_timer);
  routine_timer.data = this;
  uv_timer_start(&routine_timer, WorkerSubprocess::on_timer_routine,
                 0, BEAT_ROUTINE_INTERVAL * 1000);
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
  initialize_timer();
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

  {
    Lock::Guard guard(mutex_send_que);
    send_que.push_back(data);
    uv_async_send(&async_send_que);
  }
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

  return THIS.entry(argc, argv);
}
#endif
