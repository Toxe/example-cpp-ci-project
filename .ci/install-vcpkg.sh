#!/bin/bash

# Build Vcpkg and install dependency packages.
#
# Vcpkg itself and the Vcpkg packages will be compiled with $CC, $CXX and $CXXFLAGS, if set.
#
# If $VCPKG_CC, $VCPKG_CXX or $VCPKG_CXXFLAGS are defined then Vcpkg itself will be
# compiled with these flags, but the Vcpkg packages will still be compiled with CC/CXX/CXXFLAGS.
# Setting the $VCPKG_* might be necessary to build Vcpkg on macOS versions prior to macOS 10.15 Catalina.
#
# Usage: sh .ci/install-vcpkg.sh <project directory> [vcpkg directory name]
# - project directory: Path to the project sources where the .vcpkg file is located.
# - vcpkg directory name: optional name of directory where Vcpkg will be clone'd into
#
# Example 1: sh .ci/install-vcpkg.sh $GITHUB_WORKSPACE
# Example 2: sh .ci/install-vcpkg.sh $APPVEYOR_BUILD_FOLDER vcpkg-clang

set -e

if [ $# -lt 1 ]; then exit 1; fi

PROJECT_DIR=$1
VCPKG_DIR=${2:-vcpkg}

# do nothing if .vcpkg file doesn't exist
if [ ! -f "$PROJECT_DIR/.vcpkg" ]; then echo ".vcpkg file does not exist, skipping Vcpkg installation."; exit 0; fi

VCPKG_CC=${VCPKG_CC-$CC}
VCPKG_CXX=${VCPKG_CXX-$CXX}
VCPKG_CXXFLAGS=${VCPKG_CXXFLAGS-$CXXFLAGS}

echo "---- install-vcpkg.sh ----"
echo "PROJECT_DIR: $PROJECT_DIR"
echo "VCPKG_DIR: $VCPKG_DIR"
echo "CC: $CC"
echo "CXX: $CXX"
echo "CXXFLAGS: $CXXFLAGS"
echo "VCPKG_CC: $VCPKG_CC"
echo "VCPKG_CXX: $VCPKG_CXX"
echo "VCPKG_CXXFLAGS: $VCPKG_CXXFLAGS"
echo "--------------------------"

pushd $HOME
git clone --depth 1 https://github.com/Microsoft/vcpkg.git "$VCPKG_DIR"
cd "$VCPKG_DIR"
CC=$VCPKG_CC CXX=$VCPKG_CXX CXXFLAGS=$VCPKG_CXXFLAGS ./bootstrap-vcpkg.sh --disableMetrics
./vcpkg install $(< "$PROJECT_DIR/.vcpkg")
popd
