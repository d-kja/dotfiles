import QtQuick
import QtQuick.Layouts
import "../../../core/config"
import "../../../lib/base"

/**
 * Calendar widge
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
    
    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        
        onTriggered: {
            const now = new Date()
            timeText.text = Qt.formatTime(now, "hh:mm")
            dateText.text = Qt.formatDate(now, "ddd, MMM d")
        }
    }
    
    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: Config.appearance.spacing
        
        StyledText {
            id: timeText
            font.pixelSize: Config.appearance.font.size
            bold: true
        }
        
        Rectangle {
            width: 1
            height: parent.height * 0.6
            color: Config.appearance.foregroundColor
            opacity: 0.3
        }
        
        StyledText {
            id: dateText
            font.pixelSize: Config.appearance.font.size
            opacity: 0.8
        }
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        
        onClicked: {
            console.log("Calendar clicked")
        }
    }
}
