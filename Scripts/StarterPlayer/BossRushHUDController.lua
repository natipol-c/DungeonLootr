--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BossRushHUDController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.BossRushHUDController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local BossHealthBars = require(ReplicatedStorage.ClientTools.BossHealthBars);
local LocalPlayer = Players.LocalPlayer;
local u1 = { "IS THAT ALL YOU GOT?", "DON\'T GIVE UP NOW!", "KEEP PUSHING FORWARD!", "YOU\'RE UNSTOPPABLE!", "THEY NEVER STOOD A CHANCE.", "THE NEXT ONE WON\'T BE SO EASY.", "FEEL THE POWER!", "NO MERCY!", "RISE ABOVE!", "THIS IS YOUR MOMENT!", "THEY FEAR YOU NOW.", "SHOW THEM YOUR STRENGTH!", "NOTHING CAN STOP YOU!", "PURE DOMINATION!", "THE ARENA TREMBLES!" };
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
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = nil;
local u26 = nil;
local u27 = nil;
local u28 = false;
local u29 = 0;
local u30 = 0;
local u31 = false;
local u32 = nil;
local u33 = false;
local u34 = 0;
local u35 = 0;
local u36 = nil;
local u37 = nil;
local RunService = game:GetService("RunService");

local function FormatTimeMs(p38: number) -- Line: 104
    local math_max_ret = math.max(p38, 0);
    local math_floor_ret = math.floor(math_max_ret / 60);
    local v39 = math.floor(math_max_ret) % 60;
    local math_floor_ret2 = math.floor(math_max_ret % 1 * 100);

    return string.format("%02d:%02d:%02d", math_floor_ret, v39, math_floor_ret2);
end;

local function FormatHealth(p40: number) -- Line: 113
    local math_max_ret = math.max(0, p40);
    local math_floor_ret = math.floor(math_max_ret);
    local v41 = tostring(math_floor_ret);
    local v42;

    repeat
        v41, v42 = v41:gsub("^(-?%d+)(%d%d%d)", "%1,%2");
    until v42 == 0;

    return v41;
end;

local function UpdateBossHealth(p43: number, p44: number, p45: string) -- Line: 126
    -- upvalues: u15 (ref), u16 (ref), u18 (ref), FormatHealth (copy), u20 (ref), BossHealthBars (copy), u33 (ref), u34 (ref), u35 (ref)
    if not u15 then
        return;
    end;

    u15.Visible = true;

    if u16 then
        u16.Text = p45 or "Boss";
    end;

    if u18 then
        u18.Text = FormatHealth(p43) .. " / " .. FormatHealth(p44);
    end;

    local v46 = p44 > 0 and (math.clamp(p43 / p44, 0, 1) or 0) or 0;

    if u20 then
        BossHealthBars.Update(p43, p44, p45);
    end;

    if v46 < 1 then
        u33 = true;
        u34 = os.clock();

        if u35 == 0 then
            u35 = os.clock();
        end;
    end;

    if p43 <= 0 then
        task.delay(1, function() -- Line: 159
            -- upvalues: u15 (ref)
            if u15 then
                u15.Visible = false;
            end;
        end);
        StopTrailLogic();
    end;
end;

local function UpdateBossType(p47: string) -- Line: 167
    -- upvalues: u17 (ref), u22 (ref), u23 (ref)
    if not u17 then
        return;
    end;

    if p47 == "Enraged" then
        u17.Visible = true;
        u17.Text = "ENRAGED";

        if u22 then
            u22.Enabled = false;
        end;

        if u23 then
            u23.Enabled = true;
        end;
    elseif p47 == "Empowered" then
        u17.Visible = true;
        u17.Text = "EMPOWERED";

        if u23 then
            u23.Enabled = false;
        end;

        if u22 then
            u22.Enabled = true;
        end;
    else
        u17.Visible = false;
        u17.Text = "";

        if u22 then
            u22.Enabled = false;
        end;

        if u23 then
            u23.Enabled = false;
        end;
    end;
end;

