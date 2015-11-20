
#include <string>
#include <vector>

#include "convert.hpp"

namespace processwarp {

// Convert JSON to binary data.
std::string Convert::json2bin(const picojson::value& json) {
  const std::string& js_str = json.get<std::string>();
  std::vector<uint8_t> bin;
  for (unsigned int i = 0; i < js_str.size(); i += 2) {
    std::string hex(js_str, i, 2);
    bin.push_back(0xFF & std::stoi(hex, nullptr, 16));
  }
  return std::string(reinterpret_cast<char*>(bin.data()), bin.size());
}

// Convert binary data to JSON.
picojson::value Convert::bin2json(const uint8_t* bin, unsigned int size) {
  std::ostringstream os;
  os << std::hex << std::setfill('0');
  for (unsigned int i = 0; i < size; i ++) {
    os << std::setw(2) << (0xFF & static_cast<int>(bin[i]));
  }
  return picojson::value(os.str());
}
}  // namespace processwarp
