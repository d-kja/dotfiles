//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QSG_RENDER_LOOP=threaded
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

import Quickshell
import Quickshell.Wayland
import QtQuick

ShellRoot {
    Variants {
        model: Quickshell.screens

        WlrLayershell {
            id: collapsable_bar

            required property var modelData

            // Overlay setup
            exclusiveZone: 0
            layer: WlrLayer.Overlay

            keyboardFocus: WlrKeyboardFocus.None

            screen: modelData
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            property bool is_collapsed: true // Default behavior

            property int collapsed_height: 4
            property int expanded_height: 40

            implicitHeight: is_collapsed ? collapsed_height : expanded_height

            // Handles hover behavior to expand/collapse component
            HoverHandler {
                onHoveredChanged: {
                    if (hovered) {
                        collapsable_bar.is_collapsed = false;

                        collapse_timer.stop();
                        return;
                    }

                    // fallback
                    collapse_timer.restart();
                }
            }

            // Create a small delay before collapsing
            Timer {
                id: collapse_timer

                interval: 250 // ms
                onTriggered: collapsable_bar.is_collapsed = true
            }

            // Expand / collapse animation
            Behavior on implicitHeight {
                NumberAnimation {
                    duration: 300

                    easing {
                        type: Easing.OutCubic
                    }
                }
            }

            // VISIBLE CONTENT
            Rectangle {
                anchors.fill: parent
                color: "transparent"

                Row {
                    id: bar_content

                    anchors.centerIn: parent

                    spacing: 20
                    opacity: collapsable_bar.is_collapsed ? 0 : 1

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 150
                        }
                    }

                    Text {
                        text: "Home"
                        color: "white"
                    }
                    Text {
                        text: "Settings"
                        color: "white"
                    }
                }
            }
        }
    }
}
