
#include <cassert>
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
  const uint8_t* title = thread.memory->get_raw(Process::read_builtin_param_ptr(src, &seek));
  uint8_t* monitor = thread.memory->get_raw_writable(Process::read_builtin_param_ptr(src, &seek));
  uint8_t* share = thread.memory->get_raw_writable(Process::read_builtin_param_ptr(src, &seek));  
  assert(static_cast<signed>(src.size()) == seek);

  // GLFWwindow* window =
  glfwCreateWindow(width, height,
		   reinterpret_cast<const char*>(title),
		   reinterpret_cast<GLFWmonitor*>(monitor),
		   reinterpret_cast<GLFWwindow*>(share));

  /// TODO:ネイティブのアドレスとのペアを作成。
  //thread.memory.set<vaddr_t>(dst, proc.create_native_ptr(window));
  
  return BP_NORMAL;
}

// This function destroys the specified window and its context.
BuiltinPost BuiltinGlfw3::destroyWindow(Process& proc, Thread& thread, BuiltinFuncParam p,
					vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  vaddr_t window = Process::read_builtin_param_ptr(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);
  
  glfwDestroyWindow(reinterpret_cast<GLFWwindow*>(thread.memory->get_raw_writable(window)));

  /// TODO:ネイティブのアドレスとのペアを解消。
  //proc.destory_native_ptr(window);

  return BP_NORMAL;
}

void BuiltinGlfw3::regist(VMachine& vm) {
  vm.regist_builtin_func("glfwCreateWindow", BuiltinGlfw3::createWindow, 0);
  vm.regist_builtin_func("glfwDestroyWindow", BuiltinGlfw3::destroyWindow, 0);
}
