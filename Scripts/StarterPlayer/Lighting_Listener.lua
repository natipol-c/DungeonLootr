--[[
  Type:     LocalScript
  Method:   cached
  Name:     Lighting_Listener
  Path:     game.StarterPlayer.StarterCharacterScripts.Lighting_Listener
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:20 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local Tagged = CollectionService:GetTagged("Lighting_Change");
local LocalPlayer = Players.LocalPlayer;
local Lighting = game:GetService("Lighting");
local u1 = {};
local u2 = {};
local u3 = nil;
local u4 = {
    Obsidian = {
        Brightness = 6.07,
        ClockTime = 0.6,
        GeographicLatitude = 0,
        EnvironmentSpecularScale = 1,
        Ambient = Color3.fromRGB(108, 100, 140)
    },
    Desert = {
        Brightness = 3.68,
        ClockTime = 7.6,
        GeographicLatitude = 0,
        EnvironmentSpecularScale = 1,
        Ambient = Color3.fromRGB(91, 30, 0)
    },
    Lava = {
        Brightness = 3.68,
        ClockTime = 7.6,
        GeographicLatitude = 0,
        EnvironmentSpecularScale = 1,
        Ambient = Color3.fromRGB(91, 30, 0)
    },
    Taiga = {
        Brightness = 5.81,
        ClockTime = 17.6,
        GeographicLatitude = 0,
        EnvironmentSpecularScale = 1,
        Ambient = Color3.fromRGB(192, 245, 255)
    },
    ["Forest Dungeon"] = {
        Brightness = 0.91,
        ClockTime = 9.2,
        GeographicLatitude = 0,
        EnvironmentSpecularScale = 1,
        Ambient = Color3.fromRGB(157, 105, 0)
    },
    ["Heavenly Dungeon"] = {
        Brightness = 3.64,
        ClockTime = 17.5,
        GeographicLatitude = 101,
        EnvironmentSpecularScale = 0,
        Ambient = Color3.fromRGB(156, 106, 45)
    },
    Default = {
        Brightness = 1.63,
        ClockTime = 14.5,
        GeographicLatitude = 0,
        EnvironmentSpecularScale = 1,
        Ambient = Color3.fromRGB(89, 122, 101),
        ColorShift_Bottom = Color3.fromRGB(0, 0, 0),
        ColorShift_Top = Color3.fromRGB(0, 0, 0),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    },
    Akaza = {
        Brightness = 2.48,
        ClockTime = 14.6,
        GeographicLatitude = 0,
        EnvironmentSpecularScale = 1,
        Ambient = Color3.fromRGB(44, 88, 76)
    },
    Sukuna = {
        Brightness = 2.48,
        ClockTime = 14.6,
        GeographicLatitude = 0,
        EnvironmentSpecularScale = 1,
        Ambient = Color3.fromRGB(85, 0, 0),
        ColorShift_Bottom = Color3.fromRGB(170, 85, 0),
        ColorShift_Top = Color3.fromRGB(255, 85, 0),
        OutdoorAmbient = Color3.fromRGB(61, 0, 0)
    },
    Halloween = {
        Brightness = 2.18,
        ClockTime = 9.4,
        GeographicLatitude = 0,
        EnvironmentSpecularScale = 1,
        ExposureCompensation = 1.15,
        Ambient = Color3.fromRGB(44, 88, 76),
        ColorShift_Bottom = Color3.fromRGB(255, 253, 190),
        ColorShift_Top = Color3.fromRGB(178, 147, 255),
        OutdoorAmbient = Color3.fromRGB(70, 43, 33)
    }
};

local function applyRegionByName(p5: string) -- Line: 104
    -- upvalues: u4 (copy), Lighting (copy)
    for i, v in pairs(u4[p5] or u4.Default) do
        Lighting[i] = v;
    end;
end;

local SkyboxFolder = game.Lighting.SkyboxFolder;

local function ApplySkybox(p6: string) -- Line: 113
    -- upvalues: SkyboxFolder (copy)
    if SkyboxFolder:FindFirstChild(p6) then
        local v7 = SkyboxFolder:FindFirstChild(p6);
        game.Lighting:FindFirstChildOfClass("Sky").Parent = SkyboxFolder;
        v7.Parent = game.Lighting;
    end;

    if p6 == "NightSky" then
        game.Lighting.Atmosphere.Offset = 0.124;
        game.Lighting.Atmosphere.Glare = 5.62;

        return;
    end;

    game.Lighting.Atmosphere.Offset = 1;
    game.Lighting.Atmosphere.Glare = 0;
end;

local function SetupBox(u8: userdata) -- Line: 135
    -- upvalues: u1 (copy), u2 (copy), LocalPlayer (copy), u4 (copy), Lighting (copy), ApplySkybox (copy), SkyboxFolder (copy), u3 (ref)
    if u8:GetAttribute("Setup") then
        return;
    end;

    u8:SetAttribute("Setup", true);
    u1[u8] = u1[u8] or {};
    u2[u8] = u2[u8] or 0;
    u8.Touched:Connect(function(p9: userdata) -- Line: 142
        -- upvalues: LocalPlayer (ref), u1 (ref), u8 (copy), u2 (ref), u4 (ref), Lighting (ref), ApplySkybox (ref), SkyboxFolder (ref), u3 (ref)
        if game.ReplicatedStorage:GetAttribute("Fireworks") then
            return;
        end;

        local Character = LocalPlayer.Character;

        if not (Character and p9:IsDescendantOf(Character)) then
            return;
        end;

        local v10 = u1[u8];

        if v10[p9] then
            return;
        end;

        v10[p9] = true;
        local v11 = u2;
        local v12 = u8;
        v11[v12] = v11[v12] + 1;

        if u2[u8] == 1 then
            local Attribute = u8:GetAttribute("Region");

            if Attribute and u4[Attribute] then
                for i, v in pairs(u4[Attribute] or u4.Default) do
                    Lighting[i] = v;
                end;

                if u8:GetAttribute("Skybox") and u8:GetAttribute("Skybox") ~= "" then
                    ApplySkybox(u8:GetAttribute("Skybox"));
                else
                    if SkyboxFolder:FindFirstChild("DefaultSky") then
                        local DefaultSky = SkyboxFolder:FindFirstChild("DefaultSky");
                        game.Lighting:FindFirstChildOfClass("Sky").Parent = SkyboxFolder;
                        DefaultSky.Parent = game.Lighting;
                    end;

                    game.Lighting.Atmosphere.Offset = 1;
                    game.Lighting.Atmosphere.Glare = 0;
                end;

                u3 = u8;
            end;
        end;
    end);
    u8.TouchEnded:Connect(function(p13: userdata) -- Line: 167
        -- upvalues: LocalPlayer (ref), u1 (ref), u8 (copy), u2 (ref), u3 (ref), u4 (ref), Lighting (ref)
        if game.ReplicatedStorage:GetAttribute("Fireworks") then
            return;
        end;

        local Character = LocalPlayer.Character;

        if not (Character and (p13 and p13:IsDescendantOf(Character))) then
            return;
        end;

        local v14 = u1[u8];

        if not v14[p13] then
            return;
        end;

        v14[p13] = nil;
        u2[u8] = math.max(0, (u2[u8] or 0) - 1);

        if u2[u8] == 0 and u3 == u8 then
            for i, v in pairs(u4.Default or u4.Default) do
                Lighting[i] = v;
            end;

            u3 = nil;
        end;
    end);
end;

for _, v in pairs(Tagged) do
    SetupBox(v);
end;

CollectionService:GetInstanceAddedSignal("Lighting_Change"):Connect(SetupBox);