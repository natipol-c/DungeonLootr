--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Battlepass
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.Battlepass
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
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local GameInfo = ReplicatedStorage:WaitForChild("GameInfo");
local BattlepassData = require(GameInfo:WaitForChild("BattlepassData"));
local EmoteData = require(GameInfo:WaitForChild("EmoteData"));
local Image_Data = require(GameInfo:WaitForChild("Image_Data"));
local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local StarBurst = require(ReplicatedStorage.Modules.StarBurst);
local Cosmetic_Manager = require(ReplicatedStorage.Globals.Modules.Cosmetic_Manager);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local Knit = require(ReplicatedStorage.Packages.Knit);
local UIController = require(script.Parent.Parent.Controllers.UIController);
local v3 = {};
local u4 = nil;
local u5 = nil;
local u6 = {
    frame = nil,
    questsFrame = nil,
    totalLevel = nil,
    expAmount = nil,
    profileIncomplete = nil,
    profileComplete = nil,
    barFill = nil,
    classicUnlocked = nil,
    premiumUnlocked = nil,
    premiumBuy = nil,
    content = nil,
    template = nil,
    nextBtn = nil,
    backBtn = nil,
    showcase = nil,
    questNotice = nil,
    questTimerLabel = nil,
    questScroll = nil,
    questTemplate = nil
};
local u7 = {};
local u8 = {};
local u9 = 0;
local u10 = "Free";
local u11 = 0;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local CHECKPOINT_INTERVAL = BattlepassData.CHECKPOINT_INTERVAL;

local function GetBP() -- Line: 131
    -- upvalues: u2 (ref)
    if u2 then
        return u2.Data.Battlepass;
    end;

    return nil;
end;

local function IsTierClaimed(p15: number, p16: string) -- Line: 136
    -- upvalues: u2 (ref)
    local v17;

    if u2 then
        v17 = u2.Data.Battlepass;
    else
        v17 = nil;
    end;

    if not v17 then
        return false;
    end;

    local v18 = p16 == "Premium" and v17.ClaimedPremium or v17.ClaimedFree;

    if v18 then
        v18 = table.find(v18, p15) ~= nil;
    end;

    return v18;
end;

local function FormatTime(p19: number) -- Line: 143
    local math_floor_ret = math.floor(p19 / 3600);
    local math_floor_ret2 = math.floor(p19 % 3600 / 60);
    local math_floor_ret3 = math.floor(p19 % 60);

    if math_floor_ret > 0 then
        return string.format("%dh %02dm", math_floor_ret, math_floor_ret2);
    end;

    return string.format("%dm %02ds", math_floor_ret2, math_floor_ret3);
end;

local function GetRewardIcon(p20: table) -- Line: 155
    -- upvalues: Image_Data (copy), GameInfo (copy)
    local Type = p20.Type;

    if Type == "Coins" then
        return Image_Data.Rewards.Cash;
    end;

    if Type == "Stars" then
        return Image_Data.Rewards.Stars;
    end;

    if Type == "NormalSpins" then
        return Image_Data.Rewards.NormalSpins;
    end;

    if Type == "LuckySpins" then
        return Image_Data.Rewards.LuckySpins;
    end;

    if Type == "ClassEXPPotion" then
        return Image_Data.Potions.ClassXPEssence;
    end;

    if Type == "Equipment" then
        local Id = p20.Id;

        return Id and Image_Data.Equipment[Id] or nil;
    end;

    if Type == "ClassItem" then
        local Id = p20.Id;

        if not Id then
            return nil;
        end;

        local v21 = Image_Data.Class_Items or {};
        local v22 = v21[string.gsub(Id, "%s", "")];

        if not v22 then
            local v23 = require(GameInfo:WaitForChild("ClassItemData")).Get(Id);

            if v23 and v23.ClassName then
                v22 = v21[string.gsub(v23.ClassName, "%s", "")];
            end;
        end;

        return v22;
    end;

    if Type == "Title" then
        return Image_Data.Rewards.Title;
    end;

    if Type == "Package" then
        local v24 = require(GameInfo:WaitForChild("PackageData")).Get(p20.Id);

        return v24 and v24.Icon or nil;
    end;

    if Type ~= "CraftingMaterial" then
        if Type ~= "BuffPotion" then
            return nil;
        end;

        local BuffPotionData = require(GameInfo:WaitForChild("BuffPotionData"));
        local v25 = p20.Id and BuffPotionData.GetPotion(p20.Id);

        return v25 and v25.Icon or nil;
    end;

    local ItemData = require(GameInfo:WaitForChild("ItemData"));
    local v26 = p20.Id and ItemData.Index[p20.Id];

    if v26 then
        v26 = v26.Icon;
    end;

    if v26 == "" or not v26 then
        v26 = nil;
    end;

    return v26;
end;

local CFrame_new_ret = CFrame.new(Vector3.new(0, 0.5, -12), Vector3.new(0, 0.5, 0));
local CFrame_new_ret2 = CFrame.new(0, 0.5, 0);
local u27 = {};

local function CloneLocalCharacter() -- Line: 223
    -- upvalues: Players (copy)
    local Character = Players.LocalPlayer.Character;

    if not Character then
        return nil;
    end;

    local v28 = {};

    for _, descendant in Character:GetDescendants() do
        if not descendant.Archivable then
            descendant.Archivable = true;
            table.insert(v28, descendant);
        end;
    end;

    local Archivable = Character.Archivable;
    Character.Archivable = true;
    local v29 = Character:Clone();
    Character.Archivable = Archivable;

    for _, v in v28 do
        v.Archivable = false;
    end;

    for _, descendant in v29:GetDescendants() do
        if descendant:IsA("BaseScript") or (descendant:IsA("Tool") or (descendant:IsA("ForceField") or (descendant:IsA("BillboardGui") or descendant.Name == "Holder"))) then
            descendant:Destroy();
        end;
    end;

    return v29;
end;

local function ClearViewportRender(p30: userdata) -- Line: 252
    for _, child in p30:GetChildren() do
        if child:IsA("WorldModel") or (child:IsA("Camera") or child:IsA("Model")) then
            child:Destroy();
        end;
    end;
end;

