#pragma once

#include <string>
#include <vector>

#include "packet.hpp"
#include "process.hpp"
#include "types.hpp"
#include "vmachine.hpp"

namespace processwarp {
class BuiltinGui {
 public:
  static BuiltinPostProc::Type create(Process& proc, Thread& thread, BuiltinFuncParam p,
                                      vaddr_t dst, std::vector<uint8_t>& src);
  static BuiltinPostProc::Type flush(Process& proc, Thread& thread, BuiltinFuncParam p,
                                     vaddr_t dst, std::vector<uint8_t>& src);
  static BuiltinPostProc::Type script(Process& proc, Thread& thread, BuiltinFuncParam p,
                                      vaddr_t dst, std::vector<uint8_t>& src);

  static void regist(VMachine& vm, PacketController& packet_controller);
};
}  // namespace processwarp
