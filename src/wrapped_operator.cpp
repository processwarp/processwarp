
#include <cassert>
#include <cmath>
#include <cstdint>
#include <cstring>

#include "error.hpp"
#include "type_store.hpp"
#include "util.hpp"
#include "wrapped_operator.hpp"

using namespace processwarp;

// Constructor with memory accessor.
WrappedOperator::WrappedOperator(VMemory::Accessor& memory_) :
  memory(memory_) {
}

// デストラクタ。
WrappedOperator::~WrappedOperator() {
  // 基底クラスなため、virtual宣言を行うが何もしない。
}

// bit_cast命令に対応したキャスト演算を行う。
void WrappedOperator::bit_cast(vaddr_t dst, size_t size, vaddr_t src) {
  throw_error(Error::INST_VIOLATION);
}

// 値をコピーする。
void WrappedOperator::copy(vaddr_t dst, vaddr_t src) {
  throw_error(Error::INST_VIOLATION);
}

// 値を読み込む
vm_int_t WrappedOperator::get(vaddr_t src) {
  throw_error(Error::INST_VIOLATION);
}

// 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
bool WrappedOperator::is_or_nans(vaddr_t a, vaddr_t b) {
  throw_error(Error::INST_VIOLATION);
}

/**
 * TypeBaseクラスの2項演算子はすべてVOILATIONとする。
 * @param op メソッド名
 */
