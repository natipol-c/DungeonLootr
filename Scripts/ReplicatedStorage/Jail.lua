--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Jail
  Path:     game.ReplicatedStorage.CmdrClient.Commands.Jail
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Jail",
    Description = "Trap a player in a jail cell",
    Group = "Admin",
    Aliases = { "j" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The Player to jail"
        } }
};