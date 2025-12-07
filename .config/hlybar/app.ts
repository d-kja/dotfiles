import app from "ags/gtk4/app"
import style from "./styles/index.scss"

import { Bar } from "./widget/bar"
import { Notifications } from "./widget/notification"

const monitors = app.get_monitors()

app.start({
  instanceName: "gramen",

  css: style,
  main() {
    monitors.map((monitor) => {
      Bar(monitor)
    })

    Notifications()
  },
})
