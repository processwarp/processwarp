
#include <cassert>
#include <cmath>
#include <cstdint>
#include <cstring>

#include "basic_operator.hpp"
#include "error.hpp"
#include "type_store.hpp"
#include "util.hpp"

using namespace processwarp;

// デストラクタ。
BasicOperator::~BasicOperator() {
  // 基底クラスなため、virtual宣言を行うが何もしない。
}

// bit_cast命令に対応したキャスト演算を行う。
void BasicOperator::bit_cast(uint8_t* dst, size_t size, uint8_t* src) {
  throw_error(Error::INST_VIOLATION);
}

// 値をコピーする。
void BasicOperator::copy(uint8_t* dst, uint8_t* src) {
  throw_error(Error::INST_VIOLATION);
}

// 値を読み込む
/*
vm_int_t BasicOperator::get(uint8_t* src) {
  throw_error(Error::INST_VIOLATION);
  }*/

// 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
bool BasicOperator::is_or_nans(uint8_t* a, uint8_t* b) {
  throw_error(Error::INST_VIOLATION);
}

/**
 * TypeBaseクラスの2項演算子はすべてVOILATIONとする。
 * @param op メソッド名
 */
#define M_BINARY_OPERATOR_VIOLATION(op)				\
  void BasicOperator::op(uint8_t* dst, uint8_t* a, uint8_t* b) {	\
    throw_error(Error::INST_VIOLATION);				\
  }

M_BINARY_OPERATOR_VIOLATION(op_add); // 加算
M_BINARY_OPERATOR_VIOLATION(op_and); // and
M_BINARY_OPERATOR_VIOLATION(op_div); // 除算
M_BINARY_OPERATOR_VIOLATION(op_mul); // 乗算
M_BINARY_OPERATOR_VIOLATION(op_or);  // or
M_BINARY_OPERATOR_VIOLATION(op_rem); // 剰余
M_BINARY_OPERATOR_VIOLATION(op_shl); // 左シフト
M_BINARY_OPERATOR_VIOLATION(op_shr); // 右シフト
M_BINARY_OPERATOR_VIOLATION(op_sub); // 減算
M_BINARY_OPERATOR_VIOLATION(op_xor); // xor

// 比較演算もすべてVIOLATIONにしておく
M_BINARY_OPERATOR_VIOLATION(op_equal);         // a==b
M_BINARY_OPERATOR_VIOLATION(op_greater);       // a>b
M_BINARY_OPERATOR_VIOLATION(op_greater_equal); // a>=b
M_BINARY_OPERATOR_VIOLATION(op_not_nans);      // !isnan(a) && !isnan(b)
M_BINARY_OPERATOR_VIOLATION(op_not_equal);     // a!=b

#undef M_BINARY_OPERATOR_VIOLATION

// type_cast命令に対応したキャスト演算を行う。
void BasicOperator::type_cast(uint8_t* dst, vaddr_t type, uint8_t* src) {
  print_llvm_instruction();
  throw_error(Error::INST_VIOLATION);
}

// bit_cast命令に対応したキャスト演算を行う。
template <typename T> void PrimitiveOperator<T>::bit_cast(uint8_t* dst, size_t size, uint8_t* src) {
  longest_uint_t buffer = 0;
  memcpy(&buffer, src, sizeof(T));
  memcpy(dst, &buffer, size);
  print_debug("bitcast %s (%p <- %p)\n", Util::numptr2str(&buffer, size).c_str(), dst, src);
}

// 値をコピーする。
template <typename T> void PrimitiveOperator<T>::copy(uint8_t* dst, uint8_t* src) {
  *reinterpret_cast<T*>(dst) = *reinterpret_cast<T*>(src);
  print_debug("copy %s (%p <- %p)\n", Util::numptr2str(dst, sizeof(T)).c_str(), dst, src);
}

// 値を読み込む
/*
template <typename T> vm_int_t PrimitiveOperator<T>::get(uint8_t* src) {
  return static_cast<vm_int_t>(*reinterpret_cast<T*>(src));
  }*/

// 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
template <typename T> bool PrimitiveOperator<T>::is_or_nans(uint8_t* a, uint8_t* b) {
  // 整数演算ではサポートしない機能
  throw_error(Error::INST_VIOLATION);
}

namespace processwarp {

