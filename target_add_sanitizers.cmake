function(TARGET_ADD_SANITIZERS target)
  if (CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang" OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    target_compile_options("${target}" PRIVATE
      $<$<CONFIG:Debug>:
        -fsanitize=address
        -fsanitize=undefined
        -fsanitize=integer
        -fno-omit-frame-pointer
        -fno-optimize-sibling-calls>)
    target_link_libraries("${target}" PRIVATE
      $<$<CONFIG:Debug>:-fsanitize=address>)
  endif()
endfunction()
