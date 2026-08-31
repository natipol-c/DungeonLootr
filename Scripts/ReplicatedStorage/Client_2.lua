--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Client
  Path:     game.ReplicatedStorage.Packages._Index.sleitnick_comm@1.0.1.comm.Client
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:43 2026
]]

-- Decompiled with Potassium's decompiler.

local Util = require(script.Parent.Util);
require(script.Parent.Types);
local Promise = require(script.Parent.Parent.Promise);
local script_ClientRemoteSignal = require(script.ClientRemoteSignal);
local script_ClientRemoteProperty = require(script.ClientRemoteProperty);

return {
    GetFunction = function(p1: userdata, p2: string, p3: boolean, u4: any, u5: any) -- Line: 9, Name: GetFunction
        -- upvalues: Util (copy), Promise (copy)
        assert(not Util.IsServer, "GetFunction must be called from the client");
        local u6 = Util.GetCommSubFolder(p1, "RF"):Expect("Failed to get Comm RF folder"):WaitForChild(p2, Util.WaitForChildTimeout);
        assert(u6 ~= nil, "Failed to find RemoteFunction: " .. p2);
        local v7;

        if type(u4) == "table" then
            v7 = #u4 > 0;
        else
            v7 = false;
        end;

        local u8;

        if type(u5) == "table" then
            u8 = #u5 > 0;
        else
            u8 = false;
        end;

        local function ProcessOutbound(p9) -- Line: 22
            -- upvalues: u5 (copy)
            for _, v in ipairs(u5) do
                local table_pack_ret = table.pack(v(p9));

                if not table_pack_ret[1] then
                    return table.unpack(table_pack_ret, 2, table_pack_ret.n);
                end;

                p9.n = #p9;
            end;

            return table.unpack(p9, 1, p9.n);
        end;

        return v7 and (p3 and function(...) -- Line: 34
            -- upvalues: Promise (ref), u8 (copy), u6 (copy), ProcessOutbound (copy), u4 (copy)
            local table_pack_ret = table.pack(...);

            return Promise.new(function(p10, p11) -- Line: 36
                -- upvalues: u8 (ref), u6 (ref), ProcessOutbound (ref), table_pack_ret (copy), u4 (ref)
                local success, result = pcall(function() -- Line: 37
                    -- upvalues: u8 (ref), u6 (ref), ProcessOutbound (ref), table_pack_ret (ref)
                    if u8 then
                        return table.pack(u6:InvokeServer(ProcessOutbound(table_pack_ret)));
                    end;

                    return table.pack(u6:InvokeServer(table.unpack(table_pack_ret, 1, table_pack_ret.n)));
                end);

                if not success then
                    p11(result);

                    return;
                end;

                for _, v in ipairs(u4) do
                    local table_pack_ret2 = table.pack(v(result));

                    if not table_pack_ret2[1] then
                        return table.unpack(table_pack_ret2, 2, table_pack_ret2.n);
                    end;

                    result.n = #result;
                end;

                p10(table.unpack(result, 1, result.n));
            end);
        end or function(...) -- Line: 59
            -- upvalues: u8 (copy), u6 (copy), ProcessOutbound (copy), u4 (copy)
            local v12;

            if u8 then
                v12 = table.pack(u6:InvokeServer(ProcessOutbound(table.pack(...))));
            else
                v12 = table.pack(u6:InvokeServer(...));
            end;

            for _, v in ipairs(u4) do
                local table_pack_ret = table.pack(v(v12));

                if not table_pack_ret[1] then
                    return table.unpack(table_pack_ret, 2, table_pack_ret.n);
                end;

                v12.n = #v12;
            end;

            return table.unpack(v12, 1, v12.n);
        end) or (p3 and function(...) -- Line: 78
            -- upvalues: Promise (ref), u8 (copy), u6 (copy), ProcessOutbound (copy)
            local table_pack_ret = table.pack(...);

            return Promise.new(function(p13, p14) -- Line: 80
                -- upvalues: u8 (ref), u6 (ref), ProcessOutbound (ref), table_pack_ret (copy)
                local success, result = pcall(function() -- Line: 81
                    -- upvalues: u8 (ref), u6 (ref), ProcessOutbound (ref), table_pack_ret (ref)
                    if u8 then
                        return table.pack(u6:InvokeServer(ProcessOutbound(table_pack_ret)));
                    end;

                    return table.pack(u6:InvokeServer(table.unpack(table_pack_ret, 1, table_pack_ret.n)));
                end);

                if success then
                    p13(table.unpack(result, 1, result.n));

                    return;
                end;

                p14(result);
            end);
        end or (u8 and function(...) -- Line: 97
            -- upvalues: u6 (copy), ProcessOutbound (copy)
            return u6:InvokeServer(ProcessOutbound(table.pack(...)));
        end or function(...) -- Line: 101
            -- upvalues: u6 (copy)
            return u6:InvokeServer(...);
        end));
    end,

    GetSignal = function(p15: userdata, p16: string, p17: any, p18: any) -- Line: 109, Name: GetSignal
        -- upvalues: Util (copy), script_ClientRemoteSignal (copy)
        assert(not Util.IsServer, "GetSignal must be called from the client");
        local v19 = Util.GetCommSubFolder(p15, "RE"):Expect("Failed to get Comm RE folder"):WaitForChild(p16, Util.WaitForChildTimeout);
        assert(v19 ~= nil, "Failed to find RemoteEvent: " .. p16);

        return script_ClientRemoteSignal.new(v19, p17, p18);
    end,

    GetProperty = function(p20: userdata, p21: string, p22: any, p23: any) -- Line: 122, Name: GetProperty
        -- upvalues: Util (copy), script_ClientRemoteProperty (copy)
        assert(not Util.IsServer, "GetProperty must be called from the client");
        local v24 = Util.GetCommSubFolder(p20, "RP"):Expect("Failed to get Comm RP folder"):WaitForChild(p21, Util.WaitForChildTimeout);
        assert(v24 ~= nil, "Failed to find RemoteEvent for RemoteProperty: " .. p21);

        return script_ClientRemoteProperty.new(v24, p22, p23);
    end
};