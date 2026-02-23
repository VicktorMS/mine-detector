-- ==========================================
--  Alert Library
--  Handles speaker sound alerts
-- ==========================================

local alert = {}

-- Play a single alert sound
function alert.play(speaker, config)
    if speaker then
        speaker.playSound(config.ALERT_SOUND, config.ALERT_VOLUME, config.ALERT_PITCH)
    end
end

-- Play a pattern of alert sounds (3 beeps)
function alert.playPattern(speaker, config)
    if not speaker then return end
    for i = 1, 3 do
        speaker.playSound(config.ALERT_SOUND, config.ALERT_VOLUME, config.ALERT_PITCH)
        sleep(0.3)
    end
end

return alert
