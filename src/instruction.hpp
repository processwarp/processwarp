#pragma once

#include "definitions.hpp"

namespace usagi {
  class Instruction {
  public:
    /**
     * 命令の中からオペコードを抜き出す。
     * @param code 命令
     * @return オペコード
     */
    static inline instruction_t get_opcode(instruction_t code) {
      return (code >> 56) & 0xFF;
    }

    /**
     * 命令の中からオプションコードを抜き出す。
     * @param code 命令
     * @return オプションコード
     */
    static inline instruction_t get_option(instruction_t code) {
      return (code >> 48) & 0xFF;
    }

    /**
     * AB形式の命令の中からAコードを抜き出す。
     * @param code 命令
     * @return Aコード
     */
    static inline instruction_t get_code_A(instruction_t code) {
      return (code >> 24) & 0xFFFFFF;
    }
    
    /**
     * AB形式の命令の中からBコードを抜き出す。
     * @param code 命令
     * @return Bコード
     */
    static inline instruction_t get_code_B(instruction_t code) {
      return (code      ) & 0xFFFFFF;
    }

    /**
     * AB形式の命令を作成する。
     * @param opcode オペコード
     * @param option オプション
     * @param a Aコード
     * @param b Bコード
     * @return 命令
     */
    static inline instruction_t make_AB(Opcode opcode, int option, int a, int b) {
      assert((static_cast<instruction_t>(a)    << 24 & ~0x0000FFFFFF000000) == 0 ||
	     (static_cast<instruction_t>(-a-1) << 24 & ~0x0000FFFFFF000000) == 0);
      assert((static_cast<instruction_t>(b)    <<  0 & ~0x0000000000FFFFFF) == 0 ||
	     (static_cast<instruction_t>(-b-1) <<  0 & ~0x0000000000FFFFFF) == 0);

      return
	(static_cast<instruction_t>(opcode) << 56 & 0xFF00000000000000) |
	(static_cast<instruction_t>(option) << 48 & 0x00FF000000000000) |
	(static_cast<instruction_t>(a)      << 24 & 0x0000FFFFFF000000) |
	(static_cast<instruction_t>(b)      <<  0 & 0x0000000000FFFFFF);
    }

    /**
     * AB形式の命令のAコードを書き換える。
     * @param code 書き換え前命令
     * @param a Aコード
     * @return 書き換え後命令
     */
    static inline instruction_t rewrite_code_A(instruction_t code, int a) {
      assert((static_cast<instruction_t>(a)    << 24 & ~0x0000FFFFFF000000) == 0 ||
	     (static_cast<instruction_t>(-a-1) << 24 & ~0x0000FFFFFF000000) == 0);
      return (code & 0xFFFF000000FFFFFF) | (a << 24 & 0x0000FFFFFF000000);
    }

    /**
     * AB形式の命令のBコードを書き換える。
     * @param code 書き換え前命令
     * @param b Bコード
     * @return 書き換え後命令
     */
    static inline instruction_t rewrite_code_B(instruction_t code, int b) {
      assert((static_cast<instruction_t>(b)    <<  0 & ~0x0000000000FFFFFF) == 0 ||
	     (static_cast<instruction_t>(-b-1) <<  0 & ~0x0000000000FFFFFF) == 0);
      return (code & 0xFFFFFFFFFF000000) | (b <<  0 & 0x0000000000FFFFFF);
    }
  };
}
