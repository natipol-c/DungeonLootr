--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     LoadingOverlay
  Path:     game.ReplicatedStorage.ClientTools.LoadingOverlay
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:27 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = false;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = "";
local u8 = nil;
local u9 = nil;

local function getCanvas() -- Line: 75
    -- upvalues: LocalPlayer (copy)
    local v10 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if not v10 then
        return nil;
    end;

    local Loading = v10:FindFirstChild("Loading");

    if not Loading then
        return nil;
    end;

    local CanvasGroup = Loading:FindFirstChild("CanvasGroup");

    if CanvasGroup and CanvasGroup:IsA("CanvasGroup") then
        return CanvasGroup;
    end;

    return nil;
end;

local function getStatusLabel(p11: userdata) -- Line: 88
    local Top = p11:FindFirstChild("Top");

    if not Top then
        return nil;
    end;

    local Status = Top:FindFirstChild("Status");

    if Status and Status:IsA("TextLabel") then
        return Status;
    end;

    return nil;
end;

local function getSkipButton(p12: userdata) -- Line: 97
    local Skip = p12:FindFirstChild("Skip");

    if Skip and Skip:IsA("ImageButton") then
        return Skip;
    end;

    return nil;
end;

local function teardownSkip() -- Line: 104
    -- upvalues: u9 (ref), u8 (ref)
    if u9 then
        u9:Disconnect();
        u9 = nil;
    end;

    if u8 then
        u8.Visible = false;
        u8 = nil;
    end;
end;

local function getRootPart() -- Line: 115
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        return Character:FindFirstChild("HumanoidRootPart");
    end;

    return nil;
end;

local function stopThread(p13: thread?) -- Line: 121
    if p13 then
        pcall(task.cancel, p13);
    end;
end;

local function startShine(p14: userdata) -- Line: 137
    -- upvalues: TweenService (copy)
    local Top = p14:FindFirstChild("Top");

    if Top then
        Top = Top:FindFirstChild("ImageLabel");
    end;

    if Top then
        Top = Top:FindFirstChildOfClass("UIGradient");
    end;

    if not Top then
        return nil;
    end;

    local Transparency = Top.Transparency;
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Name = "_ShineProxy";
    NumberValue.Value = 0.168;
    NumberValue.Parent = Top;
    local u16 = NumberValue.Changed:Connect(function(p15) -- Line: 151
        -- upvalues: Top (copy)
        local math_max_ret = math.max(p15 - 0.08, 0.001);
        local math_min_ret = math.min(p15 + 0.08, 0.999);
        local math_clamp_ret = math.clamp(p15, math_max_ret + 0.001, math_min_ret - 0.001);
        Top.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.7),
            NumberSequenceKeypoint.new(math_max_ret, 0.7),
            NumberSequenceKeypoint.new(math_clamp_ret, 0),
            NumberSequenceKeypoint.new(math_min_ret, 0.7),
            NumberSequenceKeypoint.new(1, 0.7)
        });
    end);
    local u17 = TweenService:Create(NumberValue, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Value = 0.997
    });
    u17:Play();
    local u18 = false;

    return function() -- Line: 173
        -- upvalues: u18 (ref), u17 (copy), u16 (copy), NumberValue (copy), Top (copy), Transparency (copy)
        if u18 then
            return;
        end;

        u18 = true;
        u17:Cancel();
        u16:Disconnect();
        NumberValue:Destroy();

        if Top.Parent then
            Top.Transparency = Transparency;
        end;
    end;
end;

function u1.IsActive() -- Line: 187
    -- upvalues: u2 (ref)
    return u2;
end;

