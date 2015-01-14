#pragma once

#include <vector>
#include <memory>

#include "callinfo.hpp"
#include "definitions.hpp"
#include "value.hpp"

namespace usagi {
  /**
   * スレッド
   */
  class Thread {
  public:
    /** スタックトップ */
    unsigned int top;

    /** CallInfo */
    typedef std::vector<std::unique_ptr<CallInfo>> CallInfos;
    CallInfos callinfos;

    /** スタック */
    typedef std::vector<Value> Stack;
    Stack stack;
  };
}
