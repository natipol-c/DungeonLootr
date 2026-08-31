--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Quests
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.Quests
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = nil;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local GameInfo = ReplicatedStorage:WaitForChild("GameInfo");
local QuestData = require(GameInfo:WaitForChild("QuestData"));
local Registry = require(script.Parent.Parent.Controllers.Registry);
local Knit = require(ReplicatedStorage.Packages.Knit);
local UIController = require(script.Parent.Parent.Controllers.UIController);
local v3 = {};
local u4 = nil;
local u5 = {
    Easy = "RestlessPlayer",
    Medium = "Epic",
    Hard = "Mythic"
};
local u6 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Rarity_Gradients");
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = {};
local u12 = {};
local u13 = {};
local u14 = {};
local u15 = nil;
local u16 = nil;

local function SetGradientPairState(p17: userdata, p18: boolean) -- Line: 104
    for _, v in { "Background", "Outline" } do
        local v19 = p17:FindFirstChild(v);

        if v19 then
            local Active = v19:FindFirstChild("Active");
            local Inactive = v19:FindFirstChild("Inactive");

            if Active then
                Active.Enabled = p18;
            end;

            if Inactive then
                Inactive.Enabled = not p18;
            end;
        end;
    end;
end;

local function ApplyDifficultyGradient(p20: userdata, p21: string?) -- Line: 117
    -- upvalues: u5 (copy), u6 (copy)
    local Background = p20:FindFirstChild("Background");

    if Background then
        Background = Background:FindFirstChild("UIStroke");
    end;

    if Background then
        Background = Background:FindFirstChild("RarityGradient");
    end;

    if not Background then
        return;
    end;

    local v22 = u5[p21 or "Easy"];
    local v23 = u6;

    if v23 then
        if v22 then
            v22 = u6:FindFirstChild(v22);
        end;
    else
        v22 = v23;
    end;

    if v22 then
        Background.Color = v22.Color;
    end;
end;

local function UpdateQuestCell(p24: any, p25: number) -- Line: 136
    -- upvalues: u13 (copy), u15 (ref), ApplyDifficultyGradient (copy), SetGradientPairState (copy)
    local v26 = u13[p24.Id];

    if v26 then
        v26 = v26[p25];
    end;

    if not v26 then
        return;
    end;

    local Slot = p24.GetSlot(p25);

    if not Slot or (not Slot.QuestId or Slot.QuestId == "") then
        v26.Visible = false;

        return;
    end;

    local Def = p24.GetDef(Slot.QuestId);

    if not Def then
        warn("[Quests UI] Unknown quest ID:", Slot.QuestId);
        v26.Visible = false;

        return;
    end;

    v26.Visible = p24.Id == u15;
    local v27 = Slot.Progress or 0;
    local v28 = Def.Target or 1;
    local v29 = Slot.Claimed or false;
    local v30 = Slot.Completed or false;
    local Title = v26:FindFirstChild("Title");

    if Title then
        Title.Text = Def.Objective or "";
    end;

    local Sub = v26:FindFirstChild("Sub");

    if Sub then
        Sub.Text = Def.Name or "";
    end;

    local Reward_Amount = v26:FindFirstChild("Reward_Amount");

    if Reward_Amount then
        Reward_Amount.Text = p24.GetRewardText(Def);
    end;

    local ProgressBar = v26:FindFirstChild("ProgressBar");

    if ProgressBar then
        local math_min_ret = math.min(v27, v28);
        local Progress = ProgressBar:FindFirstChild("Progress");

        if Progress then
            Progress.Text = `{math_min_ret}/{v28}`;
        end;

        local Fill = ProgressBar:FindFirstChild("Fill");

        if Fill then
            local v31 = (v30 or v29) and 1 or math.clamp(v27 / v28, 0, 1);
            Fill.Size = UDim2.new(v31, 0, Fill.Size.Y.Scale, Fill.Size.Y.Offset);
        end;
    end;

    ApplyDifficultyGradient(v26, Def.Difficulty);
    local Incomplete = v26:FindFirstChild("Incomplete");

    if Incomplete then
        Incomplete.Visible = not (v30 or v29);
    end;

    local Complete = v26:FindFirstChild("Complete");

    if Complete then
        Complete.Visible = v30 or v29;
        local TextLabel = Complete:FindFirstChild("TextLabel");

        if TextLabel then
            TextLabel.Text = v29 and "Claimed" or "Claim";
        end;

        if v30 then
            v30 = not v29;
        end;

        SetGradientPairState(Complete, v30);
    end;
