# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/dungtran/Dokumente/work/org.gmplib-gmp/build/ubuntu_24.04_x86_64/gmp/libgmp/src/TARGET_libgmp"
  "/home/dungtran/Dokumente/work/org.gmplib-gmp/build/ubuntu_24.04_x86_64/gmp/libgmp/src/TARGET_libgmp-build"
  "/home/dungtran/Dokumente/work/org.gmplib-gmp/build/ubuntu_24.04_x86_64/gmp/libgmp"
  "/home/dungtran/Dokumente/work/org.gmplib-gmp/build/ubuntu_24.04_x86_64/gmp/libgmp/tmp"
  "/home/dungtran/Dokumente/work/org.gmplib-gmp/build/ubuntu_24.04_x86_64/gmp/libgmp/src/TARGET_libgmp-stamp"
  "/home/dungtran/Dokumente/work/org.gmplib-gmp/build/ubuntu_24.04_x86_64/gmp/libgmp/src"
  "/home/dungtran/Dokumente/work/org.gmplib-gmp/build/ubuntu_24.04_x86_64/gmp/libgmp/src/TARGET_libgmp-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/dungtran/Dokumente/work/org.gmplib-gmp/build/ubuntu_24.04_x86_64/gmp/libgmp/src/TARGET_libgmp-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/dungtran/Dokumente/work/org.gmplib-gmp/build/ubuntu_24.04_x86_64/gmp/libgmp/src/TARGET_libgmp-stamp${cfgdir}") # cfgdir has leading slash
endif()
