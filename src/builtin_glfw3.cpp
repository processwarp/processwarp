
#include <GLFW/glfw3.h>

#include <cassert>
#include <vector>

#include "builtin_glfw3.hpp"
#include "process.hpp"

namespace processwarp {

/* this function creates a window and
 * its associated OpenGL or OpenGL ES context.
 */
BuiltinPost BuiltinGlfw3::createWindow(Process& proc, Thread& thread,
                                       BuiltinFuncParam p, vaddr_t dst,
                                       std::vector<uint8_t>& src) {
  int seek = 0;
  uint32_t width = Process::read_builtin_param_i32(src, &seek);
  uint32_t height = Process::read_builtin_param_i32(src, &seek);
  vaddr_t title_addr = Process::read_builtin_param_ptr(src, &seek);
  vaddr_t monitor_addr = Process::read_builtin_param_ptr(src, &seek);
  vaddr_t share_addr = Process::read_builtin_param_ptr(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);

  const uint8_t* title = thread.memory->read_raw(title_addr);
  uint8_t* monitor = thread.memory->read_writable(monitor_addr);
  uint8_t* share = thread.memory->read_writable(share_addr);

  // GLFWwindow* window =
  glfwCreateWindow(width, height,
                   reinterpret_cast<const char*>(title),
                   reinterpret_cast<GLFWmonitor*>(monitor),
                   reinterpret_cast<GLFWwindow*>(share));

  /// @todo ネイティブのアドレスとのペアを作成。
  // thread.memory.set<vaddr_t>(dst, proc.create_native_ptr(window));

  return BP_NORMAL;
}

// This function destroys the specified window and its context.
BuiltinPost BuiltinGlfw3::destroyWindow(Process& proc, Thread& thread,
                                        BuiltinFuncParam p, vaddr_t dst,
                                        std::vector<uint8_t>& src) {
  int seek = 0;
  vaddr_t window = Process::read_builtin_param_ptr(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);

  glfwDestroyWindow(reinterpret_cast<GLFWwindow*>
                    (thread.memory->read_writable(window)));

  /// @todo ネイティブのアドレスとのペアを解消。
  // proc.destory_native_ptr(window);

  return BP_NORMAL;
}

void BuiltinGlfw3::regist(VMachine& vm) {
  vm.regist_builtin_func("glfwCreateWindow", BuiltinGlfw3::createWindow, 0);
  vm.regist_builtin_func("glfwDestroyWindow", BuiltinGlfw3::destroyWindow, 0);
}
}  // namespace processwarp
