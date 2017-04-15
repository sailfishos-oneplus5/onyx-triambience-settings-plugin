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

        function getByName(nameToSearch)
        {
            var name = nameToSearch.split(";")[0]
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
                                   filepath: a[i]["filepath"],
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
                //: page header
                //% "Tristate ambience selector"
                title: qsTrId("onyx-tristate-settings-title")
            }

            SectionHeader
            {
                //% "Top"
                text: qsTrId("onyx-top-position")
            }

            AmbienceImage
            {
                source: ambiences.getByName(ambience_top.value).wallpaper
                ambienceName: ambiences.getByName(ambience_top.value).displayName
                ambienceColor: ambiences.getByName(ambience_top.value).highlightColor
                onClicked:
                {
                    var sel = pageStack.push(Qt.resolvedUrl("Selector.qml"), { ambiences: ambiences,
                                                                               name: ambience_top.value.split(";")[0],
                                                                               pageTitle: qsTrId("onyx-top-position")})
                    sel.selected.connect(function()
                    {
                        ambience_top.value = sel.name + ";" + ambiences.getByName(sel.name).filepath
                    })
                }
            }

            SectionHeader
            {
                //% "Middle"
                text: qsTrId("onyx-middle-position")
            }

            AmbienceImage
            {
                source: ambiences.getByName(ambience_middle.value).wallpaper
                ambienceName: ambiences.getByName(ambience_middle.value).displayName
                ambienceColor: ambiences.getByName(ambience_middle.value).highlightColor
                onClicked:
                {
                    var sel = pageStack.push(Qt.resolvedUrl("Selector.qml"), { ambiences: ambiences,
                                                                               name: ambience_middle.value.split(";")[0],
                                                                               pageTitle: qsTrId("onyx-middle-position")})
                    sel.selected.connect(function()
                    {
                        ambience_middle.value = sel.name + ";" + ambiences.getByName(sel.name).filepath
                    })
                }
            }

            SectionHeader
            {
                //% "Bottom"
                text: qsTrId("onyx-bottom-position")
            }

            AmbienceImage
            {
                source: ambiences.getByName(ambience_bottom.value).wallpaper
                ambienceName: ambiences.getByName(ambience_bottom.value).displayName
                ambienceColor: ambiences.getByName(ambience_bottom.value).highlightColor
                onClicked:
                {
                    var sel = pageStack.push(Qt.resolvedUrl("Selector.qml"), { ambiences: ambiences,
                                                                               name: ambience_bottom.value.split(";")[0],
                                                                               pageTitle: qsTrId("onyx-bottom-position")})
                    sel.selected.connect(function()
                    {
                        ambience_bottom.value = sel.name + ";" + ambiences.getByName(sel.name).filepath
                    })
                }
            }
        }
    }

    ConfigurationValue
    {
        id: ambience_top
        key: "/apps/onyxtristate/top"
        defaultValue: "silent.ambience"
    }
    ConfigurationValue
    {
        id: ambience_middle
        key: "/apps/onyxtristate/middle"
        defaultValue: "sailing.ambience"
    }
    ConfigurationValue
    {
        id: ambience_bottom
        key: "/apps/onyxtristate/bottom"
        defaultValue: "origami.ambience"
    }

}

