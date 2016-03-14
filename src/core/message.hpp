#pragma once

#include <string>

namespace processwarp {
namespace Message {
typedef const std::string _Type;
typedef _Type& Type;

std::string vformat(Type mid, va_list args);
const std::string& get(Type mid);
bool load(const std::string& fname);
}  // namespace Message
}  // namespace processwarp
