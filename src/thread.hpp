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
    /** CallInfo */
    typedef std::vector<std::unique_ptr<StackInfo>> StackInfos;
    StackInfos stackinfos;
  };
}
