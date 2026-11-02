-- MAA: fetch the current main branch on every execution.
local url = "https://raw.githubusercontent.com/Cybersize/MAA/main/main.lua?t=" .. tostring(os.time())
local ok, source = pcall(function() return game:HttpGet(url) end)
assert(ok, "MAA: GitHub download failed: " .. tostring(source))
assert(type(source) == "string" and #source > 0, "MAA: GitHub returned an empty script")
local chunk, err = loadstring(source, "@MAA/main.lua")
assert(chunk, "MAA: script compilation failed: " .. tostring(err))
return chunk()
