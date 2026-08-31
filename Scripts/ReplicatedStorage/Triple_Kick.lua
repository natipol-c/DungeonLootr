--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Triple_Kick
  Path:     game.ReplicatedStorage.Classes.Divergent.Skill_Modules.Triple_Kick
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:46 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return require(ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer).markerEmit(script, {
    models = { "skill2", "HighlightEmit" }
});