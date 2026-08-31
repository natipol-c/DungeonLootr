--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ChallengeHUDController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.ChallengeHUDController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local BossHealthBars = require(ReplicatedStorage.ClientTools.BossHealthBars);
local LoadingOverlay = require(ReplicatedStorage.ClientTools.LoadingOverlay);
local DungeonData = require(ReplicatedStorage.GameInfo.DungeonData);
local ChallengeData = require(ReplicatedStorage.GameInfo.ChallengeData);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local LocalPlayer = Players.LocalPlayer;
local TweenInfo_new_ret = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret3 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret4 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 80, 80);
local Color3_fromRGB_ret3 = Color3.fromRGB(120, 255, 120);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = false;
local u19 = false;
local u20 = nil;
local u21 = "Boss";
local u22 = 0;
local u23 = nil;
local u24 = nil;

local function ResolveFeaturedBossName() -- Line: 77
    -- upvalues: u20 (ref), DungeonData (copy), u21 (ref)
    if not u20 then
        return;
    end;

    local Boss = DungeonData.GetBoss(u20);

    if Boss then
        u21 = Boss.Name or Boss.HeroId or "Boss";
    end;
end;

local function SlideChallengeFrame(p25: string) -- Line: 86
    -- upvalues: u9 (ref), TweenService (copy), TweenInfo_new_ret2 (copy)
    if not u9 then
        return;
    end;

    local Attribute = u9:GetAttribute(p25);

    if typeof(Attribute) ~= "UDim2" then
        return;
    end;

    TweenService:Create(u9, TweenInfo_new_ret2, {
        Position = Attribute
    }):Play();
end;

local function StartTimerShake() -- Line: 95
    -- upvalues: u23 (ref), u11 (ref), u24 (ref), RunService (copy)
    if u23 then
        return;
    end;

    if not u11 then
        return;
    end;

    if not u24 then
        u24 = u11.Position;
    end;

    local u26 = u24;
    u23 = RunService.Heartbeat:Connect(function() -- Line: 100
        -- upvalues: u11 (ref), u26 (copy)
        if not (u11 and u11.Parent) then
            return;
        end;

        local math_random_ret = math.random(-1, 1);
        local math_random_ret2 = math.random(-1, 1);
        u11.Position = UDim2.new(u26.X.Scale, u26.X.Offset + math_random_ret, u26.Y.Scale, u26.Y.Offset + math_random_ret2);
    end);
end;

local function StopTimerShake() -- Line: 108
    -- upvalues: u23 (ref), u11 (ref), u24 (ref)
    if u23 then
        u23:Disconnect();
        u23 = nil;
    end;

    if u11 and u24 then
        u11.Position = u24;
    end;
end;

local function SetCanvasVisible(p27: boolean) -- Line: 118
    -- upvalues: u8 (ref), TweenService (copy), TweenInfo_new_ret (copy), u18 (ref)
    if not u8 then
        return;
    end;

    if p27 then
        u8.Visible = true;
        TweenService:Create(u8, TweenInfo_new_ret, {
            GroupTransparency = 0
        }):Play();

        return;
    end;

    local v28 = TweenService:Create(u8, TweenInfo_new_ret, {
        GroupTransparency = 1
    });
    v28.Completed:Once(function() -- Line: 125
        -- upvalues: u18 (ref), u8 (ref)
        if not u18 and u8 then
            u8.Visible = false;
        end;
    end);
    v28:Play();
end;

local function Activate() -- Line: 134
    -- upvalues: u18 (ref), u20 (ref), DungeonData (copy), u21 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u7 (ref), u19 (ref), u12 (ref), u9 (ref), u10 (ref), u11 (ref), u24 (ref), ChallengeData (copy), Color3_fromRGB_ret (copy), u8 (ref), TweenService (copy), TweenInfo_new_ret (copy)
    if u18 then
        return;
    end;

    u18 = true;
    local v29 = u20 and DungeonData.GetBoss(u20);

    if v29 then
        u21 = v29.Name or v29.HeroId or "Boss";
    end;

    if u2 then
        u2.Visible = true;
    end;

    if u3 then
        u3.Visible = true;
    end;

    if u4 then
        u4.Text = "Wave: 0";
    end;

    if u5 then
        u5.Visible = true;
    end;

    if u7 and u20 then
        local Dungeon = DungeonData.GetDungeon(u20);
        u7.Text = Dungeon and Dungeon.DisplayName or "";
    end;

    u19 = false;

    if u12 then
        u12.Visible = false;
    end;

    if u9 then
        local Attribute = u9:GetAttribute("Start");

        if typeof(Attribute) == "UDim2" then
            u9.Position = Attribute;
        end;
    end;

    if u10 then
        u10.Text = "Beginning in...";
    end;

    if u11 then
        if not u24 then
            u24 = u11.Position;
        end;

        u11.Text = ChallengeData.LOADING_TIME .. "s";
        u11.TextColor3 = Color3_fromRGB_ret;
    end;

    if not u8 then
        return;
    end;

    u8.Visible = true;
    TweenService:Create(u8, TweenInfo_new_ret, {
        GroupTransparency = 0
    }):Play();
