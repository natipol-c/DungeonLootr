--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AddStarsServer
  Path:     game.ReplicatedStorage.ExternalModules.Cmdr.Server commands.AddStarsServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local Knit = require(game.ReplicatedStorage.Packages.Knit);

return function(p1: any, p2: userdata, p3: number) -- Line: 2
    -- upvalues: Knit (copy)
    Knit.GetService("DataService"):Increment(p2, { "Stars" }, p3);

    return true;
end;