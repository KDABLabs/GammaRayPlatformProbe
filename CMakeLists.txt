project(GammaRayAndroidPlatformProbe)

cmake_minimum_required(VERSION 3.5)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

include(FeatureSummary)

find_package(GammaRay 2.11.50 REQUIRED NO_MODULE)
set_package_properties(GammaRay PROPERTIES
    TYPE REQUIRED
    URL "http://www.kdab.com/gammaray"
    DESCRIPTION "Qt introspection tool"
    PURPOSE "Needed to build Android GammaRay plug-in."
)

find_package(Qt5 REQUIRED COMPONENTS
    Bluetooth
    Quick
    Positioning
    Sensors
)
if (ANDROID)
    find_package(Qt5AndroidExtras REQUIRED)
endif()

add_subdirectory(app)

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)
