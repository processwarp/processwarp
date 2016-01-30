
#include <cstring>
#include <regex>
#include <string>
#include <vector>

#include "format.hpp"

namespace processwarp {

union ApContent {
  vaddr_t addr;
  longest_uint_t int_value;
  double float_value;
};

/**
 * Format string alike to "printf".
 * Parameters to embed to format string are get from virtual memory space.
 * Anyother functions are the same to printf.
 * @param thread
 * @param format_
 * @param ap
 * @return Formatted string.
 */
std::string Format::parse(Thread& thread, const uint8_t* format_,
                          const std::vector<uint8_t>& ap) {
  const std::string format(reinterpret_cast<const char*>(format_));
  printf("Format::parse(%s)\n", reinterpret_cast<const char*>(format_));
  std::vector<ApContent> ap_contents;
  unsigned int ap_index = 0;
  while (ap_index < ap.size()) {
    std::unique_ptr<TypeStore>
        type(TypeStore::read(*thread.memory,
                             *reinterpret_cast<const vaddr_t*>(ap.data() + ap_index)));
    ApContent content;

    if (type->addr == BasicTypeAddress::POINTER) {
      content.addr = *reinterpret_cast<const vaddr_t*>(ap.data() + ap_index + sizeof(vaddr_t));

    } else if (type->addr == BasicTypeAddress::F32) {
      content.float_value = *reinterpret_cast<const float*>(ap.data() + ap_index + sizeof(vaddr_t));

    } else if (type->addr == BasicTypeAddress::F64) {
      content.float_value =
          *reinterpret_cast<const double*>(ap.data() + ap_index + sizeof(vaddr_t));

    } else {
      unsigned int size = type->size;
      if (size > sizeof(longest_uint_t)) size = sizeof(longest_uint_t);
      content.int_value = 0;
      std::memcpy(&content.int_value, ap.data() + ap_index + sizeof(vaddr_t), size);
    }

    ap_contents.push_back(content);
    ap_index += sizeof(vaddr_t) + type->size;
  }
  assert(ap.size() == ap_index);

  std::regex expression("%([1-9][0-9]*\\$)?([#0 \\+\\-]*)([1-9][0-9]*)?"
                        "(\\.([0-9]*)?)?(hh?|ll?|j|z|t)?([%diouxXfeEgGcsp])");

  std::sregex_iterator it(format.begin(), format.end(), expression);
  std::sregex_iterator end;
  if (it == end) return std::string(reinterpret_cast<const char*>(format_));

  int output_position = 0;
  int last_index      = -1;
  std::ostringstream output;

  for (; it != end; it++) {
    std::smatch match = *it;

    output.flags(static_cast<std::ios::fmtflags>(0));
    output.write(format.c_str() + output_position, match.position() - output_position);
    output_position = match.position() + match.length();

    // index
    unsigned int index;
    if (match[1].matched) {
      index = std::stoi(match[1].str(), nullptr, 10) - 1;
      last_index = index;
    } else {
      index = ++last_index;
    }
    if (index > ap_contents.size()) continue;
    ApContent& content = ap_contents.at(index);

    // flags
    std::ios::fmtflags flags = static_cast<std::ios::fmtflags>(0);
    if (match[2].matched) {
      for (char c : match[2].str()) {
        switch (c) {
          case '0': output.fill('0'); break;
          case ' ': output.fill(' '); break;
          case '#': flags |= std::ios::showbase; break;
          case '+': flags |= std::ios::showpos;  break;
          case '-': flags |= std::ios::left;     break;
          default: assert(false); break;
        }
      }
    }
    if (!(flags & std::ios::left)) flags |= std::ios::right;

    // width
    if (match[3].matched) {
      output.width(std::stoi(match[3].str(), nullptr, 10));
    } else {
      output.width(0);
    }

    // precision
    if (match[5].matched) {
      output.precision(std::stoi(match[5].str(), nullptr, 10));
    } else {
      if (match[4].matched) {
        output.precision(0);
      } else {
        output.precision(6);
      }
    }

    // modifier
    longest_uint_t mask = 0xFFFFFFFF;
    if (match[6].matched) {
      std::string m = match[6].str();
      if (m == "hh") mask = 0xFF;
      if (m == "h")  mask = 0xFFFF;
      if (m == "ll") mask = 0xFFFFFFFFFFFFFFFF;
      if (m == "l")  mask = 0xFFFFFFFFFFFFFFFF;
      if (m == "j")  assert(false);  /// @todo
      if (m == "z")  assert(false);  /// @todo
      if (m == "t")  assert(false);  /// @todo
    }

    // type
    switch (match[7].str()[0]) {
      case '%': {
        output.put('%');
      } break;

      case 'd':
      case 'i': {
        output.flags(flags | std::ios::dec);
        output << static_cast<longest_int_t>(content.int_value & mask);
      } break;

      case 'o': {
        output.flags(flags | std::ios::oct);
        output << (content.int_value & mask);
      } break;

      case 'u': {
        output.flags(flags | std::ios::dec);
        output << (content.int_value & mask);
      } break;

      case 'X':
        flags |= std::ios::uppercase;
      case 'x': {
        output.flags(flags | std::ios::hex);
        output << (content.int_value & mask);
      } break;

      case 'f': {
        output.flags(flags | std::ios::fixed);
        output << content.float_value;
      } break;

      case 'E':
        flags |= std::ios::uppercase;
      case 'e': {
        output.flags(flags | std::ios::scientific);
        output << content.float_value;
      } break;

      case 'G':
        flags |= std::ios::uppercase;
      case 'g': {
        output.flags(flags);
        output << content.float_value;
      } break;

      case 'c': {
        output.put(static_cast<char>(content.int_value));
      } break;

      case 's': {
        output << reinterpret_cast<const char*>(thread.memory->read_raw(content.addr));
      } break;

      case 'p': {
        output.precision(0);
        output.flags(std::ios::hex | std::ios::uppercase | (flags & std::ios::left));
        output << content.addr;
      } break;

      default: {
        assert(false);
      }
    }
  }
  output.write(format.c_str() + output_position, format.size() - output_position);
  return output.str();
}
}  // namespace processwarp
