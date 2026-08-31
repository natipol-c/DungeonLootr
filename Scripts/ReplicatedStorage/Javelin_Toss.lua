--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Javelin_Toss
  Path:     game.ReplicatedStorage.Classes.Vacio.Skill_Modules.Javelin_Toss
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:48 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return require(ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer).markerEmit(script, {
    models = { "Skill4", "HighlightEmit" }
});