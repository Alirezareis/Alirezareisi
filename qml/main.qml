import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

ApplicationWindow {
    id: window
    width: 1200
    height: 800
    minimumWidth: 800
    minimumHeight: 600
    visible: true
    title: (backend ? backend.name : "") + " - " + (backend ? backend.title : "")

    // Dynamic RTL layout mirroring
    LayoutMirroring.enabled: backend ? backend.isRtl : false
    LayoutMirroring.childrenInherit: true

    FontLoader { id: fontInter; source: "qrc:/assets/fonts/Inter-Regular.ttf" }
    FontLoader { id: fontSpaceGrotesk; source: "qrc:/assets/fonts/SpaceGrotesk-Regular.ttf" }
    FontLoader { id: fontJetBrainsMono; source: "qrc:/assets/fonts/JetBrainsMono-Regular.ttf" }

    property string fontSans: (backend && backend.isRtl) ? "Vazirmatn" : fontInter.name
    property string fontDisplay: (backend && backend.isRtl) ? "Vazirmatn" : fontSpaceGrotesk.name
    property string fontMono: fontJetBrainsMono.name

    font.family: fontSans

    property string activeWorkspace: "app"

    // Background styling
    background: Rectangle {
        id: bgRect
        color: "#080810"

        // Immersive Atmospheric Ambient Glows (GPU Blurred Orbs)
        Shape {
            id: glow1
            width: 580
            height: 580
            x: -140
            y: -140
            preferredRendererType: Shape.CurveRenderer

            ShapePath {
                strokeColor: "transparent"
                fillGradient: RadialGradient {
                    centerX: 290; centerY: 290
                    centerRadius: 290
                    focalX: 290; focalY: 290
                    focalRadius: 0
                    GradientStop { position: 0.0; color: "#2b00f2fe" }
                    GradientStop { position: 0.5; color: "#1200f2fe" }
                    GradientStop { position: 1.0; color: "transparent" }
                }
                PathRectangle {
                    x: 0; y: 0
                    width: 580; height: 580
                }
            }
            
            SequentialAnimation on x {
                loops: Animation.Infinite
                NumberAnimation { to: -90; duration: 15000; easing.type: Easing.InOutQuad }
                NumberAnimation { to: -140; duration: 15000; easing.type: Easing.InOutQuad }
            }
            SequentialAnimation on scale {
                loops: Animation.Infinite
                NumberAnimation { to: 1.1; duration: 15000; easing.type: Easing.InOutQuad }
                NumberAnimation { to: 1.0; duration: 15000; easing.type: Easing.InOutQuad }
            }
        }

        Shape {
            id: glow2
            width: 580
            height: 580
            x: bgRect.width - 440
            y: bgRect.height - 440
            preferredRendererType: Shape.CurveRenderer

            ShapePath {
                strokeColor: "transparent"
                fillGradient: RadialGradient {
                    centerX: 290; centerY: 290
                    centerRadius: 290
                    focalX: 290; focalY: 290
                    focalRadius: 0
                    GradientStop { position: 0.0; color: "#2b4facfe" }
                    GradientStop { position: 0.5; color: "#124facfe" }
                    GradientStop { position: 1.0; color: "transparent" }
                }
                PathRectangle {
                    x: 0; y: 0
                    width: 580; height: 580
                }
            }
            
            SequentialAnimation on x {
                loops: Animation.Infinite
                NumberAnimation { to: bgRect.width - 490; duration: 20000; easing.type: Easing.InOutQuad }
                NumberAnimation { to: bgRect.width - 440; duration: 20000; easing.type: Easing.InOutQuad }
            }
            SequentialAnimation on scale {
                loops: Animation.Infinite
                NumberAnimation { to: 1.1; duration: 20000; easing.type: Easing.InOutQuad }
                NumberAnimation { to: 1.0; duration: 20000; easing.type: Easing.InOutQuad }
            }
        }
    }

    // Scrollable Main View
    ScrollView {
        id: mainScroll
        anchors.fill: parent
        clip: true

        ScrollBar.vertical: ScrollBar {
            policy: ScrollBar.AsNeeded
        }

        ColumnLayout {
            id: mainLayout
            width: mainScroll.availableWidth
            spacing: 0

            // Global Navigation Header
            Rectangle {
                Layout.fillWidth: true
                height: 70
                color: "#66080810" // translucent
                border.color: "#0dffffff"
                border.width: 1
                
                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 40
                    anchors.rightMargin: 40
                    spacing: 20

                    // Logo Brand Block
                    RowLayout {
                        spacing: 12
                        Rectangle {
                            width: 44
                            height: 44
                            radius: 12
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: "#00F2FE" }
                                GradientStop { position: 1.0; color: "#4FACFE" }
                            }
                            Rectangle {
                                anchors.centerIn: parent
                                width: 41
                                height: 41
                                radius: 10
                                color: "#080810"
                                AppIcon {
                                    anchors.centerIn: parent
                                    icon.source: "qrc:/assets/icons/cpu.svg"
                                    width: 20
                                    height: 20
                                    icon.color: "#00F2FE"
                                }
                            }
                        }

                        ColumnLayout {
                            spacing: 2
                            RowLayout {
                                spacing: 8
                                Text {
                                    text: backend ? backend.name : ""
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "#ffffff"
                                    font.family: window.fontDisplay
                                }
                                Rectangle {
                                    color: "#1a00f2fe"
                                    border.color: "#3300f2fe"
                                    border.width: 1
                                    radius: 4
                                    width: 90
                                    height: 18
                                    Text {
                                        anchors.centerIn: parent
                                        text: "QT 6.7 LTS PROFILE"
                                        font.pixelSize: 8
                                        font.bold: true
                                        color: "#00F2FE"
                                        font.family: window.fontMono
                                    }
                                }
                            }
                            Text {
                                text: "Qt/C++ WebAssembly Portfolio Showcase"
                                font.pixelSize: 11
                                color: "#b0b0b8"
                                font.family: window.fontMono
                            }
                        }
                    }

                    Item { Layout.fillWidth: true } // Spacer

                    // Social Profiles & Contacts
                    RowLayout {
                        spacing: 14
                        
                        Button {
                            implicitWidth: 36
                            implicitHeight: 36
                            background: Rectangle {
                                color: parent.hovered ? "#0dffffff" : "transparent"
                                border.color: parent.hovered ? "#5900f2fe" : "#0dffffff"
                                radius: 8
                                Behavior on color { ColorAnimation { duration: 150 } }
                                Behavior on border.color { ColorAnimation { duration: 150 } }
                            }
                            contentItem: AppIcon {
                                icon.source: "qrc:/assets/icons/github.svg"
                                width: 18; height: 18
                                icon.color: parent.hovered ? "#ffffff" : "#a0a0ab"
                            }
                            onClicked: {
                                if (backend) {
                                    Qt.openUrlExternally(backend.githubUrl);
                                }
                            }
                        }

                        Button {
                            implicitWidth: 36
                            implicitHeight: 36
                            background: Rectangle {
                                color: parent.hovered ? "#0dffffff" : "transparent"
                                border.color: parent.hovered ? "#5900f2fe" : "#0dffffff"
                                radius: 8
                                Behavior on color { ColorAnimation { duration: 150 } }
                                Behavior on border.color { ColorAnimation { duration: 150 } }
                            }
                            contentItem: AppIcon {
                                icon.source: "qrc:/assets/icons/mail.svg"
                                width: 18; height: 18
                                icon.color: parent.hovered ? "#ffffff" : "#a0a0ab"
                            }
                            onClicked: {
                                if (backend) {
                                    Qt.openUrlExternally("mailto:" + backend.email);
                                }
                            }
                        }

                        Rectangle {
                            color: "#1a10b981"
                            border.color: "#3310b981"
                            border.width: 1
                            radius: 12
                            width: 120
                            height: 24
                            RowLayout {
                                anchors.centerIn: parent
                                spacing: 6
                                Rectangle {
                                    width: 6; height: 6; radius: 3; color: "#10b981"
                                    SequentialAnimation on opacity {
                                        NumberAnimation { to: 0.3; duration: 800 }
                                        NumberAnimation { to: 1.0; duration: 800 }
                                        loops: Animation.Infinite
                                    }
                                }
                                Text {
                                    text: "CI BUILD PASSING"
                                    font.pixelSize: 9
                                    color: "#10b981"
                                    font.family: window.fontMono
                                }
                            }
                        }
                    }
                }
            }

            // Main Body Container
            ColumnLayout {
                Layout.fillWidth: true
                Layout.maximumWidth: 1000
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 40
                Layout.bottomMargin: 40
                spacing: 30

                // Workspace Portfolio Explainer Hero
                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 16

                    Rectangle {
                        Layout.alignment: Qt.AlignHCenter
                        color: "#08ffffff"
                        border.color: "#1affffff"
                        border.width: 1
                        radius: 12
                        width: 280
                        height: 24
                        RowLayout {
                            anchors.centerIn: parent
                            spacing: 8
                            AppIcon {
                                icon.source: "qrc:/assets/icons/map-pin.svg" // fallback icon for award
                                width: 14; height: 14
                                icon.color: "#00F2FE"
                            }
                            Text {
                                text: "DUAL-LANGUAGE LTR/RTL RESPONSIVE ENGINE"
                                font.pixelSize: 10
                                font.bold: true
                                color: "#00F2FE"
                                font.family: "Courier New"
                            }
                        }
                    }

                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter
                        spacing: 8
                        Text {
                            text: "Cross-Platform"
                            font.pixelSize: 42
                            font.family: window.fontDisplay
                            color: "#ffffff"
                        }
                        Text {
                            text: "Qt QML Portfolio"
                            font.pixelSize: 42
                            font.bold: true
                            font.family: window.fontDisplay
                            color: "#00F2FE" // Simplified gradient
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.maximumWidth: 700
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                        text: "Explore an interactive portfolio engineered with Qt Quick/QML (Front-end) and C++ (Back-end), demonstrating native compilation targets across Windows x64, Linux x64, and browser-embedded WebAssembly."
                        font.pixelSize: 14
                        color: "#b0b0b8"
                        lineHeight: 1.5
                    }
                }

                // Workspace Mode Selection Cards
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 15

                    // Tab 1: App
                    GlassCard {
                        id: tabAppCard
                        Layout.fillWidth: true
                        implicitHeight: 100
                        glowColor: "#00F2FE"
                        clickable: true
                        
                        // Override background to show selected state
                        background: Rectangle {
                            color: window.activeWorkspace === "app" ? "#08ffffff" : (tabAppCard.isHovered ? "#0dffffff" : "#080810")
                            border.color: window.activeWorkspace === "app" ? "#8000f2fe" : (tabAppCard.isHovered ? "#33ffffff" : "#1affffff")
                            border.width: 1
                            radius: 16
                            Behavior on border.color { ColorAnimation { duration: 150 } }
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 15
                            Rectangle {
                                width: 40; height: 40; radius: 10
                                color: window.activeWorkspace === "app" ? "#1a00f2fe" : "#05ffffff"
                                border.color: window.activeWorkspace === "app" ? "#4d00f2fe" : "#1affffff"
                                AppIcon {
                                    anchors.centerIn: parent
                                    icon.source: "qrc:/assets/icons/file-text.svg"
                                    width: 20; height: 20
                                    icon.color: window.activeWorkspace === "app" ? "#00F2FE" : (tabAppCard.isHovered ? "#ffffff" : "#808088")
                                }
                            }
                            ColumnLayout {
                                spacing: 4
                                Text { text: "INTERACTIVE WEBASSEMBLY APP"; font.pixelSize: 11; font.bold: true; color: "#ffffff"; font.family: window.fontDisplay }
                                Text { text: "This site was made using QML"; font.pixelSize: 11; color: "#b0b0b8"; font.family: window.fontMono }
                            }
                        }
                        onClicked: window.activeWorkspace = "app"
                    }

                    // Tab 2: Code
                    GlassCard {
                        id: tabCodeCard
                        Layout.fillWidth: true
                        implicitHeight: 100
                        glowColor: "#00F2FE"
                        clickable: true
                        
                        background: Rectangle {
                            color: window.activeWorkspace === "code" ? "#08ffffff" : (tabCodeCard.isHovered ? "#0dffffff" : "#080810")
                            border.color: window.activeWorkspace === "code" ? "#8000f2fe" : (tabCodeCard.isHovered ? "#33ffffff" : "#1affffff")
                            border.width: 1
                            radius: 16
                            Behavior on border.color { ColorAnimation { duration: 150 } }
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 15
                            Rectangle {
                                width: 40; height: 40; radius: 10
                                color: window.activeWorkspace === "code" ? "#1a00f2fe" : "#05ffffff"
                                border.color: window.activeWorkspace === "code" ? "#4d00f2fe" : "#1affffff"
                                AppIcon {
                                    anchors.centerIn: parent
                                    icon.source: "qrc:/assets/icons/cpu.svg"
                                    width: 20; height: 20
                                    icon.color: window.activeWorkspace === "code" ? "#00F2FE" : (tabCodeCard.isHovered ? "#ffffff" : "#808088")
                                }
                            }
                            ColumnLayout {
                                spacing: 4
                                Text { text: "C++ & QML CODE BLUEPRINTS"; font.pixelSize: 11; font.bold: true; color: "#ffffff"; font.family: window.fontDisplay }
                                Text { text: "QMake, C++ Backend, and QML Files"; font.pixelSize: 11; color: "#b0b0b8"; font.family: window.fontMono }
                            }
                        }
                        onClicked: window.activeWorkspace = "code"
                    }

                    // Tab 3: Desktop
                    GlassCard {
                        id: tabDesktopCard
                        Layout.fillWidth: true
                        implicitHeight: 100
                        glowColor: "#00F2FE"
                        clickable: true
                        
                        background: Rectangle {
                            color: window.activeWorkspace === "desktop" ? "#08ffffff" : (tabDesktopCard.isHovered ? "#0dffffff" : "#080810")
                            border.color: window.activeWorkspace === "desktop" ? "#8000f2fe" : (tabDesktopCard.isHovered ? "#33ffffff" : "#1affffff")
                            border.width: 1
                            radius: 16
                            Behavior on border.color { ColorAnimation { duration: 150 } }
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 15
                            Rectangle {
                                width: 40; height: 40; radius: 10
                                color: window.activeWorkspace === "desktop" ? "#1a00f2fe" : "#05ffffff"
                                border.color: window.activeWorkspace === "desktop" ? "#4d00f2fe" : "#1affffff"
                                AppIcon {
                                    anchors.centerIn: parent
                                    icon.source: "qrc:/assets/icons/map-pin.svg"
                                    width: 20; height: 20
                                    icon.color: window.activeWorkspace === "desktop" ? "#00F2FE" : (tabDesktopCard.isHovered ? "#ffffff" : "#808088")
                                }
                            }
                            ColumnLayout {
                                spacing: 4
                                Text { text: "CI/CD DESKTOP TARGETS"; font.pixelSize: 11; font.bold: true; color: "#ffffff"; font.family: window.fontDisplay }
                                Text { text: "Windows MinGW, Linux GCC, & Wasm Builds"; font.pixelSize: 11; color: "#b0b0b8"; font.family: window.fontMono }
                            }
                        }
                        onClicked: window.activeWorkspace = "desktop"
                    }
                }

                // Dynamic Display Panel
                Item {
                    Layout.fillWidth: true
                    implicitHeight: 620
                    Layout.topMargin: 20

                    Loader {
                        id: contentLoader
                        anchors.fill: parent
                        
                        source: {
                            if (window.activeWorkspace === "app") return "ResumeViewer.qml";
                            if (window.activeWorkspace === "code") return "CodeExplorer.qml";
                            if (window.activeWorkspace === "desktop") return "DesktopTarget.qml";
                            return "ResumeViewer.qml";
                        }
                        
                        // Simple crossfade
                        Behavior on source {
                            SequentialAnimation {
                                NumberAnimation { target: contentLoader; property: "opacity"; to: 0; duration: 150 }
                                PropertyAction { target: contentLoader; property: "source" }
                                NumberAnimation { target: contentLoader; property: "opacity"; to: 1; duration: 250; easing.type: Easing.OutCubic }
                            }
                        }
                    }
                }
            }

            // Global Footer
            Rectangle {
                Layout.fillWidth: true
                height: 100
                color: "#66000000" // bg-black/40
                
                Rectangle {
                    anchors.top: parent.top
                    width: parent.width
                    height: 1
                    color: "#0dffffff" // border-white/5
                }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 8
                    
                    Text {
                        text: "Alireza Reisiminab © 2026. All Rights Reserved."
                        font.pixelSize: 10
                        font.family: window.fontMono
                        color: "#606068"
                        Layout.alignment: Qt.AlignHCenter
                    }
                    
                    RowLayout {
                        spacing: 8
                        Layout.alignment: Qt.AlignHCenter
                        Text { text: "Powered by"; font.pixelSize: 10; font.family: window.fontMono; color: "#606068" }
                        Text { text: "Qt Quick / QML 6.7"; font.pixelSize: 10; font.family: window.fontMono; color: "#00F2FE"; font.bold: true }
                        Text { text: "•"; font.pixelSize: 10; font.family: window.fontMono; color: "#606068" }
                        Text { text: "Emscripten WebAssembly"; font.pixelSize: 10; font.family: window.fontMono; color: "#4FACFE"; font.bold: true }
                        Text { text: "•"; font.pixelSize: 10; font.family: window.fontMono; color: "#606068" }
                        Text { text: "C++ Core Engines"; font.pixelSize: 10; font.family: window.fontMono; color: "#00F2FE"; font.bold: true }
                        Text { text: "•"; font.pixelSize: 10; font.family: window.fontMono; color: "#606068" }
                        Text { text: "React & Tailwind CSS v4"; font.pixelSize: 10; font.family: window.fontMono; color: "#4FACFE"; font.bold: true }
                    }
                }
            }
        }
    }
}
