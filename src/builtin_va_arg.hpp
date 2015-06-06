#pragma once

#include "definitions.hpp"

namespace processwarp {
  class BuiltinVaArg {
  public:
    /**
     * VMにライブラリを登録する。
     * @param vm 登録対象のVM
     */
    static void regist(VMachine& vm);

    /**
     * __builtin_va_arg関数。
     * srcから取り出すパラメタは以下のとおり。
     * i8* arglist
     * i64 sizeof argument
     * 戻り値は以下のとおり
     * void* 取り出した値へのポインタ
     */
    static bool arg(VMachine& vm, Thread& th, BuiltinFuncParam p,
		    vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * llvm.va_copy関数。
     * srcから取り出すパラメタは以下のとおり。
     * i8* destarglist
     * i8* srcarglist
     */
    static bool copy(VMachine& vm, Thread& th, BuiltinFuncParam p,
		     vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * llvm.va_end関数。
     * srcから取り出すパラメタは以下のとおり。
     * i8* arglist
     */
    static bool end(VMachine& vm, Thread& th, BuiltinFuncParam p,
		    vaddr_t dst, std::vector<uint8_t>& src);

    /**
     * llvm.va_start関数。
     * srcから取り出すパラメタは以下のとおり。
     * i8* arglist
     */
    static bool start(VMachine& vm, Thread& th, BuiltinFuncParam p,
		      vaddr_t dst, std::vector<uint8_t>& src);
  };
}
