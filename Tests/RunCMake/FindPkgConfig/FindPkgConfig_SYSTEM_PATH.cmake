find_package(PkgConfig REQUIRED)

set(ROOT "${CMAKE_CURRENT_BINARY_DIR}/root")
string(REPLACE " " "\\ " ESCAPED_ROOT "${ROOT}")
set(LIB_DIR "${ROOT}/lib")
set(INCLUDE_DIR "${ROOT}/include")
set(PKGCONFIG_DIR "${LIB_DIR}/pkgconfig")

file(WRITE "${PKGCONFIG_DIR}/zot.pc" "
prefix=${ESCAPED_ROOT}
libdir=\${prefix}/lib
includedir=\${prefix}/include

Name: Zot
Description: Dummy package to test LIBRARY_DIR support
Version: 1.0
Libs: -L\${libdir} -lzot
Cflags: -I\${includedir}
")

# Create a "library" file to find in libdir.
set(CMAKE_FIND_LIBRARY_PREFIXES "prefix-")
set(CMAKE_FIND_LIBRARY_SUFFIXES "-suffix")
file(WRITE "${LIB_DIR}/prefix-zot-suffix")

# 'pkg-config --libs' drops -L flags in PKG_CONFIG_SYSTEM_LIBRARY_PATH by default.
set(ENV{PKG_CONFIG_SYSTEM_LIBRARY_PATH} "${LIB_DIR}")
# 'pkg-config --cflags' drops -I flags in PKG_CONFIG_SYSTEM_INCLUDE_PATH by default.
set(ENV{PKG_CONFIG_SYSTEM_INCLUDE_PATH} "${INCLUDE_DIR}")

# 'pkgconf --libs' also drops -L flags in LIBRARY_PATH by default.
set(ENV{LIBRARY_PATH}                   "${LIB_DIR}")
# 'pkgconf --cflags' also drops -I flags in CPATH by default.
set(ENV{CPATH}                          "${INCLUDE_DIR}")

set(ENV{PKG_CONFIG_PATH}                "${PKGCONFIG_DIR}")
pkg_check_modules(ZOT REQUIRED zot)

message(STATUS "ZOT_LIBRARIES='${ZOT_LIBRARIES}'")
message(STATUS "ZOT_LINK_LIBRARIES='${ZOT_LINK_LIBRARIES}'")
message(STATUS "ZOT_LDFLAGS='${ZOT_LDFLAGS}'")
message(STATUS "ZOT_CFLAGS='${ZOT_CFLAGS}'")
