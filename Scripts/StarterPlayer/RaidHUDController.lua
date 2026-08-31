--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     RaidHUDController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.RaidHUDController
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
local RaidData = require(ReplicatedStorage.GameInfo.RaidData);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local LocalPlayer = Players.LocalPlayer;
local TweenInfo_new_ret = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 80, 80);
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
local u17 = false;
local u18 = false;
local u19 = nil;
local u20 = 1;
local u21 = false;
local u22 = nil;
local u23 = nil;

local function RaidEntry() -- Line: 80
    -- upvalues: u19 (ref), RaidData (copy)
    return u19 and RaidData.GetRaid(u19) or nil;
end;

local function FormatClock(p24: number) -- Line: 85
    local math_floor_ret = math.floor(p24);
    local math_max_ret = math.max(0, math_floor_ret);

    return string.format("%d:%02d", math.floor(math_max_ret / 60), math_max_ret % 60);
end;

local function SetPhaseTitle() -- Line: 90
    -- upvalues: u9 (ref), u20 (ref)
    if u9 then
        u9.Text = "PHASE " .. u20;
    end;
end;

local function StartTimerShake() -- Line: 95
    -- upvalues: u22 (ref), u10 (ref), u23 (ref), RunService (copy)
    if u22 then
        return;
    end;

    if not u10 then
        return;
    end;

    if not u23 then
        u23 = u10.Position;
    end;

    local u25 = u23;
    u22 = RunService.Heartbeat:Connect(function() -- Line: 100
        -- upvalues: u10 (ref), u25 (copy)
        if not (u10 and u10.Parent) then
            return;
        end;

        local math_random_ret = math.random(-1, 1);
        local math_random_ret2 = math.random(-1, 1);
        u10.Position = UDim2.new(u25.X.Scale, u25.X.Offset + math_random_ret, u25.Y.Scale, u25.Y.Offset + math_random_ret2);
    end);
end;

local function StopTimerShake() -- Line: 108
    -- upvalues: u22 (ref), u10 (ref), u23 (ref)
    if u22 then
        u22:Disconnect();
        u22 = nil;
    end;

    if u10 and u23 then
        u10.Position = u23;
    end;
end;

local function SetCanvasVisible(p26: boolean) -- Line: 118
    -- upvalues: u7 (ref), TweenService (copy), TweenInfo_new_ret (copy), u17 (ref)
    if not u7 then
        return;
    end;

    if p26 then
        u7.Visible = true;
        TweenService:Create(u7, TweenInfo_new_ret, {
            GroupTransparency = 0
        }):Play();

        return;
    end;

    local v27 = TweenService:Create(u7, TweenInfo_new_ret, {
        GroupTransparency = 1
    });
    v27.Completed:Once(function() -- Line: 125
        -- upvalues: u17 (ref), u7 (ref)
        if not u17 and u7 then
            u7.Visible = false;
        end;
    end);
    v27:Play();
end;

local function Activate() -- Line: 134
    -- upvalues: u17 (ref), u20 (ref), u21 (ref), u2 (ref), u3 (ref), u4 (ref), u6 (ref), u19 (ref), RaidData (copy), u18 (ref), u11 (ref), u8 (ref), u9 (ref), u10 (ref), u23 (ref), Color3_fromRGB_ret (copy), u7 (ref), TweenService (copy), TweenInfo_new_ret (copy)
    if u17 then
        return;
    end;

    u17 = true;
    u20 = 1;
    u21 = false;

    if u2 then
        u2.Visible = true;
    end;

    if u3 then
        u3.Visible = false;
    end;

    if u4 then
        u4.Visible = true;
    end;

    if u6 then
        local v28 = u19 and RaidData.GetRaid(u19) or nil;
        u6.Text = v28 and v28.DisplayName or "Raid";
    end;

    u18 = false;

    if u11 then
        u11.Visible = false;
    end;

    if u8 then
        local Attribute = u8:GetAttribute("Start");

        if typeof(Attribute) == "UDim2" then
            u8.Position = Attribute;
        end;
    end;

    if u9 then
        u9.Text = "Beginning in...";
    end;

    if u10 then
        if not u23 then
            u23 = u10.Position;
        end;

        u10.Text = RaidData.LOADING_TIME .. "s";
        u10.TextColor3 = Color3_fromRGB_ret;
    end;

    if not u7 then
        return;
    end;

    u7.Visible = true;
    TweenService:Create(u7, TweenInfo_new_ret, {
        GroupTransparency = 0
    }):Play();
