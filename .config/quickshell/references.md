# Quickshell Project References

## Documentation

- [Quickshell](https://quickshell.org/docs/v0.1.0/types/Quickshell/)
- [The QT 6 Book](https://qmlbook.ir/ch04-qmlstart/qml-syntax.html#properties)
- [Quickshell Examples](https://git.outfoxxed.me/quickshell/quickshell-examples)

## Analyzed Configurations

### 1. Caelestia Shell (Primary Inspiration)
- **Repository**: https://github.com/caelestia-dots/shell
- **Stars**: 6.8k ⭐
- **Architecture**: Module-Service Hybrid
- **Key Features**:
  - Material Design 3 theming
  - 31 singleton services
  - Extensive configuration system (JSON-based)
  - C++ plugin for performance (audio visualization, image analysis)
  - Multi-monitor support with Variants
  - Drawer system for panel management
  - IPC command system via caelestia-cli

### 2. end-4/dots-hyprland (illogical-impulse)
- **Repository**: https://github.com/end-4/dots-hyprland/tree/main/dots/.config/quickshell/ii
- **Stars**: 11.8k ⭐ (full dots repo)
- **Architecture**: Panel Family System
- **Key Features**:
  - Multiple UI themes (ii, waffle) with runtime switching
  - 50+ singleton services
  - 100+ reusable widgets
  - AI integration (Gemini, OpenAI, Mistral)
  - Translation system (8 languages)
  - Material Design 3 color system
  - Dynamic wallpaper-based theming

### 3. Rexcrazy804/Zaphkiel
- **Repository**: https://github.com/Rexcrazy804/Zaphkiel/tree/master/dots/quickshell
- **Stars**: 253 ⭐
- **Architecture**: Layer-Based
- **Key Features**:
  - iPhone-style notch interface
  - Layer-based organization
  - State machine animations
  - Material Design 3 easing curves
  - Greetd integration (display manager)
  - Process incubation pattern

### 4. Other References
- [Xanazf](https://github.com/Xanazf/quickshell_config)

## Pattern Summary

### Architecture Patterns
1. **Module-Service Hybrid** (Caelestia) - Traditional, scalable
2. **Panel Family System** (end-4/ii) - Multi-theme support
3. **Layer-Based** (Zaphkiel) - Performance-focused, innovative UI

### State Management
1. **Distributed State** - Feature-specific singletons
2. **Centralized State** - Single Globals singleton
3. **Persistent State** - JSON-backed saved preferences

### Performance Optimization
1. **C++ Plugins** - FFT, image processing, file I/O
2. **Lazy Loading** - Loader with active bindings
3. **Debouncing** - Config saves, search queries
4. **Object Pooling** - Repeater/ListView reuse

## Credits

Special thanks to:
- [@outfoxxed](https://github.com/outfoxxed) - Quickshell creator
- [@soramane](https://github.com/soramane) - Caelestia shell
- [@end_4](https://github.com/end-4) - illogical-impulse configuration
- [@Rexcrazy804](https://github.com/Rexcrazy804) - Zaphkiel configuration

---

**For detailed patterns and implementation guidelines, see `QUICKSHELL_PATTERNS.md`**

