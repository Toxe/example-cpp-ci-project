#!/bin/sh

# Build Vcpkg and install dependency packages.
#
# Usage: sh .ci/install-vcpkg.sh <project directory>
# - project directory: Path to the project sources where the .vcpkg file is located.
#
# Example: sh .ci/install-vcpkg.sh $GITHUB_WORKSPACE

if [ $# -lt 1 ]; then exit 1; fi

cd $HOME
git clone --depth 1 https://github.com/Microsoft/vcpkg.git
cd vcpkg
./bootstrap-vcpkg.sh --disableMetrics
./vcpkg install $(< "$1/.vcpkg")
