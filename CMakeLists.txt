cmake_minimum_required(VERSION 2.8.12)

project(ford-helper LANGUAGES CXX)
############################ Compiler options #################################
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/compiler_options.cmake)

############################## RPATH ##########################################
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/rpath_config.cmake REQUIRED)

include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/version.cmake)



############################## hmi cofigure modifier #############################
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/hmi_configure.cmake REQUIRED)
if(CMAKE_SYSTEM_NAME STREQUAL Windows)
    set(Qt5_DIR "C:/Qt/Qt5.12.1/5.12.1/msvc2015_64/lib/cmake/Qt5")
    set(CMAKE_INCLUDE_CURRENT_DIR ON)
    set(CMAKE_AUTOMOC ON)
    set(CMAKE_AUTORCC ON)
    find_package(Qt5 COMPONENTS Core Quick REQUIRED)
    find_package(Qt5Core)
    find_package(Qt5Gui)
    find_package(Qt5Qml)
    find_package(Qt5Quick)
    find_package(Qt5Xml)
    find_package(Qt5Sql)


    include_directories("D:/Awork_/ford-kipawa/ford-qt-hmi/fordhal/fordinterfaces")
    include_directories("D:/Awork_/ford-kipawa/ford-qt-hmi/ford/include/HMI_Headers")
    include_directories("D:/Awork_/ford-kipawa/ford-qt-hmi/ford/include/HMI_Headers/inc")
    include_directories("D:/Awork_/ford-kipawa/ford-qt-hmi/ford/include/HMIControls")
    include_directories("D:/Awork_/ford-kipawa/ford-qt-hmi/ford/include")
    include_directories("D:/Awork_/ford-kipawa/ford-qt-hmi/fordhal/inc")
    link_directories("D:/Awork_/ford-kipawa/ford-qt-hmi/fordhal/lib")
    link_directories("D:/Awork_/ford-kipawa/ford-qt-hmi/ford/build_msvc2015_64/release/com/ford/hmicontrols")
    #ink_directories(/home/_Project/LoadFordThemeHelper/fs/os/aarch64le/lib)
    #link_directories(/home/_Project/LoadFordThemeHelper/fs/os/themes/qml/com/ford/hmicontrols)
    link_directories("D:/Awork_/ford-kipawa/ford-qt-hmi/ford/build_msvc2015_64/release")
    link_directories("C:/Qt/Qt5.12.1/5.12.1/msvc2015_64/lib")


    add_executable(${PROJECT_NAME} "main.cpp" "source.qrc"
        "qmlsrc/main.qml"
        "themeloader.h"
        "themeloader.cpp"
        "qmlsrc/main.qml"
        "qmlsrc/HomeForm.qml"
        "qmlsrc/RecentScreenQuickControl.qml"
        "qmlsrc/RecentScreenFHC.qml"
        "qmlsrc/RecentItemDelegate.qml"
        "qmlsrc/InteractiveListDelegate.qml"
        "qmlsrc/ArrowCanvas.qml"
        )

    target_link_libraries(${PROJECT_NAME}
                 HMIControls
                 HMIThemeBundle
                 )

    target_link_libraries(${PROJECT_NAME} Qt5::Core Qt5::Quick)
