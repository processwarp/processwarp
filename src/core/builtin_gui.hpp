#pragma once

#include <string>
#include <vector>

#include "definitions.hpp"
#include "process.hpp"
#include "vmachine.hpp"

namespace processwarp {
class BuiltinGuiDelegate {
 public:
  virtual ~BuiltinGuiDelegate();

  virtual void builtin_gui_send_command(Process& proc, const nid_t& dst_nid, Module::Type module,
                                        const std::string& command, picojson::object& param) = 0;
};

class BuiltinGui {
 public:
  static BuiltinPostProc::Type create(Process& proc, Thread& thread, BuiltinFuncParam p,
                                      vaddr_t dst, std::vector<uint8_t>& src);
  static BuiltinPostProc::Type script(Process& proc, Thread& thread, BuiltinFuncParam p,
                                      vaddr_t dst, std::vector<uint8_t>& src);

  static void regist(VMachine& vm, BuiltinGuiDelegate& delegate);
};
}  // namespace processwarp
