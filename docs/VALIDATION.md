# MAA 2.7 validation

Official Luau 0.745 compiles the bundle. Real's checker reports zero errors and warnings for both the core and the live wrapper (with the injected STATE declaration supplied to the checker). MattLib 1.2.1 remains pinned to `bb9187fa8be705a5b7225904b0dd737c9f612035`; its license and source hash are embedded.

## Local checks

All 157 checks passed against the final v2.7 core and actual embedded MattLib:

| Suite | Checks | Scope |
| --- | ---: | --- |
| Recording and timing | 24 | Passive hook forwarding, placement CFrames, action confirmation, sold-unit identity, wave/timer direction, late catch-up, cancellation, JSON validation. |
| Wave rules and storage | 17 | Single JSON, restoration after failed writes, helper cleanup, ownership, upgrade/sell windows, retry limits, playback coordination. |
| Replay | 18 | Independent replay, countdown cancellation, deduplication, rejection/error handling, early loss, match resets. |
| Auto Start | 16 | First/subsequent matches, map/endpoint readiness, recorded-vote coordination, bounded retries, Stop and persistence. |
| Match | 16 | Story/tower/portal gating and arguments, result-action precedence, wave skips, unresolved calls, queued teleport restoration. |
| Buffs | 23 | Default-off schema, basic upkeep, shared Kisuke cast, locked/busy/other-owner filtering, formation waits, four-unit expiry/stagger ordering, modified cooldowns, five-unit ring ordering, rejection of one-way opposite coverage, recorded-active deduplication, coordination with unresolved buff requests, family isolation, removed units, confirmation/retry limits, Stop, one-file persistence, early-placement rejection, preservation across unrelated settings and native auto-cast suppression. |
| Auto Play | 23 | UUID/cap/ownership and money gates, slot rotation, map/category/place plans, one JSON, circle bounds, road/surface/occupied-point filtering, continued scans, valid priorities, upgrades/sell precedence, Stop, timeout/rejection handling, macro exclusion, match reset, lobby/map readiness, and integrated staged support placement/casts. |
| MattLib integration | 20 | Seven tabs, native Activated callbacks, Record/Play toggles, all four designs, re-execution cleanup, state/error synchronization, Match controls and disabled Fast Forward, Buffs controls, pattern selection and Auto Play controls. |

The core suites use deterministic Lua engine doubles. UI integration runs the real bundled MattLib under official Luau with mocked Roblox services. Intentional failure cases include missing files, rejected requests and unconfirmed actions; their expected messages are not startup failures.

The Buffs test model simulates a capped multiplicative transfer and refuses to overwrite an existing received buff. This tests scheduler ordering, cancellation and synchronization under that stated model. It is not evidence that the hidden server uses that exact strength formula or produces a 100% live stack. The ring test verifies ordering and spacing; it does not prove full-team coverage.

## Current-client research

The client index covered 1,605 scripts from place 14229839966, build 637. Unit attack data confirms Erwin's 25% physical/30s buff, Wendy's 30% magic/30s buff, and their base 60s active cooldowns. Evolved Kisuke's range/SPA ability unlocks at upgrade 6, with current cooldowns 120/105/90 seconds at upgrades 6/7/8. Idol (Star)'s aura is passive.

The current UI uses `AttacksReplicate.get_current_active_attack_cooldown(model, activeId)` for queued/using state, cooldown and global readiness. It reads `_stats.last_active_cast`, `_buffs` effect state and `_dmg_buff_physical`/`_dmg_buff_magic` attributes. The corresponding active request is `use_active_attack(model)`.

The Match handlers were checked for the game's start/skip/result voting, story, tower, portal and return-to-lobby requests. Portal inventory and host rules follow the client handlers. No matching Fast Forward handler/control was found in bounded endpoint/UI/index searches; its control stays disabled.

## Live evidence and limits

The final MAA 2.7 code loaded through Real live-reload with the stable label MAA. It printed the title MAA 2.7, seven tabs, mode infinite and level namek_infinite. The final startup/read-only preview returned no client warnings or errors. It read the actual six-slot team and caps, current costs, ground/hill data and valid candidate positions. The bounded preview needed later scans for some units; after three scans it found a position for each equipped unit. These were candidate positions, not placements. Temporary collision-query folders were destroyed after each query.

An initial preview caught overly conservative mesh-box rejection and model-name lookup warnings. The final code uses the canonical pet-model name for footprint calculation and the physics engine's narrow-phase mesh overlap query. The final preview passed without those warnings. Six user-placed Erwins were observed during later read-only checks, with an active cooldown of approximately 63.27 seconds. No MAA automation was enabled and no game action was sent. Real later disconnected, so no further live casting test was attempted.

The supplied [Lenio tutorial](https://www.youtube.com/watch?v=XPMjMMMMkyg) was checked through captions and visible frames. It establishes staged placement for the relay, not just four preplaced supports. The local Buffs tests were corrected accordingly. The integrated scenario verifies spawn/cast ordering and the four-unit limit under a disclosed transfer simulation; it does not prove the server's formula.

The [XT HUB showcase](https://www.youtube.com/watch?v=wIy6MdyVY0U) was inspected as a second UI/workflow reference. It includes a separate visual action-plan editor; this build implements the supplied Auto Play screenshot controls and map circle plans, not that full editor. No linked third-party script was executed.

Successful server placement/progression, current-server transfer strength, curse-adjusted combos and sustained 100% uptime remain unverified. The six-unit double line and Fast Forward remain unimplemented/unavailable. See [the research notes](BUFF_COMBO_RESEARCH.md).
