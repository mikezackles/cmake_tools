include(check_compiler)

function(TARGET_ALL_WARNINGS_EXCEPT target)
  set(compilers CLANG GCC MSVC)
  cmake_parse_arguments(PARSED "" "" "${compilers}" ${ARGN})
  check_compiler()

  if (is_clang)
    target_compile_options("${target}" PRIVATE
      -Wall -Weverything -pedantic
      $<$<CONFIG:Debug>:-Werror>
      $<$<CONFIG:Debug>:-ferror-limit=3>
      ${PARSED_CLANG})
  elseif(is_gcc)
    target_compile_options("${target}" PRIVATE
      -Wconversion -Wall -Wextra -Wpedantic
      $<$<CONFIG:Debug>:-Werror>
      $<$<CONFIG:Debug>:-fmax-errors=3>
      ${PARSED_GCC})
  elseif(is_msvc)
    target_compile_options("${target}" PRIVATE
      /Wall
      $<$<CONFIG:Debug>:/WX>
      ${PARSED_MSVC})
  endif()
endfunction()
