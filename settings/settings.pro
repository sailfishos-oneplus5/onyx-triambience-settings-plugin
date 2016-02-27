TEMPLATE = aux

entries.path = /usr/share/jolla-settings/entries
entries.files = onyx-triambience-settings.json

pages.path = /usr/share/jolla-settings/pages/onyx-triambience-settings
pages.files = settings.qml Selector.qml AmbienceImage.qml

OTHER_FILES += \
    onyx-triambience-settings.json \
    settings.qml \
    Selector.qml \
    AmbienceImage.qml
    
INSTALLS = entries pages
    
