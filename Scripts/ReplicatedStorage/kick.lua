--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     kick
  Path:     game.ReplicatedStorage.CmdrClient.Commands.kick
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:21 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "kick",
    Description = "Kicks a player or set of players.",
    Group = "Admin",
    Aliases = { "boot" },
    Args = { {
            Type = "players",
            Name = "players",
            Description = "The players to kick."
        } }
};