end;

local function UpdateCategory(p32) -- Line: 205
    -- upvalues: UpdateQuestCell (copy)
    for i = 1, p32.SlotCount do
        UpdateQuestCell(p32, i);
        local _ = i;
    end;
end;

local function AnyClaimable() -- Line: 212
    -- upvalues: u11 (ref)
    for _, v in ipairs(u11) do
        local v33 = v;

        for i = 1, v.SlotCount do
            local Slot = v33.GetSlot(i);

            if Slot and (Slot.Completed and not Slot.Claimed) then
                return true;
            end;

            local _ = i;
        end;
    end;

    return false;
end;

local function BuildCategory(u34) -- Line: 230
    -- upvalues: u9 (ref), u10 (ref), u13 (copy), Knit (copy)
    if not (u9 and u10) then
        return;
    end;

    local v35 = {};
    u13[u34.Id] = v35;

    for i = 1, u34.SlotCount do
        local v36 = u10:Clone();
        v36.Name = `Quest_{u34.Id}_{i}`;
        v36.LayoutOrder = i;
        v36.Visible = false;
        local Complete = v36:FindFirstChild("Complete");

        if Complete then
            Complete.MouseButton1Click:Connect(function() -- Line: 244
                -- upvalues: u34 (copy), i (copy), Knit (ref)
                local Slot = u34.GetSlot(i);

                if not Slot or (not Slot.Completed or Slot.Claimed) then
                    return;
                end;

                local v37, v38 = u34.Claim(i);

                if v37 and v38 then
                    Knit.GetController("SoundController"):Play("Ting");
                end;
            end);
        end;

        v36.Parent = u9;
        v35[i] = v36;
        local _ = i;
    end;
end;

local function UpdateTabVisuals() -- Line: 265
    -- upvalues: u14 (copy), SetGradientPairState (copy), u15 (ref)
    for i, v in pairs(u14) do
        SetGradientPairState(v, i == u15);
    end;
end;

local function SetActiveCategory(p39: string) -- Line: 274
    -- upvalues: u12 (ref), u15 (ref), u13 (copy), u14 (copy), SetGradientPairState (copy), UpdateQuestCell (copy)
    local v40 = u12[p39];

    if not v40 then
        return;
    end;

    u15 = p39;

    for i, v in pairs(u13) do
        if i ~= p39 then
            for _, v2 in pairs(v) do
                v2.Visible = false;
            end;
        end;
    end;

    for i, v in pairs(u14) do
        SetGradientPairState(v, i == u15);
    end;

    for i = 1, v40.SlotCount do
        UpdateQuestCell(v40, i);
        local _ = i;
    end;
end;

local function FormatTime(p41: number) -- Line: 298
    local math_floor_ret = math.floor(p41);
    local math_max_ret = math.max(0, math_floor_ret);
    local math_floor_ret2 = math.floor(math_max_ret / 86400);
    local math_floor_ret3 = math.floor(math_max_ret % 86400 / 3600);
    local math_floor_ret4 = math.floor(math_max_ret % 3600 / 60);

    if math_floor_ret2 > 0 then
        return `{math_floor_ret2}d {math_floor_ret3}h`;
    end;

    if math_floor_ret3 > 0 then
        return `{math_floor_ret3}h {math_floor_ret4}m`;
    end;

    return string.format("%d:%02d", math_floor_ret4, math_max_ret % 60);
end;

