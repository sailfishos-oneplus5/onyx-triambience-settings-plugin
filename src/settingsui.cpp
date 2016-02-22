#include "settingsui.h"
#include <QDir>
#include <QVariantMap>
#include <QVariantList>
#include <QThread>
#include <QSettings>
#include <QDebug>
#include <QtDBus/QtDBus>
#include <QtAlgorithms>
#include <linux/input.h>


SettingsUi::SettingsUi(QObject *parent) :
    QObject(parent)
{
}

SettingsUi::~SettingsUi()
{
}
