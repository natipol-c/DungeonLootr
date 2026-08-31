--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     EquipClassWeapon
  Path:     game.ReplicatedStorage.CmdrClient.Commands.EquipClassWeapon
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "equipClassWeapon",
    Description = "Equip a player\'s most recently converted ClassWeapon (overrides their active class slot, carrying its mutation)",
    Group = "Admin",
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player whose latest ClassWeapon to equip"
        } }
};