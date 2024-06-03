cmake_minimum_required(VERSION 3.4...3.28 FATAL_ERROR)

project(LOpenGL CXX C)


set(SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src/helloTriangle)
set(sources ${SOURCE_DIR}/main.cpp)

add_executable(lopengl ${sources} ${includes})

include(FetchContent)

FetchContent_Declare(
    glfw
    GIT_REPOSITORY https://github.com/glfw/glfw
    GIT_TAG 3.4
)

FetchContent_MakeAvailable(glfw)

set(GLFW_BUILD_EXAMPLES     OFF CACHE BOOL "Build Examples" FORCE)
set(GLFW_BUILD_TESTS        OFF CACHE BOOL "Build tests" FORCE)
set(GLFW_BUILD_DOCS         OFF CACHE BOOL "Build docs" FORCE)
set(GLFW_INSTALL            OFF CACHE BOOL "Configure an install" FORCE)
set(GLFW_BUILD_WAYLAND      ON  CACHE BOOL "Use Wayland" FORCE)
set(GLFW_BUILD_X11          OFF  CACHE BOOL "Don't Use X11" FORCE)

target_link_libraries(lopengl PRIVATE glfw)
add_dependencies(lopengl glfw)

FetchContent_Declare(
    glad
    GIT_REPOSITORY https://github.com/Dav1dde/glad
    GIT_TAG v2.0.6
    SOURCE_SUBDIR cmake
)

FetchContent_MakeAvailable(glad)
glad_add_library(glad STATIC API gl:core=4.6)
target_link_libraries(lopengl PRIVATE glad)
add_dependencies(lopengl glad)


find_package(OpenGL REQUIRED)
if(OpenGL_FOUND)
    target_include_directories(lopengl PRIVATE ${OPENGL_INCLUDE_DIRS})
    target_link_libraries(lopengl PRIVATE ${OPENGL_LIBRARIES})
else()
    message(FATAL_ERROR "OpenGL Could Not Be Found!")
endif()

set_target_properties(
    lopengl PROPERTIES
    CXX_STANDARD 20
    CXX_STANDARD_REQUIRED YES
)

set_target_properties(lopengl PROPERTIES FOLDER ${PROJECT_NAME})