local function RenderEmoteInViewport(p31: userdata, p32: string) -- Line: 263
    -- upvalues: ClearViewportRender (copy), CloneLocalCharacter (copy), Cosmetic_Manager (copy), CFrame_new_ret2 (copy), CFrame_new_ret (copy), EmoteData (copy), u6 (copy), u27 (copy)
    ClearViewportRender(p31);
    local v33 = CloneLocalCharacter();

    if not v33 then
        return;
    end;

    pcall(Cosmetic_Manager.ClearAll, v33);
    local WorldModel = Instance.new("WorldModel");
    WorldModel.Name = "CharacterWorld";
    WorldModel.Parent = p31;
    local HumanoidRootPart = v33:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        v33.PrimaryPart = HumanoidRootPart;
    end;

    v33:PivotTo(CFrame_new_ret2);
    v33.Parent = WorldModel;
    local v34 = p31:FindFirstChildOfClass("Camera") or Instance.new("Camera");
    v34.FieldOfView = 30;
    v34.CFrame = CFrame_new_ret;
    v34.Parent = p31;
    p31.CurrentCamera = v34;
    local v35 = v33:FindFirstChildOfClass("Humanoid");

    if not v35 then
        return;
    end;

    local u36 = v35:FindFirstChildOfClass("Animator");

    if not u36 then
        u36 = Instance.new("Animator");
        u36.Parent = v35;
    end;

    local Animation = EmoteData.GetAnimation(p32);

    if not Animation then
        return;
    end;

    local success, result = pcall(function() -- Line: 304
        -- upvalues: u36 (ref), Animation (copy)
        return u36:LoadAnimation(Animation);
    end);

    if success and result then
        result.Priority = Enum.AnimationPriority.Action4;
        result.Looped = true;
        result:Play();

        if not (u6.frame and u6.frame.Visible) then
            result:AdjustSpeed(0);
        end;

        table.insert(u27, result);
    end;
end;

local function FillRewardSide(p37: userdata, p38: any) -- Line: 321
    -- upvalues: RenderEmoteInViewport (copy), ClearViewportRender (copy), GetRewardIcon (copy), BattlepassData (copy), SharedUtils (copy)
    local Holder = p37:FindFirstChild("Holder");
    local v39;

    if Holder then
        v39 = Holder:FindFirstChild("ItemImage");
    else
        v39 = Holder;
    end;

    if Holder then
        Holder = Holder:FindFirstChild("Amount");
    end;

    local ItemName = p37:FindFirstChild("ItemName");
    local ViewportFrame = p37:FindFirstChild("ViewportFrame");

    if p38 and p38.Type == "Emote" then
        if v39 then
            v39.Visible = false;
        end;

        if ViewportFrame then
            ViewportFrame.Visible = true;
            RenderEmoteInViewport(ViewportFrame, p38.Id);
        end;
    else
        if ViewportFrame then
            ViewportFrame.Visible = false;
            ClearViewportRender(ViewportFrame);
        end;

        if v39 then
            local v40;

            if p38 then
                v40 = GetRewardIcon(p38);
            else
                v40 = p38;
            end;

            v39.Image = v40 or "";
            v39.Visible = v40 ~= nil;
        end;
    end;

    local v41, v42;

    if p38 then
        v41, v42 = BattlepassData.GetRewardNameAndCount(p38);
    else
        v41 = "";
        v42 = 1;
    end;

    if ItemName then
        ItemName.Text = v41;
    end;

    if Holder then
        Holder.Text = "x" .. SharedUtils.AbbreviateNumber(v42);
        Holder.Visible = v42 > 1;
    end;
end;

local function UpdateCellState(p43: userdata, p44: number) -- Line: 370
    -- upvalues: u2 (ref)
    local v45;

    if u2 then
        v45 = u2.Data.Battlepass;
    else
        v45 = nil;
    end;

    local v46 = v45 and v45.HasPremium or false;
    local v47 = p44 <= (v45 and (v45.Tier or 0) or 0);
    local Main = p43.Container.Main;
    local Free = Main:FindFirstChild("Free");

    if Free then
        local v48;

        if u2 then
            v48 = u2.Data.Battlepass;
        else
            v48 = nil;
        end;

        local v49;

        if v48 then
            v49 = v48.ClaimedFree;

            if v49 then
                v49 = table.find(v49, p44) ~= nil;
            end;
        else
            v49 = false;
        end;

        local Claim = Free:FindFirstChild("Claim");
        local Locked = Free:FindFirstChild("Locked");
        local Lock = Free:FindFirstChild("Lock");
        local Claimed = Free:FindFirstChild("Claimed");

        if Claim then
            local v50;

            if v47 then
                v50 = not v49;
            else
                v50 = v47;
            end;

            Claim.Visible = v50;
        end;

        if Claimed then
            Claimed.Visible = v49;
        end;

        if Locked then
            Locked.Visible = false;
        end;

        if Lock then
            Lock.Visible = not v47;
        end;
    end;

    local Premium = Main:FindFirstChild("Premium");

    if Premium then
        local v51;

        if u2 then
            v51 = u2.Data.Battlepass;
        else
            v51 = nil;
        end;

        local v52;

        if v51 then
            v52 = v51.ClaimedPremium or v51.ClaimedFree;

            if v52 then
                v52 = table.find(v52, p44) ~= nil;
            end;
        else
            v52 = false;
        end;

        local Claim = Premium:FindFirstChild("Claim");
        local Lock = Premium:FindFirstChild("Lock");
        local Claimed = Premium:FindFirstChild("Claimed");
        local Buy = Premium:FindFirstChild("Buy");

        if Buy then
            Buy.Visible = false;
        end;

        if Claim then
            local v53;

            if v46 then
                if v47 then
                    v53 = not v52;
                else
                    v53 = v47;
                end;
            else
                v53 = v46;
            end;

            Claim.Visible = v53;
        end;

        if Claimed then
            Claimed.Visible = v52;
        end;

        if Lock then
            Lock.Visible = not (v46 and v47);
        end;
    end;
end;

local function UpdateAllCells() -- Line: 414
    -- upvalues: u7 (copy), UpdateCellState (copy)
    for i, v in pairs(u7) do
        UpdateCellState(v, i);
    end;
end;

