cmake_minimum_required(VERSION 3.7)

PROJECT("libgmp")

INCLUDE(ExternalProject)

SET(VERSION_EXTERNAL "6.2.1")
SET(PYTHON_EXECUTABLE "${Python3_EXECUTABLE}")


#----------------------------------------------------------------------------
#
# Build the project.
#

IF(${CMAKE_CROSSCOMPILING})
	IF("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
		# Get the prefix of the compiler.
		GET_FILENAME_COMPONENT(GCC_BASENAME ${CMAKE_C_COMPILER} NAME)
		IF(${GCC_BASENAME} MATCHES "([^-]+-[^-]+-[^-]+)-gcc")
			SET(CONFIGURE_HOST "--host=${CMAKE_MATCH_1}")
		ELSE(${GCC_BASENAME} MATCHES "([^-]+-[^-]+-[^-]+)-gcc")
			MESSAGE(FATAL_ERROR "Failed to extract the compiler prefix from the C compiler ${CMAKE_C_COMPILER}")
		ENDIF(${GCC_BASENAME} MATCHES "([^-]+-[^-]+-[^-]+)-gcc")
	ELSE("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
		MESSAGE(FATAL_ERROR "Cross compiling detected, but not using GCC. This is currently not supported by the CMake wrapper for OpenSSL.")
	ENDIF("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
ELSE(${CMAKE_CROSSCOMPILING})
	SET(CONFIGURE_HOST "")
ENDIF(${CMAKE_CROSSCOMPILING})

ExternalProject_Add(TARGET_libgmp
                    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/libgmp
                    URL ${CMAKE_CURRENT_SOURCE_DIR}/gmp-6.2.1.tar.xz
                    URL_HASH SHA1=0578d48607ec0e272177d175fd1807c30b00fdf2
                    CONFIGURE_COMMAND ${CMAKE_CURRENT_BINARY_DIR}/libgmp/src/TARGET_libgmp/configure --prefix=${CMAKE_BINARY_DIR}/install --enable-static=yes --enable-shared=no --enable-fat --with-pic --host=${CONFIGURE_HOST}
                    BUILD_COMMAND make
                    INSTALL_COMMAND make install
)

#SET(LIBGMP_PREFIX       ${CMAKE_BINARY_DIR}/install       CACHE INTERNAL "The complete path to the libgmp installation.")
#SET(LIBGMP_LIBRARY      gmp                               CACHE INTERNAL "The complete path to the libgmp library.")
#SET(LIBGMP_INCLUDE_DIR  ${LIBGMP_PREFIX}/include          CACHE INTERNAL "The include folder for the libgmp library.")
#SET(LIBGMP_LIB_DIR      ${LIBGMP_PREFIX}/lib              CACHE INTERNAL "The complete path to the libgmp library.")


# Create a package.
SET(CPACK_OUTPUT_FILE_PREFIX ${CMAKE_BINARY_DIR}/../repository/org/gmplib-gmp/${VERSION_EXTERNAL})
SET(CPACK_INCLUDE_TOPLEVEL_DIRECTORY FALSE)
SET(CPACK_GENERATOR "TXZ")

INSTALL(FILES ${CMAKE_BINARY_DIR}/install/lib/libgmp.a
        TYPE LIB)
INSTALL(DIRECTORY ${CMAKE_BINARY_DIR}/install/include/
        DESTINATION include)


CONFIGURE_FILE(installer/install.lua 
				${CMAKE_CURRENT_BINARY_DIR}/package/install.lua
				@ONLY)

INSTALL (FILES ${CMAKE_CURRENT_BINARY_DIR}/package/install.lua
		DESTINATION .)

CONFIGURE_FILE(installer/libgmp.xml
				${CPACK_OUTPUT_FILE_PREFIX}/libgmp-${VERSION_EXTERNAL}-${JONCHKI_PLATFORM}.xml
				@ONLY)

SET(CPACK_PACKAGE_FILE_NAME "libgmp-${VERSION_EXTERNAL}-${JONCHKI_PLATFORM}")

INCLUDE(CPack)
