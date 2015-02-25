#pragma once

#include "definitions.hpp"

namespace usagi {
  /**
   * Functions for wrap GLFW3
   */
  class IntrinsicGlfw3 {
  public:
    /**
     * This function creates a window and its associated OpenGL or OpenGL ES context.
     * parameter from src;
     * i32 width
     * i32 height
     * vaddr_t title
     * vaddr_t monitor
     * vaddr_t share
     * return into dst;
     * vaddr_t
     */
    static bool createWindow(VMachine& vm, Thread& th, IntrinsicFuncParam p,
				 vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * This function destroys the specified window and its context.
     * paramter from src;
     * vaddr_t window
     */
    static bool destroyWindow(VMachine& vm, Thread& th, IntrinsicFuncParam p,
				  vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * VMにライブラリを登録する。
     * @param vm 登録対象のVM
     */	  
    static void regist(VMachine& vm);
  };
}
