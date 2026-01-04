pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

/**
 * Audio service singleton
 * Manages audio sinks and sources via PipeWire
 */
Singleton {
    id: root

    // Default audio sink (output)
    readonly property PwNode sink: Pipewire.defaultAudioSink

    // Default audio source (input/microphone)
    readonly property PwNode source: Pipewire.defaultAudioSource

    // bind the node so we can read its properties
    PwObjectTracker {
        objects: [root.sink, root.source]
    }

    // Output properties
    readonly property real volume: sink?.audio?.volume ?? 0
    readonly property bool muted: !!sink?.audio?.muted ?? false
    readonly property string sinkDescription: sink?.description ?? "Unknown"

    // Input properties
    readonly property real micVolume: source?.audio?.volume ?? 0
    readonly property bool micMuted: !!source?.audio?.muted ?? false
    readonly property string sourceDescription: source?.description ?? "Unknown"

    // Set output volume
    function setVolume(newVolume: real): void {
        if (!sink?.ready || !sink?.audio) {
            return;
        }

        const config = Qt.application.Config;
        const maxVol = config?.audio.maxVolume ?? 1.0;

        sink.audio.volume = Math.max(0, Math.min(maxVol, newVolume));
    }

    // Toggle output mute
    function toggleMute(): void {
        if (sink?.ready && sink?.audio) {
            sink.audio.muted = !sink.audio.muted;
        }
    }

    // Set input volume
    function setMicVolume(newVolume: real): void {
        if (source?.ready && source?.audio) {
            source.audio.volume = Math.max(0, Math.min(1, newVolume));
        }
    }

    // Toggle input mute
    function toggleMicMute(): void {
        if (source?.ready && source?.audio) {
            source.audio.muted = !source.audio.muted;
        }
    }

    // Increase volume by step
    function increaseVolume(): void {
        const config = Qt.application.Config;
        const step = config?.audio.volumeStep ?? 0.05;
        setVolume(volume + step);
    }

    // Decrease volume by step
    function decreaseVolume(): void {
        const config = Qt.application.Config;
        const step = config?.audio.volumeStep ?? 0.05;
        setVolume(volume - step);
    }
}
