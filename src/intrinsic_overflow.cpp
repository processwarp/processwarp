
#include "lib/safeint3.hpp"
#include "intrinsic_overflow.hpp"
#include "vmachine.hpp"

using namespace usagi;

// VMにライブラリを登録する。
void IntrinsicOverflow::regist(VMachine& vm) {
  vm.regist_intrinsic_func("llvm.sadd.with.overflow.i16", IntrinsicOverflow::sadd, 16);
  vm.regist_intrinsic_func("llvm.sadd.with.overflow.i32", IntrinsicOverflow::sadd, 32);
  vm.regist_intrinsic_func("llvm.sadd.with.overflow.i64", IntrinsicOverflow::sadd, 64);

  vm.regist_intrinsic_func("llvm.smul.with.overflow.i16", IntrinsicOverflow::smul, 16);
  vm.regist_intrinsic_func("llvm.smul.with.overflow.i32", IntrinsicOverflow::smul, 32);
  vm.regist_intrinsic_func("llvm.smul.with.overflow.i64", IntrinsicOverflow::smul, 64);

  vm.regist_intrinsic_func("llvm.ssub.with.overflow.i16", IntrinsicOverflow::ssub, 16);
  vm.regist_intrinsic_func("llvm.ssub.with.overflow.i32", IntrinsicOverflow::ssub, 32);
  vm.regist_intrinsic_func("llvm.ssub.with.overflow.i64", IntrinsicOverflow::ssub, 64);

  vm.regist_intrinsic_func("llvm.uadd.with.overflow.i16", IntrinsicOverflow::uadd, 16);
  vm.regist_intrinsic_func("llvm.uadd.with.overflow.i32", IntrinsicOverflow::uadd, 32);
  vm.regist_intrinsic_func("llvm.uadd.with.overflow.i64", IntrinsicOverflow::uadd, 64);

  vm.regist_intrinsic_func("llvm.umul.with.overflow.i16", IntrinsicOverflow::umul, 16);
  vm.regist_intrinsic_func("llvm.umul.with.overflow.i32", IntrinsicOverflow::umul, 32);
  vm.regist_intrinsic_func("llvm.umul.with.overflow.i64", IntrinsicOverflow::umul, 64);

  vm.regist_intrinsic_func("llvm.usub.with.overflow.i16", IntrinsicOverflow::usub, 16);
  vm.regist_intrinsic_func("llvm.usub.with.overflow.i32", IntrinsicOverflow::usub, 32);
  vm.regist_intrinsic_func("llvm.usub.with.overflow.i64", IntrinsicOverflow::usub, 64);
}

/**
 * @param SFUNC SafeIntの演算関数
 * @param INT_T 計算のベースになる整数型
 * @param WIDTH 整数のビット幅
 */
#define M_CASE_PER_WIDTH(SFUNC, INT_T, WIDTH)				\
  case WIDTH: {								\
  INT_T a = static_cast<INT_T>(VMachine::read_intrinsic_param_i##WIDTH(src, &seek)); \
  INT_T b = static_cast<INT_T>(VMachine::read_intrinsic_param_i##WIDTH(src, &seek)); \
  INT_T res;								\
  bool flg = SFUNC<INT_T, INT_T>(a, b, res);				\
  *reinterpret_cast<INT_T*>(vm.get_raw_addr(dst)) = res;		\
  *reinterpret_cast<uint8_t*>(vm.get_raw_addr(dst) + sizeof(INT_T)) = (flg ? 0x00 : 0xff); \
  } break

/**
 * @param FNAME 作成する関数名
 * @param SFUNC SafeIntの演算関数
 * @param I16 16bit幅の計算のベースになる整数型
 * @param I32 32bit幅の計算のベースになる整数型
 * @param I64 64bit幅の計算のベースになる整数型
 */
#define M_FUNC_PER_METHOD(FNAME, SFUNC, I16, I32, I64) \
  bool IntrinsicOverflow::FNAME(VMachine& vm, Thread& th, IntrinsicFuncParam p, \
				vaddr_t dst, std::vector<uint8_t>& src) { \
    int seek = 0;							\
    switch (p.i64) {							\
      M_CASE_PER_WIDTH(SFUNC, I16, 16);					\
      M_CASE_PER_WIDTH(SFUNC, I32, 32);					\
      M_CASE_PER_WIDTH(SFUNC, I64, 64);					\
    default: assert(false); break;					\
    }									\
    return false;							\
  }

M_FUNC_PER_METHOD(sadd, SafeAdd,      int16_t, int32_t, int64_t)
M_FUNC_PER_METHOD(smul, SafeMultiply, int16_t, int32_t, int64_t)
M_FUNC_PER_METHOD(ssub, SafeSubtract, int16_t, int32_t, int64_t)
M_FUNC_PER_METHOD(uadd, SafeAdd,      uint16_t, uint32_t, uint64_t)
M_FUNC_PER_METHOD(umul, SafeMultiply, uint16_t, uint32_t, uint64_t)
M_FUNC_PER_METHOD(usub, SafeSubtract, uint16_t, uint32_t, uint64_t)

#undef M_FUNC_PER_METHOD
#undef M_CASE_PER_WIDTH
