#include "catch2/catch_test_macros.hpp"

#include "sub.hpp"

TEST_CASE("sub")
{
    REQUIRE(sub(0, 0) == 0);
    REQUIRE(sub(1, 0) == 1);
    REQUIRE(sub(0, 1) == -1);
    REQUIRE(sub(1, 1) == 0);
    REQUIRE(sub(2, 3) == -1);
    REQUIRE(sub(3, 2) == 1);
}
