include(check_compiler)

function(TARGET_ADD_SANITIZERS target)
  set(use_sanitizers true CACHE BOOL "Use sanitizers if available (requires libubsan for gcc)")
  if (use_sanitizers)
    check_compiler()
    if (is_clang)
      target_compile_options("${target}" PRIVATE
        $<$<CONFIG:Debug>:-fsanitize=address>
        $<$<CONFIG:Debug>:-fsanitize=undefined>
        $<$<CONFIG:Debug>:-fsanitize=integer>
        $<$<CONFIG:Debug>:-fno-omit-frame-pointer>
        $<$<CONFIG:Debug>:-fno-optimize-sibling-calls>)
      target_link_libraries("${target}" PRIVATE
        $<$<CONFIG:Debug>:-fsanitize=address>)
    elseif(is_gcc)
      target_compile_options("${target}" PRIVATE
        $<$<CONFIG:Debug>:-fsanitize=address>
        $<$<CONFIG:Debug>:-fsanitize=undefined>
        $<$<CONFIG:Debug>:-fno-omit-frame-pointer>
        $<$<CONFIG:Debug>:-fno-optimize-sibling-calls>)
      target_link_libraries("${target}" PRIVATE
        $<$<CONFIG:Debug>:-lubsan>)
    endif()
  endif()
endfunction()
