import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

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
        width: root.availableWidth
        spacing: 30
        
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 16
        
        Layout.topMargin: 20
        Layout.bottomMargin: 20
        Layout.leftMargin: 24
        Layout.rightMargin: 24

        // Profile Card with Avatar
        GlassCard {
            Layout.fillWidth: true
            implicitHeight: 140
            glowColor: "#00F2FE"

            // Glow Ball (GPU Blurred Orb)
            Shape {
                width: 150
                height: 150
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.topMargin: -15
                anchors.rightMargin: -15
                preferredRendererType: Shape.CurveRenderer

                ShapePath {
                    strokeColor: "transparent"
                    fillGradient: RadialGradient {
                        centerX: 75; centerY: 75
                        centerRadius: 75
                        focalX: 75; focalY: 75
                        focalRadius: 0
                        GradientStop { position: 0.0; color: "#2b00f2fe" }
                        GradientStop { position: 0.5; color: "#124facfe" }
                        GradientStop { position: 1.0; color: "transparent" }
                    }
                    PathRectangle {
                        x: 0; y: 0
                        width: 150; height: 150
                    }
                }
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 20

                // Avatar Square
                Rectangle {
                    width: 80
                    height: 80
                    radius: 16
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#00F2FE" }
                        GradientStop { position: 1.0; color: "#4FACFE" }
                    }
                    
                    Rectangle {
                        anchors.centerIn: parent
                        width: 77
                        height: 77
                        radius: 14
                        color: "#080810"
                        
                        Text {
                            anchors.centerIn: parent
                            text: "AR"
                            font.pixelSize: 28
                            font.bold: true
                            font.family: window.fontMono
                            color: "#00F2FE"
                        }
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 4

                    Text {
                        text: backend.name
                        font.pixelSize: 28
                        font.bold: true
                        color: "#ffffff"
                        font.family: window.fontDisplay
                        horizontalAlignment: Text.AlignLeft
                        Layout.fillWidth: true
                    }

                    Text {
                        text: backend.title
                        font.pixelSize: 16
                        color: "#00F2FE"
                        font.family: window.fontSans
                        horizontalAlignment: Text.AlignLeft
                        Layout.fillWidth: true
                    }
                }
            }
        }

        // Summary Card
        GlassCard {
            Layout.fillWidth: true
            implicitHeight: summaryCol.implicitHeight + 40
            
            ColumnLayout {
                id: summaryCol
                anchors.fill: parent
                anchors.margins: 15
                spacing: 12

                Text {
                    text: backend.isRtl ? "خلاصه حرفه‌ای" : "Professional Summary"
                    font.pixelSize: 18
                    font.bold: true
                    color: "#4FACFE"
                    font.family: window.fontDisplay
                    horizontalAlignment: Text.AlignLeft
                    Layout.fillWidth: true
                }

                Text {
                    text: backend.summary
                    font.pixelSize: 15
                    color: "#e2e2e9"
                    lineHeight: 1.5
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                    font.family: window.fontSans
                    horizontalAlignment: Text.AlignLeft
                }
            }
        }

        // Contact details and CV Download Button
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 20

            Text {
                text: backend.ui.contactInfoTitle
                font.pixelSize: 20
                font.bold: true
                color: "#ffffff"
                font.family: window.fontDisplay
                horizontalAlignment: Text.AlignLeft
                Layout.fillWidth: true
            }

            // Contact Grid
            Flow {
                id: contactFlow
                Layout.fillWidth: true
                spacing: 15

                // Email Chip
                GlassCard {
                    width: 260
                    height: 80
                    clickable: true
                    glowColor: "#4FACFE"
                    onClicked: Qt.openUrlExternally("mailto:" + backend.email)
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 5
                        spacing: 12

                        AppIcon { icon.source: "qrc:/assets/icons/mail.svg"; Layout.preferredWidth: 24; Layout.preferredHeight: 24; Layout.alignment: Qt.AlignVCenter; icon.color: "#00F2FE" }
                        ColumnLayout {
                            Layout.fillWidth: true; spacing: 2
                            Text { text: backend.isRtl ? "ایمیل" : "Email"; font.pixelSize: 11; color: "#b0b0b8"; font.family: window.fontSans; horizontalAlignment: Text.AlignLeft; Layout.fillWidth: true }
                            Text { text: backend.email; font.pixelSize: 12; font.bold: true; color: "#ffffff"; elide: Text.ElideRight; horizontalAlignment: Text.AlignLeft; Layout.fillWidth: true; font.family: window.fontSans }
                        }
                    }
                }

                // Phone Chip
                GlassCard {
                    width: 260
                    height: 80
                    clickable: true
                    glowColor: "#4FACFE"
                    onClicked: Qt.openUrlExternally("tel:" + backend.phone)

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 5
                        spacing: 12

                        AppIcon { icon.source: "qrc:/assets/icons/phone.svg"; Layout.preferredWidth: 24; Layout.preferredHeight: 24; Layout.alignment: Qt.AlignVCenter; icon.color: "#00F2FE" }
                        ColumnLayout {
                            Layout.fillWidth: true; spacing: 2
                            Text { text: backend.isRtl ? "تلفن" : "Phone"; font.pixelSize: 11; color: "#b0b0b8"; font.family: window.fontSans; horizontalAlignment: Text.AlignLeft; Layout.fillWidth: true }
                            Text { text: backend.phone; font.pixelSize: 12; font.bold: true; color: "#ffffff"; elide: Text.ElideRight; horizontalAlignment: Text.AlignLeft; Layout.fillWidth: true; font.family: window.fontSans }
                        }
                    }
                }

                // GitHub Chip
                GlassCard {
                    width: 260
                    height: 80
                    clickable: true
                    glowColor: "#00F2FE"
                    onClicked: Qt.openUrlExternally(backend.githubUrl)

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 5
                        spacing: 12

                        AppIcon { icon.source: "qrc:/assets/icons/github.svg"; Layout.preferredWidth: 24; Layout.preferredHeight: 24; Layout.alignment: Qt.AlignVCenter; icon.color: "#00F2FE" }
                        ColumnLayout {
                            Layout.fillWidth: true; spacing: 2
                            Text { text: "GitHub"; font.pixelSize: 11; color: "#b0b0b8"; font.family: window.fontSans; horizontalAlignment: Text.AlignLeft; Layout.fillWidth: true }
                            Text { text: backend.github; font.pixelSize: 12; font.bold: true; color: "#00F2FE"; elide: Text.ElideRight; horizontalAlignment: Text.AlignLeft; Layout.fillWidth: true; font.family: window.fontSans }
                        }
                    }
                }

                // LinkedIn Chip
                GlassCard {
                    width: 260
                    height: 80
                    clickable: true
                    glowColor: "#00F2FE"
                    onClicked: Qt.openUrlExternally(backend.linkedinUrl)

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 5
                        spacing: 12

                        AppIcon { icon.source: "qrc:/assets/icons/linkedin.svg"; Layout.preferredWidth: 24; Layout.preferredHeight: 24; Layout.alignment: Qt.AlignVCenter; icon.color: "#00F2FE" }
                        ColumnLayout {
                            Layout.fillWidth: true; spacing: 2
                            Text { text: "LinkedIn"; font.pixelSize: 11; color: "#b0b0b8"; font.family: window.fontSans; horizontalAlignment: Text.AlignLeft; Layout.fillWidth: true }
                            Text { text: backend.linkedin; font.pixelSize: 12; font.bold: true; color: "#00F2FE"; elide: Text.ElideRight; horizontalAlignment: Text.AlignLeft; Layout.fillWidth: true; font.family: window.fontSans }
                        }
                    }
                }
            }
            
            // Download PDF CV Button
            Button {
                id: resumeDownloadBtn
                Layout.topMargin: 15
                implicitWidth: 220
                implicitHeight: 46

                background: Rectangle {
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: resumeDownloadBtn.hovered ? "#4FACFE" : "#00F2FE" }
                        GradientStop { position: 1.0; color: resumeDownloadBtn.hovered ? "#00F2FE" : "#4FACFE" }
                    }
                    radius: 23
                    
                    // Subtle glowing drop shadow
                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: -2
                        radius: 25
                        color: "transparent"
                        border.color: "#00F2FE"
                        border.width: 1.5
                        opacity: resumeDownloadBtn.hovered ? 0.6 : 0.0
                        Behavior on opacity { NumberAnimation { duration: 150 } }
                    }
                }

                contentItem: Row {
                    spacing: 8
                    anchors.centerIn: parent

                    AppIcon { icon.source: "qrc:/assets/icons/file-text.svg"; width: 20; height: 20; anchors.verticalCenter: parent.verticalCenter; icon.color: "#ffffff" }
                    
                    Text {
                        text: backend.ui.btnResume
                        font.pixelSize: 14
                        font.bold: true
                        color: "#ffffff"
                        font.family: window.fontSans
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                onClicked: Qt.openUrlExternally("Alireza_Reisi_CV_v3.pdf")
            }
        }
    }
}
