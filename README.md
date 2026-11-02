# MAA

Roblox action macro with the bundled MattLib UI, JSON recordings, and wave-aware playback.

## Run the latest version

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Cybersize/MAA/main/loader.lua"))()
```

The stable loader fetches the current `main.lua` with a timestamp query on every execution. Run the same line again after updates; an already-running session is not updated in the background. GitHub/CDN propagation may take a short time after a push.

## Usage

1. Run the loader and choose a macro name.
2. Use **Record this match now** or arm recording for the next match.
3. Place, upgrade, change priority, sell, and use supported abilities/votes normally.
4. Choose **Stop / save recording**.
5. Load the JSON and choose **Play / sync current match**. Timing defaults to **Adaptive / Catch up / Auto**.

Use a new v2 recording for wave/time synchronization. Legacy files retain their offset timeline. Local recordings remain under the executor's `AA_Macros/` folder and are not uploaded.

See [the usage guide](docs/USAGE.md) for timing sources, repeat playback, diagnostics, and compatibility limits. See [validation](docs/VALIDATION.md) for the 24 core scenarios and five MattLib integration checks. These checks used local engine doubles; live-game/executor compatibility remains unverified.

## Updating

Publish the new tested bundle as `main.lua` on `main`; keep the loader URL unchanged. `version.json` records this bundle's version and SHA-256. `main.lua` is self-contained: MattLib is embedded, so it needs no separate runtime UI download.

The original UI bundle is [Cybersize/MattLib](https://github.com/Cybersize/MattLib), pinned to commit `bb9187fa8be705a5b7225904b0dd737c9f612035`. Its MIT notice is embedded in `main.lua` and included in [third-party notices](THIRD_PARTY_NOTICES.md).
