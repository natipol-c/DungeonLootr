--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SetLevel
  Path:     game.ReplicatedStorage.CmdrClient.Commands.SetLevel
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "setLevel",
    Description = "Set a player\'s Player Level or active-class Mastery Level",
    Group = "Admin",
    Aliases = { "sl" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player whose level to set"
        }, {
            Type = "integer",
            Name = "Level",
            Description = "Target level (1-100 for player, 1-50 for class)"
        }, {
            Type = "levelScope",
            Name = "Scope",
            Description = "Which level to set — player or class (default: player)",
            Default = "player"
        } }
};