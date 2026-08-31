--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     RemoteSignal
  Path:     game.ReplicatedStorage.Packages._Index.sleitnick_comm@1.0.1.comm.Server.RemoteSignal
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:42 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Signal = require(script.Parent.Parent.Parent.Signal);
require(script.Parent.Parent.Types);
local u1 = {};
u1.__index = u1;

function u1.new(p2: userdata, p3: string, p4: boolean?, u5: any, p6: any) -- Line: 27
    -- upvalues: u1 (copy), Signal (copy)
    local u7 = setmetatable({}, u1);
    local v8;

    if p4 == true then
        v8 = Instance.new("UnreliableRemoteEvent");
    else
        v8 = Instance.new("RemoteEvent");
    end;

    u7._re = v8;
    u7._re.Name = p3;
    u7._re.Parent = p2;

    if p6 and #p6 > 0 then
        u7._hasOutbound = true;
        u7._outbound = p6;
    else
        u7._hasOutbound = false;
    end;

    if not u5 or #u5 <= 0 then
        u7._directConnect = true;

        return u7;
    end;

    u7._directConnect = false;
    u7._signal = Signal.new();
    u7._re.OnServerEvent:Connect(function(p9, ...) -- Line: 47
        -- upvalues: u5 (copy), u7 (copy)
        local table_pack_ret = table.pack(...);

        for _, v in u5 do
            if not table.pack(v(p9, table_pack_ret))[1] then
                return;
            end;

            table_pack_ret.n = #table_pack_ret;
        end;

        u7._signal:Fire(p9, table.unpack(table_pack_ret, 1, table_pack_ret.n));
    end);

    return u7;
end;

function u1.IsUnreliable(p10) -- Line: 69
    return p10._re:IsA("UnreliableRemoteEvent");
end;

function u1.Connect(p11, p12) -- Line: 80
    if p11._directConnect then
        return p11._re.OnServerEvent:Connect(p12);
    end;

    return p11._signal:Connect(p12);
end;

function u1._processOutboundMiddleware(p13: table, p14: userdata?, ...) -- Line: 88
    if not p13._hasOutbound then
        return ...;
    end;

    local table_pack_ret = table.pack(...);

    for _, v in p13._outbound do
        local table_pack_ret2 = table.pack(v(p14, table_pack_ret));

        if not table_pack_ret2[1] then
            return table.unpack(table_pack_ret2, 2, table_pack_ret2.n);
        end;

        table_pack_ret.n = #table_pack_ret;
    end;

    return table.unpack(table_pack_ret, 1, table_pack_ret.n);
end;

function u1.Fire(p15: table, p16: userdata, ...) -- Line: 113
    p15._re:FireClient(p16, p15:_processOutboundMiddleware(p16, ...));
end;

function u1.FireAll(p17, ...) -- Line: 126
    p17._re:FireAllClients(p17:_processOutboundMiddleware(nil, ...));
end;

function u1.FireExcept(p18: table, u19: userdata, ...) -- Line: 141
    p18:FireFilter(function(p20) -- Line: 142
        -- upvalues: u19 (copy)
        return p20 ~= u19;
    end, ...);
end;

function u1.FireFilter(p21: table, p22: function, ...) -- Line: 171
    -- upvalues: Players (copy)
    for _, v in Players:GetPlayers() do
        if p22(v, ...) then
            p21._re:FireClient(v, p21:_processOutboundMiddleware(nil, ...));
        end;
    end;
end;

function u1.FireFor(p23: table, p24: table, ...) -- Line: 195
    for _, v in p24 do
        p23._re:FireClient(v, p23:_processOutboundMiddleware(nil, ...));
    end;
end;

function u1.Destroy(p25) -- Line: 204
    p25._re:Destroy();

    if p25._signal then
        p25._signal:Destroy();
    end;
end;

return u1;