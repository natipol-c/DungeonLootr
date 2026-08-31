--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     HideNametag
  Path:     game.ReplicatedStorage.CmdrClient.Commands.HideNametag
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:24 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "HideNametag",
    Description = "Hide/show your OWN overhead nameplate for everyone (persists). Whitelist only.",
    Group = "Whitelist",
    Aliases = { "hnt" },
    Args = { {
            Type = "toggleState",
            Name = "Hidden",
            Description = "true to hide your nameplate, false to show it again"
        } }
};