import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.configuration 1.0
import com.kimmoli.onyxtriambiencesettings 1.0

Page
{
    id: page

    TriambienceSettings
    {
        Component.onCompleted: console.log(getStuff())
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

            SectionHeader
            {
                text: "top"
            }
            Label
            {
                text: ambience_top.value
            }
            SectionHeader
            {
                text: "middle"
            }
            Label
            {
                text: ambience_middle.value
            }
            SectionHeader
            {
                text: "bottom"
            }
            Label
            {
                text: ambience_bottom.value
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

