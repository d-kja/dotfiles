pragma ComponentBehavior: Bound
import Quickshell.Io

JsonObject {
  id: spacing_root

  readonly property JsonObject font: JsonObject {
    readonly property real xs: spacing_reference.md
    readonly property real sm: spacing_reference.lg
    readonly property real md: spacing_reference.xl
    readonly property real lg: spacing_reference.xxl
  }

  readonly property JsonObject gap: JsonObject {
    readonly property real xs: spacing_reference.xs
    readonly property real sm: spacing_reference.sm
    readonly property real md: spacing_reference.md
    readonly property real lg: spacing_reference.lg
    readonly property real xl: spacing_reference.xl
  }

  readonly property JsonObject margin: JsonObject {
    readonly property real px: spacing_reference.px
    readonly property real xs: spacing_reference.xs
    readonly property real sm: spacing_reference.sm
    readonly property real smd: spacing_reference.smd
    readonly property real md: spacing_reference.md

    readonly property real lg: spacing_reference.lg
    readonly property real xl: spacing_reference.xl
  }

  readonly property JsonObject rouding: JsonObject {
    id: rounding_reference

    readonly property int sm: 2
    readonly property int md: 4

    readonly property int lg: 6
    readonly property int xl: 8
  }

  readonly property JsonObject spacing: JsonObject {
    id: spacing_reference

    readonly property int px: 1

    readonly property int xs: 2
    readonly property int sm: 4

    readonly property int smd: 6
    readonly property int md: 8

    readonly property int lg: 10
    readonly property int xl: 12

    readonly property int xxl: 16
  }
}