local function BuildTrack() -- Line: 424
    -- upvalues: u6 (copy), u7 (copy), u27 (copy), BattlepassData (copy), CHECKPOINT_INTERVAL (copy), FillRewardSide (copy), u4 (ref), StarBurst (copy), u2 (ref), UpdateCellState (copy)
    if not (u6.content and u6.template) then
        return;
    end;

    for _, v in pairs(u7) do
        v:Destroy();
    end;

    table.clear(u7);
    table.clear(u27);

    for i = 1, BattlepassData.MAX_TIER do
        local v54 = u6.template:Clone();
        v54.Name = "Tier_" .. i;
        v54.LayoutOrder = i;
        v54.Visible = true;
        local Container = v54.Container;
        local Level = Container:FindFirstChild("Level");

        if Level then
            Level.Text = tostring(i);
        end;

        local Checkpoint = Container:FindFirstChild("Checkpoint");

        if Checkpoint then
            Checkpoint.Visible = i % CHECKPOINT_INTERVAL == 0;
        end;

        local Main = Container.Main;
        local Free = Main:FindFirstChild("Free");

        if Free then
            FillRewardSide(Free, BattlepassData.GetTierReward(i, "Free"));

            local function claimFree() -- Line: 460
                -- upvalues: u4 (ref), i (copy), StarBurst (ref)
                local v55, v56 = u4:ClaimReward(i, "Free");

                if v55 and v56 then
                    StarBurst.AtMouse();
                end;
            end;

            local Claim = Free:FindFirstChild("Claim");

            if Claim then
                Claim.MouseButton1Click:Connect(claimFree);
            end;

            local Invisible_Claim = Free:FindFirstChild("Invisible_Claim");

            if Invisible_Claim then
                Invisible_Claim.MouseButton1Click:Connect(claimFree);
            end;
        end;

        local Premium = Main:FindFirstChild("Premium");

        if Premium then
            FillRewardSide(Premium, BattlepassData.GetTierReward(i, "Premium"));

            local function claimPremium() -- Line: 480
                -- upvalues: u4 (ref), i (copy), StarBurst (ref)
                local v57, v58 = u4:ClaimReward(i, "Premium");

                if v57 and v58 then
                    StarBurst.AtMouse();
                end;
            end;

            local Claim = Premium:FindFirstChild("Claim");

            if Claim then
                Claim.MouseButton1Click:Connect(claimPremium);
            end;

            local Invisible_Claim = Premium:FindFirstChild("Invisible_Claim");

            if Invisible_Claim then
                Invisible_Claim.MouseButton1Click:Connect(function() -- Line: 495
                    -- upvalues: u2 (ref), u4 (ref), i (copy), StarBurst (ref)
                    local v59;

                    if u2 then
                        v59 = u2.Data.Battlepass;
                    else
                        v59 = nil;
                    end;

                    if not (v59 and v59.HasPremium) then
                        u4:PromptPremiumPurchase();

                        return;
                    end;

                    local v60, v61 = u4:ClaimReward(i, "Premium");

                    if v60 and v61 then
                        StarBurst.AtMouse();
                    end;
                end);
            end;
        end;

        UpdateCellState(v54, i);
        v54.Parent = u6.content;
        u7[i] = v54;
        local _ = i;
    end;
end;

local function GetTrackMetrics() -- Line: 520
    -- upvalues: u7 (copy), u6 (copy)
    local v62 = u7[1];
    local v63 = u7[2];

    if not (v62 and v63) then
        return nil;
    end;

    local v64 = v63.AbsolutePosition.X - v62.AbsolutePosition.X;

    if v64 <= 0 then
        return nil;
    end;

    return v62.AbsolutePosition.X - u6.content.AbsolutePosition.X + u6.content.CanvasPosition.X, v64;
end;

local function GetLeftmostVisibleTier() -- Line: 534
    -- upvalues: u7 (copy), u6 (copy), BattlepassData (copy)
    local v65 = u7[1];
    local v66 = u7[2];
    local v67, v68;

    if v65 and v66 then
        v67 = v66.AbsolutePosition.X - v65.AbsolutePosition.X;

        if v67 <= 0 then
            v68 = nil;
            v67 = nil;
        else
            v68 = v65.AbsolutePosition.X - u6.content.AbsolutePosition.X + u6.content.CanvasPosition.X;
        end;
    else
        v68 = nil;
        v67 = nil;
    end;

    if not v68 then
        return 1;
    end;

    local v69 = math.floor((u6.content.CanvasPosition.X - v68) / v67) + 1;

    return math.clamp(v69, 1, BattlepassData.MAX_TIER);
end;

local function UpdateShowcase() -- Line: 546
    -- upvalues: u6 (copy), u9 (ref), u10 (ref), u2 (ref), BattlepassData (copy), GetRewardIcon (copy), RarityColors (copy)
    local showcase = u6.showcase;

    if not showcase or u9 < 1 then
        return;
    end;

    local v70 = u9;
    local v71 = u10;
    local v72;

    if u2 then
        v72 = u2.Data.Battlepass;
    else
        v72 = nil;
    end;

    local v73 = v72 and v72.HasPremium or false;
    local v74 = v70 <= (v72 and (v72.Tier or 0) or 0);
    local v75;

    if u2 then
        v75 = u2.Data.Battlepass;
    else
        v75 = nil;
    end;

    local v76;

    if v75 then
        v76 = v71 == "Premium" and v75.ClaimedPremium or v75.ClaimedFree;

        if v76 then
            v76 = table.find(v76, v70) ~= nil;
        end;
    else
        v76 = false;
    end;

    local v77;

    if v71 == "Premium" then
        v77 = not v73;
    else
        v77 = false;
    end;

    local TierReward = BattlepassData.GetTierReward(v70, v71);
    local v78 = BattlepassData.Checkpoints[v70];

    if v78 then
        v78 = v78[v71];
    end;

    local Title = showcase:FindFirstChild("Title");

    if Title then
        Title.Text = v78 and v78.Title or (TierReward and (BattlepassData.GetRewardName(TierReward) or "???") or "???");
    end;

    local Category = showcase:FindFirstChild("Category");

    if Category then
        Category.Text = v78 and v78.Category or (TierReward and (TierReward.Type or "") or "");
    end;

    local Description = showcase:FindFirstChild("Description");

    if Description then
        Description.Text = v78 and (v78.Description or "") or "";
    end;

    local Icon = showcase:FindFirstChild("Icon");

    if Icon then
        if TierReward then
            TierReward = GetRewardIcon(TierReward);
        end;

        Icon.Image = TierReward or "";
        Icon.Visible = TierReward ~= nil;
    end;

    local Rarity = showcase:FindFirstChild("Rarity");

    if Rarity then
        local v79 = v78 and v78.Rarity or "Rare";
        local Name = Rarity:FindFirstChild("Name");

        if Name then
            Name.Text = v79;
        end;

        local v80 = Rarity:FindFirstChildOfClass("UIGradient");
        local v81 = v79 == "Celestial";

        if v80 then
            v80.Enabled = v81;
        end;

        local v82 = RarityColors[v79];

        if v81 or not v82 then
            Rarity.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        else
            Rarity.BackgroundColor3 = v82.BackgroundColor3;
        end;
    end;

    local Locked_Frame = showcase:FindFirstChild("Locked_Frame");

    if Locked_Frame then
        Locked_Frame.Visible = not v74 or v77;
        local Requirement = Locked_Frame:FindFirstChild("Requirement");

        if Requirement then
            Requirement.Text = v74 and "Requires Premium Pass" or "Reach Level " .. v70;
        end;
    end;

    local Claimed_Frame = showcase:FindFirstChild("Claimed_Frame");

    if Claimed_Frame then
        Claimed_Frame.Visible = v76;
    end;

    local Claim_Frame = showcase:FindFirstChild("Claim_Frame");

    if Claim_Frame then
        Claim_Frame.Visible = v74 and not v76 and not v77;
    end;
