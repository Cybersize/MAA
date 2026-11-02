MAA 2.3

Run the same GitHub loader to get the current version:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Cybersize/MAA/main/loader.lua"))()
```

You can also run the local `MAA.lua` file. The panel should show **MAA 2.3**. MattLib 1.2.1 is embedded with its MIT notice; no separate UI download is needed. Right Ctrl hides/shows the window. The designs are selectable in Diagnostics.

One recording file

Normal saving now writes only `AA_Macros/<name>.json` inside the executor workspace. It contains the actions, wave/time data, unit identities, replay vote, and wave-rule settings. No automatic draft, staged, backup, or last-playback JSON is created. The previous file is held in memory during write verification so a recoverable write failure can restore it. Unfinished recordings and playback diagnostics stay in memory until explicitly saved/exported.

After a successful save, old helper files for that recording are removed when `delfile` is available. **Remove old helper JSONs** cleans other profiles too. Cleanup first validates the main recording; if it is missing or corrupt, recovery files are retained. Main recordings are never deleted by cleanup. Manual diagnostics exports are retained.

If `makefolder` is unavailable, the same files use the prefix `AA_Macro_` in the executor's workspace root. Local recordings are not uploaded to GitHub.

Recording and playback

1. Give the macro a name. Choose **Record start → This match** or **Next match**, then switch **Record ON**. Next match keeps the toggle on while waiting for a new match.
2. Place, upgrade, change priority, sell, and use supported abilities/votes normally. Spawn preserves the UUID and all CFrame components. Sold models retain their macro identity after moving to ReplicatedStorage.
3. Switch **Record OFF** to stop and save the same JSON. Switching it off before an armed recording starts only cancels the wait. While saving, both toggles are disabled and the panel shows **Saving recording...**. Placement confirmation waits for its live unit; unavailable confirmation fields are marked `request only` in JSON. Unconfirmed attempts remain marked and are skipped during playback.
4. On the same account/map with the same unit inventory, choose the macro name and set **Play start → Sync current match** or **Next match**. Switch **Play ON**; it loads the named JSON when needed. Switch **Play OFF** to stop or cancel a pending start. The timing defaults are **Adaptive / Catch up / Auto**.
5. Play stays on while waiting for map readiness or the next repeat match. It turns off when playback completes without Repeat, stops, or fails. Record and Play cannot run together; conflicting controls are disabled. Rapid clicks do not create duplicate sessions, and an unsuccessful start restores the toggle to its actual state.
6. Switching either active toggle off and **Stop everything** pause wave rules and Auto Replay as well. A request already sent to the server can still finish. Starting recording/playback resumes configured rules; standalone rules also have explicit Pause/Resume buttons.

Wave auto-upgrade and auto-sell

Open **Wave rules**. Both toggles are off by default. They apply to all placed units whose replicated ownership matches your player; other players' or unknown-owner models are skipped. Rules work during an active match with or without macro playback.

- **Enable auto upgrade:** begin at **Upgrade from wave**. **Upgrade through wave** sets an inclusive end (`0` means no end). **Target upgrade level** sets the desired level (`0` means Max).
- Upgrades are spread across your units with one automatic request in flight at a time. Funds/readiness rejections back off and retry. A reported maximum stops retries for that level. Accepted upgrades must produce a level change; an unconfirmed result pauses upgrading that unit to prevent duplicates.
- **Enable auto sell:** sell from **Sell from wave (inclusive)** onward. Late enabling after that wave also works. Newly placed owned units are sold while the rule remains enabled. Selling takes priority over upgrading.
- During an active upgrade window, the rule manages upgrades in place of recorded upgrade actions. Earlier recorded upgrades still play before the rule's start wave. Once the sell wave is reached, future unit actions/placements in the macro are skipped so playback does not keep using or buying sold units.
- **Save wave rules in this macro JSON** writes the settings into the same recording file. Without a recording, it creates a settings-only profile. Load applies its saved rules; enabled rules can begin immediately when their wave is already reached. Settings-only profiles run through the wave toggles, not the Play button.
- **Pause wave rules** pauses automation. **Resume wave rules** resumes it. **Stop everything** also stops the macro. RPC timeouts pause automation while an unresolved request remains outstanding.

Example: upgrade from wave 3 to level 4, then sell from wave 15 onward. Set start `3`, target `4`, sell wave `15`, enable both toggles, then save. Keep stop wave `0` unless you want a specific upgrade end wave.

Timing

Adaptive stores each action's wave, replicated `_wave_time`, and an observed phase when available. Auto detects increasing/decreasing timers and plausible server timestamps. A paused replicated timer pauses actions. Early execution waits for map/endpoints readiness. Late execution can catch up in order and skip matching existing placements or completed upgrades.

If a usable mid-wave timer is unavailable, Adaptive waits for an observed wave boundary. **Wave only** intentionally ignores within-wave time. **Offsets** uses elapsed time since playback starts; legacy v1 recordings use this mode because they have no wave samples. **Stop if late** rejects overdue actions. Positive timing adjustment delays within-wave actions; negative adjustment advances them.

The supplied place snapshot had zero wave/time values and lacked its main wave-service implementation. The live timer's meaning must therefore be detected or selected from diagnostics. Late catch-up cannot reproduce earlier combat, and server timing still depends on frames, replication, latency, funds, and cooldowns. Cobalt's logging timestamps are not used as the game clock.

Repeat and diagnostics

On the **Macro** tab, enable **Auto Replay at match end**. No learning step or loaded recording is required. It uses the built-in `set_game_finished_vote("replay")` request. The optional learned-argument override remains available if the game's request format differs.

- **Replay delay (seconds)** defaults to `2`. It can be changed from 0 to 60 seconds.
- Enabling Auto Replay also enables macro Repeat. Turn Repeat off if you want only replay voting and standalone wave rules. A macro starts repeating after you have started playback; simply loading a file does not launch it.
- At a normal finish or early loss, pending future-wave playback is cancelled. A repeating macro waits for the next actual match reset instead of hanging on unreachable waves.
- A sent vote is not repeated while waiting for the server or other players. Explicit rejections retry with spacing, up to three attempts by default. Errors and unresolved RPCs stop repeated voting; status is displayed in the panel.
- **Auto-start replayed match** defaults on. After a reset, it sends a zero-argument start vote only if the game has not already started, its endpoint is ready, and the map is not a lobby. Disable it for manual starts.
- **Stop everything** pauses replay and start voting too. Replay waits while a recording is active or a manual argument-learning session is pending.
- **Save wave rules in this macro JSON** stores the replay toggle, repeat preference, delay, and start setting with upgrade/sell settings. No additional JSON is created.

These controls operate within the current client/server session. A new Roblox client still requires running/loading MAA again; teleport reinjection is not installed. The built-in request has not been verified against your live server; use diagnostics and the optional override if the vote is rejected.

Playback reports remain in memory. **Save clock / unit diagnostics JSON** explicitly exports `<name>.diagnostics.json`, including the report, current clock samples, recent recording states, and ownership-field names. Use this only when troubleshooting; it is the only optional extra JSON. No diagnostics are uploaded.

The namecall recorder requires `hookmetamethod`, `getnamecallmethod`, `readfile`, `writefile`, and `loadstring` for the embedded UI. Separately cached native-method calls can bypass namecall capture. The hook only queues plain data and forwards the original request; processing runs outside it. Movement and camera input are outside this action macro.

The bundle compiles with official Luau 0.745 and passed 59 core scenarios plus 16 actual-MattLib integration checks in local engine doubles. It has not been verified in the live game or your executor. Start with a short recording and low-risk wave settings before using a full run.
