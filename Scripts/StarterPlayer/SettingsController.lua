--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SettingsController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.SettingsController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local GuiService = game:GetService("GuiService");
local Packages = ReplicatedStorage:WaitForChild("Packages");
local Knit = require(Packages.Knit);
local MobileLayoutData = require(ReplicatedStorage:WaitForChild("GameInfo"):WaitForChild("MobileLayoutData"));
local LocalPlayer = Players.LocalPlayer;
local u1 = {
    AutoSprint = "AutoSprint",
    Hitbox = "ShowHitbox",
    WeaponCosmetic = "HideWeaponCosmetic",
    PartyInvites = "BlockPartyInvites",
    MobileButtons = "HideMobileButtons",
    PlayerAccessories = "HidePlayerAccessories",
    MotionEffects = "ReduceMotion",
    SprintZoom = "DisableSprintZoom",
    AutoShiftLock = "AutoShiftLock",
    ReduceOtherVFX = "HideOtherVFX",
    ReduceSelfVFX = "HideSelfVFX",
    EmoteSounds = "DisableEmoteSounds",
    EmoteWeapon = "EmoteWeapon",
    DoF = "DisableDepth",
    Bloom = "DisableBloom",
    SunRays = "DisableSunrays",
    GlobalShadows = "DisableShadows",
    ZoneClear = "DisableZoneClearSound",
    AreaWarp = "DisableAreaWarp",
    HideUI = "HideUI",
    DamageNumber = "PopFallNumbers",
    LobbyNight = "LobbyNight"
};
local u2 = {
    MusicVolume = "MusicVolume",
    SFXVolume = "SFXVolume",
    EmoteVolume = "EmoteVolume"
};
local u3 = { "Below", "Above", "Hidden" };
local u4 = { "General", "Performance", "Audio", "Gameplay", "Control" };
local u5 = {
    AutoSprint = false,
    ShowHitbox = false,
    HideWeaponCosmetic = false,
    BlockPartyInvites = false,
    HideMobileButtons = false,
    ReduceMotion = false,
    DisableSprintZoom = true,
    HideOtherVFX = false,
    HideSelfVFX = false,
    DisableEmoteSounds = false,
    EmoteWeapon = false,
    DisableDepth = false,
    DisableBloom = false,
    DisableSunrays = false,
    DisableShadows = false,
    DisableZoneClearSound = false,
    HidePlayerAccessories = false,
    AutoShiftLock = true,
    DisableAreaWarp = false,
    HideUI = false,
    PopFallNumbers = false,
    LobbyNight = false,
    MusicVolume = 50,
    SFXVolume = 50,
    EmoteVolume = 50,
    HealthbarMode = "Below"
};
local Color3_fromRGB_ret = Color3.fromRGB(133, 106, 57);
local Color3_fromRGB_ret2 = Color3.fromRGB(110, 110, 110);
local TweenInfo_new_ret = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local Color3_fromRGB_ret3 = Color3.fromRGB(219, 169, 73);
local Color3_fromRGB_ret4 = Color3.fromRGB(174, 177, 181);
local TweenInfo_new_ret2 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local ACTION_BUTTONS = MobileLayoutData.ACTION_BUTTONS;
local DEFAULT_LAYOUT = MobileLayoutData.DEFAULT_LAYOUT;
local MIN_SCALE = MobileLayoutData.MIN_SCALE;
local MAX_SCALE = MobileLayoutData.MAX_SCALE;
local SCALE_STEP = MobileLayoutData.SCALE_STEP;
local v6 = Knit.CreateController({
    Name = "SettingsController",
    _settingsFrame = nil,
    _uiController = nil,
    _assetsFrame = nil,
    _initialized = false,
    _healthbarDropdown = nil,
    _healthbarHolder = nil,
    _healthbarTemplate = nil,
    _dropdownConn = nil,
    _editMode = false,
    _mobileActionsFrame = nil,
    _saveChangesFrame = nil,
    _cancelChangesFrame = nil,
    _defaultChangesFrame = nil,
    _noticeFrame = nil,
    _resizeActiveFrame = nil,
    _resizeToggleButton = nil,
    _resizeEnabledGradient = nil,
    _resizeDisabledGradient = nil,
    _resizeStatusLabel = nil,
    _pvpStatusFrame = nil,
    _potatoActive = false,
    _settingsCache = {},
    _uiElements = {},
    _categoryButtons = {},
    _sliders = {},
    _healthbarOptionButtons = {},
    _dragConnections = {},
    _pendingPositions = {},
    _savedPositions = {},
    _baseButtonSizes = {}
});

local function ApplyCheckboxVisual(p7: userdata, p8: boolean, p9: boolean?) -- Line: 167
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), TweenService (copy), TweenInfo_new_ret (copy)
    local CheckBox = p7:FindFirstChild("CheckBox");

    if not CheckBox then
        return;
    end;

    local Check = CheckBox:FindFirstChild("Check");

    if not Check then
        return;
    end;

    local v10 = p8 and Check:GetAttribute("On") or Check:GetAttribute("Off");
    local v11 = p8 and Color3_fromRGB_ret or Color3_fromRGB_ret2;

    if p9 then
        if v10 then
            Check.Position = v10;
        end;

        Check.BackgroundColor3 = v11;

        return;
    end;

    local v12 = {
        BackgroundColor3 = v11
    };

    if v10 then
        v12.Position = v10;
    end;

    TweenService:Create(Check, TweenInfo_new_ret, v12):Play();
end;

local function ApplyTabVisual(p13: userdata, p14: boolean) -- Line: 187
    -- upvalues: Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy), TweenService (copy), TweenInfo_new_ret2 (copy)
    local v15 = p14 and Color3_fromRGB_ret3 or Color3_fromRGB_ret4;
    local Icon = p13:FindFirstChild("Icon");

    if Icon and Icon:IsA("ImageLabel") then
        TweenService:Create(Icon, TweenInfo_new_ret2, {
            ImageColor3 = v15
        }):Play();
    end;

    local Text = p13:FindFirstChild("Text");

    if Text and Text:IsA("TextLabel") then
        TweenService:Create(Text, TweenInfo_new_ret2, {
            TextColor3 = v15
        }):Play();
    end;
end;

local Color3_fromRGB_ret5 = Color3.fromRGB(80, 255, 80);
local Color3_fromRGB_ret6 = Color3.fromRGB(255, 80, 80);

local function ApplyHitboxVisual(p16) -- Line: 203
    -- upvalues: Players (copy), Color3_fromRGB_ret5 (copy)
    local Character = Players.LocalPlayer.Character;

    if not Character then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local Hitbox = HumanoidRootPart:FindFirstChild("Hitbox");

    if not Hitbox then
        return;
    end;

    if not p16 then
        Hitbox.Transparency = 1;

        return;
    end;

    Hitbox.Transparency = 0.5;
    Hitbox.Color = Color3_fromRGB_ret5;
    Hitbox.Material = Enum.Material.ForceField;
    Hitbox.CastShadow = false;
end;

