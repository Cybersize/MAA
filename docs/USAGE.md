# MAA 2.8.1

Run the same GitHub loader to receive the latest version:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Cybersize/MAA/main/loader.lua"))()
```

The panel should show **MAA 2.8.1**. MattLib 1.2.1 remains embedded. Right Ctrl hides/shows the window. Choose a design in Diagnostics.

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

**Stop everything** pauses Match automation, Buffs, playback, and wave rules. **Resume match automation** resumes enabled automatic controls. Save with **Save Match settings in this macro JSON** or the existing wave-rule save button.

## Buffs

The **Buffs** tab adds the five controls from your screenshot. All default off and apply only to your confirmed-owned support units.

| Control | Behavior |
| --- | --- |
| Auto Damage Buff | Basic upkeep for supported active damage buffs. Avoids another nearby same-family cast while its effect is still within its duration. |
| Auto Range Buff | Uses supported active range buffs. Evolved Kisuke unlocks his at upgrade 6. |
| Auto Cooldown Buff | Uses supported attack-SPA reduction buffs. Kisuke's range and SPA effects share one request when both controls are on. This does not reduce active-ability cooldowns. |
| Auto Commander | Runs the selected formation-checked Erwin sequence instead of basic damage upkeep for that family. |
| Auto Windsong | Runs an independent Wendy sequence with the same placement/readiness checks. |

Choose **Auto**, **Four-unit relay**, or **Five-unit pentagon**. **Auto reuses already placed owned supports.** It prefers a valid five-unit ring, otherwise adopts four mutually covering supports for an existing-unit relay with warm-up. Extra units do not invalidate that quartet. Isolated extras receive basic upkeep between combo casts; extras that could interfere with the selected combo are excluded from casting. Without a suitable combo, Auto uses basic upkeep for the existing units. This does not implement the researched six-unit double-line combo.

The status shows the number of detected owned supports and how many are ready, followed by the selected behavior. Zero detected is distinct from a formation or cooldown wait. An existing relay can take additional cycles to build strength and uses observed expiry/readiness. Auto can recover after a support is removed or a fourth support arrives early. It never sells or replaces existing units to seed a combo.

**Four-unit relay** explicitly selects the tutorial's strict staged setup: begin with two supports, add the third after cast 1, wait four seconds, cast the second, then add the fourth. Auto Play preserves this sequence when starting fresh; it waits for the second support before the first cast. Follow the setup prompts in explicit relay mode. The pentagon rejects coverage of opposite supports, including one-way coverage from unequal ranges.

Combo steps use received-buff expiry, current per-unit cooldowns, global readiness, and replicated cast confirmation. Commander and Windsong track separate sequences. The ring spaces casts using the current cooldown. The explicit staged relay follows the supplied tutorial; its curse requirement is not changed automatically. These schedules are experimental: the current server's complete transfer-strength formula and curse behavior have not been verified by live casts. A valid layout alone does not guarantee a sustained 100% loop.

The status reports the maximum buff **observed on the support units**. It does not certify every damage unit's coverage, uninterrupted uptime, or future server acceptance. Damage-stack strength and uptime are separate measurements. Passive auras such as Idol (Star) are excluded from active requests. MAA clears the game's separate native auto-cast state for support units it manages so it cannot interrupt the sequence.

When a specialized family is enabled, basic damage upkeep leaves its sequence alone. Matching recorded active calls defer to enabled Buffs automation. Unit requests coordinate with playback and wave rules; selling takes priority. An unresolved request is never duplicated, and an unconfirmed cast pauses that unit until a new observed cast or an explicit settings reset. Explicit rejections back off and stop after three attempts.

Use **Save Buffs settings in this macro JSON** to store the controls in the same profile. **Stop everything** pauses Buffs too; **Resume buff automation** resumes enabled controls. Teleport resume includes Buffs settings without creating another JSON. See [the research notes](BUFF_COMBO_RESEARCH.md) for current-client evidence, historical sources, and remaining unknowns.

## Auto Play

The **Auto Play** tab implements the controls from the supplied screenshot. It places equipped units without requiring a recorded action macro. **Enable Auto Play** defaults off. It waits while macro Play is enabled, including while waiting for the next round.

For repeating autonomous placement, leave macro Play off and enable **Auto Play**, **Auto Start Game**, and **Auto Replay**. A saved recording is unnecessary; save a settings profile if wanted.

| Control | Behavior |
| --- | --- |
| Placement Mode | **Smart Path & Corners** samples beside actual road geometry and scores nearby-road coverage. **Circle Placement** samples within the configured radius around a saved center. |
| Snap to Path Corners | Favors road-segment ends in the scoring heuristic. This does not solve an optimal combat strategy. |
| Auto Target Priority | Applies the selected target to all confirmed-owned placed units when the game's valid-priority helper allows it. Unsupported Flying/Soaring targets are skipped. |
| Circle Radius | Placement-center radius in studs, from 5 to 100. |
| Auto Upgrade Units | Uses the shared wave-rule worker for owned units. |
| Max Upgrades per Unit | Target upgrade level; `0 = Max`. Explicit active wave-upgrade settings take precedence. |
| Auto Sell at Wave | Sells owned units from the selected wave and stops buying replacements; `0 = Off`. |

Auto Play rotates equipped slots, reads actual placement counts/caps, calculates current cost through the game's multiplier, and waits for currency. It checks ground/hill/hybrid placement surfaces, footprint edges, road clearance, obstacles and other units. Mesh obstacles use temporary local collision-query copies, destroyed immediately after the check. A bounded candidate scan continues on later ticks when early candidates are invalid.

One automatic unit request runs at a time across placement, priority, upgrades, sales and Buffs. Placements require a new matching owned unit to appear near the requested position. Errors and unconfirmed outcomes pause that unit; explicit rejections back off and stop after three attempts. An unresolved request remains single, including after a toggle/settings change. Settings changes can reset a blocked unit after its request finishes.

For a circle plan, choose **Game Mode Category** and **Select Map / Stage**, join that map/mode, click **Set Circle Position (Click on Map)**, then click a placement surface. Esc cancels. Use **Save Plan for Map** to store the position in the same named macro/profile JSON. All map plans share that file; no per-map sidecar is created. Plan selection edits a plan; it does not join or teleport to that stage. Runtime Circle mode uses only a saved plan matching the actual map, category and place.

Use **Save Auto Play settings in this macro JSON** for global controls without changing a circle position. **Stop everything** pauses Auto Play, and **Resume Auto Play** resumes enabled controls. Enabled Auto Play and its plans are included in teleport resume. Each new match resets placement state. The visual action editor is available in **Saved Action Plans**, below the Auto Play controls.

When Commander/Windsong uses the staged relay, Auto Play holds that support family at the count required by its current setup step and checks mutual range. It caps that family at four for the relay even if the game's spawn cap is higher. It does not buy curses, alter traits, reposition existing units, or silently sell an incorrectly seeded group. Five-unit ring layouts still require valid placement; basic Smart Path placement does not promise that ring.

## Visual placement editor and Action Plans

The **Auto Play → Saved Action Plans** section adds the editor from the requested workflow. It uses MattLib around a separate 3D map preview and numbered unit markers. Editing never sends placement, upgrade or sale requests. Opening the editor pauses new MAA automatic unit actions; an already-sent server request can still finish.

1. Join the map and mode you want to plan. Stop macro Record/Play, enter **Plan Name**, and click **Create Plan**. For an existing plan, choose **Saved Action Plans → Edit Plan**.
2. Select an equipped unit, click **Add marker on map**, and click the preview. Drag a marker to move it. **Rotate 90°** changes its saved spawn orientation; the arrow shows its direction. Surface and obstacle checks reject invalid positions.
3. Click a marker, then append **Upgrade**, **Sell**, or **Add priority**. Upgrade adds the next planned target level; select that action and use **Wait / target level value → Set value** to change it. Choose a target and use **Set priority** when editing a priority action.
4. Enter a value and add **Wait wave** or **Wait seconds**. Select a row and use **Move ↑/↓** or **Delete** to edit the order. Spawn must precede its unit actions, and a sold unit cannot act again. Removing a Spawn removes that marker and its dependent actions. **Undo/Redo** keeps up to 50 draft transactions in memory.
5. Use **+/−**, the mouse wheel, and **Fit** to zoom. Right-drag or choose **Pan view** to pan. **Hide plan** hides markers; **Objects** toggles decorative map geometry. Touch dragging and zoom buttons are supported.
6. Click **Save plan to current profile JSON**, then close the editor. Choose the saved plan and enable **Auto Play Plan**. Leave macro Play off. The plan runs now when ready and runs again at every new match while enabled. Saving or closing does not enable execution automatically.

The editor copies up to 1,800 static map parts into a local WorldModel and deletes the preview and listeners when closed or replaced. It does not change the game camera, move world objects, or run scripts from cloned parts. On narrow windows the action panel stacks beneath the map and remains scrollable. If another map is loaded, saved markers can still be inspected and actions reordered, but position edits require the original map/mode.

All named action plans, map circle centers, macro actions and settings share the same `AA_Macros/<profile>.json`. Drafts and undo history stay in memory. **Delete Plan** saves its removal; **Restore deleted plan** can recover the latest deletion until script reload. Failed saves/deletions restore prior in-memory settings and retain recoverable file contents. Unsaved edits are not recovered after reload.

Each action plan stores its map, mode, place, account, inventory UUIDs, positions, rotations and action order. Playback waits for those requirements, actual funds/caps and valid unoccupied positions. Existing owned units near their marker can satisfy a Spawn; completed upgrades/priorities are skipped. It never binds another player's unit. Explicit past-wave sale phases can skip an unnecessary purchase/upgrade on late starts; delays with uncertain timing are executed in order.

Wait seconds counts elapsed active time and pauses during Stop, editing, match results or macro playback. Wave waits continue as soon as their minimum wave is reached. Wait actions can progress while another worker's request is outstanding, while unit requests remain serialized. This is an ordered plan, not a replay of historical combat; exact server execution still depends on replication, latency, funds and the server.

One planned unit request runs at a time. Unknown outcomes and request errors stop that run; unresolved calls are never duplicated. Explicit rejections back off and stop after three attempts. A recognized insufficient-funds rejection waits for currency to increase. **Restart selected plan** starts again after pending requests return and can match already-present units.

**Auto Play After Plan** permits normal Auto Play after completion only when **Enable Auto Play** is also on. Without it, automatic filling stays suspended. Wave upgrade/sell rules wait while a plan runs and can resume once it completes. Enabled Buffs can run between ordered unit actions. **Stop everything** pauses execution; enabling the plan or using a Resume control resumes configured automation. Enabled plans and selection are included in teleport resume without another JSON.

Limits: 100 saved plans per profile, 64 unit markers and 500 actions per plan, 5,000 total planned actions. The native 3D preview and live server playback still need verification in the target game; the current validation uses engine doubles and a mocked viewport backend.

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

The v2.8.1 bundle compiles under official Luau 0.745 and passes 206 local scenarios, with zero errors or warnings from Real's core checker. Twelve new regression scenarios cover preplaced groups, six-unit selection, isolated upkeep, counts, removal/recovery, unknown outcomes, extra units joining a running combo and Auto Play coordination. Current-client read-only checks confirmed six owned ready Erwins; the failure came from the exact-two setup gate. The client disconnected before the revised controller could be tested live. Simulated warm-up does not prove the hidden server transfer formula or sustained 100% uptime. Native editor rendering and server plan playback also remain unverified. See [validation](VALIDATION.md).
