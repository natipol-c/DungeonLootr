--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Stats
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.Stats
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local spr = require(script.Parent.Parent.ClientUtils.spr);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local LevelData = require(ReplicatedStorage.GameInfo.LevelData);
local PrestigeData = require(ReplicatedStorage.GameInfo.PrestigeData);
local Skill = ReplicatedStorage:WaitForChild("Player").Remotes.Inputs.Skill;
local LocalPlayer = Players.LocalPlayer;
local u1 = nil;

local function GetIBC() -- Line: 32
    -- upvalues: u1 (ref), Knit (copy)
    if u1 then
        return u1;
    end;

    local success, result = pcall(function() -- Line: 34
        -- upvalues: Knit (ref)
        return Knit.GetController("InputBindingController");
    end);

    if success then
        u1 = result;
    end;

    return u1;
end;

local v2 = {};
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
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
local u24 = 0;
local u25 = 0;
local u26 = 1;
local u27 = 0;
local u28 = 0;
local u29 = {};
local u30 = {};
local u31 = {};
local u32 = {};
local u33 = {};

local function CaptureFillMax(p34: userdata?) -- Line: 106
    -- upvalues: u33 (copy)
    if p34 then
        u33[p34] = p34.Size.X.Scale;
    end;
end;

local function FillGoal(p35: userdata, p36: number) -- Line: 113
    -- upvalues: u33 (copy)
    return UDim2.fromScale((u33[p35] or 1) * p36, 1);
end;

local function SetBarFill(p37: userdata?, p38: number, p39: number, p40: boolean?) -- Line: 121
    -- upvalues: u33 (copy), spr (copy)
    if not p37 then
        return p38;
    end;

    local UDim2_fromScale_ret = UDim2.fromScale((u33[p37] or 1) * p38, 1);

    if p40 then
        spr.stop(p37, "Size");
        p37.Size = UDim2_fromScale_ret;

        return p38;
    end;

    if math.abs(p38 - p39) >= 0.1 then
        spr.target(p37, 0.85, 3, {
            Size = UDim2_fromScale_ret
        });

        return p38;
    end;

    spr.target(p37, 1, 8, {
        Size = UDim2_fromScale_ret
    });

    return p38;
end;

local function FireLevelEffect() -- Line: 141
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local LevelEffect = HumanoidRootPart:FindFirstChild("LevelEffect");

    if not LevelEffect then
        return;
    end;

    LevelEffect:SetAttribute("Fire", not LevelEffect:GetAttribute("Fire"));
end;

local function GetPlayerXPRatio() -- Line: 154
    -- upvalues: u4 (ref), LevelData (copy)
    local Data = u4.Data;
    local v41 = Data.PlayerLevel or 1;
    local v42 = Data.PlayerXP or 0;

    if LevelData.PLAYER_LEVEL_CAP <= v41 then
        return 1;
    end;

    local PlayerXPForLevel = LevelData.GetPlayerXPForLevel(v41 + 1);

    return (PlayerXPForLevel == (1 / 0) or PlayerXPForLevel <= 0) and 1 or math.clamp(v42 / PlayerXPForLevel, 0, 1);
end;

local function GetClassXPRatio() -- Line: 167
    -- upvalues: u4 (ref), LevelData (copy), PrestigeData (copy)
    local Data = u4.Data;
    local ActiveClass = Data.ActiveClass;

    if not ActiveClass or ActiveClass == "" then
        return 0;
    end;

    local v43 = Data.ClassMastery and Data.ClassMastery[ActiveClass];
    local v44 = v43 and (v43.Level or 1) or 1;
    local v45 = v43 and v43.XP or 0;

    if LevelData.CLASS_LEVEL_CAP <= v44 then
        return 1;
    end;

    local ClassXPForLevel = LevelData.GetClassXPForLevel(v44 + 1);

    if ClassXPForLevel == (1 / 0) or ClassXPForLevel <= 0 then
        return 1;
    end;

    local v46 = Data.ClassPrestige and Data.ClassPrestige[ActiveClass];
    local v47 = ClassXPForLevel * PrestigeData.GetXPRequiredMultiplier(v46 and v46.Prestiges or 0);
    local v48 = v45 / math.floor(v47);

    return math.clamp(v48, 0, 1);
end;

