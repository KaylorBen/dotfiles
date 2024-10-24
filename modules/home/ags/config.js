import { NotificationPopups } from "./modules/notification-popups.js"
import { Bar } from "./modules/bar.js"
import { applauncher } from "./modules/applauncher.js"

App.addIcons(`${App.configDir}/assets`)

App.config({
  style: "./style.css",
  windows: [
    Bar(0),
    Bar(1),
    NotificationPopups(1),
    applauncher,
  ],
})

export { }
