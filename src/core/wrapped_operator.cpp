
#include <cassert>
#include <cmath>
#include <cstdint>
#include <cstring>

#include "error.hpp"
#include "type_store.hpp"
#include "util.hpp"
#include "wrapped_operator.hpp"

namespace processwarp {

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
void WrappedOperator::copy_value(vaddr_t dst, vaddr_t src) {
  throw_error(Error::INST_VIOLATION);
}

// 値を読み込む
longest_int_t WrappedOperator::get(vaddr_t src) {
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
#define M_BINARY_OPERATOR_VIOLATION(op)                         \
  void WrappedOperator::op(vaddr_t dst, vaddr_t a, vaddr_t b) { \
    throw_error(Error::INST_VIOLATION);                         \
  }

M_BINARY_OPERATOR_VIOLATION(op_add);    // 加算
M_BINARY_OPERATOR_VIOLATION(op_and);    // and
M_BINARY_OPERATOR_VIOLATION(op_div);    // 除算
M_BINARY_OPERATOR_VIOLATION(op_mul);    // 乗算
M_BINARY_OPERATOR_VIOLATION(op_or);     // or
M_BINARY_OPERATOR_VIOLATION(op_rem);    // 剰余
M_BINARY_OPERATOR_VIOLATION(op_shl);    // 左シフト
M_BINARY_OPERATOR_VIOLATION(op_shr);    // 右シフト
M_BINARY_OPERATOR_VIOLATION(op_sub);    // 減算
M_BINARY_OPERATOR_VIOLATION(op_xor);    // xor

// 比較演算もすべてVIOLATIONにしておく
M_BINARY_OPERATOR_VIOLATION(op_equal);          // a==b
M_BINARY_OPERATOR_VIOLATION(op_greater);        // a>b
M_BINARY_OPERATOR_VIOLATION(op_greater_equal);  // a>=b
M_BINARY_OPERATOR_VIOLATION(op_not_nans);       // !isnan(a) && !isnan(b)
M_BINARY_OPERATOR_VIOLATION(op_not_equal);      // a!=b

#undef M_BINARY_OPERATOR_VIOLATION

/** */
bool WrappedOperator::is_equal(vaddr_t a, vaddr_t b) {
  throw_error(Error::INST_VIOLATION);
}

// type_cast命令に対応したキャスト演算を行う。
void WrappedOperator::type_cast(vaddr_t dst, vaddr_t type, vaddr_t src) {
  // print_llvm_instruction();
  throw_error(Error::INST_VIOLATION);
}

// Constructor with memory accessor.
template <typename T>
WrappedPrimitiveOperator<T>::WrappedPrimitiveOperator(VMemory::Accessor& memory) :
    WrappedOperator(memory) {
}

// bit_cast命令に対応したキャスト演算を行う。
template <typename T>
void WrappedPrimitiveOperator<T>::bit_cast(vaddr_t dst, size_t size, vaddr_t src) {
  longest_uint_t buffer = 0;
  *reinterpret_cast<T*>(buffer) = memory.read<T>(src);
  memory.write_copy(dst, reinterpret_cast<const uint8_t*>(&buffer), size);
  // print_debug("bitcast %" PRId64 " (%016" PRIx64 " <- %016" PRIx64 ")\n", buffer, dst, src);
}

// 値をコピーする。
template <typename T>
void WrappedPrimitiveOperator<T>::copy_value(vaddr_t dst, vaddr_t src) {
  memory.write<T>(dst, memory.read<T>(src));
  /*
    print_debug("copy_value %" PRId64 " (%016" PRIx64 " <- %016" PRIx64")\n",
    static_cast<longest_int_t>(memory.read<T>(src)), dst, src);//*/
}

// 値を読み込む
template <typename T>
longest_int_t WrappedPrimitiveOperator<T>::get(vaddr_t src) {
  return static_cast<longest_int_t>(memory.read<T>(src));
}

// 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
template <typename T>
bool WrappedPrimitiveOperator<T>::is_or_nans(vaddr_t a, vaddr_t b) {
  // 整数演算ではサポートしない機能
  throw_error(Error::INST_VIOLATION);
}

// 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
template<>
bool WrappedPrimitiveOperator<double>::is_or_nans(vaddr_t a, vaddr_t b) {
  if (std::isnan(memory.read<double>(a)) ||
      std::isnan(memory.read<double>(b))) {
    return true;

  } else {
    return false;
  }
}

// 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
template<>
bool WrappedPrimitiveOperator<float>::is_or_nans(vaddr_t a, vaddr_t b) {
  if (std::isnan(memory.read<float>(a)) ||
      std::isnan(memory.read<float>(b))) {
    return true;

  } else {
    return false;
  }
}

/**
 * 二項演算に対応したメソッドを生成する
 * @param op メソッド名
 * @param infix 演算中置子
 */
#define M_BINARY_OPERATOR_TYPE_EXTENDED(op, infix)                      \
  template <typename T>                                                 \
  void WrappedPrimitiveOperator<T>::op(vaddr_t dst, vaddr_t a, vaddr_t b) { \
    memory.write<T>(dst, memory.read<T>(a) infix memory.read<T>(b));        \
  }

M_BINARY_OPERATOR_TYPE_EXTENDED(op_add, +);     // 加算
M_BINARY_OPERATOR_TYPE_EXTENDED(op_and, &);     // and
M_BINARY_OPERATOR_TYPE_EXTENDED(op_div, /);     // 除算
M_BINARY_OPERATOR_TYPE_EXTENDED(op_mul, *);     // 乗算
M_BINARY_OPERATOR_TYPE_EXTENDED(op_or,  |);     // or
M_BINARY_OPERATOR_TYPE_EXTENDED(op_rem, %);     // 剰余
M_BINARY_OPERATOR_TYPE_EXTENDED(op_sub, -);     // 減算
M_BINARY_OPERATOR_TYPE_EXTENDED(op_xor, ^);     // xor

#undef M_BINARY_OPERATOR_TYPE_EXTENDED

/**
 * 比較演算に対応したメソッドを生成する
 * @param op メソッド名
 * @param infix 演算中置子
 */
#define M_COMP_OPERATOR_TYPE_EXTENDED(op, infix)                        \
  template <typename T>                                                 \
  void WrappedPrimitiveOperator<T>::op(vaddr_t dst, vaddr_t a, vaddr_t b) { \
    memory.write<uint8_t>(dst, (memory.read<T>(a) infix memory.read<T>(b)) ? 0x01 : 0x00); \
  }

M_COMP_OPERATOR_TYPE_EXTENDED(op_equal,         ==);    // a==b
M_COMP_OPERATOR_TYPE_EXTENDED(op_greater,       >);     // a>b
M_COMP_OPERATOR_TYPE_EXTENDED(op_greater_equal, >=);    // a>=b
M_COMP_OPERATOR_TYPE_EXTENDED(op_not_equal,     !=);    // a!=b

#undef M_COMP_OPERATOR_TYPE_EXTENDED

/** */
template <typename T>
bool WrappedPrimitiveOperator<T>::is_equal(vaddr_t a, vaddr_t b) {
  return memory.read<T>(a) == memory.read<T>(b);
}

/**
 * サポートしない2項演算子用のメソッドを生成する
 * @param op メソッド名
 * @param type 型
 */
#define M_BINARY_OPERATOR_UNSUPPORT(op, type)                           \
  template<>                                                            \
  void WrappedPrimitiveOperator<type>::op(vaddr_t dst, vaddr_t a, vaddr_t b) { \
    throw_error(Error::UNSUPPORT);                                      \
  }

M_BINARY_OPERATOR_UNSUPPORT(op_and, double);    // and
M_BINARY_OPERATOR_UNSUPPORT(op_or,  double);    // or
M_BINARY_OPERATOR_UNSUPPORT(op_rem, double);    // 剰余
M_BINARY_OPERATOR_UNSUPPORT(op_shl, double);    // 左シフト
M_BINARY_OPERATOR_UNSUPPORT(op_shr, double);    // 右シフト
M_BINARY_OPERATOR_UNSUPPORT(op_xor, double);    // xor
M_BINARY_OPERATOR_UNSUPPORT(op_and, float);     // and
M_BINARY_OPERATOR_UNSUPPORT(op_or,  float);     // or
M_BINARY_OPERATOR_UNSUPPORT(op_rem, float);     // 剰余
M_BINARY_OPERATOR_UNSUPPORT(op_shl, float);     // 左シフト
M_BINARY_OPERATOR_UNSUPPORT(op_shr, float);     // 右シフト
M_BINARY_OPERATOR_UNSUPPORT(op_xor, float);     // xor

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
template<>
void WrappedPrimitiveOperator<double>::op_not_nans(vaddr_t dst, vaddr_t a, vaddr_t b) {
  if (!std::isnan(memory.read<double>(a)) &&
      !std::isnan(memory.read<double>(b))) {
    memory.write<uint8_t>(dst, I8_TRUE);

  } else {
    memory.write<uint8_t>(dst, I8_FALSE);
  }
  /*
    print_debug("not_nans %016" PRIx64 " : %d = %" PRId64 " not_nans %" PRId64 "\n", dst,
    memory.read<uint8_t>(dst),
    static_cast<longest_int_t>(memory.read<double>(a)),
    static_cast<longest_int_t>(memory.read<double>(b)));//*/
}

// 比較命令(!isnan(a) && !isnan(b))に対応した演算を行う。
template<>
void WrappedPrimitiveOperator<float>::op_not_nans(vaddr_t dst, vaddr_t a, vaddr_t b) {
  if (!std::isnan(memory.read<float>(a)) &&
      !std::isnan(memory.read<float>(b))) {
    memory.write<uint8_t>(dst, I8_TRUE);

  } else {
    memory.write<uint8_t>(dst, I8_FALSE);
  }
  /*
    print_debug("not_nans %016" PRIx64 " : %d = %" PRId64 " not_nans %" PRId64 "\n", dst,
    memory.read<uint8_t>(dst),
    static_cast<longest_int_t>(memory.read<float>(a)),
    static_cast<longest_int_t>(memory.read<float>(b)));//*/
}

// shl命令に対応した加算を行う。
template <typename T>
void WrappedPrimitiveOperator<T>::op_shl(vaddr_t dst, vaddr_t a, vaddr_t b) {
  memory.write<T>(dst, memory.read<T>(a) << static_cast<unsigned>(memory.read<T>(b)));
  /*
    print_debug("shl %016" PRIx64 " : %d = %" PRId64 " << %" PRId64 "\n", dst,
    memory.read<uint8_t>(dst),
    static_cast<longest_int_t>(memory.read<float>(a)),
    static_cast<longest_int_t>(memory.read<float>(b)));//*/
}

// shr命令に対応した加算を行う。
template <typename T>
void WrappedPrimitiveOperator<T>::op_shr(vaddr_t dst, vaddr_t a, vaddr_t b) {
  memory.write<T>(dst, memory.read<T>(a) >> static_cast<unsigned>(memory.read<T>(b)));
  /*
    print_debug("shl %016" PRIx64 " : %d = %" PRId64 " >> %" PRId64 "\n", dst,
    memory.read<uint8_t>(dst),
    static_cast<longest_int_t>(memory.read<float>(a)),
    static_cast<longest_int_t>(memory.read<float>(b)));//*/
}

// type_cast命令に対応したキャスト演算を行う。
template <typename T>
void WrappedPrimitiveOperator<T>::type_cast(vaddr_t dst, vaddr_t type, vaddr_t src) {
  switch (type) {
    case BasicTypeAddress::POINTER:
      memory.write<vaddr_t>(dst, static_cast<unsigned>(memory.read<T>(src))); break;

    case BasicTypeAddress::UI8:
      memory.write<uint8_t>(dst, static_cast<uint8_t>(memory.read<T>(src))); break;

    case BasicTypeAddress::UI16:
      memory.write<uint16_t>(dst, static_cast<uint16_t>(memory.read<T>(src))); break;

    case BasicTypeAddress::UI32:
      memory.write<uint32_t>(dst, static_cast<uint32_t>(memory.read<T>(src))); break;

    case BasicTypeAddress::UI64:
      memory.write<uint64_t>(dst, static_cast<uint64_t>(memory.read<T>(src))); break;

    case BasicTypeAddress::SI8:
      memory.write<int8_t>(dst, static_cast<int8_t>(memory.read<T>(src))); break;

    case BasicTypeAddress::SI16:
      memory.write<int16_t>(dst, static_cast<int16_t>(memory.read<T>(src))); break;

    case BasicTypeAddress::SI32:
      memory.write<int32_t>(dst, static_cast<int32_t>(memory.read<T>(src))); break;

    case BasicTypeAddress::SI64:
      memory.write<int64_t>(dst, static_cast<int64_t>(memory.read<T>(src))); break;

    case BasicTypeAddress::F32:
      memory.write<float>(dst, static_cast<float>(memory.read<T>(src))); break;

    case BasicTypeAddress::F64:
      memory.write<double>(dst, static_cast<double>(memory.read<T>(src))); break;

    default: {
      throw_error_message(Error::CAST_VIOLATION, Util::vaddr2str(type));
    } break;
  }
  /*
    print_debug("type_cast:%" PRId64 " <- %" PRId64 "\n",
    memory.read<longest_int_t>(dst),
    static_cast<longest_int_t>(memory.read<T>(src)));//*/
}

// Constructor with memory accessor.
WrappedPointerOperator::WrappedPointerOperator(VMemory::Accessor& memory) :
    WrappedOperator(memory) {
}

// bit_cast命令に対応したキャスト演算を行う。
void WrappedPointerOperator::bit_cast(vaddr_t dst, size_t size, vaddr_t src) {
  // コピーサイズはvaddr_tのサイズと同じはず
  assert(size == sizeof(vaddr_t));
  memory.write<vaddr_t>(dst, memory.read<vaddr_t>(src));
  /*
    print_debug("bitcast %016" PRIx64 " (%016" PRIx64 " <- %016" PRIx64 ")\n",
    memory.read<vaddr_t>(dst), dst, src);//*/
}

// 値をコピーする。
void WrappedPointerOperator::copy_value(vaddr_t dst, vaddr_t src) {
  memory.write<vaddr_t>(dst, memory.read<vaddr_t>(src));
  /*
    print_debug("copy_value %016" PRIx64 " (%016" PRIx64 " <- %016" PRIx64 ")\n",
    memory.read<vaddr_t>(dst), dst, src);//*/
}

// 比較命令(a==b)に対応した演算を行う。
void WrappedPointerOperator::op_equal(vaddr_t dst, vaddr_t a, vaddr_t b) {
  if (memory.read<vaddr_t>(a) == memory.read<vaddr_t>(b)) {
    memory.write<uint8_t>(dst, I8_TRUE);

  } else {
    memory.write<uint8_t>(dst, I8_FALSE);
  }
  /*
    print_debug("%016" PRIx64 " : %d = %016" PRIx64 " == %016" PRIx64 "\n", dst,
    memory.read<uint8_t>(dst),
    memory.read<vaddr_t>(a), memory.read<vaddr_t>(b));//*/
}

bool WrappedPointerOperator::is_equal(vaddr_t a, vaddr_t b) {
  return memory.read<vaddr_t>(a) == memory.read<vaddr_t>(b);
}

// 比較命令(a>b)に対応した演算を行う。
void WrappedPointerOperator::op_greater(vaddr_t dst, vaddr_t a, vaddr_t b) {
  if (memory.read<vaddr_t>(a) > memory.read<vaddr_t>(b)) {
    memory.write<uint8_t>(dst, I8_TRUE);

  } else {
    memory.write<uint8_t>(dst, I8_FALSE);
  }
  /*
    print_debug("%016" PRIx64 " : %d = %016" PRIx64 " > %016" PRIx64 "\n", dst,
    memory.read<uint8_t>(dst),
    memory.read<vaddr_t>(a), memory.read<vaddr_t>(b));//*/
}

// 比較命令(a>=b)に対応した演算を行う。
void WrappedPointerOperator::op_greater_equal(vaddr_t dst, vaddr_t a, vaddr_t b) {
  if (memory.read<vaddr_t>(a) >= memory.read<vaddr_t>(b)) {
    memory.write<uint8_t>(dst, I8_TRUE);

  } else {
    memory.write<uint8_t>(dst, I8_FALSE);
  }
  /*
    print_debug("%016" PRIx64 " : %d = %016" PRIx64 " >= %016" PRIx64 "\n", dst,
    memory.read<uint8_t>(dst),
    memory.read<vaddr_t>(a), memory.read<vaddr_t>(b));//*/
}

// 比較命令(a!=b)に対応した演算を行う。
void WrappedPointerOperator::op_not_equal(vaddr_t dst, vaddr_t a, vaddr_t b) {
  if (memory.read<vaddr_t>(a) != memory.read<vaddr_t>(b)) {
    memory.write<uint8_t>(dst, I8_TRUE);
  } else {
    memory.write<uint8_t>(dst, I8_FALSE);
  }

  print_debug("%016" PRIx64 " : %d = %016" PRIx64 " >= %016" PRIx64 "\n", dst,
              memory.read<uint8_t>(dst),
              memory.read<vaddr_t>(a), memory.read<vaddr_t>(b));
}

// type_cast命令に対応したキャスト演算を行う。
void WrappedPointerOperator::type_cast(vaddr_t dst, vaddr_t type, vaddr_t src) {
  switch (type) {
    case BasicTypeAddress::UI8:
    case BasicTypeAddress::SI8:
      memory.write<uint8_t>(dst, static_cast<uint8_t>(memory.read<vaddr_t>(src)));
      break;

    case BasicTypeAddress::UI16:
    case BasicTypeAddress::SI16:
      memory.write<uint16_t>(dst, static_cast<uint16_t>(memory.read<vaddr_t>(src)));
      break;

    case BasicTypeAddress::UI32:
    case BasicTypeAddress::SI32:
      memory.write<uint32_t>(dst, static_cast<uint32_t>(memory.read<vaddr_t>(src)));
      break;

    case BasicTypeAddress::UI64:
    case BasicTypeAddress::SI64:
      memory.write<uint64_t>(dst, static_cast<uint64_t>(memory.read<vaddr_t>(src)));
      break;

    default:
      throw_error_message(Error::CAST_VIOLATION, Util::vaddr2str(type));
  }
  /*
    print_debug("type_cast:%" PRId64 " <- %016" PRIx64 "\n",
    memory.read<longest_int_t>(dst),
    memory.read<vaddr_t>(src));//*/
}

// Constructor with memory accessor.
WrappedComplexOperator::WrappedComplexOperator(VMemory::Accessor& memory) :
    WrappedOperator(memory) {
}

// 値をコピーする。
void WrappedComplexOperator::copy_value(vaddr_t dst, vaddr_t src) {
  memory.write_copy(dst, src, type_store->size);
}

// 明示的テンプレートのインスタンス化
template class WrappedPrimitiveOperator<int8_t>;
template class WrappedPrimitiveOperator<int16_t>;
template class WrappedPrimitiveOperator<int32_t>;
template class WrappedPrimitiveOperator<int64_t>;
template class WrappedPrimitiveOperator<uint8_t>;
template class WrappedPrimitiveOperator<uint16_t>;
template class WrappedPrimitiveOperator<uint32_t>;
template class WrappedPrimitiveOperator<uint64_t>;
template class WrappedPrimitiveOperator<float>;
template class WrappedPrimitiveOperator<double>;
}  // namespace processwarp
