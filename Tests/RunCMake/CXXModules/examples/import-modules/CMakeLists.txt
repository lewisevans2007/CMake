cmake_minimum_required(VERSION 3.24)
project(cxx_modules_import_interfaces CXX)

include("${CMAKE_SOURCE_DIR}/../cxx-modules-rules.cmake")

if (NO_PROPERTIES)
  set(package_name "export_interfaces_no_properties")
elseif (WITH_BMIS)
  set(package_name "export_bmi_and_interfaces")
else ()
  set(package_name "export_interfaces")
endif ()
set(target_name "CXXModules::${package_name}")

find_package("${package_name}" REQUIRED)

add_executable(use_import_interfaces)
target_sources(use_import_interfaces
  PRIVATE
    use.cxx)
target_compile_features(use_import_interfaces PRIVATE cxx_std_20)
target_link_libraries(use_import_interfaces PRIVATE "${target_name}")

add_test(NAME use_import_interfaces COMMAND use_import_interfaces)
