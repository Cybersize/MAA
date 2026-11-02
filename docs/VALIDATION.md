MAA 2.1 validation

The bundle compiles with official Luau 0.745. Its embedded MattLib 1.2.1 source remains pinned to `bb9187fa8be705a5b7225904b0dd737c9f612035`, with its license and hash in the file header.

41 core scenarios passed in deterministic Lua engine doubles: the prior 24 recording/timing/catch-up/replay regressions, updated for in-memory playback reports, and 17 new checks:

1. Record/save/play normally creates only the main JSON.
2. Wave rules share that JSON and round-trip with actions intact.
3. Standalone rule profiles save without a recording.
4. Helper cleanup preserves the valid main, explicit diagnostics, and orphan recovery copies.
5. A recoverable save failure restores prior contents without sidecar files.
6. Auto-upgrade waits for its start wave and reaches all owned targets while skipping another player's unit.
7. The stop wave ends upgrading.
8. Max mode stops retrying when the game reports the maximum.
9. Insufficient funds uses bounded retries and later succeeds.
10. Auto-sell is inclusive, handles late enabling, and sells later owned placements.
11. Selling takes priority over upgrading.
12. Pause and Stop everything prevent subsequent automatic requests.
13. An unconfirmed upgrade does not block a later sale.
14. Automatic upgrade requests are captured while recording.
15. Wave upgrades replace matching recorded upgrades without duplicate calls.
16. Auto-sell skips future unit actions/placements without breaking playback.
17. Invalid rule settings are rejected before replacing loaded settings.

Six integration checks passed with the actual MattLib bundle under official Luau: four-tab mounting, wave-rule control callbacks, Record button activation, input preservation across all designs, UI replacement on re-execution, and shutdown/resource cleanup.

These checks establish behavior only in the stated local doubles. No live-game RPCs were executed. They do not establish executor compatibility, real timer semantics, actual server acceptance, physical UI input behavior, or native visual appearance.