end;

local function Deactivate() -- Line: 167
    -- upvalues: u17 (ref), u18 (ref), u21 (ref), u22 (ref), u10 (ref), u23 (ref), u7 (ref), TweenService (copy), TweenInfo_new_ret (copy), u11 (ref), u4 (ref)
    if not u17 then
        return;
    end;

    u17 = false;
    u18 = false;
    u21 = false;

    if u22 then
        u22:Disconnect();
        u22 = nil;
    end;

    if u10 and u23 then
        u10.Position = u23;
    end;

    if u7 then
        local v29 = TweenService:Create(u7, TweenInfo_new_ret, {
            GroupTransparency = 1
        });
        v29.Completed:Once(function() -- Line: 125
            -- upvalues: u17 (ref), u7 (ref)
            if not u17 and u7 then
                u7.Visible = false;
            end;
        end);
        v29:Play();
    end;

    if u11 then
        u11.Visible = false;
    end;

    if u4 then
        u4.Visible = false;
    end;
end;

local function OnMapLoadScreen(p30: string, p31: number?) -- Line: 182
    -- upvalues: LoadingOverlay (copy)
    if p30 == "Begin" then
        LoadingOverlay.Show({
            StatusText = "Loading",
            AnchorHRP = false,
            Skippable = true
        });
        LoadingOverlay.SetStatusSuffix(p31 and " " .. p31 .. "s" or nil);

        return;
    end;

    if p30 == "Tick" then
        LoadingOverlay.SetStatusSuffix(p31 and " " .. p31 .. "s" or nil);

        return;
    end;

    if p30 == "Done" then
        LoadingOverlay.Hide();
    end;
end;

local function OnLoadingUpdate(p32: number) -- Line: 194
    -- upvalues: u22 (ref), u10 (ref), u23 (ref), u21 (ref), u9 (ref), Color3_fromRGB_ret (copy)
    if u22 then
        u22:Disconnect();
        u22 = nil;
    end;

    if u10 and u23 then
        u10.Position = u23;
    end;

    u21 = false;

    if u9 then
        u9.Text = "Beginning in...";
    end;

    if u10 then
        local math_floor_ret = math.floor(p32);
        u10.Text = math.max(0, math_floor_ret) .. "s";
        u10.TextColor3 = Color3_fromRGB_ret;
    end;
end;

local function OnTimerUpdate(p33: number, p34: number) -- Line: 205
    -- upvalues: u21 (ref), u9 (ref), u20 (ref), u10 (ref), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), u22 (ref), u23 (ref), RunService (copy)
    if not u21 then
        u21 = true;

        if u9 then
            u9.Text = "PHASE " .. u20;
        end;
    end;

    if not u10 then
        return;
    end;

    local math_floor_ret = math.floor(p33);
    local math_max_ret = math.max(0, math_floor_ret);
    local math_floor_ret2 = math.floor(math_max_ret);
    local math_max_ret2 = math.max(0, math_floor_ret2);
    u10.Text = "Time Left: " .. string.format("%d:%02d", math.floor(math_max_ret2 / 60), math_max_ret2 % 60);
    u10.TextColor3 = math_max_ret <= 60 and Color3_fromRGB_ret2 or Color3_fromRGB_ret;

    if math_max_ret > 30 or math_max_ret <= 0 then
        if u22 then
            u22:Disconnect();
            u22 = nil;
        end;

        if u10 and u23 then
            u10.Position = u23;
        end;

        return;
    end;

    if u22 then
        return;
    end;

    if not u10 then
        return;
    end;

    if not u23 then
        u23 = u10.Position;
    end;

    local u35 = u23;
    u22 = RunService.Heartbeat:Connect(function() -- Line: 100
        -- upvalues: u10 (ref), u35 (copy)
        if not (u10 and u10.Parent) then
            return;
        end;

        local math_random_ret = math.random(-1, 1);
        local math_random_ret2 = math.random(-1, 1);
        u10.Position = UDim2.new(u35.X.Scale, u35.X.Offset + math_random_ret, u35.Y.Scale, u35.Y.Offset + math_random_ret2);
    end);
