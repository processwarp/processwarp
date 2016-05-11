#pragma once

#include "type.hpp"
#include "type_store.hpp"
#include "vmemory.hpp"

namespace processwarp {
/**
 * 型依存の演算クラス。
 */
class WrappedOperator {
 public:
  VMemory::Accessor& memory;

  /**
   * Constructor with memory accessor.
   * @param memory Memory accessor.
   */
  explicit WrappedOperator(VMemory::Accessor& memory_);

  /**
   * デストラクタ。
   * 基底クラスなため、virtual宣言を行うが何もしない。
   */
  virtual ~WrappedOperator();

  /**
   * bit_cast命令に対応したキャスト演算を行う。
   * @param dst 出力先
   * @param size 出力サイズ
   * @param src 入力元
   */
  virtual void bit_cast(vaddr_t dst, size_t size, vaddr_t src);

  /**
   * 値をコピーする。
   * @param dst コピー先
   * @param src コピー元
   */
  virtual void copy_value(vaddr_t dst, vaddr_t src);

  /**
   * 値を読み込む
   * @param src 読み込み元
   */
  virtual longest_int_t get(vaddr_t src);

  /**
   * 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual bool is_or_nans(vaddr_t a, vaddr_t b);

  /**
   * add命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_add(vaddr_t dst, vaddr_t a, vaddr_t b);

  /**
   * and命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_and(vaddr_t dst, vaddr_t a, vaddr_t b);

  /**
   * div命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_div(vaddr_t dst, vaddr_t a, vaddr_t b);

  /**
   * 比較命令(a==b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_equal(vaddr_t dst, vaddr_t a, vaddr_t b);

  /**
   *
   */
  virtual bool is_equal(vaddr_t a, vaddr_t b);

  /**
   * 比較命令(a>b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_greater(vaddr_t dst, vaddr_t a, vaddr_t b);

  /**
   * 比較命令(a>=b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_greater_equal(vaddr_t dst, vaddr_t a, vaddr_t b);

  /**
   * 比較命令(!isnan(a) && !isnan(b))に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_not_nans(vaddr_t dst, vaddr_t a, vaddr_t b);

  /**
   * 比較命令(a!=b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_not_equal(vaddr_t dst, vaddr_t a, vaddr_t b);

  /**
   * mul命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_mul(vaddr_t dst, vaddr_t a, vaddr_t b);

  /**
   * or命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_or(vaddr_t dst, vaddr_t a, vaddr_t b);

  /**
   * rem命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_rem(vaddr_t dst, vaddr_t a, vaddr_t b);

  /**
   * shl命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_shl(vaddr_t dst, vaddr_t a, vaddr_t b);

  /**
   * shr命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_shr(vaddr_t dst, vaddr_t a, vaddr_t b);

  /**
   * sub命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_sub(vaddr_t dst, vaddr_t a, vaddr_t b);

  /**
   * xor命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_xor(vaddr_t dst, vaddr_t a, vaddr_t b);

  /**
   * type_cast命令に対応したキャスト演算を行う。
   * @param dst 出力先
   * @param type 出力型
   * @param src 入力元
   */
  virtual void type_cast(vaddr_t dst, vaddr_t type, vaddr_t src);
};

/**
 * 整数型、浮動小数型に対する演算命令。
 */
template <typename T> class WrappedPrimitiveOperator : public WrappedOperator {
 public:
  /**
   * Constructor with memory accessor.
   * @param memory Memory accessor.
   */
  explicit WrappedPrimitiveOperator(VMemory::Accessor& memory);

  /**
   * bit_cast命令に対応したキャスト演算を行う。
   * @param dst 出力先
   * @param size 出力サイズ
   * @param src 入力元
   */
  void bit_cast(vaddr_t dst, size_t size, vaddr_t src) override;

  /**
   * 値をコピーする。
   * @param dst コピー先
   * @param src コピー元
   */
  void copy_value(vaddr_t dst, vaddr_t src) override;

  /**
   * 値を読み込む
   * @param src 読み込み元
   */
  longest_int_t get(vaddr_t src) override;

  /**
   * 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  bool is_or_nans(vaddr_t a, vaddr_t b) override;

  /**
   * add命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_add(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   * and命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_and(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   * div命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_div(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   * 比較命令(a==b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_equal(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   *
   */
  bool is_equal(vaddr_t a, vaddr_t b) override;

  /**
   * 比較命令(a>b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_greater(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   * 比較命令(a>=b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_greater_equal(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   * 比較命令(!isnan(a) && !isnan(b))に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_not_nans(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   * 比較命令(a!=b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_not_equal(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   * mul命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_mul(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   * or命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_or(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   * rem命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_rem(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   * shl命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_shl(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   * shr命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_shr(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   * sub命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_sub(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   * xor命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_xor(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   * type_cast命令に対応したキャスト演算を行う。
   * @param dst 出力先
   * @param type 出力型
   * @param src 入力元
   */
  void type_cast(vaddr_t dst, vaddr_t type, vaddr_t src) override;
};

/**
 * ポインタ型に対する演算命令。
 */
class WrappedPointerOperator : public WrappedOperator {
 public:
  /**
   * Constructor with memory accessor.
   * @param memory Memory accessor.
   */
  explicit WrappedPointerOperator(VMemory::Accessor& memory);

  /**
   * bit_cast命令に対応したキャスト演算を行う。
   * @param dst 出力先
   * @param size 出力サイズ
   * @param src 入力元
   */
  void bit_cast(vaddr_t dst, size_t size, vaddr_t src) override;

  /**
   * 値をコピーする。
   * @param dst コピー先
   * @param src コピー元
   */
  void copy_value(vaddr_t dst, vaddr_t src) override;

  /**
   * 比較命令(a==b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_equal(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   *
   */
  bool is_equal(vaddr_t a, vaddr_t b) override;

  /**
   * 比較命令(a>b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_greater(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   * 比較命令(a>=b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_greater_equal(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   * 比較命令(a!=b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_not_equal(vaddr_t dst, vaddr_t a, vaddr_t b) override;

  /**
   * type_cast命令に対応したキャスト演算を行う。
   * @param dst 出力先
   * @param type 出力型
   * @param src 入力元
   */
  void type_cast(vaddr_t dst, vaddr_t type, vaddr_t src) override;
};

/**
 * 複合型に対する演算命令。
 */
class WrappedComplexOperator : public WrappedOperator {
 public:
  /// 複合型の型情報
  std::unique_ptr<TypeStore> type_store;

  /**
   * Constructor with memory accessor.
   * @param memory Memory accessor.
   */
  explicit WrappedComplexOperator(VMemory::Accessor& memory);

  /**
   * 値をコピーする。
   * @param dst コピー先
   * @param src コピー元
   */
  void copy_value(vaddr_t dst, vaddr_t src) override;
};
}  // namespace processwarp
