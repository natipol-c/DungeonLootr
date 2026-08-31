--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Mirage_Chase
  Path:     game.ReplicatedStorage.Classes.Awakened Devil EX.Skill_Modules.Mirage_Chase
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:52 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return require(ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer).markerEmit(script, {
    models = { "skill1", "HighlightEmit" }
});