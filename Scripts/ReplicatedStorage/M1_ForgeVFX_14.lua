--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     M1_ForgeVFX
  Path:     game.ReplicatedStorage.Classes.Hollow.Skill_Modules.M1_ForgeVFX
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:01 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require(ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer).markerEmit(script, {
    models = { "M1S" },
    offset = CFrame.new(0, 0, -4)
});
v1.Hit = v1.Emit;

return v1;