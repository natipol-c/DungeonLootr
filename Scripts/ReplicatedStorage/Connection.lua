--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Connection
  Path:     game.ReplicatedStorage.Globals.Modules.Signal.Connection
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2: any, p3: function, ...) -- Line: 5
    -- upvalues: u1 (copy)
    local v4 = setmetatable({}, u1);
    v4.Connected = true;
    v4.BoundArguments = { ... };
    v4.Signal = p2;
    v4.Callback = p3;
    v4.Index = #v4.Signal.Connections + 1;
    v4.Signal.Connections[v4.Index] = v4;

    return v4;
end;

function u1.Disconnect(p5) -- Line: 20
    p5.Connected = false;
    p5.Signal.Pool:SetCount(p5.Signal.Pool.Count - 1);
    local Connections = p5.Signal.Connections;
    local v6 = Connections[#Connections];
    Connections[p5.Index] = v6;

    if v6 then
        v6.Index = p5.Index;
    end;

    Connections[#Connections] = nil;
    task.defer(table.clear, p5);
end;

function u1.Pause(p7) -- Line: 32
    if not p7.Connected then
        return;
    end;

    p7.Connected = false;
end;

function u1.Resume(p8) -- Line: 38
    if p8.Connected then
        return;
    end;

    p8.Connected = true;
end;

function u1.UpdateBoundArgument(p9: table, p10: number, p11: any) -- Line: 44
    if p10 < 1 or #p9.BoundArguments < p10 then
        return;
    end;

    p9.BoundArguments[p10] = p11;
end;

return u1;