pragma ComponentBehavior: Bound
import Quickshell.Io

JsonObject {
  id: animation_root

  readonly property JsonObject curves: JsonObject {
    property list<real> base: [0.2, 0, 0, 1, 1, 1]
    property list<real> acceleration: [0.3, 0, 1, 1, 1, 1]
    property list<real> deceleration: [0, 0, 0, 1, 1, 1]
  }

  readonly property JsonObject curves_expressive: JsonObject {
    property list<real> base: [0.38, 1.21, 0.22, 1, 1, 1]
    property list<real> fast: [0.42, 1.67, 0.21, 0.9, 1, 1]
    property list<real> effects: [0.34, 0.8, 0.34, 1, 1, 1]
  }

  readonly property JsonObject curves_emphasized: JsonObject {
    property list<real> base: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
    property list<real> acceleration: [0.3, 0, 0.8, 0.15, 1, 1]
    property list<real> deceleration: [0.05, 0.7, 0.1, 1, 1, 1]
  }

  readonly property JsonObject durations: JsonObject {
    property int sm: 200
    property int base: 400
    property int lg: 600
    property int xl: 1000
  }
}
