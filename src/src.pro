TEMPLATE = lib
TARGET = onyxtriambiencesettings-qt5
CONFIG += qt hide_symbols 
QT += dbus qml quick
QT -= gui

SOURCES += \
    settingsui.cpp

HEADERS += \
    settingsui.h \
    ImageProvider.h

target.path = $$[QT_INSTALL_LIBS]

INSTALLS += target
