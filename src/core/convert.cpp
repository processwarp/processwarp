
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

/**
 * Convert JSON to time(sec).
 * This function convert JSON to time by way of relative time.
 * Timers may different from each other.
 * It suppose that the period to transport packet is very short.
 * The packet contain relative time from when the packet has send.
 * @param json Source JSON.
 * @return A time typed std::time_t.
 */
std::time_t Convert::json2time(const picojson::value& json) {
  int32_t diff = json2int<int32_t>(json);
  return time(nullptr) + diff;
}

// Convert binary data contained string type to JSON.
picojson::value Convert::bin2json(const std::string& bin) {
  return bin2json(reinterpret_cast<const uint8_t*>(bin.data()), bin.size());
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

/**
 * Convert time(sec) to JSON.
 * @see json2time
 * @param time A time typed std::time_t.
 * @return A time as JSON.
 */
picojson::value Convert::time2json(std::time_t time) {
  int32_t diff = time - std::time(nullptr);
  return int2json(diff);
}
}  // namespace processwarp
