#pragma once

#include "definitions.hpp"

namespace processwarp {
  /**
   * POSIXライブラリのうち、LLVM組み込みとして用意するもの。
   */
  class BuiltinPosix {
  public:
    /**
     * __assert_fail(assertの内部実装)関数。
     * srcから取り出すパラメタは以下のとおり。
     * vaddr_t(const) assertion
     * vaddr_t(const) file
     * i32 line
     * vaddr_t(const) function
     */
    static BuiltinPost __assert_fail(VMachine& vm, Thread& th, BuiltinFuncParam p,
				     vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * Implement for pthread_create.
     * parameter:
     * vaddr_t thread
     * vaddr_t attr
     * vaddr_t start
     * vaddr_t arg
     */
    static BuiltinPost pthread_create(VMachine& vm, Thread& th, BuiltinFuncParam p,
				      vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * Implement for pthread_exit.
     * parameter:
     * vaddr_t retval
     */
    static BuiltinPost pthread_exit(VMachine& vm, Thread& th, BuiltinFuncParam p,
				    vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * Implement for pthread_join.
     * parameter:
     * i32 thread
     * vaddr_t ret_addr
     */
    static BuiltinPost pthread_join(VMachine& vm, Thread& th, BuiltinFuncParam p,
				    vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * VMにライブラリを登録する。
     * @param vm 登録対象のVM
     */
    static void regist(VMachine& vm);
  };
}
