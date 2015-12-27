#pragma once

#include <string>
#include <vector>

#include "thread.hpp"

namespace processwarp {
namespace Format {
std::string parse(Thread& thread, const uint8_t* format, const std::vector<uint8_t>& ap);
}  // namespace Format
}  // namespace processwarp
