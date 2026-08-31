--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Sky_Crash_Air
  Path:     game.ReplicatedStorage.Classes.Awakened Devil EX.Skill_Modules.Sky_Crash_Air
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:53 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return require(ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer).markerEmit(script, {
    models = { "skill3_air", "HighlightEmit" }
});