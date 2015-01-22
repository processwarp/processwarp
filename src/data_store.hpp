#pragma once

#include <cstdint>
#include <memory>

#include "definitions.hpp"

namespace usagi {
  /**
   * 仮想メモリ空間で生データを格納するクラス。
   */
  class DataStore {
  public:
    /// アドレス
    const vaddr_t addr;
    /// 領域サイズ
    const size_t size;
    /// 領域の先頭アドレス
    std::unique_ptr<uint8_t[]> head;

    /**
     * コンストラクタ。
     * @param addr_ 割り当てアドレス
     * @param size_ 領域サイズ
     */
    DataStore(vaddr_t addr_,
	      size_t size_);
  };
}
