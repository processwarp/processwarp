
#include <picojson.h>

#include <string>
#include <vector>

#include "builtin_gui.hpp"

namespace processwarp {
BuiltinGuiDelegate::~BuiltinGuiDelegate() {
}

/**
 * When program call pw_gui_create, send "create" GUI command to frontend.
 * Parameters get from src aren't.
 * Return value set to dst isn't.
 * @return NORMAL for terminate function.
 */
BuiltinPostProc::Type BuiltinGui::create(Process& proc, Thread& thread, BuiltinFuncParam p,
                                         vaddr_t dst, std::vector<uint8_t>& src) {
  BuiltinGuiDelegate& delegate = *reinterpret_cast<BuiltinGuiDelegate*>(p.ptr);
  picojson::object param;

  delegate.builtin_gui_command(proc, "create", param);

  return BuiltinPostProc::NORMAL;
}

BuiltinPostProc::Type BuiltinGui::script(Process& proc, Thread& thread, BuiltinFuncParam p,
                                         vaddr_t dst, std::vector<uint8_t>& src) {
  /// @todo
  assert(false);

  return BuiltinPostProc::NORMAL;
}

/**
 * Regist process warp GUI library in virtual machine.
 * @param vm Target virtual machine for regist on.
 * @param delegate Event assignee for cooperate with other module.
 */
void BuiltinGui::regist(VMachine& vm, BuiltinGuiDelegate& delegate) {
  vm.regist_builtin_func("pw_gui_create", BuiltinGui::create,
                         reinterpret_cast<void*>(&delegate));
  vm.regist_builtin_func("pw_gui_script", BuiltinGui::script,
                         reinterpret_cast<void*>(&delegate));
}
}  // namespace processwarp
