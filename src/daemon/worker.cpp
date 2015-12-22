
#include <dlfcn.h>

#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>

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
  initialize_loop();

  return uv_run(loop, UV_RUN_DEFAULT);
}

/**
 * When vmachine require send packet, relay this packet to backend.
 * Backend process relay this packet to server and server relay this packet to target node.
 * @param vm Caller instance.
 * @param dst_nid Destination node-id.
 * @param packet Packet to send.
 */
void Worker::vmachine_send_packet(VMachine& vm, const nid_t& dst_nid, const std::string& packet) {
  relay_packet(dst_nid, "vm", packet);
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
 * When vmemory require send packet, relay this packet to backend.
 * Backend process relay this packet to server and server relay this packet to target node.
 * @param memory Caller instance.
 * @param dst_nid Destination node-id.
 * @param packet Packet to send.
 */
void Worker::vmemory_send_packet(VMemory& memory, const nid_t& dst_nid, const std::string& packet) {
  relay_packet(dst_nid, "memory", packet);
}

/**
 * When vmemory tell update memory image by other node, relay this event to vm.
 * @param memory Caller instance.
 * @param addr Address updated.
 */
void Worker::vmemory_recv_update(VMemory& memory, vaddr_t addr) {
  assert(vm.get() != nullptr);

  vm->on_recv_update(addr);
}

/**
 * When GUI API require send command, relay this packet to frontend through backend.
 * @param proc Caller instance.
 * @param command GUI command string.
 * @param param Parameter for command.
 */
void Worker::builtin_gui_command(Process& proc, const std::string& command,
                                 const picojson::object& param) {
  picojson::object packet;

  packet.insert(std::make_pair("command", picojson::value(std::string("gui_command"))));
  packet.insert(std::make_pair("gui_command", picojson::value(command)));
  packet.insert(std::make_pair("param", picojson::value(param)));

  send_packet(packet);
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
  THIS.send_packet(packet);
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
 * When recv stream data from backend, clip packet and call recv_packet.
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
      fprintf(stderr, "Read error %s\n", uv_err_name(nread));
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
      fprintf(stderr, "Wrong packet terminate.");
      uv_close(reinterpret_cast<uv_handle_t*>(&THIS.pipe), Worker::on_close);
      return;
    }

    picojson::value v;
    std::string err;
    picojson::parse(v, THIS.recv_buffer.data() + 4, THIS.recv_buffer.data() + 4 + psize, &err);
    printf("Worker::on_recv : %s\n", THIS.recv_buffer.data() + 4);
    if (!err.empty()) {
      /// @todo error
      fprintf(stderr, "on_read:%s\n", err.c_str());
      uv_close(reinterpret_cast<uv_handle_t*>(&THIS.pipe), Worker::on_close);
      return;
    }

    THIS.recv_packet(v.get<picojson::object>());
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
    fprintf(stderr, "error on uv_write\n");
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

  if (argc != 8) {
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

/**
 * Connect pipe to backend.
 * @param parameter Parameters storeing the path of pipe to backend.
 */
void Worker::connect_pipe(WorkerParameter& parameter) {
  int r = uv_pipe_init(loop, &pipe, 0);

  if (r) {
    /// @todo error
    fprintf(stderr, "Bind error %s\n", uv_err_name(r));
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
                 parameter.master_nid);
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
    fprintf(stderr, "idle init %s\n", uv_err_name(r));
    assert(false);
  }

  idle.data = this;
  r = uv_idle_start(&idle, Worker::on_idle);
  if (r) {
    /// @todo error
    fprintf(stderr, "idle start %s\n", uv_err_name(r));
    assert(false);
  }
}

/**
 * When receive packet from backend, call capable methods by command.
 * If command is "scheduler_command", call capable methods by sub-command.
 * @param packet Packet receive from backend.
 */
void Worker::recv_packet(const picojson::object& packet) {
  std::string command = packet.at("command").get<std::string>();

  if (command == "relay") {
    std::string type = packet.at("type").get<std::string>();
    if (type == "memory") {
      vm->vmemory.recv_memory_data(Convert::vpid2str(parameter.pid),
                                   packet.at("packet").get<std::string>());

    } else if (type == "vm") {
      vm->recv_packet(packet.at("packet").get<std::string>());

    } else {
      /// @todo
      assert(false);
    }

  } else if (command == "scheduler_command") {
    std::string scheduler_command = packet.at("scheduler_command").get<std::string>();
    if (scheduler_command == "warpout") {
      recv_scheduler_warpout(packet.at("param").get<picojson::object>());

    } else {
      /// @todo
      assert(false);
    }

  } else {
    /// @todo
    assert(false);
  }
}

/**
 * When receive scheduler warpout command, read parameter and call vm's method to do it.
 * @param parameter Command parameter contain thread-id to warpout.
 */
void Worker::recv_scheduler_warpout(const picojson::object& parameter) {
  vm->warpout_thread(Convert::json2vtid(parameter.at("tid")));
}

void Worker::relay_packet(const nid_t& dst_nid, const std::string& type,
                          const std::string& packet) {
  picojson::object p;
  p.insert(std::make_pair("command", picojson::value(std::string("relay"))));
  p.insert(std::make_pair("type", picojson::value(type)));
  p.insert(std::make_pair("dst_nid", Convert::nid2json(dst_nid)));
  p.insert(std::make_pair("packet", picojson::value(packet)));
  send_packet(p);
}

/**
 * Send JSON format packet to backend by converting to binary format.
 * @param packet A JSON formated packet.
 */
void Worker::send_packet(const picojson::object& packet) {
  std::string str_packet = picojson::value(packet).serialize();
  std::unique_ptr<uv_write_t> write_req(new uv_write_t());
  std::unique_ptr<WriteHandler> handler(new WriteHandler());
  std::unique_ptr<char[]> buffer(new char[4 + str_packet.size() + 1]);

  assert(str_packet.size() != 0);

  *reinterpret_cast<uint32_t*>(buffer.get()) = htonl(str_packet.size());
  memcpy(buffer.get() + 4, str_packet.c_str(), str_packet.size());
  buffer[4 + str_packet.size()] = '\0';

  handler->THIS = this;
  handler->buffer = buffer.get();
  write_req->data = reinterpret_cast<void*>(handler.get());
  uv_buf_t write_buf = uv_buf_init(buffer.get(), 4 + str_packet.size() + 1);
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
