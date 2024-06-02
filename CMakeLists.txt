cmake_minimum_required(VERSION 3.11 FATAL_ERROR)

project(opengl CXX)


set(GLAD_OUT_DIR        "${CMAKE_CURRENT_BINARY_DIR}" CACHE STRING "Output directory" FORCE)
set(GLAD_PROFILE        "core" CACHE STRING "OpenGL profile" FORCE)
set(GLAD_API            "gl=3.3" CACHE STRING "API type/version pairs, like \"gl=3.2,gles=\", no version means latest" FORCE)
set(GLAD_GENERATOR      "c" CACHE STRING "Language to generate the binding for" FORCE)
set(GLAD_EXTENSIONS     "" CACHE STRING "Path to extensions file or comma separated list of extensions, if missing all extensions are included" FORCE)
set(GLAD_SPEC           "gl" CACHE STRING "Name of the spec" FORCE)
set(GLAD_ALL_EXTENSIONS OFF CACHE BOOL "Include all extensions instead of those specified by GLAD_EXTENSIONS" FORCE)
set(GLAD_NO_LOADER      OFF CACHE BOOL "No loader" FORCE)
set(GLAD_REPRODUCIBLE   OFF CACHE BOOL "Reproducible build" FORCE)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)


set(SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src/helloTriangle)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
set(CMAKE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

set(sources ${SOURCE_DIR}/main.cpp)

# includes not defined ? 
add_executable(opengl ${sources} ${includes})

include(${CMAKE_DIR}/LinkGLFW.cmake)
LinkGLFW(opengl PRIVATE)

include(${CMAKE_DIR}/LinkGLAD.cmake)
LinkGLAD(opengl PRIVATE)


find_package(OpenGL REQUIRED)
if(OpenGL_FOUND)
    target_include_directories(opengl PRIVATE ${OPENGL_INCLUDE_DIRS})
    target_link_libraries(opengl PRICATE ${OPENGL_LIBRARIES})
else()
    message(FATAL_ERROR "OpenGL Could Not Be Found!")

set_target_properties(
    opengl PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED YES
    CXX_EXTENSIONS NO
)

set_target_properties(opengl PROPERTIES FOLDER ${PROJECT_NAME})
