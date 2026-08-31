--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Prestige
  Path:     game.ReplicatedStorage.CmdrClient.Commands.Prestige
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "prestige",
    Description = "Prestige a player\'s active class (must be class-level 50)",
    Group = "Admin",
    Aliases = { "prest" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player whose active class to prestige"
        } }
};