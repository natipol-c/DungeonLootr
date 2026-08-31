--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     fetchServer
  Path:     game.ReplicatedStorage.ExternalModules.Cmdr.Server commands.Debug.fetchServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");

return function(p1, p2) -- Line: 3
    -- upvalues: HttpService (copy)
    return HttpService:GetAsync(p2);
end;