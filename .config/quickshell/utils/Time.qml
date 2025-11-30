pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    property string time: 
        Qt.formatDateTime(system_clock.date, "ddd MMM d hh:mm:ss AP t");
    

    SystemClock {
        id: system_clock
        precision: SystemClock.Seconds
    }
}
