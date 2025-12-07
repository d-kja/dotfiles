import { Astal } from "ags/gtk4"
import AstalHyprland from "gi://AstalHyprland?version=0.1"

export const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

export const getFocusedMonitor = (monitors: AstalHyprland.Monitor[]) => {
  const focusedMonitor = monitors?.find(monitor => {
    return monitor.focused
  })

  return focusedMonitor
}

type LoggerLevel = "ERROR" | "WARN" | "INFO"
const _logger = (level: LoggerLevel, message: unknown[]) => {
  switch (level) {
    case "ERROR": {
      console.error("[ERROR] -", ...message)
      return
    }

    case "WARN": {
      console.info("[WARN] -", ...message)
      return
    }

    default: {
      console.log("[WARN] -", ...message)
      return
    }
  }
}

export const logger = {
  error: (...message: unknown[]) => _logger("ERROR", message),
  warn: (...message: unknown[]) => _logger("WARN", message),
  info: (...message: unknown[]) => _logger("INFO", message),
}
