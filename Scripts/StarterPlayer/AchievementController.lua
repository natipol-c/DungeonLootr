--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AchievementController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.AchievementController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local AchievementData = require(ReplicatedStorage.GameInfo.AchievementData);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local Knit = require(ReplicatedStorage.Packages.Knit);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = {};
local u10 = nil;
local u11 = false;
local TweenInfo_new_ret = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local Color3_fromRGB_ret = Color3.fromRGB(60, 60, 60);
local Color3_fromRGB_ret2 = Color3.fromRGB(120, 120, 120);

local function GetStats() -- Line: 64
    -- upvalues: u2 (ref)
    return u2 and u2.Data.Stats or {};
end;

local function GetClaimed() -- Line: 68
    -- upvalues: u2 (ref)
    local v12 = u2 and u2.Data.Achievements;

    return v12 and v12.Claimed or {};
end;

local function GetInfiniteTiers() -- Line: 73
    -- upvalues: u2 (ref)
    local v13 = u2 and u2.Data.Achievements;

    return v13 and v13.InfiniteTiers or {};
end;

local function CountUnclaimed() -- Line: 79
    -- upvalues: u2 (ref), AchievementData (copy)
    local v14 = u2 and u2.Data.Stats or {};
    local v15 = u2 and u2.Data.Achievements;
    local v16 = v15 and v15.Claimed or {};
    local v17 = u2 and u2.Data.Achievements;
    local v18 = v17 and v17.InfiniteTiers or {};
    local v19 = 0;

    for _, v in AchievementData.ChainOrder do
        local CurrentChainStep, v20, _ = AchievementData.GetCurrentChainStep(v, v14, v16, v18);

        if v20 == "claimable" then
            v19 = v19 + 1;

            if CurrentChainStep and CurrentChainStep.Infinite then
                local v21 = AchievementData.GetMaxInfiniteTier(CurrentChainStep, v14[CurrentChainStep.Stat] or 0) - (v18[CurrentChainStep.Id] or 0) - 1;
                v19 = v19 + math.max(0, v21);
            end;
        end;
    end;

    return v19;
end;

local function ApplyTheme(p22: userdata, p23: any) -- Line: 108
    -- upvalues: AchievementData (copy)
    local Theme = AchievementData.GetTheme(p23);

    if not Theme then
        return;
    end;

    local v24 = p22:FindFirstChildWhichIsA("UIStroke");

    if v24 then
        v24.Color = Theme.StrokeColor;
    end;

    local v25 = p22:FindFirstChildWhichIsA("UIGradient");

    if v25 then
        v25.Color = ColorSequence.new(Theme.GradientStart, Theme.GradientEnd);
        v25.Rotation = Theme.GradientRotation;
        v25.Enabled = true;
    end;
end;

local Color3_fromRGB_ret3 = Color3.fromRGB(80, 80, 80);

