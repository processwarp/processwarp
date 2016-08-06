#pragma once

#include <map>
#include <string>
#include <tuple>
#include <vector>

#ifndef WITH_LOG_STDOUT
#  include "logger_syslog.hpp"
#else
#  include "logger_stdout.hpp"
#endif
#include "dynamic_library.hpp"
#include "packet.hpp"
#include "subprocess.hpp"
#include "vmachine.hpp"
#include "vmemory.hpp"

namespace processwarp {
class WorkerSubprocess : public Subprocess, public VMachineDelegate, public VMemoryDelegate {
 public:
  int entry(int argc, char* argv[]);

 private:
#ifndef WITH_LOG_STDOUT
  /** Syslog logger. */
  Logger::Syslog logger;
#else
  /** Stdout logger. */
  Logger::Stdout logger;
#endif

  /** Idle event handler. */
  uv_idle_t idle;

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

  void on_connect() override;
  void on_recv_data(const picojson::object& data) override;

  void vmachine_finish(VMachine& vm) override;
  void vmachine_finish_thread(VMachine& vm, const vtid_t& tid) override;
  void vmachine_error(VMachine& vm, const std::string& message) override;
  void vmachine_send_packet(VMachine& vm, const Packet& packet) override;

  void vmemory_recv_update(VMemory& memory, vaddr_t addr) override;
  void vmemory_send_packet(VMemory& memory, const Packet& packet) override;

  static void on_idle(uv_idle_t* handle);

  std::tuple<std::string, std::string> read_options(int argc, char* argv[]);
  void initialize_libs(const picojson::array& config);
  void initialize_lib_filter(const picojson::array& config);
  void initialize_logger(const std::string& message_fname);
  void initialize_loop();
  void initialize_vm(vtid_t root_tid, vaddr_t proc_addr,
                     const NodeID& master_nid, const std::string name);
  void recv_connect_worker(const picojson::object& content);
  void recv_relay_packet(const picojson::object& content);
  void send_relay_packet(const Packet& packet);
};
}  // namespace processwarp
