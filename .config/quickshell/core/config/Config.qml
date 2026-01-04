pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

/**
 * Main configuration singleton
 * Loads configuration from JSON file and provides hot-reload capability
 */
Singleton {
    id: root

    // Ready state
    property bool ready: false

    // Prevent reload loops
    property bool recentlySaved: false

    // Configuration sections
    readonly property QtObject appearance: QtObject {
        property real rounding: 8
        property real spacing: 8
        property real padding: 12

        property real opacity: 0.95

        property color backgroundColor: "#1e1e2e"
        property color foregroundColor: "#cdd6f4"
        property color accentColor: "#89b4fa"
        property color surfaceColor: "#313244"

        readonly property QtObject font: QtObject {
            property string family: "Inter"
            property int size: 11
        }
    }

    readonly property QtObject bar: QtObject {
        property bool enabled: true
        property string position: "top"
        property int height: 40
        property bool showCalendar: true
        property bool showVolume: true
        property bool showInput: true
        property bool showTaskbar: true
    }

    readonly property QtObject audio: QtObject {
        property real volumeStep: 0.05
        property real maxVolume: 1.0
    }

    Component.onCompleted: {
        ready = true;
    }
}