local function FormatHealth(p49: number, p50: number) -- Line: 189
    local math_max_ret = math.max(p49, 0);

    return math.floor(math_max_ret) .. " / " .. math.floor(p50);
end;

local function UpdateHealth(p51: number, p52: number, p53: boolean?) -- Line: 195
    -- upvalues: u14 (ref), u26 (ref), SetBarFill (copy), u13 (ref)
    local v54 = p51 / math.max(p52, 1);
    local math_clamp_ret = math.clamp(v54, 0, 1);

    if u14 then
        local math_max_ret = math.max(p51, 0);
        u14.Text = "HP: " .. math.floor(math_max_ret) .. " / " .. math.floor(p52);
    end;

    u26 = SetBarFill(u13, math_clamp_ret, u26, p53);
end;

local function HookCharacterHealth(p55: userdata) -- Line: 207
    -- upvalues: u29 (copy), u14 (ref), u26 (ref), u13 (ref), u33 (copy), spr (copy), SetBarFill (copy)
    for _, v in u29 do
        v:Disconnect();
    end;

    table.clear(u29);
    local u56 = p55:FindFirstChildOfClass("Humanoid") or p55:WaitForChild("Humanoid", 5);

    if not u56 then
        return;
    end;

    local Health = u56.Health;
    local MaxHealth = u56.MaxHealth;
    local v57 = Health / math.max(MaxHealth, 1);
    local math_clamp_ret = math.clamp(v57, 0, 1);

    if u14 then
        local math_max_ret = math.max(Health, 0);
        u14.Text = "HP: " .. math.floor(math_max_ret) .. " / " .. math.floor(MaxHealth);
    end;

    local v58 = u13;

    if v58 then
        local UDim2_fromScale_ret = UDim2.fromScale((u33[v58] or 1) * math_clamp_ret, 1);
        spr.stop(v58, "Size");
        v58.Size = UDim2_fromScale_ret;
    end;

    u26 = math_clamp_ret;
    table.insert(u29, u56.HealthChanged:Connect(function(p59) -- Line: 221
        -- upvalues: u56 (copy), u14 (ref), u26 (ref), SetBarFill (ref), u13 (ref)
        local MaxHealth2 = u56.MaxHealth;
        local v60 = p59 / math.max(MaxHealth2, 1);
        local math_clamp_ret2 = math.clamp(v60, 0, 1);

        if u14 then
            local math_max_ret = math.max(p59, 0);
            u14.Text = "HP: " .. math.floor(math_max_ret) .. " / " .. math.floor(MaxHealth2);
        end;

        u26 = SetBarFill(u13, math_clamp_ret2, u26, nil);
    end));
    local PropertyChangedSignal = u56:GetPropertyChangedSignal("MaxHealth");
    table.insert(u29, PropertyChangedSignal:Connect(function() -- Line: 225
        -- upvalues: u56 (copy), u14 (ref), u26 (ref), SetBarFill (ref), u13 (ref)
        local Health2 = u56.Health;
        local MaxHealth2 = u56.MaxHealth;
        local v61 = Health2 / math.max(MaxHealth2, 1);
        local math_clamp_ret2 = math.clamp(v61, 0, 1);

        if u14 then
            local math_max_ret = math.max(Health2, 0);
            u14.Text = "HP: " .. math.floor(math_max_ret) .. " / " .. math.floor(MaxHealth2);
        end;

        u26 = SetBarFill(u13, math_clamp_ret2, u26, nil);
    end));
end;

local Color3_fromRGB_ret = Color3.fromRGB(255, 140, 0);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 50, 30);

local function UpdateHeat(p62: number, p63: number, p64: boolean, p65: boolean?) -- Line: 286
    -- upvalues: u16 (ref), u17 (ref), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), spr (copy), u27 (ref)
    if not (u16 and u17) then
        return;
    end;

    local v66 = p62 / math.max(p63, 1);
    local math_clamp_ret = math.clamp(v66, 0, 1);
    u17.Text = p64 and "HEAT MODE" or "HEAT";
    local v67 = p64 and Color3_fromRGB_ret2 or Color3_fromRGB_ret;

    if p65 then
        spr.stop(u16, "BackgroundColor3");
        u16.BackgroundColor3 = v67;
    else
        spr.target(u16, 0.8, 5, {
            BackgroundColor3 = v67
        });
    end;

    if p65 then
        spr.stop(u16, "Size");
        u16.Size = UDim2.fromScale(math_clamp_ret, 1);
    elseif math.abs(math_clamp_ret - u27) >= 0.1 then
        spr.target(u16, 0.85, 3, {
            Size = UDim2.fromScale(math_clamp_ret, 1)
        });
    else
        spr.target(u16, 1, 8, {
            Size = UDim2.fromScale(math_clamp_ret, 1)
        });
    end;

    u27 = math_clamp_ret;
