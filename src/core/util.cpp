
#include <openssl/sha.h>

#include <iomanip>
#include <sstream>
#include <string>

#include "util.hpp"
#include "instruction.hpp"

namespace processwarp {

static const char* OPCODE_STR[] = {
  "NOP",
  "EXTRA",
  "CALL",
  "TAILCALL",
  "RETURN",
  "SET_TYPE",
  "SET_OUTPUT",
  "SET_VALUE",
  "SET_OV_PTR",
  "ADD",
  "SUB",  // 10
  "MUL",
  "DIV",
  "REM",
  "SHL",
  "SHR",
  "AND",
  "NAND",
  "OR",
  "XOR",
  "MAX",  // 20
  "MIN",
  "SET",
  "SET_PTR",
  "SET_ADR",
  "SET_ALIGN",
  "ADD_ADR",
  "MUL_ADR",
  "GET_ADR",
  "LOAD",
  "STORE",  // 30
  "CMPXCHG",
  "ALLOCA",
  "TEST",
  "TEST_EQ",
  "JUMP",
  "INDIRECT_JUMP",
  "PHI",
  "TYPE_CAST",
  "BIT_CAST",
  "EQUAL",  // 40
  "NOT_EQUAL",
  "GREATER",
  "GREATER_EQUAL",
  "NANS",
  "OR_NANS",
  "SELECT",
  "SHUFFLE",
  "VA_ARG",
};

#if defined(ENABLE_LLVM) && !defined(NDEBUG) && !defined(EMSCRIPTEN)
const llvm::Instruction* Util::llvm_instruction;
#endif

/**
 * Calculate SHA256 from a data.
 * @param src Target data.
 * @return SHA256 hex string.
 */
std::string Util::calc_sha256(const std::string& src) {
  unsigned char bin_hash[SHA256_DIGEST_LENGTH];
  SHA256_CTX sha256;
  std::ostringstream os;

  SHA256_Init(&sha256);
  SHA256_Update(&sha256, src.c_str(), src.size());
  SHA256_Final(bin_hash, &sha256);

  int i = 0;
  for (i = 0; i < SHA256_DIGEST_LENGTH; i++) {
    os << std::hex << std::setfill('0') << std::setw(2)
       << static_cast<uint32_t>(bin_hash[i]);
  }

  return os.str();
}

// Show alert to fix function when NDEBUG isn't defined.
void Util::_fixme(int line, const char* file, std::string mesg) {
  std::cerr.setf(std::ios::dec);
  std::cerr << "\x1b[31mfixme\x1b[39m [l" << line << "@" << file << "] " << mesg << std::endl;
}

// Convert instruction code to readable string.
std::string Util::code2str(instruction_t code) {
  std::string opcode  = OPCODE_STR[Instruction::get_opcode(code)];
  std::string operand = num2dec_str(Instruction::get_operand_value(code));
  return opcode + "\t" + operand;
}

template<> std::string Util::num2hex_str<uint8_t>(uint8_t v) {
  std::ostringstream os;
  os << std::hex << std::setfill('0') <<
      std::setw(sizeof(uint8_t) * 2) << static_cast<uint32_t>(v);
  return os.str();
}

template<> uint8_t Util::hex_str2num<uint8_t>(const std::string& str) {
  std::istringstream is(str);
  uint32_t v;
  is >> std::hex >> v;
  return static_cast<uint8_t>(v);
}
}  // namespace processwarp