local function ApplyStateVisuals(p26: userdata, p27: string, p28: any) -- Line: 126
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy)
    local Claim_Frame = p26:FindFirstChild("Claim_Frame");
    local v29;

    if Claim_Frame then
        v29 = Claim_Frame:FindFirstChildWhichIsA("ImageButton") or Claim_Frame:FindFirstChildWhichIsA("TextButton");
    else
        v29 = Claim_Frame;
    end;

    local v30;

    if Claim_Frame then
        v30 = Claim_Frame:FindFirstChildWhichIsA("UIGradient");
    else
        v30 = Claim_Frame;
    end;

    local v31 = p26:FindFirstChildWhichIsA("UIStroke");
    local v32 = p26:FindFirstChildWhichIsA("UIGradient");

    if p27 == "completed" then
        if v31 then
            v31.Color = Color3_fromRGB_ret;
        end;

        if v32 then
            v32.Enabled = false;
        end;

        p26.BackgroundColor3 = Color3_fromRGB_ret;

        if v30 then
            v30.Enabled = false;
        end;

        if Claim_Frame then
            Claim_Frame.BackgroundColor3 = Color3_fromRGB_ret;
        end;

        if v29 then
            v29.AutoButtonColor = false;
        end;

        local Achievement_Name = p26:FindFirstChild("Achievement_Name");

        if Achievement_Name then
            Achievement_Name.TextColor3 = Color3_fromRGB_ret2;
        end;

        local Task_Text = p26:FindFirstChild("Task_Text");

        if Task_Text then
            Task_Text.TextColor3 = Color3_fromRGB_ret2;
        end;
    elseif p27 == "claimable" then
        if p28 and v31 then
            v31.Color = p28.StrokeColor;
        end;

        if v32 then
            v32.Enabled = true;
        end;

        if v30 then
            v30.Enabled = true;
        end;

        if v29 then
            v29.AutoButtonColor = true;
        end;

        if Claim_Frame then
            Claim_Frame.BackgroundColor3 = Color3.new(1, 1, 1);
        end;

        local Achievement_Name = p26:FindFirstChild("Achievement_Name");

        if Achievement_Name then
            Achievement_Name.TextColor3 = Color3.new(1, 1, 1);
        end;

        local Task_Text = p26:FindFirstChild("Task_Text");

        if Task_Text then
            Task_Text.TextColor3 = Color3.new(1, 1, 1);
        end;
    else
        if p28 and v31 then
            v31.Color = p28.StrokeColor;
        end;

        if v32 then
            v32.Enabled = true;
        end;

        if v30 then
            v30.Enabled = false;
        end;

        if Claim_Frame then
            Claim_Frame.BackgroundColor3 = Color3_fromRGB_ret3;
        end;

        if v29 then
            v29.AutoButtonColor = false;
        end;

        local Achievement_Name = p26:FindFirstChild("Achievement_Name");

        if Achievement_Name then
            Achievement_Name.TextColor3 = Color3.new(1, 1, 1);
        end;

        local Task_Text = p26:FindFirstChild("Task_Text");

        if Task_Text then
            Task_Text.TextColor3 = Color3.new(1, 1, 1);
        end;
    end;
end;

local function PopulateEntry(p33: userdata, p34: any, p35: string, p36: number?) -- Line: 188
    -- upvalues: AchievementData (copy), u2 (ref), ApplyTheme (copy), ApplyStateVisuals (copy)
    local Theme = AchievementData.GetTheme(p34);
    local v37 = (u2 and u2.Data.Stats or {})[p34.Stat] or 0;
    local Achievement_Name = p33:FindFirstChild("Achievement_Name");

    if Achievement_Name then
        Achievement_Name.Text = AchievementData.FormatName(p34, p36);
    end;

    local Task_Text = p33:FindFirstChild("Task_Text");

    if Task_Text then
        Task_Text.Text = AchievementData.GetTaskLabel(p34);
    end;

    local Progress_Text = p33:FindFirstChild("Progress_Text");

    if Progress_Text then
        Progress_Text.Text = AchievementData.FormatProgress(p34, v37, p36);
    end;

    local Reward_Text = p33:FindFirstChild("Reward_Text");

    if Reward_Text then
        Reward_Text.Text = AchievementData.FormatAllRewards(p34, p36);
    end;

    local Claim_Frame = p33:FindFirstChild("Claim_Frame");
    local v38 = Claim_Frame and (Claim_Frame:FindFirstChildWhichIsA("ImageButton") or Claim_Frame:FindFirstChildWhichIsA("TextButton"));

    if v38 then
        local v39 = p35 == "completed" and "DONE" or (p35 == "claimable" and "CLAIM" or "LOCKED");
        local v40 = v38:FindFirstChildWhichIsA("TextLabel");

        if v40 then
            v40.Text = v39;
        elseif v38:IsA("TextButton") then
            v38.Text = v39;
        end;
    end;

    ApplyTheme(p33, p34);
    ApplyStateVisuals(p33, p35, Theme);
    local v41 = 0;

    for i, v in AchievementData.Categories do
        if v.Key == p34.Category then
            v41 = i;
            break;
        end;
    end;

    p33.LayoutOrder = (p35 == "claimable" and 0 or (p35 == "locked" and 1 or 2)) * 1000000 + v41 * 10000 + (p34.Target or (p34.StartsAfter or 0));
