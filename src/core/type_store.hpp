#pragma once

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
    /// 構造のメンバの配列
    const std::vector<vaddr_t> member;
  
    /**
     * コンストラクタ。
     * @param size_ 構造のサイズ(Byte)
     * @param alignment_ アライメント(Byte)
     * @param member_ 構造のメンバの配列
     */
    TypeStore(size_t size_,
	      unsigned int alignment_,
	      const std::vector<vaddr_t>& member_);
  };
}
