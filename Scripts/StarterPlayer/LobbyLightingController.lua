--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     LobbyLightingController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.LobbyLightingController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit")).CreateController({
    Name = "LobbyLightingController"
});
local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u2 = false;
local u3 = nil;

local function IsValidLightingProp(u4: string) -- Line: 60
    -- upvalues: Lighting (copy)
    return pcall(function() -- Line: 61
        -- upvalues: Lighting (ref), u4 (copy)
        return Lighting[u4];
    end);
end;

local function ReadConfig(p5: userdata?) -- Line: 67
    -- upvalues: Lighting (copy)
    if not p5 then
        return nil;
    end;

    local Lighting2 = p5:FindFirstChild("Lighting");

    if not (Lighting2 and Lighting2:IsA("Configuration")) then
        return nil;
    end;

    local v6 = {};
    local v7 = false;

    for _, child in Lighting2:GetChildren() do
        if child:IsA("ValueBase") then
            local Name = child.Name;

            if pcall(function() -- Line: 61
                -- upvalues: Lighting (ref), Name (copy)
                return Lighting[Name];
            end) then
                v6[child.Name] = child.Value;
                v7 = true;
            end;
        end;
    end;

    return v7 and v6 and v6 or nil;
end;

local function ApplyProps(p8: table?, p9: boolean?) -- Line: 85
    -- upvalues: u3 (ref), TweenService (copy), Lighting (copy), TweenInfo_new_ret (copy)
    if not p8 then
        return;
    end;

    if u3 then
        u3:Cancel();
        u3 = nil;
    end;

    if not p9 then
        local success, result = pcall(TweenService.Create, TweenService, Lighting, TweenInfo_new_ret, p8);

        if success and result then
            u3 = result;
            result:Play();

            return;
        end;
    end;

    for i, v in p8 do
        pcall(function() -- Line: 103
            -- upvalues: Lighting (ref), i (copy), v (copy)
            Lighting[i] = v;
        end);
    end;
end;

local function SwapSky(p10: userdata?, p11: userdata?) -- Line: 111
    -- upvalues: Lighting (copy)
    local v12 = Lighting:FindFirstChildOfClass("Sky");

    if v12 and p10 then
        v12.Parent = p10;
    end;

    if p11 then
        p11 = p11:FindFirstChildOfClass("Sky");
    end;

    if p11 then
        p11.Parent = Lighting;
    end;
end;

function v1.SetNight(p13: table, p14: boolean, p15: boolean?) -- Line: 127
    -- upvalues: u2 (ref), Lighting (copy), ApplyProps (copy), ReadConfig (copy)
    local v16 = p14 == true;

    if v16 == u2 then
        return;
    end;

    local Default = Lighting:FindFirstChild("Default");
    local Night = Lighting:FindFirstChild("Night");

    if not (Default and Night) then
        warn("[LobbyLightingController] Lighting.Default / Lighting.Night folder missing — cannot swap");

        return;
    end;

    if v16 then
        local v17 = Lighting:FindFirstChildOfClass("Sky");

        if v17 and Default then
            v17.Parent = Default;
        end;

        local v18;

        if Night then
            v18 = Night:FindFirstChildOfClass("Sky");
        else
            v18 = Night;
        end;

        if v18 then
            v18.Parent = Lighting;
        end;

        ApplyProps(ReadConfig(Night), p15);
    else
        local v19 = Lighting:FindFirstChildOfClass("Sky");

        if v19 and Night then
            v19.Parent = Night;
        end;

        local v20;

        if Default then
            v20 = Default:FindFirstChildOfClass("Sky");
        else
            v20 = Default;
        end;

        if v20 then
            v20.Parent = Lighting;
        end;

        ApplyProps(ReadConfig(Default), p15);
    end;

    u2 = v16;
end;

function v1.IsNight(p21) -- Line: 151
    -- upvalues: u2 (ref)
    return u2;
end;

function v1.KnitInit(p22) -- Line: 157
end;

function v1.KnitStart(p23) -- Line: 161
end;

return v1;