local function StartRefreshTimer() -- Line: 313
    -- upvalues: u16 (ref), RunService (copy), u8 (ref), u12 (ref), u15 (ref), FormatTime (copy)
    if u16 then
        u16:Disconnect();
        u16 = nil;
    end;

    u16 = RunService.Heartbeat:Connect(function() -- Line: 319
        -- upvalues: u8 (ref), u12 (ref), u15 (ref), FormatTime (ref)
        if not u8 then
            return;
        end;

        local v42 = u12[u15];

        if not v42 then
            return;
        end;

        if v42.Placeholder then
            u8.Text = "";

            return;
        end;

        local RefreshRemaining = v42.GetRefreshRemaining();

        if RefreshRemaining and RefreshRemaining > 0 then
            u8.Text = `New Quests in: {FormatTime(RefreshRemaining)}`;

            return;
        end;

        u8.Text = "Refreshing...";
    end);
end;

local function BuildCategories() -- Line: 348
    -- upvalues: Knit (copy), QuestData (copy), u2 (ref), u11 (ref), u12 (ref)
    local Service = Knit.GetService("QuestService");

    local function makeCategory(u43: string) -- Line: 352
        -- upvalues: QuestData (ref), u2 (ref), Service (copy)
        return {
            Id = u43,
            TabName = u43,
            SlotCount = QuestData.Categories[u43].Slots,

            GetSlot = function(p44: number) -- Line: 358, Name: GetSlot
                -- upvalues: u2 (ref), u43 (copy)
                local Quests = u2.Data.Quests;

                if Quests then
                    Quests = Quests[u43];
                end;

                return Quests and Quests.Active and Quests.Active[p44];
            end,

            GetDef = function(p45: string) -- Line: 364, Name: GetDef
                -- upvalues: QuestData (ref)
                return QuestData.GetQuestById(p45);
            end,

            GetRewardText = function(p46) -- Line: 368, Name: GetRewardText
                -- upvalues: QuestData (ref)
                return QuestData.GetRewardDisplayText(p46.Reward);
            end,

            Claim = function(p47: number) -- Line: 372, Name: Claim
                -- upvalues: Service (ref), u43 (copy)
                return Service:ClaimQuest(u43, p47):await();
            end,

            GetRefreshRemaining = function() -- Line: 377, Name: GetRefreshRemaining
                -- upvalues: QuestData (ref), u43 (copy)
                return QuestData.SecondsUntilNextWindow(u43);
            end
        };
    end;

    u11 = {
        makeCategory("Daily"),
        makeCategory("Weekly"),
        {
            Id = "Limited",
            TabName = "Limited",
            SlotCount = 0,
            Placeholder = true,

            GetSlot = function() -- Line: 390, Name: GetSlot
                return nil;
            end,

            GetDef = function() -- Line: 391, Name: GetDef
                return nil;
            end,

            GetRewardText = function() -- Line: 392, Name: GetRewardText
                return "";
            end,

            Claim = function() -- Line: 393, Name: Claim
                return false, false;
            end,

            GetRefreshRemaining = function() -- Line: 394, Name: GetRefreshRemaining
                return nil;
            end
        }
    };
    u12 = {};

    for _, v in ipairs(u11) do
        u12[v.Id] = v;
    end;
end;

local function ResolveQuestNotice() -- Line: 412
    -- upvalues: u1 (ref), u7 (ref)
    local Actions = u1.HUD:FindFirstChild("Actions");

    if Actions then
        Actions = Actions:FindFirstChild("Right");
    end;

    if Actions then
        Actions = Actions:FindFirstChild("Buttons");
    end;

    if Actions then
        Actions = Actions:FindFirstChild("Quests");
    end;

    if Actions then
        Actions = Actions:FindFirstChild("Notice", true);
    end;

    if Actions then
        return Actions;
    end;

    local v48 = u7 and u7:FindFirstChild("Notice");

    if v48 then
        return v48;
    end;

    local Left = u1.HUD:FindFirstChild("Left");

    if Left then
        Left = Left:FindFirstChild("Quests");
    end;

    if Left then
        Left = Left:FindFirstChild("Notice_Icon");
    end;

    return Left;
end;

function v3.HasClaimable() -- Line: 435
    -- upvalues: AnyClaimable (copy)
    return AnyClaimable();