end;

local function BuildEntries() -- Line: 253
    -- upvalues: u9 (copy), u2 (ref), AchievementData (copy), u10 (ref), u7 (ref), PopulateEntry (copy), u6 (ref)
    for _, v in u9 do
        if v.Frame and v.Frame.Parent then
            v.Frame:Destroy();
        end;
    end;

    table.clear(u9);
    local v42 = u2 and u2.Data.Stats or {};
    local v43 = u2 and u2.Data.Achievements;
    local v44 = v43 and v43.Claimed or {};
    local v45 = u2 and u2.Data.Achievements;
    local v46 = v45 and v45.InfiniteTiers or {};

    for _, v in AchievementData.ChainOrder do
        local CurrentChainStep, v47, v48 = AchievementData.GetCurrentChainStep(v, v42, v44, v46);

        if CurrentChainStep and (not u10 or CurrentChainStep.Category == u10) then
            local v49 = u7:Clone();
            v49.Name = v;
            v49.Visible = true;
            PopulateEntry(v49, CurrentChainStep, v47, v48);
            local Claim_Frame = v49:FindFirstChild("Claim_Frame");
            local v50 = Claim_Frame and (Claim_Frame:FindFirstChildWhichIsA("ImageButton") or Claim_Frame:FindFirstChildWhichIsA("TextButton"));

            if v50 then
                v50.MouseButton1Click:Connect(function() -- Line: 289
                    -- upvalues: v (copy)
                    OnClaimPressed(v);
                end);
            end;

            v49.Parent = u6;
            u9[v] = {
                Frame = v49,
                CurrentAch = CurrentChainStep,
                InfiniteTier = v48
            };
        end;
    end;
end;

local function RefreshEntries() -- Line: 305
    -- upvalues: u2 (ref), u9 (copy), AchievementData (copy), PopulateEntry (copy)
    local v51 = u2 and u2.Data.Stats or {};
    local v52 = u2 and u2.Data.Achievements;
    local v53 = v52 and v52.Claimed or {};
    local v54 = u2 and u2.Data.Achievements;
    local v55 = v54 and v54.InfiniteTiers or {};

    for i, v in u9 do
        local CurrentChainStep, v56, v57 = AchievementData.GetCurrentChainStep(i, v51, v53, v55);

        if CurrentChainStep then
            v.CurrentAch = CurrentChainStep;
            v.InfiniteTier = v57;
            PopulateEntry(v.Frame, CurrentChainStep, v56, v57);
        end;
    end;
end;

local function RefreshEntriesForStat(p58: string) -- Line: 323
    -- upvalues: u2 (ref), AchievementData (copy), u9 (copy), PopulateEntry (copy)
    local v59 = u2 and u2.Data.Stats or {};
    local v60 = u2 and u2.Data.Achievements;
    local v61 = v60 and v60.Claimed or {};
    local v62 = u2 and u2.Data.Achievements;
    local v63 = v62 and v62.InfiniteTiers or {};
    local ByStat = AchievementData.GetByStat(p58);

    if not ByStat then
        return;
    end;

    local v64 = {};

    for _, v in ByStat do
        if v.Chain then
            v64[v.Chain] = true;
        end;
    end;

    for i in v64 do
        local v65 = u9[i];

        if v65 and (v65.Frame and v65.Frame.Parent) then
            local CurrentChainStep, v66, v67 = AchievementData.GetCurrentChainStep(i, v59, v61, v63);

            if CurrentChainStep then
                v65.CurrentAch = CurrentChainStep;
                v65.InfiniteTier = v67;
                PopulateEntry(v65.Frame, CurrentChainStep, v66, v67);
            end;
        end;
    end;