  // 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
  template<> bool PrimitiveOperator<double>::is_or_nans(uint8_t* a, uint8_t* b) {
    if (std::isnan(*reinterpret_cast<double*>(a)) ||
	std::isnan(*reinterpret_cast<double*>(b))) {
      return true;
    } else {
      return false;
    }
  }

  // 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
  template<> bool PrimitiveOperator<float>::is_or_nans(uint8_t* a, uint8_t* b) {
    if (std::isnan(*reinterpret_cast<float*>(a)) ||
	std::isnan(*reinterpret_cast<float*>(b))) {
      return true;
    } else {
      return false;
    }
  }
}

/**
 * 二項演算に対応したメソッドを生成する
 * @param op メソッド名
 * @param infix 演算中置子
 */
#define M_BINARY_OPERATOR_TYPE_EXTENDED(op, infix)			\
  template <typename T> void PrimitiveOperator<T>::op(uint8_t* dst, uint8_t* a, uint8_t* b) { \
    *reinterpret_cast<T*>(dst) = *reinterpret_cast<T*>(a) infix *reinterpret_cast<T*>(b); \
    print_debug("%p : %s = %s %s %s\n", dst, Util::numptr2str(dst, sizeof(T)).c_str(), \
		Util::numptr2str(a, sizeof(T)).c_str(),	#infix,		\
		Util::numptr2str(b, sizeof(T)).c_str());		\
  }

M_BINARY_OPERATOR_TYPE_EXTENDED(op_add, +); // 加算
M_BINARY_OPERATOR_TYPE_EXTENDED(op_and, &); // and
M_BINARY_OPERATOR_TYPE_EXTENDED(op_div, /); // 除算
M_BINARY_OPERATOR_TYPE_EXTENDED(op_mul, *); // 乗算
M_BINARY_OPERATOR_TYPE_EXTENDED(op_or,  |); // or
M_BINARY_OPERATOR_TYPE_EXTENDED(op_rem, %); // 剰余
M_BINARY_OPERATOR_TYPE_EXTENDED(op_sub, -); // 減算
M_BINARY_OPERATOR_TYPE_EXTENDED(op_xor, ^); // xor

#undef M_BINARY_OPERATOR_TYPE_EXTENDED

/**
 * 比較演算に対応したメソッドを生成する
 * @param op メソッド名
 * @param infix 演算中置子
 */
#define M_COMP_OPERATOR_TYPE_EXTENDED(op, infix)			\
  template <typename T> void PrimitiveOperator<T>::op(uint8_t* dst, uint8_t* a, uint8_t* b) { \
  *reinterpret_cast<uint8_t*>(dst) =					\
    (*reinterpret_cast<T*>(a) infix *reinterpret_cast<T*>(b)) ? 0x01 : 0x00; \
  print_debug("%p : %s = %s %s %s\n", dst,				\
	      Util::numptr2str(dst, 1).c_str(),				\
	      Util::numptr2str(a, sizeof(T)).c_str(), #infix,		\
	      Util::numptr2str(b, sizeof(T)).c_str());			\
  }

M_COMP_OPERATOR_TYPE_EXTENDED(op_equal,         ==); // a==b
M_COMP_OPERATOR_TYPE_EXTENDED(op_greater,       >);  // a>b
M_COMP_OPERATOR_TYPE_EXTENDED(op_greater_equal, >=); // a>=b
M_COMP_OPERATOR_TYPE_EXTENDED(op_not_equal,     !=); // a!=b

#undef M_COMP_OPERATOR_TYPE_EXTENDED

namespace processwarp {
  /**
   * サポートしない2項演算子用のメソッドを生成する
   * @param op メソッド名
   * @param type 型
   */
#define M_BINARY_OPERATOR_UNSUPPORT(op, type)				\
  template<> void PrimitiveOperator<type>::op(uint8_t* dst, uint8_t* a, uint8_t* b) { \
    throw_error(Error::UNSUPPORT);					\
  }

