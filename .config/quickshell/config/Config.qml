pragma Singleton

import Quickshell
import QtQuick

import "./Colors.qml"
import "./Spacing.qml"
import "./Animation.qml"

Singleton {
  id: configuration_root

  readonly property Colors colors: Colors {
    id: colors
  }

  readonly property Spacing spacing: Spacing {
    id: spacing
  }

  readonly property Animation animatuion: Animation {
    id: animation
  }
}
