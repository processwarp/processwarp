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
    enum Type : uint8_t {
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
    mutable void* cache;

    /**
     * コンストラクタ。
     * 値を0クリアする。
     */
    Value();

    /**
     * コピーコンストラクタ。
     * 即値の場合、cacheを作りなおす。
     */
    Value(const Value& src);

    /**
     * =演算子。
     * 即値の場合、cacheを作り直す。
     */
    Value& operator=(const Value& src);
    
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
     * 値のアドレスを設定する。
     * @param addr 値のアドレス。
     */
    void set_address(vaddr_t addr);
  };
}
