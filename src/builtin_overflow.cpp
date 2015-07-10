
#include "builtin_overflow.hpp"
#include "process.hpp"
#include "lib/safeint3.hpp"

using namespace processwarp;

// VMにライブラリを登録する。
void BuiltinOverflow::regist(Process& vm) {
  vm.regist_builtin_func("llvm.sadd.with.overflow.i16", BuiltinOverflow::sadd, 16);
  vm.regist_builtin_func("llvm.sadd.with.overflow.i32", BuiltinOverflow::sadd, 32);
  vm.regist_builtin_func("llvm.sadd.with.overflow.i64", BuiltinOverflow::sadd, 64);

  vm.regist_builtin_func("llvm.smul.with.overflow.i16", BuiltinOverflow::smul, 16);
  vm.regist_builtin_func("llvm.smul.with.overflow.i32", BuiltinOverflow::smul, 32);
  vm.regist_builtin_func("llvm.smul.with.overflow.i64", BuiltinOverflow::smul, 64);

  vm.regist_builtin_func("llvm.ssub.with.overflow.i16", BuiltinOverflow::ssub, 16);
  vm.regist_builtin_func("llvm.ssub.with.overflow.i32", BuiltinOverflow::ssub, 32);
  vm.regist_builtin_func("llvm.ssub.with.overflow.i64", BuiltinOverflow::ssub, 64);

  vm.regist_builtin_func("llvm.uadd.with.overflow.i16", BuiltinOverflow::uadd, 16);
  vm.regist_builtin_func("llvm.uadd.with.overflow.i32", BuiltinOverflow::uadd, 32);
  vm.regist_builtin_func("llvm.uadd.with.overflow.i64", BuiltinOverflow::uadd, 64);

  vm.regist_builtin_func("llvm.umul.with.overflow.i16", BuiltinOverflow::umul, 16);
  vm.regist_builtin_func("llvm.umul.with.overflow.i32", BuiltinOverflow::umul, 32);
  vm.regist_builtin_func("llvm.umul.with.overflow.i64", BuiltinOverflow::umul, 64);

  vm.regist_builtin_func("llvm.usub.with.overflow.i16", BuiltinOverflow::usub, 16);
  vm.regist_builtin_func("llvm.usub.with.overflow.i32", BuiltinOverflow::usub, 32);
  vm.regist_builtin_func("llvm.usub.with.overflow.i64", BuiltinOverflow::usub, 64);
}

/**
 * @param SFUNC SafeIntの演算関数
 * @param INT_T 計算のベースになる整数型
 * @param WIDTH 整数のビット幅
 */
#define M_CASE_PER_WIDTH(SFUNC, INT_T, WIDTH)				\
  case WIDTH: {								\
  INT_T a = static_cast<INT_T>(Process::read_builtin_param_i##WIDTH(src, &seek)); \
  INT_T b = static_cast<INT_T>(Process::read_builtin_param_i##WIDTH(src, &seek)); \
  INT_T res;								\
  bool flg = SFUNC<INT_T, INT_T>(a, b, res);				\
  *reinterpret_cast<INT_T*>(proc.get_raw_addr(dst)) = res;		\
  *reinterpret_cast<uint8_t*>(proc.get_raw_addr(dst) + sizeof(INT_T)) = (flg ? 0x00 : 0xff); \
  } break

/**
 * @param FNAME 作成する関数名
 * @param SFUNC SafeIntの演算関数
 * @param I16 16bit幅の計算のベースになる整数型
 * @param I32 32bit幅の計算のベースになる整数型
 * @param I64 64bit幅の計算のベースになる整数型
 */
#define M_FUNC_PER_METHOD(FNAME, SFUNC, I16, I32, I64)			\
  BuiltinPost BuiltinOverflow::FNAME(Process& proc, Thread& thread, BuiltinFuncParam p, \
				     vaddr_t dst, std::vector<uint8_t>& src) { \
    int seek = 0;							\
    switch (p.i64) {							\
      M_CASE_PER_WIDTH(SFUNC, I16, 16);					\
      M_CASE_PER_WIDTH(SFUNC, I32, 32);					\
      M_CASE_PER_WIDTH(SFUNC, I64, 64);					\
    default: assert(false); break;					\
    }									\
    return BP_NORMAL;							\
  }

M_FUNC_PER_METHOD(sadd, SafeAdd,      int16_t, int32_t, int64_t)
M_FUNC_PER_METHOD(smul, SafeMultiply, int16_t, int32_t, int64_t)
M_FUNC_PER_METHOD(ssub, SafeSubtract, int16_t, int32_t, int64_t)
M_FUNC_PER_METHOD(uadd, SafeAdd,      uint16_t, uint32_t, uint64_t)
M_FUNC_PER_METHOD(umul, SafeMultiply, uint16_t, uint32_t, uint64_t)
M_FUNC_PER_METHOD(usub, SafeSubtract, uint16_t, uint32_t, uint64_t)

#undef M_FUNC_PER_METHOD
#undef M_CASE_PER_WIDTH
