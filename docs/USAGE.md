AA Macro 2.0

Use **AA_Macro_v2.lua**. It embeds [Cybersize/MattLib](https://github.com/Cybersize/MattLib) 1.2.1, pinned to commit `bb9187fa8be705a5b7225904b0dd737c9f612035`. The MIT license is included in the script. No separate UI loader, download, or HTTP request is needed. Vector is the default design; Diagnostics offers all four MattLib designs.

Put the file in your executor's workspace and run:

```lua
loadstring(readfile("AA_Macro_v2.lua"))()
```

You can also execute the file's contents directly. The panel should read **AA Macro 2.0**. Running it again disables the earlier macro controller and replaces its UI. Right Ctrl hides/shows the window; MattLib provides dragging, resizing, and restore controls.

Make a new recording with v2. Old v1 JSON files do not contain wave synchronization data; they can load, but use their original elapsed-offset schedule.

1. Choose a macro name. **Record this match now** works when the match is already underway. **Arm recording for next match** waits for the next observed match start.
2. Place, upgrade, change priority, and sell normally. Active abilities and supported start/skip votes are also captured. Spawn preserves the inventory UUID, full CFrame position/rotation, and argument count. The screenshots' priority value `flying` is kept verbatim. Unit references retain their identity when sold models move into ReplicatedStorage.
3. Click **Stop / save recording**. Requests are processed outside the recording hook and confirmed from replicated state when available. Placements stay pending until their units are associated. Requests without a readable confirmation field are explicitly marked `request only` in JSON. Unconfirmed attempts remain marked and are skipped during playback.
4. Keep the same account, map, and unit inventory. Load the JSON, then click **Play / sync current match**. It can join an already-running match. **Play next match** waits for a reset/start transition. **Vote to start match** sends the zero-argument start vote shown in the screenshots.
5. **Stop playback** cancels future actions and retries. An already-sent request can still finish.

The **Timing** tab defaults to **Adaptive**, **Catch up**, and **Auto** timer interpretation.

- **Adaptive:** each action stores its wave and `_wave_time` reading, plus an observed wave phase when available. Playback uses the game's current wave/time. Auto detects increasing/decreasing movement and handles plausible server timestamps separately. A paused replicated timer pauses actions; early execution can wait for map/endpoints readiness.
- **Catch up:** overdue steps run in sequence with a minimum gap. Existing matching placements and completed upgrades are skipped. A unit already sold in the overdue timeline is not bought again. Explicitly rejected unit actions retry within the readiness timeout. Ambiguous or unconfirmed placement results stop playback to prevent duplicates.
- **Stop if late:** stops when an action misses its permitted timing window.
- **Wave only:** synchronizes by wave and deliberately ignores within-wave time. This is a less precise fallback.
- **Offsets:** replays elapsed offsets from playback start; legacy v1 recordings use this mode.
- **Timing adjustment:** positive seconds delay actions; negative seconds advance them within the same wave.

The place snapshot contained `_wave_num` and `_wave_time`, both at zero; the main wave-service implementation was missing. Auto observes the live timer rather than assuming its meaning. If the timer stays zero or mid-wave time cannot be established, Adaptive waits for an observed wave boundary. It cannot reconstruct an unexposed clock. Manual increasing, remaining, start-timestamp, deadline-timestamp, and observed-boundary modes are available if diagnostics establishes the right interpretation.

Catch-up applies recorded unit state using current resources; it cannot reproduce earlier combat or guarantee the same result. Server execution timing also depends on frame scheduling, replication, latency, funds, and cooldowns. Cobalt's log timestamps are not used as the game's clock.

For automatic repeat, save a recording, click **Learn in-game Replay button** at an end screen, then click the game's Replay button once. Enable **Repeat after match resets** and **Send learned replay vote**. After completed playback, the script sends the learned vote once at the end state and waits for the next match. Other players' votes and game rules may delay a reset. A new Roblox client/server session still requires running/loading the script again; teleport reinjection is not installed.

Files are stored in `AA_Macros/` inside the executor's workspace. Without `makefolder`, files use the prefix `AA_Macro_` in its workspace root.

- `<name>.json`: completed recording, including wave/time samples, arguments, unit tokens, and confirmation states.
- `<name>.draft.json`: incomplete recovery snapshot; the normal loader rejects unfinished drafts.
- `<name>.backup.json` and `<name>.staged.json`: save recovery/verification files.
- `<name>.last-playback.json`: timing samples, attempts, rejection reasons, skips, and result.
- `<name>.diagnostics.json`: clock samples, recent action states, unit ownership-field names, and playback details.

If spawning still fails silently, wait for the pending action to resolve, then use **Diagnostics → Save clock / unit diagnostics JSON**. Send that file and the last-playback file if the failure occurred during playback. These files remain local; the script does not upload them.

Executor requirements: `hookmetamethod`, `getnamecallmethod`, `readfile`, `writefile`, and `loadstring` for the embedded UI bundle. The hook observes supported `:InvokeServer()` / `:FireServer()` calls; separately cached native-method calls may bypass it. It only queues plain data and tail-forwards the original call. It performs no Instance serialization, network-result wrapping, or yielding, and preserves the original method/arguments. Unknown ownership layouts or ambiguous identical units can still require diagnostics. Movement and camera input are outside this action macro.

Optional settings before execution:

```lua
getgenv().AA_MacroOptions = {
    ShowUI = true,
    TimingMode = "Adaptive",
    LatePolicy = "Catch up",
    TimerSource = "Auto",
    ReadyTimeout = 45,
    RetryInterval = 0.5,
    ConfirmTimeout = 8,
    CallTimeout = 8,
    MinActionGap = 0.12,
    MaxLateness = 0.25,
}
```

The script compiles with official Luau 0.745 and passed 24 deterministic core scenarios plus five actual-MattLib integration checks in engine doubles. It has not been verified in the live game, your executor, or a real rendered Roblox UI. Start with a short place → upgrade → priority → sell recording.
