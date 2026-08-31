--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Rolling_Crescent
  Path:     game.ReplicatedStorage.Classes.Shadow Vagrant.Skill_Modules.Rolling_Crescent
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:49 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return require(ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer).markerEmit(script, {
    models = { "Skill2_GroundVar", "Skill2_AirVar" },
    casterPaths = { "HumanoidRootPart/Holder/Torso" }
});