else()
    #################################-------------QNX-----------###################################################
    ######################################      ######################################
    SET (DEVROOT "/opt/qnx700" CACHE PATH "Location of QNX toolchain")
    SET (TOOLSROOT "${DEVROOT}/host/linux/x86_64")

    set(CMAKE_INCLUDE_CURRENT_DIR ON)
    set(CMAKE_AUTOMOC ON)
    set(CMAKE_AUTORCC ON)
    INCLUDE(CMakeForceCompiler)
    SET (CMAKE_SYSTEM_PROCESSOR armle)
    SET (CMAKE_CROSSCOMPILING 1)

    ####################### Qt paths #o############################################
    set(QTROOT "${DEVROOT}/qt/5.12.1" CACHE PATH "Location of Qt")
    set(CMAKE_PREFIX_PATH ${QTROOT}/lib/cmake)
    set(Qt5_LIBS_RPATH "-Wl,--rpath-link ${QTROOT}/lib")
    set(CMAKE_EXE_LINKER_FLAGS "-Wl,--rpath-link ${QTROOT}/lib" CACHE STRING "Executable linker flags" FORCE)
    ####################### Qt paths #############################################


    CMAKE_FORCE_C_COMPILER( "${TOOLSROOT}/usr/bin/qcc" GNU)
    CMAKE_FORCE_CXX_COMPILER( "${TOOLSROOT}/usr/bin/QCC" GNU)

    SET (CMAKE_C_FLAGS "-V 5.4.0,gcc_ntoaarch64le -O2 -Wc,-fno-strict-aliasing -D__arm64__ -DNDEBUG -M -DTN_PLATFORM_QNX -fPIC" CACHE STRING "gcc c flags" FORCE)
    SET (CMAKE_CXX_FLAGS "-V 5.4.0,gcc_ntoaarch64le -O2 -Wc,-fno-strict-aliasing -D__arm64__  -DNDEBUG -M -DTN_PLATFORM_QNX -DBOOST_CB_DISABLE_DEBUG -fPIC" CACHE STRING "gcc c++ flags" FORCE)
    SET (CMAKE_AR "${TOOLSROOT}/usr/bin/ntoaarch64-ar" CACHE PATH "Location of ar" FORCE)
    SET (CMAKE_RANLIB "${TOOLSROOT}/usr/bin/ntoaarch64-ranlib" CACHE PATH "Location of ranlib" FORCE)

    add_definitions(-D_LITTLE_ENDIAN -DBOOST_CB_DISABLE_DEBUG -DBOOST_CHRONO_HEADER_ONLY -DGTEST_HAS_TR1_TUPLE=0)

    SET (CMAKE_FIND_ROOT_PATH ${TOOLSROOT}/)
    SET (CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
    SET (CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
    SET (CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

    SET($ENV{QNX_HOST} ${TOOLSROOT})
    SET($ENV{QNX_TARGET} ${DEVROOT}/target/qnx7)
    SET($ENV{MAKEFLAGS} -I$ENV{QNX_TARGET}/usr/include)
    SET($ENV{PATH} ${TOOLSROOT}/usr/bin:$ENV{HOME}.qnx/bin:${TOOLSROOT}/jre/bin:$ENV{PATH})
    link_directories(/fs/os/aarch64le/lib)

    #        set(Qt5_DIR "C:/Qt/Qt5.12.1/5.12.1/msvc2015_64/lib/cmake/Qt5")
    #        set(CMAKE_INCLUDE_CURRENT_DIR ON)

    #        find_package(Qt5 COMPONENTS Core Quick REQUIRED)
    find_package(Qt5Core)
    find_package(Qt5Gui)
    find_package(Qt5Qml)
    find_package(Qt5Quick)
    find_package(Qt5Xml)
    find_package(Qt5Sql)

    # Qt libraries
    set(QT5_X_LIBS
        ${Qt5Core_LIBRARIES}
        ${Qt5Gui_LIBRARIES}
        ${Qt5Qml_LIBRARIES}
        ${Qt5Quick_LIBRARIES}
        ${Qt5Xml_LIBRARIES}
        ${Qt5Sql_LIBRARIES}
        )

    include_directories("/home/_Project/ford-kipawa/ford-qt-hmi/fordhal/fordinterfaces")
    include_directories("/home/_Project/ford-kipawa/ford-qt-hmi/ford/include/HMI_Headers")
    include_directories("/home/_Project/ford-kipawa/ford-qt-hmi/ford/include/HMI_Headers/inc")
    include_directories("/home/_Project/ford-kipawa/ford-qt-hmi/ford/include/HMIControls")
    include_directories("/home/_Project/ford-kipawa/ford-qt-hmi/fordhal/inc")
    link_directories("/home/_Project/ford-kipawa/ford-qt-hmi/fordhal/lib")
    link_directories("/home/_Project/ford-kipawa/ford-qt-hmi/ford/build_gcc_64/release/com/ford/hmicontrols")
    link_directories("/home/_Project/LoadFordThemeHelper/fs/os/aarch64le/lib")
    link_directories("/home/_Project/LoadFordThemeHelper/fs/os/themes/qml/com/ford/hmicontrols")
    link_directories("/home/_Project/ford-kipawa/ford-qt-hmi/ford/build_gcc_64/release")
    link_directories("/opt/qnx700/qt/lib")

    add_executable(${PROJECT_NAME} "main.cpp" "source.qrc"
        "qmlsrc/main.qml"
        "themeloader.h"
        "themeloader.cpp"
        "qmlsrc/main.qml"
        "qmlsrc/HomeForm.qml"
        "qmlsrc/RecentScreenQuickControl.qml"
        "qmlsrc/RecentScreenFHC.qml"
        "qmlsrc/RecentItemDelegate.qml"
        "qmlsrc/InteractiveListDelegate.qml"
        "qmlsrc/ArrowCanvas.qml"
        )

        target_link_libraries(${PROJECT_NAME}
            HMIControls
            HMIThemeBundle
            navengine
            hmiservices
            windowmanager
            telemetryidl
            ftcpidl
            telemetry
            fnv_notifications
            NS_Logger
            boost_serialization
            NS_MessageCenter
            NS_SharedMemIf
            NS_MessageQueue
            protobuf
            soaframework
            fdtokenclient
            fnvthread
            analyticsidl
           # ipcitemosquitto
            RCN_DiagnosticsLib
            analytics
            #mosquitto
            jsoncpp
            soaidl
    #	/home/_Project/ford-kipawa/LoadFordThemeHelper/fs/os/libpaho-mqtt3cs.so.1
            NS_CoreUnified
            osssmidl
            servicemanageridl
            RCN_AnalyticsLib
            RCN_DiagnosticsLib
            keyclient
            AudioSoundInterfaceLibrary
            screen
            mq
        )
    target_link_libraries(${PROJECT_NAME} Qt5::Core Qt5::Quick Qt5::Gui Qt5::Qml ${QT5_X_LIBS})


endif()