end;

local function Deactivate() -- Line: 167
    -- upvalues: u18 (ref), u19 (ref), u23 (ref), u11 (ref), u24 (ref), u8 (ref), TweenService (copy), TweenInfo_new_ret (copy), u12 (ref), u3 (ref), u5 (ref)
    if not u18 then
        return;
    end;

    u18 = false;
    u19 = false;

    if u23 then
        u23:Disconnect();
        u23 = nil;
    end;

    if u11 and u24 then
        u11.Position = u24;
    end;

    if u8 then
        local v30 = TweenService:Create(u8, TweenInfo_new_ret, {
            GroupTransparency = 1
        });
        v30.Completed:Once(function() -- Line: 125
            -- upvalues: u18 (ref), u8 (ref)
            if not u18 and u8 then
                u8.Visible = false;
            end;
        end);
        v30:Play();
    end;

    if u12 then
        u12.Visible = false;
    end;

    if u3 then
        u3.Visible = false;
    end;

    if u5 then
        u5.Visible = false;
    end;
end;

local function OnWaveUpdate(p31: number, p32: string) -- Line: 181
    -- upvalues: u4 (ref), u10 (ref)
    if u4 then
        u4.Text = "Wave: " .. p31;
    end;

    if u10 then
        u10.Text = "WAVE " .. p31;
    end;
end;

local function OnMapLoadScreen(p33: string, p34: number?) -- Line: 190
    -- upvalues: LoadingOverlay (copy)
    if p33 == "Begin" then
        LoadingOverlay.Show({
            StatusText = "Loading",
            AnchorHRP = false,
            Skippable = true
        });
        LoadingOverlay.SetStatusSuffix(p34 and " " .. p34 .. "s" or nil);

        return;
    end;

    if p33 == "Tick" then
        LoadingOverlay.SetStatusSuffix(p34 and " " .. p34 .. "s" or nil);

        return;
    end;

    if p33 == "Done" then
        LoadingOverlay.Hide();
    end;
end;

local function OnLoadingUpdate(p35: number) -- Line: 205
    -- upvalues: u23 (ref), u11 (ref), u24 (ref), u10 (ref), Color3_fromRGB_ret (copy)
    if u23 then
        u23:Disconnect();
        u23 = nil;
    end;

    if u11 and u24 then
        u11.Position = u24;
    end;

    if u10 then
        u10.Text = "Beginning in...";
    end;

    if u11 then
        local math_floor_ret = math.floor(p35);
        u11.Text = math.max(0, math_floor_ret) .. "s";
        u11.TextColor3 = Color3_fromRGB_ret;
    end;
end;

local function OnTimerUpdate(p36: number, p37: number) -- Line: 215
    -- upvalues: u22 (ref), u11 (ref), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), u23 (ref), u24 (ref), RunService (copy)
    u22 = p36;

    if not u11 then
        return;
    end;

    local math_floor_ret = math.floor(p36);
    local math_max_ret = math.max(0, math_floor_ret);
    u11.Text = "Time Left: " .. math_max_ret .. "s";
    u11.TextColor3 = math_max_ret <= 15 and Color3_fromRGB_ret2 or Color3_fromRGB_ret;

    if math_max_ret > 10 or math_max_ret <= 0 then
        if u23 then
            u23:Disconnect();
            u23 = nil;
        end;

        if u11 and u24 then
            u11.Position = u24;
        end;

        return;
    end;

    if u23 then
        return;
    end;

    if not u11 then
        return;
    end;

    if not u24 then
        u24 = u11.Position;
    end;

    local u38 = u24;
    u23 = RunService.Heartbeat:Connect(function() -- Line: 100
        -- upvalues: u11 (ref), u38 (copy)
        if not (u11 and u11.Parent) then
            return;
        end;

        local math_random_ret = math.random(-1, 1);
        local math_random_ret2 = math.random(-1, 1);
        u11.Position = UDim2.new(u38.X.Scale, u38.X.Offset + math_random_ret, u38.Y.Scale, u38.Y.Offset + math_random_ret2);
    end);
