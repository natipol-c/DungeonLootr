--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     kill
  Path:     game.ReplicatedStorage.CmdrClient.Commands.kill
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:21 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "kill",
    Description = "Kills a player or set of players.",
    Group = "Admin",
    Aliases = { "slay" },
    Args = { {
            Type = "players",
            Name = "victims",
            Description = "The players to kill."
        } }
};