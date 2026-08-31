--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     UnjailServer
  Path:     game.ReplicatedStorage.ExternalModules.Cmdr.Server commands.UnjailServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local Store = require(script.Parent.Parent).Registry:GetStore("JailedPlayers");
local Store2 = require(script.Parent.Parent).Registry:GetStore("JailConnections");

return function(p1: any, p2: userdata) -- Line: 9
    -- upvalues: Store (copy), Store2 (copy)
    local v3 = Store[p2.UserId];

    if not v3 then
        return string.format("%s is not jailed", p2.Name);
    end;

    v3:Destroy();
    Store[p2.UserId] = nil;

    if Store2[p2.UserId] then
        for _, v in pairs(Store2[p2.UserId]) do
            v:Disconnect();
        end;

        Store2[p2.UserId] = nil;
    end;

    return string.format("Released %s from jail", p2.Name);
end;