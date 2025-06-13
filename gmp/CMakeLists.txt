cmake_minimum_required(VERSION 3.7)

PROJECT("libgmp")

INCLUDE(ExternalProject)

SET(VERSION_EXTERNAL "6.3.0")
SET(VERSION_PACKAGE  "1")
SET(PROJECT_VERSION  "${VERSION_EXTERNAL}.${VERSION_PACKAGE}")
SET(PYTHON_EXECUTABLE "${Python3_EXECUTABLE}")


#----------------------------------------------------------------------------
#
# Build the project.
#
ExternalProject_Add(TARGET_libgmp
                    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/libgmp
                    URL ${CMAKE_CURRENT_SOURCE_DIR}/gmp-${VERSION_EXTERNAL}.tar.xz
                    URL_HASH SHA1=b4043dd2964ab1a858109da85c44de224384f352
                    CONFIGURE_COMMAND ${CMAKE_CURRENT_BINARY_DIR}/libgmp/src/TARGET_libgmp/configure --prefix=${CMAKE_BINARY_DIR}/install --enable-static=yes --enable-shared=no --enable-fat --with-pic
                    BUILD_COMMAND make
                    INSTALL_COMMAND make install
                    TEST_COMMAND ${CMAKE_SOURCE_DIR}/cmake/tools/fix_pkgconfig.sh ${CMAKE_BINARY_DIR}/install
                    TEST_AFTER_INSTALL 1
)

# Create a package.
SET(CPACK_OUTPUT_FILE_PREFIX ${CMAKE_BINARY_DIR}/../repository/org/gmplib/${PROJECT_VERSION})
SET(CPACK_INCLUDE_TOPLEVEL_DIRECTORY FALSE)
SET(CPACK_GENERATOR "TXZ")

INSTALL(FILES ${CMAKE_BINARY_DIR}/install/lib/libgmp.a
        TYPE LIB)
INSTALL(DIRECTORY ${CMAKE_BINARY_DIR}/install/include/
        DESTINATION include)

INSTALL(FILES ${CMAKE_BINARY_DIR}/install/lib/pkgconfig/gmp.pc
        DESTINATION pkgconfig)

CONFIGURE_FILE(installer/install.lua 
               ${CMAKE_CURRENT_BINARY_DIR}/package/install.lua
               @ONLY)

INSTALL(FILES ${CMAKE_CURRENT_BINARY_DIR}/package/install.lua
        DESTINATION .)

CONFIGURE_FILE(installer/libgmp.xml
               ${CPACK_OUTPUT_FILE_PREFIX}/gmp-${PROJECT_VERSION}-${JONCHKI_PLATFORM}.xml
               @ONLY)

SET(CPACK_PACKAGE_FILE_NAME "gmp-${PROJECT_VERSION}-${JONCHKI_PLATFORM}")

INCLUDE(CPack)


#-----------------------------------------------------------------------------
#
# Create a custom target named "pack".
# It builds the package and creates the hashes.
#
ADD_CUSTOM_TARGET(pack
                  COMMAND ${CMAKE_MAKE_PROGRAM}
                  COMMAND ${CMAKE_MAKE_PROGRAM} package
                  COMMAND "${PYTHON_EXECUTABLE}" ${CMAKE_HOME_DIRECTORY}/cmake/tools/generate_hash.py ${CPACK_OUTPUT_FILE_PREFIX}/gmp-${PROJECT_VERSION}-${JONCHKI_PLATFORM}.xml
                  COMMAND "${PYTHON_EXECUTABLE}" ${CMAKE_HOME_DIRECTORY}/cmake/tools/generate_hash.py ${CPACK_OUTPUT_FILE_PREFIX}/gmp-${PROJECT_VERSION}-${JONCHKI_PLATFORM}.tar.xz
                  COMMENT "Pack the artifact and generate the hashes...")

