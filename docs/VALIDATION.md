# MAA 2.6 validation

Official Luau 0.745 compiles the bundle. Real's checker reports zero errors and warnings for both the core and the live wrapper (with the injected STATE declaration supplied to the checker). MattLib 1.2.1 remains pinned to `bb9187fa8be705a5b7225904b0dd737c9f612035`; its license and source hash are embedded.

## Local checks

All 129 checks passed against the final v2.6 core and actual embedded MattLib:

| Suite | Checks | Scope |
| --- | ---: | --- |
| Recording and timing | 24 | Passive hook forwarding, placement CFrames, action confirmation, sold-unit identity, wave/timer direction, late catch-up, cancellation, JSON validation. |
| Wave rules and storage | 17 | Single JSON, restoration after failed writes, helper cleanup, ownership, upgrade/sell windows, retry limits, playback coordination. |
| Replay | 18 | Independent replay, countdown cancellation, deduplication, rejection/error handling, early loss, match resets. |
| Auto Start | 16 | First/subsequent matches, map/endpoint readiness, recorded-vote coordination, bounded retries, Stop and persistence. |
| Match | 16 | Story/tower/portal gating and arguments, result-action precedence, wave skips, unresolved calls, queued teleport restoration. |
| Buffs | 19 | Default-off schema, basic upkeep, shared Kisuke cast, locked/busy/other-owner filtering, formation waits, four-unit expiry/stagger ordering, modified cooldowns, five-unit ring ordering, rejection of one-way opposite coverage, recorded-active deduplication, coordination with unresolved buff requests, family isolation, removed units, confirmation/retry limits, Stop and one-file persistence. |
| MattLib integration | 19 | Six tabs, native Activated callbacks, Record/Play toggles, all four designs, re-execution cleanup, state/error synchronization, Match controls and disabled Fast Forward, Buffs controls and pattern selection. |

The core suites use deterministic Lua engine doubles. UI integration runs the real bundled MattLib under official Luau with mocked Roblox services. Intentional failure cases include missing files, rejected requests and unconfirmed actions; their expected messages are not startup failures.

The Buffs test model simulates a capped multiplicative transfer and refuses to overwrite an existing received buff. This tests scheduler ordering, cancellation and synchronization under that stated model. It is not evidence that the hidden server uses that exact strength formula or produces a 100% live stack. The ring test verifies ordering and spacing; it does not prove full-team coverage.

## Current-client research

The client index covered 1,605 scripts from place 14229839966, build 637. Unit attack data confirms Erwin's 25% physical/30s buff, Wendy's 30% magic/30s buff, and their base 60s active cooldowns. Evolved Kisuke's range/SPA ability unlocks at upgrade 6, with current cooldowns 120/105/90 seconds at upgrades 6/7/8. Idol (Star)'s aura is passive.

The current UI uses `AttacksReplicate.get_current_active_attack_cooldown(model, activeId)` for queued/using state, cooldown and global readiness. It reads `_stats.last_active_cast`, `_buffs` effect state and `_dmg_buff_physical`/`_dmg_buff_magic` attributes. The corresponding active request is `use_active_attack(model)`.

The Match handlers were checked for the game's start/skip/result voting, story, tower, portal and return-to-lobby requests. Portal inventory and host rules follow the client handlers. No matching Fast Forward handler/control was found in bounded endpoint/UI/index searches; its control stays disabled.

## Live evidence and limits

The final MAA 2.6 bundle loaded through Real live-reload with the stable label MAA. It printed the title MAA 2.6, six tabs, mode infinite and level namek_infinite. The client console reported no errors or warnings after startup. Read-only inspection confirmed the Attacks data table and cooldown helper were accessible. All automatic controls stayed off and no owned support units were placed.

No MAA ability, purchase, upgrade, sale, start/skip/result vote, leave or teleport request was sent during these checks. Successful live progression, current-server buff transfer, curse-adjusted combos and sustained 100% uptime remain unverified. Researched layouts are described in [the research notes](BUFF_COMBO_RESEARCH.md); the six-unit double line is not implemented.
