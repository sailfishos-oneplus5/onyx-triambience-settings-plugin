#include <QtGlobal>
#include <QtQml>
#include <QQmlEngine>
#include <QQmlExtensionPlugin>
#include "settingsui.h"

class Q_DECL_EXPORT OnyxTriambienceSettingsPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
#if QT_VERSION >= QT_VERSION_CHECK(5, 0, 0)
    Q_PLUGIN_METADATA(IID "com.kimmoli.onyxtriambiencesettings")
#endif
public:
    OnyxTriambienceSettingsPlugin()
    {
    }

    virtual ~OnyxTriambienceSettingsPlugin()
    {
    }

    void registerTypes(const char *uri)
    {
        Q_ASSERT(uri == QLatin1String("com.kimmoli.onyxtriambiencesettings"));
    }
};

#include "plugin.moc"
