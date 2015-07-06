
#include <GLFW/glfw3.h>

#include "builtin_glfw3.hpp"
#include "vmachine.hpp"

using namespace processwarp;

// This function creates a window and its associated OpenGL or OpenGL ES context.
BuiltinPost BuiltinGlfw3::createWindow(VMachine& vm, Thread& th, BuiltinFuncParam p,
				       vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  uint32_t width = VMachine::read_builtin_param_i32(src, &seek);
  uint32_t height = VMachine::read_builtin_param_i32(src, &seek);
  uint8_t* title = vm.get_raw_addr(VMachine::read_builtin_param_ptr(src, &seek));
  uint8_t* monitor = vm.get_raw_addr(VMachine::read_builtin_param_ptr(src, &seek));
  uint8_t* share = vm.get_raw_addr(VMachine::read_builtin_param_ptr(src, &seek));  
  // 読み込んだパラメタ長と渡されたパラメタ長は同じはず
  assert(static_cast<signed>(src.size()) == seek);

  GLFWwindow* window = glfwCreateWindow(width, height,
					reinterpret_cast<const char*>(title),
					reinterpret_cast<GLFWmonitor*>(monitor),
					reinterpret_cast<GLFWwindow*>(share));
  
  // ネイティブのアドレスとのペアを作成。
  *reinterpret_cast<vaddr_t*>(vm.get_raw_addr(dst)) = vm.create_native_ptr(window);
  
  return BP_NORMAL;
}

// This function destroys the specified window and its context.
BuiltinPost BuiltinGlfw3::destroyWindow(VMachine& vm, Thread& th, BuiltinFuncParam p,
					vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  vaddr_t window = VMachine::read_builtin_param_ptr(src, &seek);
  // 読み込んだパラメタ長と渡されたパラメタ長は同じはず
  assert(static_cast<signed>(src.size()) == seek);
  
  glfwDestroyWindow(reinterpret_cast<GLFWwindow*>(vm.get_raw_addr(window)));

  // ネイティブのアドレスとのペアを解消。
  vm.destory_native_ptr(window);

  return BP_NORMAL;
}

void BuiltinGlfw3::regist(VMachine& vm) {
  vm.regist_builtin_func("glfwCreateWindow", BuiltinGlfw3::createWindow, 0);
  vm.regist_builtin_func("glfwDestroyWindow", BuiltinGlfw3::destroyWindow, 0);
}
