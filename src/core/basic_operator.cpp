
#include <cassert>
#include <cmath>
#include <cstdint>
#include <cstring>

#include "basic_operator.hpp"
#include "core_mid.hpp"
#include "error.hpp"
#include "logger.hpp"
#include "type_store.hpp"
#include "util.hpp"

namespace processwarp {

// デストラクタ。
BasicOperator::~BasicOperator() {
  // 基底クラスなため、virtual宣言を行うが何もしない。
}

// bit_cast命令に対応したキャスト演算を行う。
void BasicOperator::bit_cast(uint8_t* dst, size_t size, uint8_t* src) const {
  throw_error(Error::INST_VIOLATION);
}

// 値をコピーする。
void BasicOperator::copy_value(uint8_t* dst, uint8_t* src) const {
  throw_error(Error::INST_VIOLATION);
}

// 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
bool BasicOperator::is_or_nans(uint8_t* a, uint8_t* b) const {
  throw_error(Error::INST_VIOLATION);
}

/**
 * TypeBaseクラスの2項演算子はすべてVOILATIONとする。
 * @param op メソッド名
 */
#define M_BINARY_OPERATOR_VIOLATION(op)                                 \
  void BasicOperator::op(uint8_t* dst, uint8_t* a, uint8_t* b) const {  \
    throw_error(Error::INST_VIOLATION);                                 \
  }

M_BINARY_OPERATOR_VIOLATION(op_add);  // 加算
M_BINARY_OPERATOR_VIOLATION(op_and);  // and
M_BINARY_OPERATOR_VIOLATION(op_div);  // 除算
M_BINARY_OPERATOR_VIOLATION(op_mul);  // 乗算
M_BINARY_OPERATOR_VIOLATION(op_or);   // or
M_BINARY_OPERATOR_VIOLATION(op_rem);  // 剰余
M_BINARY_OPERATOR_VIOLATION(op_shl);  // 左シフト
M_BINARY_OPERATOR_VIOLATION(op_shr);  // 右シフト
M_BINARY_OPERATOR_VIOLATION(op_sub);  // 減算
M_BINARY_OPERATOR_VIOLATION(op_xor);  // xor

// 比較演算もすべてVIOLATIONにしておく
M_BINARY_OPERATOR_VIOLATION(op_equal);                // a==b
M_BINARY_OPERATOR_VIOLATION(op_greater);              // a>b
M_BINARY_OPERATOR_VIOLATION(op_greater_equal);        // a>=b
M_BINARY_OPERATOR_VIOLATION(op_not_nans);             // !isnan(a) && !isnan(b)
M_BINARY_OPERATOR_VIOLATION(op_not_equal);            // a!=b

#undef M_BINARY_OPERATOR_VIOLATION

// type_cast命令に対応したキャスト演算を行う。
void BasicOperator::type_cast(uint8_t* dst, vaddr_t type, uint8_t* src) const {
  print_llvm_instruction();
  throw_error(Error::INST_VIOLATION);
}

// bit_cast命令に対応したキャスト演算を行う。
template <typename T>
void PrimitiveOperator<T>::bit_cast(uint8_t* dst, size_t size, uint8_t* src) const {
  longest_uint_t buffer = 0;
  std::memcpy(&buffer, src, sizeof(T));
  std::memcpy(dst, &buffer, size);
  Logger::dbg_vm(CoreMid::L1001, "bitcast %s (%p <- %p)",
                 Util::numptr2str(&buffer, size).c_str(), dst, src);
}

// 値をコピーする。
template <typename T>
void PrimitiveOperator<T>::copy_value(uint8_t* dst, uint8_t* src) const {
  *reinterpret_cast<T*>(dst) = *reinterpret_cast<T*>(src);
  Logger::dbg_vm(CoreMid::L1001, "copy_value %s (%p <- %p)",
                 Util::numptr2str(dst, sizeof(T)).c_str(), dst, src);
}

// 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
template <typename T>
bool PrimitiveOperator<T>::is_or_nans(uint8_t* a, uint8_t* b) const {
  // 整数演算ではサポートしない機能
  throw_error(Error::INST_VIOLATION);
}

// 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
template<>
bool PrimitiveOperator<double>::is_or_nans(uint8_t* a, uint8_t* b) const {
  if (std::isnan(*reinterpret_cast<double*>(a)) ||
      std::isnan(*reinterpret_cast<double*>(b))) {
    return true;
  } else {
    return false;
  }
}

// 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
template<>
bool PrimitiveOperator<float>::is_or_nans(uint8_t* a, uint8_t* b) const {
  if (std::isnan(*reinterpret_cast<float*>(a)) ||
      std::isnan(*reinterpret_cast<float*>(b))) {
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
  void PrimitiveOperator<T>::op(uint8_t* dst, uint8_t* a, uint8_t* b) const { \
    *reinterpret_cast<T*>(dst) = *reinterpret_cast<T*>(a) infix *reinterpret_cast<T*>(b); \
    Logger::dbg_vm(CoreMid::L1001, "%p : %s = %s %s %s",              \
                   dst, Util::numptr2str(dst, sizeof(T)).c_str(),       \
                   Util::numptr2str(a, sizeof(T)).c_str(), #infix,      \
                   Util::numptr2str(b, sizeof(T)).c_str());             \
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
  void PrimitiveOperator<T>::op(uint8_t* dst, uint8_t* a, uint8_t* b) const { \
    *reinterpret_cast<uint8_t*>(dst) = (*reinterpret_cast<T*>(a) infix *reinterpret_cast<T*>(b)) ? \
      0x01 : 0x00;                                                      \
    Logger::dbg_vm(CoreMid::L1001, "%p : %s = %s %s %s", dst,         \
                   Util::numptr2str(dst, 1).c_str(),                    \
                   Util::numptr2str(a, sizeof(T)).c_str(), #infix,      \
                   Util::numptr2str(b, sizeof(T)).c_str());             \
                   }

M_COMP_OPERATOR_TYPE_EXTENDED(op_equal,         ==);    // a==b
M_COMP_OPERATOR_TYPE_EXTENDED(op_greater,       >);     // a>b
M_COMP_OPERATOR_TYPE_EXTENDED(op_greater_equal, >=);    // a>=b
M_COMP_OPERATOR_TYPE_EXTENDED(op_not_equal,     !=);    // a!=b

#undef M_COMP_OPERATOR_TYPE_EXTENDED

/**
 * サポートしない2項演算子用のメソッドを生成する
 * @param op メソッド名
 * @param type 型
 */
#define M_BINARY_OPERATOR_UNSUPPORT(op, type)                           \
  template<>                                                            \
  void PrimitiveOperator<type>::op(uint8_t* dst, uint8_t* a, uint8_t* b) const { \
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
void PrimitiveOperator<double>::op_not_nans(uint8_t* dst, uint8_t* a, uint8_t* b) const {
  if (!std::isnan(*reinterpret_cast<double*>(a)) &&
      !std::isnan(*reinterpret_cast<double*>(b))) {
    *dst = I8_TRUE;
  } else {
    *dst = I8_FALSE;
  }
  Logger::dbg_vm(CoreMid::L1001, "not_nans %p : %s = %s not_nans %s", dst,
                 Util::numptr2str(dst, 1).c_str(),
                 Util::numptr2str(a, sizeof(double)).c_str(),
                 Util::numptr2str(b, sizeof(double)).c_str());
}

// 比較命令(!isnan(a) && !isnan(b))に対応した演算を行う。
template<>
void PrimitiveOperator<float>::op_not_nans(uint8_t* dst, uint8_t* a, uint8_t* b) const {
  if (!std::isnan(*reinterpret_cast<float*>(a)) &&
      !std::isnan(*reinterpret_cast<float*>(b))) {
    *dst = I8_TRUE;
  } else {
    *dst = I8_FALSE;
  }
  Logger::dbg_vm(CoreMid::L1001, "not_nans %p : %s = %s not_nans %s", dst,
                 Util::numptr2str(dst, 1).c_str(),
                 Util::numptr2str(a, sizeof(float)).c_str(),
                 Util::numptr2str(b, sizeof(float)).c_str());
}

// shl命令に対応した加算を行う。
template <typename T>
void PrimitiveOperator<T>::op_shl(uint8_t* dst, uint8_t* a, uint8_t* b) const {
  *reinterpret_cast<T*>(dst) = *reinterpret_cast<T*>(a) <<
    static_cast<unsigned>(*reinterpret_cast<T*>(b));
  Logger::dbg_vm(CoreMid::L1001, "shl %p : %s = %s << %s", dst,
                 Util::numptr2str(dst, sizeof(T)).c_str(),
                 Util::numptr2str(a, sizeof(T)).c_str(),
                 Util::numptr2str(b, sizeof(T)).c_str());
}

// shr命令に対応した加算を行う。
template <typename T>
void PrimitiveOperator<T>::op_shr(uint8_t* dst, uint8_t* a, uint8_t* b) const {
  *reinterpret_cast<T*>(dst) =
    *reinterpret_cast<T*>(a) >> static_cast<unsigned>(*reinterpret_cast<T*>(b));
  Logger::dbg_vm(CoreMid::L1001, "shr %p : %s = %s << %s", dst,
                 Util::numptr2str(dst, sizeof(T)).c_str(),
                 Util::numptr2str(a, sizeof(T)).c_str(),
                 Util::numptr2str(b, sizeof(T)).c_str());
}

// type_cast命令に対応したキャスト演算を行う。
template <typename T>
void PrimitiveOperator<T>::type_cast(uint8_t* dst, vaddr_t type, uint8_t* src)  const {
  switch (type) {
    case BasicTypeAddress::POINTER:
      *reinterpret_cast<vaddr_t*>(dst) = static_cast<unsigned>(*reinterpret_cast<T*>(src));
      break;

#define M_CASE_TYPE_CAST(VM_TYPE, REAL_TYPE)                            \
      case (VM_TYPE):                                                   \
        *reinterpret_cast<REAL_TYPE*>(dst) = static_cast<REAL_TYPE>(*reinterpret_cast<T*>(src)); \
        break;

      M_CASE_TYPE_CAST(BasicTypeAddress::UI8,  uint8_t);
      M_CASE_TYPE_CAST(BasicTypeAddress::UI16, uint16_t);
      M_CASE_TYPE_CAST(BasicTypeAddress::UI32, uint32_t);
      M_CASE_TYPE_CAST(BasicTypeAddress::UI64, uint64_t);
      M_CASE_TYPE_CAST(BasicTypeAddress::SI8,  int8_t);
      M_CASE_TYPE_CAST(BasicTypeAddress::SI16, int16_t);
      M_CASE_TYPE_CAST(BasicTypeAddress::SI32, int32_t);
      M_CASE_TYPE_CAST(BasicTypeAddress::SI64, int64_t);
      M_CASE_TYPE_CAST(BasicTypeAddress::F32,  float);
      M_CASE_TYPE_CAST(BasicTypeAddress::F64,  double);
#undef M_CASE_TYPE_CAST

    default: {
      throw_error_message(Error::CAST_VIOLATION, Util::vaddr2str(type));
    } break;
  }

  Logger::dbg_vm(CoreMid::L1001, "type_cast:%s <- %s",
                 Util::numptr2str(dst, 8).c_str(),
                 Util::numptr2str(src, sizeof(T)).c_str());
}

// bit_cast命令に対応したキャスト演算を行う。
void PointerOperator::bit_cast(uint8_t* dst, size_t size, uint8_t* src) const {
  // コピーサイズはvaddr_tのサイズと同じはず
  assert(size == sizeof(vaddr_t));
  *reinterpret_cast<vaddr_t*>(dst) = *reinterpret_cast<vaddr_t*>(src);
  Logger::dbg_vm(CoreMid::L1001, "bitcast %s (%p <- %p)",
                 Util::numptr2str(dst, size).c_str(), dst, src);
}

// 値をコピーする。
void PointerOperator::copy_value(uint8_t* dst, uint8_t* src) const {
  *reinterpret_cast<vaddr_t*>(dst) = *reinterpret_cast<vaddr_t*>(src);
  Logger::dbg_vm(CoreMid::L1001, "copy_value %s (%p <- %p)",
                 Util::numptr2str(dst, sizeof(vaddr_t)).c_str(), dst, src);
}

// 比較命令(a==b)に対応した演算を行う。
void PointerOperator::op_equal(uint8_t* dst, uint8_t* a, uint8_t* b) const {
  if (*reinterpret_cast<vaddr_t*>(a) == *reinterpret_cast<vaddr_t*>(b)) {
    *reinterpret_cast<uint8_t*>(dst) = I8_TRUE;
  } else {
    *reinterpret_cast<uint8_t*>(dst) = I8_FALSE;
  }
  Logger::dbg_vm(CoreMid::L1001, "%p : %s = %s == %s", dst,
                 Util::numptr2str(dst, 1).c_str(),
                 Util::numptr2str(a, sizeof(vaddr_t)).c_str(),
                 Util::numptr2str(b, sizeof(vaddr_t)).c_str());
}

// 比較命令(a>b)に対応した演算を行う。
void PointerOperator::op_greater(uint8_t* dst, uint8_t* a, uint8_t* b) const {
  if (*reinterpret_cast<vaddr_t*>(a) > *reinterpret_cast<vaddr_t*>(b)) {
    *reinterpret_cast<uint8_t*>(dst) = I8_TRUE;
  } else {
    *reinterpret_cast<uint8_t*>(dst) = I8_FALSE;
  }
  Logger::dbg_vm(CoreMid::L1001, "%p : %s = %s > %s", dst,
                 Util::numptr2str(dst, 1).c_str(),
                 Util::numptr2str(a, sizeof(vaddr_t)).c_str(),
                 Util::numptr2str(b, sizeof(vaddr_t)).c_str());
}

// 比較命令(a>=b)に対応した演算を行う。
void PointerOperator::op_greater_equal(uint8_t* dst, uint8_t* a, uint8_t* b) const {
  if (*reinterpret_cast<vaddr_t*>(a) >= *reinterpret_cast<vaddr_t*>(b)) {
    *reinterpret_cast<uint8_t*>(dst) = I8_TRUE;
  } else {
    *reinterpret_cast<uint8_t*>(dst) = I8_FALSE;
  }
  Logger::dbg_vm(CoreMid::L1001, "%p : %s = %s >= %s", dst,
                 Util::numptr2str(dst, 1).c_str(),
                 Util::numptr2str(a, sizeof(vaddr_t)).c_str(),
                 Util::numptr2str(b, sizeof(vaddr_t)).c_str());
}

// 比較命令(a!=b)に対応した演算を行う。
void PointerOperator::op_not_equal(uint8_t* dst, uint8_t* a, uint8_t* b) const {
  if (*reinterpret_cast<vaddr_t*>(a) == *reinterpret_cast<vaddr_t*>(b)) {
    *reinterpret_cast<uint8_t*>(dst) = I8_FALSE;
  } else {
    *reinterpret_cast<uint8_t*>(dst) = I8_TRUE;
  }
  Logger::dbg_vm(CoreMid::L1001, "%p : %s = %s != %s", dst,
                 Util::numptr2str(dst, 1).c_str(),
                 Util::numptr2str(a, sizeof(vaddr_t)).c_str(),
                 Util::numptr2str(b, sizeof(vaddr_t)).c_str());
}

// type_cast命令に対応したキャスト演算を行う。
void PointerOperator::type_cast(uint8_t* dst, vaddr_t type, uint8_t* src) const {
  switch (type) {
    case BasicTypeAddress::UI8:
    case BasicTypeAddress::SI8:
      *reinterpret_cast<uint8_t*>(dst) =
        static_cast<uint8_t>(*reinterpret_cast<vaddr_t*>(src));
      break;

    case BasicTypeAddress::UI16:
    case BasicTypeAddress::SI16:
      *reinterpret_cast<uint16_t*>(dst) =
        static_cast<uint16_t>(*reinterpret_cast<vaddr_t*>(src));
      break;

    case BasicTypeAddress::UI32:
    case BasicTypeAddress::SI32:
      *reinterpret_cast<uint32_t*>(dst) =
        static_cast<uint32_t>(*reinterpret_cast<vaddr_t*>(src));
      break;

    case BasicTypeAddress::UI64:
    case BasicTypeAddress::SI64:
      *reinterpret_cast<uint64_t*>(dst) =
        static_cast<uint64_t>(*reinterpret_cast<vaddr_t*>(src));
      break;

    default:
      throw_error_message(Error::CAST_VIOLATION, Util::vaddr2str(type));
  }

  Logger::dbg_vm(CoreMid::L1001, "type_cast:%s <- %s",
                 Util::numptr2str(dst, 8).c_str(),
                 Util::numptr2str(src, sizeof(vaddr_t)).c_str());
}

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
}  // namespace processwarp
