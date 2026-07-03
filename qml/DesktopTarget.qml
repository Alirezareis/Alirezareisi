import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "#a60c0c16" // 65% opacity
    border.color: "#1affffff"
    border.width: 1
    radius: 24

    property string winState: "idle" // idle, active, done
    property string linuxState: "idle"
    property string wasmState: "idle"
    property string copiedCmd: ""

    Timer {
        id: winTimer
        interval: 2000
        onTriggered: {
            root.winState = "done";
            winResetTimer.start();
        }
    }

    Timer {
        id: winResetTimer
        interval: 3000
        onTriggered: root.winState = "idle"
    }

    Timer {
        id: linuxTimer
        interval: 2000
        onTriggered: {
            root.linuxState = "done";
            linuxResetTimer.start();
        }
    }

    Timer {
        id: linuxResetTimer
        interval: 3000
        onTriggered: root.linuxState = "idle"
    }

    Timer {
        id: wasmTimer
        interval: 2000
        onTriggered: {
            root.wasmState = "done";
            wasmResetTimer.start();
        }
    }

    Timer {
        id: wasmResetTimer
        interval: 3000
        onTriggered: root.wasmState = "idle"
    }

    Timer {
        id: copyTimer
        interval: 2000
        onTriggered: root.copiedCmd = ""
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 24

        // Section Heading
        ColumnLayout {
            spacing: 4
            RowLayout {
                spacing: 8
                AppIcon {
                    icon.source: "qrc:/assets/icons/globe.svg"
                    Layout.preferredWidth: 20
                    Layout.preferredHeight: 20
                    icon.color: "#00F2FE"
                }
                Text {
                    text: "Cross-Platform Release Channels"
                    font.pixelSize: 18
                    font.bold: true
                    color: "#ffffff"
                    font.family: window.fontDisplay
                }
            }
            Text {
                text: "The following artifacts represent production-grade binaries produced automatically by the project's GitHub Actions CI/CD workflows, fully statically and dynamically bundled with necessary Qt Quick plugins."
                font.pixelSize: 12
                color: "#b0b0b8"
                wrapMode: Text.WordWrap
                lineHeight: 1.4
                Layout.fillWidth: true
            }
        }

        // Platform Cards Row
        RowLayout {
            Layout.fillWidth: true
            spacing: 16

            // Card 1: Windows
            GlassCard {
                Layout.fillWidth: true
                implicitHeight: 260
                glowColor: "#00F2FE"

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 12

                    // Card Title
                    RowLayout {
                        spacing: 10
                        Rectangle {
                            width: 36; height: 36; radius: 8
                            color: "#0dffffff"
                            AppIcon {
                                icon.source: "qrc:/assets/icons/globe.svg" // Monitor placeholder
                                width: 18; height: 18
                                icon.color: "#00F2FE"
                            }
                        }
                        ColumnLayout {
                            spacing: 1
                            Text { text: "Windows Desktop Package"; font.pixelSize: 13; font.bold: true; color: "#ffffff"; font.family: window.fontDisplay }
                            Text { text: "X64 STANDALONE EXECUTABLE"; font.pixelSize: 9; color: "#808088"; font.family: window.fontMono }
                        }
                    }

                    // Metrics Grid (Column layout simulation)
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8
                        
                        Rectangle { Layout.fillWidth: true; height: 1; color: "#0dffffff" }

                        RowLayout {
                            Text { text: "Compiler:"; font.pixelSize: 10; color: "#808088"; font.family: window.fontMono; Layout.fillWidth: true }
                            Text { text: "MinGW GCC 11.2"; font.pixelSize: 10; font.bold: true; color: "#e2e2e9"; font.family: window.fontMono }
                        }
                        RowLayout {
                            Text { text: "Pkg Size:"; font.pixelSize: 10; color: "#808088"; font.family: window.fontMono; Layout.fillWidth: true }
                            Text { text: "18.4 MB (ZIP)"; font.pixelSize: 10; font.bold: true; color: "#e2e2e9"; font.family: window.fontMono }
                        }
                        RowLayout {
                            Text { text: "CI Build Time:"; font.pixelSize: 10; color: "#808088"; font.family: window.fontMono; Layout.fillWidth: true }
                            Text { text: "1m 45s"; font.pixelSize: 10; font.bold: true; color: "#e2e2e9"; font.family: window.fontMono }
                        }

                        Rectangle { Layout.fillWidth: true; height: 1; color: "#0dffffff" }
                    }

                    // Action Button
                    Button {
                        id: winBtn
                        Layout.fillWidth: true
                        implicitHeight: 38
                        
                        background: Rectangle {
                            color: root.winState === "done" ? "#1a10b981" : (root.winState === "active" ? "#1a00f2fe" : "#05ffffff")
                            border.color: root.winState === "done" ? "#3310b981" : (root.winState === "active" ? "#3300f2fe" : "#1affffff")
                            border.width: 1
                            radius: 10
                        }

                        contentItem: RowLayout {
                            anchors.centerIn: parent
                            spacing: 8
                            BusyIndicator {
                                implicitWidth: 16; implicitHeight: 16
                                running: root.winState === "active"
                                visible: root.winState === "active"
                            }
                            Text {
                                text: root.winState === "done" ? "PACKAGE DELIVERED!" : (root.winState === "active" ? "FETCHING ARTIFACT..." : "DOWNLOAD WINDOWS BUNDLE")
                                font.pixelSize: 10
                                font.bold: true
                                font.family: window.fontMono
                                color: root.winState === "done" ? "#10b981" : "#00F2FE"
                            }
                        }

                        onClicked: {
                            if (root.winState !== "idle") return;
                            root.winState = "active";
                            winTimer.start();
                        }
                    }
                }
            }

            // Card 2: Linux
            GlassCard {
                Layout.fillWidth: true
                implicitHeight: 260
                glowColor: "#00F2FE"

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 12

                    // Card Title
                    RowLayout {
                        spacing: 10
                        Rectangle {
                            width: 36; height: 36; radius: 8
                            color: "#0dffffff"
                            AppIcon {
                                icon.source: "qrc:/assets/icons/cpu.svg" // Cpu placeholder
                                width: 18; height: 18
                                icon.color: "#00F2FE"
                            }
                        }
                        ColumnLayout {
                            spacing: 1
                            Text { text: "Linux Desktop AppImage"; font.pixelSize: 13; font.bold: true; color: "#ffffff"; font.family: window.fontDisplay }
                            Text { text: "X64 UNIVERSAL ELF BINARY"; font.pixelSize: 9; color: "#808088"; font.family: window.fontMono }
                        }
                    }

                    // Metrics Grid
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8
                        
                        Rectangle { Layout.fillWidth: true; height: 1; color: "#0dffffff" }

                        RowLayout {
                            Text { text: "Compiler:"; font.pixelSize: 10; color: "#808088"; font.family: window.fontMono; Layout.fillWidth: true }
                            Text { text: "GCC 11.4 Ubuntu"; font.pixelSize: 10; font.bold: true; color: "#e2e2e9"; font.family: window.fontMono }
                        }
                        RowLayout {
                            Text { text: "Pkg Size:"; font.pixelSize: 10; color: "#808088"; font.family: window.fontMono; Layout.fillWidth: true }
                            Text { text: "14.2 MB (ELF)"; font.pixelSize: 10; font.bold: true; color: "#e2e2e9"; font.family: window.fontMono }
                        }
                        RowLayout {
                            Text { text: "CI Build Time:"; font.pixelSize: 10; color: "#808088"; font.family: window.fontMono; Layout.fillWidth: true }
                            Text { text: "1m 20s"; font.pixelSize: 10; font.bold: true; color: "#e2e2e9"; font.family: window.fontMono }
                        }

                        Rectangle { Layout.fillWidth: true; height: 1; color: "#0dffffff" }
                    }

                    // Action Button
                    Button {
                        id: linuxBtn
                        Layout.fillWidth: true
                        implicitHeight: 38
                        
                        background: Rectangle {
                            color: root.linuxState === "done" ? "#1a10b981" : (root.linuxState === "active" ? "#1a00f2fe" : "#05ffffff")
                            border.color: root.linuxState === "done" ? "#3310b981" : (root.linuxState === "active" ? "#3300f2fe" : "#1affffff")
                            border.width: 1
                            radius: 10
                        }

                        contentItem: RowLayout {
                            anchors.centerIn: parent
                            spacing: 8
                            BusyIndicator {
                                implicitWidth: 16; implicitHeight: 16
                                running: root.linuxState === "active"
                                visible: root.linuxState === "active"
                            }
                            Text {
                                text: root.linuxState === "done" ? "PACKAGE DELIVERED!" : (root.linuxState === "active" ? "FETCHING ARTIFACT..." : "DOWNLOAD LINUX APPIMAGE")
                                font.pixelSize: 10
                                font.bold: true
                                font.family: window.fontMono
                                color: root.linuxState === "done" ? "#10b981" : "#00F2FE"
                            }
                        }

                        onClicked: {
                            if (root.linuxState !== "idle") return;
                            root.linuxState = "active";
                            linuxTimer.start();
                        }
                    }
                }
            }

            // Card 3: WASM
            GlassCard {
                Layout.fillWidth: true
                implicitHeight: 260
                glowColor: "#00F2FE"

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 12

                    // Card Title
                    RowLayout {
                        spacing: 10
                        Rectangle {
                            width: 36; height: 36; radius: 8
                            color: "#0dffffff"
                            AppIcon {
                                icon.source: "qrc:/assets/icons/file-text.svg" // File icon
                                width: 18; height: 18
                                icon.color: "#00F2FE"
                            }
                        }
                        ColumnLayout {
                            spacing: 1
                            Text { text: "WebAssembly Assets"; font.pixelSize: 13; font.bold: true; color: "#ffffff"; font.family: window.fontDisplay }
                            Text { text: "WASM32 SINGLETHREAD TARGET"; font.pixelSize: 9; color: "#808088"; font.family: window.fontMono }
                        }
                    }

                    // Metrics Grid
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8
                        
                        Rectangle { Layout.fillWidth: true; height: 1; color: "#0dffffff" }

                        RowLayout {
                            Text { text: "Compiler:"; font.pixelSize: 10; color: "#808088"; font.family: window.fontMono; Layout.fillWidth: true }
                            Text { text: "Emscripten v3.1.50"; font.pixelSize: 10; font.bold: true; color: "#e2e2e9"; font.family: window.fontMono }
                        }
                        RowLayout {
                            Text { text: "Pkg Size:"; font.pixelSize: 10; color: "#808088"; font.family: window.fontMono; Layout.fillWidth: true }
                            Text { text: "6.8 MB (Optimized)"; font.pixelSize: 10; font.bold: true; color: "#e2e2e9"; font.family: window.fontMono }
                        }
                        RowLayout {
                            Text { text: "CI Build Time:"; font.pixelSize: 10; color: "#808088"; font.family: window.fontMono; Layout.fillWidth: true }
                            Text { text: "2m 10s"; font.pixelSize: 10; font.bold: true; color: "#e2e2e9"; font.family: window.fontMono }
                        }

                        Rectangle { Layout.fillWidth: true; height: 1; color: "#0dffffff" }
                    }

                    // Action Button
                    Button {
                        id: wasmBtn
                        Layout.fillWidth: true
                        implicitHeight: 38
                        
                        background: Rectangle {
                            color: root.wasmState === "done" ? "#1a10b981" : (root.wasmState === "active" ? "#1a00f2fe" : "#05ffffff")
                            border.color: root.wasmState === "done" ? "#3310b981" : (root.wasmState === "active" ? "#3300f2fe" : "#1affffff")
                            border.width: 1
                            radius: 10
                        }

                        contentItem: RowLayout {
                            anchors.centerIn: parent
                            spacing: 8
                            BusyIndicator {
                                implicitWidth: 16; implicitHeight: 16
                                running: root.wasmState === "active"
                                visible: root.wasmState === "active"
                            }
                            Text {
                                text: root.wasmState === "done" ? "PACKAGE DELIVERED!" : (root.wasmState === "active" ? "FETCHING ARTIFACT..." : "DOWNLOAD WEB PACKAGE")
                                font.pixelSize: 10
                                font.bold: true
                                font.family: window.fontMono
                                color: root.wasmState === "done" ? "#10b981" : "#00F2FE"
                            }
                        }

                        onClicked: {
                            if (root.wasmState !== "idle") return;
                            root.wasmState = "active";
                            wasmTimer.start();
                        }
                    }
                }
            }
        }

        // Developer Direct Compilations Panel
        Rectangle {
            Layout.fillWidth: true
            implicitHeight: 180
            color: "#05ffffff"
            border.color: "#0dffffff"
            border.width: 1
            radius: 20
            
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 16

                RowLayout {
                    spacing: 8
                    AppIcon {
                        icon.source: "qrc:/assets/icons/cpu.svg" // Terminal indicator
                        Layout.preferredWidth: 14
                        Layout.preferredHeight: 14
                        icon.color: "#00F2FE"
                    }
                    Text {
                        text: "Developer Direct Compilations"
                        font.pixelSize: 12
                        font.bold: true
                        color: "#e2e2e9"
                        font.family: window.fontDisplay
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 16

                    // Web compile command
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 6
                        Text { text: "# COMPILING FOR WEBASSEMBLY LOCALLY:"; font.pixelSize: 9; color: "#606068"; font.family: window.fontMono }
                        
                        Rectangle {
                            Layout.fillWidth: true
                            implicitHeight: 46
                            color: "#cc080810"
                            border.color: "#0dffffff"
                            border.width: 1
                            radius: 10
                            
                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 12
                                anchors.rightMargin: 12
                                
                                Text {
                                    text: "mkdir build && cd build && emcmake cmake .. && make -j$(nproc)"
                                    font.pixelSize: 10
                                    color: "#a0a0ab"
                                    font.family: window.fontMono
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }

                                Button {
                                    id: copyWasmBtn
                                    implicitWidth: 60
                                    implicitHeight: 26
                                    background: Rectangle {
                                        color: root.copiedCmd === "wasm" ? "#1a10b981" : (copyWasmBtn.hovered ? "#0fffffff" : "#05ffffff")
                                        radius: 6
                                    }
                                    contentItem: Text {
                                        text: root.copiedCmd === "wasm" ? "COPIED" : "COPY"
                                        font.pixelSize: 9
                                        font.bold: true
                                        font.family: window.fontMono
                                        color: root.copiedCmd === "wasm" ? "#10b981" : "#00F2FE"
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    onClicked: {
                                        backend.copyToClipboard("mkdir build && cd build && emcmake cmake .. && make -j$(nproc)");
                                        root.copiedCmd = "wasm";
                                        copyTimer.start();
                                    }
                                }
                            }
                        }
                    }

                    // Linux compile command
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 6
                        Text { text: "# COMPILING FOR LINUX DESKTOP:"; font.pixelSize: 9; color: "#606068"; font.family: window.fontMono }
                        
                        Rectangle {
                            Layout.fillWidth: true
                            implicitHeight: 46
                            color: "#cc080810"
                            border.color: "#0dffffff"
                            border.width: 1
                            radius: 10
                            
                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 12
                                anchors.rightMargin: 12
                                
                                Text {
                                    text: "cmake -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build -j$(nproc)"
                                    font.pixelSize: 10
                                    color: "#a0a0ab"
                                    font.family: window.fontMono
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                }

                                Button {
                                    id: copyLinuxBtn
                                    implicitWidth: 60
                                    implicitHeight: 26
                                    background: Rectangle {
                                        color: root.copiedCmd === "linux" ? "#1a10b981" : (copyLinuxBtn.hovered ? "#0fffffff" : "#05ffffff")
                                        radius: 6
                                    }
                                    contentItem: Text {
                                        text: root.copiedCmd === "linux" ? "COPIED" : "COPY"
                                        font.pixelSize: 9
                                        font.bold: true
                                        font.family: window.fontMono
                                        color: root.copiedCmd === "linux" ? "#10b981" : "#00F2FE"
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    onClicked: {
                                        backend.copyToClipboard("cmake -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build -j$(nproc)");
                                        root.copiedCmd = "linux";
                                        copyTimer.start();
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
