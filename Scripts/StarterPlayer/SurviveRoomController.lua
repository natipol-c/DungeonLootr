--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SurviveRoomController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.SurviveRoomController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local v1 = Knit.CreateController({
    Name = "SurviveRoomController"
});
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = false;

local function ShowSurvive() -- Line: 50
    -- upvalues: u2 (ref), u3 (ref), u7 (ref), TweenService (copy)
    if not (u2 and u3) then
        return;
    end;

    if u7 then
        return;
    end;

    u7 = true;
    local Attribute = u3:GetAttribute("Hidden");
    local Attribute2 = u3:GetAttribute("Start");

    if not (Attribute and Attribute2) then
        warn("[SurviveRoomController] Missing Hidden/Start attributes on Survive frame");
        u2.GroupTransparency = 0;
        u3.Visible = true;

        return;
    end;

    u3.Position = Attribute;
    u2.GroupTransparency = 1;
    u3.Visible = true;
    TweenService:Create(u3, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = Attribute2
    }):Play();
    TweenService:Create(u2, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();
end;

local function HideSurvive() -- Line: 82
    -- upvalues: u2 (ref), u3 (ref), u7 (ref), TweenService (copy)
    if not (u2 and u3) then
        return;
    end;

    if not u7 then
        return;
    end;

    u7 = false;
    local Attribute = u3:GetAttribute("Start");
    local Attribute2 = u3:GetAttribute("Hidden");
    local v8 = Attribute and UDim2.new(Attribute.X.Scale, Attribute.X.Offset, Attribute.Y.Scale + -0.05, Attribute.Y.Offset) or u3.Position;
    TweenService:Create(u3, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = v8
    }):Play();
    local v9 = TweenService:Create(u2, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        GroupTransparency = 1
    });
    v9.Completed:Connect(function() -- Line: 104
        -- upvalues: u7 (ref), u3 (ref), Attribute2 (copy)
        if u7 then
            return;
        end;

        u3.Visible = false;

        if Attribute2 then
            u3.Position = Attribute2;
        end;
    end);
    v9:Play();
end;

local function SetTime(p10: number) -- Line: 116
    -- upvalues: u5 (ref)
    if u5 then
        local math_floor_ret = math.floor(p10);
        u5.Text = `Time Left: {math.max(0, math_floor_ret)}s`;
    end;
end;

local function SetBonus(p11: number, p12: boolean) -- Line: 122
    -- upvalues: u6 (ref)
    if not u6 then
        return;
    end;

    if p12 then
        u6.Text = "Bonus earned!";

        return;
    end;

    u6.Text = `Kills left for bonus: {math.max(0, p11)}`;
end;

function v1.KnitInit(p13) -- Line: 133
    -- upvalues: Knit (copy), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref)
    local Dungeon_Container = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("HUD"):FindFirstChild("Dungeon_Container");

    if not Dungeon_Container then
        return;
    end;

    u2 = Dungeon_Container:FindFirstChild("Timer_Canvas");

    if not u2 then
        warn("[SurviveRoomController] Timer_Canvas not found");

        return;
    end;

    u3 = u2:FindFirstChild("Survive");

    if not u3 then
        warn("[SurviveRoomController] Survive frame not found in Timer_Canvas");

        return;
    end;

    u4 = u3:FindFirstChild("Title");
    u5 = u3:FindFirstChild("Time");
    local Bonus = u3:FindFirstChild("Bonus");

    if Bonus then
        Bonus = Bonus:FindFirstChild("TextLabel");
    end;

    u6 = Bonus;
    u2.GroupTransparency = 1;
    u3.Visible = false;
end;

function v1.KnitStart(p14) -- Line: 163
    -- upvalues: u2 (ref), u3 (ref), Knit (copy), u4 (ref), u5 (ref), u6 (ref), ShowSurvive (copy), HideSurvive (copy)
    if not (u2 and u3) then
        return;
    end;

    local Service = Knit.GetService("DungeonRunService");
    Service.PhaseChange:Connect(function(p15: string, p16: any) -- Line: 168
        -- upvalues: u4 (ref), u5 (ref), u6 (ref), ShowSurvive (ref), HideSurvive (ref)
        if p15 ~= "SurviveRoom" then
            if p15 == "SurviveEnd" then
                HideSurvive();

                return;
            end;

            if p15 == "Completed" or (p15 == "Failed" or p15 == "DungeonComplete") then
                HideSurvive();
            end;

            return;
        end;

        if u4 then
            u4.Text = "SURVIVE";
        end;

        local v17 = p16 and (p16.TimeLimit or 45) or 45;

        if u5 then
            local math_floor_ret = math.floor(v17);
            u5.Text = `Time Left: {math.max(0, math_floor_ret)}s`;
        end;

        local v18 = p16 and p16.BonusThreshold or 0;

        if u6 then
            u6.Text = `Kills left for bonus: {math.max(0, v18)}`;
        end;

        ShowSurvive();
    end);
    Service.SurviveTimerUpdate:Connect(function(p19: number, p20: number) -- Line: 184
        -- upvalues: u5 (ref)
        if u5 then
            local math_floor_ret = math.floor(p19);
            u5.Text = `Time Left: {math.max(0, math_floor_ret)}s`;
        end;
    end);
    Service.SurviveBonusUpdate:Connect(function(p21: number, p22: number, p23: boolean) -- Line: 188
        -- upvalues: u6 (ref)
        if not u6 then
            return;
        end;

        if p23 then
            u6.Text = "Bonus earned!";

            return;
        end;

        u6.Text = `Kills left for bonus: {math.max(0, p21)}`;
    end);
end;

return v1;