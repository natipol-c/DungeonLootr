--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     RewardRevealController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.RewardRevealController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local RewardCardRender = require(script.Parent.Parent.ClientUtils.RewardCardRender);
local TweenInfo_new_ret = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local TweenInfo_new_ret3 = TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local u1 = { "Title", "Header", "Heading", "Complete" };
local v2 = Knit.CreateController({
    Name = "RewardRevealController"
});
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = 0;

local function clearCards() -- Line: 86
    -- upvalues: u4 (ref)
    if not u4 then
        return;
    end;

    for _, child in u4:GetChildren() do
        if child.Name == "RewardCard" then
            child:Destroy();
        end;
    end;
end;

local function ensureLayout() -- Line: 98
    -- upvalues: u4 (ref)
    if not u4 then
        return;
    end;

    local v8 = u4:FindFirstChildWhichIsA("UIGridStyleLayout");

    if v8 then
        v8.SortOrder = Enum.SortOrder.LayoutOrder;

        return;
    end;

    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 12);
    UIListLayout.Parent = u4;
end;

local function setHeader(p9: string?) -- Line: 115
    -- upvalues: u3 (ref), u1 (copy)
    if not u3 then
        return;
    end;

    for _, v in u1 do
        local v10 = u3:FindFirstChild(v, true);

        if v10 and v10:IsA("TextLabel") then
            v10.Text = p9 or "";

            return;
        end;
    end;
end;

local function showGroup() -- Line: 126
    -- upvalues: u3 (ref), TweenService (copy), TweenInfo_new_ret (copy)
    if not u3 then
        return;
    end;

    u3.GroupTransparency = 1;
    u3.Visible = true;
    TweenService:Create(u3, TweenInfo_new_ret, {
        GroupTransparency = 0
    }):Play();
end;

local function hideGroup() -- Line: 134
    -- upvalues: u3 (ref), TweenService (copy), TweenInfo_new_ret2 (copy), clearCards (copy)
    if not u3 then
        return;
    end;

    local v11 = TweenService:Create(u3, TweenInfo_new_ret2, {
        GroupTransparency = 1
    });
    v11:Play();
    v11.Completed:Wait();
    u3.Visible = false;
    clearCards();
end;

local function popIn(p12: userdata, p13: number) -- Line: 144
    -- upvalues: u4 (ref), TweenService (copy), TweenInfo_new_ret3 (copy)
    p12.Name = "RewardCard";
    p12.Visible = true;
    p12.LayoutOrder = p13;

    if p12:IsA("GuiButton") then
        p12.Active = false;
        p12.AutoButtonColor = false;
    end;

    local v14 = p12:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    v14.Scale = 0.5;
    v14.Parent = p12;
    p12.Parent = u4;
    TweenService:Create(v14, TweenInfo_new_ret3, {
        Scale = 1
    }):Play();
end;

local function playCardSfx() -- Line: 160
    -- upvalues: u6 (ref)
    if not u6 then
        return;
    end;

    u6:Play("UI_LegendaryChest");
end;

local function runCascade(p15: table, p16: string?) -- Line: 172
    -- upvalues: u3 (ref), u4 (ref), u5 (ref), u7 (ref), clearCards (copy), RewardCardRender (copy), setHeader (copy), TweenService (copy), TweenInfo_new_ret (copy), popIn (copy), u6 (ref), hideGroup (copy)
    if not (u3 and (u4 and u5)) then
        return;
    end;

    u7 = u7 + 1;
    local v17 = u7;
    clearCards();
    local v18 = {};

    for _, v in p15 do
        if RewardCardRender.isRenderable(v) then
            table.insert(v18, v);
        end;
    end;

    if #v18 == 0 then
        return;
    end;

    setHeader(p16);

    if u3 then
        u3.GroupTransparency = 1;
        u3.Visible = true;
        TweenService:Create(u3, TweenInfo_new_ret, {
            GroupTransparency = 0
        }):Play();
    end;

    for i, v in v18 do
        if v17 ~= u7 then
            return;
        end;

        local v19 = u5:Clone();

        if RewardCardRender.populateRewardCard(v19, v) then
            popIn(v19, i);

            if u6 then
                u6:Play("UI_LegendaryChest");
            end;

            task.wait(0.15);
        else
            v19:Destroy();
        end;
    end;

    if v17 ~= u7 then
        return;
    end;

    task.wait(2);

    if v17 ~= u7 then
        return;
    end;

    hideGroup();
end;

function v2.PlayEntries(p20: table, p21: table, p22: string?) -- Line: 218
    -- upvalues: u3 (ref), u4 (ref), u5 (ref), runCascade (copy)
    if type(p21) ~= "table" then
        return false;
    end;

    if not (u3 and (u4 and u5)) then
        return false;
    end;

    task.spawn(runCascade, p21, p22);

    return true;
end;

function v2.KnitStart(p23) -- Line: 229
    -- upvalues: Knit (copy), u3 (ref), u4 (ref), u5 (ref), u6 (ref), ensureLayout (copy)
    local TopLevel = Knit.PlayerGui:WaitForChild("TopLevel", 10);

    if not TopLevel then
        warn("[RewardRevealController] StarterGui.TopLevel not found — reward reveal inert");

        return;
    end;

    local RewardReveal = TopLevel:FindFirstChild("RewardReveal", true);

    if not (RewardReveal and RewardReveal:IsA("CanvasGroup")) then
        warn("[RewardRevealController] TopLevel.RewardReveal (CanvasGroup) not found — reward reveal inert");

        return;
    end;

    u3 = RewardReveal;
    local RewardsFrame = RewardReveal:FindFirstChild("RewardsFrame", true);

    if not (RewardsFrame and RewardsFrame:IsA("GuiObject")) then
        warn("[RewardRevealController] RewardReveal.RewardsFrame not found — reward reveal inert");

        return;
    end;

    u4 = RewardsFrame;
    local ItemsTemplate = RewardsFrame:FindFirstChild("ItemsTemplate", true);

    if not (ItemsTemplate and ItemsTemplate:IsA("GuiObject")) then
        warn("[RewardRevealController] RewardsFrame.ItemsTemplate not found — reward reveal inert");

        return;
    end;

    u5 = ItemsTemplate;
    u5.Visible = false;
    local success, result = pcall(Knit.GetController, "SoundController");

    if success then
        u6 = result;
    end;

    ensureLayout();
    u3.GroupTransparency = 1;
    u3.Visible = false;
end;

return v2;