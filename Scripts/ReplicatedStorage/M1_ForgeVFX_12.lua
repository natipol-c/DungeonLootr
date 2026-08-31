--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     M1_ForgeVFX
  Path:     game.ReplicatedStorage.Classes.Forge Archon.Skill_Modules.M1_ForgeVFX
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:59 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return require(ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer).group(script, {
    groupPath = "M1S",
    offset = CFrame.new(0, 0, -4)
});