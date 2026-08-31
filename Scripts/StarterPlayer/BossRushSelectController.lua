--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BossRushSelectController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.BossRushSelectController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local UIController = require(script.Parent.UIController);
local Registry = require(script.Parent.Registry);
local RevealCascade = require(script.Parent.Parent.ClientUtils.RevealCascade);
local ItemIndex = require(script.Parent.Parent.UI.ItemIndex);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local BossRushData = require(ReplicatedStorage.GameInfo.BossRushData);
local Class_Data = require(ReplicatedStorage.Classes.Class_Data);
local ItemData = require(ReplicatedStorage.GameInfo.ItemData);
local ClassItemData = require(ReplicatedStorage.GameInfo.ClassItemData);
local RarityData = require(ReplicatedStorage.GameInfo.RarityData);
local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
local Image_Data = require(ReplicatedStorage.GameInfo.Image_Data);
local PackageData = require(ReplicatedStorage.GameInfo.PackageData);
local EnemyResolver = require(ReplicatedStorage.GameInfo.EnemyResolver);
local LocalPlayer = Players.LocalPlayer;
local Color3_new_ret = Color3.new(1, 1, 1);
local RarityIndex = RarityData.RarityIndex;
local HeadShot = Enum.ThumbnailType.HeadShot;
local Size100x100 = Enum.ThumbnailSize.Size100x100;
local CFrame_new_ret = CFrame.new(Vector3.new(0, 0.5, -12), Vector3.new(0, 0.5, 0));
local CFrame_new_ret2 = CFrame.new(0, 0.5, 0);
local TweenInfo_new_ret = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local FINAL_BOSS_ORDER = BossRushData.FINAL_BOSS_ORDER;
local MAX_PARTY_SIZE = BossRushData.MAX_PARTY_SIZE;
local u1 = {};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = false;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = false;
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
local u24 = {};
local u25 = nil;
local u26 = nil;
local u27 = { "Leader_Viewport", "Player2_Viewport", "Player3_Viewport", "Player4_Viewport" };
local u28 = nil;
local u29 = nil;
local u30 = 0;
local u31 = nil;
local u32 = nil;
local u33 = nil;

for i = BossRushData.MIN_SKIP_FLOOR, BossRushData.MAX_SKIP_FLOOR, BossRushData.SKIP_STEP do
    table.insert(u1, i);
    local _ = i;
end;

local Color3_fromRGB_ret = Color3.fromRGB(133, 106, 57);
local Color3_fromRGB_ret2 = Color3.fromRGB(110, 110, 110);
local TweenInfo_new_ret2 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u34 = nil;
local u35 = nil;
local u36 = nil;
local u37 = nil;
local u38 = nil;
local u39 = nil;
local u40 = {};
local u41 = {};
local u42 = nil;
local u43 = nil;
local u44 = nil;
local u45 = nil;
local u46 = {};
local u47 = nil;
local u48 = nil;
local u49 = nil;
local u50 = nil;
local u51 = false;
local u52 = nil;
local u53 = nil;
local u54 = nil;
local u55 = nil;
local u56 = nil;
local u57 = nil;
local u58 = nil;
local u59 = nil;
local u60 = nil;
local u61 = {};
local u62 = {};
local u63 = nil;
local u64 = 0;
local u65 = false;
local u66 = false;
local u67 = 1;
local u68 = nil;
local u69 = {};
local u70 = {};
local u71 = {};
local u72 = nil;
local u73 = false;
local u74 = false;
local u75 = {};
local u76 = {};

local function GetThumbnail(u77: number) -- Line: 219
    -- upvalues: Players (copy), HeadShot (copy), Size100x100 (copy)
    local success, result = pcall(function() -- Line: 220
        -- upvalues: Players (ref), u77 (copy), HeadShot (ref), Size100x100 (ref)
        return Players:GetUserThumbnailAsync(u77, HeadShot, Size100x100);
    end);

    return success and result and result or "";
end;

local function FormatCommas(p78: number) -- Line: 227
    local math_floor_ret = math.floor(p78);
    local v79 = tostring(math_floor_ret);
    local v80;

    repeat
        v79, v80 = v79:gsub("^(-?%d+)(%d%d%d)", "%1,%2");
    until v80 == 0;

    return v79;
end;

local function FormatTime(p81: number) -- Line: 238
    if p81 <= 0 then
        return "--:--";
    end;

    local math_floor_ret = math.floor(p81 / 60);
    local math_floor_ret2 = math.floor(p81 % 60);

    return string.format("%02d:%02d", math_floor_ret, math_floor_ret2);
end;

local function GetClassIdleAnim(p82: string) -- Line: 246
    -- upvalues: Class_Data (copy)
    local v83 = Class_Data[p82];

    if v83 and (v83.AnimationOverrides and v83.AnimationOverrides.idle) then
        return v83.AnimationOverrides.idle;
    end;

    return nil;
end;

local function RarityColorOf(p84: string?) -- Line: 254
    -- upvalues: RarityColors (copy), Color3_new_ret (copy)
    local v85 = RarityColors[p84];

    return v85 and v85.TextColor3 or Color3_new_ret;
end;

local function CycleIndex(p86: number) -- Line: 267
    -- upvalues: FINAL_BOSS_ORDER (copy)
    return (p86 - 1) % #FINAL_BOSS_ORDER + 1;
end;