local function StartTrailLogic() -- Line: 190
    -- upvalues: u21 (ref), u20 (ref), u33 (ref), u35 (ref), u34 (ref), u36 (ref), u37 (ref), TweenService (copy), BossHealthBars (copy)
    StopTrailLogic();

    if not (u21 and u20) then
        return;
    end;

    u21.Size = UDim2.fromScale(1, 1);
    u33 = false;
    u35 = 0;
    u34 = 0;
    u36 = game:GetService("RunService").Heartbeat:Connect(function() -- Line: 199
        -- upvalues: u33 (ref), u34 (ref), u35 (ref), u37 (ref), TweenService (ref), u21 (ref), BossHealthBars (ref), u20 (ref)
        if not u33 then
            return;
        end;

        local os_clock_ret = os.clock();

        if os_clock_ret - u34 >= 1 or os_clock_ret - u35 >= 3 then
            u33 = false;
            u35 = 0;

            if u37 then
                u37:Cancel();
            end;

            u37 = TweenService:Create(u21, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = BossHealthBars.GetActiveSize() or u20.Size
            });
            u37:Play();
        end;
    end);
end;

function StopTrailLogic()
    -- upvalues: u36 (ref), u37 (ref), u33 (ref), u35 (ref), u34 (ref)
    if u36 then
        u36:Disconnect();
        u36 = nil;
    end;

    if u37 then
        u37:Cancel();
        u37 = nil;
    end;

    u33 = false;
    u35 = 0;
    u34 = 0;
end;

local function StartSpeedrunTimer() -- Line: 240
    -- upvalues: u31 (ref), u30 (ref), u13 (ref), u14 (ref), u32 (ref), RunService (copy)
    if u31 then
        return;
    end;

    u30 = os.clock();
    u31 = true;

    if u13 then
        u13.Visible = true;
    end;

    if u14 then
        u14.Text = "00:00:00";
    end;

    if u32 then
        u32:Disconnect();
    end;

    u32 = RunService.Heartbeat:Connect(function() -- Line: 252
        -- upvalues: u31 (ref), u14 (ref), u30 (ref)
        if not u31 then
            return;
        end;

        if u14 then
            local v48 = os.clock() - u30;
            local math_max_ret = math.max(v48, 0);
            local math_floor_ret = math.floor(math_max_ret / 60);
            local v49 = math.floor(math_max_ret) % 60;
            local math_floor_ret2 = math.floor(math_max_ret % 1 * 100);
            u14.Text = string.format("%02d:%02d:%02d", math_floor_ret, v49, math_floor_ret2);
        end;
    end);
end;

local function StopSpeedrunTimer() -- Line: 260
    -- upvalues: u31 (ref), u32 (ref), u30 (ref)
    u31 = false;

    if u32 then
        u32:Disconnect();
        u32 = nil;
    end;

    return os.clock() - u30;
end;

local function UpdateFloorCounter(p50: number) -- Line: 272
    -- upvalues: u29 (ref), u8 (ref), u9 (ref), u7 (ref)
    u29 = p50;

    if u8 then
        u8.Text = "Floor:";
    end;

    if u9 then
        u9.Text = tostring(p50);
    end;

    if u7 then
        u7.Visible = true;
    end;
end;

local function UpdateLivesDisplay(p51: number) -- Line: 289
    -- upvalues: u12 (ref), u11 (ref)
    if u12 then
        u12.Text = "Lives: " .. p51;
    end;

    if u11 then
        u11.Visible = true;
    end;
end;

local function PlayFloorNotification(p52: number) -- Line: 301
    -- upvalues: u25 (ref), u24 (ref), u26 (ref), u27 (ref), u1 (copy), TweenService (copy)
    if not (u25 and u24) then
        return;
    end;

    if u26 then
        u26.Text = "FLOOR " .. p52;
        local BossGradient = u26:FindFirstChild("BossGradient");
        local v53 = u26:FindFirstChildOfClass("UIStroke");

        if BossGradient then
            BossGradient.Enabled = false;
        end;

        if v53 then
            v53.Enabled = false;
        end;
    end;

    if u27 then
        u27.Text = u1[math.random(1, #u1)];
    end;

    local Attribute = u25:GetAttribute("Hidden");
    local v54 = u25:GetAttribute("Start") or UDim2.new(0.5, 0, 0.4, 0);

    if Attribute then
        u25.Position = Attribute;
    end;

    u24.GroupTransparency = 1;
    u25.Visible = true;
    local v55 = TweenService:Create(u25, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = v54
    });
    local v56 = TweenService:Create(u24, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    });
    v55:Play();
    v56:Play();
    v55.Completed:Wait();
    task.wait(1);
    local UDim2_new_ret = UDim2.new(v54.X.Scale, v54.X.Offset, v54.Y.Scale - 0.05, v54.Y.Offset);
    local v57 = TweenService:Create(u25, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2_new_ret
    });
    local v58 = TweenService:Create(u24, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        GroupTransparency = 1
    });
    v57:Play();
    v58:Play();
    v58.Completed:Wait();
    u25.Visible = false;
