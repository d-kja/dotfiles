import QtQuick
import QtQuick.Controls.Basic as QQC
import "../../core/config"
import "../base"

/**
 * Styled slider component
 */
QQC.Slider {
    id: root
    
    implicitWidth: 150
    implicitHeight: 24
    
    background: Rectangle {
        x: root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        width: root.availableWidth
        height: 4
        
        color: Qt.rgba(
            Config.appearance.surfaceColor.r,
            Config.appearance.surfaceColor.g,
            Config.appearance.surfaceColor.b,
            0.5
        )
        radius: 2
        
        Rectangle {
            width: root.visualPosition * parent.width
            height: parent.height
            color: Config.appearance.accentColor
            radius: 2
        }
    }
    
    handle: Rectangle {
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - height / 2
        
        width: 16
        height: 16
        radius: 8
        
        color: root.pressed ? Qt.lighter(Config.appearance.accentColor, 1.2) : Config.appearance.accentColor
        border.color: Qt.lighter(Config.appearance.accentColor, 1.3)
        border.width: root.hovered ? 2 : 1
        
        Behavior on color {
            ColorAnimation { duration: 100 }
        }
        
        Behavior on border.width {
            NumberAnimation { duration: 100 }
        }
    }
}
