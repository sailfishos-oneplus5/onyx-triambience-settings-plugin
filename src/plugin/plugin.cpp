#include <QtGlobal>
#include <QtQml>
#include <QQmlEngine>
#include <QQmlExtensionPlugin>
#include <QTranslator>
#include "settingsui.h"

class Translator : public QTranslator
{
public:
    Translator(QObject *parent)
        : QTranslator(parent)
    {
        qApp->installTranslator(this);
    }

    ~Translator()
    {
        qApp->removeTranslator(this);
    }
};

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
        Q_ASSERT(uri == QLatin1String("com.kimmoli.onyxtriambiencesettings"));

        Translator *engineeringEnglish = new Translator(engine);
        if (!engineeringEnglish->load("onyx-triambience-settings_eng_en", "/usr/share/translations"))
            qWarning() << "failed loading translator" << "onyx-triambience-settings_eng_en";

        Translator *translator = new Translator(engine);
        if (!translator->load(QLocale(), "onyx-triambience-settings", "-", "/usr/share/translations"))
            qWarning() << "failed loading translator" << "onyx-triambience-settings" << QLocale();

        QQmlExtensionPlugin::initializeEngine(engine, uri);
    }
};

#include "plugin.moc"
