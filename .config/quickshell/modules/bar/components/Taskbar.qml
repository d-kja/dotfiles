import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "../../../core/config"
import "../../../core/services"
import "../../../lib/base"

/**
 * Taskbar
 */
Item {
    id: root
    
    required property var screen
    
    implicitWidth: layout.implicitWidth
    implicitHeight: parent.height
    
    RowLayout {
        id: layout
        anchors.fill: parent
        spacing: Config.appearance.spacing / 2
        
        Repeater {
            model: HyprlandService.getWindowsForMonitor(root.screen)
            
            delegate: Rectangle {
                id: windowButton
                
                required property HyprlandToplevel modelData
                
                Layout.preferredWidth: 36
                Layout.preferredHeight: parent.height - Config.appearance.padding / 2
                Layout.alignment: Qt.AlignVCenter
                
                radius: Config.appearance.rounding
                
                property bool isFocused: modelData === HyprlandService.focusedWindow
                
                color: {
                    if (isFocused) return Config.appearance.accentColor
                    if (mouseArea.containsMouse) return Qt.rgba(Config.appearance.surfaceColor.r, Config.appearance.surfaceColor.g, Config.appearance.surfaceColor.b, 0.5)
                    return Qt.rgba(Config.appearance.surfaceColor.r, Config.appearance.surfaceColor.g, Config.appearance.surfaceColor.b, 0.3)
                }
                
                Behavior on color {
                    ColorAnimation { duration: 150 }
                }
                
                // Active indicator
                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: 2
                    width: parent.width * 0.6
                    height: 2
                    radius: 1
                    color: Config.appearance.accentColor
                    visible: windowButton.isFocused
                }
                
                StyledText {
                    anchors.centerIn: parent
                    text: {
                        const title = windowButton.modelData.title || ""
                        if (title.length > 0) return title.charAt(0).toUpperCase()
                        const appId = windowButton.modelData.appId || ""
                        if (appId.length > 0) return appId.charAt(0).toUpperCase()
                        return "•"
                    }
                    font.pixelSize: Config.appearance.font.size + 1
                    bold: windowButton.isFocused
                    color: windowButton.isFocused ? "#ffffff" : Config.appearance.foregroundColor
                }
                
                Rectangle {
                    id: tooltip
                    visible: mouseArea.containsMouse && tooltipText.text.length > 0
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 6
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: tooltipText.implicitWidth + 12
                    height: tooltipText.implicitHeight + 8
                    color: Config.appearance.backgroundColor
                    radius: Config.appearance.rounding / 2
                    border.color: Qt.rgba(Config.appearance.accentColor.r, Config.appearance.accentColor.g, Config.appearance.accentColor.b, 0.3)
                    border.width: 1
                    opacity: 0
                    
                    StyledText {
                        id: tooltipText
                        anchors.centerIn: parent
                        text: windowButton.modelData?.title || ""
                        font.pixelSize: Config.appearance.font.size - 1
                    }
                    
                    states: State {
                        name: "visible"
                        when: mouseArea.containsMouse
                        PropertyChanges { target: tooltip; opacity: 1 }
                    }
                    
                    transitions: Transition {
                        NumberAnimation { property: "opacity"; duration: 200 }
                    }
                }
                
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    
                    onClicked: mouse => {
                        if (mouse.button === Qt.LeftButton) {
                            HyprlandService.focusWindow(windowButton.modelData.address)
                        } else if (mouse.button === Qt.RightButton) {
                            HyprlandService.closeWindow(windowButton.modelData.address)
                        }
                    }
                }
            }
        }
    }
}
