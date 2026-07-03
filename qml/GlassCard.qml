import QtQuick
import QtQuick.Controls

Frame {
    id: root
    implicitWidth: 300
    implicitHeight: 200
    padding: 20

    property color glowColor: "#00F2FE"
    property bool isHovered: mouseArea.containsMouse
    property alias clickable: mouseArea.enabled
    signal clicked()

    background: Rectangle {
        color: root.isHovered ? "#12ffffff" : "#0affffff"
        border.color: root.isHovered ? "#5900f2fe" : "#14ffffff"
        border.width: 1
        radius: 16

        // Glow layer
        Rectangle {
            anchors.fill: parent
            anchors.margins: -1
            border.color: root.glowColor
            border.width: 1.5
            radius: 16
            color: "transparent"
            opacity: root.isHovered ? 0.6 : 0.0
            Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
        }
        
        Behavior on color { ColorAnimation { duration: 200; easing.type: Easing.OutCubic } }
        Behavior on border.color { ColorAnimation { duration: 200; easing.type: Easing.OutCubic } }
    }

    scale: root.isHovered ? 1.015 : 1.0
    Behavior on scale {
        NumberAnimation { duration: 200; easing.type: Easing.OutBack }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: enabled && root.clickable ? Qt.PointingHandCursor : Qt.ArrowCursor
        onClicked: root.clicked()
    }
}
