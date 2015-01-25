
#include <cstdint>

#include "error.hpp"
#include "type_based.hpp"
#include "util.hpp"

using namespace usagi;

// デストラクタ。
TypeBased::~TypeBased() {
  // 基底クラスなため、virtual宣言を行うが何もしない。
}

// ADD命令に対応した加算を行う。
template <typename T> void TypeExtended<T>::add(uint8_t* dst, uint8_t* a, uint8_t* b) {
  *reinterpret_cast<T*>(dst) = *reinterpret_cast<T*>(a) + *reinterpret_cast<T*>(b);
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

// ADD命令に対応した加算を行う。
void TypePointer::add(uint8_t* dst, uint8_t* a, uint8_t* b) {
  throw_error(Error::SPEC_VIOLATION);
}

// bit_cast命令に対応したキャスト演算を行う。
void TypePointer::bit_cast(uint8_t* dst, size_t size, uint8_t* src) {
  throw_error(Error::SPEC_VIOLATION);
}

// 値をコピーする。
void TypePointer::copy(uint8_t* dst, uint8_t* src) {
  *reinterpret_cast<vaddr_t*>(dst) = *reinterpret_cast<vaddr_t*>(src);
}

// 値を読み込む
vm_int_t TypePointer::get(uint8_t* src) {
  throw_error(Error::SPEC_VIOLATION);
}

// type_cast命令に対応したキャスト演算を行う。
void TypePointer::type_cast(uint8_t* dst, vaddr_t type, uint8_t* src) {
  throw_error(Error::SPEC_VIOLATION);
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

