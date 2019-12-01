TEMPLATE = lib

TARGET = onyxtriambiencesettings-qt5
CONFIG += qt hide_symbols

QT += dbus qml quick sql
QT -= gui

HEADERS += \
    settingsui.h

SOURCES += \
    settingsui.cpp

target.path = $$[QT_INSTALL_LIBS]

INSTALLS += target
