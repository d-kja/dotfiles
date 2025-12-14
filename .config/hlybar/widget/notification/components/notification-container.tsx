import Adw from "gi://Adw";
import type AstalNotifd from "gi://AstalNotifd";
import Gtk from "gi://Gtk?version=4.0";
import Pango from "gi://Pango";
import { type Timer, timeout } from "ags/time";
import { createEffect, createState, onCleanup } from "gnim";
import { SECOND } from "../../../lib/constants";
import {
  getTime,
  isExistingFile,
  isIcon,
  notificationUrgency,
} from "../helpers";

interface NotificationProps {
  notification: AstalNotifd.Notification;
}

export const Notification = ({ notification }: NotificationProps) => {
  const [reveal, setReveal] = createState(false);

  const application = notification?.appName || "Application";
  const summary = notification?.summary || "New notification";
  const content = notification?.body || "Notification message is empty";

  const time = getTime(notification?.time);
  const urgency = notificationUrgency(notification);

  const hasTime = Boolean(time);
  const hasIcon =
    Boolean(notification?.appIcon) || isIcon(notification?.desktopEntry);

  const hasContent = Boolean(notification?.body);
  const isValidPath = Boolean(notification?.image);
  const hasActions = notification?.actions?.length > 0;
  const hasPreview = isValidPath && isExistingFile(notification?.image);
  const hasIconPreview = isValidPath && isIcon(notification?.image);

  let setup: Timer;
  const handleDismiss = () => notification.dismiss();

  createEffect(
    () => {
      setup = timeout(SECOND * 0.25, () => {
        // Create a small delay before firing the revealer... (might not be optimal)
        setReveal(true);
      });
    },
    { immediate: true },
  );

  onCleanup(() => {
    setup?.cancel?.();
  });

  return (
    <revealer
      revealChild={reveal}
      transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
      class="notification-revealer"
    >
      <Adw.Clamp widthRequest={400}>
        <box
          widthRequest={400}
          class={`notification-popup ${urgency}`}
          orientation={Gtk.Orientation.VERTICAL}
        >
          <box class="header">
            {hasIcon && (
              <image
                class="app-icon"
                visible={Boolean(
                  notification.appIcon || notification.desktopEntry,
                )}
                iconName={notification.appIcon || notification.desktopEntry}
              />
            )}

            <label
              class="app-name"
              halign={Gtk.Align.START}
              ellipsize={Pango.EllipsizeMode.END}
              label={application}
            />

            {hasTime && (
              <label
                class="time"
                hexpand
                halign={Gtk.Align.END}
                label={time ?? "-"}
              />
            )}

            <button onClicked={handleDismiss} class="app-close">
              <image iconName="window-close-symbolic" />
            </button>
          </box>

          <Gtk.Separator visible class="app-separator" />

          <box class="content">
            {hasPreview && (
              <image
                valign={Gtk.Align.START}
                class="image"
                file={notification?.image}
              />
            )}

            {hasIconPreview && (
              <box valign={Gtk.Align.START} class="icon-image">
                <image
                  iconName={notification.image}
                  halign={Gtk.Align.CENTER}
                  valign={Gtk.Align.CENTER}
                />
              </box>
            )}

            <box orientation={Gtk.Orientation.VERTICAL}>
              <label
                class="summary"
                xalign={0}
                halign={Gtk.Align.START}
                ellipsize={Pango.EllipsizeMode.END}
                label={summary}
              />

              {hasContent && (
                <label
                  class="body"
                  wrap
                  useMarkup
                  xalign={0}
                  halign={Gtk.Align.START}
                  justify={Gtk.Justification.FILL}
                  label={content}
                />
              )}
            </box>
          </box>

          {hasActions && (
            <box class="actions">
              {notification?.actions?.map?.(({ label, id }) => {
                const handleAction = () => notification?.invoke?.(id);

                return (
                  <button hexpand onClicked={handleAction}>
                    <label label={label} halign={Gtk.Align.CENTER} hexpand />
                  </button>
                );
              })}
            </box>
          )}
        </box>
      </Adw.Clamp>
    </revealer>
  );
};
