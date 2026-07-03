import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Rectangle {
    id: root
    width: 260
    color: "#33000000" // bg-black/20
    
    property int activeIndex: 0
    signal indexSelected(int index)

    // Inner dividing line that mirrors with RTL
    Rectangle {
        width: 1
        height: parent.height
        color: "#0dffffff" // border-white/5
        anchors.right: parent.right
        visible: !LayoutMirroring.enabled
    }
    Rectangle {
        width: 1
        height: parent.height
        color: "#0dffffff"
        anchors.left: parent.left
        visible: LayoutMirroring.enabled
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 30

        // Profile Header (Text Only)
        ColumnLayout {
            Layout.alignment: Qt.AlignLeft
            spacing: 8
            
            RowLayout {
                spacing: 6
                AppIcon {
                    Layout.preferredWidth: 14
                    Layout.preferredHeight: 14
                    icon.source: "qrc:/assets/icons/cpu.svg"
                    icon.color: "#ffffff"
                }
                Text {
                    text: "QML RUNTIME ENGINE"
                    font.pixelSize: 10
                    font.bold: true
                    color: "#00F2FE"
                    font.family: window.fontMono
                }
            }

            Text {
                text: backend ? backend.name : ""
                font.pixelSize: 20
                font.bold: true
                color: "#ffffff"
                font.family: window.fontDisplay
            }

            Text {
                text: backend ? backend.title : ""
                font.pixelSize: 13
                color: "#a0a0ab"
                font.family: window.fontSans
            }
        }

        // Navigation Items
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 6
            Layout.topMargin: 10

            Repeater {
                model: (backend && backend.ui) ? [
                    { "label": backend.ui.menuOverview || "Overview", "icon": "qrc:/assets/icons/user.svg" },
                    { "label": backend.ui.menuExperience || "Experience", "icon": "qrc:/assets/icons/briefcase.svg" },
                    { "label": backend.ui.menuSkills || "Skills", "icon": "qrc:/assets/icons/cpu.svg" },
                    { "label": backend.ui.menuContact || "Contact", "icon": "qrc:/assets/icons/mail.svg" }
                ] : []

                delegate: Button {
                    id: navBtn
                    Layout.fillWidth: true
                    implicitHeight: 44
                    
                    background: Rectangle {
                        color: activeIndex === index ? "#1a00f2fe" : (navBtn.hovered ? "#0affffff" : "transparent")
                        border.color: activeIndex === index ? "#3300f2fe" : "transparent"
                        border.width: 1
                        radius: 8
                        
                        // Active indicator line
                        Rectangle {
                            width: 3
                            height: parent.height * 0.4
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: -1
                            color: "#00F2FE"
                            radius: 1.5
                            visible: activeIndex === index
                        }

                        Behavior on color { ColorAnimation { duration: 250; easing.type: Easing.OutCubic } }
                    }

                    contentItem: RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 16
                        anchors.rightMargin: 16
                        spacing: 12

                        AppIcon {
                            icon.source: modelData.icon
                            Layout.preferredWidth: 16
                            Layout.preferredHeight: 16
                            Layout.alignment: Qt.AlignVCenter
                            icon.color: activeIndex === index ? "#00F2FE" : (navBtn.hovered ? "#ffffff" : "#808088")
                        }

                        Text {
                            text: modelData.label
                            font.pixelSize: 13
                            font.weight: activeIndex === index ? Font.Medium : Font.Normal
                            color: activeIndex === index ? "#00F2FE" : (navBtn.hovered ? "#ffffff" : "#a0a0ab")
                            font.family: window.fontSans
                            Layout.fillWidth: true
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignLeft
                        }
                    }

                    onClicked: {
                        root.activeIndex = index;
                        root.indexSelected(index);
                    }
                }
            }
        }
        
        Item { Layout.fillHeight: true } // Spacer

        // Core QObject Properties
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 12
            
            Text {
                text: "CORE PROPERTIES"
                font.pixelSize: 10
                font.bold: true
                color: "#606068"
                font.family: window.fontMono
            }

            ColumnLayout {
                spacing: 8
                Layout.fillWidth: true
                
                RowLayout {
                    Layout.fillWidth: true
                    Text { text: "Language"; font.pixelSize: 11; color: "#808088"; font.family: window.fontSans; Layout.fillWidth: true }
                    Text { text: (backend && backend.isRtl) ? "FA" : "EN"; font.pixelSize: 11; font.bold: true; color: "#00F2FE"; font.family: window.fontMono }
                }
                RowLayout {
                    Layout.fillWidth: true
                    Text { text: "Orientation"; font.pixelSize: 11; color: "#808088"; font.family: window.fontSans; Layout.fillWidth: true }
                    Text { text: (backend && backend.isRtl) ? "RTL" : "LTR"; font.pixelSize: 11; color: "#ffffff"; font.family: window.fontMono }
                }
                RowLayout {
                    Layout.fillWidth: true
                    Text { text: "Memory Map"; font.pixelSize: 11; color: "#808088"; font.family: window.fontSans; Layout.fillWidth: true }
                    Text { text: "0x8F2A"; font.pixelSize: 11; color: "#ffffff"; font.family: window.fontMono }
                }
            }
        }
    }
}
