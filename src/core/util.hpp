#pragma once

#if defined(ENABLE_LLVM) && !defined(NDEBUG) && !defined(EMSCRIPTEN)
#include <llvm/IR/Constants.h>
#include <llvm/IR/DerivedTypes.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Value.h>
#include <llvm/IR/ValueSymbolTable.h>
#include <llvm/AsmParser/Parser.h>
#include <llvm/Support/ManagedStatic.h>
#include <llvm/Support/SourceMgr.h>
#endif

#include <cstring>
#include <string>
#include <sstream>
#include <iomanip>
#include <iostream>

#include "definitions.hpp"

namespace processwarp {
namespace Util {
/**
 * Convert instruction code to readable string.
 * @param code Instruction code.
 * @return Converted string.
 */
std::string code2str(instruction_t code);

/**
 * Convert integer to decimal string.
 * @param v Integer.
 * @return Converted string.
 */
template<class T> std::string num2dec_str(T v) {
  return std::to_string(v);
}

/**
 * Convert integer to hex string.
 * @param v Integer.
 * @return Converted string.
 */
template<class T> std::string num2hex_str(T v) {
  std::ostringstream os;
  os << std::hex << std::setfill('0') << std::setw(sizeof(T) * 2) << v;
  return os.str();
}

template<> std::string num2hex_str<uint8_t>(uint8_t v);

inline std::string numptr2str(const void* ptr, unsigned int size) {
  longest_uint_t buffer;
  std::memcpy(&buffer, ptr, size);
  std::ostringstream os;
  os << std::hex << std::setfill('0') << std::setw(size * 2) << buffer;
  return os.str();
}

/**
 * Convert hex formated string to integer.
 * @param str Hex formated string.
 * @return Converted integer.
 */
template<class T> T hex_str2num(const std::string& str) {
  std::istringstream is(str);
  T v;
  is >> std::hex >> v;
  return v;
}

template<> uint8_t hex_str2num<uint8_t>(const std::string& str);

/**
 * Convert address string to vaddr_t.
 * @param str address string.
 * @return Converted address.
 */
inline vaddr_t str2vaddr(const std::string& str) {
  return hex_str2num<vaddr_t>(str);
}

/**
 * Converted address vaddr_t to string.
 * @param addr address vaddr_t.
 * @return Converted address.
 */
inline std::string vaddr2str(vaddr_t addr) {
  return num2hex_str<vaddr_t>(addr);
}

/**
 * Show alert to fix function when NDEBUG isn't defined.
 * @param mesg Message to show.
 */
#ifdef NDEBUG
#define fixme(mesg)  //
#else
#define fixme(mesg) Util::_fixme(__LINE__, __FILE__, mesg);
#endif
void _fixme(int line, const char* file, std::string mesg);

/**
 * Show debug message when NEBUG isn't defined.
 * @param mesg Message to show (format is the same to printf).
 */
#ifdef NDEBUG
#define print_debug(...)  //
#else  // NDEBUG
#define print_debug(...) {                                      \
    std::string file(__FILE__);                                 \
    std::string::size_type sep = file.rfind('/');               \
    if (sep == std::string::npos) sep = file.rfind('\\');       \
    const char* file_cstr = file.c_str();                       \
    if (sep != std::string::npos) file_cstr += sep + 1;         \
    fprintf(stderr, "debug [%d@%s] ", __LINE__, file_cstr);     \
    fprintf(stderr, "" __VA_ARGS__);                            \
  }
#endif  // NDEBUG

#if !defined(ENABLE_LLVM) || defined(NDEBUG) || defined(EMSCRIPTEN)
#define save_llvm_instruction(I)  //
#define print_llvm_instruction()  //
#else
extern const llvm::Instruction* llvm_instruction;
#define save_llvm_instruction(I) Util::llvm_instruction = (I)
#define print_llvm_instruction() Util::llvm_instruction->dump();
#endif
}  // namespace Util
}  // namespace processwarp