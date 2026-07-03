import QtQuick 2.15
import QtQuick.Shaders 1.0

Item {
    id: container
    anchors.fill: parent

    // Base rectangle with translucent color
    Rectangle {
        id: backgroundRect
        anchors.fill: parent
        color: "#ffffff20"
        radius: 12
    }

    // Capture the rectangle as a source for the shader
    ShaderEffectSource {
        id: sourceItem
        sourceItem: backgroundRect
        hideSource: true
        smooth: true
        recursive: true
    }

    // Apply custom blur shader
    ShaderEffect {
        anchors.fill: sourceItem
        fragmentShader: "qrc:/BlurShader.glsl"
        property real radius: 25.0
        source: sourceItem
    }
}