  M_BINARY_OPERATOR_UNSUPPORT(op_and, double); // and
  M_BINARY_OPERATOR_UNSUPPORT(op_or,  double); // or
  M_BINARY_OPERATOR_UNSUPPORT(op_rem, double); // 剰余
  M_BINARY_OPERATOR_UNSUPPORT(op_shl, double); // 左シフト
  M_BINARY_OPERATOR_UNSUPPORT(op_shr, double); // 右シフト
  M_BINARY_OPERATOR_UNSUPPORT(op_xor, double); // xor
  M_BINARY_OPERATOR_UNSUPPORT(op_and, float); // and
  M_BINARY_OPERATOR_UNSUPPORT(op_or,  float); // or
  M_BINARY_OPERATOR_UNSUPPORT(op_rem, float); // 剰余
  M_BINARY_OPERATOR_UNSUPPORT(op_shl, float); // 左シフト
  M_BINARY_OPERATOR_UNSUPPORT(op_shr, float); // 右シフト
  M_BINARY_OPERATOR_UNSUPPORT(op_xor, float); // xor

  // 比較演算のうち、整数型で未対応のもの
  M_BINARY_OPERATOR_UNSUPPORT(op_not_nans, int8_t);
  M_BINARY_OPERATOR_UNSUPPORT(op_not_nans, int16_t);
  M_BINARY_OPERATOR_UNSUPPORT(op_not_nans, int32_t);
  M_BINARY_OPERATOR_UNSUPPORT(op_not_nans, int64_t);
  M_BINARY_OPERATOR_UNSUPPORT(op_not_nans, uint8_t);
  M_BINARY_OPERATOR_UNSUPPORT(op_not_nans, uint16_t);
  M_BINARY_OPERATOR_UNSUPPORT(op_not_nans, uint32_t);
  M_BINARY_OPERATOR_UNSUPPORT(op_not_nans, uint64_t);

#undef M_BINARY_OPERATOR_UNSUPPORT

  // 比較命令(!isnan(a) && !isnan(b))に対応した演算を行う。
  template<> void PrimitiveOperator<double>::op_not_nans(uint8_t* dst, uint8_t* a, uint8_t* b) {
    if (!std::isnan(*reinterpret_cast<double*>(a)) &&
	!std::isnan(*reinterpret_cast<double*>(b))) {
      *dst = I8_TRUE;
    } else {
      *dst = I8_FALSE;
    }
    print_debug("not_nans %p : %s = %s not_nans %s\n", dst,
		Util::numptr2str(dst, 1).c_str(),
		Util::numptr2str(a, sizeof(double)).c_str(),
		Util::numptr2str(b, sizeof(double)).c_str());
  }

  // 比較命令(!isnan(a) && !isnan(b))に対応した演算を行う。
  template<> void PrimitiveOperator<float>::op_not_nans(uint8_t* dst, uint8_t* a, uint8_t* b) {
    if (!std::isnan(*reinterpret_cast<float*>(a)) &&
	!std::isnan(*reinterpret_cast<float*>(b))) {
      *dst = I8_TRUE;
    } else {
      *dst = I8_FALSE;
    }
    print_debug("not_nans %p : %s = %s not_nans %s\n", dst,
		Util::numptr2str(dst, 1).c_str(),
		Util::numptr2str(a, sizeof(float)).c_str(),
		Util::numptr2str(b, sizeof(float)).c_str());
  }

} // close "namespace processwarp"

// shl命令に対応した加算を行う。
template <typename T> void PrimitiveOperator<T>::op_shl(uint8_t* dst, uint8_t* a, uint8_t* b) {
  *reinterpret_cast<T*>(dst) =
    *reinterpret_cast<T*>(a) << static_cast<unsigned>(*reinterpret_cast<T*>(b));
  print_debug("shl %p : %s = %s << %s\n", dst,
	      Util::numptr2str(dst, sizeof(T)).c_str(),
	      Util::numptr2str(a, sizeof(T)).c_str(),
	      Util::numptr2str(b, sizeof(T)).c_str());
}

// shr命令に対応した加算を行う。
template <typename T> void PrimitiveOperator<T>::op_shr(uint8_t* dst, uint8_t* a, uint8_t* b) {
  *reinterpret_cast<T*>(dst) =
    *reinterpret_cast<T*>(a) >> static_cast<unsigned>(*reinterpret_cast<T*>(b));
  print_debug("shr %p : %s = %s << %s\n", dst,
	      Util::numptr2str(dst, sizeof(T)).c_str(),
	      Util::numptr2str(a, sizeof(T)).c_str(),
	      Util::numptr2str(b, sizeof(T)).c_str());
}

