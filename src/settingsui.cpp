#include "settingsui.h"
#include <QVariantMap>
#include <QVariantList>
#include <QDebug>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QStandardPaths>

SettingsUi::SettingsUi(QObject *parent) :
    QObject(parent)
{
}

QVariantList SettingsUi::getAmbiences()
{
    QVariantList tmp;
    QVariantMap map;
    QSqlDatabase* db;
    QSqlQuery query;

    db = new QSqlDatabase(QSqlDatabase::addDatabase("QSQLITE"));
    db->setDatabaseName(QStandardPaths::writableLocation(QStandardPaths::GenericDataLocation) + "/system/privileged/Ambienced/ambienced.sqlite");

    if (!db->open())
    {
        qDebug() << "Error opening ambienced db:" << db->lastError().text();
        return tmp;
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
            tmp.append(map);
        }
    }

    /* Add file info
     *
     * directoryId
     * displayName
     * filename
     */

    int i;

    for (i=0 ; i < tmp.size() ; i++)
    {
        QVariantMap eMap = tmp.at(i).value<QVariantMap>();
        tmp.removeAt(i);

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
        tmp.insert(i, eMap);
    }

    /* Get file path from directory table */

    for (i=0 ; i<tmp.size(); i++)
    {
        QVariantMap eMap = tmp.at(i).value<QVariantMap>();
        tmp.removeAt(i);

        query = QSqlQuery(QString("SELECT * FROM directory WHERE id=%1").arg(eMap.value("dirId").toInt()), *db);
        if (query.exec())
        {
            while (query.next())
            {
                eMap.insert("filepath", query.record().value("path").toString() + "/" + eMap.value("name").toString());
            }
        }
        tmp.insert(i, eMap);
    }

    db->close();
    
    qDebug() << "Found" << tmp.size() << "ambiences.";
    
    return tmp;
}

SettingsUi::~SettingsUi()
{
}
