# Reference Study: end-4/dots-hyprland Quickshell Architecture

## Purpose
Architectural reference study for building a well-organized Quickshell configuration.
This is **NOT** a feature checklist - we're studying patterns and organization strategies.

**Explicitly excluded from our implementation:**
- ❌ AI integration (LLM services, chat interfaces)
- ❌ Wallpaper management (theme generation, color extraction)
- ❌ Booru/anime search features
- ❌ Work safety features

**Focus areas for reference:**
- ✅ Code organization patterns
- ✅ Service singleton architecture
- ✅ Lazy loading strategies
- ✅ Component library structure
- ✅ Material Design 3 color system (static themes)
- ✅ Panel family concept
- ✅ Focus management patterns
- ✅ Configuration management
- ✅ Performance optimizations

---

## Repository Context
- **Source:** https://github.com/end-4/dots-hyprland/tree/main/dots/.config/quickshell/ii
- **Analysis Date:** January 3, 2026
- **Scale:** 870 files (556 QML, 6 JS)
- **Author:** end-4 (illogical-impulse configuration)

---

## 1. Folder Structure Pattern

### Their Organization
```
ii/
├── modules/
│   ├── common/              # ← Shared infrastructure
│   │   ├── functions/       # Pure utility functions
│   │   ├── models/          # Data structures
│   │   ├── widgets/         # Reusable UI components (100+)
│   │   ├── Appearance.qml   # Theming system
│   │   ├── Config.qml       # Configuration management
│   │   └── Persistent.qml   # State persistence
│   ├── ii/                  # Panel family (Material Design)
│   └── waffle/              # Panel family (Windows-like)
├── services/                # Singleton services (50)
├── translations/            # i18n support
└── shell.qml               # Entry point
```

### Key Takeaways
- **Three-tier separation:** common (shared) → panel families → entry point
- **Service layer:** All business logic in singletons
- **Widget library:** Centralized reusable components
- **Functions as modules:** Utility functions grouped by domain

---

## 2. Architectural Patterns Worth Adopting

### A. Singleton Service Layer
**Pattern:**
```qml
pragma Singleton
import QtQuick

Singleton {
    id: root
    property bool sidebarOpen: false
    // Globally accessible state/logic
}
```

**Benefits:**
- Global state without prop drilling
- Lazy loading (only created when accessed)
- Clear dependency graph
- Easy testing/mocking

**Our services candidates:**
- Hyprland interaction
- Audio control
- Brightness control
- Network status
- Notifications
- Time/Date
- System info

### B. Lazy Loading Pattern
**Pattern:**
```qml
Loader {
    active: GlobalStates.sidebarOpen || Config.keepLoaded
    sourceComponent: SidebarContent {}
}
```

**Benefits:**
- Reduced startup time
- Lower memory footprint
- Conditional feature loading

**Where to apply:**
- Sidebars (only when opened)
- Dashboard (only when visible)
- Settings panels
- Heavy widgets

### C. Panel Family System
**Pattern:**
```qml
component PanelFamilyLoader: Loader {
    property string identifier
    active: Config.panelFamily === identifier
}

PanelFamilyLoader {
    identifier: "modern"
    component: ModernFamily {}
}
```

**Benefits:**
- Runtime theme switching
- Shared backend services
- A/B testing UIs
- Clean separation

**Our use case:**
- Start with single family
- Structure allows future themes
- Good for experimenting with layouts

### D. Variants for Multi-Monitor
**Pattern:**
```qml
Variants {
    model: Quickshell.screens
    PanelWindow {
        required property var modelData
        screen: modelData
        // Per-monitor instance
    }
}
```

**Already using this** - good to confirm best practice.

### E. Global Focus Management
**Pattern:**
```qml
// GlobalFocusGrab singleton
property list<var> persistent: []   // Bar, keyboard
property list<var> dismissable: []  // Sidebars, menus

HyprlandFocusGrab {
    windows: [...persistent, ...dismissable]
    active: dismissable.length > 0
    onCleared: () => dismiss()
}
```

**Benefits:**
- Single focus grab for all windows
- Persistent vs dismissable distinction
- No conflicting grabs