// type_cast命令に対応したキャスト演算を行う。
template <typename T> void PrimitiveOperator<T>::type_cast(uint8_t* dst, vaddr_t type, uint8_t* src) {
  switch(type) {
  case BasicType::TY_POINTER:
    *reinterpret_cast<vaddr_t*>(dst) = static_cast<unsigned>(*reinterpret_cast<T*>(src)); break;
    
  case BasicType::TY_UI8:
    *reinterpret_cast<uint8_t*>(dst) = static_cast<uint8_t>(*reinterpret_cast<T*>(src)); break;
    
  case BasicType::TY_UI16:
    *reinterpret_cast<uint16_t*>(dst) = static_cast<uint16_t>(*reinterpret_cast<T*>(src)); break;
    
  case BasicType::TY_UI32:
    *reinterpret_cast<uint32_t*>(dst) = static_cast<uint32_t>(*reinterpret_cast<T*>(src)); break;
    
  case BasicType::TY_UI64:
    *reinterpret_cast<uint64_t*>(dst) = static_cast<uint64_t>(*reinterpret_cast<T*>(src)); break;
    
  case BasicType::TY_SI8:
    *reinterpret_cast<int8_t*>(dst) = static_cast<int8_t>(*reinterpret_cast<T*>(src)); break;
    
  case BasicType::TY_SI16:
    *reinterpret_cast<int16_t*>(dst) = static_cast<int16_t>(*reinterpret_cast<T*>(src)); break;
    
  case BasicType::TY_SI32:
    *reinterpret_cast<int32_t*>(dst) = static_cast<int32_t>(*reinterpret_cast<T*>(src)); break;
    
  case BasicType::TY_SI64:
    *reinterpret_cast<int64_t*>(dst) = static_cast<int64_t>(*reinterpret_cast<T*>(src)); break;
    
  case BasicType::TY_F32:
    *reinterpret_cast<float*>(dst) = static_cast<float>(*reinterpret_cast<T*>(src)); break;

  case BasicType::TY_F64:
    *reinterpret_cast<double*>(dst) = static_cast<double>(*reinterpret_cast<T*>(src)); break;

  default: {
    throw_error_message(Error::CAST_VIOLATION, Util::vaddr2str(type));
  } break;
  }

  print_debug("type_cast:%s <- %s\n",
	      Util::numptr2str(dst, 8).c_str(),
	      Util::numptr2str(src, sizeof(T)).c_str());
}

// bit_cast命令に対応したキャスト演算を行う。
void PointerOperator::bit_cast(uint8_t* dst, size_t size, uint8_t* src) {
  // コピーサイズはvaddr_tのサイズと同じはず
  assert(size == sizeof(vaddr_t));
  *reinterpret_cast<vaddr_t*>(dst) = *reinterpret_cast<vaddr_t*>(src);
  print_debug("bitcast %s (%p <- %p)\n",
	      Util::numptr2str(dst, size).c_str(), dst, src);
}

// 値をコピーする。
void PointerOperator::copy(uint8_t* dst, uint8_t* src) {
  *reinterpret_cast<vaddr_t*>(dst) = *reinterpret_cast<vaddr_t*>(src);
  print_debug("copy %s (%p <- %p)\n",
	      Util::numptr2str(dst, sizeof(vaddr_t)).c_str(), dst, src);
}

// 比較命令(a==b)に対応した演算を行う。
void PointerOperator::op_equal(uint8_t* dst, uint8_t* a, uint8_t* b) {
  if (*reinterpret_cast<vaddr_t*>(a) == *reinterpret_cast<vaddr_t*>(b)) {
    *reinterpret_cast<uint8_t*>(dst) = I8_TRUE;
  } else {
    *reinterpret_cast<uint8_t*>(dst) = I8_FALSE;
  }
  print_debug("%p : %s = %s == %s\n", dst,
	      Util::numptr2str(dst, 1).c_str(),
	      Util::numptr2str(a, sizeof(vaddr_t)).c_str(),
	      Util::numptr2str(b, sizeof(vaddr_t)).c_str());
}