function u1.Run(p19) -- Line: 205
    -- upvalues: u2 (ref), getCanvas (copy), startShine (copy), TweenService (copy), LocalPlayer (copy)
    local u20 = p19 or {};

    if u2 then
        return false;
    end;

    local u21 = getCanvas();

    if not u21 then
        warn("[LoadingOverlay] PlayerGui.Loading.CanvasGroup not found — skipping transition.");

        return false;
    end;

    local u22 = u20.StatusText or "Moving";
    local u23 = u20.FadeInTime or 0.4;
    local u24 = u20.HoldTime or 0.5;
    local u25 = u20.FadeOutTime or 0.4;
    local u26 = u20.DotInterval or 0.3;
    local u27 = u20.MaxDots or 3;
    local u28 = u20.AnchorHRP == nil and true or u20.AnchorHRP;
    u2 = true;
    local u29 = nil;
    local u30 = nil;
    local u31 = nil;
    local success, result = pcall(function() -- Line: 232
        -- upvalues: u21 (copy), u31 (ref), startShine (ref), u29 (ref), u22 (copy), u27 (copy), u26 (copy), TweenService (ref), u23 (copy), u20 (ref), u28 (copy), LocalPlayer (ref), u30 (ref), u24 (copy), u25 (copy)
        u21.GroupTransparency = 1;
        u21.Visible = true;
        u31 = startShine(u21);
        local Top = u21:FindFirstChild("Top");
        local u32;

        if Top then
            u32 = Top:FindFirstChild("Status");

            if not (u32 and u32:IsA("TextLabel")) then
                u32 = nil;
            end;
        else
            u32 = nil;
        end;

        if u32 then
            u29 = task.spawn(function() -- Line: 243
                -- upvalues: u32 (copy), u22 (ref), u27 (ref), u26 (ref)
                local v33 = 0;

                while true do
                    u32.Text = u22 .. string.rep(".", v33);
                    local v34 = v33 + 1;
                    v33 = u27 < v34 and 0 or v34;
                    task.wait(u26);
                end;
            end);
        end;

        local v35 = TweenService:Create(u21, TweenInfo.new(u23, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            GroupTransparency = 0
        });
        v35:Play();
        v35.Completed:Wait();

        if u20.Action then
            local success, result = pcall(u20.Action);

            if not success then
                warn("[LoadingOverlay] Action errored:", result);
            end;
        end;

        if u28 then
            local Character = LocalPlayer.Character;
            local v36;

            if Character then
                v36 = Character:FindFirstChild("HumanoidRootPart");
            else
                v36 = nil;
            end;

            if v36 then
                v36.Anchored = true;
                u30 = v36;
            end;
        end;

        task.wait(u24);

        if u30 and u30.Parent then
            u30.Anchored = false;
        end;

        u30 = nil;
        local v37 = u29;

        if v37 then
            pcall(task.cancel, v37);
        end;

        u29 = nil;
        local v38 = TweenService:Create(u21, TweenInfo.new(u25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            GroupTransparency = 1
        });
        v38:Play();
        v38.Completed:Wait();
        u21.Visible = false;
    end);
    local v39 = u29;

    if v39 then
        pcall(task.cancel, v39);
    end;

    if u31 then
        u31();
    end;

    if u30 and u30.Parent then
        u30.Anchored = false;
    end;

    if not success then
        u21.GroupTransparency = 1;
        u21.Visible = false;
        warn("[LoadingOverlay] Run errored:", result);
    end;

    u2 = false;

    return success;
end;

