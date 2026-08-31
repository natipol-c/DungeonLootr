--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     UnequipClassWeapon
  Path:     game.ReplicatedStorage.CmdrClient.Commands.UnequipClassWeapon
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "unequipClassWeapon",
    Description = "Unequip a player\'s ClassWeapon, reverting to their active class slot",
    Group = "Admin",
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player to unequip (reverts to their active class slot)"
        } }
};