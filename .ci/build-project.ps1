# Build project.
#
# The script assumes that it will be called from inside the project directory.
#
# Usage: .ci\build-project.ps1 [build-directory-name]
# - build-directory-name: Optional name of build directory. Default: build.
#
# Example 1: .ci\build-project.ps1
# Example 2: .ci\build-project.ps1 build-clang

$ErrorActionPreference = "Stop"

$BUILD_DIR = $args[0]
$VCPKG_DIR = "$HOME\vcpkg"

if ($null -eq $BUILD_DIR)
{
    $BUILD_DIR = "build"
}

# only pass toolchain file to CMake if Vcpkg is installed
if (Test-Path "$VCPKG_DIR" -PathType Container)
{
    $TOOLCHAIN = "$VCPKG_DIR\scripts\buildsystems\vcpkg.cmake"
}
else
{
    $TOOLCHAIN = "False"
}

# if CMake is not in PATH then we assume that it is located in its normal install directory
if (-not(Get-Command cmake -ErrorAction SilentlyContinue))
{
    New-Alias -Name cmake -Value "$Env:ProgramFiles\CMake\bin\cmake.exe"
}

Write-Host "---- build-project.ps1 ----"
Write-Host "BUILD_DIR: $BUILD_DIR"
Write-Host "VCPKG_DIR: $VCPKG_DIR"
Write-Host "CMAKE_TOOLCHAIN_FILE: $TOOLCHAIN"
Write-Host "---------------------------"

New-Item -Name "$BUILD_DIR" -ItemType Directory
cmake -DCMAKE_BUILD_TYPE=Debug -DVCPKG_TARGET_TRIPLET=x64-windows -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN" -B "$BUILD_DIR"
cmake --build "$BUILD_DIR" -j --config Debug
