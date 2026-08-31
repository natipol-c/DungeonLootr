--[[
  Type:     ModuleScript
  Method:   cached
  Name:     Umbral_Rite
  Path:     game.ReplicatedStorage.Classes.Sunless.Skill_Modules.Umbral_Rite
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:00 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return require(ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer).markerEmit(script, {
    models = { "Skill2" }
});