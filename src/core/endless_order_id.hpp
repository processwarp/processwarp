#pragma once

#ifndef __ANDROID__
#  include <cinttypes>
#  include <cstdint>
#else
namespace std {
#  include <inttypes.h>
#  include <stdint.h>
}  // namespace std
#endif  // ifndef __ANDROID__
#include <picojson.h>

#include <string>

namespace processwarp {
class EndlessOrderID {
 public:
  static EndlessOrderID from_json(const picojson::value& json);

  EndlessOrderID();
  EndlessOrderID(const EndlessOrderID& src);

  EndlessOrderID& operator=(const EndlessOrderID& src);
  bool operator==(const EndlessOrderID& src) const;
  bool operator>(const EndlessOrderID& src) const;
  EndlessOrderID& operator+=(uint32_t b);

  picojson::value to_json() const;
  std::string to_str() const;

 private:
  uint32_t value;

  explicit EndlessOrderID(uint32_t value_);

  static int compare(uint32_t a, uint32_t b);
};
}  // namespace processwarp