end;

local function OnRaidPhaseUpdate(p36: number, p37: number) -- Line: 223
    -- upvalues: u20 (ref), u21 (ref), u9 (ref)
    u20 = p36;

    if u21 and u9 then
        u9.Text = "PHASE " .. u20;
    end;
end;

local function OnLivesUpdate(p38: number) -- Line: 228
    -- upvalues: u4 (ref), u5 (ref)
    if u4 then
        u4.Visible = true;
    end;

    if u5 then
        u5.Text = "Lives: " .. p38;
    end;
end;

local function OnBossHealthUpdate(p39: number, p40: number, p41: string?) -- Line: 235
    -- upvalues: u19 (ref), RaidData (copy), u18 (ref), u11 (ref), u14 (ref), BossHealthBars (copy), u15 (ref), SharedUtils (copy), u16 (ref), TweenService (copy), TweenInfo_new_ret2 (copy)
    local v42 = u19 and RaidData.GetRaid(u19) or nil;
    local v43 = p41 or (v42 and v42.BossDisplayName or "Boss");

    if p39 and p39 > 0 then
        if not u18 then
            u18 = true;

            if u11 then
                u11.Visible = true;
            end;

            if u14 then
                u14.Text = v43;
            end;

            BossHealthBars.Prime(v43, p40);
        end;

        BossHealthBars.Update(p39, p40, v43);

        if u15 then
            u15.Text = SharedUtils.FormatWithCommas((math.floor(p39))) .. " / " .. SharedUtils.FormatWithCommas((math.floor(p40)));
        end;

        local v44 = u16 and BossHealthBars.GetActiveSize();

        if v44 then
            TweenService:Create(u16, TweenInfo_new_ret2, {
                Size = v44
            }):Play();
        end;
    elseif u18 then
        u18 = false;
        task.delay(1, function() -- Line: 261
            -- upvalues: u18 (ref), u11 (ref)
            if not u18 and u11 then
                u11.Visible = false;
            end;
        end);
    end;
end;

local function OnPhaseChange(p45: string, p46: any) -- Line: 269
    -- upvalues: u19 (ref), u6 (ref), RaidData (copy), u17 (ref), u18 (ref), u21 (ref), u22 (ref), u10 (ref), u23 (ref), u7 (ref), TweenService (copy), TweenInfo_new_ret (copy), u11 (ref), u4 (ref)
    if typeof(p46) == "table" and p46.RaidId then
        u19 = p46.RaidId;

        if u6 then
            local v47 = u19 and RaidData.GetRaid(u19) or nil;
            u6.Text = v47 and v47.DisplayName or "Raid";
        end;
    end;

    if p45 == "Complete" or p45 == "Failed" then
        if not u17 then
            return;
        end;

        u17 = false;
        u18 = false;
        u21 = false;

        if u22 then
            u22:Disconnect();
            u22 = nil;
        end;

        if u10 and u23 then
            u10.Position = u23;
        end;

        if u7 then
            local v48 = TweenService:Create(u7, TweenInfo_new_ret, {
                GroupTransparency = 1
            });
            v48.Completed:Once(function() -- Line: 125
                -- upvalues: u17 (ref), u7 (ref)
                if not u17 and u7 then
                    u7.Visible = false;
                end;
            end);
            v48:Play();
        end;

        if u11 then
            u11.Visible = false;
        end;

        if u4 then
            u4.Visible = false;
        end;
    end;
end;

local v49 = Knit.CreateController({
    Name = "RaidHUDController"
});

function v49.IsActive(p50) -- Line: 289
    -- upvalues: u17 (ref)
    return u17;
end;

