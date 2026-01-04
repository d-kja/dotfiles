# Quickshell Configuration Examples

Complete examples and explanations for every feature implemented.

## Table of Contents

1. [Core Framework](#core-framework)
2. [Configuration System](#configuration-system)
3. [Services](#services)
4. [Base Components](#base-components)
5. [Bar Widgets](#bar-widgets)
6. [Customization Examples](#customization-examples)

---

## Core Framework

### Configuration Singleton

The `Config` singleton provides centralized, type-safe configuration with hot-reload capability.

**Location:** `core/config/Config.qml`

**Example Usage:**

```qml
import qs.core.config

Rectangle {
    // Access configuration values
    color: Config.appearance.backgroundColor
    radius: Config.appearance.rounding
    
    // Use nested config objects
    Text {
        font.family: Config.appearance.font.family
        font.pixelSize: Config.appearance.font.size
        color: Config.appearance.foregroundColor
    }
}
```

**How it works:**
1. Reads from `~/.config/quickshell/config.json`
2. Watches for file changes and auto-reloads
3. Provides default values if config file doesn't exist
4. Debounces saves to prevent write loops (500ms delay)

**Configuration Structure:**

```json
{
  "appearance": {
    "rounding": 8,
    "spacing": 8,
    "padding": 12,
    "backgroundColor": "#1e1e2e",
    "foregroundColor": "#cdd6f4",
    "accentColor": "#89b4fa",
    "surfaceColor": "#313244",
    "opacity": 0.95,
    "font": {
      "family": "Inter",
      "size": 11
    }
  },
  "bar": {
    "enabled": true,
    "position": "top",
    "height": 40,
    "showCalendar": true,
    "showVolume": true,
    "showInput": true,
    "showTaskbar": true
  },
  "audio": {
    "volumeStep": 0.05,
    "maxVolume": 1.0
  }
}
```

---

## Configuration System

### Hot Reload

Changes to `config.json` are automatically detected and applied:

```bash
# Edit config
vim ~/.config/quickshell/config.json

# Changes apply automatically - no restart needed!
```

### Programmatic Config Updates

```qml
import qs.core.config

Button {
    text: "Increase Spacing"
    onClicked: {
        Config.appearance.spacing += 2
        Config.save()  // Triggers save with debouncing
    }
}
```

---

## Services

### Audio Service

Provides PipeWire audio control for outputs and inputs.

**Location:** `core/services/Audio.qml`

**Example: Volume Control**

```qml
import qs.core.services

Column {
    // Display current volume
    Text {
        text: `Volume: ${Math.round(Audio.volume * 100)}%`
    }
    
    // Volume slider
    Slider {
        from: 0
        to: 1
        value: Audio.volume
        onValueChanged: Audio.setVolume(value)
    }
    
    // Mute toggle
    Button {
        text: Audio.muted ? "Unmute" : "Mute"
        onClicked: Audio.toggleMute()
    }
    
    // Volume up/down buttons
    Row {
        Button {
            text: "Volume Up"
            onClicked: Audio.increaseVolume()
        }
        Button {
            text: "Volume Down"
            onClicked: Audio.decreaseVolume()
        }
    }
}
```

**Example: Microphone Control**

```qml
import qs.core.services

Column {
    // Mic status
    Text {
        text: Audio.micMuted ? "Mic Muted" : "Mic Active"
        color: Audio.micMuted ? "red" : "green"
    }
    
    // Mic volume
    Slider {
        from: 0
        to: 1
        value: Audio.micVolume
        onValueChanged: Audio.setMicVolume(value)
    }
    
    // Mute toggle
    Button {
        text: "Toggle Mic"
        onClicked: Audio.toggleMicMute()
    }
    
    // Device info
    Text {
        text: `Device: ${Audio.sourceDescription}`
    }
}
```

**Available Properties:**

```qml
// Output (speakers/headphones)
Audio.volume          // 0.0 - 1.0
Audio.muted           // boolean
Audio.sinkDescription // string

// Input (microphone)
Audio.micVolume       // 0.0 - 1.0
Audio.micMuted        // boolean
Audio.sourceDescription // string
```

**Available Methods:**

```qml
Audio.setVolume(0.5)      // Set output volume
Audio.toggleMute()         // Toggle output mute
Audio.increaseVolume()     // Increase by config step
Audio.decreaseVolume()     // Decrease by config step

Audio.setMicVolume(0.7)    // Set input volume
Audio.toggleMicMute()      // Toggle input mute
```

### Hyprland Service

Provides access to Hyprland windows and workspaces.

**Location:** `core/services/Hyprland.qml`

**Example: Window List**

```qml
import qs.core.services

Column {
    Repeater {
        model: HyprlandService.windows
        
        delegate: Rectangle {
            required property var modelData
            
            width: 200
            height: 40
            color: modelData === HyprlandService.focusedWindow 
                ? "blue" 
                : "gray"
            
            Text {
                text: modelData.title
                anchors.centerIn: parent
            }
            
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    HyprlandService.focusWindow(modelData.address)
                }
            }
        }
    }
}
```

**Example: Workspace Switcher**

```qml
import qs.core.services

Row {
    Repeater {
        model: 10
        
        delegate: Button {
            required property int index
            
            text: index + 1
            onClicked: HyprlandService.switchWorkspace(index + 1)
        }
    }
}
```

**Available Properties:**

```qml
HyprlandService.windows        // All windows
HyprlandService.workspaces     // All workspaces
HyprlandService.focusedWindow  // Currently focused window
```

**Available Methods:**

```qml
HyprlandService.getWindowsForMonitor(monitor)  // Filter by monitor
HyprlandService.getVisibleWindows()            // Non-minimized windows
HyprlandService.focusWindow(address)           // Focus specific window
HyprlandService.closeWindow(address)           // Close window
HyprlandService.switchWorkspace(id)            // Switch workspace
```

---

## Base Components

### StyledText

Text component with automatic theming.

**Location:** `lib/base/StyledText.qml`

**Example:**

```qml
import qs.lib.base

Column {
    StyledText {
        text: "Normal text"
    }
    
    StyledText {
        text: "Bold text"
        bold: true
    }
    
    StyledText {
        text: "Custom size"
        font.pixelSize: 16
    }
}
```

**Properties:**
- Inherits all `Text` properties
- `bold: bool` - Convenience property for bold text
- Automatically uses theme colors and fonts from Config

### StyledButton

Button with hover and press states.

**Location:** `lib/base/StyledButton.qml`

**Example:**

```qml
import qs.lib.base

Column {
    StyledButton {
        text: "Click me"
        onClicked: console.log("Clicked!")
    }
    
    StyledButton {
        text: "Disabled"
        enabled: false
    }
}
```

**Properties:**
- `text: string` - Button label
- `enabled: bool` - Interactive state

**Signals:**
- `clicked()` - Emitted on click

**Visual States:**
- Normal: Accent color
- Hover: Lighter accent color
- Pressed: Darker accent color
- Disabled: Semi-transparent gray

### Slider

Styled slider control.

**Location:** `lib/controls/Slider.qml`

**Example:**

```qml
import qs.lib.controls

Slider {
    from: 0
    to: 100
    value: 50
    stepSize: 1
    
    onValueChanged: {
        console.log("New value:", value)
    }
}
```

**Inherits:** Qt Quick Controls Slider

**Styled Elements:**
- Background track (surface color)
- Progress track (accent color)
- Handle (accent color with hover effects)

---

## Bar Widgets

### Calendar Widget

Displays current time and date with auto-updating.

**Location:** `modules/bar/components/Calendar.qml`

**Features:**
- Updates every second
- Time format: "hh:mm" (24-hour)
- Date format: "MMM dd, yyyy"
- Clickable (for future popup)

**Example:**

```qml
import "../modules/bar/components"

Calendar {
    // That's it! Auto-updates
}
```

**Customization:**

```qml
// Change update interval
Timer {
    interval: 60000  // Update every minute instead
    running: true
    repeat: true
    triggeredOnStart: true
    
    onTriggered: {
        const now = new Date()
        timeText.text = Qt.formatTime(now, "h:mm AP")  // 12-hour format
        dateText.text = Qt.formatDate(now, "ddd, MMM d")
    }
}
```

### Volume Control Widget

Audio output control with visual feedback.

**Location:** `modules/bar/components/VolumeControl.qml`

**Features:**
- Dynamic volume icon (🔇 🔈 🔉 🔊)
- Interactive slider
- Percentage display
- Click icon to mute
- Scroll to adjust volume
- Smooth animations

**Example:**

```qml
import "../modules/bar/components"

VolumeControl {
    // Auto-connects to Audio service
}
```

**Interactions:**
- Click icon → Toggle mute
- Drag slider → Set volume
- Scroll anywhere → Adjust volume by step

### Input Control Widget

Microphone/input device control.

**Location:** `modules/bar/components/InputControl.qml`

**Features:**
- Mute toggle icon (🎤 / 🎙️)
- Volume slider
- Status LED (green/red)
- Device name tooltip
- Visual feedback

**Example:**

```qml
import "../modules/bar/components"

InputControl {
    // Auto-connects to Audio service
}
```

**Visual States:**
- Active: Solid icon, green LED
- Muted: Faded icon, red LED

### Taskbar Widget

Window manager taskbar.

**Location:** `modules/bar/components/Taskbar.qml`

**Features:**
- Shows open windows
- Per-monitor filtering
- Focus indication
- Window title tooltips
- Click to focus
- Right-click to close

**Example:**

```qml
import "../modules/bar/components"

Taskbar {
    screen: Quickshell.screens[0]
}
```

**Interactions:**
- Left-click → Focus window
- Right-click → Close window
- Hover → Show full title

**Visual:**
- Focused window: Blue background + border
- Other windows: Transparent background
- Empty: "No windows" message

---

## Customization Examples

### Example 1: Custom Color Scheme

**Catppuccin Mocha Theme:**

```json
{
  "appearance": {
    "backgroundColor": "#1e1e2e",
    "foregroundColor": "#cdd6f4",
    "accentColor": "#89b4fa",
    "surfaceColor": "#313244"
  }
}
```

**Tokyo Night Theme:**

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

**Gruvbox Dark Theme:**

```json
{
  "appearance": {
    "backgroundColor": "#282828",
    "foregroundColor": "#ebdbb2",
    "accentColor": "#458588",
    "surfaceColor": "#3c3836"
  }
}
```

### Example 2: Minimal Bar

Hide everything except taskbar:

```json
{
  "bar": {
    "showCalendar": false,
    "showVolume": false,
    "showInput": false,
    "showTaskbar": true
  }
}
```

### Example 3: Tall Bar with Large Font

```json
{
  "bar": {
    "height": 60
  },
  "appearance": {
    "font": {
      "size": 14
    },
    "padding": 16,
    "spacing": 12
  }
}
```

### Example 4: High Contrast

```json
{
  "appearance": {
    "backgroundColor": "#000000",
    "foregroundColor": "#ffffff",
    "accentColor": "#00ff00",
    "surfaceColor": "#333333",
    "opacity": 1.0
  }
}
```

### Example 5: Rounded Everything

```json
{
  "appearance": {
    "rounding": 20,
    "padding": 16
  }
}
```

### Example 6: Louder Volume (>100%)

```json
{
  "audio": {
    "maxVolume": 1.5,
    "volumeStep": 0.1
  }
}
```

### Example 7: Custom Font

```json
{
  "appearance": {
    "font": {
      "family": "JetBrains Mono",
      "size": 12
    }
  }
}
```

---

## Creating Custom Widgets

### Step 1: Create Widget File

`modules/bar/components/CustomWidget.qml`:

```qml
import QtQuick
import QtQuick.Layouts
import "../../../core/config"
import "../../../lib/base"

Rectangle {
    id: root
    
    implicitWidth: layout.implicitWidth + Config.appearance.padding * 2
    implicitHeight: Config.bar.height - Config.appearance.padding
    
    color: Qt.rgba(
        Config.appearance.surfaceColor.r,
        Config.appearance.surfaceColor.g,
        Config.appearance.surfaceColor.b,
        0.5
    )
    radius: Config.appearance.rounding
    
    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: Config.appearance.spacing
        
        StyledText {
            text: "Custom!"
            bold: true
        }
    }
}
```

### Step 2: Add to Bar

`modules/bar/Bar.qml`:

```qml
import "components"

RowLayout {
    // ... existing widgets
    
    CustomWidget {
        visible: Config.bar.showCustom  // Add config option
        Layout.alignment: Qt.AlignVCenter
    }
}
```

### Step 3: Add Config Option

`core/config/Config.qml`:

```qml
readonly property QtObject bar: QtObject {
    property bool showCustom: true
    // ...
}
```

### Step 4: Add to JSON Schema

`config.json`:

```json
{
  "bar": {
    "showCustom": true
  }
}
```

---

## Performance Tips

1. **Use Loader for heavy widgets:**

```qml
Loader {
    active: visible && Config.bar.showHeavyWidget
    sourceComponent: HeavyWidget {}
}
```

2. **Debounce frequent updates:**

```qml
Timer {
    id: updateDebounce
    interval: 150
    onTriggered: performUpdate()
}

onDataChanged: updateDebounce.restart()
```

3. **Use Behavior for smooth animations:**

```qml
Rectangle {
    color: hovered ? "blue" : "gray"
    Behavior on color {
        ColorAnimation { duration: 150 }
    }
}
```

4. **Avoid JS loops in bindings:**

```qml
// ❌ BAD
property var items: someArray.filter(x => x.visible)

// ✅ GOOD
Repeater {
    model: someArray
    delegate: Item { visible: modelData.visible }
}
```

---

## Troubleshooting

### Config not loading

Check file path:

```bash
ls ~/.config/quickshell/config.json
```

Check JSON syntax:

```bash
cat ~/.config/quickshell/config.json | jq
```

### Widgets not showing

Check config:

```json
{
  "bar": {
    "enabled": true,
    "showCalendar": true,
    // etc.
  }
}
```

Check logs:

```bash
quickshell 2>&1 | grep -i error
```

### Audio not working

Check PipeWire:

```bash
pw-cli info all | grep -i audio
```

Test audio service:

```bash
# In QML
console.log("Sink:", Audio.sink)
console.log("Volume:", Audio.volume)
```

---

*For architectural patterns and design decisions, see `QUICKSHELL_PATTERNS.md`*
