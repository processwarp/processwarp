
#include <dlfcn.h>

#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>

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
  parameter = read_options(argc, argv);
  loop = uv_default_loop();

  read_config(parameter.config_file);
  connect_pipe(parameter);
  initialize_vm(parameter);

  return uv_run(loop, UV_RUN_DEFAULT);
}

/**
 * When vmachine require send command, relay it to backend.
 * @param vm Caller instance.
 * @param packet Command packet.
 */
void Worker::vmachine_send_command(VMachine& vm, const CommandPacket& packet) {
  send_command(packet);
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
 * When vmemory require send command, relay it to backend.
 * Backend process relay this command to target module in this node or another node through the server if need.
 * @param memory Caller instance.
 * @param dst_nid Destination node-id.
 * @param module Target module.
 * @param command Command string.
 * @param param Parameter for command.
 */
void Worker::vmemory_send_command(VMemory& memory, const nid_t& dst_nid, Module::Type module,
                                  const std::string& command, picojson::object& param) {
  assert(param.find("command") == param.end());

  param.insert(std::make_pair("command", picojson::value(command)));

  CommandPacket packet = {
    parameter.pid,
    dst_nid,
    SpecialNID::NONE,
    module,
    param
  };

  send_command(packet);
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
 * When built-in GUI module require send command, relay it to backend.
 * Backend process relay this command to target module in this node or another node through the server if need.
 * @param proc Caller instance.
 * @param dst_nid Destination node-id.
 * @param module Target module.
 * @param command Command string.
 * @param param Parameter for command.
 */
void Worker::builtin_gui_send_command(Process& proc, const nid_t& dst_nid, Module::Type module,
                                      const std::string& command,  picojson::object& param) {
  assert(param.find("command") == param.end());

  param.insert(std::make_pair("command", picojson::value(command)));

  CommandPacket packet = {
    parameter.pid,
    dst_nid,
    SpecialNID::NONE,
    module,
    param
  };

  send_command(packet);
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
 * When connect pipe to backend, send connect_worker command and tell pid.
 * @param connect
 * @param status
 */
void Worker::on_connect(uv_connect_t* connect, int status) {
  Worker& THIS = *reinterpret_cast<Worker*>(connect->data);

  uv_read_start(reinterpret_cast<uv_stream_t*>(connect->handle),
                Worker::on_alloc, Worker::on_recv);

  picojson::object packet;
  packet.insert(std::make_pair("command", picojson::value(std::string("connect_worker"))));
  packet.insert(std::make_pair("pid", Convert::vpid2json(THIS.parameter.pid)));
  THIS.send_data(packet);
  THIS.initialize_loop();
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
 * @return Read options are storead in the structure.
 */
Worker::WorkerParameter Worker::read_options(int argc, char* argv[]) {
  WorkerParameter parameter;

  if (argc != 9) {
    /// @todo error
    assert(false);
  }

  parameter.config_file = std::string(argv[1]);
  parameter.pipe_path = std::string(argv[2]);
  parameter.pid = Convert::str2vpid(argv[3]);
  parameter.root_tid = Convert::str2vtid(argv[4]);
  parameter.proc_addr = Convert::str2vaddr(argv[5]);
  parameter.master_nid = Convert::str2nid(argv[6]);
  parameter.my_nid = Convert::str2nid(argv[7]);
  parameter.name = std::string(argv[8]);

  return parameter;
}

/**
 * Read configure from file and setup libs and api filter.
 * @param config_file File name of configuration.
 */
void Worker::read_config(const std::string& config_file) {
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
      DynamicLibrary::lib_handler_t lib_handler =
          DynamicLibrary::open_lib(lib.get<std::string>());
      libs.push_back(lib_handler);
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

/**
 * Connect pipe to backend.
 * @param parameter Parameters storeing the path of pipe to backend.
 */
void Worker::connect_pipe(WorkerParameter& parameter) {
  int r = uv_pipe_init(loop, &pipe, 0);

  if (r) {
    /// @todo error
    Logger::err(DaemonMid::L3008, uv_err_name(r));
    assert(false);
  }
  pipe.data    = this;
  connect.data = this;
  uv_pipe_connect(&connect, &pipe, parameter.pipe_path.c_str(), on_connect);
}

/**
 * Initialize virtual machine.
 * @param parameter Parameters storeing any parameter to create vm.
 */
void Worker::initialize_vm(WorkerParameter& parameter) {
  assert(vm.get() == nullptr);

  vm.reset(new VMachine(*this, *this, parameter.my_nid, libs, lib_filter));
  vm->initialize(parameter.pid,
                 parameter.root_tid,
                 parameter.proc_addr,
                 parameter.master_nid,
                 parameter.name);
  vm->initialize_gui(*this);
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

  if (command == "relay_command") {
    recv_relay_command(data);

  } else {
    /// @todo
    assert(false);
  }
}

/**
 * When receive command, pass a packet to target module (must be MEMORY or VM).
 * @param content Packet content that contain command string and parameters.
 */
void Worker::recv_relay_command(const picojson::object& content) {
  CommandPacket packet = {
    Convert::json2vpid(content.at("pid")),
    Convert::json2nid(content.at("dst_nid")),
    Convert::json2nid(content.at("src_nid")),
    Convert::json2int<Module::Type>(content.at("module")),
    content.at("content").get<picojson::object>()
  };

  switch (packet.module) {
    case Module::MEMORY: {
      vm->vmemory.recv_command(packet);
    } break;

    case Module::VM: {
      vm->recv_command(packet);
    } break;

    default: {
      /// @todo error
      assert(false);
    }
  }
}

/**
 * Send command to capable module in this node through the backend.
 * @param packet Command packet.
 */
void Worker::send_command(const CommandPacket& packet) {
  picojson::object data;

  data.insert(std::make_pair("command", picojson::value(std::string("relay_command"))));
  data.insert(std::make_pair("pid", Convert::vpid2json(parameter.pid)));
  data.insert(std::make_pair("dst_nid", Convert::nid2json(packet.dst_nid)));
  data.insert(std::make_pair("src_nid", Convert::nid2json(packet.src_nid)));
  data.insert(std::make_pair("module", Convert::int2json<Module::Type>(packet.module)));
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
int main(int argc, char* argv[]) {
  processwarp::Worker THIS;

  return THIS.entry(argc, argv);
}