end;

function v3._Init(p49) -- Line: 443
    -- upvalues: u1 (ref), u7 (ref), u4 (ref), Knit (copy), u2 (ref), Registry (copy), UIController (copy), u8 (ref), u9 (ref), u10 (ref), BuildCategories (copy), u11 (ref), BuildCategory (copy), u14 (copy), SetActiveCategory (copy), ResolveQuestNotice (copy), AnyClaimable (copy), UpdateQuestCell (copy), u16 (ref), RunService (copy), u12 (ref), u15 (ref), FormatTime (copy)
    u1 = p49;
    u7 = u1.Frames:FindFirstChild("Quests");

    if not u7 then
        warn("[Quests UI] Main.Frames.Quests not found — UI not built in Studio yet");

        return;
    end;

    u4 = Knit.GetController("NoticeController");
    u2 = Registry:Get("PlayerData");

    if not u2 then
        warn("[Quests UI] PlayerData not available");

        return;
    end;

    u7.Visible = false;
    local v50 = UIController._cached[u7];

    if v50 then
        v50.isOpen = false;
    end;

    local Content = u7:FindFirstChild("Content");
    local v51;

    if Content then
        v51 = Content:FindFirstChild("Time");
    else
        v51 = Content;
    end;

    u8 = v51;
    local v52;

    if Content then
        v52 = Content:FindFirstChild("ScrollingFrame");
    else
        v52 = Content;
    end;

    u9 = v52;
    local v53 = u9 and u9:FindFirstChild("Quest_Template");
    u10 = v53;

    if u10 then
        u10.Visible = false;
    end;

    if not u10 then
        warn("[Quests UI] Content.ScrollingFrame.Quest_Template missing — no cards built");

        return;
    end;

    BuildCategories();

    for _, v in ipairs(u11) do
        BuildCategory(v);
    end;

    if Content then
        Content = Content:FindFirstChild("Tabs");
    end;

    if Content then
        for _, v in ipairs(u11) do
            local v54 = Content:FindFirstChild(v.Id);

            if v54 and v54:IsA("GuiButton") then
                u14[v.Id] = v54;
                v54.MouseButton1Click:Connect(function() -- Line: 495
                    -- upvalues: SetActiveCategory (ref), v (copy)
                    SetActiveCategory(v.Id);
                end);
            else
                warn((`[Quests UI] Content.Tabs.{v.Id} button missing`));
            end;
        end;
    else
        warn("[Quests UI] Content.Tabs missing — tab switching disabled");
    end;

    SetActiveCategory(u11[1].Id);
    local v55 = ResolveQuestNotice();

    if v55 then
        u4:Register("Quests", v55, AnyClaimable);
    else
        warn("[Quests] No Notice image found (Actions.Right.Buttons.Quests.Notice / Frames.Quests.Notice / legacy) — claimable-quest notice disabled");
    end;

    u2:OnChange(function(p56, p57) -- Line: 518
        -- upvalues: u11 (ref), UpdateQuestCell (ref), u4 (ref)
        if p57[1] == "Quests" then
            for _, v in ipairs(u11) do
                local v58 = v;

                for i = 1, v.SlotCount do
                    UpdateQuestCell(v58, i);
                    local _ = i;
                end;
            end;

            u4:Update("Quests");
        end;
    end);

    if u16 then
        u16:Disconnect();
        u16 = nil;
    end;

    u16 = RunService.Heartbeat:Connect(function() -- Line: 319
        -- upvalues: u8 (ref), u12 (ref), u15 (ref), FormatTime (ref)
        if not u8 then
            return;
        end;

        local v59 = u12[u15];

        if not v59 then
            return;
        end;

        if v59.Placeholder then
            u8.Text = "";

            return;
        end;

        local RefreshRemaining = v59.GetRefreshRemaining();

        if RefreshRemaining and RefreshRemaining > 0 then
            u8.Text = `New Quests in: {FormatTime(RefreshRemaining)}`;

            return;
        end;

        u8.Text = "Refreshing...";
    end);
end;

return v3;