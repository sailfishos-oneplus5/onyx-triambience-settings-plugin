#include "settingsui.h"
#include <QDir>
#include <QVariantMap>
#include <QVariantList>
#include <QThread>
#include <QSettings>
#include <QDebug>
#include <QtDBus/QtDBus>
#include <QtAlgorithms>
#include <QFileInfo>
#include <linux/input.h>


SettingsUi::SettingsUi(QObject *parent) :
    QObject(parent)
{
}

QVariantList SettingsUi::getAmbiences()
{
    QVariantList tmp;
    QVariantMap map;

    ambienceFiles.clear();

    QDir selectedDir("/usr/share/ambience/");
    selectedDir.setFilter(QDir::Files | QDir::Dirs | QDir::NoDot | QDir::NoDotDot);
    QStringList filter;
    filter.append("*.ambience");
    selectedDir.setNameFilters(filter);
    findFilesRecursively(selectedDir);

    foreach (QString ambienceFilename, ambienceFiles)
    {
        QFile amb;
        amb.setFileName(ambienceFilename);

        if (!amb.exists() || !amb.open(QFile::ReadOnly | QFile::Text))
        {
            continue;
        }

        QTextStream in(&amb);
        QString ambString = in.readAll();

        if (ambString.isEmpty())
        {
            amb.close();
            continue;
        }

        QJsonDocument ambJson = QJsonDocument::fromJson(ambString.toUtf8());
        QJsonObject ambObject = ambJson.object();

        QFileInfo fi(amb);

        QString displayName = ambObject["displayName"].toString();

        QTranslator translator;
        if (translator.load( QLocale(), ambObject["translationCatalog"].toString(), "-", "/usr/share/translations" ) )
        {
            displayName = translator.translate("", ambObject["displayName"].toString().toLocal8Bit().constData());
        }

        map.clear();
        map.insert("name", fi.baseName());
        map.insert("filepath", fi.absoluteFilePath());
        map.insert("displayName", displayName);
        map.insert("wallpaper", fi.absolutePath() + "/images/" + ambObject["wallpaper"].toString());
        map.insert("highlightColor", ambObject["highlightColor"].toString());
        tmp.append(map);

        amb.close();
    }

    return tmp;
}

void SettingsUi::findFilesRecursively(QDir rootDir)
{
    QDirIterator it(rootDir, QDirIterator::Subdirectories);
    while(it.hasNext())
    {
        ambienceFiles.append(it.next());
    }
}

SettingsUi::~SettingsUi()
{
}
