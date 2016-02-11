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

/** 通信プロトコルのメジャーバージョン */
static const int PROTOCOL_MAJOR_VERSION = 0;
/** 通信プロトコルのマイナーバージョン */
static const int PROTOCOL_MINOR_VERSION = 1;

static const int NODE_NAME_MAX = 128;

/** 仮想アドレス */
typedef pw_ptr_t vaddr_t;

static const unsigned int VMEMORY_RESERVE_MIN  = 8;
static const unsigned int VMEMORY_RESERVE_BASE = 16;
static const unsigned int VMEMORY_RESERVE_MAX  = 64;

/**
 * VM組み込み関数に渡すパラメタ。
 */
union BuiltinFuncParam {
  void* ptr;
  int64_t i64;
};

/**
 * Post process type of builtin function.
 */
namespace BuiltinPostProc {
enum Type {
  NORMAL,       ///< Normally run next instruction.
  RE_ENTRY,     ///< Re-entry by stack deciding.
  RETRY_LATER,  ///< Retry the same instruction later other thread.
};
}  // namespace BuiltinPostProc

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

/** システム中で扱う最長のuint */
typedef uint64_t longest_uint_t;

/** システム中で扱う最長のint */
typedef uint64_t longest_int_t;

/** 最長のuintを1うめしたもの */
// static longest_uint_t LONGEST_UINT_FILL = 0xFFFFFFFFFFFFFFFF;

/** ライブラリなど外部関数の関数の型 */
typedef void (*external_func_t)();

/** NULLのアドレス */
static const vaddr_t VADDR_NULL = 0x00000000;
/** アドレスに何も割り当てられていない状態の定数 */
static const vaddr_t VADDR_NON  = 0x00000000;

/** 命令 */
typedef uint32_t instruction_t;

/** スタックの作業用バッファサイズ */
static const int STACK_BUFFER_SIZE = 2;

/** オペランドの最大値 */
static const instruction_t FILL_OPERAND = 0x03FFFFFF;
static const instruction_t HEAD_OPERAND = 0x02000000;

/** VM内のint相当のint型 */
typedef pw_int_t vm_int_t;
/** VM内のint相当のint型 */
typedef pw_uint_t vm_uint_t;

/** Interval time of send require packet (sec). */
static const int MEMORY_REQUIRE_INTERVAL = 5;
/** Heartbeat interval.(sec) */
static const int HEARTBEAT_INTERVAL = 3;
/** Interval to call Scheduler::execute.(sec) */
static const int SCHEDULER_EXECUTE_INTERVAL = HEARTBEAT_INTERVAL;

/**
 * Virtual address types that is able to distinguish by using AND operation with MASK.
 */
namespace AddrType {
enum Type : vaddr_t {
  META     = 0x0000000000000000,  ///< Meta data (possible changeing).
  VALUE_08 = 0x1000000000000000,  ///< Address for 0~255Byte sized space.
  VALUE_16 = 0x2000000000000000,  ///< Address for 256〜65KByte sized space.
  VALUE_24 = 0x3000000000000000,  ///< Address for 65K〜16MByte sized space.
  VALUE_32 = 0x4000000000000000,  ///< Address for 16M〜4GByte sized space.
  VALUE_40 = 0x5000000000000000,  ///< Address for 4G〜1TByte sized space.
  VALUE_48 = 0x6000000000000000,  ///< Address for 1T〜256TByte sized space.
  PROGRAM  = 0xF000000000000000,  ///< Address for Function, Type.
  MASK     = 0xF000000000000000,  ///< Mask for clip AddrType area.
             };
}  // namespace AddrType

/**
 * ID of data allocated in program area.
 */
namespace ProgramType {
enum Type : uint8_t {
  NORMAL   = 0x01,  ///< Normal function data.
  EXTERNAL = 0x02,  ///< Built-in/Native function data.
  TYPE     = 0xFF,  ///< Type data.
             };
}  // namespace ProgramType

/** process-id */
typedef std::string vpid_t;
/** Special process-id those are used to send data. */
namespace SpecialPID {
static const vpid_t BROADCAST = "*";  ///< Send data independent by process.
}

/** thread-id */
typedef vaddr_t vtid_t;
/** all thread */
static const vtid_t ALL_THREAD = 0;

static const vtid_t JOIN_WAIT_NONE     = 0x0;
static const vtid_t JOIN_WAIT_ROOT     = 0x1;
static const vtid_t JOIN_WAIT_DETACHED = 0x2;

/** Node-id is assigned for each node process run in any devices. */
typedef std::string nid_t;
/** Special node-id those are used to send command. */
namespace SpecialNID {
static const nid_t NONE      = "";        ///< Set none if destination node-id is't yet determined.
static const nid_t THIS      = ".";       ///< Send command to this(local) node.
static const nid_t BROADCAST = "*";       ///< Send command to any node with the same account.
static const nid_t SERVER    = "server";  ///< Server is a special node.
}

/** trueを表す値 */
static const uint8_t I8_TRUE = 0x1;
/** falseを表す値 */
static const uint8_t I8_FALSE = 0x0;

/**
 * Function types of executable in VM.
 */
