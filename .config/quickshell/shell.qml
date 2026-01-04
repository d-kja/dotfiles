import QtQuick
import Quickshell
import qs.core.config
import qs.modules.bar

/**
 * Main shell entry point
 */
ShellRoot {
    id: root

    Bar {}

    // Expose Config and debug output
    Component.onCompleted: {
        Qt.application.Config = Config;

        console.log("Config ready:", Config.ready);
        console.log("Screens:", Quickshell.screens.length);
    }
}
