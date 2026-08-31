--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ConvertClass
  Path:     game.ReplicatedStorage.CmdrClient.Commands.ConvertClass
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "convertClass",
    Description = "Convert a player\'s active (currently-equipped) class slot into a tradeable ClassWeapon item, then reset that slot to Ronin",
    Group = "Admin",
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player whose active class slot will be converted"
        } }
};