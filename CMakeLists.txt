cmake_minimum_required(VERSION 3.12)
project("Example C++ CI Project" LANGUAGES CXX)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

set(ALL_TARGETS
    example
)

if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    string(REGEX REPLACE " /W[0-4]" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
endif()

foreach(target ${ALL_TARGETS})
    add_executable(${target} ${target}.cpp)
    target_compile_features(${target} PUBLIC cxx_std_17)
    set_target_properties(${target} PROPERTIES CXX_EXTENSIONS OFF)

    if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        target_compile_options(${target} PRIVATE -Wall -Wextra -pedantic -Wconversion -Wfloat-equal -Wold-style-cast -fcolor-diagnostics -Wmost)
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        target_compile_options(${target} PRIVATE -Wall -Wextra -pedantic -Wconversion -Wfloat-equal -Wold-style-cast -fdiagnostics-color)
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        target_compile_options(${target} PRIVATE /W4)
    endif()
endforeach()
