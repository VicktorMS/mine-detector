# Player Detector System

A CC:Tweaked + Advanced Peripherals program that detects a specific player, displays an alert on a monitor, and plays a sound.

## Required Peripherals

Connect these to your computer (directly or via wired modem + cable):

| Peripheral | Mod | Required |
|---|---|---|
| Player Detector | Advanced Peripherals | ✅ Yes |
| Monitor | CC:Tweaked | ✅ Yes |
| Speaker | CC:Tweaked | ⚠️ Optional |

## Installation

### Option 1: One-command install
1. Upload these files to a GitHub repo
2. Edit `installer.lua` and set your `BASE_URL`
3. On your CC computer, run:
```
wget run https://raw.githubusercontent.com/YOUR_USER/player-detector/main/installer.lua
```

### Option 2: Manual install
Copy each file to your computer via `wget` or `pastebin`.

## Configuration

Edit `config.lua` to change:
- `TARGET_PLAYER` — the username to detect (default: `"PL"`)
- `DETECTION_RANGE` — range in blocks (default: `20`)
- `SCAN_INTERVAL` — how often to check (default: `2` seconds)
- Colors, messages, and sound settings

## File Structure

```
/
├── startup.lua          -- Main program (auto-runs on boot)
├── config.lua           -- All settings in one place
├── installer.lua        -- One-command installer
└── lib/
    ├── display.lua      -- Monitor rendering
    └── alert.lua        -- Speaker sounds
```

## How It Works

1. The program scans for the target player every N seconds
2. When detected → monitor turns red with a welcome message + speaker plays 3 beeps
3. When the player leaves → monitor returns to idle (scanning) screen
4. Also listens for `playerClick` events on the detector block
