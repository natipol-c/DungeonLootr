--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ChargeUltimate
  Path:     game.ReplicatedStorage.CmdrClient.Commands.ChargeUltimate
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "chargeUltimate",
    Description = "Instantly fill a player\'s Ultimate meter (only if their current class has an Ultimate)",
    Group = "Admin",
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player whose Ultimate meter will be filled"
        } }
};