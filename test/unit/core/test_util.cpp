#include <gtest/gtest.h>

#include <string>

#include "util.hpp"

namespace processwarp {
class UtilTest : public ::testing::Test {
 public:
};

TEST_F(UtilTest, calc_sha256) {
  EXPECT_EQ(std::string("9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08"),
            Util::calc_sha256("test"));
}
}  // namespace processwarp
