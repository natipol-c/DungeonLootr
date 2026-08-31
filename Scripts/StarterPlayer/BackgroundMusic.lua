--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BackgroundMusic
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.BackgroundMusic
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local DungeonData = require(ReplicatedStorage.GameInfo.DungeonData);
local RaidData = require(ReplicatedStorage.GameInfo.RaidData);
local LocalPlayer = Players.LocalPlayer;
local v1 = {};
local TweenInfo_new_ret = TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
local u2 = nil;
local u3 = 0;
local u4 = {};

local function CollectSounds(p5: userdata?) -- Line: 56
    -- upvalues: SoundService (copy)
    if not p5 then
        return {};
    end;

    local Background = SoundService:FindFirstChild("Background");
    local v6 = {};

    for _, child in p5:GetChildren() do
        if child:IsA("Sound") then
            if Background then
                child.SoundGroup = Background;
            end;

            table.insert(v6, child);
        end;
    end;

    return v6;
end;

local function GetPlaylist(p7: string?) -- Line: 73
    -- upvalues: SoundService (copy), CollectSounds (copy), DungeonData (copy), RaidData (copy), u4 (copy)
    local Background = SoundService:FindFirstChild("Background");

    if not Background then
        return {};
    end;

    if p7 == nil then
        local v8 = CollectSounds((Background:FindFirstChild("Lobby")));

        if #v8 > 0 then
            return v8;
        end;

        return CollectSounds(Background);
    end;

    local v9 = (DungeonData.IsChallengeMode(p7) or RaidData.GetRaid(p7)) and "BossRush" or p7;
    local Dungeons = Background:FindFirstChild("Dungeons");

    if not Dungeons then
        if not u4.__Dungeons then
            warn("[BackgroundMusic] SoundService.Background.Dungeons folder missing");
            u4.__Dungeons = true;
        end;

        return {};
    end;

    local v10 = CollectSounds((Dungeons:FindFirstChild(v9)));

    if #v10 > 0 then
        return v10;
    end;

    local v11 = CollectSounds((Dungeons:FindFirstChild("Default")));

    if #v11 > 0 then
        return v11;
    end;

    local v12 = CollectSounds((Background:FindFirstChild("Default")));

    if #v12 > 0 then
        return v12;
    end;

    if not u4[v9] then
        warn((`[BackgroundMusic] No tracks for "{v9}", no Dungeons.Default, and no Background.Default — silent`));
        u4[v9] = true;
    end;

    return {};
end;

local function FadeOutAndStop(u13: userdata) -- Line: 125
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy), u2 (ref)
    TweenService:Create(u13, TweenInfo_new_ret, {
        Volume = 0
    }):Play();
    task.delay(1.55, function() -- Line: 128
        -- upvalues: u2 (ref), u13 (copy)
        if u2 ~= u13 then
            u13:Stop();
        end;
    end);
end;

local function FadeInAndPlay(p14: userdata) -- Line: 137
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
    if not p14.IsPlaying then
        p14.Volume = 0;
        p14:Play();
    end;

    TweenService:Create(p14, TweenInfo_new_ret, {
        Volume = 1
    }):Play();
end;

local function CrossfadeTo(p15: userdata?) -- Line: 146
    -- upvalues: u2 (ref), FadeOutAndStop (copy), FadeInAndPlay (copy)
    local v16 = u2;
    u2 = p15;

    if v16 and v16 ~= p15 then
        FadeOutAndStop(v16);
    end;

    if p15 and p15 ~= v16 then
        FadeInAndPlay(p15);
    end;
end;

