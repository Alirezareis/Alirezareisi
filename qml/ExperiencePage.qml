import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ScrollView {
    id: root
    contentWidth: contentLayout.width
    contentHeight: contentLayout.height
    clip: true

    ScrollBar.vertical: ScrollBar {
        policy: ScrollBar.AsNeeded
        parent: root
        anchors.right: parent.right
        anchors.rightMargin: 2
        contentItem: Rectangle {
            implicitWidth: 6
            implicitHeight: 100
            radius: 3
            color: parent.hovered ? "#4000f2fe" : "#14ffffff"
        }
        background: Item {}
    }

    ColumnLayout {
        id: contentLayout
        width: root.availableWidth - 20
        spacing: 30
        
        Layout.topMargin: 20
        Layout.bottomMargin: 20
        Layout.leftMargin: 20
        Layout.rightMargin: 20

        Text {
            text: backend.ui.experienceTitle
            font.pixelSize: 28
            font.bold: true
            color: "#ffffff"
            font.family: window.fontDisplay
            horizontalAlignment: Text.AlignLeft
            Layout.fillWidth: true
        }

        // Timeline Items
        Repeater {
            model: backend.experience

            delegate: RowLayout {
                id: itemRow
                Layout.fillWidth: true
                spacing: 20
                
                // Timeline column
                ColumnLayout {
                    Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                    spacing: 0
                    implicitWidth: 20
                    Layout.fillHeight: true

                    // Top line connector (hidden for first item)
                    Rectangle {
                        width: 2
                        implicitHeight: 20
                        color: index === 0 ? "transparent" : "#5900f2fe"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    // Dot
                    Rectangle {
                        width: 14
                        height: 14
                        radius: 7
                        color: "#00F2FE"
                        Layout.alignment: Qt.AlignHCenter
                        
                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: -4
                            radius: 11
                            color: "transparent"
                            border.color: "#4FACFE"
                            border.width: 1
                            opacity: 0.6
                        }
                    }

                    // Bottom line connector (hidden for last item)
                    Rectangle {
                        width: 2
                        Layout.fillHeight: true
                        color: index === backend.experience.length - 1 ? "transparent" : "#5900f2fe"
                        Layout.alignment: Qt.AlignHCenter
                    }
                }

                // Card content
                GlassCard {
                    Layout.fillWidth: true
                    implicitHeight: cardCol.implicitHeight + 40

                    ColumnLayout {
                        id: cardCol
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 12

                        // Header with role, company and period
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 4

                            RowLayout {
                                Layout.fillWidth: true

                                Text {
                                    text: modelData.role
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "#ffffff"
                                    font.family: window.fontDisplay
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.fillWidth: true
                                }

                                Text {
                                    text: modelData.period
                                    font.pixelSize: 13
                                    font.bold: true
                                    color: "#4FACFE"
                                    font.family: window.fontDisplay
                                    Layout.alignment: Qt.AlignVCenter
                                }
                            }

                            Text {
                                text: modelData.company + " | " + modelData.type
                                font.pixelSize: 14
                                color: "#00F2FE"
                                font.family: window.fontDisplay
                                horizontalAlignment: Text.AlignLeft
                                Layout.fillWidth: true
                            }
                        }

                        // Bullets
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 8
                            Layout.topMargin: 5

                            Repeater {
                                model: modelData.bullets

                                delegate: RowLayout {
                                    Layout.fillWidth: true
                                    spacing: 10
                                    
                                    // Custom bullet dot
                                    Rectangle {
                                        width: 6
                                        height: 6
                                        radius: 3
                                        color: "#4FACFE"
                                        Layout.alignment: Qt.AlignTop
                                        Layout.topMargin: 6
                                    }

                                    Text {
                                        text: modelData
                                        font.pixelSize: 14
                                        color: "#d0d0d8"
                                        lineHeight: 1.4
                                        wrapMode: Text.WordWrap
                                        Layout.fillWidth: true
                                        font.family: window.fontDisplay
                                        horizontalAlignment: Text.AlignLeft
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
