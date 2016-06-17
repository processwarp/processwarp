
#include <dlfcn.h>

#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>

#include "constant.hpp"
#include "daemon_mid.hpp"
#include "logger.hpp"
#include "worker.hpp"

namespace processwarp {
/**
 * Actual entry process, passed by main.
 * Scan command line options and change run mode by option,
 * and pass the process to main loop.
 * @param argc Count of command line option.
 * @param argv Strings of command line options.
 * @return Exit status.
 */
int Worker::entry(int argc, char* argv[]) {
  read_options(argc, argv);
  loop = uv_default_loop();

  connect_pipe();

#ifndef WITH_WORKER_DEBUG
  return uv_run(loop, UV_RUN_DEFAULT);
#else
  return EXIT_SUCCESS;
#endif
}

void Worker::vmachine_finish(VMachine& vm) {
  /// @todo
  assert(false);
}

void Worker::vmachine_finish_thread(VMachine& vm, const vtid_t& tid) {
  /// @todo
  assert(false);
}

void Worker::vmachine_error(VMachine& vm, const std::string& message) {
  /// @todo
  assert(false);
}

/**
 * When vmachine require send packet, relay it to backend.
 * @param vm Caller instance.
 * @param packet A packet to send.
 */
void Worker::vmachine_send_packet(VMachine& vm, const Packet& packet) {
  send_relay_packet(packet);
}

/**
 * When vmemory require send packet, relay it to backend.
 * @param memory Caller instance.
 * @param packet A packet to send.
 */
void Worker::vmemory_send_packet(VMemory& memory, const Packet& packet) {
  send_relay_packet(packet);
}

/**
 * When vmemory tell update memory image by another node, relay this event to vm.
 * @param memory Caller instance.
 * @param addr Address updated.
 */
void Worker::vmemory_recv_update(VMemory& memory, vaddr_t addr) {
  assert(vm.get() != nullptr);

  vm->on_recv_update(addr);
}

/**
 * Memory allocator for pipe that is created by libuv.
 * @param handle
 * @param suggested_size
 * @param buf
 */
void Worker::on_alloc(uv_handle_t *handle, size_t suggested_size, uv_buf_t *buf) {
  buf->base = new char[suggested_size];
  buf->len = suggested_size;
}

/**
 * When close pipe, do nothing.
 * @param handle Handler thant equal to pointer of pipe.
 */
void Worker::on_close(uv_handle_t* handle) {
  /// @todo
  assert(false);
}

/**
 * When connect pipe to backend, send connect_worker command and
 * tell virtual-process-id that this worker assigned.
 * Before that, bind receive function to libuv's connecter instance.
 * @param connect Libuv's connecter instance.
 * @param status Connect status ? (not used.)
 */
void Worker::on_connect(uv_connect_t* connect, int status) {
  Worker& THIS = *reinterpret_cast<Worker*>(connect->data);

  uv_read_start(reinterpret_cast<uv_stream_t*>(connect->handle),
                Worker::on_alloc, Worker::on_recv);

  picojson::object packet;
  packet.insert(std::make_pair("command", picojson::value(std::string("connect_worker"))));
  packet.insert(std::make_pair("pid", Convert::vpid2json(THIS.my_pid)));
  THIS.send_data(packet);
}

/**
 * When real process is idle, execute vm instructions.
 * @param handle
 */
void Worker::on_idle(uv_idle_t* handle) {
  Worker& THIS = *reinterpret_cast<Worker*>(handle->data);

  THIS.vm->execute();
}

/**
 * When recv stream data from backend, clip packet and call recv_data.
 * Concaenate stream data received yet with just now as buffer.
 * Parse json from buffer.
 * Call on_receive method if json packet (like bellow) is received fully,
 * and cut off a stream of packet data in head of buffer.
 * Packet:<br/>
 * [packet size (json length 4Byte big endian)][packet body (json)][\0]...(repeat)<br/>
 */
void Worker::on_recv(uv_stream_t* stream, ssize_t nread, const uv_buf_t* buf) {
  Worker& THIS = *reinterpret_cast<Worker*>(stream->data);
  std::unique_ptr<char[]> recv_buffer(buf->base);

  if (nread < 0) {
    if (nread != UV_EOF) {
      /// @todo error
      Logger::err(DaemonMid::L3003, uv_err_name(nread));
    }
    uv_close(reinterpret_cast<uv_handle_t*>(&THIS.pipe), Worker::on_close);
    return;
  }

  std::size_t idx_dst = THIS.recv_buffer.size();
  THIS.recv_buffer.resize(idx_dst + nread);
  std::memcpy(THIS.recv_buffer.data() + idx_dst, recv_buffer.get(), nread);

  while (THIS.recv_buffer.size() >= 4) {
    uint32_t psize = ntohl(*reinterpret_cast<uint32_t*>(THIS.recv_buffer.data()));
    if (THIS.recv_buffer.size() < 4 + psize + 1) return;

    if (THIS.recv_buffer.data()[4 + psize] != 0) {
      /// @todo error
      Logger::warn(DaemonMid::L3004);
      uv_close(reinterpret_cast<uv_handle_t*>(&THIS.pipe), Worker::on_close);
      assert(false);
      return;
    }

    picojson::value v;
    std::string err;
    picojson::parse(v, THIS.recv_buffer.data() + 4, THIS.recv_buffer.data() + 4 + psize, &err);
    if (!err.empty()) {
      Logger::warn(DaemonMid::L3004);
      Logger::dbg(DaemonMid::L3005, THIS.recv_buffer.data() + 4);
      return;
    }

    THIS.recv_data(v.get<picojson::object>());
    uint32_t rest_size = THIS.recv_buffer.size() - 4 - psize - 1;
    memmove(THIS.recv_buffer.data(), THIS.recv_buffer.data() + 4 + psize + 1, rest_size);
    THIS.recv_buffer.resize(rest_size);
  }
}

/**
 * When uv_write is finished, clean-up hundler.
 * If error is occurred in this method, close target pipe.
 * @param req Hundler.
 * @param status Status code.
 */
void Worker::on_write_end(uv_write_t *req, int status) {
  std::unique_ptr<uv_write_t> write_req(req);
  std::unique_ptr<WriteHandler> handler(reinterpret_cast<WriteHandler*>(write_req->data));
  std::unique_ptr<char[]> buffer(handler->buffer);

  if (status < 0) {
    /// @todo error
    Logger::err(DaemonMid::L3006, uv_err_name(status));
    uv_close(reinterpret_cast<uv_handle_t*>(&handler->THIS->pipe), Worker::on_close);
  }
}

/**
 * Get options by reading command line arguments.
 * @param argc Count of command line arguments.
 * @param argv Values of command line arguments.
 */
void Worker::read_options(int argc, char* argv[]) {
  assert(argc == 3);

  pipe_path = std::string(argv[1]);
  my_pid = Convert::str2vpid(argv[2]);
}

/**
 * Connect a pipe with the backend process.
 */
void Worker::connect_pipe() {
  int r = uv_pipe_init(loop, &pipe, 0);

  if (r) {
    /// @todo error
    Logger::err(DaemonMid::L3008, uv_err_name(r));
    assert(false);
  }
  pipe.data    = this;
  connect.data = this;
  uv_pipe_connect(&connect, &pipe, pipe_path.c_str(), on_connect);
}

/**
 * Initialize dynamic link libraries by reading configurations.
 * @param config Configurations that is passed by the backed process.
 */
void Worker::initialize_libs(const picojson::array& config) {
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
void Worker::initialize_lib_filter(const picojson::array& config) {
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
void Worker::initialize_vm(vtid_t root_tid, vaddr_t proc_addr,
                           const NodeID& master_nid, const std::string name) {
  assert(vm.get() == nullptr);

  vm.reset(new VMachine(*this, *this, my_nid, libs, lib_filter));
  vm->initialize(my_pid, root_tid, proc_addr, master_nid, name);
}

/**
 * Initialize virtual machine execute loop.
 * By using libuv, it can call virtual machine loop method while CPU is idle.
 */
void Worker::initialize_loop() {
  int r;

  r = uv_idle_init(loop, &idle);
  if (r) {
    /// @todo error
    Logger::err(DaemonMid::L3007, "uv_idle_init", uv_err_name(r));
    assert(false);
  }

  idle.data = this;
  r = uv_idle_start(&idle, Worker::on_idle);
  if (r) {
    /// @todo error
    Logger::err(DaemonMid::L3007, "uv_idle_start", uv_err_name(r));
    assert(false);
  }
}

/**
 * When receive data from backend, call capable methods by command.
 * If command is "scheduler_command", call capable methods by sub-command.
 * @param data Packet receive from backend.
 */
void Worker::recv_data(const picojson::object& data) {
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

/**
 * When receive connect_worker, read configuration from packet,
 * and create a virtual machine, start libuv's loop.
 * @param content Packet content that contain configuration to a new virtual machine.
 */
void Worker::recv_connect_worker(const picojson::object& content) {
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
void Worker::recv_relay_packet(const picojson::object& content) {
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
void Worker::send_relay_packet(const Packet& packet) {
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

/**
 * Send JSON format data to backend by converting to binary format.
 * @param data A JSON formated data.
 */
void Worker::send_data(const picojson::object& data) {
  std::string bin_data = picojson::value(data).serialize();
  std::unique_ptr<uv_write_t> write_req(new uv_write_t());
  std::unique_ptr<WriteHandler> handler(new WriteHandler());
  std::unique_ptr<char[]> buffer(new char[4 + bin_data.size() + 1]);

  assert(bin_data.size() != 0);

  *reinterpret_cast<uint32_t*>(buffer.get()) = htonl(bin_data.size());
  memcpy(buffer.get() + 4, bin_data.c_str(), bin_data.size());
  buffer[4 + bin_data.size()] = '\0';

  handler->THIS = this;
  handler->buffer = buffer.get();
  write_req->data = reinterpret_cast<void*>(handler.get());
  uv_buf_t write_buf = uv_buf_init(buffer.get(), 4 + bin_data.size() + 1);
  uv_write(write_req.get(), reinterpret_cast<uv_stream_t*>(&pipe),
           &write_buf, 1, Worker::on_write_end);
  buffer.release();
  handler.release();
  write_req.release();
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
  processwarp::Worker THIS;

  return THIS.entry(argc, argv);
}
#endif
