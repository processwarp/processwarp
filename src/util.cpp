
#include "util.hpp"
#include "instruction.hpp"

using namespace usagi;

static const char* OPCODE_STR[] = {
  "NOP",
  "EXTRA",
  "CALL",
  "TAILCALL",
  "RETURN",
  "UNWIND",
  "SET_TYPE",
  "SET_OUTPUT",
  "SET_VALUE",
  "ADD",
  "SUB", // 10
  "MUL",
  "DIV",
  "REM",
  "SHL",
  "SHR",
  "AND",
  "OR",
  "XOR",
  "COPY",
  "SET_ADR", // 20
  "SET_ALIGN",
  "ADD_ADR",
  "MUL_ADR",
  "GET_ADR",
  "LOAD",
  "STORE",
  "ALLOC",
  "FREE",
  "ALLOCA",
  "TEST", // 30
  "TEST_EQ",
  "JUMP",
  "PHI",
  "TYPE_CAST",
  "BIT_CAST",
  "EQUAL",
  "NOT_EQUAL",
  "GREATER",
  "GREATER_EQUAL",
  "NANS", // 40
  "OR_NANS",
  "SELECT",
  "VA_ARG",
};

// 未実装機能を表すメソッド。
void Util::_fixme(long line, const char* file, std::string mesg) {
    std::cerr.setf(std::ios::dec);
    std::cerr << "\x1b[31mfixme\x1b[39m [l" << line << "@" << file << "] " << mesg << std::endl;
}

// 命令コードを人間に読みやすい文字列に変換する。
std::string Util::code2str(instruction_t code) {
  std::string opcode  = OPCODE_STR[Instruction::get_opcode(code)];
  std::string operand = num2dec_str(Instruction::get_operand_value(code));
  return opcode + "\t" + operand;
}

// 文字列をアドレスに変換。
vaddr_t Util::str2vaddr(const std::string& str) {
  std::istringstream is(str);
  vaddr_t addr;
  is >> std::hex >> addr;
  return addr;
}

// アドレスを16進数表現で文字列に変換。
std::string Util::vaddr2str(vaddr_t addr) {
  std::ostringstream os;
  os << std::hex << std::setfill('0') << std::setw(16) << std::uppercase << addr;
  return os.str();
}
