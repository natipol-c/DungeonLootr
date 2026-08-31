--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     EnemyResolver
  Path:     game.ReplicatedStorage.GameInfo.EnemyResolver
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Index = require(ReplicatedStorage.GameInfo.Enemy_Data).Index;

return function(p1: string) -- Line: 15
    -- upvalues: Index (copy)
    return Index[p1];
end;