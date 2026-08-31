--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     attributes
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.mod.attributes
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local u1 = require("./logger");
local u2 = RunService:IsServer();
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = 0;
local u18 = {
    cache = function(p7: userdata) -- Line: 34, Name: cache
        -- upvalues: u1 (copy), u6 (ref), u3 (copy)
        local Attribute = p7:GetAttribute("U");

        if Attribute then
            u1.warn((`{p7} is already cached (id={Attribute})`));

            return;
        end;

        local Attributes = p7:GetAttributes();

        if next(Attributes) == nil then
            return;
        end;

        u6 = u6 + 1;
        local v8 = u6;
        local v9 = {};

        for i, v in Attributes do
            if i ~= "U" then
                v9[i] = v;
                p7:SetAttribute(i, nil);
            end;
        end;

        u3[v8] = v9;
        p7:SetAttribute("U", v8);
    end,

    restore = function(p10: userdata) -- Line: 67, Name: restore
        -- upvalues: u3 (copy), u1 (copy)
        local Attribute = p10:GetAttribute("U");
        local v11 = u3[Attribute];

        if not v11 then
            u1.warn((`{p10} with cache id '{Attribute}' doesn't have any cached attributes`));

            return;
        end;

        for i, v in v11 do
            p10:SetAttribute(i, v);
        end;

        p10:SetAttribute("U", nil);
    end,

    get = function(p12: userdata, p13: string, p14: any, p15: boolean?, p16: function?) -- Line: 84, Name: get
        -- upvalues: u3 (copy), u2 (copy)
        local v17 = u3[p12:GetAttribute("U")];

        if v17 then
            v17 = v17[p13];
        end;

        if v17 ~= nil then
            if p16 then
                return p16(v17);
            end;

            if v17 == nil then
                return p14;
            end;

            return v17;
        end;

        local Attribute = p12:GetAttribute(p13);

        if p16 then
            p14 = p16(Attribute);
        elseif Attribute ~= nil then
            p14 = Attribute;
        end;

        if not p15 and u2 then
            p12:SetAttribute(p13, p14);
        end;

        return p14;
    end
};

function u18.getRange(p19: userdata, p20: string, u21, u22, p23: boolean?) -- Line: 109
    -- upvalues: u18 (copy)
    return u18.get(p19, p20, u21, p23, function(p24) -- Line: 110
        -- upvalues: u21 (copy), u22 (copy)
        if typeof(p24) ~= "NumberRange" then
            return u21;
        end;

        if u22 then
            return NumberRange.new(math.clamp(p24.Min, u22.Min, u22.Max), (math.clamp(p24.Max, u22.Min, u22.Max)));
        end;

        return p24;
    end);
end;

function u18.getEnum(p25: userdata, p26: string, u27: any, u28: table, p29: boolean?) -- Line: 127
    -- upvalues: u18 (copy)
    return u18.get(p25, p26, u27, p29, function(p30) -- Line: 128
        -- upvalues: u28 (copy), u27 (copy)
        if p30 == nil or not table.find(u28, p30) then
            return u27;
        end;

        return p30;
    end);
end;

function u18.set(p31: userdata, p32: string, p33: any) -- Line: 137
    -- upvalues: u3 (copy)
    local v34 = u3[p31:GetAttribute("U")];

    if v34 then
        v34[p32] = p33;

        return;
    end;

    p31:SetAttribute(p32, p33);
end;

function u18.isCached(p35: userdata) -- Line: 149
    return p35:GetAttribute("U") ~= nil;
end;

function u18.getState(p36: userdata, p37: string, p38: any) -- Line: 153
    -- upvalues: u5 (copy)
    local v39 = u5[p36];

    if v39 then
        v39 = v39[p37];
    end;

    if v39 == nil then
        return p38;
    end;

    return v39;
end;

function u18.setState(p40: userdata, p41: string, p42: any) -- Line: 160
    -- upvalues: u5 (copy)
    local v43 = u5[p40];

    if not v43 then
        v43 = {};
        u5[p40] = v43;
    end;

    v43[p41] = p42;
end;

function u18.clearState(p44: userdata) -- Line: 171
    -- upvalues: u5 (copy)
    u5[p44] = nil;
end;

function u18.trigger(p45: userdata, p46: string, p47: any) -- Line: 175
    -- upvalues: u4 (copy)
    local v48 = u4[p45];

    if v48 then
        v48 = v48[p46];
    end;

    if not v48 then
        return;
    end;

    for _, v in v48 do
        v(p47);
    end;
end;

function u18.hook(u49: userdata, u50: string, u51: function) -- Line: 188
    -- upvalues: u4 (copy), u18 (copy)
    local u52 = u4[u49];

    if not u52 then
        u52 = {};
        u4[u49] = u52;
    end;

    local u53 = u52[u50];

    if not u53 then
        u53 = {};
        u52[u50] = u53;
    end;

    table.insert(u53, u51);
    local u54;

    if u18.isCached(u49) then
        u54 = nil;
    else
        u54 = u49:GetAttributeChangedSignal(u50):Connect(function() -- Line: 208
            -- upvalues: u49 (copy), u50 (copy), u51 (copy)
            u51((u49:GetAttribute(u50)));
        end);
    end;

    return function() -- Line: 214
        -- upvalues: u54 (ref), u53 (ref), u51 (copy), u52 (ref), u50 (copy), u4 (ref), u49 (copy)
        if u54 then
            u54:Disconnect();
        end;

        local table_find_ret = table.find(u53, u51);

        if table_find_ret then
            table.remove(u53, table_find_ret);
        end;

        if #u53 == 0 then
            u52[u50] = nil;
        end;

        if next(u52) == nil then
            u4[u49] = nil;
        end;
    end;
end;

return u18;