end;

local function RefreshCheckpointFromScroll() -- Line: 632
    -- upvalues: BattlepassData (copy), u7 (copy), u6 (copy), u9 (ref), u10 (ref), u11 (ref), UpdateShowcase (copy)
    local GetCheckpointForLevel = BattlepassData.GetCheckpointForLevel;
    local v83 = u7[1];
    local v84 = u7[2];
    local v85, v86;

    if v83 and v84 then
        v85 = v84.AbsolutePosition.X - v83.AbsolutePosition.X;

        if v85 <= 0 then
            v86 = nil;
            v85 = nil;
        else
            v86 = v83.AbsolutePosition.X - u6.content.AbsolutePosition.X + u6.content.CanvasPosition.X;
        end;
    else
        v86 = nil;
        v85 = nil;
    end;

    local v87;

    if v86 then
        local v88 = math.floor((u6.content.CanvasPosition.X - v86) / v85) + 1;
        v87 = math.clamp(v88, 1, BattlepassData.MAX_TIER);
    else
        v87 = 1;
    end;

    local v89 = GetCheckpointForLevel(v87);

    if v89 ~= u9 then
        u9 = v89;
        u10 = "Free";
        u11 = 0;
        UpdateShowcase();
    end;
end;

local function StartShowcaseSwap() -- Line: 644
    -- upvalues: u12 (ref), RunService (copy), u6 (copy), u10 (ref), u11 (ref), UpdateShowcase (copy)
    if u12 then
        u12:Disconnect();
    end;

    local u90 = false;
    u12 = RunService.Heartbeat:Connect(function(p91) -- Line: 650
        -- upvalues: u6 (ref), u10 (ref), u11 (ref), u90 (ref), UpdateShowcase (ref)
        if u6.frame and u6.frame.Visible then
            if not u90 then
                u90 = true;
                UpdateShowcase();
            end;

            u11 = u11 + p91;

            if u11 >= 8 then
                u11 = 0;
                u10 = u10 == "Free" and "Premium" or "Free";
                UpdateShowcase();
            end;

            return;
        end;

        u10 = "Free";
        u11 = 0;
        u90 = false;
    end);
end;

local function ScrollToNextCheckpoint() -- Line: 676
    -- upvalues: u7 (copy), u6 (copy), u9 (ref), CHECKPOINT_INTERVAL (copy), BattlepassData (copy), u14 (ref), TweenService (copy)
    local v92 = u7[1];
    local v93 = u7[2];
    local u94, u95;

    if v92 and v93 then
        u94 = v93.AbsolutePosition.X - v92.AbsolutePosition.X;

        if u94 <= 0 then
            u95 = nil;
            u94 = nil;
        else
            u95 = v92.AbsolutePosition.X - u6.content.AbsolutePosition.X + u6.content.CanvasPosition.X;
        end;
    else
        u95 = nil;
        u94 = nil;
    end;

    if not u95 then
        return;
    end;

    local content = u6.content;
    local X = content.AbsoluteWindowSize.X;
    local math_max_ret = math.max(u9, CHECKPOINT_INTERVAL);

    local function cellRightEdge(p96: number) -- Line: 684
        -- upvalues: u95 (copy), u94 (copy)
        return u95 + (p96 - 1) * u94 + u94;
    end;

    if u95 + (math_max_ret - 1) * u94 + u94 <= content.CanvasPosition.X + X + 1 then
        math_max_ret = math.min(math_max_ret + CHECKPOINT_INTERVAL, BattlepassData.MAX_TIER);
    end;

    local math_max_ret2 = math.max(content.AbsoluteCanvasSize.X - X, 0);
    local math_clamp_ret = math.clamp(u95 + (math_max_ret - 1) * u94 + u94 - X, 0, math_max_ret2);

    if u14 then
        u14:Cancel();
    end;

    u14 = TweenService:Create(content, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        CanvasPosition = Vector2.new(math_clamp_ret, 0)
    });
    u14:Play();
end;

local function ScrollToPrevCheckpoint() -- Line: 708
    -- upvalues: u7 (copy), u6 (copy), CHECKPOINT_INTERVAL (copy), BattlepassData (copy), u14 (ref), TweenService (copy)
    local v97 = u7[1];
    local v98 = u7[2];
    local v99, v100;

    if v97 and v98 then
        v99 = v98.AbsolutePosition.X - v97.AbsolutePosition.X;

        if v99 <= 0 then
            v100 = nil;
            v99 = nil;
        else
            v100 = v97.AbsolutePosition.X - u6.content.AbsolutePosition.X + u6.content.CanvasPosition.X;
        end;
    else
        v100 = nil;
        v99 = nil;
    end;

    if not v100 then
        return;
    end;

    local content = u6.content;
    local X = content.AbsoluteWindowSize.X;
    local math_max_ret = math.max(content.AbsoluteCanvasSize.X - X, 0);
    local X2 = content.CanvasPosition.X;
    local v101 = 0;

    for i = CHECKPOINT_INTERVAL, BattlepassData.MAX_TIER, CHECKPOINT_INTERVAL do
        local math_clamp_ret = math.clamp(v100 + i * v99 - X, 0, math_max_ret);
        local v102;

        if math_clamp_ret < X2 - 1 then
            v101 = math.max(v101, math_clamp_ret);
            v102 = i;
        else
            v102 = i;
        end;
    end;

    if u14 then
        u14:Cancel();
    end;

    u14 = TweenService:Create(content, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        CanvasPosition = Vector2.new(v101, 0)
    });
    u14:Play();
end;

local function UpdateHeader() -- Line: 739
    -- upvalues: u2 (ref), BattlepassData (copy), u6 (copy), SharedUtils (copy)
    local v103;

    if u2 then
        v103 = u2.Data.Battlepass;
    else
        v103 = nil;
    end;

    local v104 = v103 and (v103.Tier or 0) or 0;
    local v105 = v103 and v103.XP or 0;
    local XPForTier = BattlepassData.GetXPForTier(v104 + 1);

    if u6.totalLevel then
        u6.totalLevel.Text = tostring(v104);
    end;

    if u6.expAmount then
        u6.expAmount.Text = SharedUtils.FormatWithCommas(v105) .. "/" .. SharedUtils.FormatWithCommas(XPForTier);
    end;

    if u6.barFill then
        local v106 = XPForTier > 0 and math.clamp(v105 / XPForTier, 0, 1) or 0;
        u6.barFill.Size = UDim2.new(v106, 0, u6.barFill.Size.Y.Scale, u6.barFill.Size.Y.Offset);
    end;

    local v107 = BattlepassData.MAX_TIER <= v104;

    if u6.profileIncomplete then
        u6.profileIncomplete.Enabled = not v107;
    end;

    if u6.profileComplete then
        u6.profileComplete.Enabled = v107;
    end;
