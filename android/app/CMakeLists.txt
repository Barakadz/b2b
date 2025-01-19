cmake_minimum_required(VERSION 3.4.1)

set(can_use_assembler TRUE)
enable_language(ASM)

#Set flags to detect arm32 bit or arm64 bit for switching between elf structures
if(${ANDROID_ABI} STREQUAL "armeabi-v7a" OR ${ANDROID_ABI} STREQUAL "x86")
    add_definitions("-D_32_BIT")
elseif(${ANDROID_ABI} STREQUAL "arm64-v8a" OR ${ANDROID_ABI} STREQUAL "x86_64")
    add_definitions("-D_64_BIT")
endif()

#Add files
file(GLOB SOURCES "src/main/cpp/*.*")
add_library(globale SHARED ${SOURCES})

#find_library(log-lib log)
target_link_libraries(globale log android)