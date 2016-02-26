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

            Image
            {
                source: "image://wallpapers" + ambiences.getByName(ambience_top.value).wallpaper + "?" + width + "?" + height
                width: flick.width ? Math.min(flick.width, screen.sizeCategory > Screen.Medium ? Screen.width*0.7 : Screen.width) : Screen.width
                height: Theme.itemSizeHuge
                fillMode: Image.PreserveAspectCrop
                asynchronous: true

                BusyIndicator
                {
                    size: BusyIndicatorSize.Medium
                    anchors.centerIn: parent
                    running: parent.status != Image.Ready
                    visible: running
                }

                Label
                {
                    text: "Top"
                    font.pixelSize: Theme.fontSizeLarge
                    color: ambiences.getByName(ambience_top.value).highlightColor
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.margins: Theme.paddingMedium
                }
                Label
                {
                    text: ambiences.getByName(ambience_top.value).displayName
                    font.pixelSize: Theme.fontSizeLarge
                    color: ambiences.getByName(ambience_top.value).highlightColor
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.margins: Theme.paddingMedium
                }
                BackgroundItem
                {
                    anchors.fill: parent
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
                }
            }

            Image
            {
                source: "image://wallpapers" + ambiences.getByName(ambience_middle.value).wallpaper + "?" + width + "?" + height
                width: flick.width ? Math.min(flick.width, screen.sizeCategory > Screen.Medium ? Screen.width*0.7 : Screen.width) : Screen.width
                height: Theme.itemSizeHuge
                fillMode: Image.PreserveAspectCrop
                asynchronous: true

                BusyIndicator
                {
                    size: BusyIndicatorSize.Medium
                    anchors.centerIn: parent
                    running: parent.status != Image.Ready
                    visible: running
                }

                Label
                {
                    text: "Middle"
                    font.pixelSize: Theme.fontSizeLarge
                    color: ambiences.getByName(ambience_middle.value).highlightColor
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.margins: Theme.paddingMedium
                }
                Label
                {
                    text: ambiences.getByName(ambience_middle.value).displayName
                    font.pixelSize: Theme.fontSizeLarge
                    color: ambiences.getByName(ambience_middle.value).highlightColor
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.margins: Theme.paddingMedium
                }
                BackgroundItem
                {
                    anchors.fill: parent
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
                }
            }

            Image
            {
                source: "image://wallpapers" + ambiences.getByName(ambience_bottom.value).wallpaper + "?" + width + "?" + height
                width: flick.width ? Math.min(flick.width, screen.sizeCategory > Screen.Medium ? Screen.width*0.7 : Screen.width) : Screen.width
                height: Theme.itemSizeHuge
                fillMode: Image.PreserveAspectCrop
                asynchronous: true

                BusyIndicator
                {
                    size: BusyIndicatorSize.Medium
                    anchors.centerIn: parent
                    running: parent.status != Image.Ready
                    visible: running
                }

                Label
                {
                    text: "Bottom"
                    font.pixelSize: Theme.fontSizeLarge
                    color: ambiences.getByName(ambience_bottom.value).highlightColor
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.margins: Theme.paddingMedium
                }
                Label
                {
                    text: ambiences.getByName(ambience_bottom.value).displayName
                    font.pixelSize: Theme.fontSizeLarge
                    color: ambiences.getByName(ambience_bottom.value).highlightColor
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.margins: Theme.paddingMedium
                }
                BackgroundItem
                {
                    anchors.fill: parent
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