namespace FunctionType {
enum Type : uint8_t {
  NORMAL  = 0x01,  ///< Normal function type.
  BUILTIN = 0x02,  ///< VM built-in function type.
  NATIVE  = 0x03,  ///< Native funcion type that is execute by FFI.
            };
}  // namespace FunctionType

/**
 * Kind of primitive and structure types.
 */
namespace TypeKind {
enum Type : uint8_t {
  BASIC  = 0x01,  ///< Primitive type like int, float, and anyother and pointer, function.
  STRUCT = 0x02,  ///< Struct type like the C struct type.
  ARRAY  = 0x03,  ///< Array type like the C array type.
  VECTOR = 0x04,  ///< Vector type that is used by vector operations.
              };
}  // namespace TypeKind

/**
 * Addresses that is assigned for primitive types and pointer, function.
 */
namespace BasicTypeAddress {
static const vaddr_t VOID     = 0xF000000000000001;  ///< void.
static const vaddr_t POINTER  = 0xF000000000000002;  ///< pointer, address.
static const vaddr_t FUNCTION = 0xF000000000000003;  ///< function.

static const vaddr_t UI8      = 0xF000000000000011;  ///< 8bit unsigned int.
static const vaddr_t UI16     = 0xF000000000000012;  ///< 16bit unsigned int.
static const vaddr_t UI32     = 0xF000000000000013;  ///< 32bit unsigned int.
static const vaddr_t UI64     = 0xF000000000000014;  ///< 64bit unsigned int.
static const vaddr_t UI128    = 0xF000000000000015;  ///< 128bit unsigned int.
static const vaddr_t UI256    = 0xF000000000000016;  ///< 256bit unsigned int.
static const vaddr_t UI512    = 0xF000000000000017;  ///< 512bit unsigned int.

static const vaddr_t SI8      = 0xF000000000000021;  ///< 8bit signed int.
static const vaddr_t SI16     = 0xF000000000000022;  ///< 16bit signed int.
static const vaddr_t SI32     = 0xF000000000000023;  ///< 32bit signed int.
static const vaddr_t SI64     = 0xF000000000000024;  ///< 64bit signed int.
static const vaddr_t SI128    = 0xF000000000000025;  ///< 128bit signed int.
static const vaddr_t SI256    = 0xF000000000000026;  ///< 256bit signed int.
static const vaddr_t SI512    = 0xF000000000000027;  ///< 512bit signed int.

// F16
static const vaddr_t F32      = 0xF000000000000032;  ///< Single-precision floating point.
static const vaddr_t F64      = 0xF000000000000033;  ///< Double-precision floating point.
// F80
static const vaddr_t F128     = 0xF000000000000035;  ///< Quadruple-precision floating point.
static const vaddr_t MAX      = 0xF0000000000000FF;  ///< Max address for PrimitiveTypeAddress.
static const vaddr_t MASK     = 0x0FFFFFFFFFFFFFFF;
}  // namespace BasicTypeAddress

/** Opcode of custom VM. */
namespace Opcode {
enum Type : uint8_t {
  NOP,  // = 0;
      EXTRA,
      CALL,
      TAILCALL,
      RETURN,
      SET_TYPE,
      SET_OUTPUT,
      SET_VALUE,
      SET_OV_PTR,
      ADD,
      SUB,    // 10
      MUL,
      DIV,
      REM,
      SHL,
      SHR,
      AND,
      NAND,
      OR,
      XOR,
      MAX,    // 20
      MIN,
      SET,
      SET_PTR,
      SET_ADR,
      SET_ALIGN,
      ADD_ADR,
      MUL_ADR,
      GET_ADR,
      LOAD,
      STORE,  // 30
      CMPXCHG,
      ALLOCA,
      TEST,
      TEST_EQ,
      JUMP,
      INDIRECT_JUMP,
      PHI,
      TYPE_CAST,
      BIT_CAST,
      EQUAL,  // 40
      NOT_EQUAL,
      GREATER,
      GREATER_EQUAL,
      NOT_NANS,
      OR_NANS,
      SELECT,
      SHUFFLE,
      VA_ARG,
      };
}  // namespace Opcode

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
 * Process and thread information to use in scheduler and controller.
 */
struct ProcessInfo {
  /** Porcess-id */
  vpid_t pid;
  /** Process name. */
  std::string name;
  /** Map of thread-id and node-id, last heartbeat time that thread is running. */
  std::map<vtid_t, std::pair<nid_t, std::time_t>> threads;
  /** Node-id that havign gui frontend bundled process or NONE. */
  nid_t gui_nid;
  /** True if vm bundled process is exist in this node. */
  bool having_vm;
  /** Last heartbeat time for process. */
  std::time_t heartbeat;
};

/** Modules those are target of send command. */
namespace Module {
typedef int Type;
static const Type MEMORY     = 0;
static const Type VM         = 1;
static const Type SCHEDULER  = 2;
static const Type CONTROLLER = 3;
static const Type GUI        = 4;
}  // namespace Module

/** Packet for transport command. */
struct CommandPacket {
  const vpid_t& pid;
  const nid_t& dst_nid;
  const nid_t& src_nid;
  const Module::Type module;  ///< Target (destination) module.
  const picojson::object& content;  ///< Content format is depend on each module and command.
};
}  // namespace processwarp