end;

function OnClaimPressed(p68: string)
    -- upvalues: u11 (ref), u9 (copy), u2 (ref), AchievementData (copy), u3 (ref), u4 (ref), RefreshEntries (copy)
    if u11 then
        return;
    end;

    local v69 = u9[p68];

    if not v69 then
        return;
    end;

    local v70 = u2 and u2.Data.Stats or {};
    local v71 = u2 and u2.Data.Achievements;
    local v72 = v71 and v71.Claimed or {};
    local v73 = u2 and u2.Data.Achievements;
    local CurrentChainStep, v74, v75 = AchievementData.GetCurrentChainStep(p68, v70, v72, v73 and v73.InfiniteTiers or {});

    if v74 ~= "claimable" then
        return;
    end;

    u11 = true;

    if v69.Frame then
        local Claim_Frame = v69.Frame:FindFirstChild("Claim_Frame");
        local v76 = Claim_Frame and (Claim_Frame:FindFirstChildWhichIsA("ImageButton") or Claim_Frame:FindFirstChildWhichIsA("TextButton"));

        if v76 then
            local v77 = v76:FindFirstChildWhichIsA("TextLabel");

            if v77 then
                v77.Text = "...";
            elseif v76:IsA("TextButton") then
                v76.Text = "...";
            end;
        end;
    end;

    local v78, _ = u3:ClaimAchievement(CurrentChainStep.Id, v75);

    if v78 then
        pcall(function() -- Line: 391
            -- upvalues: u4 (ref)
            u4:Play("GiftReceived");
        end);

        if v69.Frame then
            FlashEntry(v69.Frame, Color3.fromRGB(80, 255, 80));
        end;
    end;

    RefreshEntries();
    UpdateClaimAllButton();
    UpdateBadge();
    u11 = false;
end;

local function OnClaimAllPressed() -- Line: 408
    -- upvalues: u11 (ref), CountUnclaimed (copy), u8 (ref), u3 (ref), u4 (ref), RefreshEntries (copy)
    if u11 then
        return;
    end;

    if CountUnclaimed() == 0 then
        return;
    end;

    u11 = true;
    local v79 = u8 and u8:FindFirstChildWhichIsA("TextLabel");

    if v79 then
        v79.Text = "Claiming...";
    end;

    local v80 = u3:ClaimAll();

    if v80 and v80 > 0 then
        pcall(function() -- Line: 422
            -- upvalues: u4 (ref)
            u4:Play("GiftReceived");
        end);
    end;

    RefreshEntries();
    UpdateClaimAllButton();
    UpdateBadge();
    u11 = false;
end;

function FlashEntry(p81: userdata, p82)
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
    local u83 = p81:FindFirstChildWhichIsA("UIStroke");

    if not u83 then
        return;
    end;

    local Color = u83.Color;
    u83.Color = p82;
    task.delay(0.3, function() -- Line: 443
        -- upvalues: u83 (copy), TweenService (ref), TweenInfo_new_ret (ref), Color (copy)
        if u83 and u83.Parent then
            TweenService:Create(u83, TweenInfo_new_ret, {
                Color = Color
            }):Play();
        end;
    end);
end;

function UpdateBadge()
    -- upvalues: CountUnclaimed (copy), u1 (ref), TweenService (copy), TweenInfo_new_ret2 (copy)
    local v84 = CountUnclaimed();
    local v85 = u1.HUD:FindFirstChild("Left") and u1.HUD.Left:FindFirstChild("Achievements");
    local v86 = u1.HUD:FindFirstChild("Right") and u1.HUD.Right:FindFirstChild("Achievements");
    local v87 = v85 or v86;
    local v88 = v87 and v87:FindFirstChild("Badge");

    if v88 then
        if v84 > 0 then
            v88.Visible = true;
            local v89 = v88:FindFirstChildWhichIsA("TextLabel");

            if v89 then
                v89.Text = tostring(v84);
            end;

            v88.Size = UDim2.fromScale(0, 0);
            TweenService:Create(v88, TweenInfo_new_ret2, {
                Size = v88:GetAttribute("OriginalSize") or UDim2.fromOffset(24, 24)
            }):Play();

            return;
        end;

        v88.Visible = false;
    end;
