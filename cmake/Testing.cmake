# enable testing with CTest
include(CTest)

# Catch2 v3
find_package(Catch2 3 CONFIG REQUIRED)

include(Catch)

# FakeIt
find_path(FAKEIT_INCLUDE_DIRS "boost/fakeit.hpp")
