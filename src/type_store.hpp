#pragma once

#include <memory>
#include <vector>

#include "definitions.hpp"
#include "vmemory.hpp"

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
     * @param memory 
     * @param size 構造のサイズ(Byte)
     * @param alignment アライメント(Byte)
     * @param addr
     */
    static std::unique_ptr<TypeStore> alloc_basic(VMemory::Accessor& memory,
						  unsigned int size,
						  unsigned int alignment,
						  vaddr_t addr);

    /**
     * コンストラクタ(構造体)。
     * @param memory 
     * @param size 構造のサイズ(Byte)
     * @param alignment アライメント(Byte)
     * @param member 構造のメンバの配列
     */
    static std::unique_ptr<TypeStore> alloc_struct(VMemory::Accessor& memory,
						   const std::vector<vaddr_t>& member);
    /**
     * コンストラクタ(配列/vector)。
     * @param memory 
     * @param kind 型の種類(配列/vectorのみ)
     * @param size サイズ(Byte)
     * @param alignment アライメント(Byte)
     * @param element 要素の型
     * @param num 要素数
     */
    static std::unique_ptr<TypeStore> alloc_array(VMemory::Accessor& memory,
						  vaddr_t element,
						  unsigned int num);

    static std::unique_ptr<TypeStore> alloc_vector(VMemory::Accessor& memory,
						   vaddr_t element,
						   unsigned int num);

    /**
     * 型のサイズと最大アライメントを計算する。
     * @param member 複合型のメンバ
     * @return <型のサイズ, 最大アライメント>
     */
    static std::pair<size_t, unsigned int> calc_type_size(VMemory::Accessor& memory,
							  const std::vector<vaddr_t>& member);

    /**
     * 型のサイズと最大アライメントを計算する。
     * @param type 型
     * @return <型のサイズ, 最大アライメント>
     */
    static std::pair<size_t, unsigned int> calc_type_size(VMemory::Accessor& memory,
							  vaddr_t type);

    /**
     *
     */
    static std::unique_ptr<TypeStore> read(VMemory::Accessor& memory, vaddr_t addr);
  };
}
