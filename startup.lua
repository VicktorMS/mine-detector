-- ==========================================
--  Player Detector System
--  CC:Tweaked + Advanced Peripherals
--
--  Peripherals needed:
--    - Player Detector (Advanced Peripherals)
--    - Monitor (CC:Tweaked)
--    - Speaker (CC:Tweaked)
-- ==========================================

-- Load config and libraries
local config  = require("config")
local display = require("lib.display")
local alert   = require("lib.alert")

-- Wrap peripherals
local detector = peripheral.find("playerDetector")
local monitor  = peripheral.find("monitor")
local speaker  = peripheral.find("speaker")

-- Validate peripherals
local function checkPeripherals()
    local ok = true
    if not detector then
        printError("[ERROR] Player Detector not found!")
        ok = false
    end
    if not monitor then
        printError("[ERROR] Monitor not found!")
        ok = false
    end
    if not speaker then
        print("[WARN] Speaker not found - sounds disabled")
    end
    return ok
end

if not checkPeripherals() then
    print("")
    print("Please connect the missing peripherals")
    print("and restart the program.")
    return
end

-- Setup monitor
monitor.setTextScale(config.MONITOR_TEXT_SCALE)

-- State tracking
local wasDetected = false

-- Main detection loop
local function detectionLoop()
    print("Player Detector Online!")
    print("Target: " .. config.TARGET_PLAYER)
    print("Range:  " .. config.DETECTION_RANGE .. " blocks")
    print("Scanning every " .. config.SCAN_INTERVAL .. "s")
    print(string.rep("-", 30))

    while true do
        local detected = detector.isPlayerInRange(config.DETECTION_RANGE, config.TARGET_PLAYER)

        if detected and not wasDetected then
            -- Player just entered range
            print("[ALERT] " .. config.TARGET_PLAYER .. " detected!")
            display.showAlert(monitor, config, config.TARGET_PLAYER)
            alert.playPattern(speaker, config)
            wasDetected = true

        elseif detected and wasDetected then
            -- Player still in range, update display
            display.showAlert(monitor, config, config.TARGET_PLAYER)

        elseif not detected and wasDetected then
            -- Player just left range
            print("[INFO] " .. config.TARGET_PLAYER .. " left the area.")
            display.showIdle(monitor, config)
            wasDetected = false

        else
            -- No player, idle
            display.showIdle(monitor, config)
        end

        sleep(config.SCAN_INTERVAL)
    end
end

-- Event listener for playerJoin / playerClick events
local function eventLoop()
    while true do
        local event, username = os.pullEvent()

        if event == "playerClick" and username == config.TARGET_PLAYER then
            print("[EVENT] " .. username .. " clicked the detector!")
            alert.play(speaker, config)
        end
    end
end

-- Show idle screen and run both loops
display.showIdle(monitor, config)
parallel.waitForAny(detectionLoop, eventLoop)
