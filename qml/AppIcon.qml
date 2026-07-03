//AppIcon.qml
import QtQuick
import QtQuick.Controls

Item {
    id: appIcon
    implicitWidth: 32
    implicitHeight: 32
    property alias icon: btn.icon
    property alias pressed: btn.pressed
    property bool clickable: false
    signal clicked()
    Button {
        id: btn
        anchors.fill: parent
        background: Item { }
        padding: 0
        topPadding: 0
        bottomPadding: 0
        leftPadding: 0
        rightPadding: 0
        icon.width: parent.width
        icon.height: parent.height
        display: Button.IconOnly
        enabled: appIcon.clickable
        hoverEnabled: appIcon.clickable
        onClicked: appIcon.clicked()
    }
}
