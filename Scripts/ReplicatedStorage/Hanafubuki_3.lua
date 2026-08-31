--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Hanafubuki
  Path:     game.ReplicatedStorage.Classes.Zero.Skill_Modules.Hanafubuki
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:57 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return require(ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer).markerEmit(script, {
    models = { "Skill2_GroundVar" }
});