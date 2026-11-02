MAA 2.4 validation

The bundle compiles with official Luau 0.745. Its embedded MattLib 1.2.1 source remains pinned to `bb9187fa8be705a5b7225904b0dd737c9f612035`, with its license and hash in the file header.

59 core scenarios passed in deterministic Lua engine doubles: the prior 24 recording/timing/catch-up/replay regressions, updated for in-memory playback reports, and 17 new checks:

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

17 integration checks passed with the actual MattLib bundle under official Luau. They cover four-tab mounting; wave-rule callbacks; Auto Replay/delay controls; Record on/off with one-file saving; all four designs; UI replacement; shutdown cleanup; next-match recording cancellation; Play on/off; next-match playback cancellation; conflicting-control disabling; state synchronization after API calls and errors; failed-load rollback; rapid-click deduplication; readiness and automatic repetition; disabled toggles during finalization; and Auto Vote Start control synchronization. The UI checks confirm that Play repeats automatically even with a legacy repeat-off preference, stays enabled after completion, and restarts on the next match without a separate Repeat control.

Together with the 59 existing core scenarios and 16 Auto Vote Start scenarios below, this is 92 passing local checks. Native toggle activation is exercised through MattLib's TextButton Activated signals in its engine double.

These checks establish behavior only in the stated local doubles. No live-game RPCs were executed. They do not establish executor compatibility, real timer semantics, actual server acceptance, physical UI input behavior, or native visual appearance.


18 additional replay scenarios passed:

1. Replay defaults off.
2. Standalone operation needs neither a macro nor a learned request and respects its delay.
3. A sent vote is not spammed while waiting for other players, including after a settings change.
4. Enabling on an already-open result screen starts a fresh countdown.
5. Disabling during countdown cancels voting.
6. Stop everything pauses replay; Resume restarts its countdown.
7. Explicit rejections retry with spacing and a finite attempt limit.
8. A real reset allows a fresh vote for the following match.
9. An early loss cancels future-wave waiting and repeats playback after reset.
10. Macro repetition can be disabled independently of replay voting.
11. Replay settings persist in the single existing profile JSON without a learned request.
12. Voting waits for recording finalization.
13. Replay timeouts do not create duplicate requests.
14. Invalid delay/retry/attempt settings are rejected.
15. Replayed matches receive a start vote when required.
16. Auto-start can be disabled and never starts a lobby.
17. A match that already started receives no extra start vote.
18. Start voting waits for endpoint readiness after reset.

No live server Replay/start votes were sent during these tests. The default Replay request is a compatibility preset; actual server acceptance, other players' votes, and teleport behavior remain live checks.


16 additional Auto Vote Start scenarios passed:

1. The standalone toggle defaults off.
2. It votes before the first match without requiring a macro and preserves zero arguments.
3. Settings changes and toggle cycling do not resend accepted votes.
4. Running matches and result screens receive no automatic start vote.
5. A real match reset allows one fresh vote.
6. Lobby and map/server readiness checks delay voting.
7. Missing endpoints and unavailable flags consume no attempts.
8. Disabling cancels pending votes.
9. Stop everything pauses voting and Resume restores it.
10. Explicit rejections use three-second spacing and three bounded attempts.
11. Unresolved calls are not duplicated after timeout or toggle changes.
12. Request errors stop repeated automatic voting.
13. Settings round-trip in the same JSON, legacy profiles default off, and invalid settings are rejected.
14. Replay and the standalone toggle share one start vote per reset.
15. Recorded start votes prevent duplicate automatic votes.
16. Automatic start votes cause overdue recorded start votes to be skipped.
