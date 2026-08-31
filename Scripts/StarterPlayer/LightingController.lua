--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     LightingController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.LightingController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local DungeonData = require(ReplicatedStorage.GameInfo.DungeonData);
local RaidData = require(ReplicatedStorage.GameInfo.RaidData);
local v1 = Knit.CreateController({
    Name = "LightingController"
});
local u2 = {
    Snow = {
        ClockTime = 12.4,
        Brightness = 0.52,
        Ambient = Color3.fromRGB(70, 70, 70),
        OutdoorAmbient = Color3.fromRGB(186, 208, 235)
    },
    Wood = {
        ClockTime = 13,
        Brightness = 2,
        Ambient = Color3.fromRGB(120, 120, 110),
        OutdoorAmbient = Color3.fromRGB(150, 150, 140)
    },
    Catacombs = {
        ClockTime = 12,
        Brightness = 1.4,
        Ambient = Color3.fromRGB(95, 90, 105),
        OutdoorAmbient = Color3.fromRGB(110, 105, 125)
    }
};
local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u3 = { "ClockTime", "Ambient", "Brightness", "ColorShift_Bottom", "ColorShift_Top", "OutdoorAmbient" };
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

local function StashTagged(p7: string, p8: userdata) -- Line: 125
    -- upvalues: Lighting (copy), CollectionService (copy)
    for _, child in Lighting:GetChildren() do
        if CollectionService:HasTag(child, p7) then
            child.Parent = p8;
        end;
    end;
end;

local function UnstashInto(p9: userdata, p10: string) -- Line: 137
    -- upvalues: CollectionService (copy), Lighting (copy)
    for _, child in p9:GetChildren() do
        if child.Name ~= "Lighting" or not child:IsA("Configuration") then
            CollectionService:AddTag(child, p10);
            child.Parent = Lighting;
        end;
    end;
end;

local function IsValidLightingProp(u11: string) -- Line: 148
    -- upvalues: Lighting (copy)
    return pcall(function() -- Line: 149
        -- upvalues: Lighting (ref), u11 (copy)
        return Lighting[u11];
    end);
end;

local function ReadLightingConfig(p12: userdata?) -- Line: 156
    -- upvalues: Lighting (copy)
    if not p12 then
        return nil;
    end;

    local Lighting2 = p12:FindFirstChild("Lighting");

    if not (Lighting2 and Lighting2:IsA("Configuration")) then
        return nil;
    end;

    local v13 = {};
    local v14 = false;

    for _, child in Lighting2:GetChildren() do
        if child:IsA("ValueBase") then
            local Name = child.Name;

            if pcall(function() -- Line: 149
                -- upvalues: Lighting (ref), Name (copy)
                return Lighting[Name];
            end) then
                v13[child.Name] = child.Value;
                v14 = true;
            end;
        end;
    end;

    return v14 and v13 and v13 or nil;
end;

local function ResolvePresetProps(p15: string, p16: userdata?) -- Line: 175
    -- upvalues: ReadLightingConfig (copy), u2 (copy)
    return ReadLightingConfig(p16) or u2[p15];
end;

local function SaveLightingDefaults(p17: table?) -- Line: 182
    -- upvalues: u3 (copy), Lighting (copy)
    local v18 = {};

    for _, v in u3 do
        v18[v] = Lighting[v];
    end;

    if p17 then
        for i in p17 do
            if v18[i] == nil and pcall(function() -- Line: 149
                -- upvalues: Lighting (ref), i (copy)
                return Lighting[i];
            end) then
                v18[i] = Lighting[i];
            end;
        end;
    end;

    return v18;
end;

local function TweenOrSet(p19: table?) -- Line: 200
    -- upvalues: u6 (ref), TweenService (copy), Lighting (copy), TweenInfo_new_ret (copy)
    if not p19 then
        return;
    end;

    if u6 then
        u6:Cancel();
        u6 = nil;
    end;

    local success, result = pcall(TweenService.Create, TweenService, Lighting, TweenInfo_new_ret, p19);

    if not (success and result) then
        for i, v in p19 do
            pcall(function() -- Line: 218
                -- upvalues: Lighting (ref), i (copy), v (copy)
                Lighting[i] = v;
            end);
        end;

        return;
    end;

    u6 = result;
    result:Play();
