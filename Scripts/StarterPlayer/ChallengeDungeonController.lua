--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ChallengeDungeonController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.ChallengeDungeonController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
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
local ChallengeData = require(ReplicatedStorage.GameInfo.ChallengeData);
local ChallengeRewardData = require(ReplicatedStorage.GameInfo.ChallengeRewardData);
local Class_Data = require(ReplicatedStorage.Classes.Class_Data);
local ItemData = require(ReplicatedStorage.GameInfo.ItemData);
local ClassItemData = require(ReplicatedStorage.GameInfo.ClassItemData);
local RarityData = require(ReplicatedStorage.GameInfo.RarityData);
local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
local Image_Data = require(ReplicatedStorage.GameInfo.Image_Data);
local PackageData = require(ReplicatedStorage.GameInfo.PackageData);
local EnemyResolver = require(ReplicatedStorage.GameInfo.EnemyResolver);
local QuestItemData = require(ReplicatedStorage.GameInfo.QuestItemData);
local ConsumableData = require(ReplicatedStorage.GameInfo.ConsumableData);
local BuffPotionData = require(ReplicatedStorage.GameInfo.BuffPotionData);
local LocalPlayer = Players.LocalPlayer;
local Color3_new_ret = Color3.new(1, 1, 1);
local RarityIndex = RarityData.RarityIndex;
local HeadShot = Enum.ThumbnailType.HeadShot;
local Size100x100 = Enum.ThumbnailSize.Size100x100;
local CFrame_new_ret = CFrame.new(Vector3.new(0, 0.5, -12), Vector3.new(0, 0.5, 0));
local CFrame_new_ret2 = CFrame.new(0, 0.5, 0);
local TweenInfo_new_ret = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local BOSS_PREVIEW_ORDER = ChallengeData.BOSS_PREVIEW_ORDER;
local PARTY_CAP = ChallengeData.PARTY_CAP;
local u1 = { "Leader_Viewport", "Player2_Viewport", "Player3_Viewport", "Player4_Viewport" };
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
local u12 = false;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = {};
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = nil;
local u26 = nil;
local u27 = nil;
local u28 = nil;
local u29 = nil;
local u30 = {};
local u31 = {};
local u32 = nil;
local u33 = nil;
local u34 = nil;
local u35 = nil;
local u36 = {};
local u37 = nil;
local u38 = nil;
local u39 = nil;
local u40 = nil;
local u41 = false;
local u42 = nil;
local u43 = nil;
local u44 = nil;
local u45 = nil;
local u46 = nil;
local u47 = nil;
local u48 = nil;
local u49 = nil;
local u50 = nil;
local u51 = {};
local u52 = {};
local u53 = nil;
local u54 = 0;
local u55 = false;
local u56 = false;
local u57 = 1;
local u58 = {};
local u59 = {};
local u60 = {};
local u61 = nil;
local u62 = false;
local u63 = false;
local u64 = {};
local u65 = {};

local function GetThumbnail(u66: number) -- Line: 202
    -- upvalues: Players (copy), HeadShot (copy), Size100x100 (copy)
    local success, result = pcall(function() -- Line: 203
        -- upvalues: Players (ref), u66 (copy), HeadShot (ref), Size100x100 (ref)
        return Players:GetUserThumbnailAsync(u66, HeadShot, Size100x100);
    end);

    return success and result and result or "";
end;

local function FormatCommas(p67: number) -- Line: 210
    local math_floor_ret = math.floor(p67);
    local v68 = tostring(math_floor_ret);
    local v69;

    repeat
        v68, v69 = v68:gsub("^(-?%d+)(%d%d%d)", "%1,%2");
    until v69 == 0;

    return v68;
end;

local function GetClassIdleAnim(p70: string) -- Line: 221
    -- upvalues: Class_Data (copy)
    local v71 = Class_Data[p70];

    if v71 and (v71.AnimationOverrides and v71.AnimationOverrides.idle) then
        return v71.AnimationOverrides.idle;
    end;

    return nil;
end;

local function RarityColorOf(p72: string?) -- Line: 229
    -- upvalues: RarityColors (copy), Color3_new_ret (copy)
    local v73 = RarityColors[p72];

    return v73 and v73.TextColor3 or Color3_new_ret;
end;

local function CycleIndex(p74: number) -- Line: 241
    -- upvalues: BOSS_PREVIEW_ORDER (copy)
    return (p74 - 1) % #BOSS_PREVIEW_ORDER + 1;
end;

