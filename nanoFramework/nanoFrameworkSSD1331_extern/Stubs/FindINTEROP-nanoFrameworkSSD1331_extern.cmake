#
# Copyright(c) 2018 The nanoFramework project contributors
# See LICENSE file in the project root for full license information.
#


#################################################################################################
# make sure that a valid path is set bellow                                                     #
# if this is for a class library it's OK to leave it as it is                                   #
# if this is an Interop module the path has to be set where the build can find the source files #
#################################################################################################

# native code directory
set(BASE_PATH_FOR_THIS_MODULE "${BASE_PATH_FOR_CLASS_LIBRARIES_MODULES}/InteropAssemblies/nanoFrameworkSSD1331_extern")


# set include directories
list(APPEND nanoFrameworkSSD1331_extern_INCLUDE_DIRS "${PROJECT_SOURCE_DIR}/src/CLR/Core")
list(APPEND nanoFrameworkSSD1331_extern_INCLUDE_DIRS "${PROJECT_SOURCE_DIR}/src/CLR/Include")
list(APPEND nanoFrameworkSSD1331_extern_INCLUDE_DIRS "${PROJECT_SOURCE_DIR}/src/HAL/Include")
list(APPEND nanoFrameworkSSD1331_extern_INCLUDE_DIRS "${PROJECT_SOURCE_DIR}/src/PAL/Include")
list(APPEND nanoFrameworkSSD1331_extern_INCLUDE_DIRS "${BASE_PATH_FOR_THIS_MODULE}")

# source files
set(nanoFrameworkSSD1331_extern_SRCS

    nanoFrameworkSSD1331_extern.cpp
    nanoFrameworkSSD1331_extern_nanoFrameworkSSD1331_extern_Math_mshl.cpp
    nanoFrameworkSSD1331_extern_nanoFrameworkSSD1331_extern_Math.cpp
    nanoFrameworkSSD1331_extern_nanoFrameworkSSD1331_extern_Utilities_mshl.cpp
    nanoFrameworkSSD1331_extern_nanoFrameworkSSD1331_extern_Utilities.cpp

)

foreach(SRC_FILE ${nanoFrameworkSSD1331_extern_SRCS})
    set(nanoFrameworkSSD1331_extern_SRC_FILE SRC_FILE-NOTFOUND)
    find_file(nanoFrameworkSSD1331_extern_SRC_FILE ${SRC_FILE}
	    PATHS
	        "${BASE_PATH_FOR_THIS_MODULE}"
	        "${TARGET_BASE_LOCATION}"

	    CMAKE_FIND_ROOT_PATH_BOTH
    )
# message("${SRC_FILE} >> ${nanoFrameworkSSD1331_extern_SRC_FILE}") # debug helper
list(APPEND nanoFrameworkSSD1331_extern_SOURCES ${nanoFrameworkSSD1331_extern_SRC_FILE})
endforeach()

include(FindPackageHandleStandardArgs)

FIND_PACKAGE_HANDLE_STANDARD_ARGS(nanoFrameworkSSD1331_extern DEFAULT_MSG nanoFrameworkSSD1331_extern_INCLUDE_DIRS nanoFrameworkSSD1331_extern_SOURCES)

