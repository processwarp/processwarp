#include "convert.hpp"

#include "definitions.hpp"

#include "gtest/gtest.h"

using namespace processwarp;

namespace {
  class ConvertTest : public ::testing::Test {
  public:
  };

  TEST_F(ConvertTest, bin2json) {
    vaddr_t raw = TY_POINTER;
    std::string bin(reinterpret_cast<const char*>(&raw), sizeof(raw));
    EXPECT_EQ(8, static_cast<int>(bin.size()));
    EXPECT_EQ('\x02', bin[0]);
    EXPECT_EQ('\xf0', bin[7]);

    picojson::value json = Convert::bin2json(bin);    
    std::string inner = json.get<std::string>();
    EXPECT_STREQ("02000000000000f0", inner.c_str());
  }
}
