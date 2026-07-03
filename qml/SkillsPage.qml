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
        spacing: 35
        
        Layout.topMargin: 20
        Layout.bottomMargin: 20
        Layout.leftMargin: 20
        Layout.rightMargin: 20

        // SECTION 1: TECHNICAL SKILLS
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 20

            Text {
                text: backend.ui.skillsTitle
                font.pixelSize: 28
                font.bold: true
                color: "#ffffff"
                font.family: window.fontSans
                horizontalAlignment: Text.AlignLeft
                Layout.fillWidth: true
            }

            // Loop over skills categories
            Repeater {
                model: backend.skills

                delegate: ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 12
                    Layout.bottomMargin: 10

                    Text {
                        text: modelData.category
                        font.pixelSize: 18
                        font.bold: true
                        color: "#00F2FE"
                        font.family: window.fontSans
                        horizontalAlignment: Text.AlignLeft
                        Layout.fillWidth: true
                    }

                    // Skills Grid
                    Flow {
                        Layout.fillWidth: true
                        spacing: 15

                        Repeater {
                            model: modelData.items

                            delegate: GlassCard {
                                width: 280
                                height: 75
                                glowColor: "#4FACFE"

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 5
                                    spacing: 8

                                    RowLayout {
                                        Layout.fillWidth: true

                                        Text {
                                            text: modelData.name
                                            font.pixelSize: 14
                                            font.bold: true
                                            color: "#ffffff"
                                            font.family: window.fontSans
                                            horizontalAlignment: Text.AlignLeft
                                            Layout.fillWidth: true
                                        }

                                        Text {
                                            text: Math.round(modelData.level * 100) + "%"
                                            font.pixelSize: 12
                                            color: "#4FACFE"
                                            font.family: window.fontSans
                                        }
                                    }

                                    // Progress Bar
                                    Rectangle {
                                        Layout.fillWidth: true
                                        height: 6
                                        color: "#1affffff"
                                        radius: 3

                                        Rectangle {
                                            id: fillBar
                                            width: parent.width * modelData.level
                                            height: parent.height
                                            radius: 3
                                            anchors.left: parent.left

                                            gradient: Gradient {
                                                GradientStop { position: 0.0; color: "#00F2FE" }
                                                GradientStop { position: 1.0; color: "#4FACFE" }
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

        // SECTION 2: EDUCATION
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 20
            Layout.topMargin: 15

            Text {
                text: backend.ui.educationTitle
                font.pixelSize: 28
                font.bold: true
                color: "#ffffff"
                font.family: window.fontSans
                horizontalAlignment: Text.AlignLeft
                Layout.fillWidth: true
            }

            // Grid / Flow of Education Cards
            Flow {
                Layout.fillWidth: true
                spacing: 15

                Repeater {
                    model: backend.education

                    delegate: GlassCard {
                        width: 360
                        height: 115
                        glowColor: "#4FACFE"

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 5
                            spacing: 8

                            RowLayout {
                                Layout.fillWidth: true

                                Text {
                                    text: modelData.degree
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "#ffffff"
                                    font.family: window.fontSans
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.fillWidth: true
                                }
                            }

                            Text {
                                text: modelData.school
                                font.pixelSize: 14
                                color: "#00F2FE"
                                font.family: window.fontSans
                                horizontalAlignment: Text.AlignLeft
                                Layout.fillWidth: true
                            }

                            Text {
                                text: modelData.period
                                font.pixelSize: 12
                                color: "#b0b0b8"
                                font.family: window.fontSans
                                horizontalAlignment: Text.AlignLeft
                                Layout.fillWidth: true
                            }
                        }
                    }
                }
            }
        }
    }
}
