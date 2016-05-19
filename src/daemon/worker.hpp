#pragma once

#include <uv.h>

#include <map>
#include <string>
#include <vector>

#include "builtin_gui.hpp"
#include "dynamic_library.hpp"
#include "packet.hpp"
#include "vmachine.hpp"
#include "vmemory.hpp"

namespace processwarp {
class Worker : public VMachineDelegate, public VMemoryDelegate, public BuiltinGuiDelegate {
 public:
  int entry(int argc, char* argv[]);

 private:
  struct WriteHandler {
    Worker* THIS;
    char* buffer;
  };

  /** Main loop of libuv. */
  uv_loop_t* loop;
  /** Pipe connect to backend. */
  uv_pipe_t pipe;
  /** Idle event handler. */
  uv_idle_t idle;
  uv_connect_t connect;
  std::vector<uint8_t> recv_buffer;
  /** Pipe path to connect to backend. */
  std::string pipe_path;

  /** My node-id. */
  NodeID my_nid;
  /** My process-id. */
  vpid_t my_pid;
  /** Dynamic link libraries. */
  std::vector<DynamicLibrary::lib_handler_t> libs;
  /** Map of API name call from and call for that can access. */
  std::map<std::string, std::string> lib_filter;
  /** Instance of virtual-machine. */
  std::unique_ptr<VMachine> vm;

  void vmachine_send_command(VMachine& vm, const Packet& packet) override;
  void vmachine_finish(VMachine& vm) override;
  void vmachine_finish_thread(VMachine& vm, const vtid_t& tid) override;
  void vmachine_error(VMachine& vm, const std::string& message) override;

  void vmemory_send_command(VMemory& memory, const NodeID& dst_nid, Module::Type module,
                            const std::string& command, picojson::object& param) override;
  void vmemory_recv_update(VMemory& memory, vaddr_t addr) override;

  void builtin_gui_send_command(Process& proc, const NodeID& dst_nid, Module::Type module,
                                const std::string& command,  picojson::object& param) override;

  static void on_alloc(uv_handle_t *handle, size_t suggested_size, uv_buf_t *buf);
  static void on_close(uv_handle_t* handle);
  static void on_connect(uv_connect_t* connect, int status);
  static void on_idle(uv_idle_t* handle);
  static void on_recv(uv_stream_t* stream, ssize_t nread, const uv_buf_t* buf);
  static void on_write_end(uv_write_t *req, int status);

  void read_options(int argc, char* argv[]);
  void connect_pipe();
  void initialize_libs(const picojson::array& config);
  void initialize_lib_filter(const picojson::array& config);
  void initialize_loop();
  void initialize_vm(vtid_t root_tid, vaddr_t proc_addr,
                     const NodeID& master_nid, const std::string name);
  void recv_data(const picojson::object& data);
  void recv_connect_worker(const picojson::object& content);
  void recv_relay_command(const picojson::object& content);
  void send_command(const Packet& packet);
  void send_data(const picojson::object& data);
};
}  // namespace processwarp
