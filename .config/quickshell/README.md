# Quickshell Configuration

A clean, performant Quickshell configuration with modular architecture.

## Features

- **Top Bar** with:
  - Calendar widget (time and date)
  - Volume control (slider with icon and percentage)
  - Input device control (microphone mute and volume)
  - Taskbar (open windows with focus indication)
- **JSON-based configuration** with hot-reload
- **Material Design-inspired** theming
- **Performance-optimized** with lazy loading and debouncing

## Structure

```
quickshell/
├── shell.qml                    # Entry point
├── config.json                  # User configuration
├── core/
│   ├── config/                  # Configuration system
│   │   └── Config.qml          # Main config singleton
│   └── services/                # Singleton services
│       ├── Audio.qml           # PipeWire audio service
│       └── Hyprland.qml        # Hyprland integration
├── lib/
│   ├── base/                    # Foundation components
│   │   ├── StyledText.qml
│   │   └── StyledButton.qml
│   └── controls/                # Interactive components
│       └── Slider.qml
└── modules/
    └── bar/                     # Top bar module
        ├── Bar.qml             # Main bar component
        └── components/         # Bar widgets
            ├── Calendar.qml
            ├── VolumeControl.qml
            ├── InputControl.qml
            └── Taskbar.qml
```

## Usage

### Running the Shell

```bash
quickshell
```

The shell will automatically load from `~/.config/quickshell/shell.qml`

### Configuration

Edit `~/.config/quickshell/config.json` to customize the shell. Changes are automatically reloaded.

### Customization Examples

#### Change Colors

```json
{
  "appearance": {
    "backgroundColor": "#1a1b26",
    "foregroundColor": "#c0caf5",
    "accentColor": "#7aa2f7",
    "surfaceColor": "#24283b"
  }
}
```

#### Adjust Bar Layout

```json
{
  "bar": {
    "height": 50,
    "showCalendar": true,
    "showVolume": true,
    "showInput": false,
    "showTaskbar": true
  }
}
```

#### Customize Audio

```json
{
  "audio": {
    "volumeStep": 0.1,
    "maxVolume": 1.5
  }
}
```

## Widget Documentation

### Calendar Widget

Displays current time and date with auto-updating timer.

**Features:**
- 12/24 hour time format
- Date in format: "MMM dd, yyyy"
- Clickable (popup not yet implemented)

### Volume Control Widget

Audio output control with visual feedback.

**Features:**
- Volume icon (changes based on level and mute status)
- Interactive slider
- Volume percentage display
- Click icon to mute/unmute
- Scroll to adjust volume
- Hover effects

### Input Control Widget

Microphone/input device control.

**Features:**
- Mute toggle with icon
- Volume slider
- Status indicator (green = active, red = muted)
- Device name tooltip on hover
- Visual feedback for mute state

### Taskbar Widget

Displays open windows for the current monitor.

**Features:**
- One button per window
- First letter of window title as icon
- Focus indication (highlighted + border)
- Full title tooltip on hover
- Left-click to focus window
- Right-click to close window
- Auto-filters windows by monitor

## Architecture Patterns

### Singleton Services

Global state management via singletons:

```qml
import "core/services"

// Access audio service anywhere
Text {
    text: Audio.volume
}

Button {
    onClicked: Audio.toggleMute()
}
```

### Configuration System

Type-safe config with hot-reload:

```qml
import "core/config"

Rectangle {
    color: Config.appearance.backgroundColor
    radius: Config.appearance.rounding
}
```

### Component Hierarchy

Reusable components built on styled base:

```qml
import "lib/base"
import "lib/controls"

StyledText { text: "Hello" }
Slider { from: 0; to: 100 }
```

## Performance Features

1. **Lazy Loading** - Widgets load only when enabled
2. **Debouncing** - Config saves are debounced (500ms)
3. **Efficient Bindings** - Direct property bindings, no JS loops
4. **Optimized Repaints** - Behavior animations for smooth transitions

## Extending the Shell

### Adding a New Widget

1. Create widget in `modules/bar/components/`:

```qml
// modules/bar/components/MyWidget.qml
import QtQuick
import "../../../core/config"
import "../../../lib/base"

Rectangle {
    implicitWidth: 100
    implicitHeight: Config.bar.height - Config.appearance.padding
    color: Config.appearance.surfaceColor
    radius: Config.appearance.rounding
    
    StyledText {
        anchors.centerIn: parent
        text: "My Widget"
    }
}
```

2. Add to bar layout in `modules/bar/Bar.qml`:

```qml
import "components"

RowLayout {
    // ... other widgets
    
    MyWidget {
        Layout.alignment: Qt.AlignVCenter
    }
}
```

3. Add config option in `core/config/Config.qml`:

```qml
readonly property QtObject bar: QtObject {
    property bool showMyWidget: true
    // ...
}
```

### Adding a New Service

1. Create service in `core/services/`:

```qml
// core/services/MyService.qml
pragma Singleton
import Quickshell

Singleton {
    property string data: "Hello"
    
    function doSomething(): void {
        console.log(data)
    }
}
```

2. Register in `core/services/qmldir`:

```
singleton MyService MyService.qml
```

3. Use anywhere:

```qml
import "core/services"

Text {
    text: MyService.data
}
```

## Credits

Architecture inspired by:
- [caelestia-dots/shell](https://github.com/caelestia-dots/shell) - Module-service pattern
- [end-4/dots-hyprland](https://github.com/end-4/dots-hyprland) - Widget library
- [Rexcrazy804/Zaphkiel](https://github.com/Rexcrazy804/Zaphkiel) - Layer-based organization

## License

MIT License - See LICENSE file for details