end;

local function HookPlayerHeat() -- Line: 319
    -- upvalues: u30 (copy), LocalPlayer (copy), u15 (ref), u16 (ref), u17 (ref), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), spr (copy), u27 (ref), UpdateHeat (copy)
    for _, v in u30 do
        v:Disconnect();
    end;

    table.clear(u30);
    local v68 = LocalPlayer:GetAttribute("Heat_Max") or 0;

    if u15 then
        u15.Visible = v68 > 0;
    end;

    if v68 <= 0 then
        return;
    end;

    local v69 = LocalPlayer:GetAttribute("Heat") or 0;
    local v70 = LocalPlayer:GetAttribute("Heat_Active") or false;

    if u16 and u17 then
        local v71 = v69 / math.max(v68, 1);
        local math_clamp_ret = math.clamp(v71, 0, 1);
        u17.Text = v70 and "HEAT MODE" or "HEAT";
        spr.stop(u16, "BackgroundColor3");
        u16.BackgroundColor3 = v70 and Color3_fromRGB_ret2 or Color3_fromRGB_ret;
        spr.stop(u16, "Size");
        u16.Size = UDim2.fromScale(math_clamp_ret, 1);
        u27 = math_clamp_ret;
    end;

    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("Heat");
    table.insert(u30, AttributeChangedSignal:Connect(function() -- Line: 340
        -- upvalues: LocalPlayer (ref), UpdateHeat (ref)
        UpdateHeat(LocalPlayer:GetAttribute("Heat") or 0, LocalPlayer:GetAttribute("Heat_Max") or 0, LocalPlayer:GetAttribute("Heat_Active") or false);
    end));
    local AttributeChangedSignal2 = LocalPlayer:GetAttributeChangedSignal("Heat_Max");
    table.insert(u30, AttributeChangedSignal2:Connect(function() -- Line: 347
        -- upvalues: LocalPlayer (ref), UpdateHeat (ref)
        UpdateHeat(LocalPlayer:GetAttribute("Heat") or 0, LocalPlayer:GetAttribute("Heat_Max") or 0, LocalPlayer:GetAttribute("Heat_Active") or false);
    end));
    local AttributeChangedSignal3 = LocalPlayer:GetAttributeChangedSignal("Heat_Active");
    table.insert(u30, AttributeChangedSignal3:Connect(function() -- Line: 354
        -- upvalues: LocalPlayer (ref), UpdateHeat (ref)
        UpdateHeat(LocalPlayer:GetAttribute("Heat") or 0, LocalPlayer:GetAttribute("Heat_Max") or 0, LocalPlayer:GetAttribute("Heat_Active") or false);
    end));
end;

local function GetUltimateKeyText() -- Line: 372
    -- upvalues: u1 (ref), Knit (copy), UserInputService (copy)
    local v72;

    if u1 then
        v72 = u1;
    else
        local success, result = pcall(function() -- Line: 34
            -- upvalues: Knit (ref)
            return Knit.GetController("InputBindingController");
        end);

        if success then
            u1 = result;
        end;

        v72 = u1;
    end;

    if not v72 then
        return "G";
    end;

    local LastInputType = UserInputService:GetLastInputType();
    local Key = v72:GetKey("SkillE", ((LastInputType == Enum.UserInputType.Gamepad1 or (LastInputType == Enum.UserInputType.Gamepad2 or LastInputType == Enum.UserInputType.Gamepad3)) and true or LastInputType == Enum.UserInputType.Gamepad4) and "Gamepad" or "Keyboard");

    if Key then
        Key = v72:PrettyKey(Key);
    end;

    return (not Key or Key == "") and "G" or Key;
end;

