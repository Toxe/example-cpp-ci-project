# Build project on Windows with Clang-cl.
#
# The script assumes that it will be called from inside the project directory.
#
# Usage: .ci\build-project-with-clang-cl.ps1 [build-directory-name]
# - build-directory-name: Optional name of build directory. Default: build.
#
# Example 1: .ci\build-project-with-clang-cl.ps1
# Example 2: .ci\build-project-with-clang-cl.ps1 build-clang

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

# Visual Studio installation directory
$VS_DIR = & "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe" -property installationPath

# init development environment
Push-Location .
& "$VS_DIR\Common7\Tools\Launch-VsDevShell.ps1" -Arch amd64 -HostArch amd64
Pop-Location

# Clang-cl
$CLANG_CL = "$Env:VCINSTALLDIR/Tools/Llvm/x64/bin/clang-cl.exe".Replace("\" ,"/")

Write-Host "---- build-project-with-clang-cl.ps1 ----"
Write-Host "BUILD_DIR: $BUILD_DIR"
Write-Host "VCPKG_DIR: $VCPKG_DIR"
Write-Host "VS_DIR: $VS_DIR"
Write-Host "CLANG_CL: $CLANG_CL"
Write-Host "CMAKE_TOOLCHAIN_FILE: $TOOLCHAIN"
Write-Host "-----------------------------------------"

New-Item -Name "$BUILD_DIR" -ItemType Directory
cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug -DVCPKG_TARGET_TRIPLET=x64-windows -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN" -DCMAKE_C_COMPILER="$CLANG_CL" -DCMAKE_CXX_COMPILER="$CLANG_CL" -B "$BUILD_DIR"
cmake --build "$BUILD_DIR" -j --config Debug
