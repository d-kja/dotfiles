import app from "ags/gtk4/app"
import { Astal, Gdk, Gtk } from "ags/gtk4"
import { LEFT, RIGHT, TOP } from "../../lib/helpers"

export const Bar = (monitor: Gdk.Monitor) => {
  return (
    <window
      visible
      gdkmonitor={monitor}

      name="bar"
      application={app}

      heightRequest={40}
      layer={Astal.Layer.TOP}
      anchor={TOP | LEFT | RIGHT}

      canFocus={false}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
    >
      <box>
        <centerbox hexpand>
          <box name="bar-left" halign={Gtk.Align.START} $type="start">
            ...
          </box>

          <box name="bar-center" halign={Gtk.Align.CENTER} $type="center">
            ...
          </box>

          <box name="bar-right" halign={Gtk.Align.END} $type="end">
            ...
          </box>
        </centerbox>
      </box>
    </window>
  )
}
