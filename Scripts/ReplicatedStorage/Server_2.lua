--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Server
  Path:     game.ReplicatedStorage.Packages._Index.sleitnick_comm@1.0.1.comm.Server
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:42 2026
]]

-- Decompiled with Potassium's decompiler.

local script_RemoteProperty = require(script.RemoteProperty);
local script_RemoteSignal = require(script.RemoteSignal);
require(script.Parent.Types);
local Util = require(script.Parent.Util);
local u13 = {
    BindFunction = function(p1: userdata, p2: string, u3: any, u4: any, u5: any) -- Line: 37, Name: BindFunction
        -- upvalues: Util (copy)
        assert(Util.IsServer, "BindFunction must be called from the server");
        local v6 = Util.GetCommSubFolder(p1, "RF"):Expect("Failed to get Comm RF folder");
        local RemoteFunction = Instance.new("RemoteFunction");
        RemoteFunction.Name = p2;
        local v7;

        if type(u4) == "table" then
            v7 = #u4 > 0;
        else
            v7 = false;
        end;

        local v8;

        if type(u5) == "table" then
            v8 = #u5 > 0;
        else
            v8 = false;
        end;

        local function ProcessOutbound(p9, ...) -- Line: 50
            -- upvalues: u5 (copy)
            local table_pack_ret = table.pack(...);

            for _, v in ipairs(u5) do
                local table_pack_ret2 = table.pack(v(p9, table_pack_ret));

                if not table_pack_ret2[1] then
                    return table.unpack(table_pack_ret2, 2, table_pack_ret2.n);
                end;

                table_pack_ret.n = #table_pack_ret;
            end;

            return table.unpack(table_pack_ret, 1, table_pack_ret.n);
        end;

        if v7 and v8 then
            function RemoteFunction.OnServerInvoke(p10, ...) -- Line: 62
                -- upvalues: u4 (copy), ProcessOutbound (copy), u3 (copy)
                local table_pack_ret = table.pack(...);

                for _, v in ipairs(u4) do
                    local table_pack_ret2 = table.pack(v(p10, table_pack_ret));

                    if not table_pack_ret2[1] then
                        return table.unpack(table_pack_ret2, 2, table_pack_ret2.n);
                    end;

                    table_pack_ret.n = #table_pack_ret;
                end;

                return ProcessOutbound(p10, u3(p10, table.unpack(table_pack_ret, 1, table_pack_ret.n)));
            end;
        elseif v7 then
            function RemoteFunction.OnServerInvoke(p11, ...) -- Line: 75
                -- upvalues: u4 (copy), u3 (copy)
                local table_pack_ret = table.pack(...);

                for _, v in ipairs(u4) do
                    local table_pack_ret2 = table.pack(v(p11, table_pack_ret));

                    if not table_pack_ret2[1] then
                        return table.unpack(table_pack_ret2, 2, table_pack_ret2.n);
                    end;

                    table_pack_ret.n = #table_pack_ret;
                end;

                return u3(p11, table.unpack(table_pack_ret, 1, table_pack_ret.n));
            end;
        elseif v8 then
            function RemoteFunction.OnServerInvoke(p12, ...) -- Line: 88
                -- upvalues: ProcessOutbound (copy), u3 (copy)
                return ProcessOutbound(p12, u3(p12, ...));
            end;
        else
            RemoteFunction.OnServerInvoke = u3;
        end;

        RemoteFunction.Parent = v6;

        return RemoteFunction;
    end
};

function u13.WrapMethod(p14: userdata, u15: table, p16: string, p17: any, p18: any) -- Line: 99
    -- upvalues: Util (copy), u13 (copy)
    assert(Util.IsServer, "WrapMethod must be called from the server");
    local u19 = u15[p16];
    local v20 = type(u19) == "function";
    local v21 = "Value at index " .. p16 .. " must be a function; got " .. type(u19);
    assert(v20, v21);

    return u13.BindFunction(p14, p16, function(...) -- Line: 109
        -- upvalues: u19 (copy), u15 (copy)
        return u19(u15, ...);
    end, p17, p18);
end;

function u13.CreateSignal(p22: userdata, p23: string, p24: boolean?, p25: any, p26: any) -- Line: 114
    -- upvalues: Util (copy), script_RemoteSignal (copy)
    assert(Util.IsServer, "CreateSignal must be called from the server");
    local v27 = Util.GetCommSubFolder(p22, "RE"):Expect("Failed to get Comm RE folder");

    return script_RemoteSignal.new(v27, p23, p24, p25, p26);
end;

function u13.CreateProperty(p28: userdata, p29: string, p30: any, p31: any, p32: any) -- Line: 127
    -- upvalues: Util (copy), script_RemoteProperty (copy)
    assert(Util.IsServer, "CreateProperty must be called from the server");
    local v33 = Util.GetCommSubFolder(p28, "RP"):Expect("Failed to get Comm RP folder");

    return script_RemoteProperty.new(v33, p29, p30, p31, p32);
end;

return u13;