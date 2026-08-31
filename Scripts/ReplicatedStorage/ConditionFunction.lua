--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ConditionFunction
  Path:     game.ReplicatedStorage.CmdrClient.Types.ConditionFunction
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:24 2026
]]

-- Decompiled with Potassium's decompiler.

return function(p1) -- Line: 1
    p1:RegisterType("conditionFunction", p1.Cmdr.Util.MakeEnumType("ConditionFunction", { "startsWith" }));
end;