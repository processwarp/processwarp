#pragma once

#include <cstdint>
#include <memory>

namespace usagi {
  /**
   * 仮想メモリ空間で生データを格納するクラス。
   */
  class DataStore {
  public:
    /// 領域サイズ
    const size_t size;
    /// 領域の先頭アドレス
    std::unique_ptr<uint8_t[]> head;

    /**
     * コンストラクタ。
     * @param size_ 領域サイズ
     */
    DataStore(size_t size_);
  };
}
