--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     RemoteProperty
  Path:     game.ReplicatedStorage.Packages._Index.sleitnick_comm@1.0.1.comm.Server.RemoteProperty
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:42 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RemoteSignal = require(script.Parent.RemoteSignal);
require(script.Parent.Parent.Types);
local None = require(script.Parent.Parent.Util).None;
local u1 = {};
u1.__index = u1;

function u1.new(p2: userdata, p3: string, p4: any, p5: any, p6: any) -- Line: 53
    -- upvalues: u1 (copy), RemoteSignal (copy), Players (copy), None (copy)
    local u7 = setmetatable({}, u1);
    u7._rs = RemoteSignal.new(p2, p3, false, p5, p6);
    u7._value = p4;
    u7._perPlayer = {};
    u7._playerRemoving = Players.PlayerRemoving:Connect(function(p8) -- Line: 64
        -- upvalues: u7 (copy)
        u7._perPlayer[p8] = nil;
    end);
    u7._rs:Connect(function(p9) -- Line: 67
        -- upvalues: u7 (copy), None (ref)
        local v10 = u7._perPlayer[p9];

        if v10 == nil then
            v10 = u7._value;
        elseif v10 == None then
            v10 = nil;
        end;

        u7._rs:Fire(p9, v10);
    end);

    return u7;
end;

function u1.Set(p11, p12) -- Line: 91
    p11._value = p12;
    table.clear(p11._perPlayer);
    p11._rs:FireAll(p12);
end;

function u1.SetTop(p13, p14) -- Line: 118
    -- upvalues: Players (copy)
    p13._value = p14;

    for _, v in ipairs(Players:GetPlayers()) do
        if p13._perPlayer[v] == nil then
            p13._rs:Fire(v, p14);
        end;
    end;
end;

function u1.SetFilter(p15: table, p16: function, p17: any) -- Line: 141
    -- upvalues: Players (copy)
    for _, v in ipairs(Players:GetPlayers()) do
        if p16(v, p17) then
            p15:SetFor(v, p17);
        end;
    end;
end;

function u1.SetFor(p18: table, p19: userdata, p20: any) -- Line: 163
    -- upvalues: None (copy)
    if p19.Parent then
        local v21;

        if p20 == nil then
            v21 = None;
        else
            v21 = p20;
        end;

        p18._perPlayer[p19] = v21;
    end;

    p18._rs:Fire(p19, p20);
end;

function u1.SetForList(p22: table, p23: table, p24: any) -- Line: 179
    for _, v in ipairs(p23) do
        p22:SetFor(v, p24);
    end;
end;

function u1.ClearFor(p25: table, p26: userdata) -- Line: 206
    if p25._perPlayer[p26] == nil then
        return;
    end;

    p25._perPlayer[p26] = nil;
    p25._rs:Fire(p26, p25._value);
end;

function u1.ClearForList(p27: table, p28: table) -- Line: 219
    for _, v in ipairs(p28) do
        p27:ClearFor(v);
    end;
end;

function u1.ClearFilter(p29: table, p30: function) -- Line: 229
    -- upvalues: Players (copy)
    for _, v in ipairs(Players:GetPlayers()) do
        if p30(v) then
            p29:ClearFor(v);
        end;
    end;
end;

function u1.Get(p31) -- Line: 247
    return p31._value;
end;

function u1.GetFor(p32: table, p33: userdata) -- Line: 281
    -- upvalues: None (copy)
    local v34 = p32._perPlayer[p33];

    if v34 == nil then
        return p32._value;
    end;

    if v34 == None then
        return nil;
    end;

    return v34;
end;

function u1.Destroy(p35) -- Line: 290
    p35._rs:Destroy();
    p35._playerRemoving:Disconnect();
end;

return u1;