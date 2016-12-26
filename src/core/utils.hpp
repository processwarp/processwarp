#pragma once

#include <cstring>
#include <string>
#include <sstream>
#include <iomanip>
#include <iostream>

#include "types.hpp"

namespace processwarp {
namespace Utils {
std::string calc_md5(const std::string& src);
std::string calc_sha256(const std::string& src);
std::string file_basename(const std::string& path, bool cutoff_ext = false);
std::string file_dirname(const std::string& path);
std::string get_my_fullpath();
void replace_string(std::string* str, const std::string& from, const std::string& to);

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

inline const char* get_filename(const std::string fullpath) {
  std::string::size_type sep = fullpath.rfind('/');
  if (sep == std::string::npos) sep = fullpath.rfind('\\');
  const char* file_cstr = fullpath.c_str();
  if (sep != std::string::npos) file_cstr += sep + 1;
  return file_cstr;
}

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
}  // namespace Utils
}  // namespace processwarp
