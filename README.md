# Example C++ CI Project

[![Build Status](https://travis-ci.com/Toxe/example-cpp-ci-project.svg?branch=master)](https://travis-ci.com/Toxe/example-cpp-ci-project) [![Build status](https://ci.appveyor.com/api/projects/status/smmr71cjma919r28?svg=true)](https://ci.appveyor.com/project/Toxe/example-cpp-ci-project)

An example project to test CI services.

`example_simple` is a simple program that just outputs a string and has no further dependencies and `example_benchmark` is a program that needs Vcpkg and uses PCRE, PCRE2 and Google Benchmark to perform a small regular expression benchmark.

## Dependencies

- CMake
- [Google Benchmark](https://github.com/google/benchmark)
- PCRE
- PCRE2

### Vcpkg

Install Vcpkg dependencies with:

    $ vcpkg install $(< .vcpkg)
