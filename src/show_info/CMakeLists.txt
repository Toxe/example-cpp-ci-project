add_executable(
        show_info
        main.cpp
)

set_target_properties(show_info PROPERTIES CXX_EXTENSIONS OFF)
target_compile_features(show_info PUBLIC cxx_std_20)
target_compile_options(show_info PRIVATE ${SANITIZER_FLAGS} ${DEFAULT_COMPILER_OPTIONS_AND_WARNINGS})
target_link_libraries(show_info PRIVATE ${SANITIZER_FLAGS} fmt::fmt)
