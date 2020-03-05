#include <iostream>

int main()
{
#ifdef __cplusplus
    std::cout << "__cplusplus: " << __cplusplus << '\n';
#endif

#ifdef _MSC_VER
    std::cout << "_MSC_VER: " << _MSC_VER << '\n';
#endif

#if defined(__clang_version__)
    std::cout << "__clang_version__: " << __clang_version__ << '\n';
#endif

#if defined(__GNUC__) && !defined(__clang_version__)
    std::cout << "__GNUC__: " << __GNUC__ << '\n';
#endif

#ifdef _LIBCPP_VERSION
    std::cout << "_LIBCPP_VERSION: " << _LIBCPP_VERSION << '\n';
#endif

#ifdef _GLIBCXX_RELEASE
    std::cout << "_GLIBCXX_RELEASE: " << _GLIBCXX_RELEASE << '\n';
#endif
}
