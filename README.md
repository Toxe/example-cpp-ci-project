# Example C++ CI Project and CI Services Comparison

| Service | Status | OS and Compiler |
| ------- | ------ | --------------- |
| AppVeyor | [![Build status](https://ci.appveyor.com/api/projects/status/smmr71cjma919r28?svg=true)](https://ci.appveyor.com/project/Toxe/example-cpp-ci-project) | macOS (Clang 13, GCC 12), Linux (Clang 14, GCC 11) and Windows (MSVC 2022) |
| CircleCI | [![CircleCI](https://circleci.com/gh/Toxe/example-cpp-ci-project/tree/master.svg?style=svg)](https://circleci.com/gh/Toxe/example-cpp-ci-project/tree/master) | macOS (Clang 13, GCC 12), Linux (Clang 14, GCC 11) and Windows (MSVC 2022) |
| GitHub Actions | [![CI](https://github.com/Toxe/example-cpp-ci-project/workflows/CI/badge.svg)](https://github.com/Toxe/example-cpp-ci-project/actions) | macOS (Clang 13, GCC 12), Linux (Clang 14, GCC 11) and Windows (MSVC 2022) |
| Travis |  | *no longer supported* |

An example project to test different CI (Continuous Integration) services.

- `example_simple.cpp` is a simple program that has no further dependencies and just outputs a couple of strings describing the compiler and C++ standard library that it was built with.
- `example_benchmark.cpp` needs Vcpkg and uses PCRE, PCRE2 and Google Benchmark to perform a small regular expression benchmark.

## Build and Installation Scripts

The `.ci` directory contains a couple of scripts for installing Vcpkg and building the project.
All CI services use these scripts to simplify their configurations.

- `install-vcpkg.sh` / `install-vcpkg.ps1`: Download and install Vcpkg or update an already existing Vcpkg installation.
- `build-project.sh` / `build-project.ps1`: Build the project itself.

## Dependencies

- CMake
- Vcpkg

## Example program output

### example_simple.cpp

```
__cplusplus: 201703
__clang_version__: 9.0.1
_LIBCPP_VERSION: 9000
```

### example_benchmark.cpp

```
2020-03-06 15:04:27
Running ./build/example_benchmark
Run on (4 X 3300 MHz CPU s)
CPU Caches:
  L1 Data 32K (x4)
  L1 Instruction 32K (x4)
  L2 Unified 262K (x4)
  L3 Unified 6291K (x1)
Load Average: 1.98, 1.96, 1.91
--------------------------------------------------------------------------------
Benchmark                      Time             CPU   Iterations UserCounters...
--------------------------------------------------------------------------------
BM_OneLine_PCRE              386 ns          385 ns      1786325 length=82.1709M
BM_OneLine_PCRE2             371 ns          368 ns      1836489 length=84.4785M
BM_OneLine_PCRE2_JIT         135 ns          135 ns      4972403 length=228.731M
BM_OneLine_PCRE_JIT          132 ns          131 ns      5265731 length=242.224M
BM_AllLines_PCRE            6094 ns         6082 ns       107888 length=25.6773M
BM_AllLines_PCRE2           6123 ns         6058 ns       102703 length=24.4433M
BM_AllLines_PCRE2_JIT       3524 ns         3517 ns       198269 length=47.188M
BM_AllLines_PCRE_JIT        3599 ns         3586 ns       204542 length=48.681M
```

## Pre-installed Software

The CI VMs or Docker images come with already pre-installed software.

- AppVeyor: [macOS](https://www.appveyor.com/docs/macos-images-software/), [Linux](https://www.appveyor.com/docs/linux-images-software/), [Windows](https://www.appveyor.com/docs/windows-images-software/)
- CircleCI: [macOS](https://circleci.com/docs/2.0/testing-ios/#supported-xcode-versions), [Linux](https://circleci.com/docs/2.0/circleci-images/#pre-installed-tools) ([image](https://circleci.com/developer/images/image/cimg/base), [Dockerfile](https://github.com/CircleCI-Public/cimg-base/blob/main/20.04/Dockerfile)), [Windows](https://discuss.circleci.com/t/march-2022-beta-support-for-new-operating-system-for-windows-executors-windows-server-2022/43198)
- GitHub: [macOS](https://github.com/actions/virtual-environments/blob/main/images/macos/macos-11-Readme.md), [Linux](https://github.com/actions/virtual-environments/blob/main/images/linux/Ubuntu2004-Readme.md), [Windows](https://github.com/actions/virtual-environments/blob/main/images/win/Windows2022-Readme.md)
