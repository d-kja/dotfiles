import AstalNotifd from "gi://AstalNotifd?version=0.1";
import { Astal, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";
import { type Timer, timeout } from "ags/time";
import { createBinding, createState, For, onCleanup } from "gnim";
import { SECOND } from "../../lib/constants";
import { logger } from "../../lib/helpers";
import { Notification } from "./components/notification-container";
import { isNewNotification } from "./helpers";

export const Notifications = () => {
  const monitors = createBinding(app, "monitors");

  const notificationsManager = AstalNotifd.get_default();
  if (!notificationsManager) {
    logger.error("Notification module not found");
    return;
  }

  const [notifications, setNotifications] = createState<
    AstalNotifd.Notification[]
  >([]);

  const handleCheckHasNotifications = (
    notifications: AstalNotifd.Notification[],
  ) => {
    const filteredItems = notifications?.filter(isNewNotification);

    const hasItems = filteredItems?.length > 0;
    return hasItems;
  };

  let cleaning: Timer;

  const notifiedHandler = notificationsManager.connect(
    "notified",
    (_, id, replaced) => {
      const notification = notificationsManager.get_notification(id);
      if (!notification) {
        logger.warn(`Notification ${id} not found`);
        return;
      }

      const updateHandler = (_notification: AstalNotifd.Notification) => {
        const matchesCurrentId = _notification?.id === id;
        if (matchesCurrentId) {
          return notification;
        }

        return _notification;
      };

      cleaning = timeout(SECOND * 10, () => {
        // Remove item after 10 seconds.
        setNotifications((notifications) =>
          notifications?.filter?.((notification) => notification?.id !== id),
        );
      });

      const alreadyExists = notifications
        .peek?.()
        ?.some?.((notification) => notification?.id === id);
      const wasReplaced = alreadyExists && replaced;
      if (wasReplaced) {
        setNotifications((notifications) => notifications.map(updateHandler));
        return;
      }

      setNotifications((notifications) => [notification, ...notifications]);
    },
  );

  const resolvedHandler = notificationsManager.connect("resolved", (_, id) => {
    const updateHandler = (notifications: AstalNotifd.Notification[]) => {
      const filteredNotifications = notifications?.filter(
        (notification) => notification?.id !== id,
      );
      return filteredNotifications;
    };

    setNotifications(updateHandler);
  });

  onCleanup(() => {
    notificationsManager.disconnect(notifiedHandler);
    notificationsManager.disconnect(resolvedHandler);

    cleaning?.cancel?.();
  });

  return (
    <For each={monitors}>
      {(monitor) => (
        <window
          $={(self) => onCleanup(() => self.destroy())}
          gdkmonitor={monitor}
          resizable
          visible={notifications(handleCheckHasNotifications)}
          anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
          class="notification"
        >
          <box
            $type="end"
            halign={Gtk.Align.END}
            orientation={Gtk.Orientation.VERTICAL}
            hexpand
          >
              <For each={notifications}>
                {(notification) => <Notification notification={notification} />}
              </For>
          </box>
        </window>
      )}
    </For>
  );
};