end;

local function UpdatePremiumPanel() -- Line: 768
    -- upvalues: u2 (ref), u6 (copy)
    local v108;

    if u2 then
        v108 = u2.Data.Battlepass;
    else
        v108 = nil;
    end;

    local v109 = v108 and v108.HasPremium or false;

    if u6.classicUnlocked then
        u6.classicUnlocked.Visible = true;
    end;

    if u6.premiumUnlocked then
        u6.premiumUnlocked.Visible = v109;
    end;

    if u6.premiumBuy then
        u6.premiumBuy.Visible = not v109;
    end;
end;

local function SetCompleteButtonState(p110: userdata, p111: boolean) -- Line: 784
    for _, v in { "Background", "Outline" } do
        local v112 = p110:FindFirstChild(v);

        if v112 then
            local Active = v112:FindFirstChild("Active");
            local Inactive = v112:FindFirstChild("Inactive");

            if Active then
                Active.Enabled = p111;
            end;

            if Inactive then
                Inactive.Enabled = not p111;
            end;
        end;
    end;
end;

local function UpdateBPQuestFrame(p113: number) -- Line: 796
    -- upvalues: u8 (copy), u2 (ref), BattlepassData (copy), SharedUtils (copy), ReplicatedStorage (copy), SetCompleteButtonState (copy)
    local v114 = u8[p113];

    if not v114 then
        return;
    end;

    local v115;

    if u2 then
        v115 = u2.Data.Battlepass;
    else
        v115 = nil;
    end;

    if not (v115 and v115.Quests) then
        return;
    end;

    local v116 = v115.Quests[p113];

    if not v116 or (not v116.QuestId or v116.QuestId == "") then
        v114.Visible = false;

        return;
    end;

    local QuestById = BattlepassData.GetQuestById(v116.QuestId);

    if not QuestById then
        warn("[Battlepass UI] Unknown BP quest ID:", v116.QuestId);
        v114.Visible = false;

        return;
    end;

    v114.Visible = true;
    local v117 = v116.Progress or 0;
    local v118 = QuestById.Target or 1;
    local v119 = v116.Claimed or false;
    local v120 = v116.Completed or false;
    local Title = v114:FindFirstChild("Title");

    if Title then
        Title.Text = QuestById.Objective or "";
    end;

    local Sub = v114:FindFirstChild("Sub");

    if Sub then
        Sub.Text = QuestById.Name or "";
    end;

    local Reward_Amount = v114:FindFirstChild("Reward_Amount");

    if Reward_Amount then
        Reward_Amount.Text = `{QuestById.BPXPReward or 0} EXP`;
    end;

    local ProgressBar = v114:FindFirstChild("ProgressBar");

    if ProgressBar then
        local math_min_ret = math.min(v117, v118);
        local Progress = ProgressBar:FindFirstChild("Progress");

        if Progress then
            Progress.Text = SharedUtils.AbbreviateNumber(math_min_ret) .. "/" .. SharedUtils.AbbreviateNumber(v118);
        end;

        local Fill = ProgressBar:FindFirstChild("Fill");

        if Fill then
            local v121 = (v120 or v119) and 1 or math.clamp(v117 / v118, 0, 1);
            Fill.Size = UDim2.new(v121, 0, Fill.Size.Y.Scale, Fill.Size.Y.Offset);
        end;
    end;

    local v122 = BattlepassData.QuestDifficulty[QuestById.Difficulty or "Easy"];
    local v123 = v114:FindFirstChild("Background") and v114.Background:FindFirstChild("UIStroke");

    if v123 then
        v123 = v123:FindFirstChild("RarityGradient");
    end;

    if v123 and v122 then
        local v124 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Rarity_Gradients");

        if v124 then
            v124 = v124:FindFirstChild(v122.Gradient);
        end;

        if v124 then
            v123.Color = v124.Color;
        end;
    end;

    local Incomplete = v114:FindFirstChild("Incomplete");

    if Incomplete then
        Incomplete.Visible = not (v120 or v119);
    end;

    local Complete = v114:FindFirstChild("Complete");

    if Complete then
        Complete.Visible = v120 or v119;
        local TextLabel = Complete:FindFirstChild("TextLabel");

        if TextLabel then
            TextLabel.Text = v119 and "Claimed" or "Claim";
        end;

        if v120 then
            v120 = not v119;
        end;

        SetCompleteButtonState(Complete, v120);
    end;
end;

local function UpdateQuestNotice() -- Line: 879
    -- upvalues: u6 (copy), u2 (ref)
    if not u6.questNotice then
        return;
    end;

    local v125 = false;
    local v126;

    if u2 then
        v126 = u2.Data.Battlepass;
    else
        v126 = nil;
    end;

    if v126 and v126.Quests then
        for _, v in ipairs(v126.Quests) do
            if v.Completed and not v.Claimed then
                v125 = true;
                break;
            end;
        end;
    end;

    u6.questNotice.Visible = v125;
end;

local function UpdateAllBPQuests() -- Line: 896
    -- upvalues: BattlepassData (copy), UpdateBPQuestFrame (copy), UpdateQuestNotice (copy)
    for i = 1, BattlepassData.DAILY_QUEST_COUNT do
        UpdateBPQuestFrame(i);
        local _ = i;
    end;

    UpdateQuestNotice();
end;

local function BuildQuestList() -- Line: 904
    -- upvalues: u6 (copy), u8 (copy), Knit (copy), BattlepassData (copy), u2 (ref), StarBurst (copy)
    if not (u6.questScroll and u6.questTemplate) then
        return;
    end;

    for _, v in pairs(u8) do
        v:Destroy();
    end;

    table.clear(u8);
    local Service = Knit.GetService("BattlepassService");

    for i = 1, BattlepassData.DAILY_QUEST_COUNT do
        local v127 = u6.questTemplate:Clone();
        v127.Name = "Quest_" .. i;
        v127.LayoutOrder = i;
        v127.Visible = false;
        local Complete = v127:FindFirstChild("Complete");

        if Complete then
            Complete.MouseButton1Click:Connect(function() -- Line: 922
                -- upvalues: u2 (ref), i (copy), Service (copy), Knit (ref), StarBurst (ref)
                local v128;

                if u2 then
                    v128 = u2.Data.Battlepass;
                else
                    v128 = nil;
                end;

                local v129 = v128 and v128.Quests and v128.Quests[i];

                if not v129 or (not v129.Completed or v129.Claimed) then
                    return;
                end;

                local v130, v131 = Service:ClaimQuest(i):await();

                if v130 and v131 then
                    Knit.GetController("SoundController"):Play("Ting");
                    StarBurst.AtMouse();
                end;
            end);
        end;

        v127.Parent = u6.questScroll;
        u8[i] = v127;
        local _ = i;
    end;
