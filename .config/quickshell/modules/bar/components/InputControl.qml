import QtQuick
import QtQuick.Layouts
import "../../../core/config"
import "../../../core/services"
import "../../../lib/base"

/**
 * Input control
 */
Rectangle {
    id: root
    
    implicitWidth: layout.implicitWidth + Config.appearance.padding * 1.5
    implicitHeight: parent.height
    
    color: mouseArea.containsMouse 
        ? Qt.rgba(Config.appearance.surfaceColor.r, Config.appearance.surfaceColor.g, Config.appearance.surfaceColor.b, 0.3)
        : "transparent"
    radius: Config.appearance.rounding
    
    Behavior on color {
        ColorAnimation { duration: 150 }
    }
    
    RowLayout {
        id: layout
        anchors.fill: parent
        anchors.leftMargin: Config.appearance.padding / 2
        anchors.rightMargin: Config.appearance.padding / 2
        spacing: Config.appearance.spacing / 2
        
        StyledText {
            text: "🎤"
            font.pixelSize: Config.appearance.font.size + 2
            opacity: Audio.micMuted ? 0.4 : 1.0
            
            Behavior on opacity {
                NumberAnimation { duration: 150 }
            }
            
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Audio.toggleMicMute()
            }
        }
        
        Rectangle {
            width: 6
            height: 6
            radius: 3
            color: Audio.micMuted ? "#f38ba8" : "#a6e3a1"
            
            Behavior on color {
                ColorAnimation { duration: 150 }
            }
        }
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
    }
}
