--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Flash_Step
  Path:     game.ReplicatedStorage.Classes.Vacio.Skill_Modules.Flash_Step
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:48 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return require(ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer).markerEmit(script, {
    models = { "Skill1", "HighlightEmit" }
});