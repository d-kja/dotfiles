//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QSG_RENDER_LOOP=threaded
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

import Quickshell
import QtQuick

import "components"

ShellRoot {
    id: root

    Variants {
        model: Quickshell.screens

        Bar {}
    }
}
