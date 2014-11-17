#pragma once

#include <cassert>
#include <cstdint>

#include "definitions.hpp"
#include "util.hpp"

namespace usagi {
  /** 仮想メモリ空間管理クラスのプロトタイプ定義。 */
  class VMemory;

  /**
   * 値クラス。
   */
  class Value {
  public:
    /// 値クラスの分類
    enum Type {
      NORMAL_DATA,  ///< 通常の値
      POINTER_DATA, ///< ポインタ
      FUNCTION,     ///< 関数
      TYPE,         ///< 型
    };
    /// 値クラスの分類
    Type type;

    /**
     * Valueの内部の値を持つ。
     * 仮想アドレスまたは即値の共用体。
     */
    union {
      /// 仮想アドレス
      struct {
	vaddr_t upper;  ///< 上位仮想アドレス
	vaddr_t lower;  ///< 下位仮想アドレス(関数の場合0)
      } address;

      /// 即値
      struct {
	union {
	  uint64_t i64; ///< 64bit整数の即値
	  uint32_t i32; ///< 32bit整数の即値
	  uint16_t i16; ///< 16bit整数の即値
	  uint8_t  i8;  ///< 8bit整数の即値
	  double   f64; ///< 64bit浮動小数の即値
	  float    f32; ///< 32bit浮動小数の即値
	} value;        ///< 即値の共用体
	size_t size;    ///< 即値のサイズ(Byte)
      } immediate;
    } inner_value;

    /**
     * 値を取得するためのキャッシュポインタ。
     * 即値の場合、「cache == &inner_value.immediate.value」を満たす。
     */ 
    void* cache;

    /**
     * コンストラクタ。
     * 値を0クリアする。
     */
    Value();
    
    /**
     * 値アドレスを取得する。
     * @return 値アドレス。
     */
    inline vaddr_t get_address() const {
      assert(cache != &inner_value.immediate.value); // 即値でないこと
      return inner_value.address.upper | inner_value.address.lower;
    }

    /**
     * データの格納形式が即値かどうか調べる。
     * @return 即値の場合true。
     */
    inline bool is_immediate() const {
      return cache == &inner_value.immediate.value;
    }

    /**
     * 2つの値が同じアドレスを指しているかどうか判定する。
     * @param target 判定対象の値。
     * @return 同じRawStoreの同じ位置を指している＆ポインタ属性が同じ場合true。
     */
    bool is_same(const Value& target) const;

    /**
     * 値の比較を行う。
     * @param target 比較対象インスタンス。
     * @return thisがtargetより小さい場合負、値が同じ場合0、大きい場合正の値を戻す。
     */
    //virtual int compare(const Value& target) const;

    /**
     * 変数のコピーを作成する。
     * プリミティブ変数は新しいアドレスにコピーを作成する。オブジェクトはコピー不可。
     * @param vmemory 仮想メモリ空間。
     * @param dst 配置先アドレス。VADDR_NONを指定すると空いているを割り当てる。
     * @return クローン配置先仮想アドレス。
     */
    //virtual vaddr_t copy(VMemory& vmemory, vaddr_t dst = VADDR_NON) const;

    /**
     * 型の比較を行う。
     * 型の大小はdefinitions.hppの型順で行われる。
     * @param 比較対象インスタンス。
     * @return thisがtargetより小さい場合負、値が同じ場合0、大きい場合正の値を戻す。
     */
    //int type_compare(const Value& target) const;
  };
}
