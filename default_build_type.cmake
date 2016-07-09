# This should be called *before* the project command
function(DEFAULT_BUILD_TYPE default)
  if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(STATUS "Setting build type to '${default}' as none was specified")
    set(CMAKE_BUILD_TYPE "${default}" CACHE STRING "Choose a build type")
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
  endif()
endfunction()
