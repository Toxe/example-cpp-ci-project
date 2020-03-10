#!/bin/bash

# Build project.
#
# The script assumes that it will be called from inside the project directory.
#
# Usage: sh .ci/build-project.sh [vcpkg-directory [build-directory-name]]
# - vcpkg-directory: Optional full path to Vcpkg directory. Default: $HOME/vcpkg
# - build-directory-name: Optional name of build directory. Default: build.
#                         Can only be set of vcpkg-directory is set as well.
#
# Example 1: sh .ci/build-project.sh
# Example 2: sh .ci/build-project.sh $HOME/vcpkg-clang
# Example 3: sh .ci/build-project.sh $HOME/vcpkg-clang build-clang

set -e

VCPKG_DIR=${1:-$HOME/vcpkg}
BUILD_DIR=${2:-build}

# only pass toolchain file to CMake if Vcpkg is installed
if [ -d "$VCPKG_DIR" ]; then TOOLCHAIN="$VCPKG_DIR/scripts/buildsystems/vcpkg.cmake"; else TOOLCHAIN=False; fi

echo "---- build-project.sh ----"
echo "VCPKG_DIR: $VCPKG_DIR"
echo "BUILD_DIR: $BUILD_DIR"
echo "CC: $CC"
echo "CXX: $CXX"
echo "CXXFLAGS: $CXXFLAGS"
echo "CMAKE_TOOLCHAIN_FILE: $TOOLCHAIN"
echo "--------------------------"

mkdir "$BUILD_DIR" && pushd "$BUILD_DIR"
cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN" ..
cmake --build .
popd
