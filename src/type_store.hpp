#pragma once

#include <vector>

#include "definitions.hpp"

namespace usagi {
  /**
   * 型情報クラス。
   */
  class TypeStore {
  public:
    /// 構造のサイズ(Byte)
    const size_t size;
    /// アライメント(Byte)
    const unsigned int alignment;
    /// 配列かどうか
    const bool is_array;
    /// 構造のメンバの配列
    const std::vector<vaddr_t> member;
    /// 配列の要素の型
    const vaddr_t element;
    /// 配列の要素数
    const unsigned int num;
  
    /**
     * コンストラクタ(構造)。
     * @param size_ 構造のサイズ(Byte)
     * @param alignment_ アライメント(Byte)
     * @param member_ 構造のメンバの配列
     */
    TypeStore(size_t size_,
	      unsigned int alignment_,
	      const std::vector<vaddr_t>& member_);

    /**
     * コンストラクタ(配列)。
     * @param size_ 配列のサイズ(Byte)
     * @param alignment_ アライメント(Byte)
     * @param element_ 配列の要素の型
     * @param num_ 配列の要素数
     */
    TypeStore(size_t size_,
	      unsigned int alignment_,
	      vaddr_t element_,
	      unsigned int num_);
  };
}
