-- ==========================================
--  Display Library
--  Handles all monitor rendering
-- ==========================================

local display = {}

-- Centers text on a given line
function display.centerText(mon, y, text, textColor, bgColor)
    local w, _ = mon.getSize()
    local x = math.floor((w - #text) / 2) + 1
    mon.setCursorPos(x, y)
    if textColor then mon.setTextColor(textColor) end
    if bgColor then mon.setBackgroundColor(bgColor) end
    mon.write(text)
end

-- Fills the entire monitor with a background color
function display.clearWith(mon, bgColor)
    mon.setBackgroundColor(bgColor)
    mon.clear()
end

-- Draws a horizontal line
function display.drawLine(mon, y, char, color)
    local w, _ = mon.getSize()
    mon.setCursorPos(1, y)
    if color then mon.setTextColor(color) end
    mon.write(string.rep(char or "-", w))
end

-- Shows the idle / scanning screen
function display.showIdle(mon, config)
    display.clearWith(mon, config.COLOR_IDLE_BG)
    local _, h = mon.getSize()
    local mid = math.floor(h / 2)

    display.centerText(mon, mid - 1, "[ Player Detector ]", config.COLOR_HEADER, config.COLOR_IDLE_BG)
    display.drawLine(mon, mid, "-", config.COLOR_IDLE_TEXT)
    display.centerText(mon, mid + 1, config.IDLE_MESSAGE, config.COLOR_IDLE_TEXT, config.COLOR_IDLE_BG)
    display.centerText(mon, mid + 3, "Target: " .. config.TARGET_PLAYER, config.COLOR_IDLE_TEXT, config.COLOR_IDLE_BG)
    display.centerText(mon, h, "Range: " .. config.DETECTION_RANGE .. " blocks", config.COLOR_IDLE_TEXT, config.COLOR_IDLE_BG)
end

-- Shows the alert screen when the player is detected
function display.showAlert(mon, config, playerName)
    display.clearWith(mon, config.COLOR_ALERT_BG)
    local _, h = mon.getSize()
    local mid = math.floor(h / 2)

    display.centerText(mon, mid - 2, "!! " .. config.ALERT_MESSAGE .. " !!", config.COLOR_ALERT_TEXT, config.COLOR_ALERT_BG)
    display.drawLine(mon, mid, "=", config.COLOR_ALERT_TEXT)
    local welcome = string.format(config.WELCOME_MESSAGE, playerName)
    display.centerText(mon, mid + 2, welcome, config.COLOR_ALERT_TEXT, config.COLOR_ALERT_BG)

    -- Show timestamp
    local time = textutils.formatTime(os.time(), true)
    display.centerText(mon, h, "Detected at " .. time, config.COLOR_ALERT_TEXT, config.COLOR_ALERT_BG)
end

return display
