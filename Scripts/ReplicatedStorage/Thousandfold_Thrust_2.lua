--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Thousandfold_Thrust
  Path:     game.ReplicatedStorage.Classes.Founder.Skill_Modules.Thousandfold_Thrust
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:44 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");

return require(ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer).markerEmit(script, {
    models = { "Skill2", "HighlightEmit" },
    externalContainers = { Lighting }
});