--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Lunar_Eclipse
  Path:     game.ReplicatedStorage.Classes.Awakened Devil EX.Skill_Modules.Lunar_Eclipse
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:53 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return require(ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer).markerEmit(script, {
    models = { "ultimate", "HighlightEmit" },
    ownerOnlyParams = { "ScreenEffect" }
});