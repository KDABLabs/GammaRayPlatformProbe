add_executable(gammaray-platform-probe
    main.cpp
    app.qrc
)

target_link_libraries(gammaray-platform-probe
    Qt5::Gui
    Qt5::Quick
    Qt5::Widgets
    Qt5::AndroidExtras
    gammaray_probe
)