local function UpdateUltimate(p73: boolean?) -- Line: 391
    -- upvalues: LocalPlayer (copy), u18 (ref), u28 (ref), u19 (ref), u33 (copy), spr (copy), u20 (ref), GetUltimateKeyText (copy), SetBarFill (copy)
    local v74 = LocalPlayer:GetAttribute("HasUltimate") or false;

    if u18 then
        u18.Visible = v74;
    end;

    if not v74 then
        local v75 = u19;
        local v76;

        if v75 then
            local UDim2_fromScale_ret = UDim2.fromScale((u33[v75] or 1) * 0, 1);
            spr.stop(v75, "Size");
            v75.Size = UDim2_fromScale_ret;
            v76 = 0;
        else
            v76 = 0;
        end;

        u28 = v76;

        return;
    end;

    local v77 = LocalPlayer:GetAttribute("UltimateCharge") or 0;
    local math_floor_ret = math.floor(v77);
    local v78 = LocalPlayer:GetAttribute("UltimateChargeMax") or 0;
    local math_floor_ret2 = math.floor(v78);
    local v79 = LocalPlayer:GetAttribute("UltimateReady") or false;

    if u20 then
        if v79 then
            u20.Text = "Ultimate - Press " .. GetUltimateKeyText() .. " - Ready";
        else
            u20.Text = "Ultimate - " .. math_floor_ret .. "/" .. math_floor_ret2 .. " - Not Ready";
        end;
    end;

    u28 = SetBarFill(u19, math_floor_ret2 > 0 and math.clamp(math_floor_ret / math_floor_ret2, 0, 1) or 0, u28, p73);
end;

local function HookPlayerUltimate() -- Line: 425
    -- upvalues: u31 (copy), UpdateUltimate (copy), LocalPlayer (copy), UserInputService (copy)
    for _, v in u31 do
        v:Disconnect();
    end;

    table.clear(u31);
    UpdateUltimate(true);

    for _, v in { "HasUltimate", "UltimateCharge", "UltimateChargeMax", "UltimateReady" } do
        local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal(v);
        table.insert(u31, AttributeChangedSignal:Connect(function() -- Line: 435
            -- upvalues: UpdateUltimate (ref)
            UpdateUltimate();
        end));
    end;

    table.insert(u31, UserInputService.LastInputTypeChanged:Connect(function() -- Line: 441
        -- upvalues: UpdateUltimate (ref)
        UpdateUltimate();
    end));
end;

local function WireUltimateButton() -- Line: 449
    -- upvalues: u21 (ref), u31 (copy), LocalPlayer (copy), Skill (copy)
    if not u21 then
        return;
    end;

    table.insert(u31, u21.Activated:Connect(function() -- Line: 452
        -- upvalues: LocalPlayer (ref), Skill (ref)
        if LocalPlayer:GetAttribute("Dead") then
            return;
        end;

        if not LocalPlayer:GetAttribute("Weapon_Equipped") then
            return;
        end;

        if not LocalPlayer:GetAttribute("HasUltimate") then
            return;
        end;

        if not LocalPlayer:GetAttribute("UltimateReady") then
            return;
        end;

        Skill:FireServer("E", "tap");
    end));
end;

local function SetFallbackThumbnail() -- Line: 464
    -- upvalues: u22 (ref), SharedUtils (copy), LocalPlayer (copy)
    if not u22 then
        return;
    end;

    u22.Visible = true;
    u22.Image = SharedUtils.GetHeadshotThumbnail(LocalPlayer.UserId);
end;

