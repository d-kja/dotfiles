import QtQuick
import QtQuick.Layouts
import "../../../core/config"
import "../../../core/services"
import "../../../lib/base"

/**
 * Volume control
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
        spacing: Config.appearance.spacing
        
        StyledText {
            text: {
                if (Audio.muted) return "🔇"
                if (Audio.volume > 0.66) return "🔊"
                if (Audio.volume > 0.33) return "🔉"
                return "🔈"
            }
            font.pixelSize: Config.appearance.font.size + 2
            
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Audio.toggleMute()
            }
        }
        
        StyledText {
            text: Math.round(Audio.volume * 100) + "%"
            font.pixelSize: Config.appearance.font.size
            Layout.preferredWidth: 35
            horizontalAlignment: Text.AlignRight
            opacity: 0.9
        }
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
        
        onWheel: wheel => {
            if (wheel.angleDelta.y > 0) {
                Audio.increaseVolume()
            } else {
                Audio.decreaseVolume()
            }
        }
    }
}
