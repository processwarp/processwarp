#include <gtest/gtest.h>

#include <string>

#include "constant.hpp"
#include "node_id.hpp"

namespace processwarp {
class NodeIDTest : public ::testing::Test {
 public:
};

TEST_F(NodeIDTest, BROADCAST) {
  EXPECT_EQ(NID::BROADCAST, NodeID::BROADCAST.to_str());
}

TEST_F(NodeIDTest, NONE) {
  EXPECT_EQ(NID::NONE, NodeID::NONE.to_str());
}

TEST_F(NodeIDTest, SERVER) {
  EXPECT_EQ(NID::SERVER, NodeID::SERVER.to_str());
}

TEST_F(NodeIDTest, THIS) {
  EXPECT_EQ(NID::THIS, NodeID::THIS.to_str());
}

TEST_F(NodeIDTest, str) {
  std::string id_str = "0123456789abcdef0123456789abcdef";
  NodeID nid = NodeID::from_str(id_str);
  EXPECT_EQ(id_str, nid.to_str());
}

TEST_F(NodeIDTest, json) {
  std::string id_str = "fedcba9876543210fedcba9876543210";
  picojson::value id_json(id_str);
  NodeID nid = NodeID::from_json(id_json);
  EXPECT_EQ(id_str, nid.to_str());
  EXPECT_EQ(std::string("\"fedcba9876543210fedcba9876543210\""),
            nid.to_json().serialize());
}

TEST_F(NodeIDTest, constructor) {
  NodeID nid;
  EXPECT_EQ(NID::NONE, nid.to_str());
}

TEST_F(NodeIDTest, copy) {
  std::string id_str = "0123456789abcdef0123456789abcdef";
  NodeID nid_src = NodeID::from_str(id_str);
  NodeID nid_copy1(nid_src);
  NodeID nid_copy2;
  nid_copy2 = nid_copy1;
  EXPECT_EQ(id_str, nid_copy1.to_str());
  EXPECT_EQ(id_str, nid_copy2.to_str());
}

TEST_F(NodeIDTest, diff) {
  NodeID bro = NodeID::BROADCAST;
  NodeID non = NodeID::NONE;
  NodeID svr = NodeID::SERVER;
  NodeID thi = NodeID::THIS;
  NodeID n1  = NodeID::from_str("0123456789abcdef0123456789abcdef");
  NodeID n2  = NodeID::from_str("fedcba9876543210fedcba9876543210");
  NodeID n3  = NodeID::from_str("fedcba9876543210fedcba9876543210");

  EXPECT_TRUE(bro == bro);
  EXPECT_TRUE(bro == NodeID::BROADCAST);
  EXPECT_FALSE(bro == NodeID::NONE);
  EXPECT_FALSE(bro == n1);
  EXPECT_FALSE(bro != bro);
  EXPECT_FALSE(bro != NodeID::BROADCAST);
  EXPECT_TRUE(bro != NodeID::NONE);
  EXPECT_TRUE(bro != n1);

  EXPECT_TRUE(non == non);
  EXPECT_TRUE(non == NodeID::NONE);
  EXPECT_FALSE(non == NodeID::SERVER);
  EXPECT_FALSE(non == n1);
  EXPECT_FALSE(non != non);
  EXPECT_FALSE(non != NodeID::NONE);
  EXPECT_TRUE(non != NodeID::SERVER);
  EXPECT_TRUE(non != n1);

  EXPECT_TRUE(svr == svr);
  EXPECT_TRUE(svr == NodeID::SERVER);
  EXPECT_FALSE(svr == NodeID::THIS);
  EXPECT_FALSE(svr == n1);
  EXPECT_FALSE(svr != svr);
  EXPECT_FALSE(svr != NodeID::SERVER);
  EXPECT_TRUE(svr != NodeID::THIS);
  EXPECT_TRUE(svr != n1);

  EXPECT_TRUE(thi == thi);
  EXPECT_TRUE(thi == NodeID::THIS);
  EXPECT_FALSE(thi == NodeID::BROADCAST);
  EXPECT_FALSE(thi == n1);
  EXPECT_FALSE(thi != thi);
  EXPECT_FALSE(thi != NodeID::THIS);
  EXPECT_TRUE(thi != NodeID::BROADCAST);
  EXPECT_TRUE(thi != n1);

  EXPECT_TRUE(n1 == n1);
  EXPECT_FALSE(n1 != n1);
  EXPECT_TRUE(n2 == n3);
  EXPECT_FALSE(n2 != n3);
  EXPECT_TRUE(n1 < n2);
  EXPECT_FALSE(n2 < n1);
}

TEST_F(NodeIDTest, center) {
  NodeID v1   = NodeID::from_str("00000000000000000000000000000001");
  NodeID v2   = NodeID::from_str("00000000000000000000000000000002");
  NodeID v3   = NodeID::from_str("00000000000000000000000000000003");
  NodeID v4   = NodeID::from_str("00000000000000000000000000000004");
  NodeID v5   = NodeID::from_str("00000000000000000000000000000005");
  NodeID half = NodeID::from_str("7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF");

  EXPECT_EQ(NodeID::center_mod(NodeID::MIN, v1), NodeID::MIN);
  EXPECT_EQ(NodeID::center_mod(NodeID::MIN, v2), v1);
  EXPECT_EQ(NodeID::center_mod(NodeID::MIN, v3), v1);
  EXPECT_EQ(NodeID::center_mod(NodeID::MIN, v4), v2);
  EXPECT_EQ(NodeID::center_mod(NodeID::MIN, v5), v2);
  EXPECT_EQ(NodeID::center_mod(NodeID::MIN, NodeID::MAX), half);
  EXPECT_EQ(NodeID::center_mod(NodeID::MAX, NodeID::MIN), NodeID::MAX);
  EXPECT_EQ(NodeID::center_mod(NodeID::MAX, v1), NodeID::MIN);
  EXPECT_EQ(NodeID::center_mod(NodeID::MAX, v2), NodeID::MIN);
  EXPECT_EQ(NodeID::center_mod(NodeID::MAX, v3), v1);
  EXPECT_EQ(NodeID::center_mod(NodeID::MAX, v4), v1);
  EXPECT_EQ(NodeID::center_mod(NodeID::MAX, v5), v2);
}

TEST_F(NodeIDTest, is_between) {
  NodeID n1  = NodeID::from_str("0123456789abcdef0123456789abcdef");
  NodeID n2  = NodeID::from_str("0123456789abcdef0123456789abcdf0");
  NodeID n3  = NodeID::from_str("fedcba9876543210fedcba9876543210");

  EXPECT_TRUE(NodeID::MIN.is_between(NodeID::MIN, n1));
  EXPECT_TRUE(n1.is_between(n1, n2));
  EXPECT_FALSE(n2.is_between(n1, n2));
  EXPECT_TRUE(NodeID::MAX.is_between(n3, n1));
  EXPECT_TRUE(NodeID::MIN.is_between(n3, n1));
}
}  // namespace processwarp
