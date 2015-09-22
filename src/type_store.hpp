#pragma once

#include <memory>
#include <utility>
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
   * Allocate a new basic type to memory.
   * @param memory 
   * @param size Size of target type (Byte).
   * @param alignment Alignment for target type (Byte).
   * @param addr A assign address for target type.
   */
  static vaddr_t alloc_basic(VMemory::Accessor& memory,
                             unsigned int size,
                             unsigned int alignment,
                             vaddr_t addr);

  /**
   * Allocate a new strut type to memory.
   * @param memory 
   * @param member A member array of target type.
   */
  static vaddr_t alloc_struct(VMemory::Accessor& memory,
                              const std::vector<vaddr_t>& member);
  /**
   * Allocate a new array type to memory.
   * @param memory 
   * @param element Element type of array type.
   * @param num Element number of array type.
   */
  static vaddr_t alloc_array(VMemory::Accessor& memory,
                             vaddr_t element,
                             unsigned int num);

  /**
   * Allocate a new vector type to memory.
   * @param memory 
   * @param element Element type of vector type.
   * @param num Element number of vector type.
   */
  static vaddr_t alloc_vector(VMemory::Accessor& memory,
                              vaddr_t element,
                              unsigned int num);

  /**
   * Calcuate a size and alignment for structure.
   * @param member A member array of target structure type.
   * @return <Size of structure, Alignment of structure>
   */
  static std::pair<size_t, unsigned int> calc_type_size(VMemory::Accessor& memory,
                                                        const std::vector<vaddr_t>& member);

  /**
   * Calucuate a size and alignment for some type.
   * @param type A type.
   * @return <Size of type, Alignment of type>
   */
  static std::pair<size_t, unsigned int> calc_type_size(VMemory::Accessor& memory,
                                                        vaddr_t type);

  /**
   * Read out type information from memory.
   * @param memory
   * @param addr Address saving type information.
   * @param Type information.
   */
  static std::unique_ptr<TypeStore> read(VMemory::Accessor& memory, vaddr_t addr);

 private:
  /**
   *
   */
  TypeStore(vaddr_t addr,
            TypeKind kind,
            size_t size,
            unsigned int alignment,
            const std::vector<vaddr_t>& member,
            vaddr_t element,
            unsigned int num);
};
}  // namespace processwarp
