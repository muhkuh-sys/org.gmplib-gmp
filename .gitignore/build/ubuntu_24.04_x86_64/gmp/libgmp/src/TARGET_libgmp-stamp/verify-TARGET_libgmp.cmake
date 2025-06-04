# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

if("/home/dungtran/Dokumente/work/org.gmplib-gmp/gmp/gmp-6.2.1.tar.xz" STREQUAL "")
  message(FATAL_ERROR "LOCAL can't be empty")
endif()

if(NOT EXISTS "/home/dungtran/Dokumente/work/org.gmplib-gmp/gmp/gmp-6.2.1.tar.xz")
  message(FATAL_ERROR "File not found: /home/dungtran/Dokumente/work/org.gmplib-gmp/gmp/gmp-6.2.1.tar.xz")
endif()

if("SHA1" STREQUAL "")
  message(WARNING "File will not be verified since no URL_HASH specified")
  return()
endif()

if("0578d48607ec0e272177d175fd1807c30b00fdf2" STREQUAL "")
  message(FATAL_ERROR "EXPECT_VALUE can't be empty")
endif()

message(STATUS "verifying file...
     file='/home/dungtran/Dokumente/work/org.gmplib-gmp/gmp/gmp-6.2.1.tar.xz'")

file("SHA1" "/home/dungtran/Dokumente/work/org.gmplib-gmp/gmp/gmp-6.2.1.tar.xz" actual_value)

if(NOT "${actual_value}" STREQUAL "0578d48607ec0e272177d175fd1807c30b00fdf2")
  message(FATAL_ERROR "error: SHA1 hash of
  /home/dungtran/Dokumente/work/org.gmplib-gmp/gmp/gmp-6.2.1.tar.xz
does not match expected value
  expected: '0578d48607ec0e272177d175fd1807c30b00fdf2'
    actual: '${actual_value}'
")
endif()

message(STATUS "verifying file... done")
