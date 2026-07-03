import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "#a60c0c16" // 65% opacity
    border.color: "#1affffff"
    border.width: 1
    radius: 16
    clip: true

    // Fake OS Window Header
    Rectangle {
        id: headerBar
        width: parent.width
        height: 40
        color: "#cc080810" // 80% opacity
        
        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: 1
            color: "#0dffffff"
        }

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 15
            anchors.rightMargin: 15
            
            // Window control dots
            RowLayout {
                spacing: 8
                Layout.alignment: Qt.AlignVCenter
                Rectangle { width: 12; height: 12; radius: 6; color: "#ef4444" } // Red
                Rectangle { width: 12; height: 12; radius: 6; color: "#f59e0b" } // Yellow
                Rectangle { width: 12; height: 12; radius: 6; color: "#10b981" } // Green
                
                Item { width: 8; height: 1 } // spacer
                Text {
                    text: "Qt 6.7.1 WASM SINGLETHREAD"
                    font.pixelSize: 10
                    font.family: "Courier New"
                    color: "#808088"
                    visible: root.width > 600
                }
            }

            Item { Layout.fillWidth: true } // Spacer

            // App Title
            RowLayout {
                spacing: 8
                AppIcon {
                    icon.source: "qrc:/assets/icons/cpu.svg"
                    Layout.preferredWidth: 16
                    Layout.preferredHeight: 16
                    icon.color: "#00F2FE"
                }
                Text {
                    text: (backend && backend.ui) ? (backend.ui.webAssemblyCanvas || "WEBASSEMBLY INTERACTIVE CANVAS") : "WEBASSEMBLY INTERACTIVE CANVAS"
                    font.pixelSize: 10
                    font.family: "Courier New"
                    font.bold: true
                    color: "#00F2FE"
                }
            }

            Item { Layout.fillWidth: true } // Spacer

            // Connection Status
            RowLayout {
                spacing: 12
                visible: root.width > 800
                
                Rectangle {
                    color: "#08ffffff"
                    border.color: "#0dffffff"
                    border.width: 1
                    radius: 6
                    implicitWidth: 140
                    implicitHeight: 24
                    
                    RowLayout {
                        anchors.centerIn: parent
                        spacing: 6
                        Rectangle {
                            width: 6; height: 6; radius: 3; color: "#00F2FE"
                            SequentialAnimation on opacity {
                                NumberAnimation { to: 0.2; duration: 500 }
                                NumberAnimation { to: 1.0; duration: 500 }
                                loops: Animation.Infinite
                            }
                        }
                        Text {
                            text: "C++ SLOT CONNECTED"
                            font.pixelSize: 10
                            font.family: window.fontMono
                            color: "#00F2FE"
                        }
                    }
                }

                // Language Switch
                Rectangle {
                    color: langBtn.hovered ? "#0fffffff" : "#05ffffff"
                    border.color: "#14ffffff"
                    border.width: 1
                    radius: 6
                    implicitWidth: 80
                    implicitHeight: 24

                    Behavior on color { ColorAnimation { duration: 150 } }

                    RowLayout {
                        anchors.centerIn: parent
                        spacing: 6

                        AppIcon {
                            icon.source: "qrc:/assets/icons/globe.svg"
                            Layout.preferredWidth: 12
                            Layout.preferredHeight: 12
                            icon.color: "#00F2FE"
                        }

                        Text {
                            text: (backend && backend.isRtl) ? "EN" : "FA"
                            font.pixelSize: 10
                            font.bold: true
                            color: "#ffffff"
                            font.family: window.fontSans
                        }
                    }

                    MouseArea {
                        id: langBtn
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (backend) {
                                backend.toggleLanguage();
                            }
                        }
                    }
                }
            }
        }
    }

    // Main App Structure (Moved from main.qml)
    RowLayout {
        anchors.top: headerBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        spacing: 0

        // Sidebar Navigation
        Sidebar {
            id: sidebar
            Layout.fillHeight: true
            Layout.preferredWidth: 260
            activeIndex: pageLoader.targetIndex
            
            onIndexSelected: {
                pageLoader.loadPage(index);
            }
        }

        // Page Display Area
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Loader {
                id: pageLoader
                anchors.fill: parent
                clip: true

                property int targetIndex: 0
                
                function loadPage(index) {
                    if (targetIndex === index) return;
                    targetIndex = index;
                    slideOutAnim.restart();
                }

                source: "OverviewPage.qml"
                opacity: 1

                transform: Translate {
                    id: pageTranslate
                    x: 0
                }

                // Slide & Fade transition animation
                SequentialAnimation {
                    id: slideOutAnim
                    
                    ParallelAnimation {
                        NumberAnimation { target: pageLoader; property: "opacity"; to: 0; duration: 150; easing.type: Easing.InQuad }
                        NumberAnimation { target: pageTranslate; property: "x"; to: (backend && backend.isRtl) ? 40 : -40; duration: 150; easing.type: Easing.InQuad }
                    }

                    ScriptAction {
                        script: {
                            pageTranslate.x = (backend && backend.isRtl) ? -40 : 40;
                            switch (pageLoader.targetIndex) {
                                case 0: pageLoader.source = "OverviewPage.qml"; break;
                                case 1: pageLoader.source = "ExperiencePage.qml"; break;
                                case 2: pageLoader.source = "SkillsPage.qml"; break;
                                case 3: pageLoader.source = "ContactPage.qml"; break;
                            }
                        }
                    }

                    ParallelAnimation {
                        NumberAnimation { target: pageLoader; property: "opacity"; to: 1; duration: 200; easing.type: Easing.OutQuad }
                        NumberAnimation { target: pageTranslate; property: "x"; to: 0; duration: 200; easing.type: Easing.OutQuad }
                    }
                }
            }
        }
    }
}
