#pragma once

#include <vector>
#include <memory>

#include "definitions.hpp"
#include "stackinfo.hpp"

namespace usagi {
  /**
   * スレッド
   */
  class Thread {
  public:
    /// 呼び出し階層
    typedef std::vector<std::unique_ptr<StackInfo>> StackInfos;

    /// 呼び出し階層
    StackInfos stackinfos;

    /// 複合型に対する演算命令
    TypeComplex type_complex;
  };
}
