
#include <unistd.h>
#include <uv.h>

#include <cassert>
#include <string>

#include "convert.hpp"
#include "router.hpp"
#include "server_connector.hpp"
#include "worker_connector.hpp"

namespace processwarp {
/**
 * WorkerConnector instance getter as singleton pattern.
 * @return The singleton instance of WorkerConnector class.
 */
WorkerConnector& WorkerConnector::get_instance() {
  static WorkerConnector instance;
  return instance;
}

/**
 * Constructor for singleton pattern.
 * This class is singleton.
 * This method is private.
 */
WorkerConnector::WorkerConnector() {
}

/**
 * Initialize for WorkerConnector.
 * Create UNIX domain socket for worker.
 * @todo Get path of UNIX domain socket from configure.
 */
void WorkerConnector::initialize(uv_loop_t* loop,  const std::string& config_file_) {
  config_file = config_file_;
  Connector::initialize(loop, "/tmp/pw.worker.pipe");
}

/**
 * Create new worker process for virtual machine.
 * Create new process with parameter there are need to create vm.
 * Bundle property with worker and initialize status.
 * The process shuld connect pipt after launch.
 * @param pid Process-id for new vm.
 * @param root_tid Root thread-id for new vm.
 * @param proc_addr Address of process information for new vm.
 * @param master_nid Node-id of master node for new vm.
 */
void WorkerConnector::create_vm(const vpid_t& pid, vtid_t root_tid,
                                vaddr_t proc_addr, const nid_t& master_nid) {
  // static const char VALGRIND_PATH = "/usr/local/bin/valgrind";
  static const char PIPE_PATH[]   = "/tmp/pw.worker.pipe";
  std::string worker_path = Util::file_dirname(Util::get_my_fullpath()) + "/worker";
  Router& router = Router::get_instance();

  assert(properties.find(pid) == properties.end());

  properties.insert(std::make_pair(pid, WorkerProperty()));
  WorkerProperty& property = properties.at(pid);
  memset(&property, 0, sizeof(WorkerProperty));
  property.status = PipeStatus::SETUP;
  property.pid    = pid;
  property.process.data = &property;

  std::string root_tid_str = Convert::vtid2str(root_tid);
  std::string proc_addr_str = Convert::vaddr2str(proc_addr);

  char* args[] = {
    // const_cast<char*>(VALGRIND_PATH),
    const_cast<char*>(worker_path.c_str()),
    const_cast<char*>(config_file.c_str()),
    const_cast<char*>(PIPE_PATH),
    const_cast<char*>(Convert::vpid2str(pid).c_str()),
    const_cast<char*>(root_tid_str.c_str()),
    const_cast<char*>(proc_addr_str.c_str()),
    const_cast<char*>(Convert::nid2str(master_nid).c_str()),
    const_cast<char*>(Convert::nid2str(router.get_my_nid()).c_str()),
    nullptr
  };

  uv_stdio_container_t worker_stdio[3];
  worker_stdio[0].flags = UV_IGNORE;
  worker_stdio[1].flags = UV_INHERIT_FD;
  worker_stdio[1].data.fd = STDOUT_FILENO;
  worker_stdio[2].flags = UV_INHERIT_FD;
  worker_stdio[2].data.fd = STDERR_FILENO;

  uv_process_options_t options;
  memset(&options, 0, sizeof(options));
  options.exit_cb = WorkerConnector::on_exit;
  // options.file    = VALGRIND_PATH;
  options.file    = worker_path.c_str();
  options.args    = args;
  options.stdio_count = 3;
  options.stdio   = worker_stdio;

  int r = uv_spawn(loop, &property.process, &options);
  if (r) {
    /// @todo error
    fprintf(stderr, "%s\n", uv_err_name(r));
    assert(false);
  }
}

/**
 * Check worker is exist bundleing specified process.
 * @param pid Process-id to check.
 * @return True if worker is exist.
 */
bool WorkerConnector::have_process(const vpid_t& pid) {
  return properties.find(pid) != properties.end();
}

/**
 * Relay packet to worker.
 * @param pid Process-id to identify worker.
 * @param type Relay content type.
 * @param packet Packet to send.
 */
void WorkerConnector::relay_packet(const vpid_t& pid, const std::string& type,
                                   const std::string& packet) {
  picojson::object p;
  p.insert(std::make_pair("command", picojson::value(std::string("relay"))));
  p.insert(std::make_pair("type", picojson::value(type)));
  p.insert(std::make_pair("packet", picojson::value(packet)));
  send_packet(pid, p);
}

/**
 * Send scheduler command to worker.
 * @param pid Process-id to identify worker.
 * @param command Scheduler command string.
 * @param param Parameter for command.
 */
void WorkerConnector::send_scheduler_command(const vpid_t& pid, const std::string& command,
                                             const picojson::object& param) {
  picojson::object p;
  p.insert(std::make_pair("command", picojson::value(std::string("scheduler_command"))));
  p.insert(std::make_pair("scheduler_command", picojson::value(command)));
  p.insert(std::make_pair("param", picojson::value(param)));
  send_packet(pid, p);
}

/**
 * When worker process was finished, close a hundle and remove a property it bundled to worker.
 * @param req
 * @param exit_status
 * @param term_signal
 */
void WorkerConnector::on_exit(uv_process_t *req, int64_t exit_status, int term_signal) {
  WorkerConnector& THIS = WorkerConnector::get_instance();
  WorkerProperty& property = *reinterpret_cast<WorkerProperty*>(req->data);

  uv_close(reinterpret_cast<uv_handle_t*>(&property.process), nullptr);
  THIS.properties.erase(property.pid);
}

/**
 * When pipe was connect with worker, do nothing.
 * @param client Pipe connect with worker by libuv.
 */
void WorkerConnector::on_connect(uv_pipe_t& client) {
}

/**
 * When receive packet, call capable methods by command type.
 * @param client Pipe connect with worker by libuv.
 * @param packet Received JSON packet.
 */
void WorkerConnector::on_recv_packet(uv_pipe_t& client, picojson::object& packet) {
  std::string& command = packet.at("command").get<std::string>();

  if (command == "relay") {
    recv_relay(pid_map.at(&client), packet);

  } else if (command == "connect_worker") {
    recv_connect_worker(client, packet);

  } else {
    /// @todo error
    assert(false);
  }
}

/**
 * When pipe was close, remove map of pipe and pid.
 * @param client Pipe disconnect by worker.
 */
void WorkerConnector::on_close(uv_pipe_t& client) {
  pid_map.erase(&client);
}

/**
 * When receive connect_worker command, bundle process-id with worker and pipe.
 * If packets waiting to connect are exist, relay there packets.
 * @param pipe Pipe connected just now.
 * @param packet Packet contain pid parameter of command.
 */
void WorkerConnector::recv_connect_worker(uv_pipe_t& pipe, picojson::object& packet) {
  vpid_t pid = Convert::json2vpid(packet.at("pid"));

  if (properties.find(pid) == properties.end()) {
    /// @todo error
    assert(false);
  }

  WorkerProperty& property = properties.at(pid);
  if (property.pipe != nullptr) {
    /// @todo error
    assert(false);
  }
  property.status = PipeStatus::CONNECT;
  property.pipe = &pipe;
  pid_map.insert(std::make_pair(&pipe, pid));

  for (auto& wait_one : property.send_wait) {
    Connector::send_packet(*property.pipe, wait_one);
  }
  property.send_wait.clear();
}

/**
 * When recv relay packet, call ServerConnector's method to relay it.
 * @param pid Process-id bundled packet.
 * @param packet Packet to relay.
 */
void WorkerConnector::recv_relay(const vpid_t& pid, picojson::object& packet) {
  ServerConnector& server = ServerConnector::get_instance();

  server.relay_packet(pid,
                      Convert::json2nid(packet.at("dst_nid")),
                      packet.at("type").get<std::string>(),
                      packet.at("packet").get<std::string>());
}

/**
 * Send packet to specified worker.
 * @param pid Process-id to specifing worker.
 * @param packet Packet to send.
 */
void WorkerConnector::send_packet(const vpid_t& pid, const picojson::object& packet) {
  WorkerProperty& property = properties.at(pid);

  if (property.status == PipeStatus::CONNECT) {
    Connector::send_packet(*property.pipe, packet);

  } else if (property.status == PipeStatus::SETUP) {
    property.send_wait.push_back(packet);

  } else {
    /// @todo error
    assert(false);
  }
}
}  // namespace processwarp
