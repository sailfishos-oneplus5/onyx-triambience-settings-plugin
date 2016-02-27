TEMPLATE = aux

entries.path = /usr/share/jolla-settings/entries
entries.files = onyx-triambience-settings.json

pages.path = /usr/share/jolla-settings/pages/onyx-triambience-settings
pages.files = settings.qml Selector.qml AmbienceImage.qml

translations.path = /usr/share/translations
translations.files = i18n/*.qm

# system(lupdate . -ts $$PWD/i18n/onyx-triambience-settings_eng_en.ts)
system(lrelease -idbased $$PWD/i18n/*.ts)

OTHER_FILES += \
    onyx-triambience-settings.json \
    settings.qml \
    Selector.qml \
    AmbienceImage.qml \
    i18n/*.ts

TRANSLATIONS += i18n/*.ts
    
INSTALLS = entries pages translations