local function BossDisplayName(p75: number) -- Line: 247
    -- upvalues: BOSS_PREVIEW_ORDER (copy)
    local v76 = BOSS_PREVIEW_ORDER[(p75 - 1) % #BOSS_PREVIEW_ORDER + 1];

    return v76 and (v76.Name or v76.HeroId or "") or "";
end;

local function OffsetPosition(p77, p78: number) -- Line: 253
    return UDim2.new(p77.X.Scale + p78, p77.X.Offset, p77.Y.Scale, p77.Y.Offset);
end;

local function RenderBossIntoViewport(u79: number, u80: any, p81: boolean?) -- Line: 260
    -- upvalues: u18 (ref), u60 (copy), SharedUtils (copy), EnemyResolver (copy)
    local u82 = u18[u79];

    if not u82 then
        return;
    end;

    if u80 then
        u80 = u80.HeroId;
    end;

    if not u80 then
        return;
    end;

    local u83 = u60[u79];

    if u83 and (u83.bossKey == u80 and not p81) then
        return;
    end;

    if u83 and u83.animTrack then
        pcall(function() -- Line: 273
            -- upvalues: u83 (copy)
            u83.animTrack:Stop();
        end);
    end;

    for _, child in u82:GetChildren() do
        if not child:IsA("UIGradient") then
            child:Destroy();
        end;
    end;

    u60[u79] = nil;
    local success, result = pcall(function() -- Line: 282
        -- upvalues: SharedUtils (ref), u80 (copy), EnemyResolver (ref), u82 (copy), u60 (ref), u79 (copy)
        local v84 = SharedUtils.CreateItem(u80, false, true);

        if not v84 then
            return;
        end;

        local Animate = v84:FindFirstChild("Animate");

        if Animate then
            Animate:Destroy();
        end;

        local v85 = EnemyResolver(u80);
        local WorldModel = Instance.new("WorldModel");
        WorldModel.Name = "CharacterWorld";
        WorldModel.Parent = u82;
        local Vector3_new_ret = Vector3.new(0, 2 + (v85 and v85.ViewportOffset and (v85.ViewportOffset.Y or 0) or 0), 3);
        v84.Parent = WorldModel;
        local Camera = Instance.new("Camera");
        Camera.CFrame = CFrame.new(0, 1.5, v85 and (v85.ViewportDistance or -2.5) or -2.5) * CFrame.Angles(0, 3.141592653589793, 0);
        Camera.Parent = u82;
        u82.CurrentCamera = Camera;
        local Vector3_new_ret2 = Vector3.new(Camera.CFrame.Position.X, 0, Camera.CFrame.Position.Z);
        v84:PivotTo(CFrame.new(Vector3_new_ret, Vector3_new_ret + (Vector3_new_ret2.Magnitude > 0 and Vector3_new_ret2.Unit or Vector3.new(0, 0, -1))) * CFrame.Angles(0, -0.4363323129985824, 0));
        local v86 = nil;

        if v85 then
            v85 = v85.IdleAnim;
        end;

        if v85 then
            local v87 = v84:FindFirstChildWhichIsA("Animator", true);

            if not v87 then
                local v88 = v84:FindFirstChildWhichIsA("Humanoid") or v84:FindFirstChildWhichIsA("AnimationController");

                if v88 then
                    v87 = Instance.new("Animator");
                    v87.Parent = v88;
                end;
            end;

            if v87 then
                local Animation = Instance.new("Animation");
                Animation.AnimationId = v85;
                v86 = v87:LoadAnimation(Animation);
                v86.Looped = true;
                v86:Play();
            end;
        end;

        u60[u79] = {
            bossKey = u80,
            worldModel = WorldModel,
            camera = Camera,
            animTrack = v86
        };
    end);

    if not success then
        warn("[ChallengeDungeonController] Failed to render carousel boss", u80, result);
    end;
end;

local function UpdateCarouselLabels() -- Line: 348
    -- upvalues: u21 (ref), u57 (ref), BOSS_PREVIEW_ORDER (copy), u22 (ref), u23 (ref)
    if u21 then
        local v89 = BOSS_PREVIEW_ORDER[(u57 - 1) % #BOSS_PREVIEW_ORDER + 1];
        u21.Text = v89 and (v89.Name or (v89.HeroId or "")) or "";
    end;

    if u22 then
        local v90 = BOSS_PREVIEW_ORDER[(u57 + 1 - 1) % #BOSS_PREVIEW_ORDER + 1];
        u22.Text = v90 and (v90.Name or (v90.HeroId or "")) or "";
    end;

    if u23 then
        local v91 = BOSS_PREVIEW_ORDER[(u57 - 1 - 1) % #BOSS_PREVIEW_ORDER + 1];
        u23.Text = v91 and (v91.Name or (v91.HeroId or "")) or "";
    end;
end;

local function SnapToIndex(p92: number) -- Line: 356
    -- upvalues: u57 (ref), BOSS_PREVIEW_ORDER (copy), u58 (ref), RenderBossIntoViewport (copy), u18 (ref), u59 (ref), u21 (ref), u22 (ref), u23 (ref)
    u57 = (p92 - 1) % #BOSS_PREVIEW_ORDER + 1;
    local v93 = #BOSS_PREVIEW_ORDER;
    u58 = {
        Main = 1,
        Next = 2,
        Previous = 3
    };
    RenderBossIntoViewport(1, BOSS_PREVIEW_ORDER[u57]);

    if u18[1] then
        u18[1].Position = u59.Main;
    end;

    if u18[2] then
        if v93 >= 2 then
            u18[2].Visible = true;
            RenderBossIntoViewport(2, BOSS_PREVIEW_ORDER[(u57 + 1 - 1) % #BOSS_PREVIEW_ORDER + 1]);
            u18[2].Position = u59.Next;
        else
            u18[2].Visible = false;
        end;
    end;

    if u18[3] then
        if v93 >= 3 then
            u18[3].Visible = true;
            RenderBossIntoViewport(3, BOSS_PREVIEW_ORDER[(u57 - 1 - 1) % #BOSS_PREVIEW_ORDER + 1]);
            u18[3].Position = u59.Previous;
        else
            u18[3].Visible = false;
        end;
    end;

    if u21 then
        local v94 = BOSS_PREVIEW_ORDER[(u57 - 1) % #BOSS_PREVIEW_ORDER + 1];
        u21.Text = v94 and (v94.Name or (v94.HeroId or "")) or "";
    end;

    if u22 then
        local v95 = BOSS_PREVIEW_ORDER[(u57 + 1 - 1) % #BOSS_PREVIEW_ORDER + 1];
        u22.Text = v95 and (v95.Name or (v95.HeroId or "")) or "";
    end;

    if u23 then
        local v96 = BOSS_PREVIEW_ORDER[(u57 - 1 - 1) % #BOSS_PREVIEW_ORDER + 1];
        u23.Text = v96 and (v96.Name or (v96.HeroId or "")) or "";
    end;
end;

local function AnimateStep(p97: number) -- Line: 391
    -- upvalues: BOSS_PREVIEW_ORDER (copy), SnapToIndex (copy), u57 (ref), u56 (ref), u58 (ref), TweenService (copy), u18 (ref), TweenInfo_new_ret (copy), u59 (ref), RenderBossIntoViewport (copy), u21 (ref), u22 (ref), u23 (ref)
    if #BOSS_PREVIEW_ORDER < 3 then
        SnapToIndex(u57 + p97);

        return;
    end;

    u56 = true;
    u57 = (u57 + p97 - 1) % #BOSS_PREVIEW_ORDER + 1;
    local Main = u58.Main;
    local Next = u58.Next;
    local Previous = u58.Previous;

    if p97 == 1 then
        TweenService:Create(u18[Next], TweenInfo_new_ret, {
            Position = u59.Main
        }):Play();
        TweenService:Create(u18[Main], TweenInfo_new_ret, {
            Position = u59.Previous
        }):Play();
        RenderBossIntoViewport(Previous, BOSS_PREVIEW_ORDER[(u57 + 1 - 1) % #BOSS_PREVIEW_ORDER + 1]);
        local Next2 = u59.Next;
        u18[Previous].Position = UDim2.new(Next2.X.Scale + 0.2, Next2.X.Offset, Next2.Y.Scale, Next2.Y.Offset);
        TweenService:Create(u18[Previous], TweenInfo_new_ret, {
            Position = u59.Next
        }):Play();
        u58 = {
            Main = Next,
            Previous = Main,
            Next = Previous
        };
    else
        TweenService:Create(u18[Previous], TweenInfo_new_ret, {
            Position = u59.Main
        }):Play();
        TweenService:Create(u18[Main], TweenInfo_new_ret, {
            Position = u59.Next
        }):Play();
        RenderBossIntoViewport(Next, BOSS_PREVIEW_ORDER[(u57 - 1 - 1) % #BOSS_PREVIEW_ORDER + 1]);
        local Previous2 = u59.Previous;
        u18[Next].Position = UDim2.new(Previous2.X.Scale + -0.2, Previous2.X.Offset, Previous2.Y.Scale, Previous2.Y.Offset);
        TweenService:Create(u18[Next], TweenInfo_new_ret, {
            Position = u59.Previous
        }):Play();
        u58 = {
            Main = Previous,
            Next = Main,
            Previous = Next
        };
    end;

    if u21 then
        local v98 = BOSS_PREVIEW_ORDER[(u57 - 1) % #BOSS_PREVIEW_ORDER + 1];
        u21.Text = v98 and (v98.Name or (v98.HeroId or "")) or "";
    end;

    if u22 then
        local v99 = BOSS_PREVIEW_ORDER[(u57 + 1 - 1) % #BOSS_PREVIEW_ORDER + 1];
        u22.Text = v99 and (v99.Name or (v99.HeroId or "")) or "";
    end;

    if u23 then
        local v100 = BOSS_PREVIEW_ORDER[(u57 - 1 - 1) % #BOSS_PREVIEW_ORDER + 1];
        u23.Text = v100 and (v100.Name or (v100.HeroId or "")) or "";
    end;

    task.delay(TweenInfo_new_ret.Time, function() -- Line: 430
        -- upvalues: u56 (ref)
        u56 = false;
    end);
end;

local function BuildCarousel() -- Line: 437
    -- upvalues: u55 (ref), u17 (ref), BOSS_PREVIEW_ORDER (copy), u59 (ref), u19 (ref), u20 (ref), SnapToIndex (copy)
    if u55 then
        return;
    end;

    if not u17 then
        return;
    end;

    if #BOSS_PREVIEW_ORDER == 0 then
        return;
    end;

    u59 = {
        Main = u17:GetAttribute("Main_Position"),
        Next = u17:GetAttribute("Next_Position"),
        Previous = u17:GetAttribute("Previous_Position")
    };

    if not (u59.Main and (u59.Next and u59.Previous)) then
        warn("[ChallengeDungeonController] CanvasGroup missing Main/Next/Previous_Position attributes");

        return;
    end;

    local v101 = #BOSS_PREVIEW_ORDER >= 2;

    if u19 then
        u19.Visible = v101;
    end;

    if u20 then
        u20.Visible = v101;
    end;

    u55 = true;
    SnapToIndex(1);
end;

local function OnCyclePressed(p102: number) -- Line: 463
    -- upvalues: u55 (ref), u56 (ref), BOSS_PREVIEW_ORDER (copy), AnimateStep (copy)
    if not u55 or u56 then
        return;
    end;

    if #BOSS_PREVIEW_ORDER < 2 then
        return;
    end;

    AnimateStep(p102);
end;

local function ClearPlayerViewport(p103: number) -- Line: 472
    -- upvalues: u65 (copy), u28 (ref), u1 (copy)
    local v104 = u65[p103];

    if v104 then
        if v104.animTrack and v104.animTrack.IsPlaying then
            v104.animTrack:Stop();
        end;

        if v104.worldModel and v104.worldModel.Parent then
            v104.worldModel:Destroy();
        end;

        u65[p103] = nil;
    end;

    local v105 = u28 and u28:FindFirstChild(u1[p103]);

    if v105 then
        for _, child in v105:GetChildren() do
            if not child:IsA("UIGradient") then
                child:Destroy();
            end;
        end;
    end;
end;

local function PopulatePlayerViewport(p106: number, p107: userdata) -- Line: 495
    -- upvalues: ClearPlayerViewport (copy), u28 (ref), u1 (copy), CFrame_new_ret2 (copy), CFrame_new_ret (copy), Class_Data (copy), ReplicatedStorage (copy), u65 (copy)
    ClearPlayerViewport(p106);
    local v108 = u28 and u28:FindFirstChild(u1[p106]);

    if not v108 then
        return;
    end;

    local Character = p107.Character;

    if not Character then
        return;
    end;

    local Archivable = Character.Archivable;
    Character.Archivable = true;
    local v109 = Character:Clone();
    Character.Archivable = Archivable;

    for _, descendant in v109:GetDescendants() do
        if descendant:IsA("BaseScript") or (descendant:IsA("Tool") or (descendant:IsA("ForceField") or descendant:IsA("BillboardGui"))) then
            descendant:Destroy();
        end;
    end;

    local WorldModel = Instance.new("WorldModel");
    WorldModel.Name = "CharacterWorld";
    WorldModel.Parent = v108;
    v109:PivotTo(CFrame_new_ret2);
    v109.Parent = WorldModel;

    for _, child in v109:GetChildren() do
        if child:IsA("Accessory") then
            local Handle = child:FindFirstChild("Handle");

            if Handle then
                local v110 = Handle:FindFirstChildOfClass("Attachment");

                if v110 then
                    for _, child2 in v109:GetChildren() do
                        if child2:IsA("BasePart") then
                            local v111 = child2:FindFirstChild(v110.Name);

                            if v111 and v111:IsA("Attachment") then
                                local Weld = Instance.new("Weld");
                                Weld.Part0 = child2;
                                Weld.Part1 = Handle;
                                Weld.C0 = v111.CFrame;
                                Weld.C1 = v110.CFrame;
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
    Camera.Parent = v108;
    v108.CurrentCamera = Camera;
    local v112 = nil;
    local v113 = v109:FindFirstChildOfClass("Humanoid");

    if v113 then
        local v114 = v113:FindFirstChildOfClass("Animator");

        if not v114 then
            v114 = Instance.new("Animator");
            v114.Parent = v113;
        end;

        local v115 = Class_Data[p107:GetAttribute("Stat_ActiveClass") or ""];
        local v116;

        if v115 and (v115.AnimationOverrides and v115.AnimationOverrides.idle) then
            v116 = v115.AnimationOverrides.idle;
        else
            v116 = nil;
        end;

        local v117 = nil;

        if v116 then
            v117 = Instance.new("Animation");
            v117.AnimationId = v116;
        else
            local v118 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Idle_Animations");

            if v118 then
                v117 = v118:FindFirstChild("Hitman_Idle");
            end;
        end;

        if v117 then
            v112 = v114:LoadAnimation(v117);
            v112.Looped = true;
            v112:Play();
        end;
    end;

    u65[p106] = {
        clone = v109,
        animTrack = v112,
        worldModel = WorldModel,
        camera = Camera,
        userId = p107.UserId
    };
end;

local function OpenInvitePicker() -- Line: 603
    -- upvalues: u6 (ref), u2 (ref), u64 (copy)
    if not u6 then
        return;
    end;

    u6:Open({
        Header = "INVITE",
        Subtitle = "Select a player to invite",
        CloseOnSelect = false,
        MarkInvitedOnSelect = true,

        OnSelect = function(p119) -- Line: 611, Name: OnSelect
            -- upvalues: u2 (ref), u64 (ref)
            if not u2 then
                return;
            end;

            local UserId = p119.UserId;
            local v120 = u64[UserId];

            if v120 and os.clock() - v120 < 30 then
                return;
            end;

            u64[UserId] = os.clock();
            u2:RequestInvite(UserId);
        end
    });
end;

local function ApplySlot(p121: number, u122: any) -- Line: 625
    -- upvalues: u30 (copy), u31 (copy), Players (copy), HeadShot (copy), Size100x100 (copy), u65 (copy), PopulatePlayerViewport (copy), u62 (ref), ClearPlayerViewport (copy)
    local u123 = u30[p121];

    if not u123 then
        return;
    end;

    if u122 then
        u31[p121] = u122.UserId;

        if u123.PlayerCard then
            u123.PlayerCard.Visible = true;
        end;

        if u123.AddCard then
            u123.AddCard.Visible = false;
        end;

        if u123.ProfileImage then
            task.spawn(function() -- Line: 636
                -- upvalues: u122 (copy), Players (ref), HeadShot (ref), Size100x100 (ref), u123 (copy)
                local UserId = u122.UserId;
                local success, result = pcall(function() -- Line: 203
                    -- upvalues: Players (ref), UserId (copy), HeadShot (ref), Size100x100 (ref)
                    return Players:GetUserThumbnailAsync(UserId, HeadShot, Size100x100);
                end);
                local v124 = success and result and result or "";

                if u123.ProfileImage.Parent then
                    u123.ProfileImage.Image = v124;
                end;
            end);
        end;

        if u123.PlayerName then
            u123.PlayerName.Text = u122.DisplayName or (u122.Name or "");
        end;

        if u123.PlayerLevel then
            local PlayerByUserId = Players:GetPlayerByUserId(u122.UserId);
            local v125;

            if PlayerByUserId then
                local leaderstats = PlayerByUserId:FindFirstChild("leaderstats");

                if leaderstats then
                    leaderstats = leaderstats:FindFirstChild("Level");
                end;

                v125 = leaderstats and leaderstats.Value or PlayerByUserId:GetAttribute("PlayerLevel") or (u122.PlayerLevel or 1);
            else
                v125 = u122.PlayerLevel or 1;
            end;

            u123.PlayerLevel.Text = "Lv. " .. v125;
        end;

        local PlayerByUserId = Players:GetPlayerByUserId(u122.UserId);

        if PlayerByUserId then
            local v126 = u65[p121];

            if not v126 or v126.userId ~= u122.UserId then
                PopulatePlayerViewport(p121, PlayerByUserId);
            end;
        end;
    else
        u31[p121] = nil;

        if u123.PlayerCard then
            u123.PlayerCard.Visible = false;
        end;

        if u123.AddCard then
            u123.AddCard.Visible = u62;
        end;

        ClearPlayerViewport(p121);
    end;
end;

local function RefreshPartyRoster(p127) -- Line: 685
    -- upvalues: u61 (ref), u62 (ref), LocalPlayer (copy), u12 (ref), u10 (ref), u8 (ref), PARTY_CAP (copy), ApplySlot (copy), u25 (ref)
    u61 = p127;
    u62 = p127 and p127.LeaderId == LocalPlayer.UserId and true or false;

    if u12 and (not u62 and (p127 and p127.SelectedMode == "Dungeon")) then
        if u10 then
            u10:close();
        end;

        if u8 then
            u8:Open();
        end;

        return;
    end;

    local v128 = {};

    if p127 and p127.Members then
        for _, v in p127.Members do
            if v.UserId == p127.LeaderId then
                table.insert(v128, 1, v);
            end;
        end;

        for _, v in p127.Members do
            if v.UserId ~= p127.LeaderId then
                table.insert(v128, v);
            end;
        end;
    end;

    for i = 1, PARTY_CAP do
        ApplySlot(i, v128[i]);
        local _ = i;
    end;

    if u25 then
        u25.Visible = u62;
    end;
end;

local function ResolveShowcaseEntry(p129) -- Line: 732
    -- upvalues: ItemData (copy), RarityIndex (copy), ClassItemData (copy), Image_Data (copy), ConsumableData (copy), QuestItemData (copy)
    local Type = p129.Type;

    if Type == "Material" then
        local v130 = ItemData.Index[p129.Id];

        if v130 then
            local v131 = v130.Rarity or "Common";

            return {
                Icon = v130.Icon or "",
                Name = v130.Name or p129.Id,
                Amount = p129.Amount or 1,
                Rarity = v131,
                RarityIndex = RarityIndex[v131] or 1
            };
        end;

        warn("[ChallengeDungeonController] Showcase material not in ItemData.Index:", p129.Id);

        return nil;
    end;

    if Type == "ClassItem" then
        local v132 = ClassItemData.Get(p129.Id);
        local v133 = Image_Data.Class_Items or {};
        local v134 = v133[string.gsub(p129.Id, "%s", "")];

        if not v134 and (v132 and v132.ClassName) then
            v134 = v133[string.gsub(v132.ClassName, "%s", "")];
        end;

        local v135 = v132 and v132.Rarity or "Exotic";

        return {
            Icon = v134 or "",
            Name = p129.Id,
            Amount = p129.Amount or 1,
            Rarity = v135,
            RarityIndex = RarityIndex[v135] or 1
        };
    end;

    if Type == "Consumable" then
        local v136 = ConsumableData.Index and ConsumableData.Index[p129.Id];

        if v136 then
            local v137 = v136.Rarity or "Epic";

            return {
                Icon = v136.Icon or "",
                Name = v136.Name or p129.Id,
                Amount = p129.Amount or 1,
                Rarity = v137,
                RarityIndex = RarityIndex[v137] or 1
            };
        end;

        warn("[ChallengeDungeonController] Showcase consumable not in ConsumableData.Index:", p129.Id);

        return nil;
    end;

    if Type ~= "QuestItem" then
        return Type == "ProtectionScroll" and {
            Name = "Protection Scroll",
            Rarity = "Legendary",
            Icon = Image_Data.Rewards.ProtectionScroll,
            Amount = p129.Amount or 1,
            RarityIndex = RarityIndex.Legendary or 1
        } or nil;
    end;

    local v138 = QuestItemData.Get(p129.Id);

    if v138 then
        local v139 = v138.Rarity or "Mythic";

        return {
            Icon = v138.Icon or "",
            Name = v138.Name or (v138.DisplayName or p129.Id),
            Amount = p129.Amount or 1,
            Rarity = v139,
            RarityIndex = RarityIndex[v139] or 1
        };
    end;

    warn("[ChallengeDungeonController] Showcase quest item not in QuestItemData:", p129.Id);

    return nil;
end;

local function PopulateShowcaseRewards() -- Line: 819
    -- upvalues: ChallengeData (copy), u32 (ref), FormatCommas (copy), u33 (ref), u34 (ref), u35 (ref), u36 (copy), ResolveShowcaseEntry (copy), RarityColors (copy), Color3_new_ret (copy), CollectionService (copy), ItemIndex (copy)
    local SHOWCASE_REWARDS = ChallengeData.SHOWCASE_REWARDS;

    if not SHOWCASE_REWARDS then
        return;
    end;

    if u32 then
        u32.Visible = SHOWCASE_REWARDS.Coins ~= nil;

        if SHOWCASE_REWARDS.Coins then
            u32.Text = "Coins: " .. FormatCommas(SHOWCASE_REWARDS.Coins);
        end;
    end;

    if u33 then
        u33.Visible = SHOWCASE_REWARDS.EXP ~= nil;

        if SHOWCASE_REWARDS.EXP then
            u33.Text = "EXP: " .. FormatCommas(SHOWCASE_REWARDS.EXP);
        end;
    end;

    if not (u34 and u35) then
        return;
    end;

    for _, v in u36 do
        if v and v.Parent then
            v:Destroy();
        end;
    end;

    table.clear(u36);
    local v140 = {};

    for _, v in SHOWCASE_REWARDS.Items or {} do
        local v141 = ResolveShowcaseEntry(v);

        if v141 then
            v141.Id = v.Type == "ProtectionScroll" and "ProtectionScroll" or v.Id;
            table.insert(v140, v141);
        end;
    end;

    table.sort(v140, function(p142, p143) -- Line: 852
        if p142.RarityIndex == p143.RarityIndex then
            return p142.Name < p143.Name;
        end;

        return p142.RarityIndex > p143.RarityIndex;
    end);

    for i, v in v140 do
        local v144 = u35:Clone();
        v144.Name = "Reward_" .. i;
        v144.LayoutOrder = i;
        v144.Visible = true;
        local Holder = v144:FindFirstChild("Holder");

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
                local v145 = RarityColors[v.Rarity];
                ItemName.TextColor3 = v145 and v145.TextColor3 or Color3_new_ret;
            end;
        end;

        v144:SetAttribute("Tip", v.Name);

        if not CollectionService:HasTag(v144, "ToolTip") then
            CollectionService:AddTag(v144, "ToolTip");
        end;

        ItemIndex.BindCard(v144, v.Id, "ChallengeDungeon");
        v144.Parent = u34;
        table.insert(u36, v144);
    end;

    local v146 = u34:FindFirstChildOfClass("UIListLayout");

    if v146 then
        u34.CanvasSize = UDim2.new(0, v146.AbsoluteContentSize.X, 0, v146.AbsoluteContentSize.Y);
    end;
end;

local function RefreshStatsDisplay() -- Line: 906
    -- upvalues: Registry (copy), u15 (ref), u16 (ref), u14 (ref), ChallengeRewardData (copy)
    local v147 = Registry:Get("PlayerData");
    local v148;

    if v147 and (v147.Data and v147.Data.ChallengeDungeon) then
        v148 = v147.Data.ChallengeDungeon;
    else
        v148 = nil;
    end;

    if u15 then
        u15.Text = "Highest Floor: " .. (v148 and v148.HighestFloor or 0);
    end;

    if u16 then
        u16.Text = "Floor 100 Time: --";
    end;

    if u14 then
        u14.Text = "Season " .. ChallengeRewardData.CURRENT_SEASON;
    end;
end;

local function GetProgress() -- Line: 937
    -- upvalues: Registry (copy)
    local v149 = Registry:Get("PlayerData");

    if v149 and v149.Data then
        return v149.Data.ChallengeDungeon;
    end;

    return nil;
end;

local function IsMilestoneClaimed(p150: number) -- Line: 946
    -- upvalues: Registry (copy), ChallengeRewardData (copy)
    local v151 = Registry:Get("PlayerData");
    local v152;

    if v151 and v151.Data then
        v152 = v151.Data.ChallengeDungeon;
    else
        v152 = nil;
    end;

    if not v152 then
        return false;
    end;

    if v152.Season ~= ChallengeRewardData.CURRENT_SEASON then
        return false;
    end;

    local v153;

    if v152.ClaimedRewards == nil then
        v153 = false;
    else
        v153 = table.find(v152.ClaimedRewards, p150) ~= nil;
    end;

    return v153;
end;

local function IsMilestoneUnlocked(p154: number) -- Line: 953
    -- upvalues: ChallengeRewardData (copy), Registry (copy)
    local v155 = ChallengeRewardData.MILESTONES[p154];

    if not v155 then
        return false;
    end;

    local v156 = Registry:Get("PlayerData");
    local v157;

    if v156 and v156.Data then
        v157 = v156.Data.ChallengeDungeon;
    else
        v157 = nil;
    end;

    return (v157 and v157.HighestFloor or 0) >= v155.Floor;
end;

local function HasClaimableMilestone() -- Line: 964
    -- upvalues: ChallengeRewardData (copy), Registry (copy)
    for i = 1, #ChallengeRewardData.MILESTONES do
        local v158 = ChallengeRewardData.MILESTONES[i];
        local v159;

        if v158 then
            local v160 = Registry:Get("PlayerData");
            local v161;

            if v160 and v160.Data then
                v161 = v160.Data.ChallengeDungeon;
            else
                v161 = nil;
            end;

            v159 = (v161 and v161.HighestFloor or 0) >= v158.Floor;
        else
            v159 = false;
        end;

        local v162;

        if v159 then
            local v163 = Registry:Get("PlayerData");
            local v164;

            if v163 and v163.Data then
                v164 = v163.Data.ChallengeDungeon;
            else
                v164 = nil;
            end;

            local v165;

            if v164 and (v164.Season == ChallengeRewardData.CURRENT_SEASON and v164.ClaimedRewards ~= nil) then
                v165 = table.find(v164.ClaimedRewards, i) ~= nil;
            else
                v165 = false;
            end;

            if not v165 then
                return true;
            end;

            v162 = i;
        else
            v162 = i;
        end;
    end;

    return false;
end;

local function LookupDef(p166, p167) -- Line: 976
    if not (p166 and p167) then
        return nil;
    end;

    if p166.Index and p166.Index[p167] then
        return p166.Index[p167];
    end;

    local v168 = rawget(p166, p167);

    if type(v168) == "table" then
        return p166[p167];
    end;

    if type(p166.Get) == "function" then
        local success, result = pcall(p166.Get, p167);

        if success and result then
            return result;
        end;
    end;

    return nil;
end;

local function ResolveReward(p169) -- Line: 989
    -- upvalues: Image_Data (copy), ItemData (copy), LookupDef (copy), QuestItemData (copy), ConsumableData (copy), BuffPotionData (copy), PackageData (copy)
    local Type = p169.Type;
    local Id = p169.Id;
    local Amount = p169.Amount;

    if Type == "Coins" or Type == "Currency" then
        return {
            Name = "Coins",
            Category = "Currency",
            Icon = Image_Data.Rewards.Cash,
            Amount = Amount
        };
    end;

    if Type == "Stars" then
        return {
            Name = "Stars",
            Category = "Stars",
            Icon = Image_Data.Rewards.Stars,
            Amount = Amount
        };
    end;

    if Type == "LuckySpins" then
        return {
            Name = "Lucky Spins",
            Category = "Spins",
            Icon = Image_Data.Rewards.LuckySpins,
            Amount = Amount
        };
    end;

    if Type == "NormalSpins" then
        return {
            Name = "Normal Spins",
            Category = "Spins",
            Icon = Image_Data.Rewards.NormalSpins,
            Amount = Amount
        };
    end;

    if Type == "ProtectionScroll" then
        return {
            Name = "Protection Scroll",
            Category = "Consumable",
            Icon = Image_Data.Rewards.ProtectionScroll,
            Amount = Amount
        };
    end;

    if Type == "CraftingMaterial" then
        local v170 = ItemData.Index[Id];
        local v171 = {
            Category = "Material",
            Icon = v170 and (v170.Icon or "") or ""
        };

        if v170 then
            Id = v170.Name or Id;
        end;

        v171.Name = Id;
        v171.Amount = Amount;

        return v171;
    end;

    if Type == "QuestItem" then
        local v172 = LookupDef(QuestItemData, Id);
        local v173 = {
            Category = "Quest Item",
            Icon = v172 and (v172.Icon or "") or ""
        };

        if v172 then
            Id = v172.Name or (v172.DisplayName or Id);
        end;

        v173.Name = Id;
        v173.Amount = Amount;

        return v173;
    end;

    if Type == "Consumable" then
        local v174 = LookupDef(ConsumableData, Id);
        local v175 = {
            Category = "Consumable",
            Icon = v174 and (v174.Icon or "") or ""
        };

        if v174 then
            Id = v174.Name or (v174.DisplayName or Id);
        end;

        v175.Name = Id;
        v175.Amount = Amount;

        return v175;
    end;

    if Type ~= "BuffPotion" then
        if Type ~= "Package" then
            return {
                Icon = "",
                Name = tostring(Id or Type),
                Amount = Amount,
                Category = tostring(Type)
            };
        end;

        local v176;

        if Id then
            v176 = PackageData.Get(Id);
        else
            v176 = Id;
        end;

        return {
            Category = "Package",
            Icon = v176 and (v176.Icon or "") or "",
            Name = v176 and v176.Name or (Id or "Package"),
            Amount = Amount
        };
    end;

    local v177 = LookupDef(BuffPotionData, Id);
    local v178 = {
        Category = "Potion",
        Icon = v177 and (v177.Icon or "") or ""
    };

    if v177 then
        Id = v177.Name or (v177.DisplayName or Id);
    end;

    v178.Name = Id;
    v178.Amount = Amount;

    return v178;
end;

local function ComposeName(p179) -- Line: 1022
    -- upvalues: SharedUtils (copy)
    if p179.Amount then
        return SharedUtils.FormatWithCommas(p179.Amount) .. " " .. p179.Name;
    end;

    return p179.Name;
end;

local u180 = {
    LuckySpins = Color3.fromRGB(120, 255, 150),
    NormalSpins = Color3.fromRGB(255, 220, 80),
    ProtectionScroll = Color3.fromRGB(150, 215, 255)
};

local function FireMilestoneNotifications(p181) -- Line: 1044
    -- upvalues: Registry (copy), u180 (copy), ResolveReward (copy)
    local v182 = Registry:Get("ItemNotification");

    if not v182 then
        return;
    end;

    for _, v in p181.Rewards do
        local v183 = u180[v.Type];

        if v183 then
            local v184 = ResolveReward(v);
            v182.ShowItem(v184.Name, v184.Icon, v183, v184.Amount);
        end;
    end;
end;

local function ClearExtraRewardChips() -- Line: 1058
    -- upvalues: u52 (copy)
    for _, v in u52 do
        if v and v.Parent then
            v:Destroy();
        end;
    end;

    table.clear(u52);
end;

local function SetRowSelected(p185: number, p186: boolean) -- Line: 1066
    -- upvalues: u51 (copy)
    local v187 = u51[p185];

    if v187 and v187.selectFrame then
        v187.selectFrame.Visible = p186;
    end;
end;

local function ShowMilestoneInfo(p188: number) -- Line: 1075
    -- upvalues: ChallengeRewardData (copy), u53 (ref), u51 (copy), ResolveReward (copy), u42 (ref), SharedUtils (copy), u43 (ref), u44 (ref), ClearExtraRewardChips (copy), u48 (ref), u49 (ref), u50 (ref), u37 (ref), UIController (copy), u9 (ref), CollectionService (copy), ItemIndex (copy), u52 (copy), Registry (copy), u45 (ref), u46 (ref), u47 (ref)
    local v189 = ChallengeRewardData.MILESTONES[p188];

    if not v189 then
        return;
    end;

    if u53 and u53 ~= p188 then
        local v190 = u51[u53];

        if v190 and v190.selectFrame then
            v190.selectFrame.Visible = false;
        end;
    end;

    u53 = p188;
    local v191 = u51[p188];

    if v191 and v191.selectFrame then
        v191.selectFrame.Visible = true;
    end;

    local Rewards = v189.Rewards;
    local v192 = Rewards[1] and ResolveReward(Rewards[1]);

    if u42 then
        local v193;

        if v192 then
            local v194;

            if v192.Amount then
                v194 = SharedUtils.FormatWithCommas(v192.Amount) .. " " .. v192.Name;
            else
                v194 = v192.Name;
            end;

            v193 = v194 or "";
        else
            v193 = "";
        end;

        u42.Text = v193;
    end;

    if u43 then
        u43.Text = v192 and (v192.Category or "") or "";
    end;

    if u44 then
        local v195 = v192 and v192.Icon or "";
        u44.Image = v195;
        u44.Visible = v195 ~= "";
    end;

    ClearExtraRewardChips();
    local v196 = #Rewards > 1;

    if u48 then
        u48.Visible = v196;
    end;

    if v196 and (u49 and u50) then
        local v198 = {
            hideOnOpen = u37,

            onReturn = function() -- Line: 1111, Name: onReturn
                -- upvalues: UIController (ref), u9 (ref), u37 (ref)
                local v197 = UIController.getByName("ChallengeDungeon") or u9 and UIController.new(u9);

                if v197 then
                    v197:open();
                end;

                if u9 then
                    u9.Visible = false;
                end;

                if u37 then
                    u37.Visible = true;
                end;
            end
        };

        for i = 2, #Rewards do
            local v199 = ResolveReward(Rewards[i]);
            local v200 = u50:Clone();
            v200.Name = "Extra_" .. i;
            v200.LayoutOrder = i;
            v200.Visible = true;
            local Holder = v200:FindFirstChild("Holder");

            if Holder then
                Holder = Holder:FindFirstChild("Main");
            end;

            if Holder then
                local ItemImage = Holder:FindFirstChild("ItemImage");

                if ItemImage then
                    ItemImage.Image = v199.Icon;
                    ItemImage.Visible = v199.Icon ~= "";
                end;

                local Amount = Holder:FindFirstChild("Amount");

                if Amount then
                    if v199.Amount then
                        Amount.Text = "x" .. v199.Amount;
                        Amount.Visible = true;
                    else
                        Amount.Visible = false;
                    end;
                end;

                local ItemName = Holder:FindFirstChild("ItemName");

                if ItemName then
                    ItemName.Text = v199.Name;
                end;
            end;

            v200:SetAttribute("Tip", v199.Name);

            if not CollectionService:HasTag(v200, "ToolTip") then
                CollectionService:AddTag(v200, "ToolTip");
            end;

            local v201 = Rewards[i];
            local v202 = nil;

            if v201.Type == "ProtectionScroll" then
                v202 = "ProtectionScroll";
            elseif v201.Type == "CraftingMaterial" or (v201.Type == "BuffPotion" or (v201.Type == "QuestItem" or (v201.Type == "Consumable" or v201.Type == "Package"))) then
                v202 = v201.Id;
            end;

            ItemIndex.BindCard(v200, v202, v198);
            v200.Parent = u49;
            table.insert(u52, v200);
            local _ = i;
        end;

        local v203 = u49:FindFirstChildOfClass("UIListLayout");

        if v203 then
            u49.CanvasSize = UDim2.new(0, v203.AbsoluteContentSize.X, 0, v203.AbsoluteContentSize.Y);
        end;
    end;

    local v204 = Registry:Get("PlayerData");
    local v205;

    if v204 and v204.Data then
        v205 = v204.Data.ChallengeDungeon;
    else
        v205 = nil;
    end;

    local v206;

    if v205 and (v205.Season == ChallengeRewardData.CURRENT_SEASON and v205.ClaimedRewards ~= nil) then
        v206 = table.find(v205.ClaimedRewards, p188) ~= nil;
    else
        v206 = false;
    end;

    local v207 = ChallengeRewardData.MILESTONES[p188];
    local v208;

    if v207 then
        local v209 = Registry:Get("PlayerData");
        local v210;

        if v209 and v209.Data then
            v210 = v209.Data.ChallengeDungeon;
        else
            v210 = nil;
        end;

        v208 = (v210 and v210.HighestFloor or 0) >= v207.Floor;
    else
        v208 = false;
    end;

    if u45 then
        u45.Visible = v206;
    end;

    if u46 then
        u46.Visible = not v206;
        local v211;

        if v208 then
            v211 = not v206;
        else
            v211 = v208;
        end;

        u46.Active = v211;

        if u47 then
            u47.Text = v208 and "CLAIM" or "LOCKED";
        end;
    end;
end;

local function OnClaimClicked() -- Line: 1189
    -- upvalues: u53 (ref), u3 (ref), Registry (copy), ChallengeRewardData (copy), u46 (ref), u51 (copy), u45 (ref), u7 (ref), FireMilestoneNotifications (copy), u4 (ref), u5 (ref)
    local v212 = u53;

    if not (v212 and u3) then
        return;
    end;

    local v213 = Registry:Get("PlayerData");
    local v214;

    if v213 and v213.Data then
        v214 = v213.Data.ChallengeDungeon;
    else
        v214 = nil;
    end;

    local v215;

    if v214 and (v214.Season == ChallengeRewardData.CURRENT_SEASON and v214.ClaimedRewards ~= nil) then
        v215 = table.find(v214.ClaimedRewards, v212) ~= nil;
    else
        v215 = false;
    end;

    if not v215 then
        local v216 = ChallengeRewardData.MILESTONES[v212];
        local v217;

        if v216 then
            local v218 = Registry:Get("PlayerData");
            local v219;

            if v218 and v218.Data then
                v219 = v218.Data.ChallengeDungeon;
            else
                v219 = nil;
            end;

            v217 = (v219 and v219.HighestFloor or 0) >= v216.Floor;
        else
            v217 = false;
        end;

        if v217 then
            if u46 then
                u46.Active = false;
            end;

            local v220 = ChallengeRewardData.MILESTONES[v212];
            local v221, v222, v223 = u3:ClaimReward(v212):await();

            if v221 and v222 then
                local v224 = u51[v212];

                if v224 and v224.claimedOverlay then
                    v224.claimedOverlay.Visible = true;
                end;

                if u45 then
                    u45.Visible = true;
                end;

                if u46 then
                    u46.Visible = false;
                end;

                if u7 then
                    u7:Update("ChallengeRewards");
                end;

                if v220 then
                    FireMilestoneNotifications(v220);
                end;

                if u4 then
                    pcall(function() -- Line: 1213
                        -- upvalues: u4 (ref)
                        u4:Play("sfx celeste Level Up");
                    end);
                end;
            else
                if u46 then
                    u46.Active = true;
                end;

                if u5 then
                    u5:Show("Custom", type(v223) == "string" and v223 and v223 or "Failed to claim reward", 3, Color3.fromRGB(255, 100, 100), Color3.fromRGB(60, 20, 20), "Error");
                end;
            end;
        end;
    end;
end;

local function PaintMilestoneRow(p225: any, u226: number, p227: any) -- Line: 1229
    -- upvalues: ResolveReward (copy), SharedUtils (copy), Registry (copy), ChallengeRewardData (copy), u53 (ref), ShowMilestoneInfo (copy), u51 (copy)
    p225.Name = "Milestone_" .. u226;
    p225.LayoutOrder = u226;
    p225.Visible = true;
    local v228 = p227.Rewards[1] and ResolveReward(p227.Rewards[1]);
    local Frame = p225:FindFirstChild("Frame");

    if Frame then
        local ItemName = Frame:FindFirstChild("ItemName");

        if ItemName then
            local v229;

            if v228 then
                local v230;

                if v228.Amount then
                    v230 = SharedUtils.FormatWithCommas(v228.Amount) .. " " .. v228.Name;
                else
                    v230 = v228.Name;
                end;

                v229 = v230 or "";
            else
                v229 = "";
            end;

            ItemName.Text = v229;
        end;

        local ItemImage = Frame:FindFirstChild("ItemImage");

        if ItemImage then
            local v231 = v228 and v228.Icon or "";
            ItemImage.Image = v231;
            ItemImage.Visible = v231 ~= "";
        end;

        local Requirement = Frame:FindFirstChild("Requirement");

        if Requirement then
            Requirement.Text = "Floor: " .. p227.Floor;
        end;
    end;

    local Claimed = p225:FindFirstChild("Claimed");

    if Claimed then
        local v232 = Registry:Get("PlayerData");
        local v233;

        if v232 and v232.Data then
            v233 = v232.Data.ChallengeDungeon;
        else
            v233 = nil;
        end;

        local v234;

        if v233 and (v233.Season == ChallengeRewardData.CURRENT_SEASON and v233.ClaimedRewards ~= nil) then
            v234 = table.find(v233.ClaimedRewards, u226) ~= nil;
        else
            v234 = false;
        end;

        Claimed.Visible = v234;
    end;

    local Select = p225:FindFirstChild("Select");

    if Select then
        Select.Visible = false;
        p225.MouseEnter:Connect(function() -- Line: 1258
            -- upvalues: u53 (ref), u226 (copy), Select (copy)
            if u53 ~= u226 then
                Select.Visible = true;
            end;
        end);
        p225.MouseLeave:Connect(function() -- Line: 1261
            -- upvalues: u53 (ref), u226 (copy), Select (copy)
            if u53 ~= u226 then
                Select.Visible = false;
            end;
        end);
    end;

    p225.MouseButton1Click:Connect(function() -- Line: 1266
        -- upvalues: ShowMilestoneInfo (ref), u226 (copy)
        ShowMilestoneInfo(u226);
    end);
    u51[u226] = {
        clone = p225,
        selectFrame = Select,
        claimedOverlay = Claimed
    };
end;

local function BuildMilestoneList() -- Line: 1275
    -- upvalues: u39 (ref), u40 (ref), u51 (copy), u54 (ref), ChallengeRewardData (copy), PaintMilestoneRow (copy), RevealCascade (copy), u53 (ref), ShowMilestoneInfo (copy)
    if not (u39 and u40) then
        return;
    end;

    for _, v in u51 do
        if v.clone and v.clone.Parent then
            v.clone:Destroy();
        end;
    end;

    table.clear(u51);
    u54 = u54 + 1;
    local u235 = u54;
    local v236 = {};

    for i, v in ChallengeRewardData.MILESTONES do
        table.insert(v236, {
            idx = i,
            milestone = v
        });
    end;

    table.sort(v236, function(p237, p238) -- Line: 1291
        return p237.idx < p238.idx;
    end);
    local v239 = {};

    for _, v in v236 do
        local v240 = u40:Clone();
        PaintMilestoneRow(v240, v.idx, v.milestone);
        v240.Parent = u39;
        table.insert(v239, v240);
    end;

    RevealCascade.play(v239, {
        isCurrent = function() -- Line: 1305, Name: isCurrent
            -- upvalues: u54 (ref), u235 (copy)
            return u54 == u235;
        end
    });
    local v241 = u53;

    if not (v241 and u51[v241]) then
        v241 = v236[1] and v236[1].idx or nil;
    end;

    u53 = nil;

    if v241 then
        ShowMilestoneInfo(v241);
    end;
end;

local function RefreshRewardsWindow() -- Line: 1322
    -- upvalues: BuildMilestoneList (copy)
    BuildMilestoneList();
end;

local function SwitchToRewards() -- Line: 1326
    -- upvalues: u37 (ref), u9 (ref), u41 (ref), BuildMilestoneList (copy)
    if not (u37 and u9) then
        return;
    end;

    u41 = true;
    u9.Visible = false;
    u37.Visible = true;
    BuildMilestoneList();
end;

local function SwitchToPass() -- Line: 1336
    -- upvalues: u41 (ref), u37 (ref), u9 (ref)
    u41 = false;

    if u37 then
        u37.Visible = false;
    end;

    if u9 then
        u9.Visible = true;
    end;
end;

local function OnOpen() -- Line: 1344
    -- upvalues: u12 (ref), u2 (ref), ChallengeData (copy), RefreshPartyRoster (copy), Registry (copy), u15 (ref), u16 (ref), u14 (ref), ChallengeRewardData (copy), PopulateShowcaseRewards (copy), u65 (copy)
    u12 = true;

    if u2 then
        task.spawn(function() -- Line: 1350
            -- upvalues: u2 (ref), ChallengeData (ref), RefreshPartyRoster (ref)
            u2:RequestSelectMode("Challenge"):await();
            u2:RequestSelectDungeon(ChallengeData.FEATURED_DUNGEON):await();
            local v242, v243 = u2:RequestPartyData():await();

            if v242 and v243 then
                RefreshPartyRoster(v243);
            end;
        end);
    end;

    local v244 = Registry:Get("PlayerData");
    local v245;

    if v244 and (v244.Data and v244.Data.ChallengeDungeon) then
        v245 = v244.Data.ChallengeDungeon;
    else
        v245 = nil;
    end;

    if u15 then
        u15.Text = "Highest Floor: " .. (v245 and v245.HighestFloor or 0);
    end;

    if u16 then
        u16.Text = "Floor 100 Time: --";
    end;

    if u14 then
        u14.Text = "Season " .. ChallengeRewardData.CURRENT_SEASON;
    end;

    PopulateShowcaseRewards();

    for _, v in u65 do
        if v.animTrack and not v.animTrack.IsPlaying then
            v.animTrack:Play();
        end;
    end;
end;

local function OnClose() -- Line: 1372
    -- upvalues: u12 (ref), u41 (ref), u37 (ref), u65 (copy), u2 (ref)
    u12 = false;
    u41 = false;

    if u37 then
        u37.Visible = false;
    end;

    for _, v in u65 do
        if v.animTrack and v.animTrack.IsPlaying then
            v.animTrack:Stop();
        end;
    end;

    if u2 then
        task.spawn(function() -- Line: 1388
            -- upvalues: u2 (ref)
            u2:RequestSelectMode("Dungeon"):await();
        end);
    end;
end;

local v246 = Knit.CreateController({
    Name = "ChallengeDungeonController"
});

function v246.Open(p247) -- Line: 1400
    -- upvalues: u12 (ref), u10 (ref), OnOpen (copy)
    if u12 then
        return;
    end;

    if not u10 then
        return;
    end;

    u10:open();
    OnOpen();
end;

function v246.Close(p248) -- Line: 1407
    -- upvalues: u12 (ref), u10 (ref)
    if not u12 then
        return;
    end;

    if not u10 then
        return;
    end;

    u10:close();
end;

function v246.Toggle(p249) -- Line: 1413
    -- upvalues: u12 (ref)
    if u12 then
        p249:Close();

        return;
    end;

    p249:Open();
end;

function v246.IsOpen(p250) -- Line: 1421
    -- upvalues: u12 (ref)
    return u12;
end;

function v246.KnitInit(p251) -- Line: 1427
    -- upvalues: Knit (copy), u9 (ref), u10 (ref), UIController (copy), OnClose (copy), u11 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u22 (ref), u20 (ref), u23 (ref), u21 (ref), u24 (ref), u25 (ref), u26 (ref), u27 (ref), u28 (ref), u29 (ref), PARTY_CAP (copy), u30 (copy), u32 (ref), u33 (ref), u34 (ref), u35 (ref), u37 (ref), u38 (ref), u39 (ref), u40 (ref), u42 (ref), u45 (ref), u43 (ref), u44 (ref), u46 (ref), u47 (ref), u48 (ref), u49 (ref), u50 (ref)
    local Frames = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("Frames");
    u9 = Frames:FindFirstChild("ChallengeDungeon");

    if not u9 then
        warn("[ChallengeDungeonController] ChallengeDungeon frame not found in Main.Frames");

        return;
    end;

    u9.Visible = false;
    u10 = UIController._cached[u9] or UIController.new(u9);
    u10.onClose = OnClose;
    u11 = u9:FindFirstChild("Close");
    local Content = u9:FindFirstChild("Content");

    if not Content then
        warn("[ChallengeDungeonController] ChallengeDungeon.Content not found");

        return;
    end;

    u13 = Content:FindFirstChild("LeftFrame");

    if u13 then
        u14 = u13:FindFirstChild("Season_Time");
        local Text = u13:FindFirstChild("Text");

        if Text then
            u15 = Text:FindFirstChild("Highest_Floor");
            u16 = Text:FindFirstChild("Floor_100_Time");
        end;

        u17 = u13:FindFirstChild("CanvasGroup");

        if u17 then
            u18 = { u17:FindFirstChild("Viewport_1"), u17:FindFirstChild("Viewport_2"), u17:FindFirstChild("Viewport_3") };
        end;

        u19 = u13:FindFirstChild("CycleForward");
        local v252 = u19 and u19:FindFirstChild("BossName");
        u22 = v252;
        u20 = u13:FindFirstChild("CycleBack");
        local v253 = u20 and u20:FindFirstChild("BossName");
        u23 = v253;
        local Display = u13:FindFirstChild("Display");

        if Display then
            u21 = Display:FindFirstChild("BossName");
            local Title = Display:FindFirstChild("Title");

            if Title then
                Title.Text = "Boss Preview:";
            end;
        end;
    end;

    local Buttons = Content:FindFirstChild("Buttons");

    if Buttons then
        u24 = Buttons:FindFirstChild("Rewards");
        local Enter = Buttons:FindFirstChild("Enter");

        if Enter then
            u25 = Enter;
            u26 = Enter:FindFirstChild("Text");
        end;

        u27 = Buttons:FindFirstChild("Leave");
    end;

    u28 = Content:FindFirstChild("RightFrame");

    if u28 then
        local Party = u28:FindFirstChild("Party");

        if Party then
            Party = Party:FindFirstChild("Players");
        end;

        u29 = Party;

        if u29 then
            for i = 1, PARTY_CAP do
                local v254 = u29:FindFirstChild((tostring(i)));
                local v255;

                if v254 then
                    local Player = v254:FindFirstChild("Player");
                    local v256 = {
                        Slot = v254,
                        PlayerCard = Player,
                        AddCard = v254:FindFirstChild("Add")
                    };
                    local v257;

                    if Player then
                        v257 = Player:FindFirstChild("ProfileImage");
                    else
                        v257 = Player;
                    end;

                    v256.ProfileImage = v257;
                    local v258;

                    if Player then
                        v258 = Player:FindFirstChild("PlayerName");
                    else
                        v258 = Player;
                    end;

                    v256.PlayerName = v258;

                    if Player then
                        Player = Player:FindFirstChild("PlayerLevel");
                    end;

                    v256.PlayerLevel = Player;
                    u30[i] = v256;
                    v255 = i;
                else
                    v255 = i;
                end;
            end;
        end;

        local Rewards = u28:FindFirstChild("Rewards");

        if Rewards then
            u32 = Rewards:FindFirstChild("Coins");
            u33 = Rewards:FindFirstChild("EXP");
            u34 = Rewards:FindFirstChild("ScrollingFrame");

            if u34 then
                u35 = u34:FindFirstChild("Template");

                if u35 then
                    u35.Visible = false;
                end;
            end;
        end;
    end;

    u37 = Frames:FindFirstChild("ChallengeDungeon_Rewards");

    if u37 then
        u37.Visible = false;
        u38 = u37:FindFirstChild("Exit");
        local Contents = u37:FindFirstChild("Contents");

        if Contents then
            local LeftSection = Contents:FindFirstChild("LeftSection");

            if LeftSection then
                LeftSection = LeftSection:FindFirstChild("RewardsList");
            end;

            u39 = LeftSection;

            if u39 then
                u40 = u39:FindFirstChild("Template");

                if u40 then
                    u40.Visible = false;
                end;

                local TopPadding = u39:FindFirstChild("TopPadding");

                if TopPadding then
                    TopPadding.LayoutOrder = -100000;
                end;

                local BottomPadding = u39:FindFirstChild("BottomPadding");

                if BottomPadding then
                    BottomPadding.LayoutOrder = 100000;
                end;
            end;

            local RightSection = Contents:FindFirstChild("RightSection");

            if RightSection then
                RightSection = RightSection:FindFirstChild("ItemInfo");
            end;

            if RightSection then
                u42 = RightSection:FindFirstChild("ItemName");
                u45 = RightSection:FindFirstChild("Claimed");
                local Info = RightSection:FindFirstChild("Info");

                if Info then
                    local Rarity = Info:FindFirstChild("Rarity");

                    if Rarity then
                        Rarity = Rarity:FindFirstChild("Info");
                    end;

                    u43 = Rarity;
                    u44 = Info:FindFirstChild("ItemImage");
                end;

                local Button = RightSection:FindFirstChild("Button");

                if Button then
                    Button = Button:FindFirstChild("Claim");
                end;

                u46 = Button;
                local v259 = u46 and u46:FindFirstChild("TextLabel");
                u47 = v259;
                u48 = RightSection:FindFirstChild("Rewards");

                if u48 then
                    u49 = u48:FindFirstChild("ScrollingFrame");
                    u50 = u49 and u49:FindFirstChild("Template");

                    if u50 then
                        u50.Visible = false;
                    end;
                end;
            end;
        end;
    else
        warn("[ChallengeDungeonController] ChallengeDungeon_Rewards frame not found — sub-view unavailable");
    end;
end;

function v246.KnitStart(u260) -- Line: 1596
    -- upvalues: u9 (ref), u2 (ref), Knit (copy), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u24 (ref), HasClaimableMilestone (copy), Registry (copy), BuildCarousel (copy), u19 (ref), u55 (ref), u56 (ref), BOSS_PREVIEW_ORDER (copy), AnimateStep (copy), u20 (ref), u12 (ref), OnOpen (copy), u41 (ref), OnClose (copy), u11 (ref), u10 (ref), SwitchToRewards (copy), u38 (ref), SwitchToPass (copy), u46 (ref), OnClaimClicked (copy), PARTY_CAP (copy), u30 (copy), u62 (ref), u31 (copy), OpenInvitePicker (copy), u25 (ref), u63 (ref), u26 (ref), u27 (ref), u61 (ref), LocalPlayer (copy), RefreshPartyRoster (copy)
    if not u9 then
        return;
    end;

    pcall(function() -- Line: 1600
        -- upvalues: u2 (ref), Knit (ref)
        u2 = Knit.GetService("DungeonQueueService");
    end);
    pcall(function() -- Line: 1601
        -- upvalues: u3 (ref), Knit (ref)
        u3 = Knit.GetService("ChallengeRewardService");
    end);
    pcall(function() -- Line: 1602
        -- upvalues: u4 (ref), Knit (ref)
        u4 = Knit.GetController("SoundController");
    end);
    pcall(function() -- Line: 1603
        -- upvalues: u5 (ref), Knit (ref)
        u5 = Knit.GetController("NotificationController");
    end);
    pcall(function() -- Line: 1604
        -- upvalues: u6 (ref), Knit (ref)
        u6 = Knit.GetController("PlayerListController");
    end);
    pcall(function() -- Line: 1605
        -- upvalues: u7 (ref), Knit (ref)
        u7 = Knit.GetController("NoticeController");
    end);
    pcall(function() -- Line: 1606
        -- upvalues: u8 (ref), Knit (ref)
        u8 = Knit.GetController("DungeonSelectController");
    end);

    if u7 and u24 then
        local Notice = u24:FindFirstChild("Notice", true);

        if Notice then
            u7:Register("ChallengeRewards", Notice, HasClaimableMilestone);
            local v261 = Registry:Get("PlayerData");

            if v261 then
                v261:OnChange(function(p262, p263) -- Line: 1620
                    -- upvalues: u7 (ref)
                    if p263[1] == "ChallengeDungeon" then
                        u7:Update("ChallengeRewards");
                    end;
                end);
            end;
        else
            warn("[ChallengeDungeonController] Buttons.Rewards.Notice not found — claimable badge disabled");
        end;
    end;

    task.spawn(BuildCarousel);

    if u19 then
        u19.Activated:Connect(function() -- Line: 1636
            -- upvalues: u55 (ref), u56 (ref), BOSS_PREVIEW_ORDER (ref), AnimateStep (ref)
            if u55 then
                if u56 then
                    return;
                end;

                if #BOSS_PREVIEW_ORDER < 2 then
                    return;
                end;

                AnimateStep(1);
            end;
        end);
    end;

    if u20 then
        u20.Activated:Connect(function() -- Line: 1639
            -- upvalues: u55 (ref), u56 (ref), BOSS_PREVIEW_ORDER (ref), AnimateStep (ref)
            if u55 then
                if u56 then
                    return;
                end;

                if #BOSS_PREVIEW_ORDER < 2 then
                    return;
                end;

                AnimateStep(-1);
            end;
        end);
    end;

    u9:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 1645
        -- upvalues: u9 (ref), u12 (ref), OnOpen (ref), u41 (ref), OnClose (ref)
        if u9.Visible then
            if not u12 then
                OnOpen();
            end;
        else
            if u41 then
                return;
            end;

            if u12 then
                OnClose();
            end;
        end;
    end);

    if u11 then
        u11.Activated:Connect(function() -- Line: 1660
            -- upvalues: u10 (ref)
            if u10 then
                u10:close();
            end;
        end);
    end;

    if u24 then
        u24.Activated:Connect(SwitchToRewards);
    end;

    if u38 then
        u38.Activated:Connect(SwitchToPass);
    end;

    if u46 then
        u46.Activated:Connect(OnClaimClicked);
    end;

    for i = 1, PARTY_CAP do
        local v264 = u30[i];
        local v265;

        if v264 and (v264.Slot and v264.Slot:IsA("GuiButton")) then
            v264.Slot.Activated:Connect(function() -- Line: 1686
                -- upvalues: u62 (ref), u31 (ref), i (copy), OpenInvitePicker (ref)
                if not u62 then
                    return;
                end;

                if u31[i] == nil then
                    OpenInvitePicker();
                end;
            end);
            v265 = i;
        else
            v265 = i;
        end;
    end;

    if u25 then
        u25.Activated:Connect(function() -- Line: 1707
            -- upvalues: u62 (ref), u2 (ref), u63 (ref), u25 (ref), u26 (ref), u4 (ref), u260 (copy), u5 (ref)
            if not u62 then
                return;
            end;

            if not u2 then
                return;
            end;

            if u63 then
                return;
            end;

            u63 = true;
            u25.Active = false;

            if u26 then
                u26.Text = "MOVING...";
            end;

            task.spawn(function() -- Line: 1716
                -- upvalues: u2 (ref), u63 (ref), u25 (ref), u26 (ref), u4 (ref), u260 (ref), u5 (ref)
                local v266, v267, v268 = u2:RequestStartPodQueue():await();

                if not v266 then
                    v267 = false;
                    v268 = "Server request failed";
                end;

                u63 = false;

                if u25 then
                    u25.Active = true;
                end;

                if u26 then
                    u26.Text = "ENTER";
                end;

                if not v267 then
                    if u5 then
                        u5:Show("Custom", tostring(v268 or "Failed to start Challenge Dungeon"), 3, Color3.fromRGB(255, 200, 80), Color3.fromRGB(60, 45, 15), "Error");
                    end;

                    return;
                end;

                if u4 then
                    pcall(function() -- Line: 1728
                        -- upvalues: u4 (ref)
                        u4:PlaySound("GiftReceived");
                    end);
                end;

                u260:Close();
            end);
        end);
    end;

    if u27 then
        u27.Activated:Connect(function() -- Line: 1741
            -- upvalues: u2 (ref)
            if u2 then
                u2:RequestLeaveParty();
            end;
        end);
    end;

    if u2 then
        u2.PodPromptRequested:Connect(function(p269) -- Line: 1754
            -- upvalues: u61 (ref), LocalPlayer (ref), u8 (ref), u260 (copy)
            if p269 == "Challenge" then
                local v270 = u61;

                if v270 and (v270.LeaderId ~= LocalPlayer.UserId and v270.SelectedMode == "Dungeon") then
                    if u8 then
                        u8:Open();
                    end;

                    return;
                end;

                u260:Open();
            end;
        end);
        u2.PartyUpdate:Connect(function(p271) -- Line: 1770
            -- upvalues: u12 (ref), RefreshPartyRoster (ref)
            if not u12 then
                return;
            end;

            RefreshPartyRoster(p271);
        end);
    end;
end;

return v246;