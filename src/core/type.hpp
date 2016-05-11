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

#include "processwarp/processwarp.h"

namespace processwarp {
class Process;
class Thread;

namespace BuiltinPostProc {
typedef int Type;
}  // namespace BuiltinPostProc

namespace Module {
typedef int Type;
}  // namespace Module

/** Virtual address. */
typedef pw_ptr_t vaddr_t;

/** Type of virtual instruction. */
typedef uint32_t instruction_t;

/** Process-id in virtual-machine */
typedef std::string vpid_t;

/** Thread-id in virtual-machone. */
typedef vaddr_t vtid_t;

/** Node-id is assigned for each node process run in any devices. */
typedef std::string nid_t;

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
  nid_t nid;
  /** Node name. */
  std::string name;
  /** Last heartbeat time for node. */
  std::time_t heartbeat;
};

/**
 * Thread information to use in scheduler.
 */
struct ThreadInfo {
  vtid_t tid;
  nid_t nid;
  std::time_t heartbeat;
};

/**
 * Process information to use in scheduler.
 */
struct ProcessInfo {
  /** Porcess-id */
  vpid_t pid;
  /** Process name. */
  std::string name;
  /** Map of thread-id and node-id, last heartbeat time that thread is running. */
  std::map<vtid_t, ThreadInfo> threads;
  /** Node-id that havign gui frontend bundled process or NONE. */
  nid_t gui_nid;
  /** True if vm bundled process is exist in this node. */
  bool having_vm;
  /** Last heartbeat time for process. */
  std::time_t heartbeat;
};

/** Packet for transport command. */
struct CommandPacket {
  const vpid_t& pid;
  const nid_t& dst_nid;
  const nid_t& src_nid;
  const Module::Type module;  ///< Target (destination) module.
  const picojson::object& content;  ///< Content format is depend on each module and command.
};
}  // namespace processwarp
