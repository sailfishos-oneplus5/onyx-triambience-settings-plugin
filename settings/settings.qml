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
                                   wallpaper: a[i]["wallpaper"] })

                if (a[i]["name"] === ambience_top.value)
                    combo_top.currentIndex = i
                if (a[i]["name"] === ambience_middle.value)
                    combo_middle.currentIndex = i
                if (a[i]["name"] === ambience_bottom.value)
                    combo_bottom.currentIndex = i
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

            ComboBox
            {
                id: combo_top
                label: "Top "
                menu: ContextMenu
                {
                    Repeater
                    {
                        model: ambiences
                        delegate: MenuItem
                        {
                            text: displayName
                            onClicked: ambience_top.value = name
                        }
                    }
                }
            }
            ComboBox
            {
                id: combo_middle
                label: "Middle "
                menu: ContextMenu
                {
                    Repeater
                    {
                        model: ambiences
                        delegate: MenuItem
                        {
                            text: displayName
                            onClicked: ambience_middle.value = name
                        }
                    }
                }
            }
            ComboBox
            {
                id: combo_bottom
                label: "Bottom "
                menu: ContextMenu
                {
                    Repeater
                    {
                        model: ambiences
                        delegate: MenuItem
                        {
                            text: displayName
                            onClicked: ambience_bottom.value = name
                        }
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

