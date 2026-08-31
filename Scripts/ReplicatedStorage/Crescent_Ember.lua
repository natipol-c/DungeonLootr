--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Crescent_Ember
  Path:     game.ReplicatedStorage.Classes.Hollow.Skill_Modules.Crescent_Ember
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:01 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return require(ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer).markerEmit(script, {
    models = { "Skill2" }
});