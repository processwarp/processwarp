
#include <picojson.h>

#include <cassert>
#include <fstream>
#include <iostream>
#include <map>
#include <string>
#include <vector>

#include "logger.hpp"
#include "message.hpp"
#include "util.hpp"

namespace processwarp {
namespace Message {
/** Storing all messages (mid->message). */
static std::map<_Type, std::string> messages;

/**
 * Format message string with parameters similter to printf.
 * @param mid Message-id of raw message.
 * @param args Parameters to embedded.
 * @return Formatted message string.
 */
std::string vformat(Type mid, va_list args) {
  const std::string& raw_message = get(mid);
  std::vector<char> buffer;
  buffer.resize(raw_message.size() * 2);
RETRY:
  va_list args_copy;
  va_copy(args_copy, args);
  int r = vsnprintf(buffer.data(), buffer.size(), raw_message.c_str(), args_copy);
  va_end(args_copy);
  if (r >= 0 && static_cast<unsigned int>(r) >= buffer.size()) {
    buffer.resize(r + 1);
    goto RETRY;
  }
  return std::string(buffer.data());
}

/**
 * Get raw message.
 * @param mid Message-id for message.
 * @return Raw message string.
 */
const std::string& get(Type mid) {
  assert(messages.find(mid) != messages.end());
  return messages[mid];
}

/**
 * Load message database that JSON format.
 * @param fname Filename of database that JSON format.
 * @return True if succeed.
 */
bool load(const std::string& fname) {
  std::ifstream file(fname);
  if (!file.is_open()) {
    Logger::output_raw(Logger::Level::ERROR, __FILE__, __LINE__, "L4001",
                       "failed to read message file (file_name=" + fname + ", reason=can't open)");
    return false;
  }

  // Decode JSON.
  picojson::value v;
  std::string err = picojson::parse(v, file);
  file.close();
  if (!err.empty()) {
    Logger::output_raw(Logger::Level::ERROR, __FILE__, __LINE__, "L4001",
                       "failed to read message file (file_name=" + fname + ", reason=" + err + ")");
    return false;
  }

  for (auto& it_message : v.get<picojson::object>()) {
    const std::string& mid = it_message.first;
    std::string message = it_message.second.get<std::string>();

    if (messages.find(mid) != messages.end()) {
      Logger::output_raw(Logger::Level::ERROR, __FILE__, __LINE__, "L4001",
                         "failed to read message file (file_name=" + fname +
                         ", reason=duplicate mid, mid=" + mid + ")");
      return false;
    }

    // Replace reserved keyword.
    Util::replace_string(&message, "%{tid}", "%016" PRIx64);

    messages.insert(std::make_pair(mid, message));
  }

  return true;
}
}  // namespace Message
}  // namespace processwarp
