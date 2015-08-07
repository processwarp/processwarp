#pragma once

#include <cinttypes>
#include <cstdint>
#include <ctime>
#include <string>
#include <vector>

#include "../include/processwarp/processwarp.h"

namespace processwarp {
  class Process;
  class Thread;

  /** 通信プロトコルのメジャーバージョン */
  static const int PROTOCOL_MAJOR_VERSION = 0;
  /** 通信プロトコルのマイナーバージョン */
  static const int PROTOCOL_MINOR_VERSION = 1;

  /** 仮想アドレス */
  typedef __pw_vm_ptr_t vaddr_t;

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

  /** Post process type of builtin function. */
  enum BuiltinPost {
    BP_NORMAL, ///< Normally run next instruction.
    BP_RE_ENTRY, ///< Re-entry by stack deciding.
    BP_RETRY_LATER, ///< Retry the same instruction later other thread.
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
  typedef BuiltinPost (*builtin_func_t)(Process& proc, Thread& thread, BuiltinFuncParam p,
					vaddr_t dst, std::vector<uint8_t>& src);

  /** システム中で扱う最長のuint */
  typedef std::uint64_t longest_uint_t;

  /** システム中で扱う最長のint */
  typedef std::uint64_t longest_int_t;

  /** 最長のuintを1うめしたもの */
  //static longest_uint_t LONGEST_UINT_FILL = 0xFFFFFFFFFFFFFFFF;

  /** ライブラリなど外部関数の関数の型 */
  typedef void (*external_func_t)();

  /** NULLのアドレス */
  static const vaddr_t VADDR_NULL = 0x00000000;
  /** アドレスに何も割り当てられていない状態の定数 */
  static const vaddr_t VADDR_NON  = 0x00000000;

  /** 命令 */
  typedef std::uint32_t instruction_t;

  /** スタックの作業用バッファサイズ */
  static const int STACK_BUFFER_SIZE = 2;

  /** オペランドの最大値 */
  static const instruction_t FILL_OPERAND = 0x03FFFFFF;
  static const instruction_t HEAD_OPERAND = 0x02000000;

  /** VM内のint相当のint型 */
  typedef __pw_vm_int_t vm_int_t;
  /** VM内のint相当のint型 */
  typedef __pw_vm_uint_t vm_uint_t;

  /** メモリの内容ごとに割り当てるアドレスの判定フラグ */
  enum AddrType : vaddr_t {
    AD_META     = 0x0000000000000000, ///< Meta data (possible changeing).
    AD_VALUE_08 = 0x1000000000000000, ///< 0〜255Byte空間
    AD_VALUE_16 = 0x2000000000000000, ///< 256〜65KByte空間
    AD_VALUE_24 = 0x3000000000000000, ///< 65K〜16MByte空間
    AD_VALUE_32 = 0x4000000000000000, ///< 16M〜4GByte空間
    AD_VALUE_40 = 0x5000000000000000, ///< 4G〜1TByte空間
    AD_VALUE_48 = 0x6000000000000000, ///< 1T〜256TByte空間
    AD_PROGRAM  = 0xF000000000000000, ///< Function, Type.
    AD_MASK     = 0xF000000000000000,
    AD_PTR      = 0x4000000100000000,
  };

  /** ID of data allocated in program area. */
  enum ProgramType : uint8_t {
    /** Normal function data. */
    PT_NORMAL   = 0x01,
    /** Built-in/Native function data. */
    PT_EXTERNAL = 0x02,
    /** Type data. */
    PT_TYPE     = 0xFF,
  };

  /** process-id */
  typedef std::string vpid_t;
  /** thread-id */
  typedef vaddr_t vtid_t;
  /** all thread */
  static const vtid_t ALL_THREAD = 0;

  static const vtid_t JOIN_WAIT_NONE     = 0x0;
  static const vtid_t JOIN_WAIT_ROOT     = 0x1;
  static const vtid_t JOIN_WAIT_DETACHED = 0x2;

  /** device-id */
  typedef std::string dev_id_t;
  /** To set when broadcast. */
  static const dev_id_t DEV_BROADCAST = "";
  /** Server's device-id */
  static const dev_id_t DEV_SERVER = "";

