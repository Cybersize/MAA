# MAA

Roblox action macro with the bundled MattLib UI, JSON recordings, and wave-aware playback.

Version 2.4 adds Auto Vote Start before the first match and after resets. Play now repeats automatically while its toggle stays on; the separate Repeat control is removed. Record OFF stops and saves, and Play OFF stops playback and future repeats. Auto Replay, one JSON per macro, and owned-unit wave rules remain available.

## Run the latest version

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Cybersize/MAA/main/loader.lua"))()
```

The stable loader fetches the current `main.lua` with a timestamp query on every execution. Run the same line again after updates; an already-running session is not updated in the background. GitHub/CDN propagation may take a short time after a push.

## Usage

1. Run the loader and choose a macro name.
2. Choose **Record start** (This match or Next match) and switch **Record ON**.
3. Place, upgrade, change priority, sell, and use supported abilities/votes normally.
4. Switch **Record OFF** to stop and save. Switching off before the next match cancels an armed recording.
5. Choose **Play start** (Sync current match or Next match) and switch **Play ON**. Switch **Play OFF** to stop. Timing defaults to **Adaptive / Catch up / Auto**.

Play stays on after completion or an early loss and restarts the macro at each new match. Switch it off to stop. Failed starts or playback errors switch it off. Conflicting controls are disabled while recording, playing, or saving, and rapid clicks cannot create duplicate operations.

Use a new v2 recording for wave/time synchronization. Legacy files retain their offset timeline. Local recordings remain under the executor's `AA_Macros/` folder and are not uploaded.

## Wave rules

Open **Wave rules**. Auto-upgrade supports a start wave, optional end wave, and target level (`0 = Max`). Auto-sell applies from the chosen wave onward, including units placed later. Both toggles default off and affect only units confirmed to belong to you. Rules run independently of macro playback. **Stop everything** pauses both playback and automation.

Use **Save wave rules in this macro JSON** to store the settings with the recording. Saving rules alone creates a settings-only profile in that same file. During an active upgrade window, wave rules manage upgrades instead of duplicating recorded upgrade calls. Selling takes priority once its wave is reached.

Normal save/play creates only `<name>.json`. Drafts, staged copies, backups, and playback logs are no longer written automatically. Recovery-safe cleanup removes old helper files only when the main recording validates. Manual diagnostics export remains optional.

## Auto Replay

On **Macro**, enable **Auto Replay at match end**. No learned button or loaded macro is required. The default delay is two seconds. Leave **Play ON** to run the macro in each new match; leave Play off for standalone replay voting. It handles early losses, waits for a real reset, and can send a start vote if the replayed match needs one. Already-sent votes are not spammed; explicit rejections have bounded retries. **Stop everything** pauses replay too. Save its settings with the other rules in the same JSON.

## Auto Vote Start

The **Auto Vote Start** toggle replaces the manual start button. Enable it to vote before the first match and after resets. It waits for the map and match flags, skips lobbies and already-started games, and shares vote tracking with Replay and recorded start steps. Explicit rejections retry up to three times with three-second spacing. It defaults off and saves in the same macro JSON. **Stop everything** pauses it too.

For a full automatic cycle, enable **Play**, **Auto Replay at match end**, and **Auto Vote Start**. No separate Repeat toggle is needed.

See [the usage guide](docs/USAGE.md) for timing, automatic playback, and compatibility limits. See [validation](docs/VALIDATION.md) for 75 core scenarios and 17 MattLib integration checks. These checks used local engine doubles; live-game/executor compatibility remains unverified.

## Updating

Publish the new tested bundle as `main.lua` on `main`; keep the loader URL unchanged. `version.json` records this bundle's version and SHA-256. `main.lua` is self-contained: MattLib is embedded, so it needs no separate runtime UI download.

The original UI bundle is [Cybersize/MattLib](https://github.com/Cybersize/MattLib), pinned to commit `bb9187fa8be705a5b7225904b0dd737c9f612035`. Its MIT notice is embedded in `main.lua` and included in [third-party notices](THIRD_PARTY_NOTICES.md).
