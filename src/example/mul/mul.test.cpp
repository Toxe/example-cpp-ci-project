#include "catch2/catch_test_macros.hpp"

#include "mul.hpp"

TEST_CASE("mul")
{
    REQUIRE(mul(0, 0) == 0);
    REQUIRE(mul(1, 0) == 0);
    REQUIRE(mul(0, 1) == 0);
    REQUIRE(mul(1, 1) == 1);
    REQUIRE(mul(2, 3) == 6);
}