local function SetupHeadViewport(u80: userdata) -- Line: 473
    -- upvalues: u32 (copy), u23 (ref), u22 (ref), SharedUtils (copy), LocalPlayer (copy)
    for _, v in u32 do
        v:Disconnect();
    end;

    table.clear(u32);

    if not u23 then
        if not u22 then
            return;
        end;

        u22.Visible = true;
        u22.Image = SharedUtils.GetHeadshotThumbnail(LocalPlayer.UserId);

        return;
    end;

    for _, child in u23:GetChildren() do
        if child:IsA("WorldModel") or child:IsA("Camera") then
            child:Destroy();
        end;
    end;

    task.wait(1.5);

    if not (u80 and u80.Parent) then
        return;
    end;

    local success, result = pcall(function() -- Line: 500
        -- upvalues: u80 (copy), u23 (ref), u32 (ref), u22 (ref)
        if not u80:WaitForChild("Head", 3) then
            error("No Head found");
        end;

        local Archivable = u80.Archivable;
        u80.Archivable = true;
        local v81 = u80:Clone();
        u80.Archivable = Archivable;

        if not v81 then
            error("Clone failed");
        end;

        for _, descendant in v81:GetDescendants() do
            if descendant:IsA("BaseScript") or descendant:IsA("Sound") then
                descendant:Destroy();
            end;
        end;

        local u82 = v81:FindFirstChildOfClass("Humanoid");

        if u82 then
            u82.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        end;

        local WorldModel = Instance.new("WorldModel");
        WorldModel.Parent = u23;
        v81:PivotTo(CFrame.new(0, 0, 0) * CFrame.Angles(0, 0.2617993877991494, 0));
        v81.Parent = WorldModel;
        local Camera = Instance.new("Camera");
        Camera.FieldOfView = 30;
        Camera.CFrame = CFrame.new(0.2, 1.1, -5) * CFrame.fromOrientation(0, 3.056088973534591, 0);
        Camera.Parent = u23;
        u23.CurrentCamera = Camera;
        local u83 = u80:FindFirstChildOfClass("Humanoid");
        local u84;

        if u83 then
            u84 = u83:FindFirstChildOfClass("Animator");
        else
            u84 = u83;
        end;

        if u82 then
            u82 = u82:FindFirstChildOfClass("Animator");
        end;

        if u84 and u82 then
            local u85 = {};
            table.insert(u32, u84.AnimationPlayed:Connect(function(u86) -- Line: 554
                -- upvalues: u82 (copy), u85 (copy), u32 (ref)
                local Animation = u86.Animation;

                if not Animation then
                    return;
                end;

                local u87 = u82:LoadAnimation(Animation);
                u87.Priority = u86.Priority;
                u87:Play(0.1, 1, u86.Speed);
                u85[u86] = u87;
                local u88 = nil;
                u88 = u86.Stopped:Connect(function() -- Line: 567
                    -- upvalues: u87 (copy), u85 (ref), u86 (copy), u88 (ref)
                    if u87 and u87.IsPlaying then
                        u87:Stop(0.1);
                    end;

                    u85[u86] = nil;

                    if u88 then
                        u88:Disconnect();
                    end;
                end);
                table.insert(u32, u88);
            end));
            task.spawn(function() -- Line: 579
                -- upvalues: u83 (copy), u82 (copy), u84 (copy), u85 (copy), u32 (ref)
                if u83:GetState() == Enum.HumanoidStateType.Freefall then
                    u83.StateChanged:Wait();
                    task.wait(0.15);
                end;

                if not (u82 and u82.Parent) then
                    return;
                end;

                for _, v in u84:GetPlayingAnimationTracks() do
                    if v.Animation then
                        local u89 = u82:LoadAnimation(v.Animation);
                        u89.Priority = v.Priority;
                        u89:Play(0, 1, v.Speed);
                        u89.TimePosition = v.TimePosition;
                        u85[v] = u89;
                        local u90 = nil;
                        u90 = v.Stopped:Connect(function() -- Line: 598
                            -- upvalues: u89 (copy), u85 (ref), v (copy), u90 (ref)
                            if u89 and u89.IsPlaying then
                                u89:Stop(0.1);
                            end;

                            u85[v] = nil;

                            if u90 then
                                u90:Disconnect();
                            end;
                        end);
                        table.insert(u32, u90);
                    end;
                end;
            end);
        end;

        if u22 then
            u22.Visible = false;
        end;
    end);

    if not success then
        warn("[Stats] Head viewport setup failed:", result);

        if not u22 then
            return;
        end;

        u22.Visible = true;
        u22.Image = SharedUtils.GetHeadshotThumbnail(LocalPlayer.UserId);
    end;
end;

local function UpdatePlayer(p91: boolean?) -- Line: 628
    -- upvalues: u4 (ref), LevelData (copy), u10 (ref), u9 (ref), u24 (ref), SetBarFill (copy), u7 (ref)
    local Data = u4.Data;
    local v92 = Data.PlayerLevel or 1;
    local v93 = Data.PlayerXP or 0;
    local Data2 = u4.Data;
    local v94 = Data2.PlayerLevel or 1;
    local v95 = Data2.PlayerXP or 0;
    local v96;

    if LevelData.PLAYER_LEVEL_CAP <= v94 then
        v96 = 1;
    else
        local PlayerXPForLevel = LevelData.GetPlayerXPForLevel(v94 + 1);
        v96 = (PlayerXPForLevel == (1 / 0) or PlayerXPForLevel <= 0) and 1 or math.clamp(v95 / PlayerXPForLevel, 0, 1);
    end;

    if u10 then
        u10.Text = "Lv." .. v92;
    end;

    if u9 then
        if LevelData.PLAYER_LEVEL_CAP <= v92 then
            u9.Text = "MAX";
        else
            u9.Text = v93 .. "/" .. LevelData.GetPlayerXPForLevel(v92 + 1);
        end;
    end;

    u24 = SetBarFill(u7, v96, u24, p91);
