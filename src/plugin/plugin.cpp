#include <QtGlobal>
#include <QtQml>
#include <QQmlEngine>
#include <QQmlExtensionPlugin>
#include "settingsui.h"
#include "ImageProvider.h"

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

        qmlRegisterType<SettingsUi>(uri, 1, 0, "TriambienceSettings");
    }

    void initializeEngine(QQmlEngine *engine, const char *uri)
    {
        Q_UNUSED(uri);
        engine->addImageProvider("wallpapers", new ImageProvider);
    }
};

#include "plugin.moc"
