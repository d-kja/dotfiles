import QtQuick
import "../../core/config"

/**
 * Styled text component with theme support
 * 
 * @example
 * StyledText {
 *     text: "Hello World"
 *     bold: true
 * }
 */
Text {
    id: root
    
    property bool bold: false
    
    color: Config.appearance.foregroundColor
    font.family: Config.appearance.font.family
    font.pixelSize: Config.appearance.font.size
    font.bold: bold
    
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignLeft
    
    elide: Text.ElideRight
}
