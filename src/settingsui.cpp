#include <QDebug>
#include <QVariantMap>
#include <QVariantList>
#include <QStandardPaths>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QSqlError>
#include "settingsui.h"


SettingsUi::SettingsUi(QObject *parent) : QObject(parent)
{
    /* Leaving this here for future needs */
}

QVariantList SettingsUi::getAmbiences()
{
    QVariantList ambiences;
    QVariantMap map;
    QSqlDatabase* db;
    QSqlQuery query;

    db = new QSqlDatabase(QSqlDatabase::addDatabase("QSQLITE"));
    db->setDatabaseName(QStandardPaths::writableLocation(QStandardPaths::GenericDataLocation) + "/system/privileged/Ambienced/ambienced.sqlite");

    if (!db->open())
    {
        qDebug() << "Error opening ambienced db:" << db->lastError().text();
        return ambiences;
    }

    /* Collect installed ambiences
     *
     * From this table we get:
     * - fileId
     * - wallpaper - abs path to the wallpaper image
     * - highlightcolor
     */

    query = QSqlQuery("SELECT * FROM ambience", *db);

    if (query.exec())
    {
        while (query.next())
        {
            map.clear();
            map.insert("fileId", query.record().value("fileId").toInt());
            map.insert("wallpaper", query.record().value("homeWallpaper").toString());
            map.insert("highlightColor", query.record().value("highlightColor").toString());
            ambiences.append(map);
        }
    }

    /* Add file info
     *
     * directoryId
     * displayName
     * filename
     */

    int i;

    for (i = 0; i < ambiences.size(); i++)
    {
        QVariantMap eMap = ambiences.at(i).value<QVariantMap>();
        ambiences.removeAt(i);

        query = QSqlQuery(QString("SELECT * FROM file WHERE id=%1").arg(eMap.value("fileId").toInt()), *db);
        if (query.exec())
        {
            while (query.next())
            {
                eMap.insert("dirId", query.record().value("directoryId").toInt());
                eMap.insert("displayName", query.record().value("displayName").toString());
                eMap.insert("name", query.record().value("fileName").toString());
            }
        }
        ambiences.insert(i, eMap);
    }

    /* Get file path from directory table */

    for (i = 0; i < ambiences.size(); i++)
    {
        QVariantMap eMap = ambiences.at(i).value<QVariantMap>();
        ambiences.removeAt(i);

        query = QSqlQuery(QString("SELECT * FROM directory WHERE id=%1").arg(eMap.value("dirId").toInt()), *db);
        if (query.exec())
        {
            while (query.next())
                eMap.insert("filepath", query.record().value("path").toString() + "/" + eMap.value("name").toString());
        }
        ambiences.insert(i, eMap);
    }

    db->close();

    qDebug() << "Found" << ambiences.size() << "ambiences.";

    return ambiences;
}

SettingsUi::~SettingsUi() {  }