end;

local function UpdateClass(p97: boolean?) -- Line: 652
    -- upvalues: u4 (ref), GetClassXPRatio (copy), u12 (ref), u11 (ref), u25 (ref), u8 (ref), u33 (copy), spr (copy), LevelData (copy), PrestigeData (copy), SetBarFill (copy)
    local Data = u4.Data;
    local ActiveClass = Data.ActiveClass;
    local v98 = GetClassXPRatio();

    if not ActiveClass or ActiveClass == "" then
        if u12 then
            u12.Text = "Class Level: —";
        end;

        if u11 then
            u11.Text = "Class EXP: —";
        end;

        local v99 = u8;
        local v100;

        if v99 then
            local UDim2_fromScale_ret = UDim2.fromScale((u33[v99] or 1) * 0, 1);
            spr.stop(v99, "Size");
            v99.Size = UDim2_fromScale_ret;
            v100 = 0;
        else
            v100 = 0;
        end;

        u25 = v100;

        return;
    end;

    local v101 = Data.ClassMastery and Data.ClassMastery[ActiveClass];
    local v102 = v101 and (v101.Level or 1) or 1;
    local v103 = v101 and v101.XP or 0;

    if u12 then
        u12.Text = "Class Level: " .. v102;
    end;

    if u11 then
        if LevelData.CLASS_LEVEL_CAP <= v102 then
            u11.Text = "Class EXP: MAX";
        else
            local ClassXPForLevel = LevelData.GetClassXPForLevel(v102 + 1);
            local v104 = Data.ClassPrestige and Data.ClassPrestige[ActiveClass];
            local v105 = ClassXPForLevel * PrestigeData.GetXPRequiredMultiplier(v104 and v104.Prestiges or 0);
            u11.Text = "Class EXP: " .. v103 .. " / " .. math.floor(v105);
        end;
    end;

    u25 = SetBarFill(u8, v98, u25, p97);
end;

