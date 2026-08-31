--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GlobalEventServer
  Path:     game.ReplicatedStorage.ExternalModules.Cmdr.Server commands.GlobalEventServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local Knit = require(game.ReplicatedStorage.Packages.Knit);

return function(p1: any, p2: string, p3: string, p4: number, p5: number) -- Line: 3
    -- upvalues: Knit (copy)
    local Service = Knit.GetService("GlobalEventService");

    if p2 ~= "MutationBuff" then
        return `[GlobalEvent] Unknown event type: {p2}`;
    end;

    local v6, v7 = Service:StartEvent("MutationBuff", {
        MutationName = p3,
        BoostPercent = p4
    }, p5);

    if not v6 then
        return `[GlobalEvent] Failed: {v7}`;
    end;

    local v8 = `[GlobalEvent] MutationBuff started: {p3} +{p4}% for {p5}s`;

    if v7 then
        v8 = v8 .. ` (Warning: {v7})`;
    end;

    return v8;
end;