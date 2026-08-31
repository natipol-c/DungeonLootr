--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     HealthbarController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.HealthbarController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local GearScoreData = require(ReplicatedStorage.GameInfo.GearScoreData);
local Player_Healthbar = ReplicatedStorage.Assets.UI.Player_Healthbar;
local u1 = { "Below", "Above", "Hidden" };
local u2 = {
    Below = Vector3.new(0, -4.5, 0),
    Above = Vector3.new(0, 3.5, 0)
};
local v3 = Knit.CreateController({
    Name = "HealthbarController"
});
local _ = Players.LocalPlayer;
local u4 = {};
local u5 = {};
local u6 = 1;
local u7 = nil;

local function GetCurrentMode() -- Line: 88
    -- upvalues: u1 (copy), u6 (ref)
    return u1[u6];
end;

local function FormatHealth(p8: number, p9: number) -- Line: 92
    local math_max_ret = math.max(p8, 0);

    return `{math.floor(math_max_ret)}/{math.floor(p9)}`;
end;

local function FormatGearScore(p10: number) -- Line: 98
    -- upvalues: GearScoreData (copy)
    return GearScoreData.FormatCommas(p10);
end;

local function ApplyGearScoreGradient(p11: userdata, p12: number) -- Line: 104
    -- upvalues: GearScoreData (copy)
    GearScoreData.ApplyBracketGradient(p11, p12);
end;

local function GetPlayerFromCharacter(p13: userdata) -- Line: 109
    -- upvalues: Players (copy)
    for _, v in Players:GetPlayers() do
        if v.Character == p13 then
            return v;
        end;
    end;

    return nil;
end;

local function ApplyMode(p14) -- Line: 119
    -- upvalues: u1 (copy), u6 (ref), u2 (copy)
    local v15 = u1[u6];

    if v15 == "Hidden" then
        p14.gui.Enabled = false;

        return;
    end;

    p14.gui.Enabled = true;
    p14.gui.StudsOffsetWorldSpace = u2[v15];
end;

local function ApplyModeToAll() -- Line: 130
    -- upvalues: u4 (copy), u1 (copy), u6 (ref), u2 (copy)
    for _, v in u4 do
        local v16 = u1[u6];

        if v16 == "Hidden" then
            v.gui.Enabled = false;
        else
            v.gui.Enabled = true;
            v.gui.StudsOffsetWorldSpace = u2[v16];
        end;
    end;
end;

local function UpdateHealthVisual(p17: any, p18: number, p19: number) -- Line: 137
    local v20 = p18 / math.max(p19, 1);
    local math_clamp_ret = math.clamp(v20, 0, 1);

    if p17.overlay then
        p17.overlay.Size = UDim2.fromScale(math_clamp_ret, 1);
    end;

    if p17.label then
        local label = p17.label;
        local math_max_ret = math.max(p18, 0);
        label.Text = `{math.floor(math_max_ret)}/{math.floor(p19)}`;
    end;

    local os_clock_ret = os.clock();
    p17.lastDamageTime = os_clock_ret;

    if not p17.trailDirty then
        p17.firstDamageTime = os_clock_ret;
    end;

    p17.trailDirty = true;
end;

local function CleanupHealthbar(p21: userdata) -- Line: 162
    -- upvalues: u4 (copy)
    local v22 = u4[p21];

    if not v22 then
        return;
    end;

    for _, v in v22.connections do
        v:Disconnect();
    end;

    if v22.gui and v22.gui.Parent then
        v22.gui:Destroy();
    end;

    u4[p21] = nil;
end;

