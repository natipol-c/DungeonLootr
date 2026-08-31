--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     RaidSelectController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.RaidSelectController
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
local Knit = require(ReplicatedStorage.Packages.Knit);
local UIController = require(script.Parent.UIController);
local Registry = require(script.Parent.Registry);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local RaidData = require(ReplicatedStorage.GameInfo.RaidData);
local Class_Data = require(ReplicatedStorage.Classes.Class_Data);
local EnemyResolver = require(ReplicatedStorage.GameInfo.EnemyResolver);
local LocalPlayer = Players.LocalPlayer;
local HeadShot = Enum.ThumbnailType.HeadShot;
local Size100x100 = Enum.ThumbnailSize.Size100x100;
local CFrame_new_ret = CFrame.new(Vector3.new(0, 0.5, -12), Vector3.new(0, 0.5, 0));
local CFrame_new_ret2 = CFrame.new(0, 0.5, 0);
local TweenInfo_new_ret = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local RAID_ORDER = RaidData.RAID_ORDER;
local MAX_PARTY_SIZE = RaidData.MAX_PARTY_SIZE;
local u1 = { "Leader_Viewport", "Player2_Viewport", "Player3_Viewport", "Player4_Viewport" };
local TweenInfo_new_ret2 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = false;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = {};
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = {};
local DEFAULT_DIFFICULTY = RaidData.DEFAULT_DIFFICULTY;
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = nil;
local u26 = nil;
local u27 = {};
local u28 = {};
local u29 = false;
local u30 = false;
local u31 = 1;
local u32 = nil;
local u33 = {};
local u34 = {};
local u35 = {};
local u36 = nil;
local u37 = false;
local u38 = false;
local u39 = {};
local u40 = {};

local function GetThumbnail(u41: number) -- Line: 146
    -- upvalues: Players (copy), HeadShot (copy), Size100x100 (copy)
    local success, result = pcall(function() -- Line: 147
        -- upvalues: Players (ref), u41 (copy), HeadShot (ref), Size100x100 (ref)
        return Players:GetUserThumbnailAsync(u41, HeadShot, Size100x100);
    end);

    return success and result and result or "";
end;

local function FormatTime(p42: number) -- Line: 154
    if p42 <= 0 then
        return "--:--";
    end;

    local math_floor_ret = math.floor(p42 / 60);
    local math_floor_ret2 = math.floor(p42 % 60);

    return string.format("%02d:%02d", math_floor_ret, math_floor_ret2);
end;

local function GetClassIdleAnim(p43: string) -- Line: 162
    -- upvalues: Class_Data (copy)
    local v44 = Class_Data[p43];

    if v44 and (v44.AnimationOverrides and v44.AnimationOverrides.idle) then
        return v44.AnimationOverrides.idle;
    end;

    return nil;
end;

local function SelectedRaidId() -- Line: 171
    -- upvalues: RAID_ORDER (copy), u31 (ref)
    return RAID_ORDER[u31];
end;

local function RefreshClearTime() -- Line: 180
    -- upvalues: u12 (ref), RAID_ORDER (copy), u31 (ref), Registry (copy), RaidData (copy), DEFAULT_DIFFICULTY (ref)
    if not u12 then
        return;
    end;

    local v45 = RAID_ORDER[u31];
    local v46;

    if v45 then
        local v47 = Registry:Get("PlayerData");
        local v48 = v47 and v47.Data and v47.Data.DungeonBestTimes;

        if v48 then
            v48 = v48[RaidData.BestTimeKey(v45)];
        end;

        v46 = v48 and v48[DEFAULT_DIFFICULTY] or 0;
    else
        v46 = 0;
    end;

    local v49;

    if v46 <= 0 then
        v49 = "--:--";
    else
        local math_floor_ret = math.floor(v46 / 60);
        local math_floor_ret2 = math.floor(v46 % 60);
        v49 = string.format("%02d:%02d", math_floor_ret, math_floor_ret2);
    end;

    u12.Text = "Clear Time: " .. v49;
end;

local function ApplyDifficultyVisuals() -- Line: 199
    -- upvalues: u20 (copy), DEFAULT_DIFFICULTY (ref), TweenService (copy), TweenInfo_new_ret2 (copy), RefreshClearTime (copy)
    for i, v in u20 do
        local v50 = i == DEFAULT_DIFFICULTY;
        local v51 = v50 and v.BgColor or v.BgColor:Lerp(Color3.new(0, 0, 0), 0.55);
        local v52 = v50 and v.TextColor or v.TextColor:Lerp(Color3.new(0, 0, 0), 0.55);

        if v.Background then
            TweenService:Create(v.Background, TweenInfo_new_ret2, {
                ImageColor3 = v51
            }):Play();
        end;

        if v.Text then
            TweenService:Create(v.Text, TweenInfo_new_ret2, {
                TextColor3 = v52
            }):Play();
        end;
    end;

    RefreshClearTime();
end;

local function SetSelectedDifficulty(p53: string?, p54: boolean) -- Line: 216
    -- upvalues: RaidData (copy), DEFAULT_DIFFICULTY (ref), ApplyDifficultyVisuals (copy), u37 (ref), u2 (ref)
    if not RaidData.IsValidDifficulty(p53) then
        return;
    end;

    if DEFAULT_DIFFICULTY == p53 and not p54 then
        ApplyDifficultyVisuals();

        return;
    end;

    DEFAULT_DIFFICULTY = p53;
    ApplyDifficultyVisuals();

    if p54 and (u37 and u2) then
        u2:RequestSelectRaidDifficulty(p53);
    end;
