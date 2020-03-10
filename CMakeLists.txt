cmake_minimum_required(VERSION 3.12)
project("Example C++ CI Project" LANGUAGES CXX)

# default compiler options and warnings
include(cmake/DefaultCompilerOptionsAndWarnings.cmake)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

find_package(benchmark CONFIG REQUIRED)

find_library(PCRE_LIBRARY pcre)
find_library(PCRE2_LIBRARY pcre2-8)

find_path(PCRE_INCLUDE_DIRS pcre.h)
find_path(PCRE2_INCLUDE_DIRS pcre2.h)

set(ALL_TARGETS
    example_simple
    example_benchmark
)

foreach(target ${ALL_TARGETS})
    add_executable(${target} ${target}.cpp)
    target_compile_features(${target} PUBLIC cxx_std_17)
    target_compile_options(${target} PRIVATE ${DEFAULT_COMPILER_OPTIONS_AND_WARNINGS})
    set_target_properties(${target} PROPERTIES CXX_EXTENSIONS OFF)
endforeach()

target_link_libraries(example_benchmark PRIVATE benchmark::benchmark benchmark::benchmark_main "${PCRE_LIBRARY}" "${PCRE2_LIBRARY}")
