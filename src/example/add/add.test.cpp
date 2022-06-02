#include "catch2/catch_test_macros.hpp"

#include "add.hpp"

TEST_CASE("add")
{
    REQUIRE(add(0, 0) == 0);
    REQUIRE(add(1, 0) == 1);
    REQUIRE(add(0, 1) == 1);
    REQUIRE(add(1, 1) == 2);
    REQUIRE(add(2, 3) == 5);
}
