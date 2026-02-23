-- ==========================================
--  Player Detector Installer
--  Run with: wget run <URL>/installer.lua
-- ==========================================

-- CHANGE THIS to your GitHub raw URL base
local BASE_URL = "https://raw.githubusercontent.com/VicktorMS/mine-detector/main/"

local files = {
    ["startup.lua"]     = BASE_URL .. "startup.lua",
    ["config.lua"]      = BASE_URL .. "config.lua",
    ["lib/display.lua"] = BASE_URL .. "lib/display.lua",
    ["lib/alert.lua"]   = BASE_URL .. "lib/alert.lua",
}

print("================================")
print("  Player Detector - Installer")
print("================================")
print("")

-- Create directories
fs.makeDir("lib")

-- Download all files
local success = 0
local total = 0

for path, url in pairs(files) do
    total = total + 1
    write("Downloading " .. path .. "... ")
    local response = http.get(url)
    if response then
        local file = fs.open(path, "w")
        file.write(response.readAll())
        file.close()
        response.close()
        success = success + 1
        print("OK")
    else
        printError("FAILED")
    end
end

print("")
print(string.format("Downloaded %d/%d files.", success, total))

if success == total then
    print("")
    print("Installation complete!")
    print("Edit config.lua to change settings.")
    print("Reboot to start (type: reboot)")
else
    printError("Some files failed to download.")
    printError("Check your internet and try again.")
end
