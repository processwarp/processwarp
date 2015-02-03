#pragma once

#include "definitions.hpp"

namespace usagi {
  class TypeStore;

  /**
   * 型によって動作が変わる命令の基底クラス
   */
  class TypeBased {
  public:
    /**
     * デストラクタ。
     * 基底クラスなため、virtual宣言を行うが何もしない。
     */
    virtual ~TypeBased();

    /**
     * bit_cast命令に対応したキャスト演算を行う。
     * @param dst 出力先
     * @param size 出力サイズ
     * @param src 入力元
     */
    virtual void bit_cast(uint8_t* dst, size_t size, uint8_t* src);

    /**
     * 値をコピーする。
     * @param dst コピー先
     * @param src コピー元
     */
    virtual void copy(uint8_t* dst, uint8_t* src);

    /**
     * 値を読み込む
     * @param src 読み込み元
     */
    virtual vm_int_t get(uint8_t* src);

    /**
     * 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    virtual bool is_or_nans(uint8_t* a, uint8_t* b);

    /**
     * add命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    virtual void op_add(uint8_t* dst, uint8_t* a, uint8_t* b);

    /**
     * and命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    virtual void op_and(uint8_t* dst, uint8_t* a, uint8_t* b);

    /**
     * div命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    virtual void op_div(uint8_t* dst, uint8_t* a, uint8_t* b);

    /**
     * 比較命令(a==b)に対応した演算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    virtual void op_equal(uint8_t* dst, uint8_t* a, uint8_t* b);

    /**
     * 比較命令(a>b)に対応した演算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    virtual void op_greater(uint8_t* dst, uint8_t* a, uint8_t* b);

    /**
     * 比較命令(a>=b)に対応した演算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    virtual void op_greater_equal(uint8_t* dst, uint8_t* a, uint8_t* b);

    /**
     * 比較命令(!isnan(a) && !isnan(b))に対応した演算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    virtual void op_not_nans(uint8_t* dst, uint8_t* a, uint8_t* b);

    /**
     * 比較命令(a!=b)に対応した演算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    virtual void op_not_equal(uint8_t* dst, uint8_t* a, uint8_t* b);

    /**
     * mul命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    virtual void op_mul(uint8_t* dst, uint8_t* a, uint8_t* b);

    /**
     * or命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    virtual void op_or(uint8_t* dst, uint8_t* a, uint8_t* b);

    /**
     * rem命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    virtual void op_rem(uint8_t* dst, uint8_t* a, uint8_t* b);

    /**
     * shl命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    virtual void op_shl(uint8_t* dst, uint8_t* a, uint8_t* b);

    /**
     * shr命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    virtual void op_shr(uint8_t* dst, uint8_t* a, uint8_t* b);

    /**
     * sub命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    virtual void op_sub(uint8_t* dst, uint8_t* a, uint8_t* b);

    /**
     * xor命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    virtual void op_xor(uint8_t* dst, uint8_t* a, uint8_t* b);

    /**
     * type_cast命令に対応したキャスト演算を行う。
     * @param dst 出力先
     * @param type 出力型
     * @param src 入力元
     */
    virtual void type_cast(uint8_t* dst, vaddr_t type, uint8_t* src);
  };

  /**
   * 整数型、浮動小数型に対する演算命令。
   */
  template <typename T> class TypeExtended : public TypeBased {
  public:
    /**
     * bit_cast命令に対応したキャスト演算を行う。
     * @param dst 出力先
     * @param size 出力サイズ
     * @param src 入力元
     */
    void bit_cast(uint8_t* dst, size_t size, uint8_t* src) override;

    /**
     * 値をコピーする。
     * @param dst コピー先
     * @param src コピー元
     */
    void copy(uint8_t* dst, uint8_t* src) override;

    /**
     * 値を読み込む
     * @param src 読み込み元
     */
    vm_int_t get(uint8_t* src) override;

    /**
     * 比較命令(isnan(a) || isnan(b))に対応した演算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    bool is_or_nans(uint8_t* a, uint8_t* b) override;

    /**
     * add命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    void op_add(uint8_t* dst, uint8_t* a, uint8_t* b) override;

    /**
     * and命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    void op_and(uint8_t* dst, uint8_t* a, uint8_t* b) override;

    /**
     * div命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    void op_div(uint8_t* dst, uint8_t* a, uint8_t* b) override;

    /**
     * 比較命令(a==b)に対応した演算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    void op_equal(uint8_t* dst, uint8_t* a, uint8_t* b) override;

    /**
     * 比較命令(a>b)に対応した演算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    void op_greater(uint8_t* dst, uint8_t* a, uint8_t* b) override;

    /**
     * 比較命令(a>=b)に対応した演算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    void op_greater_equal(uint8_t* dst, uint8_t* a, uint8_t* b) override;

    /**
     * 比較命令(!isnan(a) && !isnan(b))に対応した演算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    void op_not_nans(uint8_t* dst, uint8_t* a, uint8_t* b) override;

    /**
     * 比較命令(a!=b)に対応した演算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    void op_not_equal(uint8_t* dst, uint8_t* a, uint8_t* b) override;

    /**
     * mul命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    void op_mul(uint8_t* dst, uint8_t* a, uint8_t* b) override;

    /**
     * or命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    void op_or(uint8_t* dst, uint8_t* a, uint8_t* b) override;

    /**
     * rem命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    void op_rem(uint8_t* dst, uint8_t* a, uint8_t* b) override;

    /**
     * shl命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    void op_shl(uint8_t* dst, uint8_t* a, uint8_t* b) override;

    /**
     * shr命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    void op_shr(uint8_t* dst, uint8_t* a, uint8_t* b) override;

    /**
     * sub命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    void op_sub(uint8_t* dst, uint8_t* a, uint8_t* b) override;

    /**
     * xor命令に対応した加算を行う。
     * @param dst 出力先
     * @param a
     * @param b
     */
    void op_xor(uint8_t* dst, uint8_t* a, uint8_t* b) override;

    /**
     * type_cast命令に対応したキャスト演算を行う。
     * @param dst 出力先
     * @param type 出力型
     * @param src 入力元
     */
    void type_cast(uint8_t* dst, vaddr_t type, uint8_t* src) override;
  };

  /**
   * ポインタ型に対する演算命令。
   */
  class TypePointer : public TypeBased {
  public:
    /**
     * 値をコピーする。
     * @param dst コピー先
     * @param src コピー元
     */
    void copy(uint8_t* dst, uint8_t* src) override;
  };

  /**
   * 複合型に対する演算命令。
   */
  class TypeComplex : public TypeBased {
  public:
    /// 複合型の型情報
    TypeStore* type_store;

    /**
     * 値をコピーする。
     * @param dst コピー先
     * @param src コピー元
     */
    void copy(uint8_t* dst, uint8_t* src) override;
  };
}
