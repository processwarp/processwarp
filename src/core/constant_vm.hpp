#pragma once

#include "type.hpp"

namespace processwarp {

/** Buffer size of working for stack. */
static const int STACK_BUFFER_SIZE  = 2;

/** Value of nullptr in virtual-machine. */
static const vaddr_t VADDR_NULL = 0x0;
/** Value of true in virtual-machine. */
static const uint8_t I8_TRUE    = 0x1;
/** Value of false in virtual-machine. */
static const uint8_t I8_FALSE   = 0x0;

/** Threshold of access count for change owner or occasion to copy. */
static const int MEMORY_REFERRAL_LIMIT  = 5;
/** Interval time of send require packet (sec). */
static const int MEMORY_REQUIRE_INTERVAL    = 5;
/** Heatbeat interval.(sec) */
static const int HEARTBEAT_INTERVAL = 10;
/** Deadline time for unresponsive module.(sec) */
static const int HEARTBEAT_DEADLINE = 60;
/** Clock routine interval.(sec) */
static const int BEAT_ROUTINE_INTERVAL = 5;

/**
 * Virtual address types that is able to distinguish by using AND operation with MASK.
 */
namespace AddressRegion {
typedef vaddr_t Type;
static const Type META      = 0x0000000000000000;  ///< Meta data (possible changeing).
static const Type VALUE_08  = 0x1000000000000000;  ///< Address for 0~255Byte sized space.
static const Type VALUE_16  = 0x2000000000000000;  ///< Address for 256〜65KByte sized space.
static const Type VALUE_24  = 0x3000000000000000;  ///< Address for 65K〜16MByte sized space.
static const Type VALUE_32  = 0x4000000000000000;  ///< Address for 16M〜4GByte sized space.
static const Type VALUE_40  = 0x5000000000000000;  ///< Address for 4G〜1TByte sized space.
static const Type VALUE_48  = 0x6000000000000000;  ///< Address for 1T〜256TByte sized space.
static const Type PROGRAM   = 0xF000000000000000;  ///< Address for Function, Type.
static const Type MASK      = 0xF000000000000000;  ///< Mask for clip AddrType area.
}  // namespace AddressRegion

/**
 * Addresses that is assigned for primitive types and pointer, function.
 */
namespace BasicTypeAddress {
static const vaddr_t VOID       = 0xF000000000000001;  ///< void.
static const vaddr_t POINTER    = 0xF000000000000002;  ///< pointer, address.
static const vaddr_t FUNCTION   = 0xF000000000000003;  ///< function.

static const vaddr_t UI8        = 0xF000000000000011;  ///< 8bit unsigned int.
static const vaddr_t UI16       = 0xF000000000000012;  ///< 16bit unsigned int.
static const vaddr_t UI32       = 0xF000000000000013;  ///< 32bit unsigned int.
static const vaddr_t UI64       = 0xF000000000000014;  ///< 64bit unsigned int.
static const vaddr_t UI128      = 0xF000000000000015;  ///< 128bit unsigned int.
static const vaddr_t UI256      = 0xF000000000000016;  ///< 256bit unsigned int.
static const vaddr_t UI512      = 0xF000000000000017;  ///< 512bit unsigned int.

static const vaddr_t SI8        = 0xF000000000000021;  ///< 8bit signed int.
static const vaddr_t SI16       = 0xF000000000000022;  ///< 16bit signed int.
static const vaddr_t SI32       = 0xF000000000000023;  ///< 32bit signed int.
static const vaddr_t SI64       = 0xF000000000000024;  ///< 64bit signed int.
static const vaddr_t SI128      = 0xF000000000000025;  ///< 128bit signed int.
static const vaddr_t SI256      = 0xF000000000000026;  ///< 256bit signed int.
static const vaddr_t SI512      = 0xF000000000000027;  ///< 512bit signed int.
// F16
static const vaddr_t F32        = 0xF000000000000032;  ///< Single-precision floating point.
static const vaddr_t F64        = 0xF000000000000033;  ///< Double-precision floating point.
// F80
static const vaddr_t F128       = 0xF000000000000035;  ///< Quadruple-precision floating point.
static const vaddr_t MAX        = 0xF0000000000000FF;  ///< Max address for PrimitiveTypeAddress.
static const vaddr_t MASK       = 0x0FFFFFFFFFFFFFFF;
}  // namespace BasicTypeAddress

/**
 * Post process type of builtin function.
 */
namespace BuiltinPostProc {
typedef int Type;
static const Type NORMAL        = 0;  ///< Normally run next instruction.
static const Type RE_ENTRY      = 1;  ///< Re-entry by stack deciding.
static const Type RETRY_LATER   = 2;  ///< Retry the same instruction later other thread.
}  // namespace BuiltinPostProc

/**
 * Function types of executable in VM.
 */
namespace FunctionType {
typedef uint8_t Type;
static const Type NORMAL    = 0x01;  ///< Normal function type.
static const Type BUILTIN   = 0x02;  ///< VM built-in function type.
static const Type NATIVE    = 0x03;  ///< Native funcion type that is execute by FFI.
}  // namespace FunctionType

namespace JoinWaitStatus {
typedef vtid_t Type;
static const Type NONE      = 0x0;
static const Type ROOT      = 0x1;
static const Type DETACHED  = 0x2;
}  // namespace JoinWaitStatus

/**
 * Opcode of custom VM.
 */
namespace Opcode {
typedef uint8_t Type;
static const Type NOP           = 0;
static const Type EXTRA         = 1;
static const Type CALL          = 2;
static const Type TAILCALL      = 3;
static const Type RETURN        = 4;
static const Type SET_TYPE      = 5;
static const Type SET_OUTPUT    = 6;
static const Type SET_VALUE     = 7;
static const Type SET_OV_PTR    = 8;
static const Type ADD           = 9;
static const Type SUB           = 10;
static const Type MUL           = 11;
static const Type DIV           = 12;
static const Type REM           = 13;
static const Type SHL           = 14;
static const Type SHR           = 15;
static const Type AND           = 16;
static const Type NAND          = 17;
static const Type OR            = 18;
static const Type XOR           = 19;
static const Type MAX           = 20;
static const Type MIN           = 21;
static const Type SET           = 22;
static const Type SET_PTR       = 23;
static const Type SET_ADR       = 24;
static const Type SET_ALIGN     = 25;
static const Type ADD_ADR       = 26;
static const Type MUL_ADR       = 27;
static const Type GET_ADR       = 28;
static const Type LOAD          = 29;
static const Type STORE         = 30;
static const Type CMPXCHG       = 31;
static const Type ALLOCA        = 32;
static const Type TEST          = 33;
static const Type TEST_EQ       = 34;
static const Type JUMP          = 35;
static const Type INDIRECT_JUMP = 36;
static const Type PHI           = 37;
static const Type TYPE_CAST     = 38;
static const Type BIT_CAST      = 39;
static const Type EQUAL         = 40;
static const Type NOT_EQUAL     = 41;
static const Type GREATER       = 42;
static const Type GREATER_EQUAL = 43;
static const Type NOT_NANS      = 44;
static const Type OR_NANS       = 45;
static const Type SELECT        = 46;
static const Type SHUFFLE       = 47;
static const Type VA_ARG        = 48;
}  // namespace Opcode

namespace OperandMask {
static const instruction_t FILL = 0x03FFFFFF;  ///< Max value.
static const instruction_t HEAD = 0x02000000;
}  // namespace OperandMask

/**
 * ID of data allocated in program area.
 */
namespace ProgramType {
typedef uint8_t Type;
static const Type NORMAL    = 0x01;  ///< Normal function data.
static const Type EXTERNAL  = 0x02;  ///< Built-in/Native function data.
static const Type TYPE      = 0xFF;  ///< Type data.
}  // namespace ProgramType

/**
 * Kind of primitive and structure types.
 */
namespace TypeKind {
typedef uint8_t Type;
static const Type BASIC     = 0x01;  ///< Primitive type, pointer, function.
static const Type STRUCT    = 0x02;  ///< Struct type like the C struct type.
static const Type ARRAY     = 0x03;  ///< Array type like the C array type.
static const Type VECTOR    = 0x04;  ///< Vector type that is used by vector operations.
}  // namespace TypeKind

namespace VMemoryPageType {
typedef uint8_t Type;
static const Type NONE      = 0x0;
static const Type LEADER    = 0x1;
static const Type ACCEPTOR  = 0x2;
static const Type PROGRAM   = 0x4;
}  // namespace VMemoryPageType

namespace VMemoryReadMode {
typedef uint8_t Type;
static const Type STOP      = 0;
static const Type ONCE      = 1;
static const Type CONTINUE  = 2;
}  // namespace VMemoryReadMode
}  // namespace processwarp
