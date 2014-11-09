#pragma once

#include <cstdint>
#include <string>
#include <vector>

namespace usagi {
  /** 通信プロトコルのメジャーバージョン */
  static const int PROTOCOL_MAJOR_VERSION = 0;
  /** 通信プロトコルのマイナーバージョン */
  static const int PROTOCOL_MINOR_VERSION = 1;

  /** 値に割り振る仮想アドレス */
  typedef std::uint64_t vaddr_t;

  /** 命令 */
  typedef std::uint32_t instruction_t;

  /** アドレスに何も割り当てられていない状態の定数 */
  static const vaddr_t VADDR_NON = 0;

  /** VM内のint相当のint型 */
  typedef int64_t vm_int_t;
  /** VM内のint相当のint型 */
  typedef uint64_t vm_uint_t;

  /** メモリの内容ごとに割り当てるアドレスの判定フラグ */
  enum AddrType : vaddr_t {
    VALUE_08 = 0x1000000000000000,      ///< 0〜255Byte空間
    VALUE_16 = 0x2000000000000000,      ///< 256〜65KByte空間
    VALUE_24 = 0x3000000000000000,      ///< 65K〜16MByte空間
    VALUE_32 = 0x4000000000000000,      ///< 16M〜4GByte空間
    VALUE_40 = 0x5000000000000000,      ///< 4G〜1PByte空間
    VALUE_48 = 0x6000000000000000,      ///< 1P〜256PByte空間
    CONSTANT = 0x8000000000000000,      ///< 定数判定フラグ
    FUNCTION = 0xF000000000000000,      ///< 関数
    MASK     = 0xF000000000000000,
  };

  /** プロセスID */
  typedef std::string pid_t;
  
  enum Opcode : uint8_t {
    // ----------------------------------------------------------------------
    // name		args	description
    // ----------------------------------------------------------------------
    //MOVE,     /* 0	A B	R(A) := R(B) */
    // OP_LOADK,	 /* 1	A Bx	R(A) := Kst(Bx)					*/
    // OP_LOADKX,	 /* 2	A 	R(A) := Kst(extra arg)				*/
    // OP_LOADBOOL, /* 3	A B C	R(A) := (Bool)B; if (C) pc++			*/
    // OP_LOADNIL,  /* 4	A B	R(A), R(A+1), ..., R(A+B) := nil		*/
    // OP_GETUPVAL, /* 5	A B	R(A) := UpValue[B]				*/

    // OP_GETTABUP, /* 6	A B C	R(A) := UpValue[B][RK(C)]			*/
    // OP_GETTABLE, /* 7	A B C	R(A) := R(B)[RK(C)]				*/

    // OP_SETTABUP, /* 8	A B C	UpValue[A][RK(B)] := RK(C)			*/
    // OP_SETUPVAL, /* 9	A B	UpValue[B] := R(A)				*/
    // OP_SETTABLE, /* 10	A B C	R(A)[RK(B)] := RK(C)				*/

    // OP_NEWTABLE, /* 11	A B C	R(A) := {} (size = B,C)				*/

    // OP_SELF,     /* 12	A B C	R(A+1) := R(B); R(A) := R(B)[RK(C)]		*/

    // OP_ADD,      /* 13	A B C	R(A) := RK(B) + RK(C)				*/
    // OP_SUB,      /* 14	A B C	R(A) := RK(B) - RK(C)				*/
    // OP_MUL,      /* 15	A B C	R(A) := RK(B) * RK(C)				*/
    // OP_DIV,      /* 16	A B C	R(A) := RK(B) / RK(C)				*/
    // OP_MOD,      /* 17	A B C	R(A) := RK(B) % RK(C)				*/
    // OP_POW,      /* 18	A B C	R(A) := RK(B) ^ RK(C)				*/
    // OP_UNM,      /* 19	A B	R(A) := -R(B)					*/
    // OP_NOT,      /* 20	A B	R(A) := not R(B)				*/
    // OP_LEN,      /* 21	A B	R(A) := length of R(B)				*/

    // OP_CONCAT,   /* 22	A B C	R(A) := R(B).. ... ..R(C)			*/

    // OP_JMP,      /* 23	A sBx	pc+=sBx; if (A) close all upvalues >= R(A) + 1	*/
    // OP_EQ,       /* 24	A B C	if ((RK(B) == RK(C)) ~= A) then pc++		*/
    // OP_LT,       /* 25	A B C	if ((RK(B) <  RK(C)) ~= A) then pc++		*/
    // OP_LE,       /* 26	A B C	if ((RK(B) <= RK(C)) ~= A) then pc++		*/

    // OP_TEST,     /* 27	A C	if not (R(A) <=> C) then pc++			*/
    // OP_TESTSET,  /* 28	A B C	if (R(B) <=> C) then R(A) := R(B) else pc++	*/

    CALL,     /* 29	A B	R(A) := RK(B)() */
      CALLX,	/*	A B	R(A) := RK(B)(RK(ex2(1)), RK(ex2(2)),,, RK(ex2(ex2(0)))) */
      TAILCALL, /* 30	A B	return  RK(A)(RK(ex2(0)), RK(ex2(1)),,, RK(ex2(B))); */
      RETURN,   /* 31	A	return  R(A) */

    // OP_FORLOOP,  /* 32	A sBx	R(A)+=R(A+2); if R(A) <?= R(A+1) then { pc+=sBx; R(A+3)=R(A) }*/
    // OP_FORPREP,  /* 33	A sBx	R(A)-=R(A+2); pc+=sBx				*/

    // OP_TFORCALL, /* 34	A C	R(A+3), ... ,R(A+2+C) := R(A)(R(A+1), R(A+2));	*/
    // OP_TFORLOOP, /* 35	A sBx	if R(A+1) ~= nil then { R(A)=R(A+1); pc += sBx }*/

    // OP_SETLIST,  /* 36	A B C	R(A)[(C-1)*FPF+i] := R(A+i), 1 <= i <= B	*/

    // OP_CLOSURE,  /* 37	A Bx	R(A) := closure(KPROTO[Bx])			*/

    // OP_VARARG,   /* 38	A B	R(A), R(A+1), ..., R(A+B-2) = vararg		*/

      EXTRAARG1,  /* 39	Ax	extra (larger) argument for previous opcode	*/
      EXTRAARG2,  /* 40 Ax Bx	extra (larger) argument for previous opcode	*/
  };
}
