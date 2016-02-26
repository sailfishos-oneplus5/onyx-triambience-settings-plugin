import QtQuick 2.0
import Sailfish.Silica 1.0

Page
{
    id: page

    property var ambiences
    property var name
    property string pageTitle : "Select"
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
                delegate:
                    Image
                    {
                        source: "image://wallpapers" + wallpaper + "?" + width + "?" + height
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
                            id: namelabel
                            text: displayName
                            font.pixelSize: Theme.fontSizeLarge
                            color: highlightColor
                            anchors.left: parent.left
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: Theme.paddingLarge
                            anchors.bottomMargin: Theme.paddingMedium
                        }
                        GlassItem
                        {
                            opacity: (name === page.name) ? 1.0 : 0.0
                            color: Theme.primaryColor
                            anchors.left: parent.left
                            anchors.leftMargin: -width/2
                            anchors.verticalCenter: namelabel.verticalCenter
                            dimmed: false
                            falloffRadius: defaultFalloffRadius
                            brightness: 1.0
                        }

                        BackgroundItem
                        {
                            anchors.fill: parent
                            onClicked:
                            {
                                page.name = ambiences.get(index).name
                                selected()
                                pageStack.pop()
                            }
                        }
                    }
            }
        }
    }
}
