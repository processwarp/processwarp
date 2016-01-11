#pragma once

#include <picojson.h>
#include <uv.h>

#include <map>
#include <memory>
#include <string>
#include <vector>

#include "builtin_gui.hpp"
#include "vmachine.hpp"
#include "vmemory.hpp"

namespace processwarp {
class WorkerDummy : public VMachineDelegate, public VMemoryDelegate, public BuiltinGuiDelegate {
 public:
  static WorkerDummy& get_instance();

  void initialize(uv_loop_t* loop_, const std::string& pipe_path_, const std::string& config_file_);
  void create_vm(const vpid_t& pid, vtid_t root_tid, vaddr_t proc_addr, const nid_t& master_nid);
  void relay_command(const CommandPacket& packet);

 private:
  uv_loop_t* loop;
  /** Idle event handler. */
  uv_idle_t idle;

  /** Dynamic link libraries. */
  std::vector<void*> libs;
  /** Map of API name call from and call for that can access. */
  std::map<std::string, std::string> lib_filter;

  std::map<vpid_t, std::unique_ptr<VMachine>> vms;

  void vmachine_send_command(VMachine& vm, const nid_t& dst_nid, Module::Type module,
                             const std::string& command, picojson::object& param) override;
  void vmachine_finish(VMachine& vm) override;
  void vmachine_finish_thread(VMachine& vm, const vtid_t& tid) override;
  void vmachine_error(VMachine& vm, const std::string& message) override;

  void vmemory_send_command(VMemory& memory, const nid_t& dst_nid, Module::Type module,
                            const std::string& command, picojson::object& param) override;
  void vmemory_recv_update(VMemory& memory, vaddr_t addr) override;

  void builtin_gui_send_command(Process& proc, const nid_t& dst_nid, Module::Type module,
                                const std::string& command,  picojson::object& param) override;

  static void on_idle(uv_idle_t* handle);

  void initialize_loop();
  void read_config(const std::string& config_file);
};

typedef WorkerDummy WorkerConnector;
}  // namespace processwarp
