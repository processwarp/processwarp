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
    /// Type of function list that will be called at befor or/and after warp.
    typedef std::vector<vaddr_t> FuncsAtWarp;
    /// Type of warp parameter.
    typedef std::map<vm_int_t, vm_int_t> WarpParameter;

    /// 呼び出し階層
    StackInfos stackinfos;
    /// Functions that will be called at befor warp.
    FuncsAtWarp funcs_at_befor_warp;
    /// Functions that will be called at after warp.
    FuncsAtWarp funcs_at_after_warp;
    /// Warp parameter
    WarpParameter warp_parameter;

    /// 複合型に対する演算命令
    TypeComplex type_complex;
  };
}
