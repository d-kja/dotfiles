import Quickshell
import QtQuick

import "../utils"

PanelWindow {
  id: root

  readonly property real margin: 8
  required property var modelData
  screen: modelData

  color: "transparent"

  implicitWidth: content.implicitWidth + margin * 2
  implicitHeight: content.implicitHeight + margin * 2

  Rectangle {
    id: content

    anchors.fill: parent
    anchors.margins: root.margin

    x: root.margin / 2
    y: root.margin / 2

    implicitHeight: 40

    radius: 6
    color: "#121214"
  }

  anchors {
    top: true
    left: true
    right: true
  }

  Text {
    id: c
    anchors.centerIn: content
    color: "white"

    text: Time.time
  }
}