local function SetupHealthbar(p23: userdata, u24: userdata, p25: userdata) -- Line: 181
    -- upvalues: u4 (copy), Player_Healthbar (copy), CollectionService (copy), u1 (copy), u6 (ref), u2 (copy), UpdateHealthVisual (copy), Players (copy), GearScoreData (copy)
    if u4[p23] then
        return;
    end;

    local v26 = Player_Healthbar:Clone();
    v26.Name = "Player_Healthbar";
    local v27 = v26:FindFirstChild("Health") or v26;
    local Overlay = v27:FindFirstChild("Overlay");
    local Trail = v27:FindFirstChild("Trail");
    local Health_Amount = v27:FindFirstChild("Health_Amount");
    v26:FindFirstChild("NameText").Text = p23.Name;
    local LevelText = v26:FindFirstChild("LevelText");

    if not LevelText then
        LevelText = Instance.new("TextLabel");
        LevelText.Name = "LevelText";
        LevelText.BackgroundTransparency = 1;
        LevelText.Size = UDim2.new(0.3, 0, 0.15, 0);
        LevelText.Position = UDim2.new(0, 0, 0, 0);
        LevelText.Font = Enum.Font.GothamBold;
        LevelText.TextColor3 = Color3.fromRGB(255, 255, 255);
        LevelText.TextStrokeTransparency = 0.5;
        LevelText.TextScaled = true;
        LevelText.Text = "Lvl. 1";
        LevelText.Parent = v26;
    end;

    local Gear_Score_Frame = v26:FindFirstChild("Gear_Score_Frame");

    if not Gear_Score_Frame then
        Gear_Score_Frame = Instance.new("Frame");
        Gear_Score_Frame.Name = "Gear_Score_Frame";
        Gear_Score_Frame.BackgroundTransparency = 1;
        Gear_Score_Frame.Size = UDim2.new(1, 0, 0.15, 0);
        Gear_Score_Frame.Position = UDim2.new(0, 0, 0.85, 0);
        Gear_Score_Frame.Parent = v26;
    end;

    local GearScore = Gear_Score_Frame:FindFirstChild("GearScore");

    if not GearScore then
        GearScore = Instance.new("TextLabel");
        GearScore.Name = "GearScore";
        GearScore.BackgroundTransparency = 1;
        GearScore.Size = UDim2.fromScale(1, 1);
        GearScore.Position = UDim2.fromScale(0, 0);
        GearScore.Font = Enum.Font.GothamBold;
        GearScore.TextColor3 = Color3.fromRGB(255, 255, 255);
        GearScore.TextStrokeTransparency = 0.5;
        GearScore.TextScaled = true;
        GearScore.Text = "0";
        GearScore.Parent = Gear_Score_Frame;
    end;

    CollectionService:AddTag(v26, "Player_Healthbar");
    v26.Adornee = p25;
    v26.Parent = p25;
    local u28 = {
        lastDamageTime = 0,
        firstDamageTime = 0,
        trailDirty = false,
        gui = v26,
        overlay = Overlay,
        trail = Trail,
        label = Health_Amount,
        levelText = LevelText,
        gearScoreLabel = GearScore,
        connections = {}
    };
    u4[p23] = u28;
    local v29 = u1[u6];

    if v29 == "Hidden" then
        u28.gui.Enabled = false;
    else
        u28.gui.Enabled = true;
        u28.gui.StudsOffsetWorldSpace = u2[v29];
    end;

    if Trail then
        Trail.Size = UDim2.fromScale(1, 1);
    end;

    UpdateHealthVisual(u28, u24.Health, u24.MaxHealth);
    u28.trailDirty = false;

    if Trail then
        Trail.Size = u28.overlay and u28.overlay.Size or UDim2.fromScale(1, 1);
    end;

    local u30 = nil;

    for _, v in Players:GetPlayers() do
        if v.Character == p23 then
            u30 = v;
            break;
        end;
    end;

    if u30 then
        LevelText.Text = `Lvl. {u30:GetAttribute("PlayerLevel") or 1}`;
        local v31 = u30:GetAttribute("Stat_GearScore") or 0;
        GearScore.Text = GearScoreData.FormatCommas(v31);
        GearScoreData.ApplyBracketGradient(GearScore, v31);
    end;

    table.insert(u28.connections, u24.HealthChanged:Connect(function(p32) -- Line: 291
        -- upvalues: UpdateHealthVisual (ref), u28 (copy), u24 (copy)
        UpdateHealthVisual(u28, p32, u24.MaxHealth);
    end));
    local connections = u28.connections;
    local PropertyChangedSignal = u24:GetPropertyChangedSignal("MaxHealth");
    table.insert(connections, PropertyChangedSignal:Connect(function() -- Line: 296
        -- upvalues: UpdateHealthVisual (ref), u28 (copy), u24 (copy)
        UpdateHealthVisual(u28, u24.Health, u24.MaxHealth);
    end));

    if u30 then
        local connections2 = u28.connections;
        local AttributeChangedSignal = u30:GetAttributeChangedSignal("PlayerLevel");
        table.insert(connections2, AttributeChangedSignal:Connect(function() -- Line: 302
            -- upvalues: u30 (copy), LevelText (ref)
            LevelText.Text = `Lvl. {u30:GetAttribute("PlayerLevel") or 1}`;
        end));
        local connections3 = u28.connections;
        local AttributeChangedSignal2 = u30:GetAttributeChangedSignal("Stat_GearScore");
        table.insert(connections3, AttributeChangedSignal2:Connect(function() -- Line: 308
            -- upvalues: u30 (copy), GearScore (ref), GearScoreData (ref)
            local v33 = u30:GetAttribute("Stat_GearScore") or 0;
            GearScore.Text = GearScoreData.FormatCommas(v33);
            GearScoreData.ApplyBracketGradient(GearScore, v33);
        end));
    end;
