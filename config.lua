-- ==========================================
--  Player Detector Config
--  Edit these values to customize behavior
-- ==========================================

local config = {}

-- Player to detect
config.TARGET_PLAYER = "PL"

-- Detection range (in blocks from the Player Detector peripheral)
config.DETECTION_RANGE = 20

-- How often to check for the player (in seconds)
config.SCAN_INTERVAL = 2

-- Monitor settings
config.ALERT_MESSAGE = "PLAYER DETECTED"
config.WELCOME_MESSAGE = "Welcome, %s!"  -- %s = player name
config.IDLE_MESSAGE = "Scanning area..."
config.MONITOR_TEXT_SCALE = 1

-- Sound settings
config.ALERT_SOUND = "minecraft:block.note_block.bell"
config.ALERT_VOLUME = 3
config.ALERT_PITCH = 1

-- Colors
config.COLOR_ALERT_BG = colors.red
config.COLOR_ALERT_TEXT = colors.white
config.COLOR_IDLE_BG = colors.black
config.COLOR_IDLE_TEXT = colors.lime
config.COLOR_HEADER = colors.yellow

return config
