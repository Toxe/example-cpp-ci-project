add_executable(
        example
        main.cpp
        add/add.cpp
        add/add.hpp
        mul/mul.cpp
        mul/mul.hpp
        sub/sub.cpp
        sub/sub.hpp
)

set_target_properties(example PROPERTIES CXX_EXTENSIONS OFF)
target_compile_features(example PUBLIC cxx_std_20)
target_compile_options(example PRIVATE ${SANITIZER_COMPILE_OPTIONS} ${DEFAULT_COMPILER_OPTIONS} ${DEFAULT_COMPILER_WARNINGS})
target_link_options(example PRIVATE ${SANITIZER_LINK_OPTIONS})
target_link_libraries(example PRIVATE ${SANITIZER_LINK_LIBRARIES} fmt::fmt)

# Tests
if (BUILD_TESTING)
    add_executable(
            example_tests
            add/add.cpp
            add/add.hpp
            add/add.test.cpp
            mul/mul.cpp
            mul/mul.hpp
            mul/mul.test.cpp
            sub/sub.cpp
            sub/sub.hpp
            sub/sub.test.cpp
    )

    set_target_properties(example_tests PROPERTIES CXX_EXTENSIONS OFF)
    target_compile_features(example_tests PUBLIC cxx_std_20)
    target_compile_options(example_tests PRIVATE ${SANITIZER_COMPILE_OPTIONS} ${DEFAULT_COMPILER_OPTIONS} ${DEFAULT_COMPILER_WARNINGS})
    target_link_options(example_tests PRIVATE ${SANITIZER_LINK_OPTIONS})
    target_link_libraries(example_tests PRIVATE ${SANITIZER_LINK_LIBRARIES} fmt::fmt Catch2::Catch2WithMain)
    target_include_directories(example_tests PRIVATE ${FAKEIT_INCLUDE_DIRS})

    catch_discover_tests(example_tests)
endif ()