  /** trueを表す値 */
  static const uint8_t I8_TRUE = 0x1;
  /** falseを表す値 */
  static const uint8_t I8_FALSE = 0x0;

  /** Function type. */
  enum FuncType : uint8_t {
    /** Normal function type. */
    FC_NORMAL       = 0x01,
    /** Built-in function type. */
    FC_BUILTIN      = 0x02,
    /** Native funcion type. */
    FC_NATIVE       = 0x03,
  };

  /** 型の種類 */
  enum TypeKind : uint8_t {
    TK_BASIC        = 0x01, ///< 基本型
    TK_STRUCT       = 0x02, ///< 構造体
    TK_ARRAY        = 0x03, ///< 配列
    TK_VECTOR       = 0x04, ///< vector
  };

  /** 基本型に予約するアドレス */
  enum BasicType : vaddr_t {
    TY_VOID     = 0xF000000000000001, ///< void型
    TY_POINTER  = 0xF000000000000002, ///< ポインタ
    TY_FUNCTION = 0xF000000000000003, ///< 関数

    TY_UI8      = 0xF000000000000011, ///< 8bit整数型
    TY_UI16     = 0xF000000000000012, ///< 16bit整数型
    TY_UI32     = 0xF000000000000013, ///< 32bit整数型
    TY_UI64     = 0xF000000000000014, ///< 64bit整数型
    TY_UI128    = 0xF000000000000015, ///< 128bit整数型
    TY_UI256    = 0xF000000000000016, ///< 256bit整数型
    TY_UI512    = 0xF000000000000017, ///< 512bit整数型

    TY_SI8      = 0xF000000000000021, ///< 8bit整数型
    TY_SI16     = 0xF000000000000022, ///< 16bit整数型
    TY_SI32     = 0xF000000000000023, ///< 32bit整数型
    TY_SI64     = 0xF000000000000024, ///< 64bit整数型
    TY_SI128    = 0xF000000000000025, ///< 128bit整数型
    TY_SI256    = 0xF000000000000026, ///< 256bit整数型
    TY_SI512    = 0xF000000000000027, ///< 512bit整数型

    // TY_F16
    TY_F32      = 0xF000000000000032, ///< 単精度浮動小数点型
    TY_F64      = 0xF000000000000033, ///< 倍精度浮動小数点型
    // TY_F80
    TY_F128     = 0xF000000000000035, ///< 四倍精度浮動小数点型
    TY_MAX      = 0xF0000000000000FF, ///< 基本型最大値
    TY_MASK     = 0x0FFFFFFFFFFFFFFF,
  };
  
  /** 仮想マシンのOpcode */
  enum Opcode : uint8_t {
    // ----------------------------------------------------------------------
    // name		args	description
    // ----------------------------------------------------------------------
    NOP = 0,
      EXTRA,
      CALL,
      TAILCALL,
      RETURN,
      SET_TYPE,
      SET_OUTPUT,
      SET_VALUE,
      SET_OV_PTR,
      ADD,
      SUB, // 10
      MUL,
      DIV,
      REM,
      SHL,
      SHR,
      AND,
      NAND,
      OR,
      XOR,
      MAX, // 20
      MIN,
      SET,
      SET_PTR,
      SET_ADR,
      SET_ALIGN,
      ADD_ADR,
      MUL_ADR,
      GET_ADR,
      LOAD,
      STORE, // 30
      CMPXCHG,
      ALLOCA,
      TEST,
      TEST_EQ,
      JUMP,
      INDIRECT_JUMP,
      PHI,
      TYPE_CAST,
      BIT_CAST,
      EQUAL, // 40
      NOT_EQUAL,
      GREATER,
      GREATER_EQUAL,
      NOT_NANS,
      OR_NANS,
      SELECT,
      SHUFFLE,
      VA_ARG,
  };

  /** Interval time of send require packet (ms). */
  static const clock_t MEMORY_REQUIRE_INTERVAL = 5000;
  /** Max retry times of send require packet. */
  static const int MEMORY_REQUIRE_TRY_MAX = 10;
}
