#pragma once

#include <cassert>

#include "definitions.hpp"

namespace processwarp {
class Instruction {
 public:
  /**
   * 命令の中からオペコードを抜き出す。
   * @param code 命令
   * @return オペコード
   */
  static inline instruction_t get_opcode(instruction_t code) {
    return (code >> 26) & 0x3F;
  }

  /**
   * 命令の中からオペランドを抜き出す。
   * @param code 命令
   * @return オペランド
   */
  static inline instruction_t get_operand(instruction_t code) {
    return (code      ) & FILL_OPERAND;
  }

  /**
   * 命令の中からオペランドを数値として抜き出す。
   * @param code 命令
   * @return 数値
   */
  static inline int get_operand_value(instruction_t code) {
    if ((code & HEAD_OPERAND) != 0) {
      return static_cast<int>(code | ~FILL_OPERAND);

    } else {
      return code & FILL_OPERAND;
    }
  }

  /**
   * 命令を作成する。
   * @param opcode オペコード
   * @param operand オペランド
   * @return 命令
   */
  static inline instruction_t make_instruction(Opcode opcode, int operand) {
    assert((static_cast<instruction_t>(operand)    & ~FILL_OPERAND) == 0 ||
           (static_cast<instruction_t>(-operand-1) & ~FILL_OPERAND) == 0);

    return
        (static_cast<instruction_t>(opcode) << 26 & 0xFC000000) |
        (static_cast<instruction_t>(operand)      & 0x03FFFFFF);
  }

  /**
   * 命令のオペランドを書き換える。
   * @param code 書き換え前命令
   * @param operand オペランド
   * @return 書き換え後命令
   */
  static inline instruction_t rewrite_operand(instruction_t code, int operand) {
    assert((static_cast<instruction_t>(operand)    & ~FILL_OPERAND) == 0 ||
           (static_cast<instruction_t>(-operand-1) & ~FILL_OPERAND) == 0);
    return (code & 0xFC000000) | (operand & 0x03FFFFFF);
  }
};
}  // namespace processwarp