end;

function UpdateClaimAllButton()
    -- upvalues: u8 (ref), CountUnclaimed (copy)
    if not u8 then
        return;
    end;

    local v90 = CountUnclaimed();
    local v91 = u8:FindFirstChildWhichIsA("TextLabel");

    if v90 > 0 then
        u8.AutoButtonColor = true;

        if v91 then
            v91.Text = `Claim All ({v90})`;
        end;
    else
        u8.AutoButtonColor = false;

        if v91 then
            v91.Text = "Nothing to Claim";
        end;
    end;
end;

local function SetupCategoryTabs() -- Line: 494
    -- upvalues: u5 (ref), u10 (ref), BuildEntries (copy), AchievementData (copy)
    local u92 = u5:FindFirstChild("Tabs") or u5:FindFirstChild("Categories");

    if not u92 then
        return;
    end;

    local Template = u92:FindFirstChild("Template");

    if not Template then
        return;
    end;

    Template.Visible = false;
    local v93 = Template:Clone();
    v93.Name = "All";
    v93.Visible = true;
    v93.LayoutOrder = 0;
    local v94 = v93:FindFirstChildWhichIsA("TextLabel") or v93:FindFirstChildWhichIsA("TextButton");

    if v94 then
        v94.Text = "All";
    end;

    local v95 = v93:FindFirstChildWhichIsA("ImageButton") or (v93:FindFirstChildWhichIsA("TextButton") or v93);

    if v95 then
        v95.MouseButton1Click:Connect(function() -- Line: 514
            -- upvalues: u10 (ref), BuildEntries (ref), u92 (copy)
            u10 = nil;
            BuildEntries();
            UpdateClaimAllButton();
            HighlightActiveTab(u92, "All");
        end);
    end;

    v93.Parent = u92;

    for i, v in AchievementData.Categories do
        local v96 = Template:Clone();
        v96.Name = v.Key;
        v96.Visible = true;
        v96.LayoutOrder = i;
        local v97 = v96:FindFirstChildWhichIsA("TextLabel") or v96:FindFirstChildWhichIsA("TextButton");

        if v97 then
            v97.Text = v.Label;
        end;

        local v98 = AchievementData.CategoryThemes[v.Key];
        local v99 = v98 and v96:FindFirstChildWhichIsA("UIStroke");

        if v99 then
            v99.Color = v98.AccentColor;
        end;

        local v100 = v96:FindFirstChildWhichIsA("ImageButton") or (v96:FindFirstChildWhichIsA("TextButton") or v96);

        if v100 then
            v100.MouseButton1Click:Connect(function() -- Line: 540
                -- upvalues: u10 (ref), v (copy), BuildEntries (ref), u92 (copy)
                u10 = v.Key;
                BuildEntries();
                UpdateClaimAllButton();
                HighlightActiveTab(u92, v.Key);
            end);
        end;

        v96.Parent = u92;
    end;
end;

function HighlightActiveTab(p101: any, p102: string)
    for _, child in p101:GetChildren() do
        if child:IsA("GuiObject") and child.Name ~= "Template" then
            local v103 = child.Name == p102;
            child.BackgroundTransparency = v103 and 0 or 0.5;
            local v104 = child:FindFirstChildWhichIsA("TextLabel");

            if v104 then
                v104.Font = v103 and Enum.Font.GothamBold or Enum.Font.Gotham;
            end;
        end;
    end;
