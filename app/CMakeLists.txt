add_executable(gammaray-platform-probe
    main.cpp
    app.qrc
)

target_link_libraries(gammaray-platform-probe
    Qt5::Gui
    Qt5::Quick
    Qt5::Widgets
    Qt5::Bluetooth
    Qt5::Positioning
    Qt5::Sensors
    gammaray_probe
)

if (ANDROID)
    target_link_libraries(gammaray-platform-probe Qt5::AndroidExtras)
endif()
