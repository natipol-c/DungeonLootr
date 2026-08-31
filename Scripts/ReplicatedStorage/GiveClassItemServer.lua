--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GiveClassItemServer
  Path:     game.ReplicatedStorage.ExternalModules.Cmdr.Server commands.GiveClassItemServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);

return function(p1, p2, p3) -- Line: 8
    -- upvalues: Knit (copy)
    local v4, v5 = Knit.GetService("ClassItemService"):GrantClassItem(p2, p3);

    if v4 then
        return `Granted class item "{p3}" to {p2.Name}`;
    end;

    return `Failed: {v5 or "Unknown error"}`;
end;