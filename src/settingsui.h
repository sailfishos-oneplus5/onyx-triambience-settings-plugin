#ifndef SETTINGSUI_H
#define SETTINGSUI_H

#include <QObject>
#include <QVariantList>
#include <QMap>


class Q_DECL_EXPORT SettingsUi : public QObject
{
    Q_OBJECT

public:
    explicit SettingsUi(QObject *parent = 0);
    virtual ~SettingsUi();

    Q_INVOKABLE QVariantList getAmbiences();
};

#endif // SETTINGSUI_H