local function RunPlaylist(p17: table, p18: number) -- Line: 161
    -- upvalues: u2 (ref), FadeOutAndStop (copy), u3 (ref), FadeInAndPlay (copy)
    if #p17 ~= 0 then
        local v19 = 1;

        while u3 == p18 do
            local v20 = p17[v19];
            local v21 = u2;
            u2 = v20;

            if v21 and v21 ~= v20 then
                FadeOutAndStop(v21);
            end;

            if v20 and v20 ~= v21 then
                FadeInAndPlay(v20);
            end;

            local u22 = false;
            local v23 = v20.Ended:Connect(function() -- Line: 173
                -- upvalues: u22 (ref)
                u22 = true;
            end);

            while u3 == p18 and not u22 do
                task.wait(0.25);
            end;

            v23:Disconnect();

            if u3 ~= p18 then
                return;
            end;

            v19 = v19 % #p17 + 1;
        end;

        return;
    end;

    local v24 = u2;
    u2 = nil;

    if v24 and v24 ~= nil then
        FadeOutAndStop(v24);
    end;
end;

local function SwitchPlaylist(p25: string?) -- Line: 188
    -- upvalues: u3 (ref), GetPlaylist (copy), RunPlaylist (copy)
    u3 = u3 + 1;
    local v26 = GetPlaylist(p25);
    task.spawn(RunPlaylist, v26, u3);
end;

local function ApplyMusicVolume(p27: number, p28: userdata?) -- Line: 199
    -- upvalues: SoundService (copy)
    local Background = SoundService:FindFirstChild("Background");

    if Background then
        Background.Volume = math.clamp(p27, 0, 100) / 100;
    end;

    if p28 then
        p28.Image = p27 <= 0 and "rbxassetid://14767575422" or "rbxassetid://8625422354";
    end;
end;

function v1._Init(p29) -- Line: 212
    -- upvalues: Knit (copy), SoundService (copy), LocalPlayer (copy), u3 (ref), GetPlaylist (copy), RunPlaylist (copy)
    local BackgroundMusic = p29.HUD.BottomRight:FindFirstChild("BackgroundMusic");
    local Service = Knit.GetService("SettingsService");
    local u30 = nil;
    pcall(function() -- Line: 220
        -- upvalues: u30 (ref), Knit (ref)
        u30 = Knit.GetController("SettingsController");
    end);
    local v31, v32 = Service:GetSettings():await();
    local u33 = (not v31 or (not v32 or type(v32.MusicVolume) ~= "number")) and 50 or v32.MusicVolume;
    local v34 = u33;
    local Background = SoundService:FindFirstChild("Background");

    if Background then
        Background.Volume = math.clamp(v34, 0, 100) / 100;
    end;

    if BackgroundMusic then
        BackgroundMusic.Image = v34 <= 0 and "rbxassetid://14767575422" or "rbxassetid://8625422354";
    end;

    if BackgroundMusic then
        BackgroundMusic.MouseButton1Click:Connect(function() -- Line: 241
            -- upvalues: u30 (ref), u33 (ref), Service (copy)
            Service:SetSetting("MusicVolume", (u30 and u30:GetVolume("MusicVolume") or u33) > 0 and 0 or 50);
        end);
    end;

    Service.SettingChanged:Connect(function(p35, p36) -- Line: 248
        -- upvalues: BackgroundMusic (copy), SoundService (ref)
        if p35 == "MusicVolume" then
            local v37 = BackgroundMusic;
            local Background2 = SoundService:FindFirstChild("Background");

            if Background2 then
                Background2.Volume = math.clamp(p36, 0, 100) / 100;
            end;

            if v37 then
                v37.Image = p36 <= 0 and "rbxassetid://14767575422" or "rbxassetid://8625422354";
            end;
        end;
    end);
    local Attribute = LocalPlayer:GetAttribute("CurrentDungeon");
    u3 = u3 + 1;
    local v38 = GetPlaylist(Attribute);
    task.spawn(RunPlaylist, v38, u3);
    LocalPlayer:GetAttributeChangedSignal("CurrentDungeon"):Connect(function() -- Line: 257
        -- upvalues: LocalPlayer (ref), u3 (ref), GetPlaylist (ref), RunPlaylist (ref)
        local Attribute2 = LocalPlayer:GetAttribute("CurrentDungeon");
        u3 = u3 + 1;
        local v39 = GetPlaylist(Attribute2);
        task.spawn(RunPlaylist, v39, u3);
    end);
end;

return v1;