end;

local function OnTimeGain(p39: number) -- Line: 231
    -- upvalues: u11 (ref), Color3_fromRGB_ret3 (copy), u22 (ref), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), TweenService (copy), TweenInfo_new_ret4 (copy)
    if not u11 then
        return;
    end;

    u11.TextColor3 = Color3_fromRGB_ret3;
    local math_floor_ret = math.floor(u22);
    TweenService:Create(u11, TweenInfo_new_ret4, {
        TextColor3 = math.max(0, math_floor_ret) <= 15 and Color3_fromRGB_ret2 or Color3_fromRGB_ret
    }):Play();
end;

local function OnLivesUpdate(p40: number) -- Line: 239
    -- upvalues: u5 (ref), u6 (ref)
    if u5 then
        u5.Visible = true;
    end;

    if u6 then
        u6.Text = "Lives: " .. p40;
    end;
end;

local function OnBossHealthUpdate(p41: number, p42: number, p43: string?) -- Line: 246
    -- upvalues: u21 (ref), u19 (ref), u12 (ref), u15 (ref), BossHealthBars (copy), SlideChallengeFrame (copy), u16 (ref), SharedUtils (copy), u17 (ref), TweenService (copy), TweenInfo_new_ret3 (copy)
    local v44 = p43 or u21;

    if p41 and p41 > 0 then
        if not u19 then
            u19 = true;

            if u12 then
                u12.Visible = true;
            end;

            if u15 then
                u15.Text = v44;
            end;

            BossHealthBars.Prime(v44, p42);
            SlideChallengeFrame("Hidden");
        end;

        BossHealthBars.Update(p41, p42, v44);

        if u16 then
            u16.Text = SharedUtils.FormatWithCommas((math.floor(p41))) .. " / " .. SharedUtils.FormatWithCommas((math.floor(p42)));
        end;

        local v45 = u17 and BossHealthBars.GetActiveSize();

        if v45 then
            TweenService:Create(u17, TweenInfo_new_ret3, {
                Size = v45
            }):Play();
        end;
    elseif u19 then
        u19 = false;
        SlideChallengeFrame("Start");
        task.delay(1, function() -- Line: 275
            -- upvalues: u19 (ref), u12 (ref)
            if not u19 and u12 then
                u12.Visible = false;
            end;
        end);
    end;
end;

local function OnPhaseChange(p46: string, p47: any) -- Line: 283
    -- upvalues: u20 (ref), DungeonData (copy), u21 (ref), u18 (ref), u19 (ref), u23 (ref), u11 (ref), u24 (ref), u8 (ref), TweenService (copy), TweenInfo_new_ret (copy), u12 (ref), u3 (ref), u5 (ref)
    if typeof(p47) == "table" and p47.LocationId then
        u20 = p47.LocationId;
        local v48 = u20 and DungeonData.GetBoss(u20);

        if v48 then
            u21 = v48.Name or v48.HeroId or "Boss";
        end;
    end;

    if p46 == "Complete" or p46 == "Failed" then
        if not u18 then
            return;
        end;

        u18 = false;
        u19 = false;

        if u23 then
            u23:Disconnect();
            u23 = nil;
        end;

        if u11 and u24 then
            u11.Position = u24;
        end;

        if u8 then
            local v49 = TweenService:Create(u8, TweenInfo_new_ret, {
                GroupTransparency = 1
            });
            v49.Completed:Once(function() -- Line: 125
                -- upvalues: u18 (ref), u8 (ref)
                if not u18 and u8 then
                    u8.Visible = false;
                end;
            end);
            v49:Play();
        end;

        if u12 then
            u12.Visible = false;
        end;

        if u3 then
            u3.Visible = false;
        end;

        if u5 then
            u5.Visible = false;
        end;
    end;
end;

local v50 = Knit.CreateController({
    Name = "ChallengeHUDController"
});

function v50.IsActive(p51) -- Line: 300
    -- upvalues: u18 (ref)
    return u18;
end;

