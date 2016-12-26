#include <gtest/gtest.h>

#include <string>

#include "constant_vm.hpp"
#include "convert.hpp"
#include "types.hpp"

namespace processwarp {
class ConvertTest : public ::testing::Test {
 public:
};

TEST_F(ConvertTest, bin2json) {
  vaddr_t raw = BasicTypeAddress::POINTER;
  std::string bin(reinterpret_cast<const char*>(&raw), sizeof(raw));
  EXPECT_EQ(8, static_cast<int>(bin.size()));
  EXPECT_EQ('\x02', bin[0]);
  EXPECT_EQ('\xf0', bin[7]);

  picojson::value json =
      Convert::bin2json(reinterpret_cast<const uint8_t*>(bin.data()), bin.length());
  std::string inner = json.get<std::string>();
  EXPECT_STREQ("02000000000000f0", inner.c_str());
}
}  // namespace processwarp
