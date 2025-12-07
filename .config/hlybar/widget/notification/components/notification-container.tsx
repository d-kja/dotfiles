import Gtk from "gi://Gtk?version=4.0"
import Adw from "gi://Adw"
import AstalNotifd from "gi://AstalNotifd"
import Pango from "gi://Pango"
import { getTime, isExistingFile, isIcon, notificationUrgency } from "../helpers"

interface NotificationProps {
  notification: AstalNotifd.Notification
}

export const Notification = ({ notification }: NotificationProps) => {
  const application = notification?.appName || "Application"

  const summary = notification?.summary || "New notification"
  const content = notification?.body || "Notification message is empty"

  const time = getTime(notification?.time)
  const urgency = notificationUrgency(notification)


  const hasTime = Boolean(time)
  const hasIcon = Boolean(notification?.appIcon) || isIcon(notification?.desktopEntry)

  const hasContent = Boolean(notification?.body)
  const isValidPath = Boolean(notification?.image)
  const hasActions = notification?.actions?.length > 0
  const hasPreview = isValidPath && isExistingFile(notification?.image)
  const hasIconPreview = isValidPath && isIcon(notification?.image)

  const handleDismiss = () => notification.dismiss()

  return (
    <Adw.Clamp maximumSize={400}>
      <box
        widthRequest={400}
        class={`notification-popup ${urgency}`}
        orientation={Gtk.Orientation.VERTICAL}
      >
        <box class="header">
          {(hasIcon) && (
            <image
              class="app-icon"
              visible={Boolean(notification.appIcon || notification.desktopEntry)}
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
            <image valign={Gtk.Align.START} class="image" file={notification?.image} />
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
              const handleAction = () => notification?.invoke?.(id)

              return (
                <button hexpand onClicked={handleAction}>
                  <label label={label} halign={Gtk.Align.CENTER} hexpand />
                </button>
              )
            })}
          </box>
        )}
      </box>
    </Adw.Clamp>
  )
}
