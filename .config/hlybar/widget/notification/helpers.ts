import { Gtk } from "ags/gtk4"
import AstalNotifd from "gi://AstalNotifd?version=0.1"
import GLib from "gi://GLib?version=2.0"

export const getTime = (time: number, format = "%H:%M") => {
  return GLib.DateTime.new_from_unix_local(time).format(format)
}

export const isIcon = (icon: string) => {
  const iconTheme = new Gtk.IconTheme()
  const hasIcon = iconTheme.has_icon(icon)

  return hasIcon
}

export const isExistingFile = (path: string) => {
  const isFile = GLib.file_test(path, GLib.FileTest.EXISTS)
  return isFile
}

export const notificationUrgency = (notification: AstalNotifd.Notification) => {
  const { LOW, CRITICAL } = AstalNotifd.Urgency;

  switch (notification?.urgency) {
    case LOW:
      return "low";
    case CRITICAL:
      return "critical";

    default:
      return "normal";
  }
};

export const isNewNotification = (notification: AstalNotifd.Notification) => {
  const span = GLib.DateTime.new_now_local().to_unix() - notification.time
  const unixSpan = GLib.DateTime.new_from_unix_local(span)

  const TEN_SECONDS = 10
  const isOld = unixSpan.get_seconds() > TEN_SECONDS

  return !isOld
}
