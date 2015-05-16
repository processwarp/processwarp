#pragma once

#include <vector>

#include "definitions.hpp"

namespace processwarp {
  /**
   * 型情報クラス。
   */
  class TypeStore {
  public:
    /// アドレス
    const vaddr_t addr;
    /// 型の種類
    const TypeKind kind;
    /// 構造のサイズ(Byte)
    const size_t size;
    /// アライメント(Byte)
    const unsigned int alignment;
    /// 構造のメンバの配列
    const std::vector<vaddr_t> member;
    /// 配列/vectorの要素の型
    const vaddr_t element;
    /// 配列/vectorの要素数
    const unsigned int num;
  
    /**
     * コンストラクタ(基本型)。
     * @param addr_ 割り当てアドレス
     * @param size_ 構造のサイズ(Byte)
     * @param alignment_ アライメント(Byte)
     */
    TypeStore(vaddr_t addr_,
	      size_t size_,
	      unsigned int alignment_);

    /**
     * コンストラクタ(構造体)。
     * @param addr_ 割り当てアドレス
     * @param size_ 構造のサイズ(Byte)
     * @param alignment_ アライメント(Byte)
     * @param member_ 構造のメンバの配列
     */
    TypeStore(vaddr_t addr_,
	      size_t size_,
	      unsigned int alignment_,
	      const std::vector<vaddr_t>& member_);

    /**
     * コンストラクタ(配列/vector)。
     * @param addr_ 割り当てアドレス
     * @param kind_ 型の種類(配列/vectorのみ)
     * @param size_ サイズ(Byte)
     * @param alignment_ アライメント(Byte)
     * @param element_ 要素の型
     * @param num_ 要素数
     */
    TypeStore(vaddr_t addr_,
	      TypeKind kind_,
	      size_t size_,
	      unsigned int alignment_,
	      vaddr_t element_,
	      unsigned int num_);
  };
}