end;

local function CycleIndex(p55: number) -- Line: 234
    -- upvalues: RAID_ORDER (copy)
    return (p55 - 1) % #RAID_ORDER + 1;
end;

local function RaidDisplayName(p56: number) -- Line: 240
    -- upvalues: RAID_ORDER (copy), RaidData (copy)
    local v57 = RAID_ORDER[(p56 - 1) % #RAID_ORDER + 1];
    local v58;

    if v57 then
        v58 = RaidData.GetRaid(v57);
    else
        v58 = v57;
    end;

    return v58 and v58.DisplayName or (v57 or "");
end;

local function OffsetPosition(p59, p60: number) -- Line: 247
    return UDim2.new(p59.X.Scale + p60, p59.X.Offset, p59.Y.Scale, p59.Y.Offset);
end;

local function RenderBossIntoViewport(u61: number, u62: string, p63: boolean?) -- Line: 253
    -- upvalues: u14 (ref), u35 (copy), RaidData (copy), SharedUtils (copy), EnemyResolver (copy)
    local u64 = u14[u61];

    if not u64 then
        return;
    end;

    local u65 = u35[u61];

    if u65 and (u65.raidId == u62 and not p63) then
        return;
    end;

    if u65 and u65.animTrack then
        pcall(function() -- Line: 261
            -- upvalues: u65 (copy)
            u65.animTrack:Stop();
        end);
    end;

    for _, child in u64:GetChildren() do
        if not child:IsA("UIGradient") then
            child:Destroy();
        end;
    end;

    u35[u61] = nil;
    local Raid = RaidData.GetRaid(u62);

    if not Raid then
        return;
    end;

    local success, result = pcall(function() -- Line: 273
        -- upvalues: SharedUtils (ref), Raid (copy), EnemyResolver (ref), u64 (copy), u35 (ref), u61 (copy), u62 (copy)
        local v66 = SharedUtils.CreateItem(Raid.BossId, false, true);

        if not v66 then
            return;
        end;

        local Animate = v66:FindFirstChild("Animate");

        if Animate then
            Animate:Destroy();
        end;

        local v67 = EnemyResolver(Raid.BossId);
        local WorldModel = Instance.new("WorldModel");
        WorldModel.Name = "CharacterWorld";
        WorldModel.Parent = u64;
        local Vector3_new_ret = Vector3.new(0, 2 + (v67 and v67.ViewportOffset and (v67.ViewportOffset.Y or 0) or 0), 3);
        v66.Parent = WorldModel;
        local Camera = Instance.new("Camera");
        Camera.CFrame = CFrame.new(0, 1.5, v67 and (v67.ViewportDistance or -2.5) or -2.5) * CFrame.Angles(0, 3.141592653589793, 0);
        Camera.Parent = u64;
        u64.CurrentCamera = Camera;
        local Vector3_new_ret2 = Vector3.new(Camera.CFrame.Position.X, 0, Camera.CFrame.Position.Z);
        v66:PivotTo(CFrame.new(Vector3_new_ret, Vector3_new_ret + (Vector3_new_ret2.Magnitude > 0 and Vector3_new_ret2.Unit or Vector3.new(0, 0, -1))) * CFrame.Angles(0, -0.4363323129985824, 0));
        local v68 = nil;

        if v67 then
            v67 = v67.IdleAnim;
        end;

        if v67 then
            local v69 = v66:FindFirstChildWhichIsA("Animator", true);

            if not v69 then
                local v70 = v66:FindFirstChildWhichIsA("Humanoid") or v66:FindFirstChildWhichIsA("AnimationController");

                if v70 then
                    v69 = Instance.new("Animator");
                    v69.Parent = v70;
                end;
            end;

            if v69 then
                local Animation = Instance.new("Animation");
                Animation.AnimationId = v67;
                v68 = v69:LoadAnimation(Animation);
                v68.Looped = true;
                v68:Play();
            end;
        end;

        u35[u61] = {
            raidId = u62,
            worldModel = WorldModel,
            camera = Camera,
            animTrack = v68
        };
    end);

    if not success then
        warn("[RaidSelectController] Failed to render carousel boss for raid", u62, result);
    end;
end;

local function UpdateCarouselLabels() -- Line: 331
    -- upvalues: u17 (ref), u31 (ref), RAID_ORDER (copy), RaidData (copy), u18 (ref), u19 (ref)
    if u17 then
        local v71 = RAID_ORDER[(u31 - 1) % #RAID_ORDER + 1];
        local v72;

        if v71 then
            v72 = RaidData.GetRaid(v71);
        else
            v72 = v71;
        end;

        u17.Text = v72 and v72.DisplayName or (v71 or "");
    end;

    if u18 then
        local v73 = RAID_ORDER[(u31 + 1 - 1) % #RAID_ORDER + 1];
        local v74;

        if v73 then
            v74 = RaidData.GetRaid(v73);
        else
            v74 = v73;
        end;

        u18.Text = v74 and v74.DisplayName or (v73 or "");
    end;

    if u19 then
        local v75 = RAID_ORDER[(u31 - 1 - 1) % #RAID_ORDER + 1];
        local v76;

        if v75 then
            v76 = RaidData.GetRaid(v75);
        else
            v76 = v75;
        end;

        u19.Text = v76 and v76.DisplayName or (v75 or "");
    end;
end;

local function SnapToIndex(p77: number) -- Line: 338
    -- upvalues: u31 (ref), RAID_ORDER (copy), u33 (ref), RenderBossIntoViewport (copy), u14 (ref), u34 (ref), u17 (ref), RaidData (copy), u18 (ref), u19 (ref), RefreshClearTime (copy)
    u31 = (p77 - 1) % #RAID_ORDER + 1;
    local v78 = #RAID_ORDER;
    u33 = {
        Main = 1,
        Next = 2,
        Previous = 3
    };
    RenderBossIntoViewport(1, RAID_ORDER[u31]);

    if u14[1] then
        u14[1].Position = u34.Main;
    end;

    if u14[2] then
        if v78 >= 2 then
            u14[2].Visible = true;
            RenderBossIntoViewport(2, RAID_ORDER[(u31 + 1 - 1) % #RAID_ORDER + 1]);
            u14[2].Position = u34.Next;
        else
            u14[2].Visible = false;
        end;
    end;

    if u14[3] then
        if v78 >= 3 then
            u14[3].Visible = true;
            RenderBossIntoViewport(3, RAID_ORDER[(u31 - 1 - 1) % #RAID_ORDER + 1]);
            u14[3].Position = u34.Previous;
        else
            u14[3].Visible = false;
        end;
    end;

    if u17 then
        local v79 = RAID_ORDER[(u31 - 1) % #RAID_ORDER + 1];
        local v80;

        if v79 then
            v80 = RaidData.GetRaid(v79);
        else
            v80 = v79;
        end;

        u17.Text = v80 and v80.DisplayName or (v79 or "");
    end;

    if u18 then
        local v81 = RAID_ORDER[(u31 + 1 - 1) % #RAID_ORDER + 1];
        local v82;

        if v81 then
            v82 = RaidData.GetRaid(v81);
        else
            v82 = v81;
        end;

        u18.Text = v82 and v82.DisplayName or (v81 or "");
    end;

    if u19 then
        local v83 = RAID_ORDER[(u31 - 1 - 1) % #RAID_ORDER + 1];
        local v84;

        if v83 then
            v84 = RaidData.GetRaid(v83);
        else
            v84 = v83;
        end;

        u19.Text = v84 and v84.DisplayName or (v83 or "");
    end;

    RefreshClearTime();
end;

local function AnimateStep(p85: number) -- Line: 372
    -- upvalues: RAID_ORDER (copy), SnapToIndex (copy), u31 (ref), u30 (ref), u33 (ref), TweenService (copy), u14 (ref), TweenInfo_new_ret (copy), u34 (ref), RenderBossIntoViewport (copy), u17 (ref), RaidData (copy), u18 (ref), u19 (ref), RefreshClearTime (copy)
    if #RAID_ORDER < 3 then
        SnapToIndex(u31 + p85);

        return;
    end;

    u30 = true;
    u31 = (u31 + p85 - 1) % #RAID_ORDER + 1;
    local Main = u33.Main;
    local Next = u33.Next;
    local Previous = u33.Previous;

    if p85 == 1 then
        TweenService:Create(u14[Next], TweenInfo_new_ret, {
            Position = u34.Main
        }):Play();
        TweenService:Create(u14[Main], TweenInfo_new_ret, {
            Position = u34.Previous
        }):Play();
        RenderBossIntoViewport(Previous, RAID_ORDER[(u31 + 1 - 1) % #RAID_ORDER + 1]);
        local Next2 = u34.Next;
        u14[Previous].Position = UDim2.new(Next2.X.Scale + 0.2, Next2.X.Offset, Next2.Y.Scale, Next2.Y.Offset);
        TweenService:Create(u14[Previous], TweenInfo_new_ret, {
            Position = u34.Next
        }):Play();
        u33 = {
            Main = Next,
            Previous = Main,
            Next = Previous
        };
    else
        TweenService:Create(u14[Previous], TweenInfo_new_ret, {
            Position = u34.Main
        }):Play();
        TweenService:Create(u14[Main], TweenInfo_new_ret, {
            Position = u34.Next
        }):Play();
        RenderBossIntoViewport(Next, RAID_ORDER[(u31 - 1 - 1) % #RAID_ORDER + 1]);
        local Previous2 = u34.Previous;
        u14[Next].Position = UDim2.new(Previous2.X.Scale + -0.2, Previous2.X.Offset, Previous2.Y.Scale, Previous2.Y.Offset);
        TweenService:Create(u14[Next], TweenInfo_new_ret, {
            Position = u34.Previous
        }):Play();
        u33 = {
            Main = Previous,
            Next = Main,
            Previous = Next
        };
    end;

    if u17 then
        local v86 = RAID_ORDER[(u31 - 1) % #RAID_ORDER + 1];
        local v87;

        if v86 then
            v87 = RaidData.GetRaid(v86);
        else
            v87 = v86;
        end;

        u17.Text = v87 and v87.DisplayName or (v86 or "");
    end;

    if u18 then
        local v88 = RAID_ORDER[(u31 + 1 - 1) % #RAID_ORDER + 1];
        local v89;

        if v88 then
            v89 = RaidData.GetRaid(v88);
        else
            v89 = v88;
        end;

        u18.Text = v89 and v89.DisplayName or (v88 or "");
    end;

    if u19 then
        local v90 = RAID_ORDER[(u31 - 1 - 1) % #RAID_ORDER + 1];
        local v91;

        if v90 then
            v91 = RaidData.GetRaid(v90);
        else
            v91 = v90;
        end;

        u19.Text = v91 and v91.DisplayName or (v90 or "");
    end;

    RefreshClearTime();
    task.delay(TweenInfo_new_ret.Time, function() -- Line: 409
        -- upvalues: u30 (ref)
        u30 = false;
    end);
end;

local function SyncToRaid(p92: string?, p93: boolean) -- Line: 416
    -- upvalues: u29 (ref), u32 (ref), RAID_ORDER (copy), u31 (ref), AnimateStep (copy), SnapToIndex (copy)
    if not u29 then
        u32 = p92;

        return;
    end;

    if not p92 then
        return;
    end;

    local v94 = nil;

    for i, v in RAID_ORDER do
        if v == p92 then
            v94 = i;
            break;
        end;
    end;

    if not v94 or v94 == u31 then
        return;
    end;

    if p93 and #RAID_ORDER >= 3 then
        if v94 == (u31 + 1 - 1) % #RAID_ORDER + 1 then
            AnimateStep(1);

            return;
        end;

        if v94 == (u31 - 1 - 1) % #RAID_ORDER + 1 then
            AnimateStep(-1);

            return;
        end;
    end;

    SnapToIndex(v94);
end;

local function BuildCarousel() -- Line: 443
    -- upvalues: u29 (ref), u13 (ref), RAID_ORDER (copy), u34 (ref), u15 (ref), u16 (ref), u32 (ref), RaidData (copy), SnapToIndex (copy)
    if u29 then
        return;
    end;

    if not u13 then
        return;
    end;

    if #RAID_ORDER == 0 then
        return;
    end;

    u34 = {
        Main = u13:GetAttribute("Main_Position"),
        Next = u13:GetAttribute("Next_Position"),
        Previous = u13:GetAttribute("Previous_Position")
    };

    if not (u34.Main and (u34.Next and u34.Previous)) then
        warn("[RaidSelectController] CanvasGroup missing Main/Next/Previous_Position attributes");

        return;
    end;

    local v95 = #RAID_ORDER >= 2;

    if u15 then
        u15.Visible = v95;
    end;

    if u16 then
        u16.Visible = v95;
    end;

    local v96 = u32 or RaidData.DEFAULT_RAID;
    local v97 = 1;

    for i, v in RAID_ORDER do
        if v == v96 then
            v97 = i;
            break;
        end;
    end;

    u29 = true;
    u32 = nil;
    SnapToIndex(v97);
end;

local function OnCyclePressed(p98: number) -- Line: 475
    -- upvalues: u29 (ref), u30 (ref), u37 (ref), RAID_ORDER (copy), u31 (ref), AnimateStep (copy), u2 (ref)
    if not u29 or u30 then
        return;
    end;

    if not u37 then
        return;
    end;

    if #RAID_ORDER < 2 then
        return;
    end;

    local v99 = RAID_ORDER[(u31 + p98 - 1) % #RAID_ORDER + 1];
    AnimateStep(p98);

    if u2 then
        u2:RequestSelectRaid(v99);
    end;
end;

local function ClearPlayerViewport(p100: number) -- Line: 491
    -- upvalues: u40 (copy), u25 (ref), u1 (copy)
    local v101 = u40[p100];

    if v101 then
        if v101.animTrack and v101.animTrack.IsPlaying then
            v101.animTrack:Stop();
        end;

        if v101.worldModel and v101.worldModel.Parent then
            v101.worldModel:Destroy();
        end;

        u40[p100] = nil;
    end;

    local v102 = u25 and u25:FindFirstChild(u1[p100]);

    if v102 then
        for _, child in v102:GetChildren() do
            if not child:IsA("UIGradient") then
                child:Destroy();
            end;
        end;
    end;
end;

local function PopulatePlayerViewport(p103: number, p104: userdata) -- Line: 514
    -- upvalues: ClearPlayerViewport (copy), u25 (ref), u1 (copy), CFrame_new_ret2 (copy), CFrame_new_ret (copy), Class_Data (copy), ReplicatedStorage (copy), u40 (copy)
    ClearPlayerViewport(p103);
    local v105 = u25 and u25:FindFirstChild(u1[p103]);

    if not v105 then
        return;
    end;

    local Character = p104.Character;

    if not Character then
        return;
    end;

    local Archivable = Character.Archivable;
    Character.Archivable = true;
    local v106 = Character:Clone();
    Character.Archivable = Archivable;

    for _, descendant in v106:GetDescendants() do
        if descendant:IsA("BaseScript") or (descendant:IsA("Tool") or (descendant:IsA("ForceField") or descendant:IsA("BillboardGui"))) then
            descendant:Destroy();
        end;
    end;

    local WorldModel = Instance.new("WorldModel");
    WorldModel.Name = "CharacterWorld";
    WorldModel.Parent = v105;
    v106:PivotTo(CFrame_new_ret2);
    v106.Parent = WorldModel;

    for _, child in v106:GetChildren() do
        if child:IsA("Accessory") then
            local Handle = child:FindFirstChild("Handle");

            if Handle then
                local v107 = Handle:FindFirstChildOfClass("Attachment");

                if v107 then
                    for _, child2 in v106:GetChildren() do
                        if child2:IsA("BasePart") then
                            local v108 = child2:FindFirstChild(v107.Name);

                            if v108 and v108:IsA("Attachment") then
                                local Weld = Instance.new("Weld");
                                Weld.Part0 = child2;
                                Weld.Part1 = Handle;
                                Weld.C0 = v108.CFrame;
                                Weld.C1 = v107.CFrame;
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
    Camera.Parent = v105;
    v105.CurrentCamera = Camera;
    local v109 = nil;
    local v110 = v106:FindFirstChildOfClass("Humanoid");

    if v110 then
        local v111 = v110:FindFirstChildOfClass("Animator");

        if not v111 then
            v111 = Instance.new("Animator");
            v111.Parent = v110;
        end;

        local v112 = Class_Data[p104:GetAttribute("Stat_ActiveClass") or ""];
        local v113;

        if v112 and (v112.AnimationOverrides and v112.AnimationOverrides.idle) then
            v113 = v112.AnimationOverrides.idle;
        else
            v113 = nil;
        end;

        local v114 = nil;

        if v113 then
            v114 = Instance.new("Animation");
            v114.AnimationId = v113;
        else
            local v115 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Idle_Animations");

            if v115 then
                v114 = v115:FindFirstChild("Hitman_Idle");
            end;
        end;

        if v114 then
            v109 = v111:LoadAnimation(v114);
            v109.Looped = true;
            v109:Play();
        end;
    end;

    u40[p103] = {
        clone = v106,
        animTrack = v109,
        worldModel = WorldModel,
        camera = Camera,
        userId = p104.UserId
    };
end;

local function OpenInvitePicker() -- Line: 616
    -- upvalues: u5 (ref), u2 (ref), u39 (copy)
    if not u5 then
        return;
    end;

    u5:Open({
        Header = "INVITE",
        Subtitle = "Select a player to invite",
        CloseOnSelect = false,
        MarkInvitedOnSelect = true,

        OnSelect = function(p116) -- Line: 624, Name: OnSelect
            -- upvalues: u2 (ref), u39 (ref)
            if not u2 then
                return;
            end;

            local UserId = p116.UserId;
            local v117 = u39[UserId];

            if v117 and os.clock() - v117 < 30 then
                return;
            end;

            u39[UserId] = os.clock();
            u2:RequestInvite(UserId);
        end
    });
end;

local function ApplySlot(p118: number, u119: any) -- Line: 638
    -- upvalues: u27 (copy), u28 (copy), Players (copy), HeadShot (copy), Size100x100 (copy), u40 (copy), PopulatePlayerViewport (copy), u37 (ref), ClearPlayerViewport (copy)
    local u120 = u27[p118];

    if not u120 then
        return;
    end;

    if u119 then
        u28[p118] = u119.UserId;

        if u120.PlayerCard then
            u120.PlayerCard.Visible = true;
        end;

        if u120.AddCard then
            u120.AddCard.Visible = false;
        end;

        if u120.ProfileImage then
            task.spawn(function() -- Line: 649
                -- upvalues: u119 (copy), Players (ref), HeadShot (ref), Size100x100 (ref), u120 (copy)
                local UserId = u119.UserId;
                local success, result = pcall(function() -- Line: 147
                    -- upvalues: Players (ref), UserId (copy), HeadShot (ref), Size100x100 (ref)
                    return Players:GetUserThumbnailAsync(UserId, HeadShot, Size100x100);
                end);
                local v121 = success and result and result or "";

                if u120.ProfileImage.Parent then
                    u120.ProfileImage.Image = v121;
                end;
            end);
        end;

        if u120.PlayerName then
            u120.PlayerName.Text = u119.DisplayName or (u119.Name or "");
        end;

        if u120.PlayerLevel then
            local PlayerByUserId = Players:GetPlayerByUserId(u119.UserId);
            local v122;

            if PlayerByUserId then
                local leaderstats = PlayerByUserId:FindFirstChild("leaderstats");

                if leaderstats then
                    leaderstats = leaderstats:FindFirstChild("Level");
                end;

                v122 = leaderstats and leaderstats.Value or PlayerByUserId:GetAttribute("PlayerLevel") or (u119.PlayerLevel or 1);
            else
                v122 = u119.PlayerLevel or 1;
            end;

            u120.PlayerLevel.Text = "Lv. " .. v122;
        end;

        local PlayerByUserId = Players:GetPlayerByUserId(u119.UserId);

        if PlayerByUserId then
            local v123 = u40[p118];

            if not v123 or v123.userId ~= u119.UserId then
                PopulatePlayerViewport(p118, PlayerByUserId);
            end;
        end;
    else
        u28[p118] = nil;

        if u120.PlayerCard then
            u120.PlayerCard.Visible = false;
        end;

        if u120.AddCard then
            u120.AddCard.Visible = u37;
        end;

        ClearPlayerViewport(p118);
    end;
end;

local function RefreshPartyRoster(p124) -- Line: 695
    -- upvalues: u36 (ref), u37 (ref), LocalPlayer (copy), MAX_PARTY_SIZE (copy), ApplySlot (copy), u22 (ref), u15 (ref), u16 (ref), u20 (copy), SyncToRaid (copy), RaidData (copy), DEFAULT_DIFFICULTY (ref), ApplyDifficultyVisuals (copy)
    u36 = p124;
    u37 = p124 and p124.LeaderId == LocalPlayer.UserId and true or false;
    local v125 = {};

    if p124 and p124.Members then
        for _, v in p124.Members do
            if v.UserId == p124.LeaderId then
                table.insert(v125, 1, v);
            end;
        end;

        for _, v in p124.Members do
            if v.UserId ~= p124.LeaderId then
                table.insert(v125, v);
            end;
        end;
    end;

    for i = 1, MAX_PARTY_SIZE do
        ApplySlot(i, v125[i]);
        local _ = i;
    end;

    if u22 then
        u22.Visible = u37;
    end;

    if u15 then
        u15.Interactable = u37;
    end;

    if u16 then
        u16.Interactable = u37;
    end;

    for _, v in u20 do
        if v.Button then
            v.Button.Interactable = u37;
        end;
    end;

    if p124 then
        if p124.SelectedRaid then
            SyncToRaid(p124.SelectedRaid, true);
        end;

        if p124.SelectedRaidDifficulty then
            local SelectedRaidDifficulty = p124.SelectedRaidDifficulty;

            if not RaidData.IsValidDifficulty(SelectedRaidDifficulty) then
                return;
            end;

            if DEFAULT_DIFFICULTY == SelectedRaidDifficulty then
                ApplyDifficultyVisuals();

                return;
            end;

            DEFAULT_DIFFICULTY = SelectedRaidDifficulty;
            ApplyDifficultyVisuals();
        end;
    end;
end;

local function OnOpen() -- Line: 743
    -- upvalues: u9 (ref), u2 (ref), RefreshPartyRoster (copy), RefreshClearTime (copy), u40 (copy)
    u9 = true;

    if u2 then
        task.spawn(function() -- Line: 748
            -- upvalues: u2 (ref), RefreshPartyRoster (ref)
            u2:RequestSelectMode("Raids"):await();
            local v126, v127 = u2:RequestPartyData():await();

            if v126 and v127 then
                RefreshPartyRoster(v127);
            end;
        end);
    end;

    RefreshClearTime();

    for _, v in u40 do
        if v.animTrack and not v.animTrack.IsPlaying then
            v.animTrack:Play();
        end;
    end;
end;

local function OnClose() -- Line: 768
    -- upvalues: u9 (ref), u40 (copy), u2 (ref)
    u9 = false;

    for _, v in u40 do
        if v.animTrack and v.animTrack.IsPlaying then
            v.animTrack:Stop();
        end;
    end;

    if u2 then
        task.spawn(function() -- Line: 780
            -- upvalues: u2 (ref)
            u2:RequestSelectMode("Dungeon"):await();
        end);
    end;
end;

local v128 = Knit.CreateController({
    Name = "RaidSelectController"
});

function v128.Open(p129) -- Line: 792
    -- upvalues: u9 (ref), u7 (ref), OnOpen (copy)
    if u9 then
        return;
    end;

    if not u7 then
        return;
    end;

    u7:open();
    OnOpen();
end;

function v128.Close(p130) -- Line: 799
    -- upvalues: u9 (ref), u7 (ref)
    if not u9 then
        return;
    end;

    if not u7 then
        return;
    end;

    u7:close();
end;

function v128.Toggle(p131) -- Line: 805
    -- upvalues: u9 (ref)
    if u9 then
        p131:Close();

        return;
    end;

    p131:Open();
end;

function v128.IsOpen(p132) -- Line: 813
    -- upvalues: u9 (ref)
    return u9;
end;

function v128.KnitInit(p133) -- Line: 819
    -- upvalues: Knit (copy), u6 (ref), u7 (ref), UIController (copy), OnClose (copy), u8 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u18 (ref), u16 (ref), u19 (ref), u17 (ref), RaidData (copy), u20 (copy), u21 (ref), u22 (ref), u23 (ref), u24 (ref), u25 (ref), u26 (ref), MAX_PARTY_SIZE (copy), u27 (copy)
    u6 = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("Frames"):FindFirstChild("Raid");

    if not u6 then
        warn("[RaidSelectController] Raid frame not found in Main.Frames");

        return;
    end;

    u6.Visible = false;
    u7 = UIController._cached[u6] or UIController.new(u6);
    u7.onClose = OnClose;
    u8 = u6:FindFirstChild("Close");
    local Content = u6:FindFirstChild("Content");

    if not Content then
        warn("[RaidSelectController] Raid.Content not found");

        return;
    end;

    u10 = Content:FindFirstChild("LeftFrame");

    if u10 then
        u11 = u10:FindFirstChild("Season_Time");

        if u11 then
            u11.Visible = false;
        end;

        local Text = u10:FindFirstChild("Text");

        if Text then
            Text = Text:FindFirstChild("Clear_Time");
        end;

        u12 = Text;
        u13 = u10:FindFirstChild("CanvasGroup");

        if u13 then
            u14 = { u13:FindFirstChild("Viewport_1"), u13:FindFirstChild("Viewport_2"), u13:FindFirstChild("Viewport_3") };
        end;

        u15 = u10:FindFirstChild("CycleForward");
        local v134 = u15 and u15:FindFirstChild("BossName");
        u18 = v134;
        u16 = u10:FindFirstChild("CycleBack");
        local v135 = u16 and u16:FindFirstChild("BossName");
        u19 = v135;
        local Display = u10:FindFirstChild("Display");

        if Display then
            Display = Display:FindFirstChild("BossName");
        end;

        u17 = Display;

        for _, v in RaidData.DIFFICULTY_ORDER do
            local v136 = u10:FindFirstChild(v);

            if v136 then
                local Background = v136:FindFirstChild("Background");
                local Text2 = v136:FindFirstChild("Text");
                u20[v] = {
                    Button = v136,
                    Background = Background,
                    Text = Text2,
                    BgColor = Background and Background.ImageColor3 or Color3.new(1, 1, 1),
                    TextColor = Text2 and Text2.TextColor3 or Color3.new(1, 1, 1)
                };
            else
                warn((`[RaidSelectController] Difficulty button "{v}" not found in LeftFrame`));
            end;
        end;
    end;

    local Buttons = Content:FindFirstChild("Buttons");

    if Buttons then
        u21 = Buttons:FindFirstChild("Rewards");

        if u21 then
            u21.Visible = false;
        end;

        local Enter = Buttons:FindFirstChild("Enter");

        if Enter then
            u22 = Enter;
            u23 = Enter:FindFirstChild("Text");
        end;

        u24 = Buttons:FindFirstChild("Leave");
    end;

    u25 = Content:FindFirstChild("RightFrame");

    if u25 then
        local Party = u25:FindFirstChild("Party");

        if Party then
            Party = Party:FindFirstChild("Players");
        end;

        u26 = Party;

        if u26 then
            for i = 1, MAX_PARTY_SIZE do
                local v137 = u26:FindFirstChild((tostring(i)));
                local v138;

                if v137 then
                    local Player = v137:FindFirstChild("Player");
                    local v139 = {
                        Slot = v137,
                        PlayerCard = Player,
                        AddCard = v137:FindFirstChild("Add")
                    };
                    local v140;

                    if Player then
                        v140 = Player:FindFirstChild("ProfileImage");
                    else
                        v140 = Player;
                    end;

                    v139.ProfileImage = v140;
                    local v141;

                    if Player then
                        v141 = Player:FindFirstChild("PlayerName");
                    else
                        v141 = Player;
                    end;

                    v139.PlayerName = v141;

                    if Player then
                        Player = Player:FindFirstChild("PlayerLevel");
                    end;

                    v139.PlayerLevel = Player;
                    u27[i] = v139;
                    v138 = i;
                else
                    v138 = i;
                end;
            end;
        end;
    end;
end;

function v128.KnitStart(u142) -- Line: 934
    -- upvalues: u6 (ref), u2 (ref), Knit (copy), u3 (ref), u4 (ref), u5 (ref), BuildCarousel (copy), u15 (ref), u29 (ref), u30 (ref), u37 (ref), RAID_ORDER (copy), u31 (ref), AnimateStep (copy), u16 (ref), u20 (copy), RaidData (copy), DEFAULT_DIFFICULTY (ref), ApplyDifficultyVisuals (copy), ReplicatedStorage (copy), u9 (ref), OnOpen (copy), OnClose (copy), u8 (ref), u7 (ref), MAX_PARTY_SIZE (copy), u27 (copy), u28 (copy), OpenInvitePicker (copy), u22 (ref), u38 (ref), u23 (ref), u24 (ref), RefreshPartyRoster (copy), Registry (copy), RefreshClearTime (copy)
    if not u6 then
        return;
    end;

    pcall(function() -- Line: 938
        -- upvalues: u2 (ref), Knit (ref)
        u2 = Knit.GetService("DungeonQueueService");
    end);
    pcall(function() -- Line: 939
        -- upvalues: u3 (ref), Knit (ref)
        u3 = Knit.GetController("SoundController");
    end);
    pcall(function() -- Line: 940
        -- upvalues: u4 (ref), Knit (ref)
        u4 = Knit.GetController("NotificationController");
    end);
    pcall(function() -- Line: 941
        -- upvalues: u5 (ref), Knit (ref)
        u5 = Knit.GetController("PlayerListController");
    end);
    task.spawn(BuildCarousel);

    if u15 then
        u15.Activated:Connect(function() -- Line: 948
            -- upvalues: u29 (ref), u30 (ref), u37 (ref), RAID_ORDER (ref), u31 (ref), AnimateStep (ref), u2 (ref)
            if u29 then
                if u30 then
                    return;
                end;

                if not u37 then
                    return;
                end;

                if #RAID_ORDER < 2 then
                    return;
                end;

                local v143 = RAID_ORDER[(u31 + 1 - 1) % #RAID_ORDER + 1];
                AnimateStep(1);

                if u2 then
                    u2:RequestSelectRaid(v143);
                end;
            end;
        end);
    end;

    if u16 then
        u16.Activated:Connect(function() -- Line: 951
            -- upvalues: u29 (ref), u30 (ref), u37 (ref), RAID_ORDER (ref), u31 (ref), AnimateStep (ref), u2 (ref)
            if u29 then
                if u30 then
                    return;
                end;

                if not u37 then
                    return;
                end;

                if #RAID_ORDER < 2 then
                    return;
                end;

                local v144 = RAID_ORDER[(u31 + -1 - 1) % #RAID_ORDER + 1];
                AnimateStep(-1);

                if u2 then
                    u2:RequestSelectRaid(v144);
                end;
            end;
        end);
    end;

    for i, v in u20 do
        if v.Button then
            v.Button.Activated:Connect(function() -- Line: 957
                -- upvalues: u37 (ref), i (copy), RaidData (ref), DEFAULT_DIFFICULTY (ref), ApplyDifficultyVisuals (ref), u2 (ref)
                if not u37 then
                    return;
                end;

                local v145 = i;

                if not RaidData.IsValidDifficulty(v145) then
                    return;
                end;

                local _ = DEFAULT_DIFFICULTY == v145;
                DEFAULT_DIFFICULTY = v145;
                ApplyDifficultyVisuals();

                if u37 and u2 then
                    u2:RequestSelectRaidDifficulty(v145);
                end;
            end);
        end;
    end;

    ApplyDifficultyVisuals();
    task.spawn(function() -- Line: 968
        -- upvalues: u142 (copy)
        local v146 = workspace:WaitForChild("Prompts"):WaitForChild("Raid"):FindFirstChildOfClass("ProximityPrompt");

        if v146 then
            v146.PromptShown:Connect(function() -- Line: 974
                -- upvalues: u142 (ref)
                u142:Open();
            end);
            v146.PromptHidden:Connect(function() -- Line: 977
                -- upvalues: u142 (ref)
                u142:Close();
            end);
            v146.Triggered:Connect(function() -- Line: 980
                -- upvalues: u142 (ref)
                u142:Toggle();
            end);
        end;
    end);
    task.spawn(function() -- Line: 989
        -- upvalues: ReplicatedStorage (ref), u142 (copy)
        local Remotes = ReplicatedStorage:WaitForChild("Remotes", 30);

        if not Remotes then
            return;
        end;

        local AdminOpenRaid = Remotes:WaitForChild("AdminOpenRaid", 30);

        if AdminOpenRaid then
            AdminOpenRaid.OnClientEvent:Connect(function() -- Line: 994
                -- upvalues: u142 (ref)
                u142:Open();
            end);
        end;
    end);
    u6:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 1001
        -- upvalues: u6 (ref), u9 (ref), OnOpen (ref), OnClose (ref)
        if u6.Visible then
            if not u9 then
                OnOpen();
            end;
        elseif u9 then
            OnClose();
        end;
    end);

    if u8 then
        u8.Activated:Connect(function() -- Line: 1015
            -- upvalues: u7 (ref)
            if u7 then
                u7:close();
            end;
        end);
    end;

    for i = 1, MAX_PARTY_SIZE do
        local v147 = u27[i];
        local v148;

        if v147 and (v147.Slot and v147.Slot:IsA("GuiButton")) then
            v147.Slot.Activated:Connect(function() -- Line: 1026
                -- upvalues: u37 (ref), u28 (ref), i (copy), OpenInvitePicker (ref)
                if not u37 then
                    return;
                end;

                if u28[i] == nil then
                    OpenInvitePicker();
                end;
            end);
            v148 = i;
        else
            v148 = i;
        end;
    end;

    if u22 then
        u22.Activated:Connect(function() -- Line: 1037
            -- upvalues: u37 (ref), u2 (ref), u38 (ref), u22 (ref), u23 (ref), u3 (ref), u4 (ref)
            if not u37 then
                return;
            end;

            if not u2 then
                return;
            end;

            if u38 then
                return;
            end;

            u38 = true;
            u22.Active = false;

            if u23 then
                u23.Text = "MOVING...";
            end;

            local v149, v150, v151 = u2:RequestEnter():await();

            if v149 and v150 then
                if u3 then
                    pcall(function() -- Line: 1051
                        -- upvalues: u3 (ref)
                        u3:PlaySound("GiftReceived");
                    end);
                end;

                task.delay(20, function() -- Line: 1054
                    -- upvalues: u23 (ref), u38 (ref), u22 (ref)
                    if u23 and u23.Text == "MOVING..." then
                        u23.Text = "ENTER";
                        u38 = false;

                        if u22 then
                            u22.Active = true;
                        end;
                    end;
                end);

                return;
            end;

            if u23 then
                u23.Text = "ENTER";
            end;

            u38 = false;
            u22.Active = true;

            if u4 then
                if type(v151) ~= "string" then
                    v151 = (v149 or type(v150) ~= "string") and "Failed to start Raid" or v150;
                end;

                u4:Show("Custom", v151, 3, Color3.fromRGB(255, 200, 80), Color3.fromRGB(60, 45, 15), "Error");
            end;
        end);
    end;

    if u24 then
        u24.Activated:Connect(function() -- Line: 1084
            -- upvalues: u2 (ref)
            if u2 then
                u2:RequestLeaveParty();
            end;
        end);
    end;

    if u2 then
        u2.PartyUpdate:Connect(function(p152) -- Line: 1095
            -- upvalues: u9 (ref), RefreshPartyRoster (ref)
            if not u9 then
                return;
            end;

            RefreshPartyRoster(p152);
        end);
    end;

    local v153 = Registry:Get("PlayerData");

    if v153 then
        v153:OnChange(function(p154, p155) -- Line: 1106
            -- upvalues: RefreshClearTime (ref)
            if p155[1] == "DungeonBestTimes" then
                RefreshClearTime();
            end;
        end);
    end;
end;

return v128;