# MAA

Roblox action macro with the bundled MattLib UI, JSON recordings, and wave-aware playback.

Version 2.3 replaces the Record and Play buttons with state-aware toggles. Record OFF stops and saves; Play OFF stops playback. Current/next-match start dropdowns preserve both workflows. Auto Replay, one JSON per macro, and owned-unit wave upgrade/sell rules remain available.

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

The toggles follow the real operation state, including waiting for a match or repeat. Playback completion and failed starts switch Play off. Conflicting controls are disabled while recording, playing, or saving, and rapid clicks cannot create duplicate operations.

Use a new v2 recording for wave/time synchronization. Legacy files retain their offset timeline. Local recordings remain under the executor's `AA_Macros/` folder and are not uploaded.

## Wave rules

Open **Wave rules**. Auto-upgrade supports a start wave, optional end wave, and target level (`0 = Max`). Auto-sell applies from the chosen wave onward, including units placed later. Both toggles default off and affect only units confirmed to belong to you. Rules run independently of macro playback. **Stop everything** pauses both playback and automation.

Use **Save wave rules in this macro JSON** to store the settings with the recording. Saving rules alone creates a settings-only profile in that same file. During an active upgrade window, wave rules manage upgrades instead of duplicating recorded upgrade calls. Selling takes priority once its wave is reached.

Normal save/play creates only `<name>.json`. Drafts, staged copies, backups, and playback logs are no longer written automatically. Recovery-safe cleanup removes old helper files only when the main recording validates. Manual diagnostics export remains optional.

## Auto Replay

On **Macro**, enable **Auto Replay at match end**. No learned button or loaded macro is required. The default delay is two seconds. Enabling it also turns on macro Repeat; uncheck Repeat for vote-only operation. It handles early losses, waits for a real reset, and can send a start vote if the replayed match needs one. Already-sent votes are not spammed; explicit rejections have bounded retries. **Stop everything** pauses replay too. Save its settings with the other rules in the same JSON.

See [the usage guide](docs/USAGE.md) for timing, repeat playback, and compatibility limits. See [validation](docs/VALIDATION.md) for 59 core scenarios and 16 MattLib integration checks. These checks used local engine doubles; live-game/executor compatibility remains unverified.

## Updating

Publish the new tested bundle as `main.lua` on `main`; keep the loader URL unchanged. `version.json` records this bundle's version and SHA-256. `main.lua` is self-contained: MattLib is embedded, so it needs no separate runtime UI download.

The original UI bundle is [Cybersize/MattLib](https://github.com/Cybersize/MattLib), pinned to commit `bb9187fa8be705a5b7225904b0dd737c9f612035`. Its MIT notice is embedded in `main.lua` and included in [third-party notices](THIRD_PARTY_NOTICES.md).
