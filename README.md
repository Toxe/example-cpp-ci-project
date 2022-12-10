# Example C++ CI Project and CI Services Comparison

[![Build status](https://ci.appveyor.com/api/projects/status/smmr71cjma919r28?svg=true)](https://ci.appveyor.com/project/Toxe/example-cpp-ci-project)
[![CircleCI](https://circleci.com/gh/Toxe/example-cpp-ci-project/tree/master.svg?style=svg)](https://circleci.com/gh/Toxe/example-cpp-ci-project/tree/master)
[![CI](https://github.com/Toxe/example-cpp-ci-project/workflows/CI/badge.svg)](https://github.com/Toxe/example-cpp-ci-project/actions)

An example project to test and compare different CI (Continuous Integration) services building a C++ project on Linux, Mac, Windows with GCC, Clang (libc++ and libstdc++), MSVC and Clang-cl. It uses Vcpkg for installing dependencies.

Note: This tries to be a simple and robust CI setup that is a comprehensive introduction and is open for improvements. It does not use more advanced configurations like build matrices and instead tries to be a bit more specific (even if that means repetition).

### Supported CI services, platforms and Compilers

#### AppVeyor

[![Build status](https://ci.appveyor.com/api/projects/status/smmr71cjma919r28?svg=true)](https://ci.appveyor.com/project/Toxe/example-cpp-ci-project)

- Linux:
  - Clang 14 + libc++
  - GCC 11 + libstdc++
- macOS:
  - Clang 13 + libc++
  - GCC 12 + libstdc++
- Windows:
  - MSVC 2022

#### CircleCI

[![CircleCI](https://circleci.com/gh/Toxe/example-cpp-ci-project/tree/master.svg?style=svg)](https://circleci.com/gh/Toxe/example-cpp-ci-project/tree/master)

- Linux:
  - Clang 14 + libc++
  - Clang 14 + libstdc++
  - GCC 11 + libstdc++
- macOS:
  - Clang 13 + libc++
  - Clang 13 + libstdc++
  - GCC 12 + libstdc++
- Windows:
  - MSVC 2022
  - Clang-cl

#### GitHub Actions

[![CI](https://github.com/Toxe/example-cpp-ci-project/workflows/CI/badge.svg)](https://github.com/Toxe/example-cpp-ci-project/actions)

- Linux:
  - Clang 14 + libc++
  - Clang 14 + libstdc++
  - GCC 12 + libstdc++
- macOS:
  - Clang 13 + libc++
  - Clang 13 + libstdc++
  - GCC 12 + libstdc++
- Windows:
  - MSVC 2022
  - Clang-cl

#### Travis

*No longer supported, since they dropped their free Open Source support.*

## Example Programs

Note: This project contains example programs that serve no other purpose than being examples. The programs themselves don't make much sense on their own.

- `src/show_info`: Outputs a couple of strings describing the compiler and C++ standard library that were used to build the program.
- `src/example`: Builds `example` (just shows some simple output) and `example_tests` (an example for running tests).

## Build and Installation Scripts

The `.ci` directory contains a couple of scripts for installing Vcpkg and building the project.
All CI services use these scripts to simplify their configurations.

- `install-vcpkg.sh` / `install-vcpkg.ps1`: Download and install Vcpkg or update an already existing Vcpkg installation.
- `build-project.sh` / `build-project.ps1`: Build the project itself.
- `build-project-with-clang-cl.ps1`: Used on Windows to build the project with Clang-cl.

## Dependencies

- CMake
- Vcpkg to install dependencies:
  - fmtlib
  - Catch2 + FakeIt

## Sanitizers

Where possible all programs are build using Address Sanitizer.

## Example program output

### `show_info`

Output depends on compiler and C++ standard library.

GCC and libstdc++:

```
__cplusplus: 202002
__GNUC__: 11
_GLIBCXX_RELEASE: 11
```

Clang and libc++:

```
__cplusplus: 202002
__clang_version__: 14.0.5 
_LIBCPP_VERSION: 14000
```

Clang and libstdc++:

```
__cplusplus: 202002
__clang_version__: 14.0.5 
_GLIBCXX_RELEASE: 11
```

MSVC:

```
__cplusplus: 199711
_MSC_VER: 1932
```

Clang-cl:

```
__cplusplus: 202002
_MSC_VER: 1932
__clang_version__: 13.0.1 
```

### `example`

```
Everything seems to be working.
```

### `example_tests`

```
Randomness seeded to: 1486164745
===============================================================================
All tests passed (16 assertions in 3 test cases)
```

## Pre-installed Software

The CI VMs or Docker images come with already pre-installed software.

- AppVeyor: [macOS](https://www.appveyor.com/docs/macos-images-software/), [Linux](https://www.appveyor.com/docs/linux-images-software/), [Windows](https://www.appveyor.com/docs/windows-images-software/)
- CircleCI: [macOS](https://circleci.com/docs/2.0/testing-ios/#supported-xcode-versions), [Linux](https://circleci.com/docs/2.0/circleci-images/#pre-installed-tools) ([image](https://circleci.com/developer/images/image/cimg/base), [Docker file](https://github.com/CircleCI-Public/cimg-base/blob/main/20.04/Dockerfile)), [Windows](https://discuss.circleci.com/t/march-2022-beta-support-for-new-operating-system-for-windows-executors-windows-server-2022/43198)
- GitHub: [macOS](https://github.com/actions/virtual-environments/blob/main/images/macos/macos-11-Readme.md), [Linux](https://github.com/actions/runner-images/blob/main/images/linux/Ubuntu2204-Readme.md), [Windows](https://github.com/actions/virtual-environments/blob/main/images/win/Windows2022-Readme.md)
