pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Hyprland

/**
 * Hyprland service singleton
 */
Singleton {
    id: root

    // All toplevels (windows)
    readonly property var windows: Hyprland.toplevels

    // Workspaces
    readonly property var workspaces: Hyprland.workspaces

    // Get windows for current monitor
    function getWindowsForMonitor(monitor: var): var {
        if (!windows?.length)
            return [];

        return windows.filter(window => {
            return window.monitor?.name === monitor?.name && !window.floating;
        });
    }

    // Get all non-minimized windows
    function getVisibleWindows(): var {
        if (!windows)
            return [];

        return windows.filter(window => {
            return window.mapped && window.workspace?.id >= 0;
        });
    }

    // Focus window
    function focusWindow(address: string): void {
        Hyprland.dispatch("focuswindow", `address:${address}`);
    }

    // Close window
    function closeWindow(address: string): void {
        Hyprland.dispatch("closewindow", `address:${address}`);
    }

    // Switch to workspace
    function switchWorkspace(id: int): void {
        Hyprland.dispatch("workspace", id.toString());
    }
}
