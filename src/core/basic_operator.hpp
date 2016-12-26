#pragma once

#include "types.hpp"

namespace processwarp {
/**
 * 型依存の演算クラス。
 */
class BasicOperator {
 public:
  /**
   * デストラクタ。
   * 基底クラスなため、virtual宣言を行うが何もしない。
   */
  virtual ~BasicOperator();

  /**
   * bit_cast命令に対応したキャスト演算を行う。
   * @param dst 出力先
   * @param size 出力サイズ
   * @param src 入力元
   */
  virtual void bit_cast(uint8_t* dst, size_t size, uint8_t* src) const;

  /**
   * 値をコピーする。
   * @param dst コピー先
   * @param src コピー元
   */
  virtual void copy_value(uint8_t* dst, uint8_t* src) const;

  /**
   * 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
   * @param a
   * @param b
   * @return
   */
  virtual bool is_or_nans(uint8_t* a, uint8_t* b) const;

  /**
   * add命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_add(uint8_t* dst, uint8_t* a, uint8_t* b) const;

  /**
   * and命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_and(uint8_t* dst, uint8_t* a, uint8_t* b) const;

  /**
   * div命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_div(uint8_t* dst, uint8_t* a, uint8_t* b) const;

  /**
   * 比較命令(a==b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_equal(uint8_t* dst, uint8_t* a, uint8_t* b) const;

  /**
   * 比較命令(a>b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_greater(uint8_t* dst, uint8_t* a, uint8_t* b) const;

  /**
   * 比較命令(a>=b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_greater_equal(uint8_t* dst, uint8_t* a, uint8_t* b) const;

  /**
   * 比較命令(!isnan(a) && !isnan(b))に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_not_nans(uint8_t* dst, uint8_t* a, uint8_t* b) const;

  /**
   * 比較命令(a!=b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_not_equal(uint8_t* dst, uint8_t* a, uint8_t* b) const;

  /**
   * mul命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_mul(uint8_t* dst, uint8_t* a, uint8_t* b) const;

  /**
   * or命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_or(uint8_t* dst, uint8_t* a, uint8_t* b) const;

  /**
   * rem命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_rem(uint8_t* dst, uint8_t* a, uint8_t* b) const;

  /**
   * shl命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_shl(uint8_t* dst, uint8_t* a, uint8_t* b) const;

  /**
   * shr命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_shr(uint8_t* dst, uint8_t* a, uint8_t* b) const;

  /**
   * sub命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_sub(uint8_t* dst, uint8_t* a, uint8_t* b) const;

  /**
   * xor命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  virtual void op_xor(uint8_t* dst, uint8_t* a, uint8_t* b) const;

  /**
   * type_cast命令に対応したキャスト演算を行う。
   * @param dst 出力先
   * @param type 出力型
   * @param src 入力元
   */
  virtual void type_cast(uint8_t* dst, vaddr_t type, uint8_t* src) const;
};

/**
 * 整数型、浮動小数型に対する演算命令。
 */
template <typename T> class PrimitiveOperator : public BasicOperator {
 public:
  /**
   * bit_cast命令に対応したキャスト演算を行う。
   * @param dst 出力先
   * @param size 出力サイズ
   * @param src 入力元
   */
  void bit_cast(uint8_t* dst, size_t size, uint8_t* src) const override;

  /**
   * 値をコピーする。
   * @param dst コピー先
   * @param src コピー元
   */
  void copy_value(uint8_t* dst, uint8_t* src) const override;

  /**
   * 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  bool is_or_nans(uint8_t* a, uint8_t* b) const override;

  /**
   * add命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_add(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * and命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_and(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * div命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_div(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * 比較命令(a==b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_equal(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * 比較命令(a>b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_greater(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * 比較命令(a>=b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_greater_equal(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * 比較命令(!isnan(a) && !isnan(b))に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_not_nans(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * 比較命令(a!=b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_not_equal(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * mul命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_mul(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * or命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_or(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * rem命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_rem(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * shl命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_shl(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * shr命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_shr(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * sub命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_sub(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * xor命令に対応した加算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_xor(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * type_cast命令に対応したキャスト演算を行う。
   * @param dst 出力先
   * @param type 出力型
   * @param src 入力元
   */
  void type_cast(uint8_t* dst, vaddr_t type, uint8_t* src) const override;
};

/**
 * ポインタ型に対する演算命令。
 */
class PointerOperator : public BasicOperator {
 public:
  /**
   * bit_cast命令に対応したキャスト演算を行う。
   * @param dst 出力先
   * @param size 出力サイズ
   * @param src 入力元
   */
  void bit_cast(uint8_t* dst, size_t size, uint8_t* src) const override;

  /**
   * 値をコピーする。
   * @param dst コピー先
   * @param src コピー元
   */
  void copy_value(uint8_t* dst, uint8_t* src) const override;

  /**
   * 比較命令(a==b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_equal(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * 比較命令(a>b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_greater(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * 比較命令(a>=b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_greater_equal(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * 比較命令(a!=b)に対応した演算を行う。
   * @param dst 出力先
   * @param a
   * @param b
   */
  void op_not_equal(uint8_t* dst, uint8_t* a, uint8_t* b) const override;

  /**
   * type_cast命令に対応したキャスト演算を行う。
   * @param dst 出力先
   * @param type 出力型
   * @param src 入力元
   */
  void type_cast(uint8_t* dst, vaddr_t type, uint8_t* src) const override;
};
}  // namespace processwarp
