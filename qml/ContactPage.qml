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

    // Timer for simulating network call
    Timer {
        id: submitTimer
        interval: 1500
        repeat: false
        onTriggered: {
            isSending = false;
            isSuccess = true;
        }
    }

    property bool isSending: false
    property bool isSuccess: false

    ColumnLayout {
        id: contentLayout
        width: root.availableWidth - 20
        spacing: 30
        
        Layout.topMargin: 20
        Layout.bottomMargin: 20
        Layout.leftMargin: 20
        Layout.rightMargin: 20

        Text {
            text: backend.ui.menuContact
            font.pixelSize: 28
            font.bold: true
            color: "#ffffff"
            font.family: window.fontSans
            horizontalAlignment: Text.AlignLeft
            Layout.fillWidth: true
        }

        Flow {
            Layout.fillWidth: true
            spacing: 25

            // Panel 1: Direct Contact Info
            GlassCard {
                width: 320
                height: 380
                glowColor: "#4FACFE"

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 20

                    Text {
                        text: backend.ui.contactInfoTitle
                        font.pixelSize: 18
                        font.bold: true
                        color: "#00F2FE"
                        font.family: window.fontSans
                        horizontalAlignment: Text.AlignLeft
                        Layout.fillWidth: true
                    }

                    // Contact Rows
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 16

                        // Location
                        RowLayout {
                            spacing: 12
                            AppIcon { icon.source: "qrc:/assets/icons/map-pin.svg"; Layout.preferredWidth: 24; Layout.preferredHeight: 24; icon.color: "#00F2FE" }
                            ColumnLayout {
                                spacing: 2
                                Text { text: backend.isRtl ? "مکان" : "Location"; font.pixelSize: 11; color: "#b0b0b8"; font.family: window.fontSans; horizontalAlignment: Text.AlignLeft; Layout.fillWidth: true }
                                Text { text: backend.location; font.pixelSize: 14; color: "#ffffff"; font.family: window.fontSans; horizontalAlignment: Text.AlignLeft; Layout.fillWidth: true }
                            }
                        }

                        // Email
                        RowLayout {
                            spacing: 12
                            AppIcon { icon.source: "qrc:/assets/icons/mail.svg"; Layout.preferredWidth: 24; Layout.preferredHeight: 24; icon.color: "#00F2FE" }
                            ColumnLayout {
                                spacing: 2
                                Text { text: backend.isRtl ? "ایمیل" : "Email"; font.pixelSize: 11; color: "#b0b0b8"; font.family: window.fontSans; horizontalAlignment: Text.AlignLeft; Layout.fillWidth: true }
                                Text { text: backend.email; font.pixelSize: 14; color: "#ffffff"; font.family: window.fontSans; horizontalAlignment: Text.AlignLeft; Layout.fillWidth: true }
                            }
                        }

                        // Phone
                        RowLayout {
                            spacing: 12
                            AppIcon { icon.source: "qrc:/assets/icons/phone.svg"; Layout.preferredWidth: 24; Layout.preferredHeight: 24; icon.color: "#00F2FE" }
                            ColumnLayout {
                                spacing: 2
                                Text { text: backend.isRtl ? "تلفن" : "Phone"; font.pixelSize: 11; color: "#b0b0b8"; font.family: window.fontSans; horizontalAlignment: Text.AlignLeft; Layout.fillWidth: true }
                                Text { text: backend.phone; font.pixelSize: 14; color: "#ffffff"; font.family: window.fontSans; horizontalAlignment: Text.AlignLeft; Layout.fillWidth: true }
                            }
                        }
                    }

                    Item { Layout.fillHeight: true }

                    Text {
                        text: backend.isRtl ? "خوشحال می‌شوم با من در ارتباط باشید!" : "Feel free to reach out for collaborations or job opportunities!"
                        font.pixelSize: 13
                        color: "#a0a0ab"
                        wrapMode: Text.WordWrap
                        lineHeight: 1.3
                        font.family: window.fontSans
                        horizontalAlignment: Text.AlignLeft
                        Layout.fillWidth: true
                    }
                }
            }

            // Panel 2: Interactive Contact Form
            GlassCard {
                id: formCard
                width: 480
                height: 380
                glowColor: "#00F2FE"

                // Success State View
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    visible: root.isSuccess
                    spacing: 15

                    Text {
                        text: "✅"
                        font.pixelSize: 56
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Text {
                        text: backend.ui.successTitle
                        font.pixelSize: 22
                        font.bold: true
                        color: "#00F2FE"
                        Layout.alignment: Qt.AlignHCenter
                        font.family: window.fontSans
                    }

                    Text {
                        text: backend.ui.successText
                        font.pixelSize: 14
                        color: "#e2e2e9"
                        Layout.alignment: Qt.AlignHCenter
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        font.family: window.fontSans
                    }

                    Button {
                        id: resetBtn
                        Layout.topMargin: 15
                        implicitWidth: 140
                        implicitHeight: 38
                        Layout.alignment: Qt.AlignHCenter

                        background: Rectangle {
                            color: resetBtn.hovered ? "#1affffff" : "#0dffffff"
                            border.color: "#33ffffff"
                            border.width: 1
                            radius: 19
                        }

                        contentItem: Text {
                            text: backend.isRtl ? "ارسال مجدد" : "Send Another"
                            font.pixelSize: 13
                            font.bold: true
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: window.fontSans
                        }

                        onClicked: {
                            nameInput.text = "";
                            emailInput.text = "";
                            messageInput.text = "";
                            root.isSuccess = false;
                        }
                    }
                }

                // Normal Form View
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    visible: !root.isSuccess
                    spacing: 12

                    Text {
                        text: backend.ui.contactFormTitle
                        font.pixelSize: 18
                        font.bold: true
                        color: "#4FACFE"
                        font.family: window.fontSans
                        horizontalAlignment: Text.AlignLeft
                        Layout.fillWidth: true
                    }

                    // Name Field
                    TextField {
                        id: nameInput
                        Layout.fillWidth: true
                        implicitHeight: 40
                        placeholderText: backend.ui.placeholderName
                        color: "#ffffff"
                        font.pixelSize: 14
                        font.family: window.fontSans
                        placeholderTextColor: "#707078"
                        enabled: !root.isSending
                        leftPadding: 12
                        rightPadding: 12
                        verticalAlignment: TextInput.AlignVCenter

                        background: Rectangle {
                            color: nameInput.activeFocus ? "#0fffffff" : "#05ffffff"
                            border.color: nameInput.activeFocus ? "#00F2FE" : "#14ffffff"
                            border.width: 1
                            radius: 8
                            Behavior on border.color { ColorAnimation { duration: 150 } }
                            Behavior on color { ColorAnimation { duration: 150 } }
                        }
                    }

                    // Email Field
                    TextField {
                        id: emailInput
                        Layout.fillWidth: true
                        implicitHeight: 40
                        placeholderText: backend.ui.placeholderEmail
                        color: "#ffffff"
                        font.pixelSize: 14
                        font.family: window.fontSans
                        placeholderTextColor: "#707078"
                        enabled: !root.isSending
                        leftPadding: 12
                        rightPadding: 12
                        verticalAlignment: TextInput.AlignVCenter

                        background: Rectangle {
                            color: emailInput.activeFocus ? "#0fffffff" : "#05ffffff"
                            border.color: emailInput.activeFocus ? "#00F2FE" : "#14ffffff"
                            border.width: 1
                            radius: 8
                            Behavior on border.color { ColorAnimation { duration: 150 } }
                            Behavior on color { ColorAnimation { duration: 150 } }
                        }
                    }

                    // Message Field
                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true

                        TextArea {
                            id: messageInput
                            placeholderText: backend.ui.placeholderMessage
                            color: "#ffffff"
                            font.pixelSize: 14
                            font.family: window.fontSans
                            placeholderTextColor: "#707078"
                            enabled: !root.isSending
                            wrapMode: TextEdit.Wrap
                            leftPadding: 12
                            rightPadding: 12
                            topPadding: 10
                            bottomPadding: 10

                            background: Rectangle {
                                color: messageInput.activeFocus ? "#0fffffff" : "#05ffffff"
                                border.color: messageInput.activeFocus ? "#00F2FE" : "#14ffffff"
                                border.width: 1
                                radius: 8
                                Behavior on border.color { ColorAnimation { duration: 150 } }
                                Behavior on color { ColorAnimation { duration: 150 } }
                            }
                        }
                    }

                    // Send Button
                    Button {
                        id: sendBtn
                        Layout.fillWidth: true
                        implicitHeight: 44
                        enabled: nameInput.text.trim().length > 0 && 
                                 emailInput.text.trim().length > 0 && 
                                 messageInput.text.trim().length > 0 && 
                                 !root.isSending

                        background: Rectangle {
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: sendBtn.enabled ? (sendBtn.hovered ? "#00F2FE" : "#4FACFE") : "#0dffffff" }
                                GradientStop { position: 1.0; color: sendBtn.enabled ? (sendBtn.hovered ? "#4FACFE" : "#00F2FE") : "#0dffffff" }
                            }
                            border.color: sendBtn.enabled ? "transparent" : "#0dffffff"
                            border.width: 1
                            radius: 8
                            
                            Rectangle {
                                anchors.fill: parent
                                anchors.margins: -1
                                radius: 9
                                color: "transparent"
                                border.color: "#00F2FE"
                                border.width: 1.5
                                visible: sendBtn.enabled && sendBtn.hovered
                            }
                        }

                        contentItem: Row {
                            spacing: 8
                            anchors.centerIn: parent

                            BusyIndicator {
                                id: sendingIndicator
                                implicitWidth: 20
                                implicitHeight: 20
                                running: root.isSending
                                visible: root.isSending
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Text {
                                text: root.isSending ? (backend.isRtl ? "در حال ارسال..." : "Sending...") : backend.ui.btnSend
                                font.pixelSize: 14
                                font.bold: true
                                color: sendBtn.enabled ? "#ffffff" : "#606068"
                                font.family: window.fontSans
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        onClicked: {
                            root.isSending = true;
                            submitTimer.start();
                        }
                    }
                }
            }
        }
    }
}
