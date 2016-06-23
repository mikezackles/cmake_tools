function(TARGET_ALL_WARNINGS_EXCEPT target)
  set(compilers CLANG GCC MSVC)
  cmake_parse_arguments(PARSED "" "" "${compilers}" ${ARGN})

  if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang" OR "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    set(is_clang TRUE)
  elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    set(is_gcc TRUE)
  elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    set(is_msvc TRUE)
  endif()

  if (NOT is_clang AND NOT is_gcc AND NOT is_msvc)
    message(FATAL_ERROR "Compiler (${CMAKE_CXX_COMPILER_ID}) is not supported")
  endif()

  if (is_clang)
    set(flags -Wall -Weverything -pedantic ${PARSED_CLANG})
  elseif (is_gcc)
    set(flags -Wall -Wextra -Wpedantic ${PARSED_GCC})
  elseif (is_msvc)
    set(flags /Wall ${PARSED_MSVC})
  endif()

  if ("${CMAKE_BUILD_TYPE}" STREQUAL "Release")
  else()
    if (is_clang)
      set(flags ${flags} -Werror -ferror-limit=3)
    elseif (is_gcc)
      set(flags ${flags} -Werror -fmax-errors=3)
    elseif (is_msvc)
      set(flags ${flags} /WX)
    endif()
  endif()

  foreach(flag ${flags})
    set_property(TARGET "${target}" APPEND_STRING PROPERTY COMPILE_FLAGS "${flag} ")
  endforeach()
endfunction()