end;

local function UntrackCharacter(p34: userdata) -- Line: 321
    -- upvalues: CleanupHealthbar (copy), u5 (copy)
    CleanupHealthbar(p34);
    local v35 = u5[p34];

    if v35 then
        for _, v in v35.conns do
            v:Disconnect();
        end;

        u5[p34] = nil;
    end;
end;

local function TrackCharacter(u36: userdata) -- Line: 337
    -- upvalues: u5 (copy), u4 (copy), SetupHealthbar (copy), CleanupHealthbar (copy)
    if u5[u36] then
        return;
    end;

    local v37 = {
        conns = {}
    };
    u5[u36] = v37;

    local function tryBuild() -- Line: 344
        -- upvalues: u4 (ref), u36 (copy), SetupHealthbar (ref)
        if u4[u36] then
            return;
        end;

        local v38 = u36:FindFirstChildOfClass("Humanoid");
        local HumanoidRootPart = u36:FindFirstChild("HumanoidRootPart");

        if v38 and HumanoidRootPart then
            SetupHealthbar(u36, v38, HumanoidRootPart);
        end;
    end;

    table.insert(v37.conns, u36.ChildAdded:Connect(function(p39) -- Line: 355
        -- upvalues: u4 (ref), u36 (copy), SetupHealthbar (ref)
        if p39.Name == "HumanoidRootPart" or p39:IsA("Humanoid") then
            if u4[u36] then
                return;
            end;

            local v40 = u36:FindFirstChildOfClass("Humanoid");
            local HumanoidRootPart = u36:FindFirstChild("HumanoidRootPart");

            if v40 and HumanoidRootPart then
                SetupHealthbar(u36, v40, HumanoidRootPart);
            end;
        end;
    end));
    table.insert(v37.conns, u36.ChildRemoved:Connect(function(p41) -- Line: 364
        -- upvalues: u4 (ref), u36 (copy), CleanupHealthbar (ref)
        if p41.Name == "HumanoidRootPart" and u4[u36] then
            CleanupHealthbar(u36);
        end;
    end));
    table.insert(v37.conns, u36.AncestryChanged:Connect(function(p42, p43) -- Line: 373
        -- upvalues: u36 (copy), CleanupHealthbar (ref), u5 (ref)
        if not p43 then
            local v44 = u36;
            CleanupHealthbar(v44);
            local v45 = u5[v44];

            if v45 then
                for _, v in v45.conns do
                    v:Disconnect();
                end;

                u5[v44] = nil;
            end;
        end;
    end));

    if u4[u36] then
        return;
    end;

    local v46 = u36:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = u36:FindFirstChild("HumanoidRootPart");

    if v46 and HumanoidRootPart then
        SetupHealthbar(u36, v46, HumanoidRootPart);
    end;
end;

local function StartTrailHeartbeat() -- Line: 386
    -- upvalues: u7 (ref), RunService (copy), u4 (copy), TweenService (copy)
    if u7 then
        return;
    end;

    u7 = RunService.Heartbeat:Connect(function() -- Line: 389
        -- upvalues: u4 (ref), TweenService (ref)
        local os_clock_ret = os.clock();

        for _, v in u4 do
            if v.trailDirty and (v.trail and (v.overlay and v.gui.Enabled)) and (os_clock_ret - v.lastDamageTime >= 0.8 or os_clock_ret - v.firstDamageTime >= 2) then
                TweenService:Create(v.trail, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = v.overlay.Size
                }):Play();
                v.trailDirty = false;
            end;
        end;
    end);
end;

local function WatchPlayer(p47: userdata) -- Line: 417
    -- upvalues: TrackCharacter (copy)
    if p47.Character then
        TrackCharacter(p47.Character);
    end;

    p47.CharacterAdded:Connect(TrackCharacter);
end;

function v3.GetMode(p48) -- Line: 429
    -- upvalues: u1 (copy), u6 (ref)
    return u1[u6];
end;

function v3.GetModeIndex(p49) -- Line: 434
    -- upvalues: u6 (ref)
    return u6;
end;