end;

local function OnPhaseChange(p59: string, p60: table?) -- Line: 372
    -- upvalues: u28 (ref), u29 (ref), u8 (ref), u9 (ref), u7 (ref), u17 (ref), u22 (ref), u23 (ref), StartTrailLogic (copy), StartSpeedrunTimer (copy), u4 (ref), u5 (ref), u15 (ref), PlayFloorNotification (copy), u31 (ref), u32 (ref), u30 (ref), u6 (ref)
    if not u28 then
        return;
    end;

    local v61 = p60 or {};

    if p59 == "Active" then
        local v62 = v61.Floor or u29;
        local v63 = v61.Tier or "Regular";
        u29 = v62;

        if u8 then
            u8.Text = "Floor:";
        end;

        if u9 then
            u9.Text = tostring(v62);
        end;

        if u7 then
            u7.Visible = true;
        end;

        if u17 then
            if v63 == "Enraged" then
                u17.Visible = true;
                u17.Text = "ENRAGED";

                if u22 then
                    u22.Enabled = false;
                end;

                if u23 then
                    u23.Enabled = true;
                end;
            elseif v63 == "Empowered" then
                u17.Visible = true;
                u17.Text = "EMPOWERED";

                if u23 then
                    u23.Enabled = false;
                end;

                if u22 then
                    u22.Enabled = true;
                end;
            else
                u17.Visible = false;
                u17.Text = "";

                if u22 then
                    u22.Enabled = false;
                end;

                if u23 then
                    u23.Enabled = false;
                end;
            end;
        end;

        StartTrailLogic();
        StartSpeedrunTimer();
        local v64 = u4 and u4:FindFirstChild("Completion_Info");

        if v64 then
            v64.Visible = false;
        end;

        if u5 then
            u5.Visible = true;
        end;
    elseif p59 == "Intermission" then
        if u15 then
            u15.Visible = false;
        end;

        StopTrailLogic();
        local v65 = v61.Floor or u29;

        if v65 % 10 == 0 then
            task.spawn(PlayFloorNotification, v65);
        end;
    elseif p59 == "Complete" then
        if u15 then
            u15.Visible = false;
        end;

        StopTrailLogic();
        u31 = false;

        if u32 then
            u32:Disconnect();
            u32 = nil;
        end;

        local _ = os.clock() - u30;

        if u6 then
            u6.Text = "BOSS RUSH - FLOOR " .. (v61.HighestFloor or u29) .. " COMPLETE";
        end;
    elseif p59 == "Failed" then
        if u15 then
            u15.Visible = false;
        end;

        StopTrailLogic();
        u31 = false;

        if u32 then
            u32:Disconnect();
            u32 = nil;
        end;

        local _ = os.clock() - u30;

        if u6 then
            u6.Text = "BOSS RUSH - DEFEATED AT FLOOR " .. (v61.HighestFloor or u29);
        end;
    else
        if p59 == "Eliminated" then
            if u15 then
                u15.Visible = false;
            end;

            if u5 then
                u5.Visible = false;
            end;

            StopTrailLogic();
            u31 = false;

            if u32 then
                u32:Disconnect();
                u32 = nil;
            end;

            local _ = os.clock() - u30;

            return;
        end;

        if p59 == "Revived" then
            local v66 = v61.Floor or u29;
            local v67 = v61.Tier or "Regular";

            if u4 then
                u4.Visible = true;
            end;

            if u5 then
                u5.Visible = true;
            end;

            u29 = v66;

            if u8 then
                u8.Text = "Floor:";
            end;

            if u9 then
                u9.Text = tostring(v66);
            end;

            if u7 then
                u7.Visible = true;
            end;

            if u17 then
                if v67 == "Enraged" then
                    u17.Visible = true;
                    u17.Text = "ENRAGED";

                    if u22 then
                        u22.Enabled = false;
                    end;

                    if u23 then
                        u23.Enabled = true;
                    end;
                elseif v67 == "Empowered" then
                    u17.Visible = true;
                    u17.Text = "EMPOWERED";

                    if u23 then
                        u23.Enabled = false;
                    end;

                    if u22 then
                        u22.Enabled = true;
                    end;
                else
                    u17.Visible = false;
                    u17.Text = "";

                    if u22 then
                        u22.Enabled = false;
                    end;

                    if u23 then
                        u23.Enabled = false;
                    end;
                end;
            end;

            StartTrailLogic();

            return;
        end;

        if p59 == "Loading" then
            if u6 then
                u6.Text = "BOSS RUSH";
            end;

            if u15 then
                u15.Visible = false;
            end;
        end;
    end;
