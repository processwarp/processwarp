#pragma once

#include <deque>
#include <map>
#include <set>
#include <string>
#include <thread>
#include <tuple>
#include <vector>

#include "dynamic_library.hpp"
#include "lock.hpp"
#include "packet.hpp"
#include "subprocess.hpp"
#include "vmachine.hpp"
#include "vmemory.hpp"

namespace processwarp {
class WorkerSubprocess : public Subprocess, public VMachineDelegate, public VMemoryDelegate {
 public:
  int entry(int argc, char* argv[]);

 private:
  /** Configure. */
  picojson::object config;

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

  std::map<vtid_t, std::thread> threads;

  /** Thread-ids waiting to invoke. */
  std::set<vtid_t> wait_invoke;
  Lock::Mutex mutex_wait_invoke;
  uv_async_t async_wait_invoke;

  std::set<vtid_t> wait_join;
  Lock::Mutex mutex_wait_join;
  uv_async_t async_wait_join;

  std::deque<picojson::object> send_que;
  Lock::Mutex mutex_send_que;
  uv_async_t async_send_que;

  uv_timer_t heartbeat_timer;
  uv_timer_t routine_timer;

  void on_connect() override;
  void on_recv_data(const picojson::object& data) override;

  void vmachine_finish(VMachine& vm) override;
  void vmachine_error(VMachine& vm, const std::string& message) override;
  void vmachine_on_invoke_thread(VMachine& vm, vtid_t tid) override;
  void vmachine_send_packet(VMachine& vm, const Packet& packet) override;

  void vmemory_send_packet(VMemory& memory, const Packet& packet) override;

  static void on_async_send_que(uv_async_t* handle);
  static void on_async_wait_invoke(uv_async_t* handle);
  static void on_async_wait_join(uv_async_t* handle);
  static void on_invoke_thread(WorkerSubprocess& THIS, vtid_t tid);
  static void on_timer_heartbeat(uv_timer_t* handle);
  static void on_timer_routine(uv_timer_t* handle);

  std::tuple<std::string, std::string> read_options(int argc, char* argv[]);
  void initialize_libs(const picojson::array& config);
  void initialize_lib_filter(const picojson::array& config);
  void initialize_loop();
  void initialize_timer();
  void initialize_vm(vtid_t root_tid, vaddr_t proc_addr, const std::string name);
  void recv_initialize(const picojson::object& content);
  void recv_relay_packet(const picojson::object& content);
  void send_relay_packet(const Packet& packet);
};
}  // namespace processwarp
