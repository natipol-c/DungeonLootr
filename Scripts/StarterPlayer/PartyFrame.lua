--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PartyFrame
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.PartyFrame
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(script.Parent.Parent.Controllers.Registry);
local spr = require(script.Parent.Parent.ClientUtils.spr);
local Class_Data = require(ReplicatedStorage.Classes.Class_Data);
local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
local LocalPlayer = Players.LocalPlayer;
local v1 = {};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = {};
local u7 = false;
local u8 = nil;
local u9 = nil;

local function SetStrokeGradient(p10: userdata, p11: string) -- Line: 49
    for _, child in p10:GetChildren() do
        if child:IsA("UIGradient") then
            child.Enabled = child.Name == p11;
        end;
    end;
end;

local function FormatBar(p12: number, p13: number) -- Line: 58
    local math_max_ret = math.max(p12, 0);

    return math.floor(math_max_ret) .. " / " .. math.floor(p13);
end;

local function AnimateBar(p14: userdata, p15: number, p16: number, p17: boolean?) -- Line: 63
    -- upvalues: spr (copy)
    local math_clamp_ret = math.clamp(p15, 0, 1);

    if p17 then
        spr.stop(p14, "Size");
        p14.Size = UDim2.fromScale(math_clamp_ret, 1);

        return math_clamp_ret;
    end;

    if math.abs(math_clamp_ret - p16) >= 0.1 then
        spr.target(p14, 0.85, 3, {
            Size = UDim2.fromScale(math_clamp_ret, 1)
        });

        return math_clamp_ret;
    end;

    spr.target(p14, 1, 8, {
        Size = UDim2.fromScale(math_clamp_ret, 1)
    });

    return math_clamp_ret;
end;

local function SetupViewport(u18: userdata, u19: userdata, p20: number) -- Line: 82
    for _, child in u18:GetChildren() do
        if child:IsA("WorldModel") or child:IsA("Camera") then
            child:Destroy();
        end;
    end;

    local success, result = pcall(function() -- Line: 90
        -- upvalues: u19 (copy), u18 (copy)
        if not u19:FindFirstChild("Head") then
            error("No Head found");
        end;

        local Archivable = u19.Archivable;
        u19.Archivable = true;
        local v21 = u19:Clone();
        u19.Archivable = Archivable;

        if not v21 then
            error("Clone failed");
        end;

        for _, descendant in v21:GetDescendants() do
            if descendant:IsA("BaseScript") or descendant:IsA("Sound") then
                descendant:Destroy();
            end;
        end;

        local u22 = v21:FindFirstChildOfClass("Humanoid");

        if u22 then
            u22.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        end;

        local WorldModel = Instance.new("WorldModel");
        WorldModel.Parent = u18;
        v21:PivotTo(CFrame.new(0, 0, 0) * CFrame.Angles(0, 0.2617993877991494, 0));
        v21.Parent = WorldModel;
        local Camera = Instance.new("Camera");
        Camera.FieldOfView = 30;
        Camera.CFrame = CFrame.new(0.2, 1.1, -5) * CFrame.fromOrientation(0, 3.056088973534591, 0);
        Camera.Parent = u18;
        u18.CurrentCamera = Camera;

        if u22 then
            u22 = u22:FindFirstChildOfClass("Animator");
        end;

        if u22 then
            local u23 = u19:FindFirstChildOfClass("Humanoid");
            local u24;

            if u23 then
                u24 = u23:FindFirstChildOfClass("Animator");
            else
                u24 = u23;
            end;

            if u24 then
                task.spawn(function() -- Line: 137
                    -- upvalues: u23 (copy), u22 (copy), u24 (copy)
                    if u23:GetState() == Enum.HumanoidStateType.Freefall then
                        u23.StateChanged:Wait();
                        task.wait(0.15);
                    end;

                    if not (u22 and u22.Parent) then
                        return;
                    end;

                    for _, v in u24:GetPlayingAnimationTracks() do
                        if v.Animation then
                            local v25 = u22:LoadAnimation(v.Animation);
                            v25.Priority = v.Priority;
                            v25:Play(0, 1, v.Speed);
                            v25.TimePosition = v.TimePosition;

                            return;
                        end;
                    end;
                end);
            end;
        end;
    end);

    if success then
        return true;
    end;

    warn("[PartyFrame] Viewport setup failed for userId", p20, ":", result);

    return false;
