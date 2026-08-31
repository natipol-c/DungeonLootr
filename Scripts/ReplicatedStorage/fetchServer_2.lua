--[[
  Type:     ModuleScript
  Method:   cached
  Name:     fetchServer
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Debug.fetchServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");

return function(p1, p2) -- Line: 3
    -- upvalues: HttpService (copy)
    return HttpService:GetAsync(p2);
end;