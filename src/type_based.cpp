
#include <cstdint>

#include "error.hpp"
#include "type_based.hpp"
#include "util.hpp"

using namespace usagi;

// デストラクタ。
TypeBased::~TypeBased() {
  // 基底クラスなため、virtual宣言を行うが何もしない。
}

// bit_cast命令に対応したキャスト演算を行う。
void TypeBased::bit_cast(uint8_t* dst, size_t size, uint8_t* src) {
  throw_error(Error::INST_VIOLATION);
}

// 値をコピーする。
void TypeBased::copy(uint8_t* dst, uint8_t* src) {
  throw_error(Error::INST_VIOLATION);
}

// 値を読み込む
vm_int_t TypeBased::get(uint8_t* src) {
  throw_error(Error::INST_VIOLATION);
}

/**
 * TypeBaseクラスの2項演算子はすべてVOILATIONとする。
 * @param op メソッド名
 */
#define M_BINARY_OPERATOR_VIOLATION(op)				\
  void TypeBased::op(uint8_t* dst, uint8_t* a, uint8_t* b) {	\
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

#undef M_BINARY_OPERATOR_VIOLATION

// type_cast命令に対応したキャスト演算を行う。
void TypeBased::type_cast(uint8_t* dst, vaddr_t type, uint8_t* src) {
  throw_error(Error::INST_VIOLATION);
}

// bit_cast命令に対応したキャスト演算を行う。
template <typename T> void TypeExtended<T>::bit_cast(uint8_t* dst, size_t size, uint8_t* src) {
  longest_uint_t buffer = 0;
  memcpy(&buffer, src, sizeof(T));
  memcpy(dst, &buffer, size);
}

// 値をコピーする。
template <typename T> void TypeExtended<T>::copy(uint8_t* dst, uint8_t* src) {
  *reinterpret_cast<T*>(dst) = *reinterpret_cast<T*>(src);
}

// 値を読み込む
template <typename T> vm_int_t TypeExtended<T>::get(uint8_t* src) {
  return static_cast<vm_int_t>(*reinterpret_cast<T*>(src));
}

/**
 * 二項演算に対応したメソッドを生成する
 * @param op メソッド名
 * @param infix 演算中置子
 */
#define M_BINARY_OPERATOR_TYPE_EXTENDED(op, infix)			\
  template <typename T> void TypeExtended<T>::op(uint8_t* dst, uint8_t* a, uint8_t* b) { \
    *reinterpret_cast<T*>(dst) = *reinterpret_cast<T*>(a) infix *reinterpret_cast<T*>(b); \
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
 * 浮動小数点演算でサポートしない2項演算子用のメソッドを生成する
 * @param op メソッド名
 * @param type 型
 */
#define M_BINARY_OPERATOR_UNSUPPORT(op, type)				\
  template<> void TypeExtended<type>::op(uint8_t* dst, uint8_t* a, uint8_t* b) { \
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

#undef M_BINARY_OPERATOR_UNSUPPORT

// shl命令に対応した加算を行う。
template <typename T> void TypeExtended<T>::op_shl(uint8_t* dst, uint8_t* a, uint8_t* b) {
  *reinterpret_cast<T*>(dst) =
    *reinterpret_cast<T*>(a) << static_cast<unsigned>(*reinterpret_cast<T*>(b));
}

// shr命令に対応した加算を行う。
template <typename T> void TypeExtended<T>::op_shr(uint8_t* dst, uint8_t* a, uint8_t* b) {
  *reinterpret_cast<T*>(dst) =
    *reinterpret_cast<T*>(a) >> static_cast<unsigned>(*reinterpret_cast<T*>(b));
}

// type_cast命令に対応したキャスト演算を行う。
template <typename T> void TypeExtended<T>::type_cast(uint8_t* dst, vaddr_t type, uint8_t* src) {
  switch(type) {
  case BasicType::TY_UI8:  *reinterpret_cast<uint8_t*>(dst) =
      static_cast<uint8_t>(*reinterpret_cast<T*>(src)); break;
    
  case BasicType::TY_UI16: *reinterpret_cast<uint16_t*>(dst) =
      static_cast<uint16_t>(*reinterpret_cast<T*>(src)); break;
    
  case BasicType::TY_UI32: *reinterpret_cast<uint32_t*>(dst) =
      static_cast<uint32_t>(*reinterpret_cast<T*>(src)); break;
    
  case BasicType::TY_UI64: *reinterpret_cast<uint64_t*>(dst) =
      static_cast<uint64_t>(*reinterpret_cast<T*>(src)); break;
    
  case BasicType::TY_SI8:  *reinterpret_cast<int8_t*>(dst) =
      static_cast<int8_t>(*reinterpret_cast<T*>(src)); break;
    
  case BasicType::TY_SI16: *reinterpret_cast<int16_t*>(dst) =
      static_cast<int16_t>(*reinterpret_cast<T*>(src)); break;
    
  case BasicType::TY_SI32: *reinterpret_cast<int32_t*>(dst) =
      static_cast<int32_t>(*reinterpret_cast<T*>(src)); break;
    
  case BasicType::TY_SI64: *reinterpret_cast<int64_t*>(dst) =
      static_cast<int64_t>(*reinterpret_cast<T*>(src)); break;
    
  case BasicType::TY_F32: *reinterpret_cast<float*>(dst) =
      static_cast<float>(*reinterpret_cast<T*>(src)); break;
    
  case BasicType::TY_F64: *reinterpret_cast<double*>(dst) =
      static_cast<double>(*reinterpret_cast<T*>(src)); break;

  default: {
    throw_error_message(Error::CAST_VIOLATION, Util::vaddr2str(type));
  } break;
  }
}

// 値をコピーする。
void TypePointer::copy(uint8_t* dst, uint8_t* src) {
  *reinterpret_cast<vaddr_t*>(dst) = *reinterpret_cast<vaddr_t*>(src);
}

// 明示的テンプレートのインスタンス化
template class usagi::TypeExtended<int8_t>;
template class usagi::TypeExtended<int16_t>;
template class usagi::TypeExtended<int32_t>;
template class usagi::TypeExtended<int64_t>;
template class usagi::TypeExtended<uint8_t>;
template class usagi::TypeExtended<uint16_t>;
template class usagi::TypeExtended<uint32_t>;
template class usagi::TypeExtended<uint64_t>;
template class usagi::TypeExtended<float>;
template class usagi::TypeExtended<double>;

