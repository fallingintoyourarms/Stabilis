# Stabilis

Stabilis is a fully automatic server monitoring and cleanup system for FiveM. It detects memory spikes, monitors entity counts, and safely restarts misbehaving resources, all without commands.

## Features

- Fully automatic monitoring and cleanup
- Memory spike detection using Lua `collectgarbage`
- Tracks vehicles, peds, and objects to prevent buildup
- Smart cleanup: only removes abandoned or unnecessary entities
- Safe auto-restart for flagged resources with cooldowns
- Protected resources are not restarted
- Console and optional file logging

## Installation

1. Copy the `stabilis` folder into your server’s `resources` directory.
2. Add `ensure stabilis` to your `server.cfg`.
3. Configure settings in `config.lua` if needed.
4. Start your server; Stabilis runs automatically.

## Configuration

Located in `config.lua`:

```lua
Config.Debug = true
Config.Interval = 60000
Config.MemoryIncreaseThreshold = 5000
Config.MaxVehicles = 200
Config.MaxPeds = 150
Config.MaxObjects = 300
Config.CleanupInterval = 300000
Config.DeleteEmptyVehicles = true
Config.DeleteOrphanPeds = true
Config.DeleteObjects = true
Config.AutoRestartLeakingResources = true
Config.LogToFile = true
````

Adjust thresholds to fit your server size and resource setup.

## How It Works

1. **Memory Monitoring**: Detects unusual memory growth and flags potential leaks.
2. **Resource Tracking**: Tracks ticks per resource to detect abnormal behavior.
3. **Smart Cleanup**: Removes only abandoned vehicles, non-player peds, or excess objects.
4. **Safe Auto-Restart**: Queues flagged resources for restart, skips protected resources, and uses cooldowns to prevent repeated restarts.
5. **Logging**: Prints actions to console and optionally logs to `logs/stabilis.log`.

## Logs

Logs are saved in `stabilis/logs/stabilis.log`. Each entry includes a timestamp and description.

Example:

```
[2026-03-25 20:00:00] [Stabilis] Memory spike detected: +6123 KB
[2026-03-25 20:00:00] [Stabilis] High tick usage detected: inventory
[2026-03-25 20:05:00] [Stabilis] Cleanup done | Vehicles: 5 | Peds: 3 | Objects: 10
```

## Recommended Use

* Medium to large FiveM servers with many resources or scripts
* Servers experiencing lag, memory leaks, or entity buildup
* Servers that want fully automatic maintenance

## Notes

* Stabilis does not patch the FiveM engine or fix internal Lua memory leaks.
* Auto-restarts should be used carefully; protected resources are skipped.
* Test new configurations on a staging server before using in production.

## Optional Next Steps

* Add alerts for flagged resources
* Implement event spam detection
* Track entity ownership per resource for safer cleanup


