import QtQuick
import QtQuick.Layouts
import "../../core/config"

/**
 * Styled button component with hover and press states
 */
Rectangle {
    id: root
    
    property string text: ""
    property bool enabled: true
    
    signal clicked()
    
    implicitWidth: layout.implicitWidth + Config.appearance.padding * 2
    implicitHeight: Config.bar.height - Config.appearance.padding
    
    color: {
        if (!enabled) return Qt.rgba(0, 0, 0, 0.3)
        if (mouseArea.pressed) return Qt.darker(Config.appearance.accentColor, 1.2)
        if (mouseArea.containsMouse) return Qt.lighter(Config.appearance.accentColor, 1.1)
        return Config.appearance.accentColor
    }
    
    radius: Config.appearance.rounding
    
    Behavior on color {
        ColorAnimation { duration: 150 }
    }
    
    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: Config.appearance.spacing
        
        StyledText {
            text: root.text
            color: "white"
            bold: true
        }
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: root.enabled
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        
        onClicked: root.clicked()
    }
}
