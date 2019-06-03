############################### RPATH #########################################

# MAC OS
if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
   # Use, i.e. don't skip the full RPATH for the build tree
   SET(CMAKE_SKIP_BUILD_RPATH  FALSE)

   # When building, don't use the install RPATH already
   # (but later on when installing)
   SET(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)

   #SET(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")

   # add the automatically determined parts of the RPATH
   # which point to directories outside the build tree to the install RPATH
   SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
endif()

###############################################################################
