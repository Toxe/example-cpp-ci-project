#!/bin/bash

# Install Vcpkg in $HOME/vcpkg.
#
# Usage: sh .ci/install-vcpkg.sh

set -e

echo "---- install-vcpkg.sh ----"
echo "Vcpkg install directory: $HOME/vcpkg"
echo "--------------------------"

pushd "$HOME"
git clone https://github.com/Microsoft/vcpkg.git
cd vcpkg
./bootstrap-vcpkg.sh --disableMetrics
popd
