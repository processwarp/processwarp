#pragma once

#include "definitions.hpp"

namespace usagi {
  class IntrinsicWarp {
  public:

    /**
     * This function register function that will be called at after warp.
     * parameter from src;
     * vaddr_t function
     */
    static bool at_after_warp(VMachine& vm, Thread& th, IntrinsicFuncParam p,
			      vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * This function register function that will be called at befor warp.
     * parameter from src;
     * vaddr_t function
     */
    static bool at_befor_warp(VMachine& vm, Thread& th, IntrinsicFuncParam p,
			      vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * This function check to warp is requested.
     */
    static bool poll_warp_request(VMachine& vm, Thread& th, IntrinsicFuncParam p,
				  vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * This function register library functions in virtual machine.
     * @param vm target virtual machine for regist on.
     */
    static void regist(VMachine& vm);

    /**
     * This function set a parameter to warp function.
     * paramter from src;
     * i32 key
     * i32 value
     */
    static bool set_processwarp_param(VMachine& vm, Thread& th, IntrinsicFuncParam p,
				      vaddr_t dst, std::vector<uint8_t>& src);
  };
}
