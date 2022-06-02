#include "fmt/core.h"

int main()
{
#ifdef __cplusplus
    fmt::print("__cplusplus: {}\n", __cplusplus);
#endif

#ifdef _MSC_VER
    fmt::print("_MSC_VER: {}\n", _MSC_VER);
#endif

#if defined(__clang_version__)
    fmt::print("__clang_version__: {}\n", __clang_version__);
#endif

#if defined(__GNUC__) && !defined(__clang_version__)
    fmt::print("__GNUC__: {}\n", __GNUC__);
#endif

#ifdef _LIBCPP_VERSION
    fmt::print("_LIBCPP_VERSION: {}\n", _LIBCPP_VERSION);
#endif

#ifdef _GLIBCXX_RELEASE
    fmt::print("_GLIBCXX_RELEASE: {}\n", _GLIBCXX_RELEASE);
#endif
}
