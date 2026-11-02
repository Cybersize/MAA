# MAA 2.5

Run the same GitHub loader to receive the latest version:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Cybersize/MAA/main/loader.lua"))()
```

The panel should show **MAA 2.5**. MattLib 1.2.1 remains embedded. Right Ctrl hides/shows the window. Choose a design in Diagnostics.

## Match controls

The **Match** tab contains the eight controls from the supplied screenshot. Every supported control defaults off.

| Control | Behavior |
| --- | --- |
| Auto Start Game | Sends one start vote before the first match and each new match. Waits for flags/map readiness and skips lobbies and already-started games. |
| Auto Skip Wave | Votes when the server opens a wave-skip window. Shares tracking with recorded votes and sends at most one accepted vote per wave. |
| Auto Replay | Sends the game's Replay request after results. An optional learned argument override remains on Macro for compatibility. |
| Auto Next Story | After a story victory, requests the next act if it exists and you are the host. |
| Auto Next Room | After an Infinity Tower victory, uses the game's solo or group next-room path. |
| Auto Next Portal | Selects the first available valid portal from the same group in your inventory and sends its UUID. Requires host ownership. It can continue after victory or defeat, consuming a portal through the normal game request. |
| Auto Leave Match | Returns to the lobby after the match ends. Takes priority over the other result actions. |
| Auto Fast Forward Speed | Unavailable and disabled. The connected game build exposes no matching speed control or request. No speed change is claimed. |

Result actions use **Result action delay (seconds)**, default `2`. When several result controls are on, **Leave → matching Next action → Replay** determines the single request. Next Story/Room apply after a win; Replay can handle a loss. Missing results, host ownership, the next act, or a valid portal are shown as waiting states.

Accepted/unknown-successful result votes are remembered until an actual reset, including after settings changes. Explicit rejections have bounded retries. Errors and unresolved calls are not repeatedly sent. Start voting has up to three automatic attempts spaced three seconds apart; skip voting has up to three attempts spaced one second apart within the open window.

Start Game is independent of Replay. There is no second replay-specific start toggle. To automate a normal repeat cycle, enable **Play**, **Auto Start Game**, and **Auto Replay**. Add Auto Skip Wave if wanted. Enable the relevant Next control for progression. Auto Leave overrides the other result controls.

**Stop everything** pauses Match automation, playback, and wave rules. **Resume match automation** resumes enabled automatic controls. Save with **Save Match settings in this macro JSON** or the existing wave-rule save button.

## Recording and playback

1. Enter a macro name. Set **Record start** to This match or Next match, then switch **Record ON**.
2. Place, upgrade, sell, change priority, and use supported abilities/votes normally.
3. Switch **Record OFF** to stop and save. Disabling before an armed recording starts cancels the wait without overwriting the file. Both operation toggles are disabled while saving.
4. Select the recording and set **Play start** to Sync current match or Next match. Switch **Play ON**.
5. Play automatically runs again at every new match while enabled. It stays on after completion or an early loss. **Play OFF** cancels the current operation and future repeats. There is no separate Repeat control. Failed starts or playback errors switch Play off.

Record and Play cannot run together. Rapid clicks do not create duplicate sessions. Unit references, full placement CFrames, and exact priority arguments are retained. Confirmation checks distinguish pending, confirmed/request-only, and rejected actions; unconfirmed attempts are skipped during playback. Movement and camera input are outside the action macro.

## One JSON

Normal saves write only `AA_Macros/<name>.json` inside the executor workspace. That file contains the actions, timing samples, unit identities, and all saved settings. Save settings alone to create a profile without actions. No automatic draft, staging, backup, or playback-report file is written. Playback reports and unfinished recordings remain in memory.

Writes verify the file and can restore its previous contents from memory on a recoverable failure. Old helper files are removed only after validating the main JSON. **Remove old helper JSONs** retains orphan recovery files and manual diagnostics. If `makefolder` is unavailable, recordings use the `AA_Macro_` filename prefix instead.

**Save clock / unit diagnostics JSON** is an optional manual export of `<name>.diagnostics.json`. No recording, inventory, or diagnostics are uploaded to GitHub.

## Wave rules

Auto-upgrade and auto-sell remain under **Wave rules** and apply to all units with confirmed ownership matching you.

- Auto-upgrade supports a start wave, inclusive end wave (`0 = no end`), and target level (`0 = Max`). It spreads requests across units, backs off for funds/readiness, and stops repeatedly upgrading an unconfirmed or maxed unit.
- Auto-sell applies from the chosen wave onward, including later placements. Selling takes priority over upgrading. Playback skips future unit actions in the sell phase.
- During an active upgrade window, the rule manages matching upgrades instead of duplicating recorded calls. Automation and playback coordinate in-flight unit requests.

Both rules default off. Standalone Pause/Resume buttons are available. Saving stores their settings inside the same JSON.

## Timing

Defaults are **Adaptive / Catch up / Auto**. Each v2 action stores the wave, replicated timer, and observed phase when available. Timer direction and plausible server timestamps are detected. Paused timers pause actions; early playback waits for readiness. Catch-up preserves ordering and avoids matching existing placements or completed upgrades.

If the timer is unavailable mid-wave, Adaptive waits for an observed wave boundary. **Wave only** ignores within-wave time. **Offsets** uses elapsed time after playback starts and supports legacy v1 recordings. **Stop if late** rejects overdue actions. Positive timing adjustment delays actions; negative adjustment advances them within their wave.

Late injection cannot reproduce combat that already happened. Server execution still depends on frames, replication, latency, funds and cooldowns; exact server-side timing is not guaranteed.

## Teleport resume

When an enabled session teleports, MAA queues the latest GitHub bundle through `queue_on_teleport` and restores settings plus enabled playback from an in-memory payload. No extra JSON is created. It loads the same named recording from executor storage. In a lobby, enabled playback waits for a match.

Map/account/place validation still applies. A recording for a different map must not be replayed blindly; a mismatch stops playback. A fresh Roblox process is separate from a teleport and still needs the loader. Executors without teleport queuing report that the loader must be rerun.

## Verification

The bundle compiles with official Luau 0.745, passes 109 local checks, and passes Real's static checker with zero errors/warnings. The actual UI loaded through Real, all eight Match controls rendered, and the live adapter read the connected match mode and level without errors. All automation was off during the live UI check. Story, tower, portal, leave and teleport requests were checked against live client handler code and local engine doubles; successful live server progression remains unverified.
