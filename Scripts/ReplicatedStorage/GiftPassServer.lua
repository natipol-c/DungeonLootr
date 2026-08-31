--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GiftPassServer
  Path:     game.ReplicatedStorage.ExternalModules.Cmdr.Server commands.GiftPassServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local MonetizationFunctions = require(game.ServerScriptService.Management.MonetizationFunctions);

return function(p1, p2, p3, p4) -- Line: 6
    -- upvalues: MonetizationFunctions (copy), Knit (copy)
    local v5 = MonetizationFunctions.ByName[p3];

    if not v5 then
        return `Product "{p3}" has no grant function defined.`;
    end;

    local v6 = 0;

    for i = 1, p4 or 1 do
        local success, result = pcall(v5, p2);
        local v7;

        if success and result ~= false then
            v6 = v6 + 1;
            v7 = i;
        else
            warn((`Failed to grant {p3} to {p2.Name}: {result}`));
            v7 = i;
        end;
    end;

    if v6 > 0 then
        Knit.GetService("NotificationService"):SendMessageToPlr(p2, "PURCHASE_SUCCESS");
    end;

    return `Granted "{p3}" x{v6} to {p2.Name}`;
end;