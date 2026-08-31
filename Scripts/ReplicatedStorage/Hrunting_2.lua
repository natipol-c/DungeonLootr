--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Hrunting
  Path:     game.ReplicatedStorage.Classes.Forge Archon.Skill_Modules.Hrunting
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
    models = { "Skill3", "HighlightEmit" },
    limbAttachments = {
        skill3arrow = "Left Arm",
        skill3beam1 = "Torso"
    },
    externalContainers = { Lighting }
});