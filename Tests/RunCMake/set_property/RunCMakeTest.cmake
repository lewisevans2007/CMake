include(RunCMake)

run_cmake(COMPILE_DEFINITIONS)
run_cmake(COMPILE_FEATURES)
run_cmake(COMPILE_OPTIONS)
run_cmake(IMPORTED_GLOBAL)
run_cmake(INCLUDE_DIRECTORIES)
run_cmake(LINK_OPTIONS)
run_cmake(LINK_DIRECTORIES)
run_cmake(LINK_LIBRARIES)
run_cmake(SOURCES)
run_cmake(SOURCE_FILE)
run_cmake(TEST-invalid)
run_cmake(TYPE)
run_cmake(USER_PROP)
run_cmake(USER_PROP_INHERITED)

set(RunCMake_TEST_BINARY_DIR "${RunCMake_BINARY_DIR}/TEST-build")
run_cmake(TEST)
set(RunCMake_TEST_NO_CLEAN 1)
run_cmake_command(TEST-test ${CMAKE_CTEST_COMMAND} -C Debug)
