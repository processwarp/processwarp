#pragma once

#include <picojson.h>

#ifndef __ANDROID__
#include <cinttypes>
#include <cstdint>
#else
namespace std {
#include <inttypes.h>
#include <stdint.h>
}  // namespace std
#endif  // ifndef __ANDROID__
#include <ctime>
#include <map>
#include <string>
#include <utility>
#include <vector>

#include "endless_order_id.hpp"
#include "processwarp/processwarp.h"
#include "node_id.hpp"

namespace processwarp {
class Process;
class Thread;

namespace BuiltinPostProc {
typedef int Type;
}  // namespace BuiltinPostProc

/** Virtual address. */
typedef pw_ptr_t vaddr_t;

/** Type of virtual instruction. */
typedef uint32_t instruction_t;

/** Process-id in virtual-machine */
typedef std::string vpid_t;

/** Thread-id in virtual-machone. */
typedef vaddr_t vtid_t;

/** Basic signed integer type in virtual-machine. */
typedef pw_int_t  vm_int_t;
/** Basic unsigned integer type in virtual-machine. */
typedef pw_uint_t vm_uint_t;

/** Longest signed integer type in system. */
typedef uint64_t longest_int_t;
/** Longest unsigned integer type in system. */
typedef uint64_t longest_uint_t;

/**
 * VM組み込み関数に渡すパラメタ。
 */
union BuiltinFuncParam {
  void* ptr;
  int64_t i64;
};

/**
 * Type definition of builtin function.
 * @param process 実行中のプロセス。
 * @param thread 実行中のスレッド。
 * @param p 固定パラメータ。
 * @param dst 戻り値格納先。
 * @param src 呼び出しパラメタ格納先。
 * @return スタック構造などを書き換え、execの再実行が必要な場合trueを戻す。
 */
typedef BuiltinPostProc::Type (*builtin_func_t)(Process& proc, Thread& thread, BuiltinFuncParam p,
                                                vaddr_t dst, std::vector<uint8_t>& src);

/**
 * Node information to use in scheduler.
 */
struct NodeInfo {
  /** Node-id. */
  NodeID nid;
  /** Node name. */
  std::string name;
  /** Last heartbeat time for node. */
  std::time_t heartbeat;
};

/**
 * Process information to use in scheduler.
 */
struct ProcessInfo {
  /** Process-id */
  vpid_t pid;
  /** Root thread-id. */
  vtid_t root_tid;
  /** Address of process information. */
  vaddr_t proc_addr;
  /** Leader-nid of proc_addr. */
  NodeID leader_nid;
  /** Process name. */
  std::string name;

  /** Map of thread-id and node-id */
  std::map<vtid_t, NodeID> threads;
  /** Node-id that havign gui frontend bundled process or NONE. */
  NodeID gui_nid;
  /** True if vm bundled process is exist in this node. */
  bool having_vm;
  /** Last heartbeat time for process. */
  std::time_t heartbeat;

  /** Update order. */
  EndlessOrderID order_id;
  /** Last update node-id. */
  NodeID last_update_nid;
};
}  // namespace processwarp
