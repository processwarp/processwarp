#pragma once

#include <cstdint>
#include <string>
#include <vector>

namespace usagi {
  class Value;
  class VMachine;
  class Thread;

  /** 通信プロトコルのメジャーバージョン */
  static const int PROTOCOL_MAJOR_VERSION = 0;
  /** 通信プロトコルのマイナーバージョン */
  static const int PROTOCOL_MINOR_VERSION = 1;

  /** VM組み込み関数の型 */
  typedef Value (*intrinsic_func_t)(VMachine&, Thread&, std::vector<Value>&);

  /** システム中で扱う最長のuint */
  typedef std::uint64_t longest_uint_t;

  /** システム中で扱う最長のint */
  typedef std::uint64_t longest_int_t;

  /** 最長のuintを1うめしたもの */
  static longest_uint_t LONGEST_UINT_FILL = 0xFFFFFFFFFFFFFFFF;

  /** ライブラリなど外部関数の関数の型 */
  typedef void (*external_func_t)();

  /** 値に割り振る仮想アドレス */
  typedef std::uint64_t vaddr_t;

  /** NULLのアドレス */
  static vaddr_t VADDR_NULL = 0x0;

  /** 命令 */
  typedef std::uint64_t instruction_t;

  /** スタックの作業用バッファサイズ */
  static const int STACK_BUFFER_SIZE = 2;

  /** 仮想プロセスID */
  typedef std::string vpid_t;

  /** A/Bオペランドの最大値 */
  static const instruction_t MAX_OPERAND_AB  = 0xFFFFFF;
  static const instruction_t HEAD_OPERAND_AB = 0x800000;

  /** アドレスに何も割り当てられていない状態の定数 */
  static const vaddr_t VADDR_NON = 0x0000000000000000;

  /** VM内のint相当のint型 */
  typedef int64_t vm_int_t;
  /** VM内のint相当のint型 */
  typedef uint64_t vm_uint_t;

  /** メモリの内容ごとに割り当てるアドレスの判定フラグ */
  enum AddrType : vaddr_t {
    AD_TYPE     = 0x0000000000000000, ///< 型
    AD_VALUE_08 = 0x1000000000000000, ///< 0〜255Byte空間
    AD_VALUE_16 = 0x2000000000000000, ///< 256〜65KByte空間
    AD_VALUE_24 = 0x3000000000000000, ///< 65K〜16MByte空間
    AD_VALUE_32 = 0x4000000000000000, ///< 16M〜4GByte空間
    AD_VALUE_40 = 0x5000000000000000, ///< 4G〜1TByte空間
    AD_VALUE_48 = 0x6000000000000000, ///< 1T〜256TByte空間
    AD_CONSTANT = 0x8000000000000000, ///< 定数判定フラグ
    AD_FUNCTION = 0xF000000000000000, ///< 関数
    AD_MASK     = 0xF000000000000000,
  };

  /** プロセスID */
  typedef std::string pid_t;

  /** 関数のタイプ */
  enum FuncType : uint8_t {
    FC_NORMAL       = 0x01, ///< 通常の関数(VMで解釈、実行する)
    FC_INTRINSIC    = 0x02, ///< VM組み込み関数
    FC_EXTERNAL     = 0x03, ///< ライブラリなど外部の関数
  };

  /** 基本型に予約するアドレス */
  enum BasicType : vaddr_t {
    TY_VOID     = 0x0000000000000001, ///< void型
    TY_POINTER  = 0x0000000000000002, ///< ポインタ
    TY_FUNCTION = 0x0000000000000003, ///< 関数
    TY_I8       = 0x0000000000000011, ///< 8bit整数型
    TY_I16      = 0x0000000000000012, ///< 16bit整数型
    TY_I32      = 0x0000000000000013, ///< 32bit整数型
    TY_I64      = 0x0000000000000014, ///< 64bit整数型
    // TY_F16
    TY_F32      = 0x0000000000000022, ///< 単精度浮動小数点型
    TY_F64      = 0x0000000000000023, ///< 倍精度浮動小数点型
    // TY_F80
    TY_F128     = 0x0000000000000024, ///< 四倍精度浮動小数点型
    TY_MAX      = 0x00000000000000FF, ///< 基本型最大値
  };
  
  /** 仮想マシンのOpcode */
  enum Opcode : uint8_t {
    // ----------------------------------------------------------------------
    // name		args	description
    // ----------------------------------------------------------------------
    NOP,
      CALL,     /* 29	A B	(RK(ex2-0A))R(ex2-0B) := RK(A)((RK(ex2-1A))RK(ex2-1B),,, */
      RETURN,   /* 31	A B	if A == 0 then return; else return RK(B); */
      JUMP,     /* ??	A B	pc = A (Bは未使用)*/
      TEST,     /* ??   A B	if (RK(A) != 0) pc = B; else pc += 1; */
      PHI,      /* ??	A B	R(A) = phi (R(B)) [ex2-0A, ex2-0B]... */
      ADD,      /* ??   A B	R(A) = (R(B))ex2-0A + ex2-0B */
      UREM,     /* ??   A B	R(A) = (R(B))ex2-0A % ex2-0B */
      SREM,     /* ??   A B	R(A) = (R(B))ex2-0A % ex2-0B */
      // メモリアクセス系命令
      LOAD,     /* ??   A B	R(A) = addrof(R(B)) */
      STORE,	/* ??   A B	addrof(R(B)) = R(A) */
      GET_EP,   /* ??   A B	R(A) = addrof(R(B)) */
      // 変換演算子
      SEXT,     /* ??   A B	R(A) = (R(B))ex2-0A % ex2-0B */
      EXTRAARG1,  /* 39	Ax	extra (larger) argument for previous opcode	*/
      EXTRAARG2,  /* 40 Ax Bx	extra (larger) argument for previous opcode	*/
  };
}