#define M_BINARY_OPERATOR_VIOLATION(op)				\
  void WrappedOperator::op(vaddr_t dst, vaddr_t a, vaddr_t b) {	\
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

/** */
bool WrappedOperator::is_equal(vaddr_t a, vaddr_t b) {
  throw_error(Error::INST_VIOLATION);
}

// type_cast命令に対応したキャスト演算を行う。
void WrappedOperator::type_cast(vaddr_t dst, vaddr_t type, vaddr_t src) {
  print_llvm_instruction();
  throw_error(Error::INST_VIOLATION);
}

// Constructor with memory accessor.
template <typename T> WrappedPrimitiveOperator<T>::WrappedPrimitiveOperator(VMemory::Accessor& memory) :
  WrappedOperator(memory) {
}

// bit_cast命令に対応したキャスト演算を行う。
template <typename T> void WrappedPrimitiveOperator<T>::bit_cast(vaddr_t dst, size_t size, vaddr_t src) {
  longest_uint_t buffer = 0;
  *reinterpret_cast<T*>(buffer) = memory.get<T>(src);
  memory.set_copy(dst, reinterpret_cast<const uint8_t*>(&buffer), size);
  print_debug("bitcast %" PRId64 " (%016" PRIx64 " <- %016" PRIx64 ")\n", buffer, dst, src);
}

// 値をコピーする。
template <typename T> void WrappedPrimitiveOperator<T>::copy(vaddr_t dst, vaddr_t src) {
  memory.set<T>(dst, memory.get<T>(src));
  print_debug("copy %" PRId64 " (%016" PRIx64 " <- %016" PRIx64")\n",
	      static_cast<longest_int_t>(memory.get<T>(src)), dst, src);
}

// 値を読み込む
template <typename T> vm_int_t WrappedPrimitiveOperator<T>::get(vaddr_t src) {
  return static_cast<vm_int_t>(memory.get<T>(src));
}

// 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
template <typename T> bool WrappedPrimitiveOperator<T>::is_or_nans(vaddr_t a, vaddr_t b) {
  // 整数演算ではサポートしない機能
  throw_error(Error::INST_VIOLATION);
}

namespace processwarp {

  // 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
  template<> bool WrappedPrimitiveOperator<double>::is_or_nans(vaddr_t a, vaddr_t b) {
    if (std::isnan(memory.get<double>(a)) ||
	std::isnan(memory.get<double>(b))) {
      return true;

    } else {
      return false;
    }
  }

  // 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
  template<> bool WrappedPrimitiveOperator<float>::is_or_nans(vaddr_t a, vaddr_t b) {
    if (std::isnan(memory.get<float>(a)) ||
	std::isnan(memory.get<float>(b))) {
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
  template <typename T> void WrappedPrimitiveOperator<T>::op(vaddr_t dst, vaddr_t a, vaddr_t b) { \
    memory.set<T>(dst, memory.get<T>(a) infix memory.get<T>(b));	\
    print_debug("%016" PRIx64 " : %" PRId64 " = %" PRId64 " %s %" PRId64 "\n", \
		dst, static_cast<longest_int_t>(memory.get<T>(dst)), \
		static_cast<longest_int_t>(memory.get<T>(a)), \
		#infix,	static_cast<longest_int_t>(memory.get<T>(b)));	\
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
  template <typename T> void WrappedPrimitiveOperator<T>::op(vaddr_t dst, vaddr_t a, vaddr_t b) { \
    memory.set<uint8_t>(dst, (memory.get<T>(a) infix memory.get<T>(b)) ? 0x01 : 0x00); \
    print_debug("%016" PRIx64 " : %d = %" PRId64 " %s %" PRId64 "\n", dst, \
		memory.get<uint8_t>(dst),				\
		static_cast<longest_int_t>(memory.get<T>(a)), #infix,	\
		static_cast<longest_int_t>(memory.get<T>(b)));		\
  }

M_COMP_OPERATOR_TYPE_EXTENDED(op_equal,         ==); // a==b
M_COMP_OPERATOR_TYPE_EXTENDED(op_greater,       >);  // a>b
M_COMP_OPERATOR_TYPE_EXTENDED(op_greater_equal, >=); // a>=b
M_COMP_OPERATOR_TYPE_EXTENDED(op_not_equal,     !=); // a!=b

#undef M_COMP_OPERATOR_TYPE_EXTENDED

/** */
template <typename T> bool WrappedPrimitiveOperator<T>::is_equal(vaddr_t a, vaddr_t b) {
  return memory.get<T>(a) == memory.get<T>(b);
}

namespace processwarp {
  /**
   * サポートしない2項演算子用のメソッドを生成する
   * @param op メソッド名
   * @param type 型
   */
#define M_BINARY_OPERATOR_UNSUPPORT(op, type)				\
  template<> void WrappedPrimitiveOperator<type>::op(vaddr_t dst, vaddr_t a, vaddr_t b) { \
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
  template<> void WrappedPrimitiveOperator<double>::op_not_nans(vaddr_t dst, vaddr_t a, vaddr_t b) {
    if (!std::isnan(memory.get<double>(a)) &&
	!std::isnan(memory.get<double>(b))) {
      memory.set<uint8_t>(dst, I8_TRUE);

    } else {
      memory.set<uint8_t>(dst, I8_FALSE);
    }

    print_debug("not_nans %016" PRIx64 " : %d = %" PRId64 " not_nans %" PRId64 "\n", dst,
		memory.get<uint8_t>(dst),
		static_cast<longest_int_t>(memory.get<double>(a)),
		static_cast<longest_int_t>(memory.get<double>(b)));
  }

  // 比較命令(!isnan(a) && !isnan(b))に対応した演算を行う。
  template<> void WrappedPrimitiveOperator<float>::op_not_nans(vaddr_t dst, vaddr_t a, vaddr_t b) {
    if (!std::isnan(memory.get<float>(a)) &&
	!std::isnan(memory.get<float>(b))) {
      memory.set<uint8_t>(dst, I8_TRUE);

    } else {
      memory.set<uint8_t>(dst, I8_FALSE);
    }

    print_debug("not_nans %016" PRIx64 " : %d = %" PRId64 " not_nans %" PRId64 "\n", dst,
		memory.get<uint8_t>(dst),
		static_cast<longest_int_t>(memory.get<float>(a)),
		static_cast<longest_int_t>(memory.get<float>(b)));
  }

} // close "namespace processwarp"

// shl命令に対応した加算を行う。
template <typename T> void WrappedPrimitiveOperator<T>::op_shl(vaddr_t dst, vaddr_t a, vaddr_t b) {
  memory.set<T>(dst, memory.get<T>(a) << static_cast<unsigned>(memory.get<T>(b)));
  print_debug("shl %016" PRIx64 " : %d = %" PRId64 " << %" PRId64 "\n", dst,
	      memory.get<uint8_t>(dst),
	      static_cast<longest_int_t>(memory.get<float>(a)),
	      static_cast<longest_int_t>(memory.get<float>(b)));
}

// shr命令に対応した加算を行う。
template <typename T> void WrappedPrimitiveOperator<T>::op_shr(vaddr_t dst, vaddr_t a, vaddr_t b) {
  memory.set<T>(dst, memory.get<T>(a) >> static_cast<unsigned>(memory.get<T>(b)));
  print_debug("shl %016" PRIx64 " : %d = %" PRId64 " >> %" PRId64 "\n", dst,
	      memory.get<uint8_t>(dst),
	      static_cast<longest_int_t>(memory.get<float>(a)),
	      static_cast<longest_int_t>(memory.get<float>(b)));
}

// type_cast命令に対応したキャスト演算を行う。
template <typename T> void WrappedPrimitiveOperator<T>::type_cast(vaddr_t dst, vaddr_t type, vaddr_t src) {
  switch(type) {
  case BasicType::TY_POINTER:
    memory.set<vaddr_t>(dst, static_cast<unsigned>(memory.get<T>(src))); break;
    
  case BasicType::TY_UI8:
    memory.set<uint8_t>(dst, static_cast<uint8_t>(memory.get<T>(src))); break;
    
  case BasicType::TY_UI16:
    memory.set<uint16_t>(dst, static_cast<uint16_t>(memory.get<T>(src))); break;
    
  case BasicType::TY_UI32:
    memory.set<uint32_t>(dst, static_cast<uint32_t>(memory.get<T>(src))); break;
    
  case BasicType::TY_UI64:
    memory.set<uint64_t>(dst, static_cast<uint64_t>(memory.get<T>(src))); break;
    
  case BasicType::TY_SI8:
    memory.set<int8_t>(dst, static_cast<int8_t>(memory.get<T>(src))); break;
    
  case BasicType::TY_SI16:
    memory.set<int16_t>(dst, static_cast<int16_t>(memory.get<T>(src))); break;
    
  case BasicType::TY_SI32:
    memory.set<int32_t>(dst, static_cast<int32_t>(memory.get<T>(src))); break;
    
  case BasicType::TY_SI64:
    memory.set<int64_t>(dst, static_cast<int64_t>(memory.get<T>(src))); break;
    
  case BasicType::TY_F32:
    memory.set<float>(dst, static_cast<float>(memory.get<T>(src))); break;

  case BasicType::TY_F64:
    memory.set<double>(dst, static_cast<double>(memory.get<T>(src))); break;

  default: {
    throw_error_message(Error::CAST_VIOLATION, Util::vaddr2str(type));
  } break;
  }

  print_debug("type_cast:%" PRId64 " <- %" PRId64 "\n",
	      memory.get<longest_int_t>(dst),
	      static_cast<longest_int_t>(memory.get<T>(src)));
}

// Constructor with memory accessor.
WrappedPointerOperator::WrappedPointerOperator(VMemory::Accessor& memory) :
  WrappedOperator(memory) {
}

// bit_cast命令に対応したキャスト演算を行う。
void WrappedPointerOperator::bit_cast(vaddr_t dst, size_t size, vaddr_t src) {
  // コピーサイズはvaddr_tのサイズと同じはず
  assert(size == sizeof(vaddr_t));
  memory.set<vaddr_t>(dst, memory.get<vaddr_t>(src));
  print_debug("bitcast %016" PRIx64 " (%016" PRIx64 " <- %016" PRIx64 ")\n",
	      memory.get<vaddr_t>(dst), dst, src);
}

// 値をコピーする。
void WrappedPointerOperator::copy(vaddr_t dst, vaddr_t src) {
  memory.set<vaddr_t>(dst, memory.get<vaddr_t>(src));
  print_debug("copy %016" PRIx64 " (%016" PRIx64 " <- %016" PRIx64 ")\n",
	      memory.get<vaddr_t>(dst), dst, src);
}

// 比較命令(a==b)に対応した演算を行う。
void WrappedPointerOperator::op_equal(vaddr_t dst, vaddr_t a, vaddr_t b) {
  if (memory.get<vaddr_t>(a) == memory.get<vaddr_t>(b)) {
    memory.set<uint8_t>(dst, I8_TRUE);

  } else {
    memory.set<uint8_t>(dst, I8_FALSE);
  }

  print_debug("%016" PRIx64 " : %d = %016" PRIx64 " == %016" PRIx64 "\n", dst,
	      memory.get<uint8_t>(dst),
	      memory.get<vaddr_t>(a), memory.get<vaddr_t>(b));
}

bool WrappedPointerOperator::is_equal(vaddr_t a, vaddr_t b) {
  return memory.get<vaddr_t>(a) == memory.get<vaddr_t>(b);
}

// 比較命令(a>b)に対応した演算を行う。
void WrappedPointerOperator::op_greater(vaddr_t dst, vaddr_t a, vaddr_t b) {
  if (memory.get<vaddr_t>(a) > memory.get<vaddr_t>(b)) {
    memory.set<uint8_t>(dst, I8_TRUE);

  } else {
    memory.set<uint8_t>(dst, I8_FALSE);
  }

  print_debug("%016" PRIx64 " : %d = %016" PRIx64 " > %016" PRIx64 "\n", dst,
	      memory.get<uint8_t>(dst),
	      memory.get<vaddr_t>(a), memory.get<vaddr_t>(b));
}

// 比較命令(a>=b)に対応した演算を行う。
void WrappedPointerOperator::op_greater_equal(vaddr_t dst, vaddr_t a, vaddr_t b) {
  if (memory.get<vaddr_t>(a) >= memory.get<vaddr_t>(b)) {
    memory.set<uint8_t>(dst, I8_TRUE);

  } else {
    memory.set<uint8_t>(dst, I8_FALSE);
  }

  print_debug("%016" PRIx64 " : %d = %016" PRIx64 " >= %016" PRIx64 "\n", dst,
	      memory.get<uint8_t>(dst),
	      memory.get<vaddr_t>(a), memory.get<vaddr_t>(b));
}

// 比較命令(a!=b)に対応した演算を行う。
void WrappedPointerOperator::op_not_equal(vaddr_t dst, vaddr_t a, vaddr_t b) {
  if (*reinterpret_cast<vaddr_t*>(a) != *reinterpret_cast<vaddr_t*>(b)) {
    *reinterpret_cast<uint8_t*>(dst) = I8_TRUE;
  } else {
    *reinterpret_cast<uint8_t*>(dst) = I8_FALSE;
  }

  print_debug("%016" PRIx64 " : %d = %016" PRIx64 " >= %016" PRIx64 "\n", dst,
	      memory.get<uint8_t>(dst),
	      memory.get<vaddr_t>(a), memory.get<vaddr_t>(b));
}

// type_cast命令に対応したキャスト演算を行う。
void WrappedPointerOperator::type_cast(vaddr_t dst, vaddr_t type, vaddr_t src) {
  switch (type) {
  case BasicType::TY_UI8:
  case BasicType::TY_SI8:
    memory.set<uint8_t>(dst, static_cast<uint8_t>(memory.get<vaddr_t>(src)));
    break;
    
  case BasicType::TY_UI16:
  case BasicType::TY_SI16:
    memory.set<uint16_t>(dst, static_cast<uint16_t>(memory.get<vaddr_t>(src)));
    break;
    
  case BasicType::TY_UI32:
  case BasicType::TY_SI32:
    memory.set<uint32_t>(dst, static_cast<uint32_t>(memory.get<vaddr_t>(src)));
    break;
    
  case BasicType::TY_UI64:
  case BasicType::TY_SI64:
    memory.set<uint64_t>(dst, static_cast<uint64_t>(memory.get<vaddr_t>(src)));
    break;
    
  default:
    throw_error_message(Error::CAST_VIOLATION, Util::vaddr2str(type));
  }
  
  print_debug("type_cast:%" PRId64 " <- %016" PRIx64 "\n",
	      memory.get<longest_int_t>(dst),
	      memory.get<vaddr_t>(src));
}

// Constructor with memory accessor.
WrappedComplexOperator::WrappedComplexOperator(VMemory::Accessor& memory) :
  WrappedOperator(memory) {
}

// 値をコピーする。
void WrappedComplexOperator::copy(vaddr_t dst, vaddr_t src) {
  memory.set_copy(dst, src, type_store->size);
}

// 明示的テンプレートのインスタンス化
template class processwarp::WrappedPrimitiveOperator<int8_t>;
template class processwarp::WrappedPrimitiveOperator<int16_t>;
template class processwarp::WrappedPrimitiveOperator<int32_t>;
template class processwarp::WrappedPrimitiveOperator<int64_t>;
template class processwarp::WrappedPrimitiveOperator<uint8_t>;
template class processwarp::WrappedPrimitiveOperator<uint16_t>;
template class processwarp::WrappedPrimitiveOperator<uint32_t>;
template class processwarp::WrappedPrimitiveOperator<uint64_t>;
template class processwarp::WrappedPrimitiveOperator<float>;
template class processwarp::WrappedPrimitiveOperator<double>;
