#!/bin/bash

# Build Vcpkg and install dependency packages.
#
# Usage: sh .ci/install-vcpkg.sh <project directory> [vcpkg directory name]
# - project directory: Path to the project sources where the .vcpkg file is located.
# - vcpkg directory name: optional name of directory where Vcpkg will be clone'd into
#
# Example 1: sh .ci/install-vcpkg.sh $GITHUB_WORKSPACE
# Example 2: sh .ci/install-vcpkg.sh $APPVEYOR_BUILD_FOLDER vcpkg-clang

if [ $# -lt 1 ]; then exit 1; fi

PROJECT_DIR=$1
VCPKG_DIR=${2:-vcpkg}

cd $HOME
git clone --depth 1 https://github.com/Microsoft/vcpkg.git "$VCPKG_DIR"
cd "$VCPKG_DIR"
./bootstrap-vcpkg.sh --disableMetrics
./vcpkg install $(< "$PROJECT_DIR/.vcpkg")