function v3.CycleMode(p50) -- Line: 439
    -- upvalues: u6 (ref), u1 (copy), u4 (copy), u2 (copy), Knit (copy)
    u6 = u6 % #u1 + 1;

    for _, v in u4 do
        local v51 = u1[u6];

        if v51 == "Hidden" then
            v.gui.Enabled = false;
        else
            v.gui.Enabled = true;
            v.gui.StudsOffsetWorldSpace = u2[v51];
        end;
    end;

    task.spawn(function() -- Line: 444
        -- upvalues: Knit (ref), u1 (ref), u6 (ref)
        local success, result = pcall(function() -- Line: 445
            -- upvalues: Knit (ref), u1 (ref), u6 (ref)
            Knit.GetService("SettingsService"):SetSetting("HealthbarMode", u1[u6]);
        end);

        if not success then
            warn("[HealthbarController] Failed to persist HealthbarMode:", result);
        end;
    end);

    return u1[u6];
end;

function v3.SetMode(p52: table, p53: string) -- Line: 458
    -- upvalues: u1 (copy), u6 (ref), u4 (copy), u2 (copy)
    local table_find_ret = table.find(u1, p53);

    if not table_find_ret then
        warn((`[HealthbarController] Invalid mode: "{p53}"`));

        return;
    end;

    u6 = table_find_ret;

    for _, v in u4 do
        local v54 = u1[u6];

        if v54 == "Hidden" then
            v.gui.Enabled = false;
        else
            v.gui.Enabled = true;
            v.gui.StudsOffsetWorldSpace = u2[v54];
        end;
    end;
end;

function v3.RefreshPlayer(p55: table, p56: userdata) -- Line: 469
    -- upvalues: CleanupHealthbar (copy), u5 (copy), TrackCharacter (copy)
    if p56.Character then
        local Character = p56.Character;
        CleanupHealthbar(Character);
        local v57 = u5[Character];

        if v57 then
            for _, v in v57.conns do
                v:Disconnect();
            end;

            u5[Character] = nil;
        end;

        TrackCharacter(p56.Character);
    end;
end;

function v3.KnitInit(p58) -- Line: 478
end;

function v3.KnitStart(p59) -- Line: 482
    -- upvalues: Knit (copy), u1 (copy), u6 (ref), u4 (copy), u2 (copy), u7 (ref), RunService (copy), TweenService (copy), Players (copy), TrackCharacter (copy), WatchPlayer (copy), CleanupHealthbar (copy), u5 (copy)
    local success, result = pcall(function() -- Line: 484
        -- upvalues: Knit (ref)
        return Knit.GetService("SettingsService"):GetSettings():expect();
    end);
    local v60 = success and (result and (result.HealthbarMode and table.find(u1, result.HealthbarMode)));

    if v60 then
        u6 = v60;
    end;

    pcall(function() -- Line: 497
        -- upvalues: Knit (ref), u1 (ref), u6 (ref), u4 (ref), u2 (ref)
        Knit.GetService("SettingsService").SettingChanged:Connect(function(p61, p62) -- Line: 499
            -- upvalues: u1 (ref), u6 (ref), u4 (ref), u2 (ref)
            local v63 = p61 == "HealthbarMode" and table.find(u1, p62);

            if v63 then
                u6 = v63;

                for _, v in u4 do
                    local v64 = u1[u6];

                    if v64 == "Hidden" then
                        v.gui.Enabled = false;
                    else
                        v.gui.Enabled = true;
                        v.gui.StudsOffsetWorldSpace = u2[v64];
                    end;
                end;
            end;
        end);
    end);

    if not u7 then
        u7 = RunService.Heartbeat:Connect(function() -- Line: 389
            -- upvalues: u4 (ref), TweenService (ref)
            local os_clock_ret = os.clock();

            for _, v in u4 do
                if v.trailDirty and (v.trail and (v.overlay and v.gui.Enabled)) and (os_clock_ret - v.lastDamageTime >= 0.8 or os_clock_ret - v.firstDamageTime >= 2) then
                    TweenService:Create(v.trail, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = v.overlay.Size
                    }):Play();
                    v.trailDirty = false;
                end;
            end;
        end);
    end;

    for _, v in Players:GetPlayers() do
        if v.Character then
            TrackCharacter(v.Character);
        end;

        v.CharacterAdded:Connect(TrackCharacter);
    end;

    Players.PlayerAdded:Connect(WatchPlayer);
    Players.PlayerRemoving:Connect(function(p65) -- Line: 521
        -- upvalues: CleanupHealthbar (ref), u5 (ref)
        if p65.Character then
            local Character = p65.Character;
            CleanupHealthbar(Character);
            local v66 = u5[Character];

            if v66 then
                for _, v in v66.conns do
                    v:Disconnect();
                end;

                u5[Character] = nil;
            end;
        end;
    end);
end;

return v3;