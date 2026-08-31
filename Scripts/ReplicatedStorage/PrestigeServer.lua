--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PrestigeServer
  Path:     game.ReplicatedStorage.ExternalModules.Cmdr.Server commands.PrestigeServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);

return function(p1, p2) -- Line: 10
    -- upvalues: Knit (copy)
    local Service = Knit.GetService("DataService");
    local Service2 = Knit.GetService("PrestigeService");
    local v3 = Service:Get(p2);

    if not v3 then
        return `Failed: No data found for {p2.Name}`;
    end;

    local ActiveClass = v3.Data.Data.ActiveClass;

    if not ActiveClass or ActiveClass == "" then
        return `Failed: {p2.Name} has no active class`;
    end;

    local v4, v5 = Service2:Prestige(p2, ActiveClass);

    if v4 then
        return `Prestiged {p2.Name}'s {ActiveClass} — now Prestige #{v5.Prestiges}, +{v5.TokensGranted} Skill Tokens ({v5.Tokens} total)`;
    end;

    return `Failed to prestige {p2.Name}'s {ActiveClass}: {tostring(v5)}`;
end;