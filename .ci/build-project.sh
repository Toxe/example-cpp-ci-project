#!/bin/bash

# Build project.
#
# The script assumes that it will be called from inside the project directory.
#
# Usage: /bin/bash .ci/build-project.sh [build-directory-name]
# - build-directory-name: Optional name of build directory. Default: build.
#
# Example 1: /bin/bash .ci/build-project.sh
# Example 2: /bin/bash .ci/build-project.sh build-clang

set -e

BUILD_DIR=${1:-build}
VCPKG_DIR="$HOME/vcpkg"

# only pass toolchain file to CMake if Vcpkg is installed
if [[ -d "$VCPKG_DIR" ]]; then TOOLCHAIN="$VCPKG_DIR/scripts/buildsystems/vcpkg.cmake"; else TOOLCHAIN=False; fi

echo "---- build-project.sh ----"
echo "BUILD_DIR: $BUILD_DIR"
echo "VCPKG_DIR: $VCPKG_DIR"
echo "CC: $CC"
echo "CXX: $CXX"
echo "CXXFLAGS: $CXXFLAGS"
echo "CMAKE_TOOLCHAIN_FILE: $TOOLCHAIN"
echo "--------------------------"

mkdir "$BUILD_DIR"
cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN" -DUSE_SANITIZER=address -B "$BUILD_DIR"
cmake --build "$BUILD_DIR" -j