**Current issue this solves:**
We might have focus management scattered across modules.

---

## 3. Component Organization

### A. Widget Library Structure
**Their approach:**
- 100+ widgets in `modules/common/widgets/`
- Prefixing: `Styled*`, `Material*`
- Base components with extension points

**Our opportunity:**
Create reusable widget library:
```
modules/common/widgets/
├── buttons/
│   ├── RippleButton.qml
│   └── IconButton.qml
├── containers/
│   ├── StyledWindow.qml
│   └── StyledFlickable.qml
├── indicators/
│   ├── CircularProgress.qml
│   └── MaterialIcon.qml
└── layout/
    ├── Sidebar.qml
    └── NavigationRail.qml
```

### B. Inline Components
**Pattern:**
```qml
component RippleAnim: NumberAnimation {
    duration: 200
    easing.type: Easing.OutCubic
}

// Use multiple times in same file
RippleAnim { target: circle; property: "radius" }
```

**Benefits:**
- Local reusability
- Cleaner than repeating code
- Better than separate files for tiny components

### C. Appearance System
**Their `Appearance.qml` (404 lines):**
```qml
pragma Singleton
Singleton {
    property QtObject m3colors: QtObject {
        property color m3background: "#1c1b1f"
        property color m3surface: "#1c1b1f"
        // ... 60+ M3 tokens
    }
    
    property QtObject colors: QtObject {
        // Layered system
        property color colLayer0: m3background
        property color colLayer1: m3surfaceContainerLow
        property color colOnLayer1: m3onSurface
        // ... with hover/active states
    }
    
    property QtObject animation: QtObject {
        property QtObject elementMove: QtObject {
            property int duration: 500
            property list<real> bezierCurve: [0.2, 0.0, 0, 1.0]
            property Component numberAnimation: Component { ... }
        }
    }
    
    property QtObject rounding: QtObject {
        property int small: 12
        property int normal: 17
        property int large: 23
    }
    
    property QtObject font: QtObject { ... }
}
```

**Our adoption:**
- Keep Material 3 color tokens (static colors)
- Animation system with reusable components
- Typography system
- Spacing/rounding scales
- **Skip:** Wallpaper color extraction, dynamic transparency

---

## 4. Configuration Management

### Their System
**628-line `Config.qml`:**
```qml
FileView {
    path: configFilePath
    watchChanges: true
    onFileChanged: debounceTimer.restart()  // 50ms
    
    adapter: JsonAdapter {
        property string theme: "dark"
        property JsonObject bar: JsonObject {
            property bool bottom: false
            property int height: 40
            // ... nested config
        }
    }
}
```

**Benefits:**
- Declarative configuration
- Auto-serialization to JSON
- External change detection
- Type-safe property access
- Debounced writes

**Our current approach:**
We have `Config.qml` but could improve:
- Add debouncing for writes
- Better nesting with JsonObject
- External file watching

---

## 5. Performance Patterns

### A. Memory Optimization
```qml
// Truncate decimal to reduce font remapping
property real fill: iconHovered ? 1 : 0
property real truncatedFill: fill.toFixed(1)

font.variableAxes: { "FILL": truncatedFill }
```

### B. Debounced Operations
```qml
Timer {
    id: writeTimer
    interval: 50  // ms
    onTriggered: fileView.writeAdapter()
}

onConfigChanged: writeTimer.restart()
```

**Apply to:**
- Config writes
- Search queries
- File reloads

### C. Animation Components
```qml
// Define once
property Component fadeAnim: Component {
    NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
}

// Use everywhere
Behavior on opacity {
    animation: Appearance.fadeAnim.createObject(this)
}
```

**Benefits:**
- Consistent timing
- Single source of truth
- Easy to adjust globally

---

## 6. Code Organization Standards

### A. File Naming
- **Components:** PascalCase (`RippleButton.qml`)
- **Utilities:** camelCase (`colorUtils.js`)
- **Prefixes:** Feature-based (`Styled*`, `Material*`, `Bar*`)

