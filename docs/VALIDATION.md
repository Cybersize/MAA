AA Macro 2.0 validation

The delivered single-file script compiles with official Luau 0.745. The embedded MattLib 1.2.1 source is pinned to commit `bb9187fa8be705a5b7225904b0dd737c9f612035`; its license and source hash are in the file header.

24 deterministic core scenarios passed with simulated Roblox services, JSON round-trips, asynchronous tasks, remote responses, and model replication:

1. Early execution waits for map readiness.
2. Sold models can move into ReplicatedStorage before their recording queue drains.
3. Deadline timers retain their direction after crossing zero.
4. Passive capture preserves native dispatch and returned tuples without a method setter; serialization happens outside the hook.
5. CFrame rotation, nil arguments, UUIDs, and `flying` priority are preserved.
6. Sold units retain their placement token.
7. Slow startup synchronizes to the live wave timer.
8. Future actions wait for their actual wave.
9. Decreasing timers synchronize in the correct direction.
10. Paused replicated time does not advance actions.
11. Explicitly rejected placements retry with the recorded UUID.
12. Existing matching units and completed upgrades are not duplicated.
13. Units sold in the overdue timeline are not repurchased.
14. Strict mode stops overdue steps before sending.
15. Unavailable mid-wave time waits for a boundary.
16. Late recording stores live wave/time, not injection age.
17. Several upgrades between recording frames retain distinct target levels.
18. Readiness timeouts retain rejection reasons and attempts.
19. Cancellation prevents later retries/actions.
20. Unconfirmed manual placements do not inflate the recorded-action count.
21. JSON rejects unsafe remotes, timestamps, unit order, and filenames.
22. Diagnostics saves clock samples and ownership-field schemas.
23. Learned replay waits for a match reset before repeating.
24. Installing over v1.1 disables its controller without blocking/duplicating placement.

Five integration checks passed in official Luau with the actual MattLib bundle and its limited engine double:

- All controls and three tabs mount.
- The native Record button's Activated event changes the controller.
- All four designs preserve the macro-name input.
- Re-execution replaces the previous UI.
- Shutdown releases managed UI resources and signal listeners.

These checks establish behavior in the stated simulated conditions. They do not establish live executor compatibility, server acceptance, live timer semantics, physical input behavior, or visual rendering quality. No live-game requests were made. Auto clock detection and diagnostics are included because the supplied snapshot did not establish timer direction or preserve the missing wave-service/server implementation.
