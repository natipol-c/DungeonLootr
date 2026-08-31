--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Twin_Projection
  Path:     game.ReplicatedStorage.Classes.Forge Archon.Skill_Modules.Twin_Projection
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:59 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");

return require(ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer).markerEmit(script, {
    models = { "Skill1", "HighlightEmit" },
    externalContainers = { Lighting }
});