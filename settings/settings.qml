import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.configuration 1.0
import com.kimmoli.onyxtriambiencesettings 1.0

Page
{
    id: page

    ListModel
    {
        id: ambiences

        function getByName(name)
        {
            for (var i=0 ; i < ambiences.count ; i++)
            {
                var n = ambiences.get(i).name
                if (name === n)
                    return ambiences.get(i)
            }
            return 0;
        }
    }

    TriambienceSettings
    {
        Component.onCompleted:
        {
            var a = getAmbiences()
            for (var i=0 ; i < a.length ; i++)
            {
                ambiences.append({ name: a[i]["name"],
                                   displayName: a[i]["displayName"],
                                   wallpaper: a[i]["wallpaper"],
                                   highlightColor: a[i]["highlightColor"]})
            }
        }
    }

    SilicaFlickable
    {
        id: flick
        anchors.fill: parent

        contentHeight: column.height

        Column
        {
            id: column

            width: page.width

            PageHeader
            {
                title: "Tristate ambience selector"
            }

            AmbienceImage
            {
                source: "image://wallpapers" + ambiences.getByName(ambience_top.value).wallpaper + "?" + width + "?" + height
                ambienceName: ambiences.getByName(ambience_top.value).displayName
                ambienceColor: ambiences.getByName(ambience_top.value).highlightColor
                onClicked:
                {
                    var sel = pageStack.push(Qt.resolvedUrl("Selector.qml"), { ambiences: ambiences,
                                                                               name: ambience_top.value,
                                                                               pageTitle: "Top"})
                    sel.selected.connect(function()
                    {
                        ambience_top.value = sel.name
                    })
                }
                Label
                {
                    text: "Top"
                    font.pixelSize: Theme.fontSizeLarge
                    color: ambiences.getByName(ambience_top.value).highlightColor
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.topMargin: Theme.paddingMedium
                }
            }

            AmbienceImage
            {
                source: "image://wallpapers" + ambiences.getByName(ambience_middle.value).wallpaper + "?" + width + "?" + height
                ambienceName: ambiences.getByName(ambience_middle.value).displayName
                ambienceColor: ambiences.getByName(ambience_middle.value).highlightColor
                onClicked:
                {
                    var sel = pageStack.push(Qt.resolvedUrl("Selector.qml"), { ambiences: ambiences,
                                                                               name: ambience_middle.value,
                                                                               pageTitle: "Middle"})
                    sel.selected.connect(function()
                    {
                        ambience_middle.value = sel.name
                    })
                }
                Label
                {
                    text: "Middle"
                    font.pixelSize: Theme.fontSizeLarge
                    color: ambiences.getByName(ambience_middle.value).highlightColor
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.topMargin: Theme.paddingMedium
                }
            }

            AmbienceImage
            {
                source: "image://wallpapers" + ambiences.getByName(ambience_bottom.value).wallpaper + "?" + width + "?" + height
                ambienceName: ambiences.getByName(ambience_bottom.value).displayName
                ambienceColor: ambiences.getByName(ambience_bottom.value).highlightColor
                onClicked:
                {
                    var sel = pageStack.push(Qt.resolvedUrl("Selector.qml"), { ambiences: ambiences,
                                                                               name: ambience_bottom.value,
                                                                               pageTitle: "Bottom"})
                    sel.selected.connect(function()
                    {
                        ambience_bottom.value = sel.name
                    })
                }
                Label
                {
                    text: "Bottom"
                    font.pixelSize: Theme.fontSizeLarge
                    color: ambiences.getByName(ambience_bottom.value).highlightColor
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.topMargin: Theme.paddingMedium
                }
            }
        }
    }    

    ConfigurationValue
    {
        id: ambience_top
        key: "/apps/onyxtristate/top"
        defaultValue: "silent"
    }
    ConfigurationValue
    {
        id: ambience_middle
        key: "/apps/onyxtristate/middle"
        defaultValue: "sailing"
    }
    ConfigurationValue
    {
        id: ambience_bottom
        key: "/apps/onyxtristate/bottom"
        defaultValue: "origami"
    }
   
}