function v2._Init(p106) -- Line: 691
    -- upvalues: u3 (ref), u4 (ref), Registry (copy), u5 (ref), Knit (copy), u6 (ref), u7 (ref), u9 (ref), u10 (ref), LocalPlayer (copy), u8 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), u23 (ref), u22 (ref), u15 (ref), u16 (ref), u17 (ref), u33 (copy), UpdatePlayer (copy), UpdateClass (copy), HookCharacterHealth (copy), SharedUtils (copy), HookPlayerHeat (copy), HookPlayerUltimate (copy), u31 (copy), Skill (copy), FireLevelEffect (copy)
    u3 = p106;
    u4 = Registry:Get("PlayerData");
    u5 = Knit.GetService("LevelService");
    local Actions = u3.HUD.Actions;
    local Bottom = Actions:FindFirstChild("Bottom");
    local Profile = Actions:FindFirstChild("Profile");
    u6 = Actions;
    local v107;

    if Profile then
        v107 = Profile:FindFirstChild("PlayerEXP");
    else
        v107 = Profile;
    end;

    local v108;

    if v107 then
        v108 = v107:FindFirstChild("Fill");
    else
        v108 = v107;
    end;

    u7 = v108;

    if v107 then
        v107 = v107:FindFirstChild("Amount");
    end;

    u9 = v107;

    if Profile then
        Profile = Profile:FindFirstChild("ProfileHolder");
    end;

    local v109;

    if Profile then
        v109 = Profile:FindFirstChild("Lvl");
    else
        v109 = Profile;
    end;

    u10 = v109;
    local v110;

    if Profile then
        v110 = Profile:FindFirstChild("User");
    else
        v110 = Profile;
    end;

    if v110 then
        v110.Text = LocalPlayer.DisplayName;
    end;

    local v111;

    if Bottom then
        v111 = Bottom:FindFirstChild("ClassEXP");
    else
        v111 = Bottom;
    end;

    local v112;

    if v111 then
        v112 = v111:FindFirstChild("Fill");
    else
        v112 = v111;
    end;

    u8 = v112;

    if v111 then
        v111 = v111:FindFirstChild("Amount");
    end;

    u11 = v111;
    u12 = nil;

    if Bottom then
        Bottom = Bottom:FindFirstChild("Bars");
    end;

    local v113;

    if Bottom then
        v113 = Bottom:FindFirstChild("Health");
    else
        v113 = Bottom;
    end;

    local v114;

    if v113 then
        v114 = v113:FindFirstChild("Fill");
    else
        v114 = v113;
    end;

    u13 = v114;

    if v113 then
        v113 = v113:FindFirstChild("Amount");
    end;

    u14 = v113;

    if Bottom then
        Bottom = Bottom:FindFirstChild("Ultimate");
    end;

    u18 = Bottom;
    local v115 = u18 and u18:FindFirstChild("Fill");
    u19 = v115;
    local v116 = u18 and u18:FindFirstChild("Amount");
    u20 = v116;
    local v117 = u18 and u18:FindFirstChild("MobileInput");
    u21 = v117;

    if Profile then
        Profile = Profile:FindFirstChild("Frame");
    end;

    local v118;

    if Profile then
        v118 = Profile:FindFirstChild("ViewportFrame");
    else
        v118 = Profile;
    end;

    u23 = v118;

    if Profile then
        Profile = Profile:FindFirstChild("ProfileImage");
    end;

    u22 = Profile;
    u15 = nil;
    u16 = nil;
    u17 = nil;
    local v119 = u7;

    if v119 then
        u33[v119] = v119.Size.X.Scale;
    end;

    local v120 = u8;

    if v120 then
        u33[v120] = v120.Size.X.Scale;
    end;

    local v121 = u13;

    if v121 then
        u33[v121] = v121.Size.X.Scale;
    end;

    local v122 = u19;

    if v122 then
        u33[v122] = v122.Size.X.Scale;
    end;

    UpdatePlayer(true);
    UpdateClass(true);

    if LocalPlayer.Character then
        task.defer(HookCharacterHealth, LocalPlayer.Character);
    end;

    LocalPlayer.CharacterAdded:Connect(function(p123) -- Line: 762
        -- upvalues: HookCharacterHealth (ref)
        task.defer(HookCharacterHealth, p123);
    end);

    if u23 then
        u23.Visible = false;
    end;

    if u22 then
        u22.Visible = true;
        u22.Image = SharedUtils.GetHeadshotThumbnail(LocalPlayer.UserId);
    end;

    HookPlayerHeat();
    HookPlayerUltimate();

    if u21 then
        table.insert(u31, u21.Activated:Connect(function() -- Line: 452
            -- upvalues: LocalPlayer (ref), Skill (ref)
            if LocalPlayer:GetAttribute("Dead") then
                return;
            end;

            if not LocalPlayer:GetAttribute("Weapon_Equipped") then
                return;
            end;

            if not LocalPlayer:GetAttribute("HasUltimate") then
                return;
            end;

            if not LocalPlayer:GetAttribute("UltimateReady") then
                return;
            end;

            Skill:FireServer("E", "tap");
        end));
    end;

    u4:OnChange(function(p124, p125) -- Line: 792
        -- upvalues: UpdatePlayer (ref), UpdateClass (ref), HookPlayerHeat (ref)
        if p125[1] == "PlayerXP" or p125[1] == "PlayerLevel" then
            UpdatePlayer();

            return;
        end;

        if p125[1] == "ClassMastery" then
            UpdateClass();

            return;
        end;

        if p125[1] == "ActiveClass" then
            UpdateClass(true);
            HookPlayerHeat();
        end;
    end);
    local Controller = Knit.GetController("SoundController");
    u5.PlayerLevelUp:Connect(function() -- Line: 808
        -- upvalues: FireLevelEffect (ref), Controller (copy)
        FireLevelEffect();

        if Controller then
            Controller:Play("LevelUP3");
        end;
    end);
    u5.ClassLevelUp:Connect(function() -- Line: 813
        -- upvalues: FireLevelEffect (ref), Controller (copy)
        FireLevelEffect();

        if Controller then
            Controller:Play("LevelUP2");
        end;
    end);
end;

return v2;