end;

local function SetThumbnail(u26: userdata, u27: number) -- Line: 167
    -- upvalues: Players (copy)
    task.spawn(function() -- Line: 168
        -- upvalues: Players (ref), u27 (copy), u26 (copy)
        local success, result = pcall(function() -- Line: 169
            -- upvalues: Players (ref), u27 (ref)
            return Players:GetUserThumbnailAsync(u27, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150);
        end);

        if success and result then
            u26.Image = result;
        end;
    end);
end;

local function SetupDisplay(p28: userdata, p29: userdata, u30: number) -- Line: 183
    -- upvalues: u7 (ref), Players (copy), SetupViewport (copy)
    local ImageLabel = p28:FindFirstChild("ImageLabel");

    if not ImageLabel then
        return;
    end;

    local ViewportFrame = ImageLabel:FindFirstChild("ViewportFrame");

    if u7 then
        if ViewportFrame then
            ViewportFrame.Visible = false;
        end;

        task.spawn(function() -- Line: 168
            -- upvalues: Players (ref), u30 (copy), ImageLabel (copy)
            local success, result = pcall(function() -- Line: 169
                -- upvalues: Players (ref), u30 (ref)
                return Players:GetUserThumbnailAsync(u30, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150);
            end);

            if success and result then
                ImageLabel.Image = result;
            end;
        end);

        return;
    end;

    local Character = p29.Character;

    if Character and ViewportFrame then
        ViewportFrame.Visible = true;
        ImageLabel.Image = "";

        if not SetupViewport(ViewportFrame, Character, u30) then
            if ViewportFrame then
                ViewportFrame.Visible = false;
            end;

            task.spawn(function() -- Line: 168
                -- upvalues: Players (ref), u30 (copy), ImageLabel (copy)
                local success, result = pcall(function() -- Line: 169
                    -- upvalues: Players (ref), u30 (ref)
                    return Players:GetUserThumbnailAsync(u30, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150);
                end);

                if success and result then
                    ImageLabel.Image = result;
                end;
            end);
        end;
    else
        if ViewportFrame then
            ViewportFrame.Visible = false;
        end;

        task.spawn(function() -- Line: 168
            -- upvalues: Players (ref), u30 (copy), ImageLabel (copy)
            local success, result = pcall(function() -- Line: 169
                -- upvalues: Players (ref), u30 (ref)
                return Players:GetUserThumbnailAsync(u30, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150);
            end);

            if success and result then
                ImageLabel.Image = result;
            end;
        end);
    end;
end;

local function UpdateClassDisplay(p31: userdata, p32: userdata) -- Line: 216
    -- upvalues: Class_Data (copy), RarityColors (copy), SetStrokeGradient (copy)
    local Class = p31:FindFirstChild("Class");

    if not Class then
        return;
    end;

    local v33 = p32:GetAttribute("Active_Class") or "";
    Class.Text = v33;
    local v34 = Class_Data.GetRarity(v33) or "Rare";
    local v35 = RarityColors[v34];

    if v35 then
        Class.TextColor3 = v35.TextColor3;
    end;

    local UIStroke = Class:FindFirstChild("UIStroke");

    if UIStroke then
        SetStrokeGradient(UIStroke, v34);
    end;
end;

local function UpdateHealth(p36: userdata, p37: userdata, p38: number, p39: boolean?) -- Line: 238
    -- upvalues: AnimateBar (copy)
    local Health = p37.Health;
    local math_max_ret = math.max(p37.MaxHealth, 1);
    local v40 = Health / math_max_ret;
    local Health2 = p36:FindFirstChild("Health");

    if Health2 then
        local Health_Color = Health2:FindFirstChild("Health_Color");

        if Health_Color then
            p38 = AnimateBar(Health_Color, v40, p38, p39);
        end;
    end;

    local Health_Amount = p36:FindFirstChild("Health_Amount");

    if Health_Amount then
        local math_max_ret2 = math.max(Health, 0);
        Health_Amount.Text = math.floor(math_max_ret2) .. " / " .. math.floor(math_max_ret);
    end;

    return p38;
end;

