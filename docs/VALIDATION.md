# MAA 2.8.1 validation

The self-contained bundle compiles with official Luau 0.745. Real's checker reports zero errors and warnings for the core and its live wrapper (with the injected STATE declaration supplied for checking). MattLib 1.2.1 is unchanged, pinned to `bb9187fa8be705a5b7225904b0dd737c9f612035`, with its license and source hash embedded.

## Local scenarios

All 206 scenarios passed:

| Suite | Count | Coverage |
| --- | ---: | --- |
| Recording/timing | 24 | Passive dispatch, confirmations, CFrames, unit identity, late/wave/time catch-up, cancellation, JSON validation. |
| Storage/wave rules | 17 | One JSON, failed-write recovery, helper cleanup, ownership, upgrade/sell windows, retries and playback coordination. |
| Replay | 18 | Standalone replay, cancellation/deduplication, rejection/error handling, losses and match resets. |
| Auto Start | 16 | First/subsequent rounds, readiness, recorded-vote coordination, bounded retries and persistence. |
| Match | 16 | Story/tower/portal conditions and arguments, result precedence, skips, unresolved calls and teleport restoration. |
| Buffs | 34 | Current abilities, separate families, staged relay timing, valid ring geometry, confirmation/retry limits, native auto-cast suppression, settings and Stop; preplaced four/six-unit adoption, isolated extras, overlap exclusion, basic fallback, counts, removal/recovery and blocked unknown casts. |
| Auto Play | 24 | UUIDs, caps/funds, rotated slots, circle/map plans, surfaces, continued scans, priorities, upgrades/sales, macro exclusion, match reset and integrated staged supports and six already placed supports without replacement purchases. |
| Action Plans | 34 | Schema/dependency rejection; no-RPC editing; marker position/rotation; invalid surfaces/maps; undo/redo; safe reorder/removal; values/priorities; one-file persistence; delete/restore; ordered confirmed playback; wave/time waits; pause/editor state; existing units/upgrades and foreign ownership; map/account/equipment gates; money/caps and currency-change retries; unresolved/failed/rejected requests; unavailable priorities; post-plan Auto Play and wave rules; match repetition; save-after-Stop; stable cursors under unrelated settings; real queued-source restoration in a simulated new client; conservative late-sale pruning; failed-save rollback; and timed waits during another worker request. |
| MattLib integration | 23 | Seven tabs and all prior controls; native-style pointer adding/dragging with inset correction; undo/action buttons; profile saves; projection round trips; disabled conflicting controls; close/reload cleanup of viewports and input connections. |

Core tests use deterministic Lua engine doubles. UI tests run the actual embedded MattLib under official Luau with mocked Roblox services. The new viewport backend is substituted in those tests, so they verify state, layout, input routing and cleanup rather than native 3D rasterization. Expected missing-file/rejected-request cases intentionally print errors in their test runs.

## Current-client and reference evidence

Earlier v2.7 research indexed 1,605 scripts from Anime Adventures place 14229839966, build 637. Client handlers establish the spawn/upgrade/sell/priority requests, placement-surface distinctions, cost/cap helpers, Match requests and buff readiness/expiry fields. The v2.7 UI/read-only placement preview found valid candidate positions for every equipped unit after bounded scans, with no game action sent. That evidence supports the shared adapter; it is not a live test of the new editor or plan worker.

The [XT HUB showcase](https://www.youtube.com/watch?v=wIy6MdyVY0U) was visually inspected for map markers, ordered actions and plan controls. The implementation uses MattLib and new code; no linked third-party script was executed. [Buff research](BUFF_COMBO_RESEARCH.md) records the separate staged-support tutorial.

Roblox documents [WorldModel spatial queries](https://create.roblox.com/docs/reference/engine/classes/WorldModel) and [Camera viewport limitations](https://create.roblox.com/docs/reference/engine/classes/Camera). The editor uses a local WorldModel and explicit viewport-size projection/ray math, avoiding the assumption that a preview camera inherits the game camera's dimensions. Static clones exclude scripts and transient preview/input resources are destroyed on close/unload.

## v2.8.1 diagnosis and live boundary

Read-only inspection of Anime Adventures place 14229839966, build 1370, found six owned Erwins with `erwin:buff_units`, ready cooldown state and no received damage buff. Their actual active cooldown was approximately 63.27 seconds. Four of the six formed a mutually covering group. The detection adapter worked; Auto's strict exact-two setup gate incorrectly treated the existing layout as unusable.

Auto now adopts a valid existing group or uses upkeep without requiring a match restart. Explicit Four-unit relay retains the video's staged setup. Local tests model non-overwriting transferred buffs and show warm-up progress, but this remains a disclosed simulation of the server rule. No support was placed, sold or cast during the read-only diagnosis. Real disconnected before the revised controller could be exercised live. Current-server buff transfer/coverage/uptime therefore remains unverified.

## Live limits

No matching Anime Adventures client was connected during v2.8 verification; the responsive Real client was in a different universe. The controller was not run there. Native map cloning/rendering, physical mouse/touch acceptance and server results for the new worker remain unverified. Previous read-only client evidence and local simulations do not establish sustained 100% buff uptime or the hidden transfer formula. Fast Forward and the six-unit double-line combo remain unavailable/unimplemented.
