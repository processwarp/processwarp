
#include <libgen.h>
#if !defined(__ANDROID__)
#include <openssl/sha.h>
#endif
#if defined(__APPLE__) && defined(__MACH__)
#include <mach-o/dyld.h>
#endif
#ifdef __linux__
#include <unistd.h>
#endif
#include <sys/param.h>

#include <iomanip>
#include <memory>
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
#if !defined(__ANDROID__)
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
#endif

/**
 * Get the last component of a pathname.
 * If suffix is matched to last of the pathname, remove it from return value.
 * @param path Pathname.
 * @param cutoff_ext Cut off the extension from basename if the basename have a externsion and option is true.
 * @return The last component of a pathname.
 */
std::string Util::file_basename(const std::string& path, bool cutoff_ext) {
  std::string basename;
  std::string::size_type pos = path.find_last_of('/');

  if (pos == std::string::npos) {
    basename = path;
  } else {
    basename = path.substr(pos + 1);
  }

  if (cutoff_ext) {
    pos = basename.find_last_of('.');
    if (pos == std::string::npos) {
      return basename;
    } else {
      return basename.substr(0, pos);
    }

  } else {
    return basename;
  }
}

/**
 * Split path to dirname and basename, and get dirname.
 * @param path A target path to split.
 * @return A string of dirname.
 */
std::string Util::file_dirname(const std::string& path) {
  std::unique_ptr<char[]> buffer(new char[path.size() + 1]);

  memcpy(buffer.get(), path.c_str(), path.size());
  buffer[path.size()] = '\0';

  return std::string(dirname(buffer.get()));
}

/**
 * Get a fullpath of executable-file just now running.
 * @return A full path of executable-file.
 */
std::string Util::get_my_fullpath() {
#if defined(__APPLE__) && defined(__MACH__)
  char buffer[MAXPATHLEN];
  uint32_t len = sizeof(buffer);

  if (_NSGetExecutablePath(buffer, &len)) {
    /// @todo error
    assert(false);
  }
  return std::string(buffer);
#elif defined(__linux__)
  char buffer[MAXPATHLEN];
  if (readlink("/proc/self/exe", buffer, sizeof(buffer)) < 0) {
    /// @todo error
    assert(false);
  }
  return std::string(buffer);
#else
#error Unexpected platform.
#endif
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