end;

local function StartQuestTimer() -- Line: 947
    -- upvalues: u13 (ref), RunService (copy), u6 (copy), BattlepassData (copy), FormatTime (copy)
    if u13 then
        u13:Disconnect();
    end;

    u13 = RunService.Heartbeat:Connect(function() -- Line: 952
        -- upvalues: u6 (ref), BattlepassData (ref), FormatTime (ref)
        if not u6.questTimerLabel then
            return;
        end;

        local v132 = BattlepassData.SecondsUntilNextWindow();
        u6.questTimerLabel.Text = "New Quests in: " .. FormatTime(v132);
    end);
end;

local function SwitchToQuests() -- Line: 963
    -- upvalues: u6 (copy)
    if u6.frame then
        u6.frame.Visible = false;
    end;

    if u6.questsFrame then
        u6.questsFrame.Visible = true;
    end;
end;

local function SwitchToPass() -- Line: 968
    -- upvalues: u6 (copy)
    if u6.questsFrame then
        u6.questsFrame.Visible = false;
    end;

    if u6.frame then
        u6.frame.Visible = true;
    end;
end;

local function RefreshAll() -- Line: 977
    -- upvalues: UpdateHeader (copy), u2 (ref), u6 (copy), u7 (copy), UpdateCellState (copy), UpdateShowcase (copy), BattlepassData (copy), UpdateBPQuestFrame (copy), UpdateQuestNotice (copy)
    UpdateHeader();
    local v133;

    if u2 then
        v133 = u2.Data.Battlepass;
    else
        v133 = nil;
    end;

    local v134 = v133 and v133.HasPremium or false;

    if u6.classicUnlocked then
        u6.classicUnlocked.Visible = true;
    end;

    if u6.premiumUnlocked then
        u6.premiumUnlocked.Visible = v134;
    end;

    if u6.premiumBuy then
        u6.premiumBuy.Visible = not v134;
    end;

    for i, v in pairs(u7) do
        UpdateCellState(v, i);
    end;

    UpdateShowcase();

    for i = 1, BattlepassData.DAILY_QUEST_COUNT do
        UpdateBPQuestFrame(i);
        local _ = i;
    end;

    UpdateQuestNotice();
end;

local function HasClaimableNotice() -- Line: 993
    -- upvalues: u2 (ref), BattlepassData (copy)
    local v135;

    if u2 then
        v135 = u2.Data.Battlepass;
    else
        v135 = nil;
    end;

    if not v135 then
        return false;
    end;

    if v135.Quests then
        for _, v in ipairs(v135.Quests) do
            if v.Completed and not v.Claimed then
                return true;
            end;
        end;
    end;

    local v136 = v135.Tier or 0;

    for i = 1, math.min(v136, BattlepassData.MAX_TIER) do
        if not table.find(v135.ClaimedFree or {}, i) then
            return true;
        end;

        local _ = i;
    end;

    if v135.HasPremium then
        for i = 1, math.min(v136, BattlepassData.MAX_TIER) do
            if not table.find(v135.ClaimedPremium or {}, i) then
                return true;
            end;

            local _ = i;
        end;
    end;

    return false;
end;

function v3.HasNotice() -- Line: 1025
    -- upvalues: HasClaimableNotice (copy)
    return HasClaimableNotice();
end;