### B. Property Ordering
```qml
Item {
    // 1. Required properties
    required property var data
    
    // 2. State properties
    property bool open: false
    
    // 3. Configuration
    property real radius: Appearance.rounding.small
    
    // 4. Computed/readonly
    readonly property bool isActive: open && enabled
    
    // 5. Signals
    signal closed()
    
    // 6. Functions
    function toggle() { open = !open }
    
    // 7. Child components
}
```

### C. Import Organization
```qml
// 1. QML/Qt imports
import QtQuick
import QtQuick.Layouts

// 2. Quickshell imports
import Quickshell
import Quickshell.Wayland

// 3. Project imports
import qs.modules.common
import qs.modules.common.widgets
import qs.services
```

### D. Pragma Usage
```qml
pragma Singleton                    // For singletons
pragma ComponentBehavior: Bound     // Strict scoping
```

---

## 7. Patterns to Avoid / Simplify

### Skip These Features
1. **Wallpaper Management**
   - Color extraction (ColorQuantizer)
   - Dynamic transparency calculation
   - Theme generation scripts
   - Wallpaper selector UI

2. **AI Integration**
   - LLM service layer
   - API strategies
   - Chat UI components
   - Prompt management

3. **Overcomplicated Features**
   - Work safety system
   - Booru integration
   - Music recognition
   - Emoji picker (if not needed)

### Simplify These
1. **Translation System**
   - Keep if multilingual needed
   - Otherwise skip for simpler setup

2. **Multiple Panel Families**
   - Start with one family
   - Add structure for future expansion

3. **Overlay Widget System**
   - Skip floating widgets initially
   - Focus on core panels first

---

## 8. Recommended Folder Structure

### Proposed for Our Config
```
quickshell/
├── modules/
│   ├── common/
│   │   ├── functions/           # ColorUtils, DateUtils, etc.
│   │   ├── models/              # Data structures
│   │   ├── widgets/             # Reusable components
│   │   │   ├── buttons/
│   │   │   ├── containers/
│   │   │   ├── indicators/
│   │   │   └── layout/
│   │   ├── Appearance.qml       # Theme system
│   │   ├── Config.qml           # Configuration
│   │   └── Directories.qml      # Path management
│   │
│   └── main/                    # Our panel family
│       ├── bar/
│       ├── background/
│       ├── dashboard/
│       ├── launcher/
│       ├── lock/
│       ├── notifications/
│       ├── osd/
│       ├── session/
│       ├── sidebar/
│       └── utilities/
│
├── services/                    # Singleton services
│   ├── Audio.qml
│   ├── Brightness.qml
│   ├── DateTime.qml
│   ├── GlobalStates.qml
│   ├── Hypr.qml
│   ├── Network.qml
│   ├── Notifications.qml
│   └── SystemInfo.qml
│
└── shell.qml                    # Entry point
```

---

## 9. Migration Strategy

### Phase 1: Foundation
1. Create service singletons
2. Build Appearance system
3. Set up widget library structure
4. Establish common utilities

### Phase 2: Module Refactoring
1. Convert existing modules to new structure
2. Implement lazy loading
3. Add focus management
4. Update imports

### Phase 3: Polish
1. Add animations
2. Optimize performance
3. Documentation
4. Testing

---

## 10. Key Differences from end-4

### What We're Adopting
✅ Service singleton architecture
✅ Lazy loading pattern
✅ Widget library organization
✅ Material Design 3 color system (static)
✅ Appearance centralization
✅ Configuration management patterns
✅ Focus management approach
✅ Code organization standards

### What We're Skipping
❌ Wallpaper color extraction
❌ Dynamic transparency calculation
❌ AI integration
❌ Booru features
❌ Work safety system
❌ Multiple panel families (initially)
❌ Translation system (unless needed)

### Our Unique Requirements
- Keep existing feature set
- Simpler, focused scope
- Performance-first approach
- Maintainability over features

---

## Conclusion

The end-4 config provides excellent **architectural patterns** we can adopt:
- Service-oriented design
- Lazy loading strategies
- Widget library organization
- Configuration management
- Performance optimizations

While avoiding the **feature complexity** we don't need:
- Wallpaper theming
- AI integration
- Niche features

**Next Step:** Create a detailed refactoring plan applying these patterns to our existing Quickshell config.
