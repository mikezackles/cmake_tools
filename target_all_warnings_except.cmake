function(TARGET_ALL_WARNINGS_EXCEPT target)
  set(compilers CLANG GCC MSVC)
  cmake_parse_arguments(PARSED "" "" "${compilers}" ${ARGN})

  target_compile_options("${target}" PRIVATE
    $<$<OR:$<CXX_COMPILER_ID:AppleClang>,$<CXX_COMPILER_ID:Clang>>:
      -Wall -Weverything -pedantic
      $<$<CONFIG:Debug>:-Werror -ferror-limit=3>
      ${PARSED_CLANG}>
    $<$<CXX_COMPILER_ID:GNU>:
      -Wall -Wextra -Wpedantic
      $<$<CONFIG:Debug>:-Werror -fmax-errors=3>
      ${PARSED_GCC}>
    $<$<CXX_COMPILER_ID:MSVC>:
      /Wall
      $<$<CONFIG:Debug>:/WX>
      ${PARSED_MSVC}>
    )
endfunction()
