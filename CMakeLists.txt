cmake_minimum_required(VERSION 3.22)

project(my_project)

add_executable(${PROJECT_NAME} src/main.c)

add_library(my_lib STATIC my_lib.cpp)





