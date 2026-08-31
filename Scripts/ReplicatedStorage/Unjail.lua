--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Unjail
  Path:     game.ReplicatedStorage.CmdrClient.Commands.Unjail
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Unjail",
    Description = "Release a player from jail",
    Group = "Admin",
    Aliases = { "uj" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The Player to release from jail"
        } }
};