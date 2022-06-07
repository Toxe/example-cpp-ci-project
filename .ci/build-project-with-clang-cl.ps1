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

# Visual Studio installation directory
$VS_DIR = Get-VSSetupInstance -All | Select-VSSetupInstance -Require "Microsoft.VisualStudio.Component.VC.Tools.x86.x64" -Latest | Select-Object -ExpandProperty InstallationPath

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
Write-Host "CMAKE_TOOLCHAIN_FILE: $TOOLCHAIN"
Write-Host "CLANG_CL: $CLANG_CL"
Write-Host "-----------------------------------------"

New-Item -Name "$BUILD_DIR" -ItemType Directory
cmake -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DVCPKG_TARGET_TRIPLET=x64-windows -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN" -DCMAKE_C_COMPILER="$CLANG_CL" -DCMAKE_CXX_COMPILER="$CLANG_CL" -B "$BUILD_DIR"
cmake --build "$BUILD_DIR" -j 4 --config RelWithDebInfo
