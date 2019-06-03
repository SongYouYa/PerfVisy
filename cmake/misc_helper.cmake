# Search for Python
find_package(PythonInterp 2.7 REQUIRED)

# Scripts DIR
set(SCRIPTS_DIR ${CMAKE_CURRENT_LIST_DIR}/scripts)

##
# @brief Provides the build type
#
# @param BUILD_TYPE_VAR -> build type variable name
# @usage
#  get_build_type(BUILD_TYPE_VAR)
##
function(get_build_type BUILD_TYPE_VAR)
    set(TMP_BUILD_TYPE "debug")
    # Take build type - if not specified, it is debug by default
    if(CMAKE_BUILD_TYPE)
       string(TOLOWER "${CMAKE_BUILD_TYPE}" TMP_BUILD_TYPE)
    endif()
    set(${BUILD_TYPE_VAR} ${TMP_BUILD_TYPE} PARENT_SCOPE)
endfunction()

##
# @brief States if a string can be considered as an absolute path
#
# @param PATH_CANDIDATE -> Path candidate variable
# @param RET_VAR -> Return variable (TRUE / FALSE )
##
function(is_absolute_path PATH_CANDIDATE RET_VAR)
    if ((PATH_CANDIDATE MATCHES "^/.*") OR (PATH_CANDIDATE MATCHES "^[a-zA-Z]:.*"))
        set(${RET_VAR} TRUE PARENT_SCOPE)
    else()
        set(${RET_VAR} FALSE PARENT_SCOPE)
    endif()
endfunction()

##
# @brief Adds an inplace replacement command to a specified target
#
# @param TARGET_NAME - Target name
# @param FILE_PATH - Source and destination file path
# @param SEARCH_PATTERN - Pattern to search
# @param REPLACEMENT - Replacement
##
function (add_inplace_replace_command TARGET_NAME FILE_PATH SEARCH_PATTERN REPLACEMENT)
    add_custom_command(TARGET ${TARGET_NAME}
        COMMAND python ${SCRIPTS_DIR}/replace_in_file.py ${FILE_PATH} ${SEARCH_PATTERN} ${REPLACEMENT}
     )
endfunction()

##
# @brief Stringify a list
#
# @param A_LIST - The source list
# @param A_PREFIX - A prefix to add before inserting item in the resulting strin
# @param OUT_STRING - Output string
##
function (stringify_list A_LIST A_PREFIX OUT_STRING)
    set(OUT_VAL)
    foreach(item ${A_LIST})
        set(OUT_VAL "${OUT_VAL}${A_PREFIX}${item} ")
    endforeach()
    set(${OUT_STRING} ${OUT_VAL} PARENT_SCOPE)
endfunction()
