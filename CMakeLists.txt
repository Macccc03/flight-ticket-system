cmake_minimum_required(VERSION 3.16)

project(Flight-ticket-system VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Network)
qt_standard_project_setup(REQUIRES 6.8)

set(SOURCES main.cpp)

qt_add_executable(appFlightTicketSystem ${SOURCES})

# 配置 FluentUI 路径（QML 模块路径 + 插件库路径）
set(FluentUI_QML_PATH "C:/Qt/6.9.0/6.9.3/msvc2022_64/qml" CACHE STRING "FluentUI QML模块路径")
set(FluentUI_LIB_PATH "C:/Qt/6.9.0/6.9.3/msvc2022_64/qml/FluentUI" CACHE STRING "FluentUI 插件库路径")  # 插件库所在目录

# QML 导入路径（项目根目录 + FluentUI QML路径）
set(QML_IMPORT_PATH
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${FluentUI_QML_PATH}
    CACHE STRING "" FORCE
)

# QML 模块配置（URI 匹配项目名）
qt_add_qml_module(appFlightTicketSystem
    URI Flight-ticket-system
    VERSION 1.0
    QML_FILES Main.qml
    RESOURCE_PREFIX "/qt/qml"
)

# 关键1：添加插件库搜索路径（告诉链接器去哪里找 fluentuiplugind.lib）
target_link_directories(appFlightTicketSystem
    PRIVATE ${FluentUI_LIB_PATH}
)

# 关键2：链接 Debug 版本的 FluentUI 插件库（带 d 后缀）
target_link_libraries(appFlightTicketSystem
    PRIVATE Qt6::Quick Qt6::Network
    PRIVATE fluentuiplugind  # Debug 版插件库（Release 版为 fluentuiplugin）
)

set_target_properties(appFlightTicketSystem PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS appFlightTicketSystem
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
