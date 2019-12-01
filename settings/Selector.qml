import QtQuick 2.2
import Sailfish.Silica 1.0

Page
{
    id: page

    property var ambiences
    property var name
    property string pageTitle : ""
    signal selected

    // Flickable wrapper
    SilicaFlickable
    {
        id: flick
        anchors.fill: parent
        contentHeight: col.height
        clip: true

        // Page content
        Column
        {
            id: col
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
