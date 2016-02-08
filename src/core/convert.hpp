#pragma once

#include <picojson.h>

#include <set>
#include <string>
#include <vector>

#include "definitions.hpp"
#include "util.hpp"

namespace processwarp {
namespace Convert {
/**
 * Convert integer to string.
 * @param num A source integer.
 * @return A integer as string.
 */
template<class T> std::string int2str(T num) {
  return Util::num2hex_str<T>(num);
}

/**
 * Convert process-id to string.
 * @param pid process-id.
 * @return process-id as string.
 */
inline const std::string& vpid2str(const vpid_t& pid) {
  return pid;
}

/**
 * Convert thread-id to string.
 * @param tid thread-id.
 * @return thread-id as string.
 */
inline std::string vtid2str(const vtid_t& tid) {
  return int2str<vtid_t>(tid);
}

/**
 * Convert virtual-address to string.
 * @param addr Virtual-address.
 * @return Virtual-address as string.
 */
inline std::string vaddr2str(const vaddr_t& addr) {
  return int2str<vaddr_t>(addr);
}

/**
 * Convert node-id to string.
 * @param nid Source node-id.
 * @return Converted value as string.
 */
inline const std::string& nid2str(const nid_t& nid) {
  return nid;
}

/**
 * Convert string to integer.
 * @param str A source string.
 * @return A converted integer.
 */
template<class T> T str2int(const std::string& str) {
  return Util::hex_str2num<T>(str);
}

/**
 * Convert process-id to string.
 * @param str Source string value.
 * @return Converted value as vpid_t.
 */
inline vpid_t str2vpid(const std::string& str) {
  return str;
}

/**
 * Convert thread-id from string.
 * @param str A string.
 * @return A thread-id.
 */
inline vtid_t str2vtid(const std::string& str) {
  return str2int<vtid_t>(str);
}

/**
 * Convert virtual-address from string.
 * @param str string.
 * @return Virtual-address.
 */
inline vaddr_t str2vaddr(const std::string& str) {
  return str2int<vaddr_t>(str);
}

/**
 * Convert node-id to string.
 * @param str Source string value.
 * @return Node-id.
 */
inline const nid_t& str2nid(const std::string& str) {
  return str;
}

/**
 * Convert process-id from JSON.
 * @param json JSON.
 * @return process-id.
 */
inline vpid_t json2vpid(const picojson::value& json) {
  return str2vpid(json.get<std::string>());
}

/**
 * Convert JSON to bool.
 * @param json Source JSON.
 * @return A converted integer.
 */
inline bool json2bool(const picojson::value& json) {
  return json.get<std::string>() == "T";
}

/**
 * Convert JSON to integer.
 * @param json Source JSON.
 * @return A converted integer.
 */
template<class T> T json2int(const picojson::value& json) {
  return str2int<T>(json.get<std::string>());
}

/**
 * Convert a thread-id from JSON.
 * @param json Source JSON.
 * @return A thread-id.
 */
inline vtid_t json2vtid(const picojson::value& json) {
  return str2vtid(json.get<std::string>());
}

/**
 * Convert a virtual address from JSON.
 * @param json Source JSON.
 * @return A virtual address.
 */
inline vaddr_t json2vaddr(const picojson::value& json) {
  return str2vaddr(json.get<std::string>());
}

/**
 * Convert a vector of virtual address from JSON.
 * @param json Source JSON.
 * @return A vector of virtual address.
 */
inline std::vector<vaddr_t> json2vaddr_vector(const picojson::value& json) {
  std::vector<vaddr_t> av;
  for (auto& it : json.get<picojson::array>()) {
    av.push_back(json2vaddr(it));
  }
  return av;
}

/**
 * Convert a instruction code from JSON.
 * @param json Source JSON.
 * @return A instruction code.
 */
inline instruction_t json2code(const picojson::value& json) {
  return str2int<instruction_t>(json.get<std::string>());
}

/**
 * Convert a node-id from JSON
 * @param json Source JSON.
 * @return A node-id.
 */
inline const nid_t& json2nid(const picojson::value& json) {
  return str2nid(json.get<std::string>());
}

/**
 * Convert JSON to binary data.
 * It have JSON to contain binary data as hex string.
 * @param json Source JSON.
 * @return Binary data.
 */
std::string json2bin(const picojson::value& json);

/**
 * Convert process-id to JSON.
 * @param pid Source process-id.
 * @return Process-id as JSON.
 */
inline picojson::value vpid2json(const vpid_t& pid) {
  return picojson::value(vpid2str(pid));
}

/**
 * Convert bool to JSON.
 * @param b Source boolean.
 * @return Boolean as JSON.
 */
inline picojson::value bool2json(bool b) {
  return picojson::value(std::string(b ? "T" : "F"));
}

/**
 * Convert integer to JSON.
 * @param num Source integer.
 * @return Integer as JSON.
 */
template<class T> picojson::value int2json(T num) {
  return picojson::value(int2str<T>(num));
}

/**
 * Convert thread-id to JSON.
 * @param tid Source thread-id.
 * @return Thread-id as JSON.
 */
inline picojson::value vtid2json(const vtid_t& tid) {
  return picojson::value(vtid2str(tid));
}

/**
 * Convert virtual address to JSON.
 * @param addr Source virtual address.
 * @return Virtual address as JSON.
 */
inline picojson::value vaddr2json(vaddr_t addr) {
  return int2json<vaddr_t>(addr);
}

/**
 * Convert vector of virtual address to JSON.
 * @param av Source vector of virtual address.
 * @return Virtual address as JSON.
 */
inline picojson::value vaddr_vector2json(const std::vector<vaddr_t> av) {
  picojson::array json;
  for (auto& it : av) {
    json.push_back(vaddr2json(it));
  }
  return picojson::value(json);
}

/**
 * Convert instruction code to JSON.
 * @param code Source instruction code.
 * @return Instruction code as JSON.
 */
inline picojson::value code2json(instruction_t code) {
  return picojson::value(int2str<instruction_t>(code));
}

/**
 * Convert node-id to JSON.
 * @param nid Source node-id.
 * @return node-id as JSON.
 */
inline picojson::value nid2json(const nid_t& nid) {
  return picojson::value(nid2str(nid));
}

/**
 * Convert binary data to JSON.
 * Binary data is converted to hex string and packed by JSON.
 * @param bin Source binary data.
 * @param size Source binary data size.
 * @return Binary data as JSON.
 */
picojson::value bin2json(const uint8_t* bin, unsigned int size);
}  // namespace Convert
}  // namespace processwarp