end;

local function ActivateBossRush() -- Line: 458
    -- upvalues: u28 (ref), u6 (ref), u5 (ref), u7 (ref), u11 (ref), u10 (ref), u15 (ref), u13 (ref), u29 (ref), u8 (ref), u9 (ref)
    if u28 then
        return;
    end;

    u28 = true;

    if u6 then
        u6.Text = "BOSS RUSH";
    end;

    if u5 then
        u5.Visible = true;
    end;

    if u7 then
        u7.Visible = true;
    end;

    if u11 then
        u11.Visible = true;
    end;

    if u10 then
        u10.Visible = false;
    end;

    if u15 then
        u15.Visible = false;
    end;

    local v68 = u5 and u5:FindFirstChild("Time_Left");

    if v68 then
        v68.Visible = false;
    end;

    if u13 then
        u13.Visible = true;
    end;

    local v69 = u5 and u5:FindFirstChild("Objective_Frame");

    if v69 then
        v69.Visible = false;
    end;

    u29 = 0;

    if u8 then
        u8.Text = "Floor:";
    end;

    if u9 then
        u9.Text = tostring(0);
    end;

    if u7 then
        u7.Visible = true;
    end;
end;

local function DeactivateBossRush() -- Line: 492
    -- upvalues: u28 (ref), u31 (ref), u32 (ref), u30 (ref), u17 (ref)
    if not u28 then
        return;
    end;

    u28 = false;
    StopTrailLogic();
    u31 = false;

    if u32 then
        u32:Disconnect();
        u32 = nil;
    end;

    local _ = os.clock() - u30;

    if u17 then
        u17.Visible = false;
        u17.Text = "";
    end;
end;

local v70 = Knit.CreateController({
    Name = "BossRushHUDController"
});

function v70.IsActive(p71) -- Line: 511
    -- upvalues: u28 (ref)
    return u28;
end;

function v70.KnitInit(p72) -- Line: 517
    -- upvalues: Knit (copy), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), BossHealthBars (copy), u22 (ref), u23 (ref), u24 (ref), u25 (ref), u26 (ref), u27 (ref)
    u4 = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("HUD"):FindFirstChild("Dungeon_Container");

    if not u4 then
        return;
    end;

    u5 = u4:FindFirstChild("Info");

    if u5 then
        u6 = u5:FindFirstChild("Dungeon_Name");
        u7 = u5:FindFirstChild("Mob_Counter");

        if u7 then
            u8 = u7:FindFirstChild("Enemies_Text");
            u9 = u7:FindFirstChild("Progress_Text");
        end;

        u10 = u5:FindFirstChild("Object_Frame");
        u11 = u5:FindFirstChild("Lives_Frame");

        if u11 then
            u12 = u11:FindFirstChild("Lives_Text");
        end;

        u13 = u5:FindFirstChild("Timer");

        if u13 then
            u14 = u13:FindFirstChild("Time_Text");
        end;
    end;

    u15 = u4:FindFirstChild("Boss_Info");

    if u15 then
        u16 = u15:FindFirstChild("Boss_Name");
        u17 = u15:FindFirstChild("Boss_Type");
        u18 = u15:FindFirstChild("Health_Amount");
        u19 = u15:FindFirstChild("Health_Bar");

        if u19 then
            u20 = u19:FindFirstChild("Health_Color");
            u21 = u19:FindFirstChild("Trail");
        end;

        BossHealthBars.SetRefs(u19, u15:FindFirstChild("Health_Count"));

        if u17 then
            u22 = u17:FindFirstChild("Empowered");
            u23 = u17:FindFirstChild("Enraged");
        end;
    end;

    u24 = u4:FindFirstChild("Notification_Canvas");
    u25 = u24 and u24:FindFirstChild("Zone_Cleared");

    if u25 then
        u26 = u25:FindFirstChild("Title");
        u27 = u25:FindFirstChild("Zone_Text");
    end;