end;

local function ConnectServerSignals() -- Line: 568
    -- upvalues: u3 (ref), RefreshEntriesForStat (copy), RefreshEntries (copy)
    u3.StatUpdated:Connect(function(p105) -- Line: 569
        -- upvalues: RefreshEntriesForStat (ref)
        if not (p105 and p105.StatKey) then
            return;
        end;

        RefreshEntriesForStat(p105.StatKey);
        UpdateClaimAllButton();
        UpdateBadge();
    end);
    u3.AchievementReady:Connect(function(p106) -- Line: 576
        -- upvalues: RefreshEntries (ref)
        if not p106 then
            return;
        end;

        RefreshEntries();
        UpdateClaimAllButton();
        UpdateBadge();
    end);
    u3.AchievementClaimed:Connect(function(p107) -- Line: 584
        -- upvalues: RefreshEntries (ref)
        if not p107 then
            return;
        end;

        RefreshEntries();
        UpdateClaimAllButton();
        UpdateBadge();
    end);
end;

local function ConnectDataListener() -- Line: 595
    -- upvalues: u2 (ref), u5 (ref), RefreshEntries (copy)
    u2:OnChange(function(p108, p109, p110, p111) -- Line: 596
        -- upvalues: u5 (ref), RefreshEntries (ref)
        if not (u5 and u5.Visible) then
            return;
        end;

        if (p109[1] == "Stats" or p109[1] == "Achievements") and true or p109[1] == "PermanentBoosts" then
            RefreshEntries();
            UpdateClaimAllButton();
            UpdateBadge();
        end;
    end);
end;

return {
    _Init = function(p112) -- Line: 615, Name: _Init
        -- upvalues: u1 (ref), u2 (ref), Registry (copy), u3 (ref), Knit (copy), u4 (ref), u5 (ref), u7 (ref), u6 (ref), u8 (ref), OnClaimAllPressed (copy), SetupCategoryTabs (copy), BuildEntries (copy), ConnectServerSignals (copy), RefreshEntries (copy)
        u1 = p112;
        u2 = Registry:Get("PlayerData");
        u3 = Knit.GetService("AchievementService");
        u4 = Knit.GetController("SoundController");
        u5 = u1.Frames:WaitForChild("Achievements");
        local Body = u5:WaitForChild("Body");
        u7 = Body:WaitForChild("Template");
        u7.Visible = false;
        u6 = Body:IsA("ScrollingFrame") and Body and Body or (Body:FindFirstChildWhichIsA("ScrollingFrame") or Body);
        local ClaimAll_Frame = u5:FindFirstChild("ClaimAll_Frame");
        u8 = ClaimAll_Frame and (ClaimAll_Frame:FindFirstChildWhichIsA("ImageButton") or ClaimAll_Frame:FindFirstChildWhichIsA("TextButton"));

        if u8 then
            u8.MouseButton1Click:Connect(function() -- Line: 637
                -- upvalues: OnClaimAllPressed (ref)
                OnClaimAllPressed();
            end);
        end;

        SetupCategoryTabs();
        BuildEntries();
        UpdateClaimAllButton();
        UpdateBadge();
        ConnectServerSignals();
        u2:OnChange(function(p113, p114, p115, p116) -- Line: 596
            -- upvalues: u5 (ref), RefreshEntries (ref)
            if not (u5 and u5.Visible) then
                return;
            end;

            if (p114[1] == "Stats" or p114[1] == "Achievements") and true or p114[1] == "PermanentBoosts" then
                RefreshEntries();
                UpdateClaimAllButton();
                UpdateBadge();
            end;
        end);
        u5:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 658
            -- upvalues: u5 (ref), RefreshEntries (ref)
            if u5.Visible then
                RefreshEntries();
                UpdateClaimAllButton();
                UpdateBadge();
            end;
        end);
        warn("[AchievementController] Initialized — chain-based display");
    end
};