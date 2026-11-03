# MAA

Roblox action macro with the bundled MattLib UI, JSON recordings, and wave-aware playback.

Version 2.8.1 fixes Auto Commander/Windsong for already placed supports. Auto adopts a suitable existing group or uses basic upkeep, and the panel shows detected/ready counts. The visual placement editor, path/circle Auto Play, Match automation, teleport resume and Record/Play toggles remain available. Everything saves in one profile JSON.

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

## Match controls

Open **Match** for **Auto Start Game**, **Auto Skip Wave**, **Auto Replay**, **Auto Next Story**, **Auto Next Room**, **Auto Next Portal**, and **Auto Leave Match**. All default off. **Auto Fast Forward Speed** is displayed disabled because the connected build exposes no matching control/request.

At results, Leave takes priority, then the matching Next option, then Replay. Story and tower progression require victory; portal continuation requires a valid same-group inventory item and host ownership. A two-second result delay is adjustable. One result request is sent per end state, with bounded retries for explicit rejection. Stop everything pauses all automation. Save Match settings in the same macro JSON.

For a normal repeating cycle, enable **Play**, **Auto Start Game**, and **Auto Replay**. Play repeats automatically at each new match; Start Game is independent of Replay. No separate Repeat toggle is needed.

Teleport queuing restores settings and enabled playback using the latest GitHub bundle and the same named local recording. No extra JSON is written. Map/account/place validation still applies; a different map stops playback until an appropriate recording is selected.

## Auto Play

The **Auto Play** tab places equipped units without recording a macro. Choose Smart Path & Corners or Circle Placement, optionally set priority, upgrades and a sell wave, then enable Auto Play. It uses current funds/caps, valid surfaces and collision checks. It waits while macro Play is enabled and serializes automatic unit requests.

For Circle Placement, choose the actual map/mode, click Set Circle Position, click the map, and Save Plan for Map. All saved map centers share the same profile JSON. Plan selection does not join a stage. Stop everything pauses Auto Play.

## Visual placement editor

Open **Auto Play → Saved Action Plans**, enter a name and choose **Create Plan**. Select an equipped unit and add/drag numbered markers on the 3D preview. Append spawn, target-upgrade, sell, priority, wait-wave and wait-seconds actions; reorder them with dependency checks. Zoom/pan, hide decorative objects, rotate markers and undo/redo changes. Save in the same profile JSON, close the editor, then enable **Auto Play Plan**. Leave macro Play off.

The plan repeats every new match while enabled. Existing owned units/upgrades can satisfy steps, wrong-map/account plans wait, and unresolved or unconfirmed requests are never duplicated. Auto Play After Plan permits normal filling after completion when Auto Play is also enabled. Wave rules wait during the plan and resume after completion. Editing sends no game requests; opening pauses new automatic unit actions. Pending requests can still finish.

All named plans share the existing JSON with recordings/settings. No editor drafts, undo logs or per-plan files are written. Delete/restore and recoverable save failures preserve the one-file workflow. See [usage](docs/USAGE.md) for controls, execution and limits.

## Buffs

Open **Buffs** for the five requested toggles and Commander/Windsong statuses. All controls default off. Basic upkeep handles supported active buffs; Kisuke's Range and attack-SPA controls share one cast. Passive auras are excluded.

Choose Auto, Four-unit relay or Five-unit pentagon. Auto reuses already placed owned supports: a valid ring, four mutually covering units with warm-up, or basic upkeep. Extra units do not block the selected group; isolated extras receive upkeep between combo casts, while overlapping extras are excluded from casting. The status reports detected/ready counts. Explicit Four-unit relay keeps the tutorial's staged placement, also preserved for fresh Auto Play placements. The scheduler uses received-buff expiry, replicated cast confirmation and actual readiness. Commander/Windsong keep separate state and suppress conflicting native auto-casts. The six-unit double line is not implemented.

Save Buffs settings in the same macro JSON. Stop everything pauses the automation. Status reports observed support-unit buff strength; a valid formation does not guarantee full-team coverage or a sustained 100% loop. See [the research notes](docs/BUFF_COMBO_RESEARCH.md).

See [the usage guide](docs/USAGE.md) and [validation](docs/VALIDATION.md). There are 206 passing local scenarios and clean Real static checks. Read-only diagnosis confirmed six owned ready Erwins; Auto's setup gate caused the failure. The client disconnected before the revised controller could be tested live. Native editor rendering, server plan playback and sustained buff combos remain unverified.

## Updating

Publish the new tested bundle as `main.lua` on `main`; keep the loader URL unchanged. `version.json` records this bundle's version and SHA-256. `main.lua` is self-contained: MattLib is embedded, so it needs no separate runtime UI download.

The original UI bundle is [Cybersize/MattLib](https://github.com/Cybersize/MattLib), pinned to commit `bb9187fa8be705a5b7225904b0dd737c9f612035`. Its MIT notice is embedded in `main.lua` and included in [third-party notices](THIRD_PARTY_NOTICES.md).
