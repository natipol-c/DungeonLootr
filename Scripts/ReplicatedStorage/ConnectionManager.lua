--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ConnectionManager
  Path:     game.ReplicatedStorage.Globals.Modules.ConnectionManager
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local ErrorEnums = require(script.Parent.ErrorEnums);

function u1.new(p2: string) -- Line: 8
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Name = p2;
    v3.Connections = {};

    return v3;
end;

function u1.AddConnection(p4: table, p5: any, p6: userdata) -- Line: 18
    -- upvalues: ErrorEnums (copy)
    if p4.Connections[p5] then
        ErrorEnums.Connections.AlreadyExists(p5, p4.Name);

        return;
    end;

    p4.Connections[p5] = p6;
end;

function u1.HasConnection(p7, p8) -- Line: 24
    return p7.Connections[p8] ~= nil;
end;

function u1.GetConnection(p9, p10) -- Line: 29
    -- upvalues: ErrorEnums (copy)
    if p9.Connections[p10] then
        return p9.Connections[p10];
    end;

    ErrorEnums.Connections.NotFound(p10, p9.Name);
end;

function u1.ReleaseConnection(p11, p12) -- Line: 35
    -- upvalues: ErrorEnums (copy)
    if not p11.Connections[p12] then
        ErrorEnums.Connections.NotFound(p12, p11.Name);

        return;
    end;

    p11.Connections[p12]:Disconnect();
    p11.Connections[p12] = nil;
end;

function u1.UpdateConnection(p13: table, p14: any, p15: userdata) -- Line: 42
    -- upvalues: ErrorEnums (copy)
    if not p13.Connections[p14] then
        ErrorEnums.Connections.NotFound(p14, p13.Name);

        return;
    end;

    p13.Connections[p14]:Disconnect();
    p13.Connections[p14] = p15;
end;

function u1.ReleaseAll(p16) -- Line: 49
    for _, v in p16.Connections do
        v:Disconnect();
    end;

    table.clear(p16);
end;

return u1;