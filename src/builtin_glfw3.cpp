
#include <GLFW/glfw3.h>

#include "builtin_glfw3.hpp"
#include "process.hpp"

using namespace processwarp;

// This function creates a window and its associated OpenGL or OpenGL ES context.
BuiltinPost BuiltinGlfw3::createWindow(Process& proc, Thread& thread, BuiltinFuncParam p,
				       vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  uint32_t width = Process::read_builtin_param_i32(src, &seek);
  uint32_t height = Process::read_builtin_param_i32(src, &seek);
  uint8_t* title = proc.get_raw_addr(Process::read_builtin_param_ptr(src, &seek));
  uint8_t* monitor = proc.get_raw_addr(Process::read_builtin_param_ptr(src, &seek));
  uint8_t* share = proc.get_raw_addr(Process::read_builtin_param_ptr(src, &seek));  
  // 読み込んだパラメタ長と渡されたパラメタ長は同じはず
  assert(static_cast<signed>(src.size()) == seek);

  GLFWwindow* window = glfwCreateWindow(width, height,
					reinterpret_cast<const char*>(title),
					reinterpret_cast<GLFWmonitor*>(monitor),
					reinterpret_cast<GLFWwindow*>(share));
  
  // ネイティブのアドレスとのペアを作成。
  *reinterpret_cast<vaddr_t*>(proc.get_raw_addr(dst)) = proc.create_native_ptr(window);
  
  return BP_NORMAL;
}

// This function destroys the specified window and its context.
BuiltinPost BuiltinGlfw3::destroyWindow(Process& proc, Thread& thread, BuiltinFuncParam p,
					vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  vaddr_t window = Process::read_builtin_param_ptr(src, &seek);
  // 読み込んだパラメタ長と渡されたパラメタ長は同じはず
  assert(static_cast<signed>(src.size()) == seek);
  
  glfwDestroyWindow(reinterpret_cast<GLFWwindow*>(proc.get_raw_addr(window)));

  // ネイティブのアドレスとのペアを解消。
  proc.destory_native_ptr(window);

  return BP_NORMAL;
}

void BuiltinGlfw3::regist(Process& vm) {
  vm.regist_builtin_func("glfwCreateWindow", BuiltinGlfw3::createWindow, 0);
  vm.regist_builtin_func("glfwDestroyWindow", BuiltinGlfw3::destroyWindow, 0);
}