end;

local function ApplyLightingProperties(p20: table?) -- Line: 223
    -- upvalues: TweenOrSet (copy)
    TweenOrSet(p20);
end;

local function RestoreLightingProperties() -- Line: 228
    -- upvalues: u5 (ref), TweenOrSet (copy)
    if not u5 then
        return;
    end;

    TweenOrSet(u5);
    u5 = nil;
end;

local function ApplyPreset(p21: string) -- Line: 236
    -- upvalues: u4 (ref), Lighting (copy), ReadLightingConfig (copy), u2 (copy), u5 (ref), SaveLightingDefaults (copy), StashTagged (copy), UnstashInto (copy), TweenOrSet (copy)
    if u4 == p21 then
        return;
    end;

    local v22 = Lighting:FindFirstChild(p21);
    local Default = Lighting:FindFirstChild("Default");
    local v23 = ReadLightingConfig(v22) or u2[p21];

    if not u5 then
        u5 = SaveLightingDefaults(v23);
    end;

    if v22 then
        if not Default then
            warn("[LightingController] Lighting.Default folder not found — creating one");
            Default = Instance.new("Folder");
            Default.Name = "Default";
            Default.Parent = Lighting;
        end;

        StashTagged("Default_Lighting", Default);
        UnstashInto(v22, "Active_Preset");
    end;

    TweenOrSet(v23);
    u4 = p21;
end;

local function RestoreDefaults() -- Line: 275
    -- upvalues: u4 (ref), Lighting (copy), CollectionService (copy), u5 (ref), TweenOrSet (copy)
    if not u4 then
        return;
    end;

    local v24 = Lighting:FindFirstChild(u4);
    local Default = Lighting:FindFirstChild("Default");

    if v24 then
        for _, child in Lighting:GetChildren() do
            if CollectionService:HasTag(child, "Active_Preset") then
                CollectionService:RemoveTag(child, "Active_Preset");
                child.Parent = v24;
            end;
        end;
    else
        for _, child in Lighting:GetChildren() do
            if CollectionService:HasTag(child, "Active_Preset") then
                CollectionService:RemoveTag(child, "Active_Preset");
                child:Destroy();
            end;
        end;
    end;

    if Default then
        for _, child in Default:GetChildren() do
            child.Parent = Lighting;
        end;
    end;

    if u5 then
        TweenOrSet(u5);
        u5 = nil;
    end;

    u4 = nil;
end;

function v1.KnitInit(p25) -- Line: 314
end;

local function ResolveCurrentPreset() -- Line: 321
    -- upvalues: LocalPlayer (copy), RaidData (copy), DungeonData (copy)
    local Attribute = LocalPlayer:GetAttribute("CurrentDungeon");

    if not Attribute then
        return nil;
    end;

    if Attribute == "BossRush" then
        local Attribute2 = LocalPlayer:GetAttribute("BossRushLighting");

        if type(Attribute2) ~= "string" or (Attribute2 == "" or not Attribute2) then
            Attribute2 = nil;
        end;

        return Attribute2;
    end;

    local Raid = RaidData.GetRaid(Attribute);

    if Raid then
        return Raid.LightingPreset;
    end;

    local Dungeon = DungeonData.GetDungeon(Attribute);

    return Dungeon and Dungeon.LightingPreset or nil;
end;

function v1.KnitStart(p26) -- Line: 340
    -- upvalues: LocalPlayer (copy), ResolveCurrentPreset (copy), ApplyPreset (copy), RestoreDefaults (copy)
    LocalPlayer:GetAttributeChangedSignal("InDungeon"):Connect(function() -- Line: 342
        -- upvalues: LocalPlayer (ref), ResolveCurrentPreset (ref), ApplyPreset (ref), RestoreDefaults (ref)
        if LocalPlayer:GetAttribute("InDungeon") == true then
            local v27 = ResolveCurrentPreset();

            if v27 then
                ApplyPreset(v27);
            end;
        else
            RestoreDefaults();
        end;
    end);
    local v28 = LocalPlayer:GetAttribute("InDungeon") == true and ResolveCurrentPreset();

    if v28 then
        ApplyPreset(v28);
    end;
end;

return v1;