function v3._Init(p137) -- Line: 1029
    -- upvalues: u1 (ref), u2 (ref), Registry (copy), u4 (ref), Knit (copy), u5 (ref), u6 (copy), UIController (copy), BattlepassData (copy), StarBurst (copy), ScrollToNextCheckpoint (copy), ScrollToPrevCheckpoint (copy), SwitchToQuests (copy), u9 (ref), u10 (ref), SwitchToPass (copy), BuildQuestList (copy), BuildTrack (copy), RefreshCheckpointFromScroll (copy), u7 (copy), UpdateShowcase (copy), u12 (ref), RunService (copy), u11 (ref), u27 (copy), u13 (ref), FormatTime (copy), UpdateHeader (copy), UpdateCellState (copy), UpdateBPQuestFrame (copy), UpdateQuestNotice (copy), HasClaimableNotice (copy)
    u1 = p137;
    u2 = Registry:Get("PlayerData");

    if not u2 then
        warn("[Battlepass UI] PlayerData not available");

        return;
    end;

    u4 = Knit.GetController("BattlepassController");
    u5 = Knit.GetController("NoticeController");
    local Frames = u1:FindFirstChild("Frames");
    local v138;

    if Frames then
        v138 = Frames:FindFirstChild("Battlepass");
    else
        v138 = Frames;
    end;

    u6.frame = v138;

    if Frames then
        Frames = Frames:FindFirstChild("Battlepass_Quests");
    end;

    u6.questsFrame = Frames;

    if not u6.frame then
        warn("[Battlepass UI] Main.Frames.Battlepass not found — UI not built in Studio yet");

        return;
    end;

    u6.frame.Visible = false;
    local v139 = UIController._cached[u6.frame];

    if v139 then
        v139.isOpen = false;
    end;

    local Contents = u6.frame:FindFirstChild("Contents");
    local v140;

    if Contents then
        v140 = Contents:FindFirstChild("Header");
    else
        v140 = Contents;
    end;

    if v140 then
        local Profile = v140:FindFirstChild("Profile");

        if Profile then
            u6.totalLevel = Profile:FindFirstChild("TotalLevel");
            local EXPTitle = Profile:FindFirstChild("EXPTitle");
            local v141 = EXPTitle and EXPTitle:FindFirstChild("EXPAmount");
            u6.expAmount = v141;
            local Background = Profile:FindFirstChild("Background");
            Background = Background;
            local v142;

            if Background then
                v142 = Background:FindFirstChild("Incomplete");
            else
                v142 = Background;
            end;

            u6.profileIncomplete = v142;
            local v143 = Background and Background:FindFirstChild("Complete");
            u6.profileComplete = v143;
        end;

        local Bar = v140:FindFirstChild("Bar");
        local v144 = Bar and Bar:FindFirstChild("Fill");
        u6.barFill = v144;
        local Buttons = v140:FindFirstChild("Buttons");

        if Buttons then
            local Claim_All = Buttons:FindFirstChild("Claim_All");

            if Claim_All then
                local u145 = false;
                Claim_All.MouseButton1Click:Connect(function() -- Line: 1083
                    -- upvalues: u145 (ref), u2 (ref), BattlepassData (ref), u4 (ref), Knit (ref), StarBurst (ref)
                    if u145 then
                        return;
                    end;

                    u145 = true;
                    local v146;

                    if u2 then
                        v146 = u2.Data.Battlepass;
                    else
                        v146 = nil;
                    end;

                    if v146 then
                        local v147 = v146.HasPremium or false;
                        local v148 = false;

                        for i = 1, math.min(v146.Tier or 0, BattlepassData.MAX_TIER) do
                            local v149;

                            if u2 then
                                v149 = u2.Data.Battlepass;
                            else
                                v149 = nil;
                            end;

                            local v150;

                            if v149 then
                                v150 = v149.ClaimedFree;

                                if v150 then
                                    v150 = table.find(v150, i) ~= nil;
                                end;
                            else
                                v150 = false;
                            end;

                            if not v150 then
                                local v151, v152 = u4:ClaimReward(i, "Free");
                                v148 = v151 and v152 and true or v148;
                            end;

                            local v153;

                            if v147 then
                                local v154;

                                if u2 then
                                    v154 = u2.Data.Battlepass;
                                else
                                    v154 = nil;
                                end;

                                local v155;

                                if v154 then
                                    v155 = v154.ClaimedPremium or v154.ClaimedFree;

                                    if v155 then
                                        v155 = table.find(v155, i) ~= nil;
                                    end;
                                else
                                    v155 = false;
                                end;

                                if v155 then
                                    v153 = i;
                                else
                                    local v156, v157 = u4:ClaimReward(i, "Premium");

                                    if v156 and v157 then
                                        v153 = i;
                                        v148 = true;
                                    else
                                        v153 = i;
                                    end;
                                end;
                            else
                                v153 = i;
                            end;
                        end;

                        if v148 then
                            Knit.GetController("SoundController"):Play("ItemPurchased");
                            StarBurst.AtMouse();
                        end;
                    end;

                    u145 = false;
                end);
            end;

            local Skip_1 = Buttons:FindFirstChild("Skip_1");

            if Skip_1 then
                Skip_1.MouseButton1Click:Connect(function() -- Line: 1118
                    -- upvalues: u4 (ref)
                    u4:PromptTierSkip(1);
                end);
            end;

            local Skip_10 = Buttons:FindFirstChild("Skip_10");

            if Skip_10 then
                Skip_10.MouseButton1Click:Connect(function() -- Line: 1124
                    -- upvalues: u4 (ref)
                    u4:PromptTierSkip(10);
                end);
            end;
        end;
    end;

    local v158;

    if Contents then
        v158 = Contents:FindFirstChild("Premium");
    else
        v158 = Contents;
    end;

    if v158 then
        local Classic = v158:FindFirstChild("Classic");
        local v159 = Classic and Classic:FindFirstChild("Unlocked");
        u6.classicUnlocked = v159;
        local Premium = v158:FindFirstChild("Premium");

        if Premium then
            u6.premiumUnlocked = Premium:FindFirstChild("Unlocked");
            u6.premiumBuy = Premium:FindFirstChild("Buy");

            if u6.premiumBuy then
                u6.premiumBuy.MouseButton1Click:Connect(function() -- Line: 1142
                    -- upvalues: u4 (ref)
                    u4:PromptPremiumPurchase();
                end);
            end;
        end;
    end;

    if Contents then
        Contents = Contents:FindFirstChild("Scrolling");
    end;

    if Contents then
        u6.content = Contents:FindFirstChild("Content");
        local v160 = u6.content and u6.content:FindFirstChild("Template");
        u6.template = v160;

        if u6.template then
            u6.template.Visible = false;
        end;

        u6.nextBtn = Contents:FindFirstChild("Next");

        if u6.nextBtn then
            u6.nextBtn.MouseButton1Click:Connect(ScrollToNextCheckpoint);
        end;

        u6.backBtn = Contents:FindFirstChild("Back");

        if u6.backBtn then
            u6.backBtn.MouseButton1Click:Connect(ScrollToPrevCheckpoint);
        end;
    end;

    local Quest = u6.frame:FindFirstChild("Quest");

    if Quest then
        u6.showcase = Quest:FindFirstChild("Main");
        u6.questNotice = Quest:FindFirstChild("Notice");

        if u6.questNotice then
            u6.questNotice.Visible = false;
        end;

        local QuestButton = Quest:FindFirstChild("QuestButton");

        if QuestButton then
            QuestButton.MouseButton1Click:Connect(SwitchToQuests);
        end;

        local v161 = u6.showcase and u6.showcase:FindFirstChild("Claim_Frame");

        if v161 then
            v161 = v161:FindFirstChild("Claim");
        end;

        if v161 then
            v161.MouseButton1Click:Connect(function() -- Line: 1182
                -- upvalues: u9 (ref), u4 (ref), u10 (ref), StarBurst (ref)
                if u9 >= 1 then
                    local v162, v163 = u4:ClaimReward(u9, u10);

                    if v162 and v163 then
                        StarBurst.AtMouse();
                    end;
                end;
            end);
        end;
    end;

    if u6.questsFrame then
        u6.questsFrame.Visible = false;
        local Exit = u6.questsFrame:FindFirstChild("Exit", true);

        if Exit then
            Exit.MouseButton1Click:Connect(SwitchToPass);
        end;

        local Content = u6.questsFrame:FindFirstChild("Content");

        if Content then
            u6.questTimerLabel = Content:FindFirstChild("Time");
            u6.questScroll = Content:FindFirstChild("ScrollingFrame");
            local v164 = u6.questScroll and u6.questScroll:FindFirstChild("Quest_Template");
            u6.questTemplate = v164;

            if u6.questTemplate then
                u6.questTemplate.Visible = false;
            end;
        end;

        BuildQuestList();
    end;

    BuildTrack();

    if u6.content then
        u6.content:GetPropertyChangedSignal("CanvasPosition"):Connect(RefreshCheckpointFromScroll);
        task.defer(function() -- Line: 1221
            -- upvalues: u9 (ref), BattlepassData (ref), u7 (ref), u6 (ref), UpdateShowcase (ref)
            local GetCheckpointForLevel = BattlepassData.GetCheckpointForLevel;
            local v165 = u7[1];
            local v166 = u7[2];
            local v167, v168;

            if v165 and v166 then
                v167 = v166.AbsolutePosition.X - v165.AbsolutePosition.X;

                if v167 <= 0 then
                    v168 = nil;
                    v167 = nil;
                else
                    v168 = v165.AbsolutePosition.X - u6.content.AbsolutePosition.X + u6.content.CanvasPosition.X;
                end;
            else
                v168 = nil;
                v167 = nil;
            end;

            local v169;

            if v168 then
                local v170 = math.floor((u6.content.CanvasPosition.X - v168) / v167) + 1;
                v169 = math.clamp(v170, 1, BattlepassData.MAX_TIER);
            else
                v169 = 1;
            end;

            u9 = GetCheckpointForLevel(v169);
            UpdateShowcase();
        end);
    end;

    if u12 then
        u12:Disconnect();
    end;

    local u171 = false;
    u12 = RunService.Heartbeat:Connect(function(p172) -- Line: 650
        -- upvalues: u6 (ref), u10 (ref), u11 (ref), u171 (ref), UpdateShowcase (ref)
        if u6.frame and u6.frame.Visible then
            if not u171 then
                u171 = true;
                UpdateShowcase();
            end;

            u11 = u11 + p172;

            if u11 >= 8 then
                u11 = 0;
                u10 = u10 == "Free" and "Premium" or "Free";
                UpdateShowcase();
            end;

            return;
        end;

        u10 = "Free";
        u11 = 0;
        u171 = false;
    end);
    u6.frame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 1231
        -- upvalues: u6 (ref), u27 (ref)
        local u173 = u6.frame.Visible and 1 or 0;

        for _, v in u27 do
            pcall(function() -- Line: 1234
                -- upvalues: v (copy), u173 (copy)
                v:AdjustSpeed(u173);
            end);
        end;
    end);

    if u13 then
        u13:Disconnect();
    end;

    u13 = RunService.Heartbeat:Connect(function() -- Line: 952
        -- upvalues: u6 (ref), BattlepassData (ref), FormatTime (ref)
        if not u6.questTimerLabel then
            return;
        end;

        local v174 = BattlepassData.SecondsUntilNextWindow();
        u6.questTimerLabel.Text = "New Quests in: " .. FormatTime(v174);
    end);
    UpdateHeader();
    local v175;

    if u2 then
        v175 = u2.Data.Battlepass;
    else
        v175 = nil;
    end;

    local v176 = v175 and v175.HasPremium or false;

    if u6.classicUnlocked then
        u6.classicUnlocked.Visible = true;
    end;

    if u6.premiumUnlocked then
        u6.premiumUnlocked.Visible = v176;
    end;

    if u6.premiumBuy then
        u6.premiumBuy.Visible = not v176;
    end;

    for i, v in pairs(u7) do
        UpdateCellState(v, i);
    end;

    UpdateShowcase();

    for i = 1, BattlepassData.DAILY_QUEST_COUNT do
        UpdateBPQuestFrame(i);
        local _ = i;
    end;

    UpdateQuestNotice();
    u2:OnChange(function(p177, p178, p179, p180) -- Line: 1245
        -- upvalues: BattlepassData (ref), UpdateBPQuestFrame (ref), UpdateQuestNotice (ref), UpdateHeader (ref), u2 (ref), u6 (ref), u7 (ref), UpdateCellState (ref), UpdateShowcase (ref)
        if p178[1] ~= "Battlepass" then
            return;
        end;

        if p178[2] == "Quests" then
            for i = 1, BattlepassData.DAILY_QUEST_COUNT do
                UpdateBPQuestFrame(i);
                local _ = i;
            end;

            UpdateQuestNotice();

            return;
        end;

        UpdateHeader();
        local v181;

        if u2 then
            v181 = u2.Data.Battlepass;
        else
            v181 = nil;
        end;

        local v182 = v181 and v181.HasPremium or false;

        if u6.classicUnlocked then
            u6.classicUnlocked.Visible = true;
        end;

        if u6.premiumUnlocked then
            u6.premiumUnlocked.Visible = v182;
        end;

        if u6.premiumBuy then
            u6.premiumBuy.Visible = not v182;
        end;

        for i, v in pairs(u7) do
            UpdateCellState(v, i);
        end;

        UpdateShowcase();

        for i = 1, BattlepassData.DAILY_QUEST_COUNT do
            UpdateBPQuestFrame(i);
            local _ = i;
        end;

        UpdateQuestNotice();
    end);
    u4:OnTierUp(function(p183) -- Line: 1257
        -- upvalues: UpdateHeader (ref), u2 (ref), u6 (ref), u7 (ref), UpdateCellState (ref), UpdateShowcase (ref), BattlepassData (ref), UpdateBPQuestFrame (ref), UpdateQuestNotice (ref)
        UpdateHeader();
        local v184;

        if u2 then
            v184 = u2.Data.Battlepass;
        else
            v184 = nil;
        end;

        local v185 = v184 and v184.HasPremium or false;

        if u6.classicUnlocked then
            u6.classicUnlocked.Visible = true;
        end;

        if u6.premiumUnlocked then
            u6.premiumUnlocked.Visible = v185;
        end;

        if u6.premiumBuy then
            u6.premiumBuy.Visible = not v185;
        end;

        for i, v in pairs(u7) do
            UpdateCellState(v, i);
        end;

        UpdateShowcase();

        for i = 1, BattlepassData.DAILY_QUEST_COUNT do
            UpdateBPQuestFrame(i);
            local _ = i;
        end;

        UpdateQuestNotice();
    end);
    u4:OnQuestCompleted(function(p186) -- Line: 1261
        -- upvalues: BattlepassData (ref), UpdateBPQuestFrame (ref), UpdateQuestNotice (ref)
        for i = 1, BattlepassData.DAILY_QUEST_COUNT do
            UpdateBPQuestFrame(i);
            local _ = i;
        end;

        UpdateQuestNotice();
    end);
    u4:OnQuestProgress(function(p187, p188) -- Line: 1265
        -- upvalues: UpdateBPQuestFrame (ref)
        UpdateBPQuestFrame(p187);
    end);

    if u5 then
        local v189 = nil;
        local v190 = u1:FindFirstChild("HUD") and u1.HUD:FindFirstChild("Actions") and u1.HUD.Actions:FindFirstChild("Left");
        local v191 = v190 and v190:FindFirstChild("Buttons") and v190.Buttons:FindFirstChild("Battlepass");

        if v191 then
            v189 = v191:FindFirstChild("Notification", true);
        end;

        if v189 then
            u5:Register("Battlepass", v189, HasClaimableNotice);
        end;
    end;
end;

return v3;