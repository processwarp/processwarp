#pragma once

#include <set>

#include "lib/picojson.h"
#include "definitions.hpp"
#include "util.hpp"

namespace processwarp {
  namespace Convert {
    /**
     * Convert process-id from JSON.
     * @param json JSON.
     * @return process-id.
     */
    inline vpid_t json2vpid(const picojson::value& json) {
      return json.get<vpid_t>();
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
      return Util::hex_str2num<T>(json.get<std::string>());
    }

    /**
     * Convert a thread-id from JSON.
     * @param json Source JSON.
     * @return A thread-id.
     */
    inline vtid_t json2vtid(const picojson::value& json) {
      return json2int<vtid_t>(json);
    }

    /**
     * Convert a virtual address from JSON.
     * @param json Source JSON.
     * @return A virtual address.
     */
    inline vaddr_t json2vaddr(const picojson::value& json) {
      return json2int<vaddr_t>(json);
    }

    /**
     * Convert a instruction code from JSON.
     * @param json Source JSON.
     * @return A instruction code.
     */
    inline instruction_t json2code(const picojson::value& json) {
      return json2int<instruction_t>(json);
    }

    /**
     * Convert process-id to JSON.
     * @param pid Source process-id.
     * @return Process-id as JSON.
     */
    inline picojson::value vpid2json(const vpid_t& pid) {
      return picojson::value(pid);
    }

    /**
     * Convert bool to JSON.
     * @param b Source boolean.
     * @return Boolean as JSON.
     */
    inline picojson::value bool2json(bool b) {
      return picojson::value(b ? "T" : "F");
    }
    
    /**
     * Convert integer to JSON.
     * @param num Source integer.
     * @return Integer as JSON.
     */
    template<class T> picojson::value int2json(T num) {
      return picojson::value(Util::num2hex_str<T>(num));
    }

    /**
     * Convert thread-id to JSON.
     * @param tid Source thread-id.
     * @return Thread-id as JSON.
     */
    inline picojson::value vtid2json(const vtid_t& tid) {
      return int2json<vtid_t>(tid);
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
     * Convert instruction code to JSON.
     * @param code Source instruction code.
     * @return Instruction code as JSON.
     */
    inline picojson::value code2json(instruction_t code) {
      return int2json<instruction_t>(code);
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
      return Util::num2hex_str<vtid_t>(tid);
    }

    /**
     * Convert thread-id from string.
     * @param str string.
     * @param thread-id.
     */
    inline vtid_t str2vtid(const std::string& str) {
      return Util::hex_str2num<vtid_t>(str);
    }
  }
}
