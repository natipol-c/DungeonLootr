--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Signal
  Path:     game.ReplicatedStorage.Globals.Modules.Signal
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local script_Connection = require(script.Connection);
local Enums = require(script.Parent.Enums);
local CoroutinePool = require(script.Parent.CoroutinePool);
local u10 = {
    [Enums.SignalType.Default] = function(p1: any, p2: userdata, p3: string, ...) -- Line: 11
        p1:Fire(...);
    end,

    [Enums.SignalType.Property] = function(p4: any, p5: userdata, p6: string, ...) -- Line: 12
        p4:Fire(p5[p6], ...);
    end,

    [Enums.SignalType.Attribute] = function(p7: any, p8: userdata, p9: string, ...) -- Line: 13
        p7:Fire(p8:GetAttribute(p9), ...);
    end
};
local u17 = {
    [Enums.SignalType.Default] = function(p11: userdata, p12: string, ...) -- Line: 18
        return p11[p12];
    end,

    [Enums.SignalType.Property] = function(p13: userdata, p14: string, ...) -- Line: 19
        return p13:GetPropertyChangedSignal(p14);
    end,

    [Enums.SignalType.Attribute] = function(p15: userdata, p16: string, ...) -- Line: 20
        return p15:GetAttributeChangedSignal(p16);
    end
};
local u18 = {};
u18.__index = u18;

local function HandleInvoker(p19: any, p20: table) -- Line: 28
    if not (p20 and next(p20)) then
        p19.Callback(table.unpack(p19.BoundArguments));

        return;
    end;

    table.move(p19.BoundArguments, 1, #p19.BoundArguments, #p20 + 1, p20);
    p19.Callback(table.unpack(p20));
end;

function u18.new() -- Line: 38
    -- upvalues: u18 (copy), CoroutinePool (copy), Enums (copy)
    local v21 = setmetatable({}, u18);
    v21.Connections = {};
    v21.Accessor = nil;
    v21.MainConnection = nil;
    v21.Pool = CoroutinePool.new(1);
    v21.SignalType = Enums.SignalType.Default;

    return v21;
end;

function u18.wrap(p22: userdata) -- Line: 51
    -- upvalues: u18 (copy), CoroutinePool (copy), Enums (copy)
    local u23 = setmetatable({}, u18);
    u23.Connections = {};
    u23.Accessor = nil;
    u23.Pool = CoroutinePool.new(1);
    u23.SignalType = Enums.SignalType.Default;
    u23.MainConnection = p22:Connect(function(...) -- Line: 58
        -- upvalues: u23 (copy)
        u23:Fire(...);
    end);

    return u23;
end;

function u18.fromInstanceAccessor(u24: userdata, u25: string, p26: any) -- Line: 64
    -- upvalues: u18 (copy), CoroutinePool (copy), Enums (copy), u17 (copy), u10 (copy)
    local u27 = setmetatable({}, u18);
    u27.Connections = {};
    u27.Accessor = u25;
    u27.Pool = CoroutinePool.new(1);
    u27.SignalType = p26 or Enums.SignalType.Default;
    u27.MainConnection = u17[u27.SignalType](u24, u25):Connect(function(...) -- Line: 72
        -- upvalues: u10 (ref), u27 (copy), u24 (copy), u25 (copy)
        u10[u27.SignalType](u27, u24, u25, ...);
    end);

    return u27;
end;

function u18.UpdateInstance(u28: table, u29: userdata) -- Line: 80
    -- upvalues: u17 (copy), u10 (copy)
    if not u28.Accessor then
        return;
    end;

    u28.MainConnection:Disconnect();
    u28.MainConnection = u17[u28.SignalType](u29, u28.Accessor):Connect(function(...) -- Line: 84
        -- upvalues: u10 (ref), u28 (copy), u29 (copy)
        u10[u28.SignalType](u28, u29, u28.Accessor, ...);
    end);
end;

function u18.Connect(p30: table, p31: function, ...) -- Line: 90
    -- upvalues: script_Connection (copy)
    local v32 = script_Connection.new(p30, p31, ...);
    p30.Pool:SetCount(p30.Pool.Count + 1);

    return v32;
end;

function u18.Once(p33: table, u34: function, ...) -- Line: 98
    -- upvalues: script_Connection (copy)
    local v35 = p33:Connect(function(...) -- Line: 99
        -- upvalues: script_Connection (ref), u34 (copy)
        if script_Connection.Connected then
            script_Connection:Disconnect();
        end;

        u34(...);
    end, ...);
    p33.Pool:SetCount(p33.Pool.Count + 1);

    return v35;
end;

function u18.Wait(p36) -- Line: 105
    local u37 = nil;
    local coroutine_running_ret = coroutine.running();
    u37 = p36:Connect(function(...) -- Line: 109, Name: WaitCallback
        -- upvalues: u37 (ref), coroutine_running_ret (copy)
        u37:Disconnect();

        if coroutine.status(coroutine_running_ret) == "suspended" then
            task.spawn(coroutine_running_ret, ...);
        end;
    end);

    return coroutine.yield();
end;

function u18.Fire(p38, ...) -- Line: 119
    -- upvalues: HandleInvoker (copy)
    local table_pack_ret = table.pack(...);

    for _, v in p38.Connections do
        if v and v.Connected then
            p38.Pool:Get():Execute(HandleInvoker, v, table_pack_ret);
        end;
    end;
end;

function u18.DisconnectAll(p39) -- Line: 129
    for _, v in p39.Connections do
        v:Disconnect();
    end;

    if p39.MainConnection then
        p39.MainConnection:Disconnect();
    end;

    p39.Pool:Destroy();
    table.clear(p39);
end;

return u18;