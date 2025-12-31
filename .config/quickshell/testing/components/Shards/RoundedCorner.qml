import QtQuick
import QtQuick.Shapes

Item {
  id: root

  enum CornerEnum {
    TOP_LEFT,
    TOP_RIGHT,
    BOTTOM_LEFT,
    BOTTOM_RIGHT
  }

  required property color color

  required property var corner
  required property int size

  implicitWidth: size
  implicitHeight: size

  property bool isTop: corner === RoundedCorner.CornerEnum.TOP_RIGHT || corner === RoundedCorner.CornerEnum.TOP_LEFT
  property bool isBottom: corner === RoundedCorner.CornerEnum.BOTTOM_RIGHT || corner === RoundedCorner.CornerEnum.BOTTOM_LEFT

  property bool isRight: corner === RoundedCorner.CornerEnum.TOP_RIGHT || corner === RoundedCorner.CornerEnum.BOTTOM_RIGHT
  property bool isLeft: corner === RoundedCorner.CornerEnum.TOP_LEFT || corner === RoundedCorner.CornerEnum.BOTTOM_LEFT

  Shape {
    id: shape_reference

    anchors {
      // Y AXIS
      top: root.isTop ? parent.top : undefined
      bottom: root.isBottom ? parent.bottom : undefined

      // X AXIS
      left: root.isLeft ? parent.left : undefined
      right: root.isRight ? parent.right : undefined
    }

    layer.enabled: true
    layer.smooth: true

    preferredRendererType: Shape.CurveRenderer

    ShapePath {
      id: shape

      strokeWidth: 0
      fillColor: root.color

      pathHints: ShapePath.PathSolid & ShapePath.PathNonIntersecting

      startX: switch (root.corner) {
      case RoundedCorner.CornerEnum.TOP_LEFT:
      case RoundedCorner.CornerEnum.BOTTOM_LEFT:
        {
          return 0;
        }
      case RoundedCorner.CornerEnum.TOP_RIGHT:
      case RoundedCorner.CornerEnum.BOTTOM_RIGHT:
        {
          return root.size;
        }
      }

      startY: switch (root.corner) {
      case RoundedCorner.CornerEnum.TOP_LEFT:
      case RoundedCorner.CornerEnum.TOP_RIGHT:
        {
          return 0;
        }
      case RoundedCorner.CornerEnum.BOTTOM_LEFT:
      case RoundedCorner.CornerEnum.BOTTOM_RIGHT:
        {
          return root.size;
        }
      }

      PathAngleArc {
        moveToStart: false

        centerX: root.size - shape.startX
        centerY: root.size - shape.startY
        radiusX: root.size
        radiusY: root.size

        startAngle: switch (root.corner) {
        case RoundedCorner.CornerEnum.TOP_LEFT:
          return 180;
        case RoundedCorner.CornerEnum.TOP_RIGHT:
          return -90;
        case RoundedCorner.CornerEnum.BOTTOM_LEFT:
          return 90;
        case RoundedCorner.CornerEnum.BOTTOM_RIGHT:
          return 0;
        }

        sweepAngle: 90
      }

      PathLine {
        x: shape.startX
        y: shape.startY
      }
    }
  }
}