function v49.KnitInit(p51) -- Line: 295
    -- upvalues: Knit (copy), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref)
    u2 = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("HUD"):FindFirstChild("Dungeon_Container");

    if not u2 then
        return;
    end;

    local Info = u2:FindFirstChild("Info");

    if Info then
        u3 = Info:FindFirstChild("Wave");
        u4 = Info:FindFirstChild("Lives_Frame");
        local v52 = u4 and u4:FindFirstChild("Lives_Text");
        u5 = v52;
        u6 = Info:FindFirstChild("Dungeon_Name");
    end;

    u7 = u2:FindFirstChild("Challenge_Canvas");
    local v53 = u7 and u7:FindFirstChild("Frame");
    u8 = v53;

    if u8 then
        u9 = u8:FindFirstChild("Title");
        u10 = u8:FindFirstChild("SubText");
    end;

    u11 = u2:FindFirstChild("Boss_Info");

    if u11 then
        u12 = u11:FindFirstChild("Health_Bar");
        u13 = u11:FindFirstChild("Health_Count");
        u14 = u11:FindFirstChild("Boss_Name");
        u15 = u11:FindFirstChild("Health_Amount");
        local v54 = u12 and u12:FindFirstChild("Trail");
        u16 = v54;
    end;
end;

function v49.KnitStart(p55) -- Line: 325
    -- upvalues: u2 (ref), Knit (copy), u1 (ref), u12 (ref), u13 (ref), BossHealthBars (copy), OnMapLoadScreen (copy), OnLoadingUpdate (copy), OnTimerUpdate (copy), OnRaidPhaseUpdate (copy), OnLivesUpdate (copy), OnBossHealthUpdate (copy), OnPhaseChange (copy), LocalPlayer (copy), RaidData (copy), u19 (ref), Activate (copy), u17 (ref), u18 (ref), u21 (ref), u22 (ref), u10 (ref), u23 (ref), u7 (ref), TweenService (copy), TweenInfo_new_ret (copy), u11 (ref), u4 (ref)
    if not u2 then
        return;
    end;

    local success, result = pcall(function() -- Line: 329
        -- upvalues: Knit (ref)
        return Knit.GetService("RaidRunService");
    end);

    if not (success and result) then
        return;
    end;

    u1 = result;

    if u12 and u13 then
        BossHealthBars.SetRefs(u12, u13);
    end;

    u1.MapLoadScreen:Connect(OnMapLoadScreen);
    u1.LoadingUpdate:Connect(OnLoadingUpdate);
    u1.TimerUpdate:Connect(OnTimerUpdate);
    u1.RaidPhaseUpdate:Connect(OnRaidPhaseUpdate);
    u1.LivesUpdate:Connect(OnLivesUpdate);
    u1.BossHealthUpdate:Connect(OnBossHealthUpdate);
    u1.PhaseChange:Connect(OnPhaseChange);

    local function refresh() -- Line: 351
        -- upvalues: LocalPlayer (ref), RaidData (ref), u19 (ref), Activate (ref), u17 (ref), u18 (ref), u21 (ref), u22 (ref), u10 (ref), u23 (ref), u7 (ref), TweenService (ref), TweenInfo_new_ret (ref), u11 (ref), u4 (ref)
        if LocalPlayer:GetAttribute("InRaid") then
            local Attribute = LocalPlayer:GetAttribute("CurrentDungeon");

            if typeof(Attribute) == "string" and RaidData.GetRaid(Attribute) then
                u19 = Attribute;
            end;

            Activate();

            return;
        end;

        if not u17 then
            return;
        end;

        u17 = false;
        u18 = false;
        u21 = false;

        if u22 then
            u22:Disconnect();
            u22 = nil;
        end;

        if u10 and u23 then
            u10.Position = u23;
        end;

        if u7 then
            local v56 = TweenService:Create(u7, TweenInfo_new_ret, {
                GroupTransparency = 1
            });
            v56.Completed:Once(function() -- Line: 125
                -- upvalues: u17 (ref), u7 (ref)
                if not u17 and u7 then
                    u7.Visible = false;
                end;
            end);
            v56:Play();
        end;

        if u11 then
            u11.Visible = false;
        end;

        if u4 then
            u4.Visible = false;
        end;
    end;

    LocalPlayer:GetAttributeChangedSignal("InRaid"):Connect(refresh);
    refresh();
end;

return v49;