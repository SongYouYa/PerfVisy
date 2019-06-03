include(${CMAKE_CURRENT_LIST_DIR}/misc_helper.cmake)

# modify hmi configure
function(deploy_hmi_config LINKING_TARGET SOURCE_PATH DESTINATION_PATH)
    
    set(DEPS_TARGET ${LINKING_TARGET}_deps)
    
    #add_custom_target(${DEPS_TARGET} ALL)
    add_custom_command(TARGET ${DEPS_TARGET}
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${SOURCE_PATH}/ ${DESTINATION_PATH}/hmiconfig/
    )
    
    ## hmisettings.ini
    if(CMAKE_SYSTEM_NAME STREQUAL QNX700 OR CMAKE_SYSTEM_NAME STREQUAL QNX)
        add_inplace_replace_command(${DEPS_TARGET} ${DESTINATION_PATH}/hmiconfig/hmisettings.ini writableLocationPath.* writableLocationPath=/fs/rwdata/telenav)
    else()
        add_inplace_replace_command(${DEPS_TARGET} ${DESTINATION_PATH}/hmiconfig/hmisettings.ini writableLocationPath.* writableLocationPath=)
    endif()

    add_inplace_replace_command(${DEPS_TARGET} ${DESTINATION_PATH}/hmiconfig/hmisettings.ini hmiLoggingFolderName.* hmiLoggingFolderName=navigation-logs)
    add_inplace_replace_command(${DEPS_TARGET} ${DESTINATION_PATH}/hmiconfig/hmisettings.ini qtarpStorageFolerName.* qtarpStorageFolerName=Storage_QTARP)
    
endfunction()