function v50.KnitInit(p52) -- Line: 306
    -- upvalues: Knit (copy), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u17 (ref)
    u2 = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("HUD"):FindFirstChild("Dungeon_Container");

    if not u2 then
        return;
    end;

    local Info = u2:FindFirstChild("Info");

    if Info then
        u3 = Info:FindFirstChild("Wave");
        local v53 = u3 and u3:FindFirstChild("TextLabel");
        u4 = v53;
        u5 = Info:FindFirstChild("Lives_Frame");
        local v54 = u5 and u5:FindFirstChild("Lives_Text");
        u6 = v54;
        u7 = Info:FindFirstChild("Dungeon_Name");
    end;

    u8 = u2:FindFirstChild("Challenge_Canvas");
    local v55 = u8 and u8:FindFirstChild("Frame");
    u9 = v55;

    if u9 then
        u10 = u9:FindFirstChild("Title");
        u11 = u9:FindFirstChild("SubText");
    end;

    u12 = u2:FindFirstChild("Boss_Info");

    if u12 then
        u13 = u12:FindFirstChild("Health_Bar");
        u14 = u12:FindFirstChild("Health_Count");
        u15 = u12:FindFirstChild("Boss_Name");
        u16 = u12:FindFirstChild("Health_Amount");
        local v56 = u13 and u13:FindFirstChild("Trail");
        u17 = v56;
    end;
end;

function v50.KnitStart(p57) -- Line: 337
    -- upvalues: u2 (ref), Knit (copy), u1 (ref), u13 (ref), u14 (ref), BossHealthBars (copy), OnWaveUpdate (copy), OnMapLoadScreen (copy), OnLoadingUpdate (copy), OnTimerUpdate (copy), OnTimeGain (copy), OnLivesUpdate (copy), OnBossHealthUpdate (copy), OnPhaseChange (copy), LocalPlayer (copy), Activate (copy), u18 (ref), u19 (ref), u23 (ref), u11 (ref), u24 (ref), u8 (ref), TweenService (copy), TweenInfo_new_ret (copy), u12 (ref), u3 (ref), u5 (ref)
    if not u2 then
        return;
    end;

    local success, result = pcall(function() -- Line: 341
        -- upvalues: Knit (ref)
        return Knit.GetService("ChallengeRunService");
    end);

    if not (success and result) then
        return;
    end;

    u1 = result;

    if u13 and u14 then
        BossHealthBars.SetRefs(u13, u14);
    end;

    u1.WaveUpdate:Connect(OnWaveUpdate);
    u1.MapLoadScreen:Connect(OnMapLoadScreen);
    u1.LoadingUpdate:Connect(OnLoadingUpdate);
    u1.TimerUpdate:Connect(OnTimerUpdate);
    u1.TimeGain:Connect(OnTimeGain);
    u1.LivesUpdate:Connect(OnLivesUpdate);
    u1.BossHealthUpdate:Connect(OnBossHealthUpdate);
    u1.PhaseChange:Connect(OnPhaseChange);

    local function refresh() -- Line: 364
        -- upvalues: LocalPlayer (ref), Activate (ref), u18 (ref), u19 (ref), u23 (ref), u11 (ref), u24 (ref), u8 (ref), TweenService (ref), TweenInfo_new_ret (ref), u12 (ref), u3 (ref), u5 (ref)
        if LocalPlayer:GetAttribute("InChallenge") then
            Activate();

            return;
        end;

        if not u18 then
            return;
        end;

        u18 = false;
        u19 = false;

        if u23 then
            u23:Disconnect();
            u23 = nil;
        end;

        if u11 and u24 then
            u11.Position = u24;
        end;

        if u8 then
            local v58 = TweenService:Create(u8, TweenInfo_new_ret, {
                GroupTransparency = 1
            });
            v58.Completed:Once(function() -- Line: 125
                -- upvalues: u18 (ref), u8 (ref)
                if not u18 and u8 then
                    u8.Visible = false;
                end;
            end);
            v58:Play();
        end;

        if u12 then
            u12.Visible = false;
        end;

        if u3 then
            u3.Visible = false;
        end;

        if u5 then
            u5.Visible = false;
        end;
    end;

    LocalPlayer:GetAttributeChangedSignal("InChallenge"):Connect(refresh);

    if LocalPlayer:GetAttribute("InChallenge") then
        Activate();

        return;
    end;

    if not u18 then
        return;
    end;

    u18 = false;
    u19 = false;

    if u23 then
        u23:Disconnect();
        u23 = nil;
    end;

    if u11 and u24 then
        u11.Position = u24;
    end;

    if u8 then
        local v59 = TweenService:Create(u8, TweenInfo_new_ret, {
            GroupTransparency = 1
        });
        v59.Completed:Once(function() -- Line: 125
            -- upvalues: u18 (ref), u8 (ref)
            if not u18 and u8 then
                u8.Visible = false;
            end;
        end);
        v59:Play();
    end;

    if u12 then
        u12.Visible = false;
    end;

    if u3 then
        u3.Visible = false;
    end;

    if u5 then
        u5.Visible = false;
    end;
end;

return v50;