############################ Common compiler flags #############################
# GCC compatible flags
if(CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES "GNU")
   set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
   set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wextra")

   # Protobuf generated code visibility issue
   set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility=default -fvisibility-inlines-hidden")

   if(CMAKE_SYSTEM_NAME MATCHES "QNX")
   	set(CMAKE_INCLUDE_SYSTEM_FLAG_CXX "-I" CACHE STRING "System includes flag" FORCE)
   else()
   	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wpedantic")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pedantic-errors")
        #set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Werror")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wsign-compare")
   endif()

   # Position independent code
   if(CMAKE_SYSTEM_NAME MATCHES "QNX")
       set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIE")
   else()
       set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")
   endif()
endif()



if (CMAKE_SYSTEM_NAME STREQUAL QNX OR CMAKE_SYSTEM_NAME STREQUAL QNX700)
   string(REPLACE "-Y _gpp" " " CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
endif()

if (CMAKE_SYSTEM_NAME STREQUAL Windows)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /bigobj /MP")
endif()

# C++ standard
set (CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
###############################################################################
