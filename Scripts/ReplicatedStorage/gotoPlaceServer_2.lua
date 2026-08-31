--[[
  Type:     ModuleScript
  Method:   cached
  Name:     gotoPlaceServer
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Admin.gotoPlaceServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

local TeleportService = game:GetService("TeleportService");

return function(p1, p2, p3, p4) -- Line: 3
    -- upvalues: TeleportService (copy)
    local v5 = p2 or { p1.Executor };

    if p3 <= 0 then
        return "Invalid place ID";
    end;

    if p4 == "-" then
        return "Invalid job ID";
    end;

    p1:Reply("Commencing teleport...");

    if p4 then
        for _, v in ipairs(v5) do
            TeleportService:TeleportToPlaceInstance(p3, p4, v);
        end;
    else
        TeleportService:TeleportAsync(p3, v5);
    end;

    return "Teleported.";
end;