local function UpdateLevel(p41: userdata, p42: userdata) -- Line: 286
    local Level = p41:FindFirstChild("Level");

    if not Level then
        return;
    end;

    local leaderstats = p42:FindFirstChild("leaderstats");

    if leaderstats then
        leaderstats = leaderstats:FindFirstChild("Level");
    end;

    Level.Text = "Level. " .. (leaderstats and leaderstats.Value or 1);
end;

local function HookMemberListeners(u43: number, u44: userdata, u45: userdata) -- Line: 297
    -- upvalues: UpdateHealth (copy), UpdateClassDisplay (copy), SetupDisplay (copy)
    local u46 = {};
    local u47 = 0;

    local function HookHumanoid(p48: userdata) -- Line: 303
        -- upvalues: u47 (ref), UpdateHealth (ref), u44 (copy), u46 (copy)
        local u49 = p48:FindFirstChildOfClass("Humanoid") or p48:WaitForChild("Humanoid", 5);

        if not u49 then
            return;
        end;

        u47 = UpdateHealth(u44, u49, u47, true);
        table.insert(u46, u49.HealthChanged:Connect(function() -- Line: 311
            -- upvalues: u47 (ref), UpdateHealth (ref), u44 (ref), u49 (copy)
            u47 = UpdateHealth(u44, u49, u47);
        end));
        local PropertyChangedSignal = u49:GetPropertyChangedSignal("MaxHealth");
        table.insert(u46, PropertyChangedSignal:Connect(function() -- Line: 315
            -- upvalues: u47 (ref), UpdateHealth (ref), u44 (ref), u49 (copy)
            u47 = UpdateHealth(u44, u49, u47);
        end));
    end;

    local Level = u44:FindFirstChild("Level");

    if Level then
        local leaderstats = u45:FindFirstChild("leaderstats");

        if leaderstats then
            leaderstats = leaderstats:FindFirstChild("Level");
        end;

        Level.Text = "Level. " .. (leaderstats and leaderstats.Value or 1);
    end;

    local leaderstats = u45:FindFirstChild("leaderstats");

    if leaderstats then
        leaderstats = leaderstats:FindFirstChild("Level");
    end;

    if leaderstats then
        table.insert(u46, leaderstats.Changed:Connect(function() -- Line: 339
            -- upvalues: u44 (copy), u45 (copy)
            local Level2 = u44:FindFirstChild("Level");

            if not Level2 then
                return;
            end;

            local leaderstats2 = u45:FindFirstChild("leaderstats");

            if leaderstats2 then
                leaderstats2 = leaderstats2:FindFirstChild("Level");
            end;

            Level2.Text = "Level. " .. (leaderstats2 and leaderstats2.Value or 1);
        end));
    end;

    UpdateClassDisplay(u44, u45);
    local AttributeChangedSignal = u45:GetAttributeChangedSignal("Active_Class");
    table.insert(u46, AttributeChangedSignal:Connect(function() -- Line: 346
        -- upvalues: UpdateClassDisplay (ref), u44 (copy), u45 (copy), SetupDisplay (ref), u43 (copy)
        UpdateClassDisplay(u44, u45);
        SetupDisplay(u44, u45, u43);
    end));

    if u45.Character then
        HookHumanoid(u45.Character);
    end;

    table.insert(u46, u45.CharacterAppearanceLoaded:Connect(function(p50) -- Line: 358
        -- upvalues: HookHumanoid (copy), SetupDisplay (ref), u44 (copy), u45 (copy), u43 (copy)
        HookHumanoid(p50);
        SetupDisplay(u44, u45, u43);
    end));

    return u46;
end;

local function AddMember(p51: number, p52: string) -- Line: 370
    -- upvalues: u6 (copy), Players (copy), u5 (ref), SetupDisplay (copy), u4 (ref), HookMemberListeners (copy)
    if u6[p51] then
        return;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(p51);

    if not PlayerByUserId then
        return;
    end;

    local v53 = u5:Clone();
    v53.Name = "Member_" .. p51;
    v53.Visible = true;
    local PlayerName = v53:FindFirstChild("PlayerName");

    if PlayerName then
        PlayerName.Text = p52;
    end;

    SetupDisplay(v53, PlayerByUserId, p51);
    v53.Parent = u4;
    u6[p51] = {
        card = v53,
        connections = HookMemberListeners(p51, v53, PlayerByUserId),
        player = PlayerByUserId
    };
