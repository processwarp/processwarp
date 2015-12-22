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

  virtual void builtin_gui_command(Process& proc, const std::string& command,
                                   const picojson::object& param) = 0;
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