end;

function v70.KnitStart(p73) -- Line: 581
    -- upvalues: u4 (ref), u2 (ref), Knit (copy), u3 (ref), LocalPlayer (copy), ActivateBossRush (copy), u28 (ref), u31 (ref), u32 (ref), u30 (ref), u17 (ref), u29 (ref), u8 (ref), u9 (ref), u7 (ref), u22 (ref), u23 (ref), StartTrailLogic (copy), u15 (ref), u16 (ref), UpdateBossHealth (copy), OnPhaseChange (copy), u12 (ref), u11 (ref)
    if not u4 then
        return;
    end;

    pcall(function() -- Line: 585
        -- upvalues: u2 (ref), Knit (ref)
        u2 = Knit.GetService("BossRushService");
    end);
    pcall(function() -- Line: 588
        -- upvalues: u3 (ref), Knit (ref)
        u3 = Knit.GetController("SoundController");
    end);

    if not u2 then
        return;
    end;

    LocalPlayer:GetAttributeChangedSignal("InBossRush"):Connect(function() -- Line: 595
        -- upvalues: LocalPlayer (ref), ActivateBossRush (ref), u28 (ref), u31 (ref), u32 (ref), u30 (ref), u17 (ref)
        if LocalPlayer:GetAttribute("InBossRush") then
            ActivateBossRush();

            return;
        end;

        if not u28 then
            return;
        end;

        u28 = false;
        StopTrailLogic();
        u31 = false;

        if u32 then
            u32:Disconnect();
            u32 = nil;
        end;

        local _ = os.clock() - u30;

        if u17 then
            u17.Visible = false;
            u17.Text = "";
        end;
    end);

    if LocalPlayer:GetAttribute("InBossRush") then
        ActivateBossRush();
    end;

    u2.FloorStart:Connect(function(p74, p75, p76) -- Line: 611
        -- upvalues: u28 (ref), u29 (ref), u8 (ref), u9 (ref), u7 (ref), u17 (ref), u22 (ref), u23 (ref), StartTrailLogic (ref), u15 (ref), u16 (ref)
        if not u28 then
            return;
        end;

        u29 = p74;

        if u8 then
            u8.Text = "Floor:";
        end;

        if u9 then
            u9.Text = tostring(p74);
        end;

        if u7 then
            u7.Visible = true;
        end;

        if u17 then
            if p76 == "Enraged" then
                u17.Visible = true;
                u17.Text = "ENRAGED";

                if u22 then
                    u22.Enabled = false;
                end;

                if u23 then
                    u23.Enabled = true;
                end;
            elseif p76 == "Empowered" then
                u17.Visible = true;
                u17.Text = "EMPOWERED";

                if u23 then
                    u23.Enabled = false;
                end;

                if u22 then
                    u22.Enabled = true;
                end;
            else
                u17.Visible = false;
                u17.Text = "";

                if u22 then
                    u22.Enabled = false;
                end;

                if u23 then
                    u23.Enabled = false;
                end;
            end;
        end;

        StartTrailLogic();

        if u15 then
            u15.Visible = true;
        end;

        if u16 then
            u16.Text = p75 or "Boss";
        end;
    end);
    u2.BossHealthUpdate:Connect(function(p77, p78, p79) -- Line: 625
        -- upvalues: u28 (ref), UpdateBossHealth (ref)
        if not u28 then
            return;
        end;

        UpdateBossHealth(p77, p78, p79);
    end);
    u2.PhaseChange:Connect(function(p80, p81) -- Line: 631
        -- upvalues: u28 (ref), OnPhaseChange (ref)
        if not u28 then
            return;
        end;

        OnPhaseChange(p80, p81);
    end);
    u2.LivesUpdate:Connect(function(p82) -- Line: 637
        -- upvalues: u28 (ref), u12 (ref), u11 (ref)
        if not u28 then
            return;
        end;

        if u12 then
            u12.Text = "Lives: " .. p82;
        end;

        if u11 then
            u11.Visible = true;
        end;
    end);
    u2.FloorCleared:Connect(function(p83, p84) -- Line: 643
        -- upvalues: u28 (ref)
        if u28 then
        end;
    end);
    u2.MilestoneReached:Connect(function(p85, p86) -- Line: 649
        -- upvalues: u28 (ref)
        if u28 then
        end;
    end);
end;

return v70;