end;

local function RemoveMember(p54: number) -- Line: 403
    -- upvalues: u6 (copy)
    local v55 = u6[p54];

    if not v55 then
        return;
    end;

    for _, v in v55.connections do
        v:Disconnect();
    end;

    v55.card:Destroy();
    u6[p54] = nil;
end;

local function RefreshRoster(p56) -- Line: 421
    -- upvalues: u6 (copy), u3 (ref), LocalPlayer (copy), AddMember (copy)
    if not (p56 and p56.Members) then
        for i in u6 do
            local v57 = u6[i];

            if v57 then
                for _, v in v57.connections do
                    v:Disconnect();
                end;

                v57.card:Destroy();
                u6[i] = nil;
            end;
        end;

        u3.Visible = false;

        return;
    end;

    local v58 = {};

    for _, v in p56.Members do
        if v.UserId ~= LocalPlayer.UserId then
            v58[v.UserId] = v.DisplayName or (v.Name or "Player");
        end;
    end;

    for i in u6 do
        if not v58[i] then
            local v59 = u6[i];

            if v59 then
                for _, v in v59.connections do
                    v:Disconnect();
                end;

                v59.card:Destroy();
                u6[i] = nil;
            end;
        end;
    end;

    for i, v in v58 do
        if not u6[i] then
            AddMember(i, v);
        end;
    end;

    u3.Visible = next(u6) ~= nil;
end;

function v1.SetDisplayMode(p60: boolean) -- Line: 460
    -- upvalues: u7 (ref), u6 (copy), SetupDisplay (copy)
    u7 = p60;

    for i, v in u6 do
        SetupDisplay(v.card, v.player, i);
    end;
end;

function v1._Init(p61) -- Line: 471
    -- upvalues: u2 (ref), u3 (ref), u4 (ref), u5 (ref), u8 (ref), Knit (copy), u9 (ref), RefreshRoster (copy), LocalPlayer (copy), Players (copy), u6 (copy)
    u2 = p61;
    u3 = u2.HUD:FindFirstChild("Party_Frame");

    if not u3 then
        warn("[PartyFrame] HUD.Party_Frame not found");

        return;
    end;

    u4 = u3:FindFirstChild("Holder");

    if not u4 then
        warn("[PartyFrame] Party_Frame.Holder not found");

        return;
    end;

    u5 = u4:FindFirstChild("Player_Info");

    if not u5 then
        warn("[PartyFrame] Player_Info template not found");

        return;
    end;

    u5.Visible = false;
    u3.Visible = false;
    u8 = Knit.GetService("DungeonQueueService");
    u9 = Knit.GetService("DungeonRunService");
    u8.PartyUpdate:Connect(function(p62) -- Line: 502
        -- upvalues: RefreshRoster (ref)
        RefreshRoster(p62);
    end);
    u9.SessionMemberUpdate:Connect(function(p63) -- Line: 509
        -- upvalues: RefreshRoster (ref)
        RefreshRoster({
            Members = p63
        });
    end);

    if LocalPlayer:GetAttribute("InDungeon") then
        local v64, v65 = u9:GetSessionMembers():await();

        if v64 and v65 then
            RefreshRoster({
                Members = v65
            });
        end;
    else
        local v66, v67 = u8:RequestPartyData():await();

        if v66 and v67 then
            RefreshRoster(v67);
        end;
    end;

    LocalPlayer:GetAttributeChangedSignal("InDungeon"):Connect(function() -- Line: 528
        -- upvalues: LocalPlayer (ref), u9 (ref), RefreshRoster (ref)
        if LocalPlayer:GetAttribute("InDungeon") then
            local v68, v69 = u9:GetSessionMembers():await();

            if v68 and v69 then
                RefreshRoster({
                    Members = v69
                });
            end;
        end;
    end);
    Players.PlayerRemoving:Connect(function(p70) -- Line: 538
        -- upvalues: u6 (ref), u3 (ref)
        if u6[p70.UserId] then
            local UserId = p70.UserId;
            local v71 = u6[UserId];

            if v71 then
                for _, v in v71.connections do
                    v:Disconnect();
                end;

                v71.card:Destroy();
                u6[UserId] = nil;
            end;

            u3.Visible = next(u6) ~= nil;
        end;
    end);
end;

return v1;