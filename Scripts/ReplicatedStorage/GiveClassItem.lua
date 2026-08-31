--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GiveClassItem
  Path:     game.ReplicatedStorage.CmdrClient.Commands.GiveClassItem
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "giveClassItem",
    Description = "Grant a class item to a player (switches their class)",
    Group = "Admin",
    Aliases = { "gci" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player to receive the class item"
        }, {
            Type = "classItem",
            Name = "ClassItem",
            Description = "Class item to grant (autocomplete enabled)"
        } }
};