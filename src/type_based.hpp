#pragma once

#include "definitions.hpp"

namespace usagi {
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
     * add命令に対応した加算を行う。
     * @param dst 出力先
     * @param a 
     * @param b
     */
    virtual void add(uint8_t* dst, uint8_t* a, uint8_t* b) = 0;

    /**
     * bit_cast命令に対応したキャスト演算を行う。
     * @param dst 出力先
     * @param size 出力サイズ
     * @param src 入力元
     */
    virtual void bit_cast(uint8_t* dst, size_t size, uint8_t* src) = 0;

    /**
     * 値をコピーする。
     * @param dst コピー先
     * @param src コピー元
     */
    virtual void copy(uint8_t* dst, uint8_t* src) = 0;

    /**
     * 値を読み込む
     * @param src 読み込み元
     */
    virtual vm_int_t get(uint8_t* src) = 0;

    /**
     * type_cast命令に対応したキャスト演算を行う。
     * @param dst 出力先
     * @param type 出力型
     * @param src 入力元
     */
    virtual void type_cast(uint8_t* dst, vaddr_t type, uint8_t* src) = 0;
  };

  /**
   * 整数型、浮動小数型に対する演算命令。
   */
  template <typename T> class TypeExtended : public TypeBased {
  public:
    /*
     * ADD命令に対応した加算を行う。
     * @param dst 出力先
     * @param a 
     * @param b
     */
    void add(uint8_t* dst, uint8_t* a, uint8_t* b) override;

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
    /*
     * ADD命令に対応した加算を行う。
     * llvmではポインタに対する直接加算は行わないのでエラーとなる
     * @param dst 出力先
     * @param a 
     * @param b
     */
    void add(uint8_t* dst, uint8_t* a, uint8_t* b) override;

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
     * type_cast命令に対応したキャスト演算を行う。
     * @param dst 出力先
     * @param type 出力型
     * @param src 入力元
     */
    void type_cast(uint8_t* dst, vaddr_t type, uint8_t* src) override;
  };
}
