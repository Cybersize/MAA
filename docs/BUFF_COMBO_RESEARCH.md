# Buff combo research

Research date: 2026-11-03. Connected game: Anime Adventures, place 14229839966, build 637. The client script index covers 1,605 scripts in the current server snapshot.

## Findings from the current client

| Unit | Mechanic confirmed in game data | Automation consequence |
| --- | --- | --- |
| Commander / Erwin | `erwin:buff_units`; +25% physical damage, 30-second duration, 60-second base active cooldown | Distinguish basic buff uptime from a 100% damage-stack relay. |
| Windsong / Wendy | `wendy:buff_units`; +30% magic damage, 30-second duration, 60-second base active cooldown | Its physical/magic category differs from Commander. Keep its combo state separate. |
| Trickster (Release) / evolved Kisuke | `kisuke:buff` unlocks at upgrade 6; active cooldown 120s at upgrade 6, 105s at 7, 90s at 8; range +20% and attack cooldown/SPA -10% for 30 seconds | Range and cooldown toggles share one cast. Read the current cooldown and unlock state. SPA reduction is distinct from active ability cooldown. |
| Idol (Star), currently equipped | Passive global aura for the same player's units; no active ability; damage/upgrade-cost bonuses improve with upgrades | Never send an active-ability request for this passive aura. |

The unit UI reads `AttacksReplicate.get_current_active_attack_cooldown(model, activeId)`, which accounts for queued/using state and both per-unit and global active cooldowns. Actual cast timestamps are replicated through `_stats.last_active_cast`. `_stats.active_attack` identifies the current unlocked ability. Damage-buff display reads `_stats` attributes `_dmg_buff_physical` and `_dmg_buff_magic`.

The current Buffs definitions mark physical/magic damage buffs, range buffs, and attack-cooldown buffs `stack=false`. This supports checking existing effects before casting, but does not reveal the server's entire transfer-strength formula or refresh policy. Those details need live observation.

## Reported combo patterns

1. **Four-unit relay:** stagger the first two support casts, then trigger the third/fourth as particular received buffs expire. Community instructions depend on placement and curse-adjusted timing. A fixed 30-second round robin does not implement this relay.
2. **Five-unit pentagon:** each support unit should cover its two adjacent support units and exclude the two opposite ones. The reported sequence walks around the ring. Coverage and actual readiness must be validated.
3. **Six-unit double line:** two lines of three transfer the buff toward the damage units and alternate their output casts. The ends of each line must not cover one another. This requires a different formation and schedule.

The [Destructoid guide](https://www.destructoid.com/how-to-100-buff-with-erwin-wendy-leafy-anime-adventures/) describes these methods and distinguishes cursed and uncursed setups. It was updated in January 2025, so its numeric delays are historical guidance, not proof of current server timing. A [player explanation](https://www.reddit.com/r/AnimeAdventuresRBLX/comments/1ia5h3m/does_anyone_have_a_formula_to_get_infinite_100/) also emphasizes received-buff expiry and curse-dependent offsets; comments disagree on how ordinary SPA affects ability cooldown. Current replicated state should take precedence.

## Requirements for the implementation

- Separate per-unit and per-family combo state. Commander and Windsong must not consume one another's sequence steps.
- Check ownership, active unlock, queued/using state, per-unit/global cooldown and observed buff expiry.
- Validate the selected formation before running its special sequence. If units are missing, moved or sold, show a setup/waiting state instead of blindly advancing.
- Read actual cast confirmations before advancing. Unconfirmed requests must not be repeatedly sent.
- Prevent generic Damage/Range/Cooldown automation from interrupting a specialized combo or duplicating a recorded ability cast.
- Show **100% stack** only when that amount is observed on the relevant unit statistics. Do not equate full uptime with +100% damage.
- Keep all five toggles off by default and store settings in the existing macro JSON. Do not automatically change curses, traits or equipment. Automatic placement requires the separate Auto Play control to be enabled.

## Supplied 2026 tutorial and v2.7 correction

The [Lenio video](https://www.youtube.com/watch?v=XPMjMMMMkyg) was inspected through its captions and visible frames on November 3. It requires a suitable curse and staged placement: start with two supports, cast the first, place the third and wait four seconds, cast the second, then place the fourth. The remaining casts follow expiry of the received buffs. At the final shown frame some supports display 95% while others display 100%.

This corrects v2.6's assumption that all four supports could be placed before setup. V2.7 rejects that unseeded layout, guides manual staging, and lets Auto Play stage the required births in mutual range. It also suppresses the game's native auto-cast table/attribute on managed supports, because the UnitUpgradeUI client loop could otherwise cast outside MAA's schedule. Unrelated Buffs controls preserve an in-progress sequence.

## Verification boundary

The current client confirms the listed abilities, cooldown fields, upgrade unlocks, buff categories and passive aura. Later read-only checks observed six user-placed Erwins and an approximately 63.27-second active cooldown. MAA did not place or cast a support and did not change inventory/curse settings. A sustained current-server transfer loop has not been demonstrated by MAA.

MAA 2.7 implements basic active-buff upkeep, the corrected staged relay and guarded five-unit ring scheduling. The six-unit double line is not implemented. All 157 local checks pass, including 23 Buffs checks and an integrated placement/cast scenario in the Auto Play suite. The real seven-tab UI and read-only placement planner start without client warnings/errors. Tests use a disclosed transfer simulation and do not prove the current server formula. All Buffs controls default off. Current support-unit stats supply the displayed observed maximum; the UI does not promise team-wide coverage or a sustained 100% loop.
