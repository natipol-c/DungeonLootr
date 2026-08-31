--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ClientRemoteSignal
  Path:     game.ReplicatedStorage.Packages._Index.sleitnick_comm@1.0.1.comm.Client.ClientRemoteSignal
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:43 2026
]]

-- Decompiled with Potassium's decompiler.

local Signal = require(script.Parent.Parent.Parent.Signal);
require(script.Parent.Parent.Types);
local u1 = {};
u1.__index = u1;

function u1.new(p2: userdata, u3: any, p4: any) -- Line: 24
    -- upvalues: u1 (copy), Signal (copy)
    local u5 = setmetatable({}, u1);
    u5._re = p2;

    if p4 and #p4 > 0 then
        u5._hasOutbound = true;
        u5._outbound = p4;
    else
        u5._hasOutbound = false;
    end;

    if not u3 or #u3 <= 0 then
        u5._directConnect = true;

        return u5;
    end;

    u5._directConnect = false;
    u5._signal = Signal.new();
    u5._reConn = u5._re.OnClientEvent:Connect(function(...) -- Line: 40
        -- upvalues: u3 (copy), u5 (copy)
        local table_pack_ret = table.pack(...);

        for _, v in u3 do
            if not table.pack(v(table_pack_ret))[1] then
                return;
            end;

            table_pack_ret.n = #table_pack_ret;
        end;

        u5._signal:Fire(table.unpack(table_pack_ret, 1, table_pack_ret.n));
    end);

    return u5;
end;

function u1._processOutboundMiddleware(p6, ...) -- Line: 57
    local table_pack_ret = table.pack(...);

    for _, v in p6._outbound do
        local table_pack_ret2 = table.pack(v(table_pack_ret));

        if not table_pack_ret2[1] then
            return table.unpack(table_pack_ret2, 2, table_pack_ret2.n);
        end;

        table_pack_ret.n = #table_pack_ret;
    end;

    return table.unpack(table_pack_ret, 1, table_pack_ret.n);
end;

function u1.Connect(p7: table, p8: function) -- Line: 76
    if p7._directConnect then
        return p7._re.OnClientEvent:Connect(p8);
    end;

    return p7._signal:Connect(p8);
end;

function u1.Fire(p9, ...) -- Line: 92
    if p9._hasOutbound then
        p9._re:FireServer(p9:_processOutboundMiddleware(...));

        return;
    end;

    p9._re:FireServer(...);
end;

function u1.Destroy(p10) -- Line: 103
    if p10._signal then
        p10._signal:Destroy();
    end;
end;

return u1;