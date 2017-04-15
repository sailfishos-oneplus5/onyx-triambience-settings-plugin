import QtQuick 2.0
import Sailfish.Silica 1.0

Page
{
    id: page

    property var ambiences
    property var name
    property string pageTitle : ""
    signal selected

    SilicaFlickable
    {
        id: flick
        anchors.fill: parent
        clip: true

        contentHeight: column.height

        Column
        {
            id: column

            width: page.width

            PageHeader
            {
                title: pageTitle
            }

            Repeater
            {
                model: ambiences
                delegate: AmbienceImage
                {
                    source: wallpaper
                    ambienceName: displayName
                    ambienceColor: highlightColor
                    isSelected: name === page.name
                    onClicked:
                    {
                        page.name = name
                        selected()
                        pageStack.pop()
                    }
                }

            }
        }
    }
}
