import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "#a60c0c16" // 65% opacity
    border.color: "#1affffff"
    border.width: 1
    radius: 24

    property var filesList: []
    property var selectedFile: null
    property string fileContent: ""
    property var fileLines: []
    property bool copied: false

    // Load files list on startup
    Component.onCompleted: {
        filesList = backend.getSourceFiles();
        if (filesList.length > 0) {
            selectFile(filesList[0]);
        }
    }

    function selectFile(file) {
        selectedFile = file;
        fileContent = backend.getSourceFileContent(file.path);
        fileLines = fileContent.split("\n");
        copied = false;
    }

    // Syntax Highlighter Logic
    function highlightLine(line, lang) {
        if (!line.trim()) return "&nbsp;";
        
        // Escape HTML
        var escaped = line.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
        
        // Check if comment
        var trimmed = escaped.trim();
        if (trimmed.indexOf("//") === 0 || trimmed.indexOf("#") === 0) {
            return "<span style='color:#606068; font-style:italic;'>" + escaped + "</span>";
        }
        
        var keywords = [
            'class', 'explicit', 'nullptr', 'const', 'void', 'bool', 'int', 'char', 'float', 'double',
            'return', 'if', 'else', 'for', 'while', 'switch', 'case', 'default', 'import', 'property',
            'alias', 'signals', 'public', 'private', 'Q_PROPERTY', 'Q_INVOKABLE', 'emit',
            'slots', 'on', 'QT', 'CONFIG', 'SOURCES', 'HEADERS', 'RESOURCES', 'INSTALLS'
        ];

        var qtKeywords = [
            'QString', 'QObject', 'QVariantList', 'QJsonObject', 'QFile', 'QJsonDocument', 'QJsonArray',
            'QGuiApplication', 'QQmlApplicationEngine', 'QQmlContext', 'QUrl', 'QCoreApplication',
            'ApplicationWindow', 'Rectangle', 'RowLayout', 'StackLayout', 'Sidebar', 'OverviewPage',
            'ExperiencePage', 'SkillsPage', 'ContactPage', 'MouseArea', 'Behavior', 'ColorAnimation',
            'Gradient', 'GradientStop', 'GlassCard', 'Loader', 'Image', 'Text', 'ColumnLayout', 'ScrollView',
            'Item', 'Button', 'Flow', 'TextField', 'TextArea', 'BusyIndicator', 'Flickable', 'Repeater'
        ];
        
        // Regex split keeping dividers
        var words = escaped.split(/(\s+|=|\{|\}|\(|\)|\,|;|\:|\+|\*|\/|\&|&lt;|&gt;)/);
        var result = "";
        
        for (var i = 0; i < words.length; i++) {
            var w = words[i];
            var trimW = w.trim();
            
            // Basic string literals
            if ((w.indexOf("\"") === 0 && w.lastIndexOf("\"") === w.length - 1 && w.length > 1) || 
                (w.indexOf("'") === 0 && w.lastIndexOf("'") === w.length - 1 && w.length > 1)) {
                result += "<span style='color:#10b981;'>" + w + "</span>";
                continue;
            }
            
            if (keywords.indexOf(trimW) !== -1) {
                result += "<span style='color:#4FACFE; font-weight:bold;'>" + w + "</span>";
            } else if (qtKeywords.indexOf(trimW) !== -1) {
                result += "<span style='color:#00F2FE; font-weight:bold;'>" + w + "</span>";
            } else if (/^\d+$/.test(trimW)) {
                result += "<span style='color:#f59e0b;'>" + w + "</span>";
            } else {
                result += w;
            }
        }
        return result;
    }

    Timer {
        id: copyTimer
        interval: 2000
        onTriggered: root.copied = false
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Title Bar
        Rectangle {
            Layout.fillWidth: true
            height: 55
            color: "#cc080810" // 80% opaque
            radius: 24
            
            // Mask top corners
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 10
                color: "#cc080810"
            }
            
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: "#0dffffff"
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                
                RowLayout {
                    spacing: 8
                    AppIcon {
                        icon.source: "qrc:/assets/icons/cpu.svg"
                        Layout.preferredWidth: 18
                        Layout.preferredHeight: 18
                        icon.color: "#00F2FE"
                    }
                    Text {
                        text: "QT / C++ BLUEPRINT EXPLORER"
                        font.pixelSize: 11
                        font.bold: true
                        font.family: window.fontMono
                        color: "#e2e2e9"
                    }
                }

                Item { Layout.fillWidth: true }

                Rectangle {
                    color: "#08ffffff"
                    border.color: "#1a00f2fe"
                    border.width: 1
                    radius: 6
                    implicitWidth: 160
                    implicitHeight: 26
                    
                    RowLayout {
                        anchors.centerIn: parent
                        spacing: 6
                        AppIcon {
                            icon.source: "qrc:/assets/icons/file-text.svg"
                            Layout.preferredWidth: 12
                            Layout.preferredHeight: 12
                            icon.color: "#00F2FE"
                        }
                        Text {
                            text: "QT 6.7 LTS DEPLOYMENT"
                            font.pixelSize: 9
                            font.family: window.fontMono
                            color: "#00F2FE"
                        }
                    }
                }
            }
        }

        // Main Split Area
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            // Left Sidebar: File Tree
            Rectangle {
                Layout.preferredWidth: 240
                Layout.fillHeight: true
                color: "#1a000000" // subtle dark
                
                Rectangle {
                    width: 1
                    height: parent.height
                    color: "#0dffffff"
                    anchors.right: parent.right
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 12

                    Text {
                        text: "WORKSPACE FILES"
                        font.pixelSize: 10
                        font.bold: true
                        color: "#606068"
                        font.family: window.fontMono
                    }

                    // Files Scroll Area
                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true
                        
                        ScrollBar.vertical: ScrollBar {
                            width: 4
                            contentItem: Rectangle { color: "#14ffffff"; radius: 2 }
                            background: Item {}
                        }

                        ColumnLayout {
                            width: parent.width - 6
                            spacing: 6

                            Repeater {
                                model: root.filesList

                                delegate: Button {
                                    id: fileBtn
                                    Layout.fillWidth: true
                                    implicitHeight: 38
                                    
                                    property bool isSelected: root.selectedFile && root.selectedFile.path === modelData.path

                                    background: Rectangle {
                                        color: fileBtn.isSelected ? "#1a00f2fe" : (fileBtn.hovered ? "#08ffffff" : "transparent")
                                        border.color: fileBtn.isSelected ? "#3300f2fe" : "transparent"
                                        border.width: 1
                                        radius: 8
                                        Behavior on color { ColorAnimation { duration: 150 } }
                                    }

                                    contentItem: RowLayout {
                                        anchors.fill: parent
                                        anchors.leftMargin: 10
                                        anchors.rightMargin: 10
                                        spacing: 8

                                        AppIcon {
                                            icon.source: "qrc:/assets/icons/file-text.svg"
                                            Layout.preferredWidth: 14
                                            Layout.preferredHeight: 14
                                            icon.color: fileBtn.isSelected ? "#00F2FE" : "#808088"
                                        }

                                        Text {
                                            text: modelData.name
                                            font.pixelSize: 12
                                            font.family: window.fontMono
                                            color: fileBtn.isSelected ? "#00F2FE" : (fileBtn.hovered ? "#ffffff" : "#a0a0ab")
                                            Layout.fillWidth: true
                                            elide: Text.ElideRight
                                        }
                                    }

                                    onClicked: {
                                        root.selectFile(modelData);
                                    }
                                }
                            }
                        }
                    }

                    // Compiler Quick-Info
                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 105
                        color: "#05ffffff"
                        border.color: "#0dffffff"
                        border.width: 1
                        radius: 12
                        
                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 12
                            spacing: 6

                            RowLayout {
                                spacing: 6
                                AppIcon {
                                    icon.source: "qrc:/assets/icons/cpu.svg"
                                    Layout.preferredWidth: 12
                                    Layout.preferredHeight: 12
                                    icon.color: "#00F2FE"
                                }
                                Text {
                                    text: "Qt Compiler Core"
                                    font.pixelSize: 11
                                    font.bold: true
                                    color: "#ffffff"
                                }
                            }

                            Text {
                                text: "To build this locally, configure your kit with Qt 6.7.x Desktop GCC or Emscripten, run qmake or cmake, then make."
                                font.pixelSize: 10
                                color: "#808088"
                                wrapMode: Text.WordWrap
                                lineHeight: 1.3
                                Layout.fillWidth: true
                            }
                        }
                    }
                }
            }

            // Right Panel: Code View
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 0

                // Code Header Bar
                Rectangle {
                    Layout.fillWidth: true
                    height: 55
                    color: "#05ffffff"
                    
                    Rectangle {
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: 1
                        color: "#0dffffff"
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 20
                        anchors.rightMargin: 20
                        
                        ColumnLayout {
                            spacing: 2
                            Layout.alignment: Qt.AlignVCenter
                            
                            RowLayout {
                                spacing: 8
                                Text {
                                    text: root.selectedFile ? root.selectedFile.path : ""
                                    font.pixelSize: 12
                                    font.bold: true
                                    color: "#ffffff"
                                    font.family: window.fontMono
                                }
                                Rectangle {
                                    color: "#1a00f2fe"
                                    border.color: "#3300f2fe"
                                    border.width: 1
                                    radius: 4
                                    implicitWidth: 40
                                    implicitHeight: 16
                                    Text {
                                        anchors.centerIn: parent
                                        text: root.selectedFile ? root.selectedFile.language.toUpperCase() : ""
                                        font.pixelSize: 8
                                        font.bold: true
                                        color: "#00F2FE"
                                        font.family: window.fontMono
                                    }
                                }
                            }
                            Text {
                                text: root.selectedFile ? root.selectedFile.description : ""
                                font.pixelSize: 11
                                color: "#808088"
                                elide: Text.ElideRight
                                Layout.maximumWidth: 450
                            }
                        }

                        Item { Layout.fillWidth: true }

                        // Copy Button
                        Button {
                            id: copyBtn
                            implicitWidth: 100
                            implicitHeight: 32
                            Layout.alignment: Qt.AlignVCenter

                            background: Rectangle {
                                color: root.copied ? "#1a10b981" : (copyBtn.hovered ? "#3300f2fe" : "#1a00f2fe")
                                border.color: root.copied ? "#3310b981" : "#3300f2fe"
                                border.width: 1
                                radius: 8
                                Behavior on color { ColorAnimation { duration: 150 } }
                            }

                            contentItem: RowLayout {
                                anchors.centerIn: parent
                                spacing: 6
                                Text {
                                    text: root.copied ? "COPIED!" : "COPY CODE"
                                    font.pixelSize: 10
                                    font.bold: true
                                    font.family: window.fontMono
                                    color: root.copied ? "#10b981" : "#00F2FE"
                                }
                            }

                            onClicked: {
                                backend.copyToClipboard(root.fileContent);
                                root.copied = true;
                                copyTimer.start();
                            }
                        }
                    }
                }

                // Code Display View (List of highlighted lines)
                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    ScrollBar.vertical: ScrollBar {
                        width: 6
                        contentItem: Rectangle { color: "#14ffffff"; radius: 3 }
                        background: Item {}
                    }

                    ScrollBar.horizontal: ScrollBar {
                        height: 6
                        contentItem: Rectangle { color: "#14ffffff"; radius: 3 }
                        background: Item {}
                    }

                    ColumnLayout {
                        id: codeCol
                        width: parent.width
                        spacing: 0
                        
                        Layout.topMargin: 12
                        Layout.bottomMargin: 12

                        Repeater {
                            model: root.fileLines

                            delegate: RowLayout {
                                Layout.fillWidth: true
                                spacing: 0
                                height: 18

                                // Line Number Gutter
                                Text {
                                    text: (index + 1).toString()
                                    font.pixelSize: 11
                                    font.family: window.fontMono
                                    color: "#40ffffff"
                                    horizontalAlignment: Text.AlignRight
                                    Layout.preferredWidth: 35
                                    rightPadding: 12
                                }
                                
                                Rectangle {
                                    width: 1
                                    Layout.fillHeight: true
                                    color: "#0dffffff"
                                }

                                // Code line content (RichText)
                                Text {
                                    text: root.highlightLine(modelData, root.selectedFile ? root.selectedFile.language : "")
                                    font.pixelSize: 11
                                    font.family: window.fontMono
                                    color: "#e2e2e9"
                                    textFormat: Text.RichText
                                    Layout.fillWidth: true
                                    leftPadding: 15
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