local function BossDisplayName(p87: number) -- Line: 273
    -- upvalues: FINAL_BOSS_ORDER (copy), BossRushData (copy)
    local v88 = FINAL_BOSS_ORDER[(p87 - 1) % #FINAL_BOSS_ORDER + 1];
    local v89;

    if v88 then
        v89 = BossRushData.GetFinalBoss(v88);
    else
        v89 = v88;
    end;

    return v89 and v89.DisplayName or (v88 or "");
end;

local function OffsetPosition(p90, p91: number) -- Line: 280
    return UDim2.new(p90.X.Scale + p91, p90.X.Offset, p90.Y.Scale, p90.Y.Offset);
end;

local function RenderBossIntoViewport(u92: number, u93: string, p94: boolean?) -- Line: 287
    -- upvalues: u24 (ref), u71 (copy), BossRushData (copy), SharedUtils (copy), EnemyResolver (copy)
    local u95 = u24[u92];

    if not u95 then
        return;
    end;

    local u96 = u71[u92];

    if u96 and (u96.bossKey == u93 and not p94) then
        return;
    end;

    if u96 and u96.animTrack then
        pcall(function() -- Line: 297
            -- upvalues: u96 (copy)
            u96.animTrack:Stop();
        end);
    end;

    for _, child in u95:GetChildren() do
        if not child:IsA("UIGradient") then
            child:Destroy();
        end;
    end;

    u71[u92] = nil;
    local FinalBoss = BossRushData.GetFinalBoss(u93);

    if not FinalBoss then
        return;
    end;

    local success, result = pcall(function() -- Line: 309
        -- upvalues: SharedUtils (ref), FinalBoss (copy), EnemyResolver (ref), u95 (copy), u71 (ref), u92 (copy), u93 (copy)
        local v97 = SharedUtils.CreateItem(FinalBoss.BossId, false, true);

        if not v97 then
            return;
        end;

        local Animate = v97:FindFirstChild("Animate");

        if Animate then
            Animate:Destroy();
        end;

        local v98 = EnemyResolver(FinalBoss.BossId);
        local WorldModel = Instance.new("WorldModel");
        WorldModel.Name = "CharacterWorld";
        WorldModel.Parent = u95;
        local Vector3_new_ret = Vector3.new(0, 2 + (v98 and v98.ViewportOffset and (v98.ViewportOffset.Y or 0) or 0), 3);
        v97.Parent = WorldModel;
        local Camera = Instance.new("Camera");
        Camera.CFrame = CFrame.new(0, 1.5, v98 and (v98.ViewportDistance or -2.5) or -2.5) * CFrame.Angles(0, 3.141592653589793, 0);
        Camera.Parent = u95;
        u95.CurrentCamera = Camera;
        local Vector3_new_ret2 = Vector3.new(Camera.CFrame.Position.X, 0, Camera.CFrame.Position.Z);
        v97:PivotTo(CFrame.new(Vector3_new_ret, Vector3_new_ret + (Vector3_new_ret2.Magnitude > 0 and Vector3_new_ret2.Unit or Vector3.new(0, 0, -1))) * CFrame.Angles(0, -0.4363323129985824, 0));
        local v99 = nil;

        if v98 then
            v98 = v98.IdleAnim;
        end;

        if v98 then
            local v100 = v97:FindFirstChildWhichIsA("Animator", true);

            if not v100 then
                local v101 = v97:FindFirstChildWhichIsA("Humanoid") or v97:FindFirstChildWhichIsA("AnimationController");

                if v101 then
                    v100 = Instance.new("Animator");
                    v100.Parent = v101;
                end;
            end;

            if v100 then
                local Animation = Instance.new("Animation");
                Animation.AnimationId = v98;
                v99 = v100:LoadAnimation(Animation);
                v99.Looped = true;
                v99:Play();
            end;
        end;

        u71[u92] = {
            bossKey = u93,
            worldModel = WorldModel,
            camera = Camera,
            animTrack = v99
        };
    end);

    if not success then
        warn("[BossRushSelectController] Failed to render carousel boss", u93, result);
    end;
end;

local function UpdateCarouselLabels() -- Line: 375
    -- upvalues: u12 (ref), u67 (ref), FINAL_BOSS_ORDER (copy), BossRushData (copy), u13 (ref), u14 (ref)
    if u12 then
        local v102 = FINAL_BOSS_ORDER[(u67 - 1) % #FINAL_BOSS_ORDER + 1];
        local v103;

        if v102 then
            v103 = BossRushData.GetFinalBoss(v102);
        else
            v103 = v102;
        end;

        u12.Text = v103 and v103.DisplayName or (v102 or "");
    end;

    if u13 then
        local v104 = FINAL_BOSS_ORDER[(u67 + 1 - 1) % #FINAL_BOSS_ORDER + 1];
        local v105;

        if v104 then
            v105 = BossRushData.GetFinalBoss(v104);
        else
            v105 = v104;
        end;

        u13.Text = v105 and v105.DisplayName or (v104 or "");
    end;

    if u14 then
        local v106 = FINAL_BOSS_ORDER[(u67 - 1 - 1) % #FINAL_BOSS_ORDER + 1];
        local v107;

        if v106 then
            v107 = BossRushData.GetFinalBoss(v106);
        else
            v107 = v106;
        end;

        u14.Text = v107 and v107.DisplayName or (v106 or "");
    end;
end;

local function SnapToIndex(p108: number) -- Line: 383
    -- upvalues: u67 (ref), FINAL_BOSS_ORDER (copy), u69 (ref), RenderBossIntoViewport (copy), u24 (ref), u70 (ref), u12 (ref), BossRushData (copy), u13 (ref), u14 (ref)
    u67 = (p108 - 1) % #FINAL_BOSS_ORDER + 1;
    local v109 = #FINAL_BOSS_ORDER;
    u69 = {
        Main = 1,
        Next = 2,
        Previous = 3
    };
    RenderBossIntoViewport(1, FINAL_BOSS_ORDER[u67]);

    if u24[1] then
        u24[1].Position = u70.Main;
    end;

    if u24[2] then
        if v109 >= 2 then
            u24[2].Visible = true;
            RenderBossIntoViewport(2, FINAL_BOSS_ORDER[(u67 + 1 - 1) % #FINAL_BOSS_ORDER + 1]);
            u24[2].Position = u70.Next;
        else
            u24[2].Visible = false;
        end;
    end;

    if u24[3] then
        if v109 >= 3 then
            u24[3].Visible = true;
            RenderBossIntoViewport(3, FINAL_BOSS_ORDER[(u67 - 1 - 1) % #FINAL_BOSS_ORDER + 1]);
            u24[3].Position = u70.Previous;
        else
            u24[3].Visible = false;
        end;
    end;

    if u12 then
        local v110 = FINAL_BOSS_ORDER[(u67 - 1) % #FINAL_BOSS_ORDER + 1];
        local v111;

        if v110 then
            v111 = BossRushData.GetFinalBoss(v110);
        else
            v111 = v110;
        end;

        u12.Text = v111 and v111.DisplayName or (v110 or "");
    end;

    if u13 then
        local v112 = FINAL_BOSS_ORDER[(u67 + 1 - 1) % #FINAL_BOSS_ORDER + 1];
        local v113;

        if v112 then
            v113 = BossRushData.GetFinalBoss(v112);
        else
            v113 = v112;
        end;

        u13.Text = v113 and v113.DisplayName or (v112 or "");
    end;

    if u14 then
        local v114 = FINAL_BOSS_ORDER[(u67 - 1 - 1) % #FINAL_BOSS_ORDER + 1];
        local v115;

        if v114 then
            v115 = BossRushData.GetFinalBoss(v114);
        else
            v115 = v114;
        end;

        u14.Text = v115 and v115.DisplayName or (v114 or "");
    end;
end;

local function AnimateStep(p116: number) -- Line: 418
    -- upvalues: FINAL_BOSS_ORDER (copy), SnapToIndex (copy), u67 (ref), u66 (ref), u69 (ref), TweenService (copy), u24 (ref), TweenInfo_new_ret (copy), u70 (ref), RenderBossIntoViewport (copy), u12 (ref), BossRushData (copy), u13 (ref), u14 (ref)
    if #FINAL_BOSS_ORDER < 3 then
        SnapToIndex(u67 + p116);

        return;
    end;

    u66 = true;
    u67 = (u67 + p116 - 1) % #FINAL_BOSS_ORDER + 1;
    local Main = u69.Main;
    local Next = u69.Next;
    local Previous = u69.Previous;

    if p116 == 1 then
        TweenService:Create(u24[Next], TweenInfo_new_ret, {
            Position = u70.Main
        }):Play();
        TweenService:Create(u24[Main], TweenInfo_new_ret, {
            Position = u70.Previous
        }):Play();
        RenderBossIntoViewport(Previous, FINAL_BOSS_ORDER[(u67 + 1 - 1) % #FINAL_BOSS_ORDER + 1]);
        local Next2 = u70.Next;
        u24[Previous].Position = UDim2.new(Next2.X.Scale + 0.2, Next2.X.Offset, Next2.Y.Scale, Next2.Y.Offset);
        TweenService:Create(u24[Previous], TweenInfo_new_ret, {
            Position = u70.Next
        }):Play();
        u69 = {
            Main = Next,
            Previous = Main,
            Next = Previous
        };
    else
        TweenService:Create(u24[Previous], TweenInfo_new_ret, {
            Position = u70.Main
        }):Play();
        TweenService:Create(u24[Main], TweenInfo_new_ret, {
            Position = u70.Next
        }):Play();
        RenderBossIntoViewport(Next, FINAL_BOSS_ORDER[(u67 - 1 - 1) % #FINAL_BOSS_ORDER + 1]);
        local Previous2 = u70.Previous;
        u24[Next].Position = UDim2.new(Previous2.X.Scale + -0.2, Previous2.X.Offset, Previous2.Y.Scale, Previous2.Y.Offset);
        TweenService:Create(u24[Next], TweenInfo_new_ret, {
            Position = u70.Previous
        }):Play();
        u69 = {
            Main = Previous,
            Next = Main,
            Previous = Next
        };
    end;

    if u12 then
        local v117 = FINAL_BOSS_ORDER[(u67 - 1) % #FINAL_BOSS_ORDER + 1];
        local v118;

        if v117 then
            v118 = BossRushData.GetFinalBoss(v117);
        else
            v118 = v117;
        end;

        u12.Text = v118 and v118.DisplayName or (v117 or "");
    end;

    if u13 then
        local v119 = FINAL_BOSS_ORDER[(u67 + 1 - 1) % #FINAL_BOSS_ORDER + 1];
        local v120;

        if v119 then
            v120 = BossRushData.GetFinalBoss(v119);
        else
            v120 = v119;
        end;

        u13.Text = v120 and v120.DisplayName or (v119 or "");
    end;

    if u14 then
        local v121 = FINAL_BOSS_ORDER[(u67 - 1 - 1) % #FINAL_BOSS_ORDER + 1];
        local v122;

        if v121 then
            v122 = BossRushData.GetFinalBoss(v121);
        else
            v122 = v121;
        end;

        u14.Text = v122 and v122.DisplayName or (v121 or "");
    end;

    task.delay(TweenInfo_new_ret.Time, function() -- Line: 457
        -- upvalues: u66 (ref)
        u66 = false;
    end);
end;

local function SyncToBoss(p123: string?, p124: boolean) -- Line: 464
    -- upvalues: u65 (ref), u68 (ref), FINAL_BOSS_ORDER (copy), u67 (ref), AnimateStep (copy), SnapToIndex (copy)
    if not u65 then
        u68 = p123;

        return;
    end;

    if not p123 then
        return;
    end;

    local v125 = nil;

    for i, v in FINAL_BOSS_ORDER do
        if v == p123 then
            v125 = i;
            break;
        end;
    end;

    if not v125 or v125 == u67 then
        return;
    end;

    if p124 and #FINAL_BOSS_ORDER >= 3 then
        if v125 == (u67 + 1 - 1) % #FINAL_BOSS_ORDER + 1 then
            AnimateStep(1);

            return;
        end;

        if v125 == (u67 - 1 - 1) % #FINAL_BOSS_ORDER + 1 then
            AnimateStep(-1);

            return;
        end;
    end;

    SnapToIndex(v125);
end;

local function BuildCarousel() -- Line: 491
    -- upvalues: u65 (ref), u7 (ref), FINAL_BOSS_ORDER (copy), u70 (ref), u8 (ref), u2 (ref), u68 (ref), BossRushData (copy), SnapToIndex (copy)
    if u65 then
        return;
    end;

    if not u7 then
        return;
    end;

    if #FINAL_BOSS_ORDER == 0 then
        return;
    end;

    u70 = {
        Main = u7:GetAttribute("Main_Position"),
        Next = u7:GetAttribute("Next_Position"),
        Previous = u7:GetAttribute("Previous_Position")
    };

    if not (u70.Main and (u70.Next and u70.Previous)) then
        warn("[BossRushSelectController] CanvasGroup missing Main/Next/Previous_Position attributes");

        return;
    end;

    local v126 = #FINAL_BOSS_ORDER >= 2;

    if u8 then
        u8.Visible = v126;
    end;

    if u2 then
        u2.Visible = v126;
    end;

    local v127 = u68 or BossRushData.DEFAULT_FINAL_BOSS;
    local v128 = 1;

    for i, v in FINAL_BOSS_ORDER do
        if v == v127 then
            v128 = i;
            break;
        end;
    end;

    u65 = true;
    u68 = nil;
    SnapToIndex(v128);
end;

local function OnCyclePressed(p129: number) -- Line: 524
    -- upvalues: u65 (ref), u66 (ref), u73 (ref), FINAL_BOSS_ORDER (copy), u67 (ref), AnimateStep (copy), u3 (ref)
    if not u65 or u66 then
        return;
    end;

    if not u73 then
        return;
    end;

    if #FINAL_BOSS_ORDER < 2 then
        return;
    end;

    local v130 = FINAL_BOSS_ORDER[(u67 + p129 - 1) % #FINAL_BOSS_ORDER + 1];
    AnimateStep(p129);

    if u3 then
        u3:RequestSelectFinalBoss(v130);
    end;
end;

local function ApplySkipToggleVisual(p131: boolean, p132: boolean?) -- Line: 543
    -- upvalues: u15 (ref), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), TweenService (copy), TweenInfo_new_ret2 (copy)
    if not u15 then
        return;
    end;

    local v133 = p131 and u15:GetAttribute("On") or u15:GetAttribute("Off");
    local v134 = p131 and Color3_fromRGB_ret or Color3_fromRGB_ret2;

    if p132 then
        if v133 then
            u15.Position = v133;
        end;

        u15.BackgroundColor3 = v134;

        return;
    end;

    local v135 = {
        BackgroundColor3 = v134
    };

    if v133 then
        v135.Position = v133;
    end;

    TweenService:Create(u15, TweenInfo_new_ret2, v135):Play();
end;

local function UpdateSkipDisplay() -- Line: 559
    -- upvalues: u25 (ref), u9 (ref), u29 (ref), u73 (ref), BossRushData (copy), u30 (ref), u4 (ref), u26 (ref)
    if u25 then
        u25.GroupTransparency = u9 and 0 or 0.7;

        if u29 then
            u29.Interactable = u9 and u73;
        end;
    end;

    local SkipCost = BossRushData.GetSkipCost(u30);

    if u4 then
        u4.Text = "x" .. SkipCost;
    end;

    if u26 then
        u26.Text = "Floor: " .. (u30 > 0 and tostring(u30) or "-");
    end;
end;

local function SetSkipState(p136: boolean, p137: number, p138: boolean) -- Line: 575
    -- upvalues: u9 (ref), u30 (ref), ApplySkipToggleVisual (copy), u25 (ref), u29 (ref), u73 (ref), BossRushData (copy), u4 (ref), u26 (ref), u3 (ref)
    u9 = p136;
    u30 = p136 and p137 and p137 or 0;
    ApplySkipToggleVisual(u9, false);

    if u25 then
        u25.GroupTransparency = u9 and 0 or 0.7;

        if u29 then
            u29.Interactable = u9 and u73;
        end;
    end;

    local SkipCost = BossRushData.GetSkipCost(u30);

    if u4 then
        u4.Text = "x" .. SkipCost;
    end;

    if u26 then
        u26.Text = "Floor: " .. (u30 > 0 and tostring(u30) or "-");
    end;

    if p138 and (u73 and u3) then
        u3:RequestSelectSkipFloor(u9 and u30 or 0);
    end;
end;

local function OnSkipTogglePressed() -- Line: 586
    -- upvalues: u73 (ref), u9 (ref), u30 (ref), ApplySkipToggleVisual (copy), u25 (ref), u29 (ref), BossRushData (copy), u4 (ref), u26 (ref), u3 (ref), u10 (ref), u1 (copy)
    if not u73 then
        return;
    end;

    if u9 then
        u9 = false;
        u30 = 0;
        ApplySkipToggleVisual(u9, false);

        if u25 then
            u25.GroupTransparency = u9 and 0 or 0.7;

            if u29 then
                u29.Interactable = u9 and u73;
            end;
        end;

        local SkipCost = BossRushData.GetSkipCost(u30);

        if u4 then
            u4.Text = "x" .. SkipCost;
        end;

        if u26 then
            u26.Text = "Floor: " .. (u30 > 0 and tostring(u30) or "-");
        end;

        if u73 and u3 then
            u3:RequestSelectSkipFloor(u9 and u30 or 0);
        end;

        return;
    end;

    if u10 and not u10:Prompt({
        Message = "Skipping floors means the WHOLE party\'s final time will not be tracked on the leaderboard. Floor Milestone rewards are still earned. Continue?",
        ConfirmText = "Skip",
        DenyText = "Cancel"
    }) then
        return;
    end;

    if not u73 then
        return;
    end;

    u9 = true;
    u30 = u1[1] or 0 or 0;
    ApplySkipToggleVisual(u9, false);

    if u25 then
        u25.GroupTransparency = u9 and 0 or 0.7;

        if u29 then
            u29.Interactable = u9 and u73;
        end;
    end;

    local SkipCost = BossRushData.GetSkipCost(u30);

    if u4 then
        u4.Text = "x" .. SkipCost;
    end;

    if u26 then
        u26.Text = "Floor: " .. (u30 > 0 and tostring(u30) or "-");
    end;

    if u73 and u3 then
        u3:RequestSelectSkipFloor(u9 and u30 or 0);
    end;
end;

local function OnSkipCyclePressed() -- Line: 610
    -- upvalues: u73 (ref), u9 (ref), u1 (copy), u30 (ref), ApplySkipToggleVisual (copy), u25 (ref), u29 (ref), BossRushData (copy), u4 (ref), u26 (ref), u3 (ref)
    if not (u73 and u9) then
        return;
    end;

    if #u1 == 0 then
        return;
    end;

    local v139 = 1;

    for i, v in u1 do
        if v == u30 then
            v139 = i;
            break;
        end;
    end;

    u9 = true;
    u30 = u1[v139 % #u1 + 1] or 0;
    ApplySkipToggleVisual(u9, false);

    if u25 then
        u25.GroupTransparency = u9 and 0 or 0.7;

        if u29 then
            u29.Interactable = u9 and u73;
        end;
    end;

    local SkipCost = BossRushData.GetSkipCost(u30);

    if u4 then
        u4.Text = "x" .. SkipCost;
    end;

    if u26 then
        u26.Text = "Floor: " .. (u30 > 0 and tostring(u30) or "-");
    end;

    if u73 and u3 then
        u3:RequestSelectSkipFloor(u9 and u30 or 0);
    end;
end;

local function SyncSkipFromParty(p140: number?) -- Line: 623
    -- upvalues: BossRushData (copy), u9 (ref), u30 (ref), ApplySkipToggleVisual (copy), u25 (ref), u29 (ref), u73 (ref), u4 (ref), u26 (ref)
    local v141 = tonumber(p140) or 0;
    local v142 = BossRushData.IsValidSkipFloor(v141);
    local v143 = v142 and v141 and v141 or 0;
    u9 = v142;
    u30 = v142 and v143 and v143 or 0;
    ApplySkipToggleVisual(u9, false);

    if u25 then
        u25.GroupTransparency = u9 and 0 or 0.7;

        if u29 then
            u29.Interactable = u9 and u73;
        end;
    end;

    local SkipCost = BossRushData.GetSkipCost(u30);

    if u4 then
        u4.Text = "x" .. SkipCost;
    end;

    if u26 then
        u26.Text = "Floor: " .. (u30 > 0 and tostring(u30) or "-");
    end;
end;

local function ClearPlayerViewport(p144: number) -- Line: 632
    -- upvalues: u76 (copy), u38 (ref), u27 (copy)
    local v145 = u76[p144];

    if v145 then
        if v145.animTrack and v145.animTrack.IsPlaying then
            v145.animTrack:Stop();
        end;

        if v145.worldModel and v145.worldModel.Parent then
            v145.worldModel:Destroy();
        end;

        u76[p144] = nil;
    end;

    local v146 = u38 and u38:FindFirstChild(u27[p144]);

    if v146 then
        for _, child in v146:GetChildren() do
            if not child:IsA("UIGradient") then
                child:Destroy();
            end;
        end;
    end;
end;

local function PopulatePlayerViewport(p147: number, p148: userdata) -- Line: 655
    -- upvalues: ClearPlayerViewport (copy), u38 (ref), u27 (copy), CFrame_new_ret2 (copy), CFrame_new_ret (copy), Class_Data (copy), ReplicatedStorage (copy), u76 (copy)
    ClearPlayerViewport(p147);
    local v149 = u38 and u38:FindFirstChild(u27[p147]);

    if not v149 then
        return;
    end;

    local Character = p148.Character;

    if not Character then
        return;
    end;

    local Archivable = Character.Archivable;
    Character.Archivable = true;
    local v150 = Character:Clone();
    Character.Archivable = Archivable;

    for _, descendant in v150:GetDescendants() do
        if descendant:IsA("BaseScript") or (descendant:IsA("Tool") or (descendant:IsA("ForceField") or descendant:IsA("BillboardGui"))) then
            descendant:Destroy();
        end;
    end;

    local WorldModel = Instance.new("WorldModel");
    WorldModel.Name = "CharacterWorld";
    WorldModel.Parent = v149;
    v150:PivotTo(CFrame_new_ret2);
    v150.Parent = WorldModel;

    for _, child in v150:GetChildren() do
        if child:IsA("Accessory") then
            local Handle = child:FindFirstChild("Handle");

            if Handle then
                local v151 = Handle:FindFirstChildOfClass("Attachment");

                if v151 then
                    for _, child2 in v150:GetChildren() do
                        if child2:IsA("BasePart") then
                            local v152 = child2:FindFirstChild(v151.Name);

                            if v152 and v152:IsA("Attachment") then
                                local Weld = Instance.new("Weld");
                                Weld.Part0 = child2;
                                Weld.Part1 = Handle;
                                Weld.C0 = v152.CFrame;
                                Weld.C1 = v151.CFrame;
                                Weld.Parent = Handle;
                                break;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    local Camera = Instance.new("Camera");
    Camera.FieldOfView = 30;
    Camera.CFrame = CFrame_new_ret;
    Camera.Parent = v149;
    v149.CurrentCamera = Camera;
    local v153 = nil;
    local v154 = v150:FindFirstChildOfClass("Humanoid");

    if v154 then
        local v155 = v154:FindFirstChildOfClass("Animator");

        if not v155 then
            v155 = Instance.new("Animator");
            v155.Parent = v154;
        end;

        local v156 = Class_Data[p148:GetAttribute("Stat_ActiveClass") or ""];
        local v157;

        if v156 and (v156.AnimationOverrides and v156.AnimationOverrides.idle) then
            v157 = v156.AnimationOverrides.idle;
        else
            v157 = nil;
        end;

        local v158 = nil;

        if v157 then
            v158 = Instance.new("Animation");
            v158.AnimationId = v157;
        else
            local v159 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Idle_Animations");

            if v159 then
                v158 = v159:FindFirstChild("Hitman_Idle");
            end;
        end;

        if v158 then
            v153 = v155:LoadAnimation(v158);
            v153.Looped = true;
            v153:Play();
        end;
    end;

    u76[p147] = {
        clone = v150,
        animTrack = v153,
        worldModel = WorldModel,
        camera = Camera,
        userId = p148.UserId
    };
end;

local function OpenInvitePicker() -- Line: 763
    -- upvalues: u28 (ref), u3 (ref), u75 (copy)
    if not u28 then
        return;
    end;

    u28:Open({
        Header = "INVITE",
        Subtitle = "Select a player to invite",
        CloseOnSelect = false,
        MarkInvitedOnSelect = true,

        OnSelect = function(p160) -- Line: 771, Name: OnSelect
            -- upvalues: u3 (ref), u75 (ref)
            if not u3 then
                return;
            end;

            local UserId = p160.UserId;
            local v161 = u75[UserId];

            if v161 and os.clock() - v161 < 30 then
                return;
            end;

            u75[UserId] = os.clock();
            u3:RequestInvite(UserId);
        end
    });
end;

local function ApplySlot(p162: number, u163: any) -- Line: 785
    -- upvalues: u40 (copy), u41 (copy), Players (copy), HeadShot (copy), Size100x100 (copy), u76 (copy), PopulatePlayerViewport (copy), u73 (ref), ClearPlayerViewport (copy)
    local u164 = u40[p162];

    if not u164 then
        return;
    end;

    if u163 then
        u41[p162] = u163.UserId;

        if u164.PlayerCard then
            u164.PlayerCard.Visible = true;
        end;

        if u164.AddCard then
            u164.AddCard.Visible = false;
        end;

        if u164.ProfileImage then
            task.spawn(function() -- Line: 796
                -- upvalues: u163 (copy), Players (ref), HeadShot (ref), Size100x100 (ref), u164 (copy)
                local UserId = u163.UserId;
                local success, result = pcall(function() -- Line: 220
                    -- upvalues: Players (ref), UserId (copy), HeadShot (ref), Size100x100 (ref)
                    return Players:GetUserThumbnailAsync(UserId, HeadShot, Size100x100);
                end);
                local v165 = success and result and result or "";

                if u164.ProfileImage.Parent then
                    u164.ProfileImage.Image = v165;
                end;
            end);
        end;

        if u164.PlayerName then
            u164.PlayerName.Text = u163.DisplayName or (u163.Name or "");
        end;

        if u164.PlayerLevel then
            local PlayerByUserId = Players:GetPlayerByUserId(u163.UserId);
            local v166;

            if PlayerByUserId then
                local leaderstats = PlayerByUserId:FindFirstChild("leaderstats");

                if leaderstats then
                    leaderstats = leaderstats:FindFirstChild("Level");
                end;

                v166 = leaderstats and leaderstats.Value or PlayerByUserId:GetAttribute("PlayerLevel") or (u163.PlayerLevel or 1);
            else
                v166 = u163.PlayerLevel or 1;
            end;

            u164.PlayerLevel.Text = "Lv. " .. v166;
        end;

        local PlayerByUserId = Players:GetPlayerByUserId(u163.UserId);

        if PlayerByUserId then
            local v167 = u76[p162];

            if not v167 or v167.userId ~= u163.UserId then
                PopulatePlayerViewport(p162, PlayerByUserId);
            end;
        end;
    else
        u41[p162] = nil;

        if u164.PlayerCard then
            u164.PlayerCard.Visible = false;
        end;

        if u164.AddCard then
            u164.AddCard.Visible = u73;
        end;

        ClearPlayerViewport(p162);
    end;
end;

local function RefreshPartyRoster(p168) -- Line: 845
    -- upvalues: u72 (ref), u73 (ref), LocalPlayer (copy), MAX_PARTY_SIZE (copy), ApplySlot (copy), u35 (ref), u8 (ref), u2 (ref), u33 (ref), BossRushData (copy), u9 (ref), u30 (ref), ApplySkipToggleVisual (copy), u25 (ref), u29 (ref), u4 (ref), u26 (ref), SyncToBoss (copy)
    u72 = p168;
    u73 = p168 and p168.LeaderId == LocalPlayer.UserId and true or false;
    local v169 = {};

    if p168 and p168.Members then
        for _, v in p168.Members do
            if v.UserId == p168.LeaderId then
                table.insert(v169, 1, v);
            end;
        end;

        for _, v in p168.Members do
            if v.UserId ~= p168.LeaderId then
                table.insert(v169, v);
            end;
        end;
    end;

    for i = 1, MAX_PARTY_SIZE do
        ApplySlot(i, v169[i]);
        local _ = i;
    end;

    if u35 then
        u35.Visible = u73;
    end;

    if u8 then
        u8.Interactable = u73;
    end;

    if u2 then
        u2.Interactable = u73;
    end;

    if u33 then
        u33.Interactable = u73;
    end;

    local v170;

    if p168 then
        v170 = p168.SelectedSkipFloor;
    else
        v170 = p168;
    end;

    local v171 = tonumber(v170) or 0;
    local v172 = BossRushData.IsValidSkipFloor(v171);
    local v173 = v172 and v171 and v171 or 0;
    u9 = v172;
    u30 = v172 and v173 and v173 or 0;
    ApplySkipToggleVisual(u9, false);

    if u25 then
        u25.GroupTransparency = u9 and 0 or 0.7;

        if u29 then
            u29.Interactable = u9 and u73;
        end;
    end;

    local SkipCost = BossRushData.GetSkipCost(u30);

    if u4 then
        u4.Text = "x" .. SkipCost;
    end;

    if u26 then
        u26.Text = "Floor: " .. (u30 > 0 and tostring(u30) or "-");
    end;

    if p168 and p168.SelectedFinalBoss then
        SyncToBoss(p168.SelectedFinalBoss, true);
    end;
end;

local function ResolveShowcaseEntry(p174) -- Line: 893
    -- upvalues: ItemData (copy), RarityIndex (copy), ClassItemData (copy), Image_Data (copy), PackageData (copy)
    local Type = p174.Type;

    if Type == "Material" then
        local v175 = ItemData.Index[p174.Id];

        if v175 then
            local v176 = v175.Rarity or "Common";

            return {
                Icon = v175.Icon or "",
                Name = v175.Name or p174.Id,
                Amount = p174.Amount or 1,
                Rarity = v176,
                RarityIndex = RarityIndex[v176] or 1
            };
        end;

        warn("[BossRushSelectController] Showcase material not in ItemData.Index:", p174.Id);

        return nil;
    end;

    if Type ~= "ClassItem" then
        if Type ~= "Package" then
            return nil;
        end;

        local v177 = PackageData.Get(p174.Id);

        if v177 then
            local v178 = v177.Rarity or "Celestial";

            return {
                Icon = v177.Icon or "",
                Name = v177.Name or p174.Id,
                Amount = p174.Amount or 1,
                Rarity = v178,
                RarityIndex = RarityIndex[v178] or 1
            };
        end;

        warn("[BossRushSelectController] Showcase package not in PackageData:", p174.Id);

        return nil;
    end;

    local v179 = ClassItemData.Get(p174.Id);
    local v180 = Image_Data.Class_Items or {};
    local v181 = v180[string.gsub(p174.Id, "%s", "")];

    if not v181 and (v179 and v179.ClassName) then
        v181 = v180[string.gsub(v179.ClassName, "%s", "")];
    end;

    local v182 = v179 and v179.Rarity or "Exotic";

    return {
        Icon = v181 or "",
        Name = p174.Id,
        Amount = p174.Amount or 1,
        Rarity = v182,
        RarityIndex = RarityIndex[v182] or 1
    };
end;

local function PopulateShowcaseRewards() -- Line: 955
    -- upvalues: BossRushData (copy), u42 (ref), FormatCommas (copy), u43 (ref), u44 (ref), u45 (ref), u46 (copy), ResolveShowcaseEntry (copy), RarityColors (copy), Color3_new_ret (copy), CollectionService (copy)
    local SHOWCASE_REWARDS = BossRushData.SHOWCASE_REWARDS;

    if not SHOWCASE_REWARDS then
        return;
    end;

    if u42 then
        u42.Text = "Coins: " .. FormatCommas(SHOWCASE_REWARDS.Coins or 0);
    end;

    if u43 then
        u43.Text = "EXP: " .. FormatCommas(SHOWCASE_REWARDS.EXP or 0);
    end;

    if not (u44 and u45) then
        return;
    end;

    for _, v in u46 do
        if v and v.Parent then
            v:Destroy();
        end;
    end;

    table.clear(u46);
    local v183 = {};

    for _, v in SHOWCASE_REWARDS.Items or {} do
        local v184 = ResolveShowcaseEntry(v);

        if v184 then
            table.insert(v183, v184);
        end;
    end;

    table.sort(v183, function(p185, p186) -- Line: 976
        if p185.RarityIndex == p186.RarityIndex then
            return p185.Name < p186.Name;
        end;

        return p185.RarityIndex > p186.RarityIndex;
    end);

    for i, v in v183 do
        local v187 = u45:Clone();
        v187.Name = "Reward_" .. i;
        v187.LayoutOrder = i;
        v187.Visible = true;
        local Holder = v187:FindFirstChild("Holder");

        if Holder then
            Holder = Holder:FindFirstChild("Main");
        end;

        if Holder then
            local ItemImage = Holder:FindFirstChild("ItemImage");

            if ItemImage then
                ItemImage.Image = v.Icon;
                ItemImage.Visible = v.Icon ~= "";
            end;

            local Amount = Holder:FindFirstChild("Amount");

            if Amount then
                Amount.Text = "x" .. v.Amount;
                Amount.Visible = (v.Amount or 0) > 1;
            end;

            local ItemName = Holder:FindFirstChild("ItemName");

            if ItemName then
                ItemName.Text = v.Name;
                local v188 = RarityColors[v.Rarity];
                ItemName.TextColor3 = v188 and v188.TextColor3 or Color3_new_ret;
            end;
        end;

        v187:SetAttribute("Tip", v.Name);

        if not CollectionService:HasTag(v187, "ToolTip") then
            CollectionService:AddTag(v187, "ToolTip");
        end;

        v187.Parent = u44;
        table.insert(u46, v187);
    end;

    local v189 = u44:FindFirstChildOfClass("UIListLayout");

    if v189 then
        u44.CanvasSize = UDim2.new(0, v189.AbsoluteContentSize.X, 0, v189.AbsoluteContentSize.Y);
    end;
end;

local function RefreshStatsDisplay() -- Line: 1028
    -- upvalues: Registry (copy), u16 (ref), u17 (ref), u19 (ref), BossRushData (copy)
    local v190 = Registry:Get("PlayerData");
    local v191;

    if v190 and (v190.Data and v190.Data.BossRush) then
        v191 = v190.Data.BossRush;
    else
        v191 = nil;
    end;

    if u16 then
        u16.Text = "Highest Floor: " .. (v191 and (v191.HighestFloor or 0) or 0);
    end;

    if u17 then
        local v192 = v191 and v191.FastestFloor100 or 0;
        local v193;

        if v192 <= 0 then
            v193 = "--:--";
        else
            local math_floor_ret = math.floor(v192 / 60);
            local math_floor_ret2 = math.floor(v192 % 60);
            v193 = string.format("%02d:%02d", math_floor_ret, math_floor_ret2);
        end;

        u17.Text = "Floor 100 Time: " .. v193;
    end;

    if u19 then
        u19.Text = "SEASON " .. BossRushData.CURRENT_SEASON .. " - ENDS IN --:--:--";
    end;
end;

local function GetRushProgress() -- Line: 1058
    -- upvalues: Registry (copy)
    local v194 = Registry:Get("PlayerData");

    if v194 and v194.Data then
        return v194.Data.BossRush;
    end;

    return nil;
end;

local function IsMilestoneClaimed(p195: number) -- Line: 1068
    -- upvalues: Registry (copy), BossRushData (copy)
    local v196 = Registry:Get("PlayerData");
    local v197;

    if v196 and v196.Data then
        v197 = v196.Data.BossRush;
    else
        v197 = nil;
    end;

    if not v197 then
        return false;
    end;

    if v197.Season ~= BossRushData.CURRENT_SEASON then
        return false;
    end;

    local v198;

    if v197.ClaimedRewards == nil then
        v198 = false;
    else
        v198 = table.find(v197.ClaimedRewards, p195) ~= nil;
    end;

    return v198;
end;

local function IsMilestoneUnlocked(p199: number) -- Line: 1075
    -- upvalues: BossRushData (copy), Registry (copy)
    local v200 = BossRushData.MILESTONES[p199];

    if not v200 then
        return false;
    end;

    local v201 = Registry:Get("PlayerData");
    local v202;

    if v201 and v201.Data then
        v202 = v201.Data.BossRush;
    else
        v202 = nil;
    end;

    return (v202 and v202.HighestFloor or 0) >= v200.Floor;
end;

local function HasClaimableMilestone() -- Line: 1086
    -- upvalues: BossRushData (copy), Registry (copy)
    for i = 1, #BossRushData.MILESTONES do
        local v203 = BossRushData.MILESTONES[i];
        local v204;

        if v203 then
            local v205 = Registry:Get("PlayerData");
            local v206;

            if v205 and v205.Data then
                v206 = v205.Data.BossRush;
            else
                v206 = nil;
            end;

            v204 = (v206 and v206.HighestFloor or 0) >= v203.Floor;
        else
            v204 = false;
        end;

        local v207;

        if v204 then
            local v208 = Registry:Get("PlayerData");
            local v209;

            if v208 and v208.Data then
                v209 = v208.Data.BossRush;
            else
                v209 = nil;
            end;

            local v210;

            if v209 and (v209.Season == BossRushData.CURRENT_SEASON and v209.ClaimedRewards ~= nil) then
                v210 = table.find(v209.ClaimedRewards, i) ~= nil;
            else
                v210 = false;
            end;

            if not v210 then
                return true;
            end;

            v207 = i;
        else
            v207 = i;
        end;
    end;

    return false;
end;

local function ResolveReward(p211) -- Line: 1099
    -- upvalues: Image_Data (copy), ItemData (copy), PackageData (copy)
    local Type = p211.Type;

    if Type == "Currency" then
        return {
            Name = "Coins",
            Category = "Currency",
            Icon = Image_Data.Rewards.Cash,
            Amount = p211.Amount
        };
    end;

    if Type == "Stars" then
        return {
            Name = "Stars",
            Category = "Stars",
            Icon = Image_Data.Rewards.Stars,
            Amount = p211.Amount
        };
    end;

    if Type == "ForgeStones" then
        return {
            Name = "Forge Stone",
            Category = "Forge Material",
            Icon = Image_Data.ForgeMaterials["Forge Stone"],
            Amount = p211.Amount
        };
    end;

    if Type == "ReforgeStone" then
        return {
            Name = "Reforge Stone",
            Category = "Forge Material",
            Icon = Image_Data.ForgeMaterials["Reforge Stone"],
            Amount = p211.Amount
        };
    end;

    if Type == "Material" then
        local v212 = ItemData.Index[p211.Id];

        return {
            Category = "Material",
            Icon = v212 and (v212.Icon or "") or "",
            Name = v212 and v212.Name or p211.Id,
            Amount = p211.Amount
        };
    end;

    if Type == "NormalSpins" then
        return {
            Name = "Normal Spins",
            Category = "Spins",
            Icon = Image_Data.Rewards.NormalSpins,
            Amount = p211.Amount
        };
    end;

    if Type == "LuckySpins" then
        return {
            Name = "Lucky Spins",
            Category = "Spins",
            Icon = Image_Data.Rewards.LuckySpins,
            Amount = p211.Amount
        };
    end;

    if Type == "Title" then
        local v213 = p211.TitleId and p211.TitleId:gsub("_", " ") or "";

        return {
            Amount = nil,
            Category = "Title",
            Icon = Image_Data.Rewards.Title,
            Name = "Title: " .. v213
        };
    end;

    if Type == "Cosmetic" then
        return {
            Amount = nil,
            Category = "Cosmetic",
            Icon = Image_Data.Rewards.Cosmetic,
            Name = p211.CosmeticId or "Cosmetic"
        };
    end;

    if Type ~= "Package" then
        return {
            Icon = "",
            Name = tostring(Type),
            Amount = p211.Amount,
            Category = tostring(Type)
        };
    end;

    local v214 = p211.Id and PackageData.Get(p211.Id);

    return {
        Amount = nil,
        Category = "Package",
        Icon = v214 and (v214.Icon or "") or "",
        Name = v214 and v214.Name or "Package"
    };
end;

local function ComposeName(p215) -- Line: 1132
    -- upvalues: FormatCommas (copy)
    if p215.Amount then
        return FormatCommas(p215.Amount) .. " " .. p215.Name;
    end;

    return p215.Name;
end;

local function FireMilestoneNotifications(p216) -- Line: 1141
    -- upvalues: Registry (copy), Image_Data (copy), ItemData (copy), PackageData (copy)
    local v217 = Registry:Get("ItemNotification");

    if not v217 then
        return;
    end;

    for _, v in p216.Rewards do
        if v.Type == "ForgeStones" then
            v217.ShowItem("Forge Stone", Image_Data.ForgeMaterials["Forge Stone"], Color3.fromRGB(255, 180, 80), v.Amount);
        elseif v.Type == "ReforgeStone" then
            v217.ShowItem("Reforge Stone", Image_Data.ForgeMaterials["Reforge Stone"], Color3.fromRGB(120, 220, 255), v.Amount);
        elseif v.Type == "Material" then
            local v218 = ItemData.Index[v.Id];
            v217.ShowItem(v218 and v218.Name or v.Id, v218 and v218.Icon or "", Color3.fromRGB(255, 200, 120), v.Amount);
        elseif v.Type == "NormalSpins" then
            v217.ShowItem("Normal Spins", Image_Data.Rewards.NormalSpins, Color3.fromRGB(255, 220, 80), v.Amount);
        elseif v.Type == "LuckySpins" then
            v217.ShowItem("Lucky Spins", Image_Data.Rewards.LuckySpins, Color3.fromRGB(120, 255, 150), v.Amount);
        elseif v.Type == "Title" then
            local v219 = v.TitleId and v.TitleId:gsub("_", " ") or "Title";
            v217.ShowItem("Title: " .. v219, Image_Data.Rewards.Title, Color3.fromRGB(255, 220, 80));
        elseif v.Type == "Cosmetic" then
            v217.ShowItem(v.CosmeticId, Image_Data.Rewards.Cosmetic, Color3.fromRGB(200, 120, 255));
        elseif v.Type == "Package" then
            local v220 = v.Id and PackageData.Get(v.Id);
            v217.ShowItem(v220 and (v220.Name or "Package") or "Package", v220 and v220.Icon or "", Color3.fromRGB(255, 60, 60));
        end;
    end;
end;

local function ClearExtraRewardChips() -- Line: 1171
    -- upvalues: u62 (copy)
    for _, v in u62 do
        if v and v.Parent then
            v:Destroy();
        end;
    end;

    table.clear(u62);
end;

local function SetRowSelected(p221: number, p222: boolean) -- Line: 1179
    -- upvalues: u61 (copy)
    local v223 = u61[p221];

    if v223 and v223.selectFrame then
        v223.selectFrame.Visible = p222;
    end;
end;

local function ShowMilestoneInfo(p224: number) -- Line: 1189
    -- upvalues: BossRushData (copy), u63 (ref), u61 (copy), ResolveReward (copy), u52 (ref), FormatCommas (copy), u53 (ref), u54 (ref), ClearExtraRewardChips (copy), u58 (ref), u59 (ref), u60 (ref), u47 (ref), UIController (copy), u20 (ref), CollectionService (copy), ItemIndex (copy), u62 (copy), Registry (copy), u55 (ref), u56 (ref), u57 (ref)
    local v225 = BossRushData.MILESTONES[p224];

    if not v225 then
        return;
    end;

    if u63 and u63 ~= p224 then
        local v226 = u61[u63];

        if v226 and v226.selectFrame then
            v226.selectFrame.Visible = false;
        end;
    end;

    u63 = p224;
    local v227 = u61[p224];

    if v227 and v227.selectFrame then
        v227.selectFrame.Visible = true;
    end;

    local Rewards = v225.Rewards;
    local v228 = Rewards[1] and ResolveReward(Rewards[1]);

    if u52 then
        local v229;

        if v228 then
            local v230;

            if v228.Amount then
                v230 = FormatCommas(v228.Amount) .. " " .. v228.Name;
            else
                v230 = v228.Name;
            end;

            v229 = v230 or "";
        else
            v229 = "";
        end;

        u52.Text = v229;
    end;

    if u53 then
        u53.Text = v228 and (v228.Category or "") or "";
    end;

    if u54 then
        local v231 = v228 and v228.Icon or "";
        u54.Image = v231;
        u54.Visible = v231 ~= "";
    end;

    ClearExtraRewardChips();
    local v232 = #Rewards > 1;

    if u58 then
        u58.Visible = v232;
    end;

    if v232 and (u59 and u60) then
        local v234 = {
            hideOnOpen = u47,

            onReturn = function() -- Line: 1225, Name: onReturn
                -- upvalues: UIController (ref), u20 (ref), u47 (ref)
                local v233 = UIController.getByName("BossRush") or u20 and UIController.new(u20);

                if v233 then
                    v233:open();
                end;

                if u20 then
                    u20.Visible = false;
                end;

                if u47 then
                    u47.Visible = true;
                end;
            end
        };

        for i = 2, #Rewards do
            local v235 = ResolveReward(Rewards[i]);
            local v236 = u60:Clone();
            v236.Name = "Extra_" .. i;
            v236.LayoutOrder = i;
            v236.Visible = true;
            local Holder = v236:FindFirstChild("Holder");

            if Holder then
                Holder = Holder:FindFirstChild("Main");
            end;

            if Holder then
                local ItemImage = Holder:FindFirstChild("ItemImage");

                if ItemImage then
                    ItemImage.Image = v235.Icon;
                    ItemImage.Visible = v235.Icon ~= "";
                end;

                local Amount = Holder:FindFirstChild("Amount");

                if Amount then
                    if v235.Amount then
                        Amount.Text = "x" .. v235.Amount;
                        Amount.Visible = true;
                    else
                        Amount.Visible = false;
                    end;
                end;

                local ItemName = Holder:FindFirstChild("ItemName");

                if ItemName then
                    ItemName.Text = v235.Name;
                end;
            end;

            v236:SetAttribute("Tip", v235.Name);

            if not CollectionService:HasTag(v236, "ToolTip") then
                CollectionService:AddTag(v236, "ToolTip");
            end;

            local v237 = Rewards[i];
            local v238 = nil;

            if v237.Type == "ReforgeStone" then
                v238 = "Reforge Stone";
            elseif v237.Type == "ForgeStones" then
                v238 = "Forge Stone";
            elseif v237.Type == "Material" or (v237.Type == "ClassItem" or v237.Type == "Package") then
                v238 = v237.Id;
            end;

            ItemIndex.BindCard(v236, v238, v234);
            v236.Parent = u59;
            table.insert(u62, v236);
            local _ = i;
        end;

        local v239 = u59:FindFirstChildOfClass("UIListLayout");

        if v239 then
            u59.CanvasSize = UDim2.new(0, v239.AbsoluteContentSize.X, 0, v239.AbsoluteContentSize.Y);
        end;
    end;

    local v240 = Registry:Get("PlayerData");
    local v241;

    if v240 and v240.Data then
        v241 = v240.Data.BossRush;
    else
        v241 = nil;
    end;

    local v242;

    if v241 and (v241.Season == BossRushData.CURRENT_SEASON and v241.ClaimedRewards ~= nil) then
        v242 = table.find(v241.ClaimedRewards, p224) ~= nil;
    else
        v242 = false;
    end;

    local v243 = BossRushData.MILESTONES[p224];
    local v244;

    if v243 then
        local v245 = Registry:Get("PlayerData");
        local v246;

        if v245 and v245.Data then
            v246 = v245.Data.BossRush;
        else
            v246 = nil;
        end;

        v244 = (v246 and v246.HighestFloor or 0) >= v243.Floor;
    else
        v244 = false;
    end;

    if u55 then
        u55.Visible = v242;
    end;

    if u56 then
        u56.Visible = not v242;
        local v247;

        if v244 then
            v247 = not v242;
        else
            v247 = v244;
        end;

        u56.Active = v247;

        if u57 then
            u57.Text = v244 and "CLAIM" or "LOCKED";
        end;
    end;
end;

local function OnClaimClicked() -- Line: 1304
    -- upvalues: u63 (ref), u21 (ref), Registry (copy), BossRushData (copy), u56 (ref), u61 (copy), u55 (ref), u31 (ref), FireMilestoneNotifications (copy), u22 (ref), u23 (ref)
    local v248 = u63;

    if not (v248 and u21) then
        return;
    end;

    local v249 = Registry:Get("PlayerData");
    local v250;

    if v249 and v249.Data then
        v250 = v249.Data.BossRush;
    else
        v250 = nil;
    end;

    local v251;

    if v250 and (v250.Season == BossRushData.CURRENT_SEASON and v250.ClaimedRewards ~= nil) then
        v251 = table.find(v250.ClaimedRewards, v248) ~= nil;
    else
        v251 = false;
    end;

    if not v251 then
        local v252 = BossRushData.MILESTONES[v248];
        local v253;

        if v252 then
            local v254 = Registry:Get("PlayerData");
            local v255;

            if v254 and v254.Data then
                v255 = v254.Data.BossRush;
            else
                v255 = nil;
            end;

            v253 = (v255 and v255.HighestFloor or 0) >= v252.Floor;
        else
            v253 = false;
        end;

        if v253 then
            if u56 then
                u56.Active = false;
            end;

            local v256 = BossRushData.MILESTONES[v248];
            local v257, v258, v259 = u21:ClaimMilestoneReward(v248):await();

            if v257 and v258 then
                local v260 = u61[v248];

                if v260 and v260.claimedOverlay then
                    v260.claimedOverlay.Visible = true;
                end;

                if u55 then
                    u55.Visible = true;
                end;

                if u56 then
                    u56.Visible = false;
                end;

                if u31 then
                    u31:Update("BossRushRewards");
                end;

                if v256 then
                    FireMilestoneNotifications(v256);
                end;

                if u22 then
                    pcall(function() -- Line: 1328
                        -- upvalues: u22 (ref)
                        u22:Play("sfx celeste Level Up");
                    end);
                end;
            else
                if u56 then
                    u56.Active = true;
                end;

                if u23 then
                    u23:Show("Custom", type(v259) == "string" and v259 and v259 or "Failed to claim reward", 3, Color3.fromRGB(255, 100, 100), Color3.fromRGB(60, 20, 20), "Error");
                end;
            end;
        end;
    end;
end;

local function PaintMilestoneRow(p261: any, u262: number, p263: any) -- Line: 1344
    -- upvalues: ResolveReward (copy), FormatCommas (copy), Registry (copy), BossRushData (copy), u63 (ref), ShowMilestoneInfo (copy), u61 (copy)
    p261.Name = "Milestone_" .. u262;
    p261.LayoutOrder = u262;
    p261.Visible = true;
    local v264 = p263.Rewards[1] and ResolveReward(p263.Rewards[1]);
    local Frame = p261:FindFirstChild("Frame");

    if Frame then
        local ItemName = Frame:FindFirstChild("ItemName");

        if ItemName then
            local v265;

            if v264 then
                local v266;

                if v264.Amount then
                    v266 = FormatCommas(v264.Amount) .. " " .. v264.Name;
                else
                    v266 = v264.Name;
                end;

                v265 = v266 or "";
            else
                v265 = "";
            end;

            ItemName.Text = v265;
        end;

        local ItemImage = Frame:FindFirstChild("ItemImage");

        if ItemImage then
            local v267 = v264 and v264.Icon or "";
            ItemImage.Image = v267;
            ItemImage.Visible = v267 ~= "";
        end;

        local Requirement = Frame:FindFirstChild("Requirement");

        if Requirement then
            Requirement.Text = "Floor: " .. p263.Floor;
        end;
    end;

    local Claimed = p261:FindFirstChild("Claimed");

    if Claimed then
        local v268 = Registry:Get("PlayerData");
        local v269;

        if v268 and v268.Data then
            v269 = v268.Data.BossRush;
        else
            v269 = nil;
        end;

        local v270;

        if v269 and (v269.Season == BossRushData.CURRENT_SEASON and v269.ClaimedRewards ~= nil) then
            v270 = table.find(v269.ClaimedRewards, u262) ~= nil;
        else
            v270 = false;
        end;

        Claimed.Visible = v270;
    end;

    local Select = p261:FindFirstChild("Select");

    if Select then
        Select.Visible = false;
        p261.MouseEnter:Connect(function() -- Line: 1373
            -- upvalues: u63 (ref), u262 (copy), Select (copy)
            if u63 ~= u262 then
                Select.Visible = true;
            end;
        end);
        p261.MouseLeave:Connect(function() -- Line: 1376
            -- upvalues: u63 (ref), u262 (copy), Select (copy)
            if u63 ~= u262 then
                Select.Visible = false;
            end;
        end);
    end;

    p261.MouseButton1Click:Connect(function() -- Line: 1381
        -- upvalues: ShowMilestoneInfo (ref), u262 (copy)
        ShowMilestoneInfo(u262);
    end);
    u61[u262] = {
        clone = p261,
        selectFrame = Select,
        claimedOverlay = Claimed
    };
end;

local function BuildMilestoneList() -- Line: 1390
    -- upvalues: u49 (ref), u50 (ref), u61 (copy), u64 (ref), BossRushData (copy), PaintMilestoneRow (copy), RevealCascade (copy), u47 (ref), u63 (ref), ShowMilestoneInfo (copy)
    if not (u49 and u50) then
        return;
    end;

    for _, v in u61 do
        if v.clone and v.clone.Parent then
            v.clone:Destroy();
        end;
    end;

    table.clear(u61);
    u64 = u64 + 1;
    local u271 = u64;
    local v272 = {};

    for i, v in BossRushData.MILESTONES do
        table.insert(v272, {
            idx = i,
            milestone = v
        });
    end;

    table.sort(v272, function(p273, p274) -- Line: 1407
        return p273.idx < p274.idx;
    end);
    local v275 = {};

    for _, v in v272 do
        local v276 = u50:Clone();
        PaintMilestoneRow(v276, v.idx, v.milestone);
        v276.Parent = u49;
        table.insert(v275, v276);
    end;

    RevealCascade.play(v275, {
        isCurrent = function() -- Line: 1418, Name: isCurrent
            -- upvalues: u47 (ref), u64 (ref), u271 (copy)
            local v277;

            if u47 == nil then
                v277 = false;
            else
                v277 = u47.Visible and u64 == u271;
            end;

            return v277;
        end
    });
    local v278 = u63;

    if not (v278 and u61[v278]) then
        v278 = v272[1] and v272[1].idx or nil;
    end;

    u63 = nil;

    if v278 then
        ShowMilestoneInfo(v278);
    end;
end;

local function RefreshRewardsWindow() -- Line: 1435
    -- upvalues: BuildMilestoneList (copy)
    BuildMilestoneList();
end;

local function SwitchToRewards() -- Line: 1439
    -- upvalues: u47 (ref), u20 (ref), u51 (ref), BuildMilestoneList (copy)
    if not (u47 and u20) then
        return;
    end;

    u51 = true;
    u20.Visible = false;
    u47.Visible = true;
    BuildMilestoneList();
end;

local function SwitchToPass() -- Line: 1447
    -- upvalues: u51 (ref), u47 (ref), u20 (ref)
    u51 = false;

    if u47 then
        u47.Visible = false;
    end;

    if u20 then
        u20.Visible = true;
    end;
end;

local function OnOpen() -- Line: 1455
    -- upvalues: u5 (ref), u3 (ref), RefreshPartyRoster (copy), RefreshStatsDisplay (copy), PopulateShowcaseRewards (copy), u76 (copy)
    u5 = true;

    if u3 then
        task.spawn(function() -- Line: 1460
            -- upvalues: u3 (ref), RefreshPartyRoster (ref)
            u3:RequestSelectMode("BossRush"):await();
            local v279, v280 = u3:RequestPartyData():await();

            if v279 and v280 then
                RefreshPartyRoster(v280);
            end;
        end);
    end;

    RefreshStatsDisplay();
    PopulateShowcaseRewards();

    for _, v in u76 do
        if v.animTrack and not v.animTrack.IsPlaying then
            v.animTrack:Play();
        end;
    end;
end;

local function OnClose() -- Line: 1481
    -- upvalues: u5 (ref), u51 (ref), u47 (ref), u76 (copy), u3 (ref)
    u5 = false;
    u51 = false;

    if u47 then
        u47.Visible = false;
    end;

    for _, v in u76 do
        if v.animTrack and v.animTrack.IsPlaying then
            v.animTrack:Stop();
        end;
    end;

    if u3 then
        task.spawn(function() -- Line: 1497
            -- upvalues: u3 (ref)
            u3:RequestSelectMode("Dungeon"):await();
        end);
    end;
end;

local v281 = Knit.CreateController({
    Name = "BossRushSelectController"
});

function v281.Open(p282) -- Line: 1509
    -- upvalues: u5 (ref), u11 (ref), OnOpen (copy)
    if u5 then
        return;
    end;

    if not u11 then
        return;
    end;

    u11:open();
    OnOpen();
end;

function v281.Close(p283) -- Line: 1516
    -- upvalues: u5 (ref), u11 (ref)
    if not u5 then
        return;
    end;

    if not u11 then
        return;
    end;

    u11:close();
end;

function v281.Toggle(p284) -- Line: 1522
    -- upvalues: u5 (ref)
    if u5 then
        p284:Close();

        return;
    end;

    p284:Open();
end;

function v281.IsOpen(p285) -- Line: 1530
    -- upvalues: u5 (ref)
    return u5;
end;

function v281.KnitInit(p286) -- Line: 1536
    -- upvalues: Knit (copy), u20 (ref), u11 (ref), UIController (copy), OnClose (copy), u32 (ref), u18 (ref), u19 (ref), u16 (ref), u17 (ref), u7 (ref), u24 (ref), u8 (ref), u13 (ref), u2 (ref), u14 (ref), u12 (ref), u33 (ref), u15 (ref), u25 (ref), u29 (ref), u4 (ref), u26 (ref), u6 (ref), u34 (ref), u35 (ref), u36 (ref), u37 (ref), u38 (ref), u39 (ref), MAX_PARTY_SIZE (copy), u40 (copy), u42 (ref), u43 (ref), u44 (ref), u45 (ref), u47 (ref), u48 (ref), u49 (ref), u50 (ref), u52 (ref), u55 (ref), u53 (ref), u54 (ref), u56 (ref), u57 (ref), u58 (ref), u59 (ref), u60 (ref)
    local Frames = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("Frames");
    u20 = Frames:FindFirstChild("BossRush");

    if not u20 then
        warn("[BossRushSelectController] BossRush frame not found in Main.Frames");

        return;
    end;

    u20.Visible = false;
    u11 = UIController._cached[u20] or UIController.new(u20);
    u11.onClose = OnClose;
    u32 = u20:FindFirstChild("Close");
    local Content = u20:FindFirstChild("Content");

    if not Content then
        warn("[BossRushSelectController] BossRush.Content not found");

        return;
    end;

    u18 = Content:FindFirstChild("LeftFrame");

    if u18 then
        u19 = u18:FindFirstChild("Season_Time");
        local Text = u18:FindFirstChild("Text");

        if Text then
            u16 = Text:FindFirstChild("Highest_Floor");
            u17 = Text:FindFirstChild("Floor_100_Time");
        end;

        u7 = u18:FindFirstChild("CanvasGroup");

        if u7 then
            u24 = { u7:FindFirstChild("Viewport_1"), u7:FindFirstChild("Viewport_2"), u7:FindFirstChild("Viewport_3") };
        end;

        u8 = u18:FindFirstChild("CycleForward");
        local v287 = u8 and u8:FindFirstChild("BossName");
        u13 = v287;
        u2 = u18:FindFirstChild("CycleBack");
        local v288 = u2 and u2:FindFirstChild("BossName");
        u14 = v288;
        local Display = u18:FindFirstChild("Display");

        if Display then
            Display = Display:FindFirstChild("BossName");
        end;

        u12 = Display;
        u33 = u18:FindFirstChild("SkipToggle");
        local v289 = u33 and u33:FindFirstChild("Check");
        u15 = v289;
        u25 = u18:FindFirstChild("Skip");

        if u25 then
            u29 = u25:FindFirstChild("ImageButton");
            u4 = u25:FindFirstChild("Amount");
            u26 = u25:FindFirstChild("Skip_Floor");
            u6 = u25:FindFirstChild("ItemImage");
        end;
    end;

    local Buttons = Content:FindFirstChild("Buttons");

    if Buttons then
        u34 = Buttons:FindFirstChild("Rewards");
        local Enter = Buttons:FindFirstChild("Enter");

        if Enter then
            u35 = Enter;
            u36 = Enter:FindFirstChild("Text");
        end;

        u37 = Buttons:FindFirstChild("Leave");
    end;

    u38 = Content:FindFirstChild("RightFrame");

    if u38 then
        local Party = u38:FindFirstChild("Party");

        if Party then
            Party = Party:FindFirstChild("Players");
        end;

        u39 = Party;

        if u39 then
            for i = 1, MAX_PARTY_SIZE do
                local v290 = u39:FindFirstChild((tostring(i)));
                local v291;

                if v290 then
                    local Player = v290:FindFirstChild("Player");
                    local v292 = {
                        Slot = v290,
                        PlayerCard = Player,
                        AddCard = v290:FindFirstChild("Add")
                    };
                    local v293;

                    if Player then
                        v293 = Player:FindFirstChild("ProfileImage");
                    else
                        v293 = Player;
                    end;

                    v292.ProfileImage = v293;
                    local v294;

                    if Player then
                        v294 = Player:FindFirstChild("PlayerName");
                    else
                        v294 = Player;
                    end;

                    v292.PlayerName = v294;

                    if Player then
                        Player = Player:FindFirstChild("PlayerLevel");
                    end;

                    v292.PlayerLevel = Player;
                    u40[i] = v292;
                    v291 = i;
                else
                    v291 = i;
                end;
            end;
        end;

        local Rewards = u38:FindFirstChild("Rewards");

        if Rewards then
            u42 = Rewards:FindFirstChild("Coins");
            u43 = Rewards:FindFirstChild("EXP");
            u44 = Rewards:FindFirstChild("ScrollingFrame");

            if u44 then
                u45 = u44:FindFirstChild("Template");

                if u45 then
                    u45.Visible = false;
                end;
            end;
        end;
    end;

    u47 = Frames:FindFirstChild("BossRush_Rewards");

    if u47 then
        u47.Visible = false;
        u48 = u47:FindFirstChild("Exit");
        local Contents = u47:FindFirstChild("Contents");

        if Contents then
            local LeftSection = Contents:FindFirstChild("LeftSection");

            if LeftSection then
                LeftSection = LeftSection:FindFirstChild("RewardsList");
            end;

            u49 = LeftSection;

            if u49 then
                u50 = u49:FindFirstChild("Template");

                if u50 then
                    u50.Visible = false;
                end;

                local TopPadding = u49:FindFirstChild("TopPadding");

                if TopPadding then
                    TopPadding.LayoutOrder = -100000;
                end;

                local BottomPadding = u49:FindFirstChild("BottomPadding");

                if BottomPadding then
                    BottomPadding.LayoutOrder = 100000;
                end;
            end;

            local RightSection = Contents:FindFirstChild("RightSection");

            if RightSection then
                RightSection = RightSection:FindFirstChild("ItemInfo");
            end;

            if RightSection then
                u52 = RightSection:FindFirstChild("ItemName");
                u55 = RightSection:FindFirstChild("Claimed");
                local Info = RightSection:FindFirstChild("Info");

                if Info then
                    local Rarity = Info:FindFirstChild("Rarity");

                    if Rarity then
                        Rarity = Rarity:FindFirstChild("Info");
                    end;

                    u53 = Rarity;
                    u54 = Info:FindFirstChild("ItemImage");
                end;

                local Button = RightSection:FindFirstChild("Button");

                if Button then
                    Button = Button:FindFirstChild("Claim");
                end;

                u56 = Button;
                local v295 = u56 and u56:FindFirstChild("TextLabel");
                u57 = v295;
                u58 = RightSection:FindFirstChild("Rewards");

                if u58 then
                    u59 = u58:FindFirstChild("ScrollingFrame");
                    u60 = u59 and u59:FindFirstChild("Template");

                    if u60 then
                        u60.Visible = false;
                    end;
                end;
            end;
        end;
    else
        warn("[BossRushSelectController] BossRush_Rewards frame not found — sub-view unavailable");
    end;
end;

function v281.KnitStart(u296) -- Line: 1711
    -- upvalues: u20 (ref), u3 (ref), Knit (copy), u21 (ref), u22 (ref), u23 (ref), u28 (ref), u10 (ref), u31 (ref), u34 (ref), HasClaimableMilestone (copy), Registry (copy), BuildCarousel (copy), u8 (ref), u65 (ref), u66 (ref), u73 (ref), FINAL_BOSS_ORDER (copy), u67 (ref), AnimateStep (copy), u2 (ref), u33 (ref), OnSkipTogglePressed (copy), u29 (ref), OnSkipCyclePressed (copy), u6 (ref), u15 (ref), Color3_fromRGB_ret2 (copy), u25 (ref), u9 (ref), BossRushData (copy), u30 (ref), u4 (ref), u26 (ref), ReplicatedStorage (copy), u5 (ref), OnOpen (copy), u51 (ref), OnClose (copy), u32 (ref), u11 (ref), SwitchToRewards (copy), u48 (ref), SwitchToPass (copy), u56 (ref), OnClaimClicked (copy), MAX_PARTY_SIZE (copy), u40 (copy), u41 (copy), OpenInvitePicker (copy), u35 (ref), u74 (ref), u36 (ref), u37 (ref), RefreshPartyRoster (copy)
    if not u20 then
        return;
    end;

    pcall(function() -- Line: 1715
        -- upvalues: u3 (ref), Knit (ref)
        u3 = Knit.GetService("DungeonQueueService");
    end);
    pcall(function() -- Line: 1716
        -- upvalues: u21 (ref), Knit (ref)
        u21 = Knit.GetService("BossRushService");
    end);
    pcall(function() -- Line: 1717
        -- upvalues: u22 (ref), Knit (ref)
        u22 = Knit.GetController("SoundController");
    end);
    pcall(function() -- Line: 1718
        -- upvalues: u23 (ref), Knit (ref)
        u23 = Knit.GetController("NotificationController");
    end);
    pcall(function() -- Line: 1719
        -- upvalues: u28 (ref), Knit (ref)
        u28 = Knit.GetController("PlayerListController");
    end);
    pcall(function() -- Line: 1720
        -- upvalues: u10 (ref), Knit (ref)
        u10 = Knit.GetController("WarningController");
    end);
    pcall(function() -- Line: 1721
        -- upvalues: u31 (ref), Knit (ref)
        u31 = Knit.GetController("NoticeController");
    end);

    if u31 and u34 then
        local Notice = u34:FindFirstChild("Notice", true);

        if Notice then
            u31:Register("BossRushRewards", Notice, HasClaimableMilestone);
            local v297 = Registry:Get("PlayerData");

            if v297 then
                v297:OnChange(function(p298, p299) -- Line: 1735
                    -- upvalues: u31 (ref)
                    if p299[1] == "BossRush" then
                        u31:Update("BossRushRewards");
                    end;
                end);
            end;
        else
            warn("[BossRushSelectController] Buttons.Rewards.Notice not found — claimable badge disabled");
        end;
    end;

    task.spawn(BuildCarousel);

    if u8 then
        u8.Activated:Connect(function() -- Line: 1751
            -- upvalues: u65 (ref), u66 (ref), u73 (ref), FINAL_BOSS_ORDER (ref), u67 (ref), AnimateStep (ref), u3 (ref)
            if u65 then
                if u66 then
                    return;
                end;

                if not u73 then
                    return;
                end;

                if #FINAL_BOSS_ORDER < 2 then
                    return;
                end;

                local v300 = FINAL_BOSS_ORDER[(u67 + 1 - 1) % #FINAL_BOSS_ORDER + 1];
                AnimateStep(1);

                if u3 then
                    u3:RequestSelectFinalBoss(v300);
                end;
            end;
        end);
    end;

    if u2 then
        u2.Activated:Connect(function() -- Line: 1754
            -- upvalues: u65 (ref), u66 (ref), u73 (ref), FINAL_BOSS_ORDER (ref), u67 (ref), AnimateStep (ref), u3 (ref)
            if u65 then
                if u66 then
                    return;
                end;

                if not u73 then
                    return;
                end;

                if #FINAL_BOSS_ORDER < 2 then
                    return;
                end;

                local v301 = FINAL_BOSS_ORDER[(u67 + -1 - 1) % #FINAL_BOSS_ORDER + 1];
                AnimateStep(-1);

                if u3 then
                    u3:RequestSelectFinalBoss(v301);
                end;
            end;
        end);
    end;

    if u33 then
        u33.Activated:Connect(OnSkipTogglePressed);
    end;

    if u29 then
        u29.Activated:Connect(OnSkipCyclePressed);
    end;

    if u6 and u6:IsA("ImageLabel") then
        u6.Image = "rbxassetid://126472006264478";
    end;

    if u15 then
        local Attribute = u15:GetAttribute("Off");

        if Attribute then
            u15.Position = Attribute;
        end;

        u15.BackgroundColor3 = Color3_fromRGB_ret2;
    end;

    if u25 then
        u25.GroupTransparency = u9 and 0 or 0.7;

        if u29 then
            u29.Interactable = u9 and u73;
        end;
    end;

    local SkipCost = BossRushData.GetSkipCost(u30);

    if u4 then
        u4.Text = "x" .. SkipCost;
    end;

    if u26 then
        u26.Text = "Floor: " .. (u30 > 0 and tostring(u30) or "-");
    end;

    task.spawn(function() -- Line: 1775
        -- upvalues: u296 (copy)
        local v302 = workspace:WaitForChild("Prompts"):WaitForChild("BossRush"):FindFirstChildOfClass("ProximityPrompt");

        if v302 then
            v302.PromptShown:Connect(function() -- Line: 1781
                -- upvalues: u296 (ref)
                u296:Open();
            end);
            v302.PromptHidden:Connect(function() -- Line: 1784
                -- upvalues: u296 (ref)
                u296:Close();
            end);
            v302.Triggered:Connect(function() -- Line: 1787
                -- upvalues: u296 (ref)
                u296:Toggle();
            end);
        end;
    end);
    local v303 = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("AdminOpenBossRush");

    if v303 then
        v303.OnClientEvent:Connect(function() -- Line: 1797
            -- upvalues: u296 (copy)
            u296:Open();
        end);
    end;

    u20:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 1805
        -- upvalues: u20 (ref), u5 (ref), OnOpen (ref), u51 (ref), OnClose (ref)
        if u20.Visible then
            if not u5 then
                OnOpen();
            end;
        else
            if u51 then
                return;
            end;

            if u5 then
                OnClose();
            end;
        end;
    end);

    if u32 then
        u32.Activated:Connect(function() -- Line: 1820
            -- upvalues: u11 (ref)
            if u11 then
                u11:close();
            end;
        end);
    end;

    if u34 then
        u34.Activated:Connect(SwitchToRewards);
    end;

    if u48 then
        u48.Activated:Connect(SwitchToPass);
    end;

    if u56 then
        u56.Activated:Connect(OnClaimClicked);
    end;

    for i = 1, MAX_PARTY_SIZE do
        local v304 = u40[i];
        local v305;

        if v304 and (v304.Slot and v304.Slot:IsA("GuiButton")) then
            v304.Slot.Activated:Connect(function() -- Line: 1846
                -- upvalues: u73 (ref), u41 (ref), i (copy), OpenInvitePicker (ref)
                if not u73 then
                    return;
                end;

                if u41[i] == nil then
                    OpenInvitePicker();
                end;
            end);
            v305 = i;
        else
            v305 = i;
        end;
    end;

    if u35 then
        u35.Activated:Connect(function() -- Line: 1859
            -- upvalues: u73 (ref), u3 (ref), u74 (ref), u35 (ref), u36 (ref), u22 (ref), u23 (ref)
            if not u73 then
                return;
            end;

            if not u3 then
                return;
            end;

            if u74 then
                return;
            end;

            u74 = true;
            u35.Active = false;

            if u36 then
                u36.Text = "MOVING...";
            end;

            local v306, v307, v308 = u3:RequestEnter():await();

            if v306 and v307 then
                if u22 then
                    pcall(function() -- Line: 1875
                        -- upvalues: u22 (ref)
                        u22:PlaySound("GiftReceived");
                    end);
                end;

                task.delay(20, function() -- Line: 1878
                    -- upvalues: u36 (ref), u74 (ref), u35 (ref)
                    if u36 and u36.Text == "MOVING..." then
                        u36.Text = "ENTER";
                        u74 = false;

                        if u35 then
                            u35.Active = true;
                        end;
                    end;
                end);

                return;
            end;

            if u36 then
                u36.Text = "ENTER";
            end;

            u74 = false;
            u35.Active = true;

            if u23 then
                if type(v308) ~= "string" then
                    v308 = (v306 or type(v307) ~= "string") and "Failed to start Boss Rush" or v307;
                end;

                u23:Show("Custom", v308, 3, Color3.fromRGB(255, 200, 80), Color3.fromRGB(60, 45, 15), "Error");
            end;
        end);
    end;

    if u37 then
        u37.Activated:Connect(function() -- Line: 1908
            -- upvalues: u3 (ref)
            if u3 then
                u3:RequestLeaveParty();
            end;
        end);
    end;

    if u3 then
        u3.PartyUpdate:Connect(function(p309) -- Line: 1920
            -- upvalues: u5 (ref), RefreshPartyRoster (ref)
            if not u5 then
                return;
            end;

            RefreshPartyRoster(p309);
        end);
    end;
end;

return v281;