function u1.Show(p40) -- Line: 341
    -- upvalues: u2 (ref), getCanvas (copy), u7 (ref), u9 (ref), u8 (ref), u4 (ref), startShine (copy), u3 (ref), TweenService (copy), LocalPlayer (copy), u5 (ref), u1 (copy), u6 (ref)
    local u41 = p40 or {};

    if u2 then
        return false;
    end;

    local u42 = getCanvas();

    if not u42 then
        warn("[LoadingOverlay] PlayerGui.Loading.CanvasGroup not found — skipping Show.");

        return false;
    end;

    local u43 = u41.StatusText or "Moving";
    local u44 = u41.FadeInTime or 0.4;
    local u45 = u41.DotInterval or 0.3;
    local u46 = u41.MaxDots or 3;
    local v47 = u41.MaxHoldTime or 20;
    local u48 = u41.AnchorHRP == nil and true or u41.AnchorHRP;
    local u49 = u41.Skippable == true;
    u2 = true;
    u7 = "";

    if u9 then
        u9:Disconnect();
        u9 = nil;
    end;

    if u8 then
        u8.Visible = false;
        u8 = nil;
    end;

    local success, result = pcall(function() -- Line: 364
        -- upvalues: u42 (copy), u4 (ref), startShine (ref), u3 (ref), u43 (copy), u7 (ref), u46 (copy), u45 (copy), TweenService (ref), u44 (copy), u41 (ref), u48 (copy), LocalPlayer (ref), u5 (ref), u49 (copy), u8 (ref), u9 (ref), u1 (ref)
        u42.GroupTransparency = 1;
        u42.Visible = true;
        u4 = startShine(u42);
        local Top = u42:FindFirstChild("Top");
        local u50;

        if Top then
            u50 = Top:FindFirstChild("Status");

            if not (u50 and u50:IsA("TextLabel")) then
                u50 = nil;
            end;
        else
            u50 = nil;
        end;

        if u50 then
            u3 = task.spawn(function() -- Line: 372
                -- upvalues: u50 (copy), u43 (ref), u7 (ref), u46 (ref), u45 (ref)
                local v51 = 0;

                while true do
                    u50.Text = u43 .. string.rep(".", v51) .. u7;
                    local v52 = v51 + 1;
                    v51 = u46 < v52 and 0 or v52;
                    task.wait(u45);
                end;
            end);
        end;

        local v53 = TweenService:Create(u42, TweenInfo.new(u44, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            GroupTransparency = 0
        });
        v53:Play();
        v53.Completed:Wait();

        if u41.Action then
            local success, result = pcall(u41.Action);

            if not success then
                warn("[LoadingOverlay] Show Action errored:", result);
            end;
        end;

        if u48 then
            local Character = LocalPlayer.Character;
            local v54;

            if Character then
                v54 = Character:FindFirstChild("HumanoidRootPart");
            else
                v54 = nil;
            end;

            if v54 then
                v54.Anchored = true;
                u5 = v54;
            end;
        end;

        if u49 then
            local Skip = u42:FindFirstChild("Skip");

            if not (Skip and Skip:IsA("ImageButton")) then
                Skip = nil;
            end;

            if Skip then
                u8 = Skip;
                Skip.Visible = true;
                u9 = Skip.Activated:Connect(function() -- Line: 414
                    -- upvalues: u41 (ref), u1 (ref)
                    if u41.OnSkip then
                        pcall(u41.OnSkip);
                    end;

                    u1.Hide();
                end);
            end;
        end;
    end);

    if success then
        u6 = task.delay(v47, function() -- Line: 440
            -- upvalues: u2 (ref), u1 (ref)
            if u2 then
                warn("[LoadingOverlay] Show held past MaxHoldTime — auto-hiding.");
                u1.Hide();
            end;
        end);

        return true;
    end;

    local v55 = u3;

    if v55 then
        pcall(task.cancel, v55);
    end;

    u3 = nil;
    u7 = "";

    if u9 then
        u9:Disconnect();
        u9 = nil;
    end;

    if u8 then
        u8.Visible = false;
        u8 = nil;
    end;

    if u4 then
        u4();
    end;

    u4 = nil;

    if u5 and u5.Parent then
        u5.Anchored = false;
    end;

    u5 = nil;
    u42.GroupTransparency = 1;
    u42.Visible = false;
    u2 = false;
    warn("[LoadingOverlay] Show errored:", result);

    return false;
end;

function u1.Hide(p56) -- Line: 450
    -- upvalues: u2 (ref), u6 (ref), getCanvas (copy), u5 (ref), u3 (ref), u7 (ref), u9 (ref), u8 (ref), TweenService (copy), u4 (ref)
    local v57 = p56 or {};

    if not u2 then
        return false;
    end;

    local v58 = u6;

    if v58 then
        pcall(task.cancel, v58);
    end;

    u6 = nil;
    local u59 = v57.FadeOutTime or 0.4;
    local u60 = getCanvas();

    if u5 and u5.Parent then
        u5.Anchored = false;
    end;

    u5 = nil;
    local v61 = u3;

    if v61 then
        pcall(task.cancel, v61);
    end;

    u3 = nil;
    u7 = "";

    if u9 then
        u9:Disconnect();
        u9 = nil;
    end;

    if u8 then
        u8.Visible = false;
        u8 = nil;
    end;

    local success, result = pcall(function() -- Line: 468
        -- upvalues: u60 (copy), TweenService (ref), u59 (copy)
        if u60 then
            local v62 = TweenService:Create(u60, TweenInfo.new(u59, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                GroupTransparency = 1
            });
            v62:Play();
            v62.Completed:Wait();
            u60.Visible = false;
        end;
    end);

    if u4 then
        u4();
    end;

    u4 = nil;

    if not success then
        if u60 then
            u60.GroupTransparency = 1;
            u60.Visible = false;
        end;

        warn("[LoadingOverlay] Hide errored:", result);
    end;

    u2 = false;

    return success;
end;

function u1.SetStatusSuffix(p63: string?) -- Line: 504
    -- upvalues: u7 (ref)
    u7 = p63 or "";
end;

return u1;