// 比較命令(a>b)に対応した演算を行う。
void PointerOperator::op_greater(uint8_t* dst, uint8_t* a, uint8_t* b) {
  if (*reinterpret_cast<vaddr_t*>(a) > *reinterpret_cast<vaddr_t*>(b)) {
    *reinterpret_cast<uint8_t*>(dst) = I8_TRUE;
  } else {
    *reinterpret_cast<uint8_t*>(dst) = I8_FALSE;
  }
  print_debug("%p : %s = %s > %s\n", dst,
	      Util::numptr2str(dst, 1).c_str(),
	      Util::numptr2str(a, sizeof(vaddr_t)).c_str(),
	      Util::numptr2str(b, sizeof(vaddr_t)).c_str());
}

// 比較命令(a>=b)に対応した演算を行う。
void PointerOperator::op_greater_equal(uint8_t* dst, uint8_t* a, uint8_t* b) {
  if (*reinterpret_cast<vaddr_t*>(a) >= *reinterpret_cast<vaddr_t*>(b)) {
    *reinterpret_cast<uint8_t*>(dst) = I8_TRUE;
  } else {
    *reinterpret_cast<uint8_t*>(dst) = I8_FALSE;
  }
  print_debug("%p : %s = %s >= %s\n", dst,
	      Util::numptr2str(dst, 1).c_str(),
	      Util::numptr2str(a, sizeof(vaddr_t)).c_str(),
	      Util::numptr2str(b, sizeof(vaddr_t)).c_str());
}

// 比較命令(a!=b)に対応した演算を行う。
void PointerOperator::op_not_equal(uint8_t* dst, uint8_t* a, uint8_t* b) {
  if (*reinterpret_cast<vaddr_t*>(a) == *reinterpret_cast<vaddr_t*>(b)) {
    *reinterpret_cast<uint8_t*>(dst) = I8_FALSE;
  } else {
    *reinterpret_cast<uint8_t*>(dst) = I8_TRUE;
  }
  print_debug("%p : %s = %s != %s\n", dst,
	      Util::numptr2str(dst, 1).c_str(),
	      Util::numptr2str(a, sizeof(vaddr_t)).c_str(),
	      Util::numptr2str(b, sizeof(vaddr_t)).c_str());
}

// type_cast命令に対応したキャスト演算を行う。
void PointerOperator::type_cast(uint8_t* dst, vaddr_t type, uint8_t* src) {
  switch (type) {
  case BasicType::TY_UI8:
  case BasicType::TY_SI8:
    *reinterpret_cast<uint8_t*>(dst) = static_cast<uint8_t>(*reinterpret_cast<vaddr_t*>(src));
    break;
    
  case BasicType::TY_UI16:
  case BasicType::TY_SI16:
    *reinterpret_cast<uint16_t*>(dst) = static_cast<uint16_t>(*reinterpret_cast<vaddr_t*>(src));
    break;
    
  case BasicType::TY_UI32:
  case BasicType::TY_SI32:
    *reinterpret_cast<uint32_t*>(dst) = static_cast<uint32_t>(*reinterpret_cast<vaddr_t*>(src));
    break;
    
  case BasicType::TY_UI64:
  case BasicType::TY_SI64:
    *reinterpret_cast<uint64_t*>(dst) = static_cast<uint64_t>(*reinterpret_cast<vaddr_t*>(src));
    break;
    
  default:
    throw_error_message(Error::CAST_VIOLATION, Util::vaddr2str(type));
  }
  
  print_debug("type_cast:%s <- %s\n",
	      Util::numptr2str(dst, 8).c_str(),
	      Util::numptr2str(src, sizeof(vaddr_t)).c_str());
}

// 値をコピーする。
/*
void OperatorForComplex::copy(uint8_t* dst, uint8_t* src) {
  memcpy(dst, src, type_store->size);
  }//*/

// 明示的テンプレートのインスタンス化
template class processwarp::PrimitiveOperator<int8_t>;
template class processwarp::PrimitiveOperator<int16_t>;
template class processwarp::PrimitiveOperator<int32_t>;
template class processwarp::PrimitiveOperator<int64_t>;
template class processwarp::PrimitiveOperator<uint8_t>;
template class processwarp::PrimitiveOperator<uint16_t>;
template class processwarp::PrimitiveOperator<uint32_t>;
template class processwarp::PrimitiveOperator<uint64_t>;
template class processwarp::PrimitiveOperator<float>;
template class processwarp::PrimitiveOperator<double>;
