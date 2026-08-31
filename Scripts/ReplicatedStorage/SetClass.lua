--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SetClass
  Path:     game.ReplicatedStorage.CmdrClient.Commands.SetClass
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "setClass",
    Description = "Force-set a player\'s active class (grants ownership if needed)",
    Group = "Admin",
    Aliases = { "sc" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player whose class will be changed"
        }, {
            Type = "className",
            Name = "ClassName",
            Description = "Class name (autocomplete enabled — e.g. Ronin, Vacio, Cursed Child)"
        } }
};