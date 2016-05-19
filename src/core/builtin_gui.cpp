
#include <picojson.h>

#include <string>
#include <vector>

#include "builtin_gui.hpp"
#include "constant.hpp"
#include "format.hpp"

namespace processwarp {
BuiltinGuiDelegate::~BuiltinGuiDelegate() {
}

/**
 * When program call pw_gui_create, send "create_gui" command to scheduler in this node.
 * Scheduler should control to create a GUI frontend.
 * Parameters get from src aren't.
 * Return value set to dst isn't.
 * @return NORMAL for terminate function.
 */
BuiltinPostProc::Type BuiltinGui::create(Process& proc, Thread& thread, BuiltinFuncParam p,
                                         vaddr_t dst, std::vector<uint8_t>& src) {
  BuiltinGuiDelegate& delegate = *reinterpret_cast<BuiltinGuiDelegate*>(p.ptr);

  picojson::object param;
  delegate.builtin_gui_send_command(proc, NodeID::THIS, Module::SCHEDULER, "create_gui", param);

  return BuiltinPostProc::NORMAL;
}

/**
 * When program call pw_gui_flush, send "script" command with script that
 * copy image back to fore canvas.
 * Return value set to dst isn't.
 * @return NORMAL for terminate function.
 */
BuiltinPostProc::Type BuiltinGui::flush(Process& proc, Thread& thread, BuiltinFuncParam p,
                                        vaddr_t dst, std::vector<uint8_t>& src) {
  BuiltinGuiDelegate& delegate = *reinterpret_cast<BuiltinGuiDelegate*>(p.ptr);

  picojson::object param;
  std::string script =
      "var image = global.context.getImageData("
      "0, 0,"
      "global.canvas.width,"
      "global.canvas.height);"
      "global.context_fore.putImageData(image, 0, 0);";
  param.insert(std::make_pair("script", picojson::value(script)));
  delegate.builtin_gui_send_command(proc, NodeID::NONE, Module::GUI, "script", param);

  return BuiltinPostProc::NORMAL;
}

/**
 * When program call pw_gui_script, send "script" command with script string to the frontend.
 * Destination node-id is resolved by scheduler.
 * Before send each command, embed parameter with format string the same as the "printf".
 * Parameters get from src are, pointer of format-string, and any parameter alike to "printf".
 * Return value set to dst isn't.
 * @return NORMAL for terminate function.
 */
BuiltinPostProc::Type BuiltinGui::script(Process& proc, Thread& thread, BuiltinFuncParam p,
                                         vaddr_t dst, std::vector<uint8_t>& src) {
  BuiltinGuiDelegate& delegate = *reinterpret_cast<BuiltinGuiDelegate*>(p.ptr);
  int seek = 0;
  vaddr_t format_ptr = Process::read_builtin_param_ptr(src, &seek);
  std::vector<uint8_t> ap(src.begin() + seek, src.end());
  std::string script = Format::parse(thread, thread.memory->read_raw(format_ptr), ap);

  picojson::object param;
  param.insert(std::make_pair("script", picojson::value(script)));
  delegate.builtin_gui_send_command(proc, NodeID::NONE, Module::GUI, "script", param);

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
  vm.regist_builtin_func("pw_gui_flush", BuiltinGui::flush,
                         reinterpret_cast<void*>(&delegate));
  vm.regist_builtin_func("pw_gui_script", BuiltinGui::script,
                         reinterpret_cast<void*>(&delegate));
}
}  // namespace processwarp
