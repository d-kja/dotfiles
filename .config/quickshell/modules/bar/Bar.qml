import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../../core/config"
import "components"

/**
 * Main bar component
 */
PanelWindow {
    id: root
    
    property var scr: Quickshell.screens[0]
    
    anchors {
        top: true
        left: true
        right: true
    }
    
    implicitHeight: Config.bar.height
    color: "transparent"

    mask: Region { item: barBackground }
    
    WlrLayershell.namespace: "shell:bar"
    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
    
    Rectangle {
        id: barBackground
        anchors.fill: parent
        
        color: Qt.rgba(
            Config.appearance.backgroundColor.r,
            Config.appearance.backgroundColor.g,
            Config.appearance.backgroundColor.b,
            Config.appearance.opacity
        )
        
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: Config.appearance.padding
            anchors.rightMargin: Config.appearance.padding
            anchors.topMargin: Config.appearance.padding / 2
            anchors.bottomMargin: Config.appearance.padding / 2
            spacing: Config.appearance.spacing
            
            // Left section - Taskbar
            Taskbar {
                screen: root.scr
                visible: Config.bar.showTaskbar
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            
            // Center spacer
            Item {
                Layout.fillWidth: true
            }
            
            // Right section - System controls
            RowLayout {
                spacing: Config.appearance.spacing
                Layout.fillHeight: true
                
                InputControl {
                    visible: Config.bar.showInput
                    Layout.fillHeight: true
                }
                
                VolumeControl {
                    visible: Config.bar.showVolume
                    Layout.fillHeight: true
                }
                
                Calendar {
                    visible: Config.bar.showCalendar
                    Layout.fillHeight: true
                }
            }
        }
    }
}
