--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     fetch
  Path:     game.ReplicatedStorage.CmdrClient.Commands.fetch
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:21 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "fetch",
    Description = "Fetch a value from the Internet",
    Group = "DefaultDebug",
    Aliases = {},
    Args = { {
            Type = "url",
            Name = "URL",
            Description = "The URL to fetch."
        } }
};