local function FlashHitbox() -- Line: 221
    -- upvalues: Players (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret5 (copy)
    local Character = Players.LocalPlayer.Character;

    if not Character then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local Hitbox = HumanoidRootPart:FindFirstChild("Hitbox");

    if not Hitbox then
        return;
    end;

    Hitbox.Color = Color3_fromRGB_ret6;
    task.delay(0.25, function() -- Line: 230
        -- upvalues: Hitbox (copy), Color3_fromRGB_ret5 (ref)
        if Hitbox and Hitbox.Parent then
            Hitbox.Color = Color3_fromRGB_ret5;
        end;
    end);
end;

local function SetLightingEffectEnabled(p17: string, p18: boolean) -- Line: 238
    for _, descendant in ipairs(game:GetService("Lighting"):GetDescendants()) do
        if descendant:IsA(p17) then
            descendant.Enabled = p18;
        end;
    end;
end;

local function ApplyPotato() -- Line: 246
    for _, descendant in ipairs(workspace:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Material = Enum.Material.SmoothPlastic;

            if descendant:IsA("MeshPart") then
                descendant.TextureID = "";
            end;
        end;
    end;
end;

local function IsWithin(p19: userdata, p20: vector) -- Line: 263
    if not (p19 and p19.Parent) then
        return false;
    end;

    local AbsolutePosition = p19.AbsolutePosition;
    local AbsoluteSize = p19.AbsoluteSize;
    local v21;

    if p20.X >= AbsolutePosition.X and (p20.X <= AbsolutePosition.X + AbsoluteSize.X and p20.Y >= AbsolutePosition.Y) then
        v21 = p20.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
    else
        v21 = false;
    end;

    return v21;
end;

function v6._applyDamageNumberSetting(p22: table, p23: boolean) -- Line: 274
    -- upvalues: LocalPlayer (copy)
    LocalPlayer:SetAttribute("DamageNumberAnimation", p23 and "PopAndFall" or "FloatAndLinger");
end;

function v6._applyHitboxSetting(p24: table, p25: boolean) -- Line: 278
    -- upvalues: ApplyHitboxVisual (copy), LocalPlayer (copy), Players (copy), Color3_fromRGB_ret5 (copy)
    ApplyHitboxVisual(p25);
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    if p24._hitboxWatcher then
        p24._hitboxWatcher:Disconnect();
        p24._hitboxWatcher = nil;
    end;

    if p25 then
        p24._hitboxWatcher = HumanoidRootPart.ChildAdded:Connect(function(p26) -- Line: 292
            -- upvalues: Players (ref), Color3_fromRGB_ret5 (ref)
            if p26.Name == "Hitbox" then
                local Character2 = Players.LocalPlayer.Character;

                if not Character2 then
                    return;
                end;

                local HumanoidRootPart2 = Character2:FindFirstChild("HumanoidRootPart");

                if not HumanoidRootPart2 then
                    return;
                end;

                local Hitbox = HumanoidRootPart2:FindFirstChild("Hitbox");

                if not Hitbox then
                    return;
                end;

                Hitbox.Transparency = 0.5;
                Hitbox.Color = Color3_fromRGB_ret5;
                Hitbox.Material = Enum.Material.ForceField;
                Hitbox.CastShadow = false;
            end;
        end);
    end;
end;

function v6.IsEnabled(p27: table, p28: string) -- Line: 302
    return p27._settingsCache[p28] == true;
end;

function v6.GetSettings(p29) -- Line: 306
    return table.clone(p29._settingsCache);
end;

function v6.GetVolume(p30: table, p31: string) -- Line: 311
    local v32 = p30._settingsCache[p31];

    return type(v32) == "number" and v32 and v32 or 50;
end;

function v6.ShouldReduceMotion(p33) -- Line: 316
    return p33:IsEnabled("ReduceMotion");
end;

function v6.ShouldSkipChestSpin(p34) -- Line: 320
    return p34:IsEnabled("SkipChestSpin");
end;

function v6.ShouldHideOtherVFX(p35) -- Line: 324
    return p35:IsEnabled("HideOtherVFX");
end;

function v6.ShouldHideSelfVFX(p36) -- Line: 328
    return p36:IsEnabled("HideSelfVFX");
end;

function v6.ShouldDisableEmoteSounds(p37) -- Line: 334
    return p37:IsEnabled("DisableEmoteSounds");
end;

function v6.IsPVPEnabled(p38) -- Line: 338
    return p38:IsEnabled("PVPEnabled");
end;

function v6.IsEditMode(p39) -- Line: 342
    return p39._editMode;
end;

function v6.OpenSettings(p40) -- Line: 347
    if p40._uiController then
        p40._uiController:open();
    end;
end;

function v6.CloseSettings(p41) -- Line: 351
    if p41._uiController then
        p41._uiController:close();
    end;
end;

function v6.ToggleSettings(p42) -- Line: 355
    if p42._uiController then
        p42._uiController:toggle();
    end;
end;

function v6.IsOpen(p43) -- Line: 359
    if p43._uiController then
        return p43._uiController.isOpen;
    end;

    return false;
end;

function v6._applyMobileButtonsVisibility(p44) -- Line: 379
    -- upvalues: UserInputService (copy)
    if not p44._mobileActionsFrame then
        return;
    end;

    if p44._editMode then
        p44._mobileActionsFrame.Visible = true;

        return;
    end;

    p44._mobileActionsFrame.Visible = UserInputService.TouchEnabled and not (p44._settingsCache.HideMobileButtons == true);
end;

function v6._getBaseButtonSize(p45: table, p46: userdata) -- Line: 393
    local v47 = p45._baseButtonSizes[p46.Name];

    if not v47 then
        v47 = p46.Size;
        p45._baseButtonSizes[p46.Name] = v47;
    end;

    return v47;
end;

function v6._getButtonScale(p48: table, p49: userdata) -- Line: 403
    local v50 = p48:_getBaseButtonSize(p49);

    return v50.X.Scale == 0 and 1 or p49.Size.X.Scale / v50.X.Scale;
end;

function v6._applyButtonScale(p51: table, p52: userdata, p53: number) -- Line: 411
    -- upvalues: MIN_SCALE (copy), MAX_SCALE (copy)
    local math_clamp_ret = math.clamp(p53, MIN_SCALE, MAX_SCALE);
    local v54 = p51:_getBaseButtonSize(p52);
    p52.Size = UDim2.new(v54.X.Scale * math_clamp_ret, v54.X.Offset * math_clamp_ret, v54.Y.Scale * math_clamp_ret, v54.Y.Offset * math_clamp_ret);
end;

function v6._setResizeModeVisual(p55: table, p56: boolean) -- Line: 423
    if p55._resizeEnabledGradient then
        p55._resizeEnabledGradient.Enabled = p56;
    end;

    if p55._resizeDisabledGradient then
        p55._resizeDisabledGradient.Enabled = not p56;
    end;

    if p55._resizeStatusLabel then
        p55._resizeStatusLabel.Text = p56 and "Resizing Mode: ON" or "Resizing Mode: OFF";
    end;
end;

function v6._loadMobileLayout(p57) -- Line: 431
    -- upvalues: ACTION_BUTTONS (copy)
    if not p57._mobileActionsFrame then
        return;
    end;

    local v58 = require(script.Parent.Registry):Get("PlayerData");

    if not v58 then
        return;
    end;

    local MobileButtonLayout = v58.Data.MobileButtonLayout;

    if not MobileButtonLayout then
        return;
    end;

    for _, v in ipairs(ACTION_BUTTONS) do
        local v59 = p57._mobileActionsFrame:FindFirstChild(v);
        local v60 = MobileButtonLayout[v];

        if v59 and (v60 and (v60.X and v60.Y)) then
            v59.Position = UDim2.fromScale(v60.X, v60.Y);
            p57:_applyButtonScale(v59, v60.Scale or 1);
        end;
    end;
end;

function v6.EnterEditMode(p61) -- Line: 452
    -- upvalues: ACTION_BUTTONS (copy), Knit (copy)
    if p61._editMode then
        return;
    end;

    if not p61._mobileActionsFrame then
        warn("[SettingsController] MobileActions frame not found, cannot enter edit mode");

        return;
    end;

    p61._editMode = true;
    p61:_applyMobileButtonsVisibility();
    p61:CloseSettings();

    if p61._saveChangesFrame then
        p61._saveChangesFrame.Visible = true;
    end;

    if p61._cancelChangesFrame then
        p61._cancelChangesFrame.Visible = true;
    end;

    if p61._defaultChangesFrame then
        p61._defaultChangesFrame.Visible = true;
    end;

    if p61._noticeFrame then
        p61._noticeFrame.Visible = true;
    end;

    if p61._resizeActiveFrame then
        p61._resizeActiveFrame.Visible = true;
    end;

    p61:_setResizeModeVisual(false);
    p61._pendingPositions = {};
    p61._savedPositions = {};

    for _, v in ipairs(ACTION_BUTTONS) do
        local v62 = p61._mobileActionsFrame:FindFirstChild(v);

        if v62 then
            local v63 = {
                X = v62.Position.X.Scale,
                Y = v62.Position.Y.Scale,
                Scale = p61:_getButtonScale(v62)
            };
            p61._pendingPositions[v] = v63;
            p61._savedPositions[v] = {
                X = v63.X,
                Y = v63.Y,
                Scale = v63.Scale
            };
        end;
    end;

    p61:_setupDragHandlers();
    local Controller = Knit.GetController("SoundController");

    if Controller then
        Controller:Play("Click");
    end;
end;

function v6.ExitEditMode(p64: table, p65: boolean) -- Line: 491
    -- upvalues: Knit (copy), ACTION_BUTTONS (copy)
    if not p64._editMode then
        return;
    end;

    p64._editMode = false;
    p64:_applyMobileButtonsVisibility();
    p64:_cleanupDragHandlers();

    if p64._saveChangesFrame then
        p64._saveChangesFrame.Visible = false;
    end;

    if p64._cancelChangesFrame then
        p64._cancelChangesFrame.Visible = false;
    end;

    if p64._defaultChangesFrame then
        p64._defaultChangesFrame.Visible = false;
    end;

    if p64._noticeFrame then
        p64._noticeFrame.Visible = false;
    end;

    if p64._resizeActiveFrame then
        p64._resizeActiveFrame.Visible = false;
    end;

    p64:_setResizeModeVisual(false);

    if p65 then
        Knit.GetService("DataService"):SaveMobileLayout(p64._pendingPositions);
        local Controller = Knit.GetController("NotificationController");

        if Controller then
            Controller:Show("Custom", "Mobile layout saved!", 3, Color3.new(0.298039, 1, 0.235294), Color3.new(0.258823, 0.513725, 0.160784), "Ting");
        end;
    elseif p64._mobileActionsFrame then
        for _, v in ipairs(ACTION_BUTTONS) do
            local v66 = p64._mobileActionsFrame:FindFirstChild(v);
            local v67 = p64._savedPositions[v];

            if v66 and v67 then
                v66.Position = UDim2.fromScale(v67.X, v67.Y);
                p64:_applyButtonScale(v66, v67.Scale or 1);
            end;
        end;
    end;

    p64._pendingPositions = {};
    p64._savedPositions = {};
    local Controller = Knit.GetController("SoundController");

    if Controller then
        Controller:Play("Click");
    end;
end;

function v6.ResetToDefaultLayout(p68) -- Line: 539
    -- upvalues: ACTION_BUTTONS (copy), DEFAULT_LAYOUT (copy)
    if not p68._mobileActionsFrame then
        return;
    end;

    for _, v in ipairs(ACTION_BUTTONS) do
        local v69 = p68._mobileActionsFrame:FindFirstChild(v);
        local v70 = DEFAULT_LAYOUT[v];

        if v69 and v70 then
            v69.Position = UDim2.fromScale(v70.X, v70.Y);
            p68:_applyButtonScale(v69, v70.Scale or 1);
            p68._pendingPositions[v] = {
                X = v70.X,
                Y = v70.Y,
                Scale = v70.Scale or 1
            };
        end;
    end;
end;

function v6._setupDragHandlers(u71) -- Line: 554
    -- upvalues: GuiService (copy), SCALE_STEP (copy), MIN_SCALE (copy), MAX_SCALE (copy), ACTION_BUTTONS (copy), UserInputService (copy)
    u71:_cleanupDragHandlers();
    local u72 = nil;
    local Vector2_zero = Vector2.zero;
    local u73 = nil;
    local u74 = false;
    local u75 = false;
    local u76 = 0;
    local u77 = 1;
    local u78 = 0;
    local u79 = nil;
    local GuiInset = GuiService:GetGuiInset();

    local function snapScale(p80) -- Line: 575
        -- upvalues: SCALE_STEP (ref), MIN_SCALE (ref), MAX_SCALE (ref)
        local v81 = math.floor(p80 / SCALE_STEP + 0.5) * SCALE_STEP;

        return math.clamp(v81, MIN_SCALE, MAX_SCALE);
    end;

    local function commitPending(p82) -- Line: 580
        -- upvalues: u71 (copy)
        u71._pendingPositions[p82.Name] = {
            X = p82.Position.X.Scale,
            Y = p82.Position.Y.Scale,
            Scale = u71:_getButtonScale(p82)
        };
    end;

    local function setResizing(p83) -- Line: 591
        -- upvalues: u75 (ref), u71 (copy), u74 (ref)
        u75 = p83;
        u71:_setResizeModeVisual(p83 or u74);
    end;

    if u71._resizeToggleButton then
        local v84 = u71._resizeToggleButton.Activated:Connect(function() -- Line: 599
            -- upvalues: u74 (ref), u71 (copy), u75 (ref)
            u74 = not u74;
            u71:_setResizeModeVisual(u74 or u75);
        end);
        table.insert(u71._dragConnections, v84);
    end;

    for _, v in ipairs(ACTION_BUTTONS) do
        local u85 = u71._mobileActionsFrame:FindFirstChild(v);

        if u85 then
            local v89 = u85.InputBegan:Connect(function(p86) -- Line: 610
                -- upvalues: u72 (ref), u79 (ref), u85 (copy), u78 (ref), u73 (ref), u74 (ref), u76 (ref), u77 (ref), u71 (copy), u75 (ref), GuiInset (copy), Vector2_zero (ref)
                if u72 then
                    return;
                end;

                if p86.UserInputType ~= Enum.UserInputType.Touch and p86.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    return;
                end;

                local os_clock_ret = os.clock();
                local v87;

                if u79 == u85 then
                    v87 = os_clock_ret - u78 <= 0.45;
                else
                    v87 = false;
                end;

                u78 = os_clock_ret;
                u79 = u85;
                u72 = u85;
                u73 = p86;

                if not (u74 or v87) then
                    local v88 = u85.AbsolutePosition + u85.AbsoluteSize / 2 + GuiInset;
                    Vector2_zero = Vector2.new(p86.Position.X - v88.X, p86.Position.Y - v88.Y);

                    return;
                end;

                u78 = 0;
                u76 = p86.Position.Y;
                u77 = u71:_getButtonScale(u85);
                u75 = true;
                u71:_setResizeModeVisual(true);
            end);
            table.insert(u71._dragConnections, v89);
            local v95 = u85.InputChanged:Connect(function(p90) -- Line: 639
                -- upvalues: u71 (copy), u85 (copy), SCALE_STEP (ref), MIN_SCALE (ref), MAX_SCALE (ref)
                if p90.UserInputType ~= Enum.UserInputType.MouseWheel then
                    return;
                end;

                local v91 = p90.Position.Z > 0 and 1 or -1;
                local v92 = (u71:_getButtonScale(u85) + v91 * SCALE_STEP) / SCALE_STEP + 0.5;
                local v93 = math.floor(v92) * SCALE_STEP;
                u71:_applyButtonScale(u85, (math.clamp(v93, MIN_SCALE, MAX_SCALE)));
                local v94 = u85;
                u71._pendingPositions[v94.Name] = {
                    X = v94.Position.X.Scale,
                    Y = v94.Position.Y.Scale,
                    Scale = u71:_getButtonScale(v94)
                };
            end);
            table.insert(u71._dragConnections, v95);
        end;
    end;

    local v98 = UserInputService.InputChanged:Connect(function(p96) -- Line: 648
        -- upvalues: u72 (ref), u73 (ref), u75 (ref), u76 (ref), u71 (copy), u77 (ref), SCALE_STEP (ref), MIN_SCALE (ref), MAX_SCALE (ref), Vector2_zero (ref)
        if not u72 then
            return;
        end;

        if p96 ~= u73 and p96.UserInputType ~= Enum.UserInputType.MouseMovement then
            return;
        end;

        if u75 then
            local v97 = math.floor((u77 + (u76 - p96.Position.Y) / 150) / SCALE_STEP + 0.5) * SCALE_STEP;
            u71:_applyButtonScale(u72, (math.clamp(v97, MIN_SCALE, MAX_SCALE)));

            return;
        end;

        local ViewportSize = workspace.CurrentCamera.ViewportSize;
        local math_clamp_ret = math.clamp((p96.Position.X - Vector2_zero.X) / ViewportSize.X, 0.05, 0.95);
        local math_clamp_ret2 = math.clamp((p96.Position.Y - Vector2_zero.Y) / ViewportSize.Y, 0.05, 0.95);
        u72.Position = UDim2.fromScale(math_clamp_ret, math_clamp_ret2);
    end);
    table.insert(u71._dragConnections, v98);
    local v101 = UserInputService.InputEnded:Connect(function(p99) -- Line: 670
        -- upvalues: u72 (ref), u73 (ref), u71 (copy), u75 (ref), u74 (ref)
        if not u72 then
            return;
        end;

        if p99 == u73 or p99.UserInputType == Enum.UserInputType.MouseButton1 and (u73 ~= nil and u73.UserInputType == Enum.UserInputType.MouseButton1) then
            local v100 = u72;
            u71._pendingPositions[v100.Name] = {
                X = v100.Position.X.Scale,
                Y = v100.Position.Y.Scale,
                Scale = u71:_getButtonScale(v100)
            };

            if u75 then
                u75 = false;
                u71:_setResizeModeVisual(u74);
            end;

            u72 = nil;
            u73 = nil;
        end;
    end);
    table.insert(u71._dragConnections, v101);
end;

function v6._cleanupDragHandlers(p102) -- Line: 688
    for _, v in ipairs(p102._dragConnections) do
        v:Disconnect();
    end;

    table.clear(p102._dragConnections);
end;

function v6._setupMobileLayoutTrigger(u103) -- Line: 698
    local MobileLayout = u103._assetsFrame:FindFirstChild("MobileLayout", true);

    if not MobileLayout then
        warn("[SettingsController] MobileLayout frame not found");

        return;
    end;

    local Button = MobileLayout:FindFirstChild("Button");
    local v104 = nil;

    if Button and Button:IsA("GuiButton") then
        v104 = Button;
    elseif Button then
        v104 = Button:FindFirstChildWhichIsA("GuiButton");
    end;

    local v105 = v104 or MobileLayout:FindFirstChildWhichIsA("GuiButton");

    if v105 then
        v105.MouseButton1Click:Connect(function() -- Line: 719
            -- upvalues: u103 (copy)
            u103:EnterEditMode();
        end);

        return;
    end;

    warn("[SettingsController] MobileLayout: no clickable Button found");
end;

local function SetupCheckbox(u106: any, p107: userdata, u108: string) -- Line: 726
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
    local CheckBox = p107:FindFirstChild("CheckBox");

    if not CheckBox then
        warn((`[SettingsController] No CheckBox found in {p107.Name}`));

        return;
    end;

    u106._uiElements[u108] = p107;
    local v109 = u106._settingsCache[u108] == true;
    local CheckBox2 = p107:FindFirstChild("CheckBox");
    local v110 = CheckBox2 and CheckBox2:FindFirstChild("Check");

    if v110 then
        local v111 = v109 and v110:GetAttribute("On") or v110:GetAttribute("Off");

        if v111 then
            v110.Position = v111;
        end;

        v110.BackgroundColor3 = v109 and Color3_fromRGB_ret or Color3_fromRGB_ret2;
    end;

    CheckBox.MouseButton1Click:Connect(function() -- Line: 736
        -- upvalues: u106 (copy), u108 (copy)
        u106:_onCheckboxClicked(u108);
    end);
end;

function v6._onCheckboxClicked(p112: table, u113: string) -- Line: 741
    -- upvalues: Knit (copy)
    local Controller = Knit.GetController("SoundController");

    if Controller then
        Controller:Play("Click");
    end;

    local Service = Knit.GetService("SettingsService");
    task.spawn(function() -- Line: 748
        -- upvalues: Service (copy), u113 (copy)
        Service:ToggleSetting(u113):await();
    end);
end;

function v6._updateHealthbarDropdown(p114: table, p115: string) -- Line: 755
    if not p114._healthbarDropdown then
        return;
    end;

    local Option = p114._healthbarDropdown:FindFirstChild("Option");

    if Option then
        Option.Text = p115;
    end;
end;

function v6._closeHealthbarDropdown(p116) -- Line: 761
    if p116._dropdownConn then
        p116._dropdownConn:Disconnect();
        p116._dropdownConn = nil;
    end;

    p116._healthbarOptionButtons = {};

    if not p116._healthbarHolder then
        return;
    end;

    for _, child in p116._healthbarHolder:GetChildren() do
        if child:IsA("GuiButton") and child ~= p116._healthbarTemplate then
            child:Destroy();
        end;
    end;

    p116._healthbarHolder.Visible = false;
end;

function v6._selectHealthbarMode(p117: table, u118: string) -- Line: 776
    -- upvalues: Knit (copy)
    p117._settingsCache.HealthbarMode = u118;
    p117:_updateHealthbarDropdown(u118);
    p117:_closeHealthbarDropdown();
    local Controller = Knit.GetController("HealthbarController");

    if Controller then
        Controller:SetMode(u118);
    end;

    local Service = Knit.GetService("SettingsService");
    task.spawn(function() -- Line: 785
        -- upvalues: Service (copy), u118 (copy)
        Service:SetSetting("HealthbarMode", u118):await();
    end);
    local Controller2 = Knit.GetController("SoundController");

    if Controller2 then
        Controller2:Play("Click");
    end;
end;

function v6._openHealthbarDropdown(u119) -- Line: 793
    -- upvalues: u3 (copy), UserInputService (copy)
    if not (u119._healthbarHolder and u119._healthbarTemplate) then
        return;
    end;

    u119._healthbarOptionButtons = {};

    for _, v in ipairs(u3) do
        local v120 = u119._healthbarTemplate:Clone();
        v120.Name = "Option_" .. v;
        local Option = v120:FindFirstChild("Option");

        if Option then
            Option.Text = v;
        end;

        v120.Visible = true;
        v120.Parent = u119._healthbarHolder;
        v120.MouseButton1Click:Connect(function() -- Line: 804
            -- upvalues: u119 (copy), v (copy)
            u119:_selectHealthbarMode(v);
        end);
        table.insert(u119._healthbarOptionButtons, v120);
    end;

    u119._healthbarHolder.Visible = true;
    u119._dropdownConn = UserInputService.InputBegan:Connect(function(p121) -- Line: 816
        -- upvalues: u119 (copy)
        if p121.UserInputType ~= Enum.UserInputType.MouseButton1 and p121.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        local _healthbarDropdown = u119._healthbarDropdown;
        local Position = p121.Position;
        local v122;

        if _healthbarDropdown and _healthbarDropdown.Parent then
            local AbsolutePosition = _healthbarDropdown.AbsolutePosition;
            local AbsoluteSize = _healthbarDropdown.AbsoluteSize;

            if Position.X >= AbsolutePosition.X and (Position.X <= AbsolutePosition.X + AbsoluteSize.X and Position.Y >= AbsolutePosition.Y) then
                v122 = Position.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
            else
                v122 = false;
            end;
        else
            v122 = false;
        end;

        if v122 then
            return;
        end;

        for _, v in u119._healthbarOptionButtons do
            local Position2 = p121.Position;
            local v123;

            if v and v.Parent then
                local AbsolutePosition = v.AbsolutePosition;
                local AbsoluteSize = v.AbsoluteSize;

                if Position2.X >= AbsolutePosition.X and (Position2.X <= AbsolutePosition.X + AbsoluteSize.X and Position2.Y >= AbsolutePosition.Y) then
                    v123 = Position2.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
                else
                    v123 = false;
                end;
            else
                v123 = false;
            end;

            if v123 then
                return;
            end;
        end;

        u119:_closeHealthbarDropdown();
    end);
end;

function v6._toggleHealthbarDropdown(p124) -- Line: 829
    if p124._healthbarHolder and p124._healthbarHolder.Visible then
        p124:_closeHealthbarDropdown();

        return;
    end;

    p124:_openHealthbarDropdown();
end;

function v6._setupHealthbarDropdown(u125) -- Line: 837
    local Healthbar = u125._assetsFrame:FindFirstChild("Healthbar", true);

    if not Healthbar then
        warn("[SettingsController] Healthbar dropdown frame not found");

        return;
    end;

    local Dropdown = Healthbar:FindFirstChild("Dropdown");
    local Dropdown_Holder = Healthbar:FindFirstChild("Dropdown_Holder");

    if not (Dropdown and Dropdown_Holder) then
        warn("[SettingsController] Healthbar Dropdown / Dropdown_Holder missing");

        return;
    end;

    local Dropdown_Template = Dropdown_Holder:FindFirstChild("Dropdown_Template");

    if Dropdown_Template then
        Dropdown_Template.Visible = false;
    end;

    u125._healthbarDropdown = Dropdown;
    u125._healthbarHolder = Dropdown_Holder;
    u125._healthbarTemplate = Dropdown_Template;
    Dropdown_Holder.Visible = false;
    u125:_updateHealthbarDropdown(u125._settingsCache.HealthbarMode or "Below");
    Dropdown.MouseButton1Click:Connect(function() -- Line: 859
        -- upvalues: u125 (copy)
        u125:_toggleHealthbarDropdown();
    end);
end;

function v6._updateSliderVisual(p126: table, p127: string, p128: number) -- Line: 866
    local v129 = p126._sliders[p127];

    if not v129 then
        return;
    end;

    local math_clamp_ret = math.clamp(p128 / 100, 0, 1);

    if v129.fill then
        local Y = v129.fill.Size.Y;
        v129.fill.Size = UDim2.new(math_clamp_ret, 0, Y.Scale, Y.Offset);
    end;

    if v129.knob then
        local Y = v129.knob.Position.Y;
        v129.knob.Position = UDim2.new(math_clamp_ret, 0, Y.Scale, Y.Offset);
    end;

    if v129.value then
        local value = v129.value;
        local math_round_ret = math.round(p128);
        value.Text = tostring(math_round_ret);
    end;
end;

local function ApplyVolumeLive(p130: string, p131: number) -- Line: 883
    local SoundService = game:GetService("SoundService");

    if p130 == "MusicVolume" then
        local Background = SoundService:FindFirstChild("Background");

        if Background then
            Background.Volume = p131 / 100;
        end;
    elseif p130 == "SFXVolume" then
        local SFX = SoundService:FindFirstChild("SFX");

        if SFX then
            SFX.Volume = p131 / 100;
        end;
    else
        local v132 = p130 == "EmoteVolume" and SoundService:FindFirstChild("Emote");

        if v132 then
            v132.Volume = p131 / 100;
        end;
    end;
end;

function v6._setupSlider(p133: table, p134: string, p135: string) -- Line: 899
    local v136 = p133._assetsFrame:FindFirstChild(p134, true);

    if not v136 then
        warn((`[SettingsController] Slider frame not found: {p134}`));

        return;
    end;

    local Dragger = v136:FindFirstChild("Dragger");

    if not Dragger then
        warn((`[SettingsController] {p134}: no Dragger`));

        return;
    end;

    local v137 = nil;
    local v138 = nil;

    for _, child in Dragger:GetChildren() do
        if child.Name == "Bar" then
            if child:FindFirstChildWhichIsA("UIStroke") then
                v138 = child;
            else
                v137 = child;
            end;
        end;
    end;

    local v139 = {
        frame = v136,
        dragger = Dragger,
        fill = v137,
        knob = v138,
        value = v136:FindFirstChild("Value")
    };
    p133._sliders[p135] = v139;
    p133:_updateSliderVisual(p135, p133._settingsCache[p135] or 50);
    p133:_wireSliderDrag(p135);
end;

function v6._wireSliderDrag(u140: table, u141: string) -- Line: 935
    -- upvalues: GuiService (copy), ApplyVolumeLive (copy), UserInputService (copy), Knit (copy)
    local dragger = u140._sliders[u141].dragger;
    local u142 = false;

    local function fractionFromX(p143: number) -- Line: 940
        -- upvalues: GuiService (ref), dragger (copy)
        local GuiInset = GuiService:GetGuiInset();
        local X = dragger.AbsoluteSize.X;

        return X <= 0 and 0 or math.clamp((p143 - (dragger.AbsolutePosition.X + GuiInset.X)) / X, 0, 1);
    end;

    local function setFromInput(p144) -- Line: 948
        -- upvalues: GuiService (ref), dragger (copy), u140 (copy), u141 (copy), ApplyVolumeLive (ref)
        local X = p144.Position.X;
        local GuiInset = GuiService:GetGuiInset();
        local X2 = dragger.AbsoluteSize.X;
        local v145 = X2 <= 0 and 0 or math.clamp((X - (dragger.AbsolutePosition.X + GuiInset.X)) / X2, 0, 1);
        local math_round_ret = math.round(v145 * 100);
        u140._settingsCache[u141] = math_round_ret;
        u140:_updateSliderVisual(u141, math_round_ret);
        ApplyVolumeLive(u141, math_round_ret);
    end;

    dragger.InputBegan:Connect(function(p146) -- Line: 955
        -- upvalues: u142 (ref), GuiService (ref), dragger (copy), u140 (copy), u141 (copy), ApplyVolumeLive (ref)
        if p146.UserInputType ~= Enum.UserInputType.MouseButton1 and p146.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        u142 = true;
        local X = p146.Position.X;
        local GuiInset = GuiService:GetGuiInset();
        local X2 = dragger.AbsoluteSize.X;
        local v147 = X2 <= 0 and 0 or math.clamp((X - (dragger.AbsolutePosition.X + GuiInset.X)) / X2, 0, 1);
        local math_round_ret = math.round(v147 * 100);
        u140._settingsCache[u141] = math_round_ret;
        u140:_updateSliderVisual(u141, math_round_ret);
        ApplyVolumeLive(u141, math_round_ret);
    end);
    UserInputService.InputChanged:Connect(function(p148) -- Line: 964
        -- upvalues: u142 (ref), GuiService (ref), dragger (copy), u140 (copy), u141 (copy), ApplyVolumeLive (ref)
        if not u142 then
            return;
        end;

        if p148.UserInputType ~= Enum.UserInputType.MouseMovement and p148.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        local X = p148.Position.X;
        local GuiInset = GuiService:GetGuiInset();
        local X2 = dragger.AbsoluteSize.X;
        local v149 = X2 <= 0 and 0 or math.clamp((X - (dragger.AbsolutePosition.X + GuiInset.X)) / X2, 0, 1);
        local math_round_ret = math.round(v149 * 100);
        u140._settingsCache[u141] = math_round_ret;
        u140:_updateSliderVisual(u141, math_round_ret);
        ApplyVolumeLive(u141, math_round_ret);
    end);
    UserInputService.InputEnded:Connect(function(p150) -- Line: 973
        -- upvalues: u142 (ref), u140 (copy), u141 (copy), Knit (ref)
        if not u142 then
            return;
        end;

        if p150.UserInputType ~= Enum.UserInputType.MouseButton1 and p150.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        u142 = false;
        local u151 = u140._settingsCache[u141];
        local Service = Knit.GetService("SettingsService");
        task.spawn(function() -- Line: 982
            -- upvalues: Service (copy), u141 (ref), u151 (copy)
            Service:SetSetting(u141, u151):await();
        end);
    end);
end;

function v6._selectCategory(p152: table, p153: string) -- Line: 990
    -- upvalues: ApplyTabVisual (copy)
    if not p152._assetsFrame then
        return;
    end;

    for _, child in p152._assetsFrame:GetChildren() do
        if child:IsA("Frame") and child.Name ~= "Bottom" then
            child.Visible = p153 == "General" and true or child.Name == p153;
        end;
    end;

    p152._assetsFrame.CanvasPosition = Vector2.zero;

    for i, v in pairs(p152._categoryButtons) do
        ApplyTabVisual(v, i == p153);
    end;
end;

function v6._setupCategoryNav(u154: table, p155: userdata) -- Line: 1005
    -- upvalues: u4 (copy), Knit (copy)
    local Frame = p155:FindFirstChild("Frame");

    if not Frame then
        warn("[SettingsController] Category nav Frame not found");

        return;
    end;

    table.clear(u154._categoryButtons);

    for _, v in ipairs(u4) do
        local v156 = Frame:FindFirstChild(v);

        if v156 and v156:IsA("GuiButton") then
            u154._categoryButtons[v] = v156;
            v156.MouseButton1Click:Connect(function() -- Line: 1016
                -- upvalues: u154 (copy), v (copy), Knit (ref)
                u154:_selectCategory(v);
                local Controller = Knit.GetController("SoundController");

                if Controller then
                    Controller:Play("Click");
                end;
            end);
        end;
    end;

    u154:_selectCategory("General");
end;

function v6._setupPotato(u157) -- Line: 1028
    -- upvalues: Color3_fromRGB_ret2 (copy), Knit (copy), ApplyPotato (copy), ApplyCheckboxVisual (copy)
    local Potato = u157._assetsFrame:FindFirstChild("Potato", true);

    if not Potato then
        return;
    end;

    local CheckBox = Potato:FindFirstChild("CheckBox");

    if not CheckBox then
        return;
    end;

    local CheckBox2 = Potato:FindFirstChild("CheckBox");
    local v158 = CheckBox2 and CheckBox2:FindFirstChild("Check");

    if v158 then
        local Attribute = v158:GetAttribute("Off");

        if Attribute then
            v158.Position = Attribute;
        end;

        v158.BackgroundColor3 = Color3_fromRGB_ret2;
    end;

    CheckBox.MouseButton1Click:Connect(function() -- Line: 1036
        -- upvalues: u157 (copy), Knit (ref), ApplyPotato (ref), ApplyCheckboxVisual (ref), Potato (copy)
        if u157._potatoActive then
            return;
        end;

        local u159 = false;
        local Controller = Knit.GetController("WarningController");

        if Controller then
            pcall(function() -- Line: 1042
                -- upvalues: u159 (ref), Controller (copy)
                u159 = Controller:Prompt({
                    Message = "This will strip all materials and textures from the world for the rest of this session. <b>It cannot be undone unless you rejoin.</b> Continue?",
                    ConfirmText = "Potato Me",
                    DenyText = "Cancel"
                });
            end);
        end;

        if not u159 then
            return;
        end;

        ApplyPotato();
        u157._potatoActive = true;
        ApplyCheckboxVisual(Potato, true, false);
        local Controller2 = Knit.GetController("SoundController");

        if Controller2 then
            Controller2:Play("Click");
        end;
    end);
end;

function v6._restoreDefaults(p160) -- Line: 1063
    -- upvalues: Knit (copy), u5 (copy)
    local u161 = false;
    local Controller = Knit.GetController("WarningController");

    if Controller then
        pcall(function() -- Line: 1067
            -- upvalues: u161 (ref), Controller (copy)
            u161 = Controller:Prompt({
                Message = "Restore all settings and keybinds to their defaults?",
                ConfirmText = "Restore",
                DenyText = "Cancel"
            });
        end);
    else
        u161 = true;
    end;

    if not u161 then
        return;
    end;

    local Service = Knit.GetService("SettingsService");

    for i, v in pairs(u5) do
        p160._settingsCache[i] = v;
        task.spawn(function() -- Line: 1082
            -- upvalues: Service (copy), i (copy), v (copy)
            Service:SetSetting(i, v):await();
        end);
    end;

    local Controller2 = Knit.GetController("InputBindingController");

    if Controller2 then
        Controller2:ResetAll("Keyboard");
        Controller2:ResetAll("Gamepad");
    end;

    local Controller3 = Knit.GetController("HealthbarController");

    if Controller3 then
        Controller3:SetMode(u5.HealthbarMode);
    end;

    p160:_refreshAllVisuals();
    local Controller4 = Knit.GetController("SoundController");

    if Controller4 then
        Controller4:Play("Click");
    end;
end;

function v6._setupRestoreDefaults(u162: table, p163: userdata) -- Line: 1104
    local RestoreDefaults = p163:FindFirstChild("RestoreDefaults");

    if not RestoreDefaults then
        return;
    end;

    local v164 = RestoreDefaults:IsA("GuiButton") and RestoreDefaults and RestoreDefaults or RestoreDefaults:FindFirstChildWhichIsA("GuiButton");

    if v164 then
        v164.MouseButton1Click:Connect(function() -- Line: 1109
            -- upvalues: u162 (copy)
            u162:_restoreDefaults();
        end);
    end;
end;

function v6._setupExit(u165: table, p166: userdata) -- Line: 1115
    local Exit = p166:FindFirstChild("Exit");

    if not Exit then
        return;
    end;

    local v167 = Exit:IsA("GuiButton") and Exit and Exit or Exit:FindFirstChildWhichIsA("GuiButton");

    if v167 then
        v167.MouseButton1Click:Connect(function() -- Line: 1120
            -- upvalues: u165 (copy)
            u165:CloseSettings();
        end);
    end;
end;

function v6._updatePVPStatusHUD(p168: table, p169: boolean) -- Line: 1129
    local _pvpStatusFrame = p168._pvpStatusFrame;

    if not _pvpStatusFrame then
        return;
    end;

    local v170 = p169 and _pvpStatusFrame:FindFirstChild("PVP_Enabled") or _pvpStatusFrame:FindFirstChild("PVP_Disabled");

    if v170 and v170:IsA("ImageLabel") then
        _pvpStatusFrame.Image = v170.Image;
    end;

    local Status_Text = _pvpStatusFrame:FindFirstChild("Status_Text");

    if Status_Text then
        Status_Text.Text = p169 and "PVP ON" or "PVP OFF";
    end;

    _pvpStatusFrame.ImageColor3 = p169 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0);
end;

function v6._onServerSettingChanged(p171: table, p172: string, p173: any) -- Line: 1147
    -- upvalues: ApplyCheckboxVisual (copy), Knit (copy), SetLightingEffectEnabled (copy)
    p171._settingsCache[p172] = p173;

    if not p171._initialized then
        return;
    end;

    local v174 = p171._uiElements[p172];

    if v174 then
        ApplyCheckboxVisual(v174, p173 == true, false);
    end;

    if p172 == "PVPEnabled" then
        p171:_updatePVPStatusHUD(p173 == true);

        return;
    end;

    if p172 == "ShowHitbox" then
        p171:_applyHitboxSetting(p173 == true);

        return;
    end;

    if p172 == "HealthbarMode" then
        local Controller = Knit.GetController("HealthbarController");

        if Controller then
            Controller:SetMode(p173);
        end;

        p171:_updateHealthbarDropdown(p173);

        return;
    end;

    if p172 == "HideMobileButtons" then
        p171:_applyMobileButtonsVisibility();

        return;
    end;

    if p172 == "PopFallNumbers" then
        p171:_applyDamageNumberSetting(p173 == true);

        return;
    end;

    if p172 == "DisableBloom" then
        SetLightingEffectEnabled("BloomEffect", not p173);

        return;
    end;

    if p172 == "DisableSunrays" then
        SetLightingEffectEnabled("SunRaysEffect", not p173);

        return;
    end;

    if p172 == "DisableDepth" then
        SetLightingEffectEnabled("DepthOfFieldEffect", not p173);

        return;
    end;

    if p172 == "DisableShadows" then
        game:GetService("Lighting").GlobalShadows = not p173;

        return;
    end;

    if p172 == "LobbyNight" then
        local Controller = Knit.GetController("LobbyLightingController");

        if Controller then
            Controller:SetNight(p173 == true);
        end;
    else
        if p172 == "MusicVolume" then
            p171:_updateSliderVisual("MusicVolume", p173);

            return;
        end;

        if p172 == "SFXVolume" then
            p171:_updateSliderVisual("SFXVolume", p173);

            return;
        end;

        if p172 == "EmoteVolume" then
            p171:_updateSliderVisual("EmoteVolume", p173);
        end;
    end;
end;

function v6._refreshAllVisuals(p175) -- Line: 1192
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
    for i, v in pairs(p175._uiElements) do
        local v176 = p175._settingsCache[i] == true;
        local CheckBox = v:FindFirstChild("CheckBox");

        if CheckBox then
            local Check = CheckBox:FindFirstChild("Check");

            if Check then
                local v177 = v176 and Check:GetAttribute("On") or Check:GetAttribute("Off");

                if v177 then
                    Check.Position = v177;
                end;

                Check.BackgroundColor3 = v176 and Color3_fromRGB_ret or Color3_fromRGB_ret2;
            end;
        end;
    end;

    for i in pairs(p175._sliders) do
        p175:_updateSliderVisual(i, p175._settingsCache[i] or 50);
    end;

    p175:_updateHealthbarDropdown(p175._settingsCache.HealthbarMode or "Below");
    p175:_updatePVPStatusHUD(p175._settingsCache.PVPEnabled == true);
end;

function v6._setupHUD(u178: table, p179: userdata) -- Line: 1207
    local HUD = p179:FindFirstChild("HUD");

    if not HUD then
        return;
    end;

    local BottomRight = HUD:FindFirstChild("BottomRight");

    if BottomRight then
        local Settings = BottomRight:FindFirstChild("Settings");

        if Settings then
            local v180 = Settings:FindFirstChildWhichIsA("TextButton") or Settings:FindFirstChildWhichIsA("ImageButton");

            if v180 then
                v180.MouseButton1Click:Connect(function() -- Line: 1219
                    -- upvalues: u178 (copy)
                    u178:ToggleSettings();
                end);
            elseif Settings:IsA("TextButton") or Settings:IsA("ImageButton") then
                Settings.MouseButton1Click:Connect(function() -- Line: 1221
                    -- upvalues: u178 (copy)
                    u178:ToggleSettings();
                end);
            end;
        end;

        u178._pvpStatusFrame = BottomRight:FindFirstChild("PVP_Status");
        u178:_updatePVPStatusHUD(u178._settingsCache.PVPEnabled == true);
    end;

    local MobileActions = HUD:FindFirstChild("MobileActions");

    if MobileActions then
        u178._mobileActionsFrame = MobileActions;
        u178:_applyMobileButtonsVisibility();
        local Save_Changes = MobileActions:FindFirstChild("Save_Changes");

        if Save_Changes then
            u178._saveChangesFrame = Save_Changes;
            Save_Changes.Visible = false;
            local ImageButton = Save_Changes:FindFirstChild("ImageButton");

            if ImageButton then
                ImageButton.Activated:Connect(function() -- Line: 1242
                    -- upvalues: u178 (copy)
                    u178:ExitEditMode(true);
                end);
            end;
        end;

        local Cancel_Changes = MobileActions:FindFirstChild("Cancel_Changes");

        if Cancel_Changes then
            u178._cancelChangesFrame = Cancel_Changes;
            Cancel_Changes.Visible = false;
            local ImageButton = Cancel_Changes:FindFirstChild("ImageButton");

            if ImageButton then
                ImageButton.Activated:Connect(function() -- Line: 1252
                    -- upvalues: u178 (copy)
                    u178:ExitEditMode(false);
                end);
            end;
        end;

        local Default_Changes = MobileActions:FindFirstChild("Default_Changes");

        if Default_Changes then
            u178._defaultChangesFrame = Default_Changes;
            Default_Changes.Visible = false;
            local ImageButton = Default_Changes:FindFirstChild("ImageButton");

            if ImageButton then
                ImageButton.Activated:Connect(function() -- Line: 1262
                    -- upvalues: u178 (copy)
                    u178:ResetToDefaultLayout();
                end);
            end;
        end;

        local Notice = MobileActions:FindFirstChild("Notice");

        if Notice then
            u178._noticeFrame = Notice;
            Notice.Visible = false;
        end;

        local Resize_Active = MobileActions:FindFirstChild("Resize_Active");

        if Resize_Active then
            u178._resizeActiveFrame = Resize_Active;
            Resize_Active.Visible = false;
            u178._resizeToggleButton = Resize_Active:FindFirstChild("ImageButton");
            u178._resizeEnabledGradient = Resize_Active:FindFirstChild("EnabledGradient");
            u178._resizeDisabledGradient = Resize_Active:FindFirstChild("DisabledGradient");
            u178._resizeStatusLabel = Resize_Active:FindFirstChild("Status");
        end;

        u178:_loadMobileLayout();
    end;
end;

function v6.SetupUI(p181: table, p182: userdata) -- Line: 1289
    -- upvalues: u1 (copy), SetupCheckbox (copy), u2 (copy)
    local UIController = require(script.Parent.UIController);
    local Main = p182:WaitForChild("Main", 10);

    if not Main then
        warn("[SettingsController] Settings.Main panel not found");

        return;
    end;

    p181._settingsFrame = Main;
    p181._uiController = UIController.new(Main);
    Main.Visible = false;
    p181._uiController.isOpen = false;
    local Assets = Main:WaitForChild("Assets", 10);

    if not Assets then
        warn("[SettingsController] Settings.Main.Assets not found");

        return;
    end;

    p181._assetsFrame = Assets;
    p181:_setupCategoryNav(Main);

    for i, v in pairs(u1) do
        local v183 = Assets:FindFirstChild(i, true);

        if v183 then
            SetupCheckbox(p181, v183, v);
        else
            warn((`[SettingsController] Setting frame not found: {i}`));
        end;
    end;

    p181:_setupHealthbarDropdown();

    for i, v in pairs(u2) do
        p181:_setupSlider(i, v);
    end;

    p181:_setupPotato();
    p181:_setupRestoreDefaults(Main);
    p181:_setupExit(Main);
    p181:_setupMobileLayoutTrigger();
    p181._initialized = true;
    p181:_refreshAllVisuals();
end;

function v6._applyBootSideEffects(u184) -- Line: 1339
    -- upvalues: SetLightingEffectEnabled (copy), Knit (copy)
    if u184._settingsCache.ShowHitbox then
        task.defer(function() -- Line: 1341
            -- upvalues: u184 (copy)
            u184:_applyHitboxSetting(true);
        end);
    end;

    if u184._settingsCache.DisableBloom then
        SetLightingEffectEnabled("BloomEffect", false);
    end;

    if u184._settingsCache.DisableSunrays then
        SetLightingEffectEnabled("SunRaysEffect", false);
    end;

    if u184._settingsCache.DisableDepth then
        SetLightingEffectEnabled("DepthOfFieldEffect", false);
    end;

    if u184._settingsCache.DisableShadows then
        game:GetService("Lighting").GlobalShadows = false;
    end;

    local v185 = u184._settingsCache.LobbyNight and Knit.GetController("LobbyLightingController");

    if v185 then
        v185:SetNight(true, true);
    end;

    u184:_applyDamageNumberSetting(u184._settingsCache.PopFallNumbers == true);
end;

function v6.KnitInit(p186) -- Line: 1366
    p186._settingsCache = {
        ReduceMotion = false,
        HideOtherVFX = false,
        HideSelfVFX = false,
        DisableEmoteSounds = false,
        EmoteWeapon = false,
        ShowHitbox = false,
        HideWeaponCosmetic = false,
        DisableSprintZoom = true,
        AutoSprint = false,
        BlockPartyInvites = false,
        HideMobileButtons = false,
        DisableBloom = false,
        DisableSunrays = false,
        DisableDepth = false,
        DisableShadows = false,
        DisableZoneClearSound = false,
        HidePlayerAccessories = false,
        AutoShiftLock = true,
        DisableAreaWarp = false,
        HideUI = false,
        PopFallNumbers = false,
        LobbyNight = false,
        HealthbarMode = "Below",
        MusicVolume = 50,
        SFXVolume = 50,
        EmoteVolume = 50,
        PVPEnabled = false,
        SkipChestSpin = false
    };
end;

function v6.KnitStart(u187) -- Line: 1385
    -- upvalues: Knit (copy), LocalPlayer (copy), ReplicatedStorage (copy), FlashHitbox (copy)
    local Service = Knit.GetService("SettingsService");
    Service.SettingChanged:Connect(function(p188, p189) -- Line: 1389
        -- upvalues: u187 (copy)
        u187:_onServerSettingChanged(p188, p189);
    end);
    local v190, v191 = Service:GetSettings():await();

    if v190 and v191 then
        for i, v in pairs(v191) do
            u187._settingsCache[i] = v;
        end;
    end;

    local v192 = v190 and (v191 and (v191.HealthbarMode and Knit.GetController("HealthbarController")));

    if v192 then
        v192:SetMode(v191.HealthbarMode);
    end;

    u187:_applyBootSideEffects();
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    u187:_setupHUD((PlayerGui:WaitForChild("Main")));
    LocalPlayer.CharacterAdded:Connect(function(p193) -- Line: 1415
        -- upvalues: u187 (copy)
        p193:WaitForChild("HumanoidRootPart");

        if u187._settingsCache.ShowHitbox then
            task.defer(function() -- Line: 1418
                -- upvalues: u187 (ref)
                u187:_applyHitboxSetting(true);
            end);
        end;
    end);
    ReplicatedStorage.Player.Remotes.CombatFeedback.OnClientEvent:Connect(function(p194) -- Line: 1424
        -- upvalues: u187 (copy), FlashHitbox (ref)
        if p194 == "Hit" and u187._settingsCache.ShowHitbox then
            FlashHitbox();
        end;
    end);
    (function(u195: string) -- Line: 1432, Name: connectZoneClearSound
        -- upvalues: Knit (ref), u187 (copy)
        local success, result = pcall(function() -- Line: 1433
            -- upvalues: Knit (ref), u195 (copy)
            return Knit.GetService(u195);
        end);

        if success and (result and result.PlayZoneClearSound) then
            result.PlayZoneClearSound:Connect(function() -- Line: 1435
                -- upvalues: u187 (ref), Knit (ref)
                if u187._settingsCache.DisableZoneClearSound then
                    return;
                end;

                local Controller = Knit.GetController("SoundController");

                if Controller then
                    Controller:Play("Room_Clear");
                end;
            end);
        end;
    end)("DungeonRunService");
    local Settings = PlayerGui:WaitForChild("Settings");
    task.defer(function() -- Line: 1446
        -- upvalues: u187 (copy), Settings (copy)
        u187:SetupUI(Settings);
    end);
end;

return v6;