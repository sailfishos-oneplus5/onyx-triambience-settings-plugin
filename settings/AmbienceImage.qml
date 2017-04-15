import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.thumbnailer 1.0

BackgroundItem
{

    width: flick.width ? Math.min(flick.width, screen.sizeCategory > Screen.Medium ? Screen.width*0.7 : Screen.width) : Screen.width
    height: Theme.itemSizeHuge

    property alias source: img.source
    property alias ambienceName: namelabel.text
    property alias ambienceColor: namelabel.color
    property bool isSelected: false

    Thumbnail
    {
        id: img
        anchors.fill: parent
        sourceSize.width: width
        sourceSize.height: height
    }

    Rectangle
    {
        anchors.fill: parent
        gradient: Gradient
        {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 1.0; color: Qt.rgba(0.0 ,0.0, 0.0, 0.5) }
        }
    }

    BusyIndicator
    {
        size: BusyIndicatorSize.Medium
        anchors.centerIn: parent
        running: img.status != Image.Ready
        visible: running
    }

    Label
    {
        id: namelabel
        font.pixelSize: Theme.fontSizeLarge
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: Theme.paddingLarge
        anchors.bottomMargin: Theme.paddingMedium
    }

    GlassItem
    {
        opacity: (isSelected) ? 1.0 : 0.0
        color: Theme.primaryColor
        anchors.left: parent.left
        anchors.leftMargin: -width/2
        anchors.verticalCenter: namelabel.verticalCenter
        dimmed: false
        falloffRadius: defaultFalloffRadius
        brightness: 1.0
    }
}
