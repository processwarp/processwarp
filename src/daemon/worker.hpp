#pragma once

#include <uv.h>

#include <map>
#include <string>
#include <vector>

#include "builtin_gui.hpp"
#include "vmachine.hpp"
#include "vmemory.hpp"

namespace processwarp {
class Worker : public VMachineDelegate, public VMemoryDelegate, public BuiltinGuiDelegate {
 public:
  int entry(int argc, char* argv[]);

 private:
  struct WorkerParameter {
    std::string config_file;
    std::string pipe_path;
    vpid_t pid;
    vtid_t root_tid;
    vaddr_t proc_addr;
    nid_t master_nid;
    nid_t my_nid;
  };

  struct WriteHandler {
    Worker* THIS;
    char* buffer;
  };

  WorkerParameter parameter;
  /** Main loop of libuv. */
  uv_loop_t* loop;
  /** Pipe connect to backend. */
  uv_pipe_t pipe;
  /** Idle event handler. */
  uv_idle_t idle;
  uv_connect_t connect;
  std::vector<uint8_t> recv_buffer;

  /** Dynamic link libraries. */
  std::vector<void*> libs;
  /** Map of API name call from and call for that can access. */
  std::map<std::string, std::string> lib_filter;
  std::unique_ptr<VMachine> vm;

  void vmachine_send_packet(VMachine& vm, const nid_t& dst_nid,
                            const std::string& content) override;
  void vmachine_finish(VMachine& vm) override;
  void vmachine_finish_thread(VMachine& vm, const vtid_t& tid) override;
  void vmachine_error(VMachine& vm, const std::string& message) override;

  void vmemory_send_packet(VMemory& memory, const nid_t& dst_nid,
                           const std::string& content) override;
  void vmemory_recv_update(VMemory& memory, vaddr_t addr) override;

  void builtin_gui_send_command(Process& proc, InnerModule::Type module,
                                const picojson::object& content) override;
  void builtin_gui_send_frontend_packet(Process& proc, const std::string& content) override;

  static void on_alloc(uv_handle_t *handle, size_t suggested_size, uv_buf_t *buf);
  static void on_close(uv_handle_t* handle);
  static void on_connect(uv_connect_t* connect, int status);
  static void on_idle(uv_idle_t* handle);
  static void on_recv(uv_stream_t* stream, ssize_t nread, const uv_buf_t* buf);
  static void on_write_end(uv_write_t *req, int status);

  WorkerParameter read_options(int argc, char* argv[]);
  void read_config(const std::string& config_file);
  void connect_pipe(WorkerParameter& parameter);
  void initialize_vm(WorkerParameter& parameter);
  void initialize_loop();
  void recv_data(const picojson::object& data);
  void send_command(InnerModule::Type module, const picojson::object& content);
  void send_inner_module_packet(const nid_t& dst_nid, InnerModule::Type module,
                                const std::string& content);
  void send_outer_module_packet(const nid_t& dst_nid, OuterModule::Type module,
                                const std::string& content);
  void send_data(const picojson::object& data);
};
}  // namespace processwarp
