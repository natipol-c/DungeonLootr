--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SummoningController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.SummoningController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local MarketplaceService = game:GetService("MarketplaceService");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local v1 = Knit.CreateController({
    Name = "SummoningController"
});
local u2 = nil;
local u3 = nil;
local Class_Data = require(ReplicatedStorage.Classes.Class_Data);
local SummoningData = require(ReplicatedStorage.GameInfo.SummoningData);
local RarityData = require(ReplicatedStorage.GameInfo.RarityData);
local MutationData = require(ReplicatedStorage.GameInfo.MutationData);
local MonetizationList = require(ReplicatedStorage.GameInfo.MonetizationList);
local Weld_Manager = require(ReplicatedStorage.Globals.Modules.Weld_Manager);
local Registry = require(script.Parent.Registry);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local Image_Data = require(ReplicatedStorage.GameInfo.Image_Data);
local u4 = nil;
local u5 = nil;
local u6 = nil;

local function GetAspectGradientTemplate(p7: string) -- Line: 56
    -- upvalues: u6 (ref), ReplicatedStorage (copy)
    if not u6 then
        local Assets = ReplicatedStorage:FindFirstChild("Assets");

        if Assets then
            Assets = Assets:FindFirstChild("Rarity_Gradients");
        end;

        u6 = Assets;
    end;

    return u6 and u6:FindFirstChild(p7) or nil;
end;

local RarityIndex = RarityData.RarityIndex;
local Mythic = RarityIndex.Mythic;
local Mythic2 = RarityIndex.Mythic;
local LocalPlayer = Players.LocalPlayer;
local u8 = false;
local u9 = false;
local u10 = false;
local u11 = false;
local u12 = false;
local u13 = nil;
local u14 = 0;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
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
local u30 = nil;
local u31 = nil;
local u32 = nil;
local u33 = nil;
local u34 = false;
local u35 = nil;
local u36 = nil;
local u37 = false;
local u38 = false;
local u39 = nil;
local u40 = nil;
local u41 = nil;
local u42 = nil;
local u43 = "Spin";
local u44 = nil;
local u45 = {};
local u46 = {};
local u47 = nil;
local u48 = "";
local u49 = nil;
local u50 = nil;
local u51 = nil;
local u52 = nil;
local u53 = nil;
local u54 = nil;
local u55 = {};
local u56 = nil;
local u57 = nil;
local u58 = nil;
local u59 = nil;
local u60 = nil;
local u61 = nil;
local u62 = nil;
local u63 = nil;
local u64 = nil;
local u65 = nil;
local u66 = {};
local u67 = {};
local u68 = {};
local u69 = nil;
local u70 = nil;
local u71 = 1;
local u72 = false;
local u73 = "";
local u74 = nil;
local u75 = nil;

local function ResolveWorldReferences() -- Line: 214
    -- upvalues: u49 (ref), u50 (ref), u51 (ref)
    if u49 and (u49.Parent and (u50 and (u50.Parent and (u51 and u51.Parent)))) then
        return true;
    end;

    for i = 1, 10 do
        u49 = workspace:FindFirstChild("Summoning_Area");

        if u49 then
            u50 = u49:FindFirstChild("Camera_Model");
            u51 = u49:FindFirstChild("Summoning_Location_Model");
        end;

        if u49 and (u50 and u51) then
            return true;
        end;

        task.wait(0.2);
        local _ = i;
    end;

    warn("[SummoningController] Failed to resolve world references after retries, models may be streamed out");

    return false;
end;

local function FreezePlayer() -- Line: 243
    -- upvalues: LocalPlayer (copy), u15 (ref), u16 (ref), u17 (ref), u18 (ref)
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local v76 = Character:FindFirstChildOfClass("Humanoid");

    if not v76 then
        return;
    end;

    local v77;

    if v76.WalkSpeed > 0 then
        v77 = v76.WalkSpeed or nil;
    else
        v77 = nil;
    end;

    u15 = v77;
    local v78;

    if v76.JumpPower > 0 then
        v78 = v76.JumpPower or nil;
    else
        v78 = nil;
    end;

    u16 = v78;
    local v79;

    if v76.JumpHeight > 0 then
        v79 = v76.JumpHeight or nil;
    else
        v79 = nil;
    end;

    u17 = v79;
    u18 = v76.AutoRotate;
    v76.WalkSpeed = 0;
    v76.JumpPower = 0;
    v76.JumpHeight = 0;
    v76.AutoRotate = false;
    LocalPlayer:SetAttribute("Disable_ShiftLock", true);
end;

local function UnfreezePlayer() -- Line: 268
    -- upvalues: LocalPlayer (copy), u15 (ref), u16 (ref), u17 (ref), u18 (ref)
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local v80 = Character:FindFirstChildOfClass("Humanoid");

    if not v80 then
        return;
    end;

    v80.WalkSpeed = u15 or 20;
    v80.JumpPower = u16 or 50;
    v80.JumpHeight = u17 or 7.2;
    v80.AutoRotate = u18 == nil and true or u18;
    u15 = nil;
    u16 = nil;
    u17 = nil;
    u18 = nil;
    LocalPlayer:SetAttribute("Disable_ShiftLock", nil);
end;

local function SwitchToSummoningCamera() -- Line: 290
    -- upvalues: u56 (ref), u57 (ref), u50 (ref)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    u56 = workspace_CurrentCamera.CameraType;
    u57 = workspace_CurrentCamera.CFrame;
    local v81 = u50:FindFirstChildOfClass("Part") or (u50:FindFirstChild("Camera") or u50);
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    workspace_CurrentCamera.CFrame = v81.CFrame;
end;

local function RestoreCamera() -- Line: 302
    -- upvalues: u56 (ref)
    workspace.CurrentCamera.CameraType = u56 or Enum.CameraType.Custom;
end;

local function SwitchToSummoningDOF() -- Line: 309
    -- upvalues: u58 (ref), u59 (ref)
    if u58 then
        u58.Enabled = false;
    end;

    if u59 then
        u59.Enabled = true;
    end;
end;

local function RestoreDefaultDOF() -- Line: 314
    -- upvalues: u59 (ref), u58 (ref)
    if u59 then
        u59.Enabled = false;
    end;

    if u58 then
        u58.Enabled = true;
    end;
end;

local function DestroyClone() -- Line: 321
    -- upvalues: u13 (ref), u54 (ref), u55 (copy), u53 (ref), u52 (ref)
    if u13 then
        u13:Disconnect();
        u13 = nil;
    end;

    if u54 then
        u54:Stop(0);
        u54 = nil;
    end;

    for _, v in u55 do
        v:Stop(0);
    end;

    table.clear(u55);
    u53 = nil;

    if u52 then
        u52:Destroy();
        u52 = nil;
    end;
end;

local function CreateClone() -- Line: 344
    -- upvalues: DestroyClone (copy), LocalPlayer (copy), u51 (ref), u52 (ref), u53 (ref), Class_Data (copy), u54 (ref)
    DestroyClone();
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local v82 = {};

    if not Character.Archivable then
        v82[Character] = false;
        Character.Archivable = true;
    end;

    for _, descendant in Character:GetDescendants() do
        if not descendant.Archivable then
            v82[descendant] = false;
            descendant.Archivable = true;
        end;
    end;

    local v83 = Character:Clone();

    for i, _ in v82 do
        if i and i.Parent then
            i.Archivable = false;
        end;
    end;

    if not v83 then
        warn("[SummoningController] Failed to clone character");

        return;
    end;

    for _, descendant in v83:GetDescendants() do
        if descendant:IsA("BaseScript") or (descendant:IsA("ForceField") or (descendant:IsA("BodyMover") or descendant:IsA("Constraint"))) then
            descendant:Destroy();
        end;
    end;

    local v84 = u51:FindFirstChild("HumanoidRootPart") or (u51:IsA("Model") and u51.PrimaryPart or u51:FindFirstChildOfClass("Part"));

    if v84 then
        local Position = v84.CFrame.Position;
        local LookVector = v84.CFrame.LookVector;
        local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);
        v83:PivotTo(CFrame.lookAt(Position, Position + (Vector3_new_ret.Magnitude < 0.001 and Vector3.new(0, 0, -1) or Vector3_new_ret)));
    end;

    local HumanoidRootPart = v83:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        HumanoidRootPart.Anchored = true;
    end;

    v83.Name = "SummoningClone";
    v83.Parent = workspace;
    u52 = v83;
    local v85 = v83:FindFirstChildOfClass("Humanoid");

    if v85 then
        local v86 = v85:FindFirstChildOfClass("Animator");

        if not v86 then
            v86 = Instance.new("Animator");
            v86.Parent = v85;
        end;

        u53 = v86;
        local v87 = "rbxassetid://72402887392404";
        local Attribute = LocalPlayer:GetAttribute("Active_Class");

        if Attribute then
            local v88 = Class_Data.Get(Attribute);

            if v88 and (v88.AnimationOverrides and v88.AnimationOverrides.idle) then
                v87 = v88.AnimationOverrides.idle;
            end;
        end;

        local Animation = Instance.new("Animation");
        Animation.AnimationId = v87;
        u54 = u53:LoadAnimation(Animation);
        u54.Looped = true;
        u54:Play(0.2);
    end;
end;

local function SwapCloneClass(p89: string) -- Line: 446
    -- upvalues: u52 (ref), Weld_Manager (copy), Class_Data (copy), u53 (ref), u54 (ref)
    if not u52 then
        return;
    end;

    Weld_Manager.Clear(u52, "Class_Prefab");
    local ClassFolder = Class_Data.GetClassFolder(p89);

    if not ClassFolder then
        warn("[SummoningController] Class folder not found for:", p89);

        return;
    end;

    local Prefabs = ClassFolder:FindFirstChild("Prefabs");

    if not Prefabs then
        warn("[SummoningController] Prefabs folder not found for:", p89);

        return;
    end;

    local Holder = Prefabs:FindFirstChild("Holder");

    if not Holder then
        warn("[SummoningController] Holder not found in Prefabs for:", p89);

        return;
    end;

    local v90 = Class_Data.Get(p89);
    local Weld = Weld_Manager.Weld;
    local v91 = {};
    local v92;

    if v90 then
        v92 = v90.WeldOverrides or nil;
    else
        v92 = nil;
    end;

    v91.WeldOverrides = v92;
    local v93;

    if v90 then
        v93 = v90.Motor6D_Overrides or nil;
    else
        v93 = nil;
    end;

    v91.Motor6D_Overrides = v93;
    local v94;

    if v90 then
        v94 = v90.SkipDefaultWelds or false;
    else
        v94 = false;
    end;

    v91.SkipDefaultWelds = v94;
    Weld(Holder, u52, "Class_Prefab", v91);

    if u53 then
        if u54 then
            u54:Stop(0.2);
        end;

        local v95 = not (v90 and (v90.AnimationOverrides and v90.AnimationOverrides.idle)) and "rbxassetid://72402887392404" or v90.AnimationOverrides.idle;
        local Animation = Instance.new("Animation");
        Animation.AnimationId = v95;
        u54 = u53:LoadAnimation(Animation);
        u54.Looped = true;
        u54:Play(0.2);
    end;
end;

local function FormatCelestialLabelText(p96: string, p97: boolean) -- Line: 503
    -- upvalues: u60 (ref)
    local v98 = u60 and u60.Data.ClassMastery;
    local v99 = v98 and v98[p96] and v98[p96].Level;

    if v99 then
        p96 = p96 .. " - Lvl. " .. v99 or p96;
    end;

    if p97 then
        p96 = "2x " .. p96 or p96;
    end;

    return p96;
end;

local function ApplyCelestialFocusVisual(p100, p101) -- Line: 514
    -- upvalues: u60 (ref)
    local Selected = p100:FindFirstChild("Selected");

    if Selected and Selected:IsA("UIGradient") then
        Selected.Enabled = p101;
    end;

    local Attribute = p100:GetAttribute("ClassName");

    if Attribute then
        local v102 = u60 and u60.Data.ClassMastery;
        local v103 = v102 and v102[Attribute] and v102[Attribute].Level;

        if v103 then
            Attribute = Attribute .. " - Lvl. " .. v103 or Attribute;
        end;

        if p101 then
            Attribute = "2x " .. Attribute or Attribute;
        end;

        if p100:IsA("TextLabel") or p100:IsA("TextButton") then
            p100.Text = Attribute;
        else
            local v104 = p100:FindFirstChildWhichIsA("TextLabel");

            if v104 then
                v104.Text = Attribute;
            end;
        end;
    end;

    p100:SetAttribute("IsFocused", p101);
end;

local function RefreshCelestialFocusVisuals() -- Line: 539
    -- upvalues: u46 (copy), ApplyCelestialFocusVisual (copy), u48 (ref)
    local Celestial = u46.Celestial;

    if not Celestial then
        return;
    end;

    for _, v in Celestial do
        ApplyCelestialFocusVisual(v, v:GetAttribute("ClassName") == u48);
    end;
end;

local function UpdateCelestialPityDisplay() -- Line: 550
    -- upvalues: u62 (ref), u60 (ref), SummoningData (copy)
    if not u62 then
        return;
    end;

    u62.Text = string.format("Guaranteed Celestial in: %d/%d", u60 and u60.Data.CelestialPityCounter or 0, SummoningData.CELESTIAL_PITY_CAP or 200);
end;

local function HandleCelestialClick(p105: string) -- Line: 559
    -- upvalues: u75 (ref), u9 (ref), u48 (ref), RefreshCelestialFocusVisuals (copy)
    if not u75 then
        return;
    end;

    if u9 then
        return;
    end;

    local v106 = u48 == p105 and "" or p105;
    local v107, v108 = u75:SetCelestialFocus(v106):await();

    if v107 and (v108 and v108.Success) then
        u48 = v106;
        RefreshCelestialFocusVisuals();
    end;
end;

local function SetRarityLabelText(p109: any, p110: string) -- Line: 579
    if p109 then
        p109 = p109.TextLabel;
    end;

    if not p109 then
        return;
    end;

    p109.Text = p110;
    local Text = p109:FindFirstChild("Text");

    if Text and Text:IsA("TextLabel") then
        Text.Text = p110;
    end;
end;

local function PopulateClassList(p111) -- Line: 603
    -- upvalues: SummoningData (copy), u25 (ref), u45 (copy), u46 (copy), Class_Data (copy), u60 (ref), u75 (ref), u9 (ref), u48 (ref), RefreshCelestialFocusVisuals (copy), ApplyCelestialFocusVisual (copy)
    local Rates = SummoningData.GetRates(p111);

    if not u25 then
        warn("[SummoningController] PopulateClassList: classList is nil, Class_List frame not found");

        return;
    end;

    for _, v in SummoningData.RarityOrder do
        local v112 = u45[v];

        if v112 and v112.TextLabel then
            local v113 = Rates[v];

            if v113 then
                local v114 = string.upper(v) .. " - " .. SummoningData.FormatRate(v113);
                local v115;

                if v112 then
                    v115 = v112.TextLabel;
                else
                    v115 = v112;
                end;

                if v115 then
                    v115.Text = v114;
                    local Text = v115:FindFirstChild("Text");

                    if Text and Text:IsA("TextLabel") then
                        Text.Text = v114;
                    end;
                end;

                v112.Button.Visible = true;
            else
                v112.Button.Visible = false;
            end;
        end;
    end;

    for _, v in u46 do
        for _, v2 in v do
            v2:Destroy();
        end;
    end;

    table.clear(u46);
    local Class_Text = u25:FindFirstChild("Class_Text");

    if not Class_Text then
        return;
    end;

    local Class_Text_Button = u25:FindFirstChild("Class_Text_Button");
    local v116 = 0;

    for _, v in SummoningData.RarityOrder do
        local v117 = u45[v];

        if v117 and v117.Button then
            v117.Button.LayoutOrder = v116;
            v116 = v116 + 1;
        end;

        local SummonableClassesByRarity = Class_Data.GetSummonableClassesByRarity(v);
        u46[v] = {};
        local v118 = v == "Celestial";
        local v119 = v;
        local v120 = v118 and Class_Text_Button and Class_Text_Button or Class_Text;

        for _, v2 in SummonableClassesByRarity do
            local v121 = v120:Clone();
            v121.Name = "ClassLabel_" .. v2;
            v121:SetAttribute("ClassName", v2);
            local v122 = u60 and u60.Data.ClassMastery;
            local v123 = v122 and v122[v2] and v122[v2].Level;
            local v124;

            if v123 then
                v124 = v2 .. " - Lvl. " .. v123 or v2;
            else
                v124 = v2;
            end;

            if v121:IsA("TextLabel") or v121:IsA("TextButton") then
                v121.Text = v124;
            else
                local v125 = v121:FindFirstChildWhichIsA("TextLabel");

                if v125 then
                    v125.Text = v124;
                end;
            end;

            v121.Visible = false;
            v121.LayoutOrder = v116;
            v116 = v116 + 1;
            v121.Parent = u25;
            table.insert(u46[v119], v121);

            if v118 then
                if v121:IsA("GuiButton") then
                    v121.Activated:Connect(function() -- Line: 682
                        -- upvalues: v2 (copy), u75 (ref), u9 (ref), u48 (ref), RefreshCelestialFocusVisuals (ref)
                        local v126 = v2;

                        if not u75 then
                            return;
                        end;

                        if u9 then
                            return;
                        end;

                        local v127 = u48 == v126 and "" or v126;
                        local v128, v129 = u75:SetCelestialFocus(v127):await();

                        if v128 and (v129 and v129.Success) then
                            u48 = v127;
                            RefreshCelestialFocusVisuals();
                        end;
                    end);
                else
                    v121.Active = true;
                    v121.InputBegan:Connect(function(p130) -- Line: 688
                        -- upvalues: v2 (copy), u75 (ref), u9 (ref), u48 (ref), RefreshCelestialFocusVisuals (ref)
                        if p130.UserInputType == Enum.UserInputType.MouseButton1 or p130.UserInputType == Enum.UserInputType.Touch then
                            local v131 = v2;

                            if not u75 then
                                return;
                            end;

                            if u9 then
                                return;
                            end;

                            local v132 = u48 == v131 and "" or v131;
                            local v133, v134 = u75:SetCelestialFocus(v132):await();

                            if v133 and (v134 and v134.Success) then
                                u48 = v132;
                                RefreshCelestialFocusVisuals();
                            end;
                        end;
                    end);
                end;

                ApplyCelestialFocusVisual(v121, v2 == u48);
            end;
        end;

        if v118 then
            local v135 = Class_Text:Clone();
            v135.Name = "ClassLabel_CelestialPrompt";

            if v135:IsA("TextLabel") or v135:IsA("TextButton") then
                v135.Text = "Click a Class you want the most!";
                v135.TextColor3 = Color3.fromRGB(0, 255, 0);
            else
                local v136 = v135:FindFirstChildWhichIsA("TextLabel");

                if v136 then
                    v136.Text = "Click a Class you want the most!";
                    v136.TextColor3 = Color3.fromRGB(0, 255, 0);
                end;
            end;

            v135.Visible = false;
            v135.LayoutOrder = v116;
            v116 = v116 + 1;
            v135.Parent = u25;
            table.insert(u46[v119], v135);
        end;
    end;

    Class_Text.Visible = false;

    if Class_Text_Button then
        Class_Text_Button.Visible = false;
    end;
end;

local function ToggleRaritySection(p137: string) -- Line: 728
    -- upvalues: u47 (ref), u46 (copy)
    if u47 and u46[u47] then
        for _, v in u46[u47] do
            v.Visible = false;
        end;
    end;

    if u47 == p137 then
        u47 = nil;

        return;
    end;

    u47 = p137;

    if u46[p137] then
        for _, v in u46[p137] do
            v.Visible = true;
        end;
    end;
end;

local function UpdateClassNameDisplay(p138: string, p139: string) -- Line: 750
    -- upvalues: u21 (ref), u22 (ref), Class_Data (copy), u23 (ref), u60 (ref), u24 (ref)
    if not u21 then
        return;
    end;

    u21.Text = p138;

    for _, child in u21:GetChildren() do
        if child:IsA("UIGradient") then
            child.Enabled = child.Name == p139;
        end;
    end;

    if u22 then
        local v140 = Class_Data.Get(p138);
        u22.Text = v140 and v140.Description or "";

        for _, child in u22:GetChildren() do
            if child:IsA("UIGradient") then
                child.Enabled = false;
            end;
        end;
    end;

    if u23 then
        local v141 = u60 and u60.Data.ClassMastery;
        local v142 = v141 and v141[p138] and v141[p138].Level;
        u23.Text = v142 and "Class Level: " .. v142 or "Class Level: 1";
    end;

    if u24 then
        u24.Text = p139;

        for _, child in u24:GetChildren() do
            if child:IsA("UIGradient") then
                child.Enabled = child.Name == p139;
            end;
        end;
    end;
end;

local function UpdateAspectDisplay(p143: string?) -- Line: 797
    -- upvalues: u74 (ref), u6 (ref), ReplicatedStorage (copy)
    if not u74 then
        return;
    end;

    local v144;

    if p143 == nil then
        v144 = false;
    else
        v144 = p143 ~= "";
    end;

    u74.Text = "Aspect: " .. (v144 and p143 and p143 or "None");
    local RarityGradient = u74:FindFirstChild("RarityGradient");

    if not (RarityGradient and RarityGradient:IsA("UIGradient")) then
        return;
    end;

    local v145;

    if v144 then
        if not u6 then
            local Assets = ReplicatedStorage:FindFirstChild("Assets");

            if Assets then
                Assets = Assets:FindFirstChild("Rarity_Gradients");
            end;

            u6 = Assets;
        end;

        v145 = u6 and u6:FindFirstChild(p143) or nil or nil;
    else
        v145 = nil;
    end;

    if not v145 then
        RarityGradient.Enabled = false;

        return;
    end;

    RarityGradient.Color = v145.Color;
    RarityGradient.Transparency = v145.Transparency;
    RarityGradient.Rotation = v145.Rotation;
    RarityGradient.Enabled = true;
end;

local v146 = 0;
local u147 = {};
local u148 = nil;
local u149 = {
    Blaze = "Basic attacks have a <b>10%</b> chance to <font color=\"#FF6E28\">Ignite</font>, burning for <b>10s</b>. Ignited enemies take <font color=\"#FF6E28\"><b>+25%</b></font> damage from you.",
    Glaciel = "Basic attacks have a <b>2.5%</b> chance to <font color=\"#96E6FF\">Freeze</font> an enemy for <b>4s</b>. Striking a frozen foe can <font color=\"#96E6FF\">Shatter</font> it for <b>200%</b> damage.",
    Fulmin = "Basic attacks have a <b>10%</b> chance to call a <font color=\"#78C8FF\">Lightning Strike</font>: <b>400%</b> damage in an area and a <b>7s</b> <font color=\"#78C8FF\">Stun</font>. <b>15s</b> cooldown.",
    Aegis = "A successful <font color=\"#FFD75A\">Parry</font> unleashes a radiant nova: <b>250%</b> damage and a <b>3s</b> <font color=\"#FFD75A\">Stun</font> to nearby foes, and empowers you with <font color=\"#FFD75A\"><b>+25%</b></font> damage for <b>5s</b>.",
    Verdant = "Basic attacks have a <b>15%</b> chance to apply <font color=\"#78D24B\">Poison</font>, stacking up to <b>5x</b> for ramping damage over <b>5s</b>.",
    Sanguine = "Your hits have a <b>10%</b> chance to trigger <font color=\"#E82838\">Lifesteal</font> for <b>3s</b>, healing you for <b>10%</b> of the damage dealt each hit. <b>15s</b> cooldown.",
    Umbral = "Critical hits have a <b>35%</b> chance to detonate a <font color=\"#B478E6\">Shadow Burst</font>: <b>150%</b> bonus damage and a <b>1.5s</b> <font color=\"#B478E6\">Stun</font>. <b>3s</b> cooldown.",
    Tempest = "Every <font color=\"#7864F5\">skill cast</font> builds a <font color=\"#7864F5\">Storm</font> stack: <font color=\"#7864F5\"><b>+5%</b></font> skill damage each, up to <font color=\"#7864F5\"><b>+40%</b></font>. At max, your next skill erupts in a <font color=\"#7864F5\">Lightning Storm</font> for <b>200%</b> damage and resets the charge.",
    Phantom = "Dodging leaves a <font color=\"#78EBDC\">Shadow Clone</font> that detonates for <b>150%</b> damage. If the clone lands a kill, gain <font color=\"#78EBDC\"><b>+25%</b></font> overall damage for <b>5s</b> (refreshes, doesn\'t stack).",
    Ruin = "Basic attacks stack <font color=\"#D2703C\">Sunder</font> on a single enemy: up to <font color=\"#D2703C\"><b>+75%</b></font> damage taken. Every hit benefits, <font color=\"#D2703C\">skills included</font>, but only basic attacks build it, and striking a new enemy resets the mark.",
    Alacrity = "Basic attacks have a <b>20%</b> chance to enter a <b>10s</b> <font color=\"#82D7FA\">Haste</font> window: <font color=\"#82D7FA\"><b>+60%</b></font> attack speed. <b>7s</b> cooldown, beginning after the buff ends."
};

local function UpdateRarityRateLabels(p150) -- Line: 590
    -- upvalues: SummoningData (copy), u45 (copy)
    local Rates = SummoningData.GetRates(p150);

    for _, v in SummoningData.RarityOrder do
        local v151 = u45[v];

        if v151 and v151.TextLabel then
            local v152 = Rates[v];

            if v152 then
                local v153 = string.upper(v) .. " - " .. SummoningData.FormatRate(v152);

                if v151 then
                    v151 = v151.TextLabel;
                end;

                if v151 then
                    v151.Text = v153;
                    local Text = v151:FindFirstChild("Text");

                    if Text and Text:IsA("TextLabel") then
                        Text.Text = v153;
                    end;
                end;
            end;
        end;
    end;
end;

local u154 = { "Blaze", "Glaciel", "Fulmin", "Aegis", "Verdant", "Sanguine", "Umbral", "Tempest", "Phantom", "Ruin", "Alacrity" };

for _, v in MutationData.GetClassWeaponAspectNames() do
    local ClassWeaponAspect = MutationData.GetClassWeaponAspect(v);

    if ClassWeaponAspect then
        v146 = v146 + ClassWeaponAspect.Chance;
    end;
end;

u147.BaseTotal = v146;
u147.HunterTotal = v146 + (MutationData.HUNTER_BONUS_CHANCE or 0);
u147.HunterScale = v146 > 0 and (u147.HunterTotal / v146 or 1) or 1;
local Color3_fromRGB_ret = Color3.fromRGB(248, 241, 219);
local Color3_fromRGB_ret2 = Color3.fromRGB(110, 225, 120);
local Color3_fromRGB_ret3 = Color3.fromRGB(235, 95, 95);

local function PlayerOwnsAspectHunter() -- Line: 873
    -- upvalues: MonetizationList (copy), u60 (ref), LocalPlayer (copy)
    local AspectHunter = MonetizationList.AspectHunter;

    if not (AspectHunter and (AspectHunter.DoesPlayerOwn and u60)) then
        return false;
    end;

    local success, result = pcall(AspectHunter.DoesPlayerOwn, LocalPlayer, u60.Data);

    if success then
        success = result == true;
    end;

    return success;
end;

local function FormatAspectChance(p155: number) -- Line: 882
    local v156 = math.floor((p155 or 0) * 100 * 100 + 0.5) / 100;

    if v156 % 1 == 0 then
        return string.format("%d%%", v156);
    end;

    return string.format("%.2f", v156):gsub("0+$", ""):gsub("%.$", "") .. "%";
end;

local function ApplyAspectRatesToEntry(p157: userdata, p158: boolean) -- Line: 897
    -- upvalues: MutationData (copy), u43 (ref), u147 (copy), FormatAspectChance (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
    local Attribute = p157:GetAttribute("AspectName");

    if not Attribute then
        return;
    end;

    local ClassWeaponAspect = MutationData.GetClassWeaponAspect(Attribute);

    if not ClassWeaponAspect then
        return;
    end;

    local Chance = p157:FindFirstChild("Chance");

    if not Chance then
        return;
    end;

    if u43 == "Gem" then
        Chance.Text = FormatAspectChance(u147.BaseTotal > 0 and ClassWeaponAspect.Chance / u147.BaseTotal or 0);
        Chance.TextColor3 = Color3_fromRGB_ret;

        return;
    end;

    if p158 then
        Chance.Text = FormatAspectChance(ClassWeaponAspect.Chance * u147.HunterScale);
        Chance.TextColor3 = Color3_fromRGB_ret2;

        return;
    end;

    Chance.Text = FormatAspectChance(ClassWeaponAspect.Chance);
    Chance.TextColor3 = Color3_fromRGB_ret;
end;

local function ApplyAspectRatesMode(p159: string) -- Line: 923
    -- upvalues: u43 (ref), MonetizationList (copy), u60 (ref), LocalPlayer (copy), u39 (ref), u40 (ref), u42 (ref), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), u41 (ref), u147 (copy), FormatAspectChance (copy), u36 (ref), ApplyAspectRatesToEntry (copy)
    u43 = p159 == "Gem" and "Gem" or "Spin";
    local AspectHunter = MonetizationList.AspectHunter;
    local v160;

    if AspectHunter and (AspectHunter.DoesPlayerOwn and u60) then
        local v161;
        v160, v161 = pcall(AspectHunter.DoesPlayerOwn, LocalPlayer, u60.Data);

        if v160 then
            v160 = v161 == true;
        end;
    else
        v160 = false;
    end;

    local v162 = u39 and u39:FindFirstChild("Selected");

    if v162 then
        v162.Visible = u43 == "Spin";
    end;

    local v163 = u40 and u40:FindFirstChild("Selected");

    if v163 then
        v163.Visible = u43 == "Gem";
    end;

    if u42 then
        u42.Text = "Aspect Hunter - " .. (v160 and "Active" or "Inactive");
        u42.TextColor3 = v160 and Color3_fromRGB_ret2 or Color3_fromRGB_ret3;
    end;

    if u41 then
        if u43 == "Gem" then
            u41.Text = "Aspect Gems always grant an Aspect. Rates total 100%.";
        else
            local v164 = v160 and u147.HunterTotal or u147.BaseTotal;
            u41.Text = string.format("%s chance for an Aspect. %s no aspect.", FormatAspectChance(v164), FormatAspectChance(1 - v164));
        end;
    end;

    local v165 = u36 and u36:FindFirstChild("ScrollingFrame");

    if v165 then
        for _, child in v165:GetChildren() do
            if child:GetAttribute("AspectName") then
                ApplyAspectRatesToEntry(child, v160);
            end;
        end;
    end;
end;

local function BuildAspectIndex() -- Line: 970
    -- upvalues: u38 (ref), u36 (ref), u154 (copy), MutationData (copy), u149 (copy), Image_Data (copy), u6 (ref), ReplicatedStorage (copy), ApplyAspectRatesMode (copy), u43 (ref)
    if u38 or not u36 then
        return;
    end;

    local ScrollingFrame = u36:FindFirstChild("ScrollingFrame");
    local v166;

    if ScrollingFrame then
        v166 = ScrollingFrame:FindFirstChild("Template");
    else
        v166 = ScrollingFrame;
    end;

    if not v166 then
        return;
    end;

    v166.Visible = false;
    local v167 = 0;

    for _, v in u154 do
        local ClassWeaponAspect = MutationData.GetClassWeaponAspect(v);

        if ClassWeaponAspect then
            local v168 = v166:Clone();
            v168.Name = "Aspect_" .. v;
            v168:SetAttribute("AspectName", v);
            v168.LayoutOrder = v167;
            v167 = v167 + 1;
            local Aspect_Name = v168:FindFirstChild("Aspect_Name");

            if Aspect_Name then
                Aspect_Name.Text = ClassWeaponAspect.DisplayName or v;
            end;

            local Aspect_Description = v168:FindFirstChild("Aspect_Description");

            if Aspect_Description then
                Aspect_Description.RichText = true;
                Aspect_Description.Text = u149[v] or (ClassWeaponAspect.Description or "");
            end;

            local Icon = v168:FindFirstChild("Icon");
            local v169 = Icon and Image_Data.Aspects[v];

            if v169 then
                Icon.Image = v169;
            end;

            local RarityGradient = v168:FindFirstChild("RarityGradient");

            if not u6 then
                local Assets = ReplicatedStorage:FindFirstChild("Assets");

                if Assets then
                    Assets = Assets:FindFirstChild("Rarity_Gradients");
                end;

                u6 = Assets;
            end;

            local v170 = u6 and u6:FindFirstChild(v) or nil;

            if RarityGradient and (RarityGradient:IsA("UIGradient") and v170) then
                RarityGradient.Color = v170.Color;
                RarityGradient.Transparency = v170.Transparency;
                RarityGradient.Rotation = v170.Rotation;
                RarityGradient.Enabled = true;
            end;

            v168.Visible = true;
            v168.Parent = ScrollingFrame;
        end;
    end;

    u38 = true;
    ApplyAspectRatesMode(u43);
end;

local u171 = {
    button = nil,
    frame = nil,
    open = false,
    built = false,
    settingsController = nil,
    settingsService = nil,
    Defs = { {
            Key = "SkipAllSpinWarnings",
            Title = "Skip All Warnings"
        }, {
            Key = "SkipAspectRollWarning",
            Title = "Skip Aspect Roll-Off Warnings"
        }, {
            Key = "SkipMythicRollWarning",
            Title = "Skip Mythic Roll-Off Warnings"
        }, {
            Key = "SkipCelestialRollWarning",
            Title = "Skip Celestial Roll-Off Warnings"
        } },
    OnColor = Color3.fromRGB(133, 106, 57),
    OffColor = Color3.fromRGB(110, 110, 110),
    Tween = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    rows = {}
};

local function IsSkipFilterOn(p172: string) -- Line: 1061
    -- upvalues: u171 (copy)
    local settingsController = u171.settingsController;
    local v173;

    if settingsController == nil then
        v173 = false;
    else
        v173 = settingsController:IsEnabled(p172) == true;
    end;

    return v173;
end;

local function ApplyFilterCheckboxVisual(p174: userdata, p175: boolean, p176: boolean?) -- Line: 1068
    -- upvalues: u171 (copy), TweenService (copy)
    local CheckBox = p174:FindFirstChild("CheckBox");

    if not CheckBox then
        return;
    end;

    local Check = CheckBox:FindFirstChild("Check");

    if not Check then
        return;
    end;

    local v177 = p175 and Check:GetAttribute("On") or Check:GetAttribute("Off");
    local v178 = p175 and u171.OnColor or u171.OffColor;

    if p176 then
        if v177 then
            Check.Position = v177;
        end;

        Check.BackgroundColor3 = v178;

        return;
    end;

    local v179 = {
        BackgroundColor3 = v178
    };

    if v177 then
        v179.Position = v177;
    end;

    TweenService:Create(Check, u171.Tween, v179):Play();
end;

local function RefreshFilterVisuals() -- Line: 1089
    -- upvalues: u171 (copy)
    if not u171.built then
        return;
    end;

    for _, v in u171.Defs do
        local v180 = u171.rows[v.Key];

        if v180 then
            local Key = v.Key;
            local settingsController = u171.settingsController;
            local v181;

            if settingsController == nil then
                v181 = false;
            else
                v181 = settingsController:IsEnabled(Key) == true;
            end;

            local CheckBox = v180:FindFirstChild("CheckBox");

            if CheckBox then
                local Check = CheckBox:FindFirstChild("Check");

                if Check then
                    local v182 = v181 and Check:GetAttribute("On") or Check:GetAttribute("Off");
                    local v183 = v181 and u171.OnColor or u171.OffColor;

                    if v182 then
                        Check.Position = v182;
                    end;

                    Check.BackgroundColor3 = v183;
                end;
            end;
        end;
    end;
end;

local function HandleFilterClick(u184: string) -- Line: 1103
    -- upvalues: u171 (copy), u3 (ref), u5 (ref), ApplyFilterCheckboxVisual (copy)
    local settingsController = u171.settingsController;
    local v185;

    if settingsController == nil then
        v185 = false;
    else
        v185 = settingsController:IsEnabled(u184) == true;
    end;

    local u186 = not v185;

    if u184 == "SkipAllSpinWarnings" and (u186 == true and (u3 and not u3:Prompt({
        Message = "This disables <b>every</b> spin roll-off warning. You\'ll be able to spin off <b>Mythic</b>, <b>Celestial</b>, and <b>aspected</b> classes with no confirmation. Are you sure?",
        ConfirmText = "Disable Warnings",
        DenyText = "Cancel"
    }))) then
        return;
    end;

    if u5 then
        u5:Play("Click");
    end;

    local v187 = u171.rows[u184];

    if v187 then
        ApplyFilterCheckboxVisual(v187, u186, false);
    end;

    local settingsService = u171.settingsService;

    if settingsService then
        task.spawn(function() -- Line: 1123
            -- upvalues: settingsService (copy), u184 (copy), u186 (copy)
            settingsService:SetSetting(u184, u186):await();
        end);
    end;
end;

local function BuildFilterList() -- Line: 1132
    -- upvalues: u171 (copy), HandleFilterClick (copy)
    if u171.built or not u171.frame then
        return;
    end;

    local ScrollingFrame = u171.frame:FindFirstChild("ScrollingFrame");
    local v188;

    if ScrollingFrame then
        v188 = ScrollingFrame:FindFirstChild("Template");
    else
        v188 = ScrollingFrame;
    end;

    if not v188 then
        return;
    end;

    v188.Visible = false;
    local v189 = 0;

    for _, v in u171.Defs do
        local v190 = v188:Clone();
        v190.Name = "Filter_" .. v.Key;
        v190.LayoutOrder = v189;
        v189 = v189 + 1;
        local Title = v190:FindFirstChild("Title");

        if Title then
            Title.Text = v.Title;
        end;

        u171.rows[v.Key] = v190;
        local Key = v.Key;
        local settingsController = u171.settingsController;
        local v191;

        if settingsController == nil then
            v191 = false;
        else
            v191 = settingsController:IsEnabled(Key) == true;
        end;

        local CheckBox = v190:FindFirstChild("CheckBox");
        local v192 = CheckBox and CheckBox:FindFirstChild("Check");

        if v192 then
            local v193 = v191 and v192:GetAttribute("On") or v192:GetAttribute("Off");
            local v194 = v191 and u171.OnColor or u171.OffColor;

            if v193 then
                v192.Position = v193;
            end;

            v192.BackgroundColor3 = v194;
        end;

        local CheckBox2 = v190:FindFirstChild("CheckBox");

        if CheckBox2 and CheckBox2:IsA("GuiButton") then
            CheckBox2.Activated:Connect(function() -- Line: 1156
                -- upvalues: HandleFilterClick (ref), v (copy)
                HandleFilterClick(v.Key);
            end);
        end;

        v190.Visible = true;
        v190.Parent = ScrollingFrame;
    end;

    u171.built = true;
end;

local function GetAllClassNames() -- Line: 1171
    -- upvalues: SummoningData (copy), Class_Data (copy)
    local v195 = {};

    for _, v in SummoningData.RarityOrder do
        for _, v2 in Class_Data.GetSummonableClassesByRarity(v) do
            table.insert(v195, v2);
        end;
    end;

    return v195;
end;

local function AnimateNameRoll(p196: string, p197: number) -- Line: 1183
    -- upvalues: GetAllClassNames (copy), u21 (ref), u11 (ref), Class_Data (copy), UpdateClassNameDisplay (copy)
    local v198 = GetAllClassNames();

    if #v198 == 0 then
        if u21 then
            u21.Text = p196;
        end;

        return;
    end;

    local v199 = 0;

    while v199 < p197 and not u11 do
        local math_clamp_ret = math.clamp(v199 / p197, 0, 1);
        local v200 = math_clamp_ret * 0.31 * math_clamp_ret + 0.04;
        local v201;

        repeat
            v201 = v198[math.random(1, #v198)];
        until v201 ~= p196 or #v198 <= 1;

        UpdateClassNameDisplay(v201, Class_Data.GetRarity(v201) or "Rare");
        task.wait(v200);
        v199 = v199 + v200;
    end;
end;

local function PlayRevealParticles(p202: string) -- Line: 1222
    -- upvalues: u51 (ref)
    if not u51 then
        return;
    end;

    local HumanoidRootPart = u51:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v203 = HumanoidRootPart:FindFirstChild(p202);

    if not (v203 and v203:IsA("BasePart")) then
        return;
    end;

    v203:SetAttribute("Fire", not v203:GetAttribute("Fire"));
end;

local function CheckSpinWarning(p204: string) -- Line: 1238
    -- upvalues: u3 (ref), u171 (copy), u21 (ref), Class_Data (copy), RarityIndex (copy), Mythic2 (copy), Mythic (copy), u73 (ref)
    if not u3 then
        return true;
    end;

    local settingsController = u171.settingsController;
    local v205;

    if settingsController == nil then
        v205 = false;
    else
        v205 = settingsController:IsEnabled("SkipAllSpinWarnings") == true;
    end;

    if v205 then
        return true;
    end;

    local v206 = u21 and u21.Text or "";

    if v206 == "" then
        return true;
    end;

    local Rarity = Class_Data.GetRarity(v206);

    if not Rarity then
        return true;
    end;

    local v207;

    if p204 == "Lucky" then
        v207 = Mythic2;
    else
        v207 = Mythic;
    end;

    local v208 = v207 <= (RarityIndex[Rarity] or 0);
    local v209 = u73 ~= "";

    if v209 then
        local settingsController2 = u171.settingsController;
        local v210;

        if settingsController2 == nil then
            v210 = false;
        else
            v210 = settingsController2:IsEnabled("SkipAspectRollWarning") == true;
        end;

        if v210 then
            v209 = false;
        end;
    end;

    if v208 then
        local v211, v212;

        if Rarity == "Mythic" then
            local settingsController2 = u171.settingsController;
            local v213;

            if settingsController2 == nil then
                v213 = false;
            else
                v213 = settingsController2:IsEnabled("SkipMythicRollWarning") == true;
            end;

            if v213 then
                v208 = false;
            elseif Rarity == "Celestial" then
                v211 = u171.settingsController;

                if v211 == nil then
                    v212 = false;
                else
                    v212 = v211:IsEnabled("SkipCelestialRollWarning") == true;
                end;

                if v212 then
                    v208 = false;
                end;
            end;
        elseif Rarity == "Celestial" then
            v211 = u171.settingsController;

            if v211 == nil then
                v212 = false;
            else
                v212 = v211:IsEnabled("SkipCelestialRollWarning") == true;
            end;

            if v212 then
                v208 = false;
            end;
        end;
    end;

    if not (v208 or v209) then
        return true;
    end;

    local v214;

    if v209 then
        v214 = "<b>" .. u73 .. "</b> " .. (v208 and "<b>" .. Rarity .. "</b> " or "") .. "class <b>" .. v206 .. "</b>";
    else
        v214 = "<b>" .. Rarity .. "</b> class <b>" .. v206 .. "</b>";
    end;

    return u3:Prompt({
        ConfirmText = "Spin",
        DenyText = "Cancel",
        Message = "You are about to spin off your " .. v214 .. "." .. (v209 and " Its <b>" .. u73 .. "</b> aspect will be lost." or "") .. " Are you sure?"
    });
end;

local function SetSpinLabelText(p215: any, p216: string) -- Line: 1301
    if not p215 then
        return;
    end;

    p215.Text = p216;
    local Parent = p215.Parent;

    if Parent and Parent:IsA("TextLabel") then
        Parent.Text = p216;
    end;
end;

local function DoSpin(p217: string, p218: boolean?) -- Line: 1311
    -- upvalues: u9 (ref), u75 (ref), u51 (ref), LocalPlayer (copy), u11 (ref), u12 (ref), u30 (ref), u31 (ref), u52 (ref), TweenService (copy), u13 (ref), RunService (copy), AnimateNameRoll (copy), u50 (ref), SwapCloneClass (copy), UpdateClassNameDisplay (copy), UpdateAspectDisplay (copy), u5 (ref), PlayRevealParticles (copy), u148 (ref)
    if u9 then
        return;
    end;

    if not u75 then
        return;
    end;

    u9 = true;
    local v219, v220 = u75:Spin(p217, p218 or false):await();

    if not (v219 and v220) then
        warn("[SummoningController] Spin failed:", v220);
        u9 = false;

        return;
    end;

    local ClassName = v220.ClassName;
    local Rarity = v220.Rarity;
    local v221 = u51 and u51:FindFirstChild("HumanoidRootPart") and u51.HumanoidRootPart:FindFirstChild("Summoning");

    if v221 then
        v221:SetAttribute("FX_Activate", true);
    end;

    local v222 = (LocalPlayer:GetAttribute("EasterEgg") or math.random() < 0.01) and true or false;
    u11 = false;
    u12 = v222;
    local v223, v224;

    if v222 then
        v223 = nil;
        v224 = nil;
    else
        v224 = u30 and u30.Text or nil;
        v223 = u31 and u31.Text or nil;
        local v225 = u30;

        if v225 then
            v225.Text = "Skip";
            local Parent = v225.Parent;

            if Parent and Parent:IsA("TextLabel") then
                Parent.Text = "Skip";
            end;
        end;

        local v226 = u31;

        if v226 then
            v226.Text = "Skip";
            local Parent = v226.Parent;

            if Parent and Parent:IsA("TextLabel") then
                Parent.Text = "Skip";
            end;
        end;
    end;

    local v227;

    if v222 and u52 then
        local HumanoidRootPart = u52:FindFirstChild("HumanoidRootPart");
        v227 = Instance.new("Highlight");
        v227.FillColor = Color3.new(1, 1, 1);
        v227.OutlineColor = Color3.new(0, 0, 0);
        v227.FillTransparency = 1;
        v227.OutlineTransparency = 1;
        v227.Parent = u52;
        TweenService:Create(v227, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            FillTransparency = 0,
            OutlineTransparency = 0
        }):Play();

        if HumanoidRootPart then
            local u228 = tick();
            u13 = RunService.RenderStepped:Connect(function(p229) -- Line: 1379
                -- upvalues: u228 (copy), HumanoidRootPart (copy)
                local v230 = (tick() - u228) / 2.5;
                local math_clamp_ret = math.clamp(v230, 0, 1);
                local v231 = HumanoidRootPart;
                v231.CFrame = v231.CFrame * CFrame.Angles(0, math.rad((math_clamp_ret * 2130 * math_clamp_ret + 30) * p229), 0);
            end);
        end;
    else
        v227 = nil;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local v232 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(2.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        FieldOfView = 60
    });
    v232:Play();
    AnimateNameRoll(ClassName, 2.5);
    v232:Cancel();

    if u13 then
        u13:Disconnect();
        u13 = nil;
    end;

    if v222 and (u52 and u50) then
        local HumanoidRootPart = u52:FindFirstChild("HumanoidRootPart");
        local v233 = u50:FindFirstChildOfClass("Part") or (u50.PrimaryPart or u50);

        if HumanoidRootPart and v233 then
            local Position = HumanoidRootPart.CFrame.Position;
            local Position2 = v233.CFrame.Position;
            local Vector3_new_ret = Vector3.new(Position2.X - Position.X, 0, Position2.Z - Position.Z);
            local CFrame_lookAt_ret = CFrame.lookAt(Position, Position + (Vector3_new_ret.Magnitude < 0.001 and Vector3.new(0, 0, -1) or Vector3_new_ret));
            local v234 = TweenService:Create(HumanoidRootPart, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                CFrame = CFrame_lookAt_ret
            });
            v234:Play();
            v234.Completed:Wait();
        end;
    end;

    SwapCloneClass(ClassName);
    UpdateClassNameDisplay(ClassName, Rarity);
    UpdateAspectDisplay(v220.Aspect);

    if v220.Aspect and (v220.Aspect ~= "" and u5) then
        u5:Play("GiftReceived");
    end;

    local v235 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FieldOfView = FieldOfView
    });
    v235:Play();

    if v221 then
        v221:SetAttribute("FX_Activate", false);
    end;

    PlayRevealParticles(Rarity);

    if v222 and v227 then
        local v236 = TweenService:Create(v227, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 1,
            OutlineTransparency = 1
        });
        v236:Play();
        v236.Completed:Wait();
        v227:Destroy();
    else
        v235.Completed:Wait();
    end;

    if not v222 then
        local v237 = v224 and u30;

        if v237 then
            v237.Text = v224;
            local Parent = v237.Parent;

            if Parent and Parent:IsA("TextLabel") then
                Parent.Text = v224;
            end;
        end;

        local v238 = v223 and u31;

        if v238 then
            v238.Text = v223;
            local Parent = v238.Parent;

            if Parent and Parent:IsA("TextLabel") then
                Parent.Text = v223;
            end;
        end;
    end;

    u11 = false;
    u12 = false;
    UpdateSpinCounts();
    u148();
    local LocalPlayer2 = game:GetService("Players").LocalPlayer;

    if LocalPlayer2 then
        LocalPlayer2:SetAttribute("OnboardingSpinCount", (LocalPlayer2:GetAttribute("OnboardingSpinCount") or 0) + 1);
    end;

    u9 = false;
end;

function UpdateSpinCounts()
    -- upvalues: u75 (ref), u28 (ref), u29 (ref), u30 (ref), u10 (ref)
    if not u75 then
        return;
    end;

    local v239, v240 = u75:GetSpinCounts():await();

    if v239 and v240 then
        if u28 then
            u28.Text = v240.Normal .. " Spins";
        end;

        if u29 then
            u29.Text = v240.Lucky .. " Spins";
        end;

        if v240.Normal > 0 then
            local v241 = u30;

            if v241 then
                v241.Text = "Normal Spin";
                local Parent = v241.Parent;

                if Parent and Parent:IsA("TextLabel") then
                    Parent.Text = "Normal Spin";
                end;
            end;

            u10 = false;

            return;
        end;

        local v242 = u30;
        local v243 = "1 Spin - " .. 1500 .. " Coins";

        if v242 then
            v242.Text = v243;
            local Parent = v242.Parent;

            if Parent and Parent:IsA("TextLabel") then
                Parent.Text = v243;
            end;
        end;

        u10 = true;
    end;
end;

local function GetNextSlotCostLabel(p244: number) -- Line: 1530
    return p244 == 0 and "1k Coins" or (p244 == 1 and "1.5k Coins" or (p244 == 2 and "15k Coins" or "134 R$"));
end;

local function ApplySlotStroke(p245: userdata, p246: boolean) -- Line: 1546
    local Background = p245:FindFirstChild("Background");

    if Background then
        Background = Background:FindFirstChild("Stroke");
    end;

    if Background then
        for _, child in Background:GetChildren() do
            if child:IsA("UIGradient") then
                if child.Name == "Selected" then
                    child.Enabled = p246;
                elseif child.Name == "Default" then
                    child.Enabled = not p246;
                end;
            end;
        end;
    end;

    local SelectedImage = p245:FindFirstChild("SelectedImage");

    if SelectedImage then
        SelectedImage.Visible = p246;
    end;
end;

u148 = function() -- Line: 1571, Name: RefreshSlotList
    -- upvalues: u64 (ref), u65 (ref), u75 (ref), u71 (ref), LocalPlayer (copy), u72 (ref), u73 (ref), u60 (ref), u66 (copy), u67 (copy), u68 (copy), u9 (ref), Class_Data (copy), UpdateClassNameDisplay (copy), UpdateAspectDisplay (copy), SwapCloneClass (copy), u148 (ref), Image_Data (copy), ApplySlotStroke (copy), u69 (ref), u70 (ref)
    if not (u64 and u65) then
        return;
    end;

    if not u75 then
        return;
    end;

    local v247, v248 = u75:GetSlotData():await();

    if not (v247 and v248) then
        return;
    end;

    local v249 = v248.Slots or { "Ronin" };
    local v250 = v248.SlotAspects or {};
    local v251 = v248.SlotLocks or {};
    u71 = v248.ActiveIndex or 1;
    local Attribute = LocalPlayer:GetAttribute("Active_Class");
    local v252 = Attribute == nil and true or v249[u71] == Attribute;
    u72 = v251[u71] == true;
    u73 = v250[u71] or "";
    local v253 = u60 and u60.Data.ClassMastery or {};

    while #u66 > #v249 do
        local table_remove_ret = table.remove(u66);
        local v254 = #u66 + 1;

        if u67[v254] then
            u67[v254]:Disconnect();
            u67[v254] = nil;
        end;

        if u68[v254] then
            u68[v254]:Disconnect();
            u68[v254] = nil;
        end;

        table_remove_ret:Destroy();
    end;

    for i = #u66 + 1, #v249 do
        local v255 = u65:Clone();
        v255.Name = "Slot_" .. i;
        v255.LayoutOrder = i;
        v255.Visible = true;
        v255.Parent = u64;
        u66[i] = v255;
        local Selection_Button = v255:FindFirstChild("Selection_Button");

        if Selection_Button then
            u67[i] = Selection_Button.MouseButton1Click:Connect(function() -- Line: 1643
                -- upvalues: u9 (ref), i (copy), u71 (ref), u75 (ref), Class_Data (ref), UpdateClassNameDisplay (ref), UpdateAspectDisplay (ref), SwapCloneClass (ref), u148 (ref)
                if u9 then
                    return;
                end;

                if i == u71 then
                    return;
                end;

                local v256, v257 = u75:SwitchSlot(i):await();

                if v256 and (v257 and v257.Success) then
                    u71 = i;
                    local ClassName = v257.ClassName;
                    UpdateClassNameDisplay(ClassName, Class_Data.GetRarity(ClassName) or "Rare");
                    UpdateAspectDisplay(v257.Aspect);
                    SwapCloneClass(ClassName);
                    u148();
                end;
            end);
        end;

        local Lock_Button = v255:FindFirstChild("Lock_Button");
        local v258;

        if Lock_Button then
            u68[i] = Lock_Button.MouseButton1Click:Connect(function() -- Line: 1667
                -- upvalues: u9 (ref), u75 (ref), i (copy), u148 (ref)
                if u9 then
                    return;
                end;

                local v259, v260 = u75:ToggleSlotLock(i):await();

                if v259 and (v260 and v260.Success) then
                    u148();
                end;
            end);
            v258 = i;
        else
            v258 = i;
        end;
    end;

    for i, v in v249 do
        local v261 = u66[i];

        if v261 then
            local Class_Name = v261:FindFirstChild("Class_Name");

            if Class_Name then
                Class_Name.Text = v;
            end;

            local Class_Level = v261:FindFirstChild("Class_Level");

            if Class_Level then
                local v262 = v253[v] and v253[v].Level;
                Class_Level.Text = v262 and "Lvl. " .. v262 or "Lvl. 1";
            end;

            local Class_Rarity = v261:FindFirstChild("Class_Rarity");
            local v263;

            if Class_Rarity then
                local v264 = Class_Data.GetRarity(v) or "Rare";
                Class_Rarity.Text = v264;
                v263 = i;

                for _, child in Class_Rarity:GetChildren() do
                    if child:IsA("UIGradient") then
                        child.Enabled = child.Name == v264;
                    end;
                end;
            else
                v263 = i;
            end;

            local Buy_Cover = v261:FindFirstChild("Buy_Cover");

            if Buy_Cover then
                Buy_Cover.Visible = false;
            end;

            local Lock_Button = v261:FindFirstChild("Lock_Button");

            if Lock_Button then
                Lock_Button.Visible = true;
                Lock_Button.Image = v251[v263] and Image_Data.UI.Lock or Image_Data.UI.Unlocked;
            end;

            local Shadow = v261:FindFirstChild("Shadow");

            if Shadow then
                Shadow.Visible = true;
            end;

            local Aspect_Icon = v261:FindFirstChild("Aspect_Icon");

            if Aspect_Icon then
                local v265 = v250[v263];
                local v266;

                if v265 and v265 ~= "" then
                    v266 = Image_Data.Aspects[v265] or nil;
                else
                    v266 = nil;
                end;

                if v266 then
                    Aspect_Icon.Image = v266;
                    Aspect_Icon.Visible = true;
                else
                    Aspect_Icon.Visible = false;
                end;
            end;

            local v267;

            if v252 then
                v267 = v263 == u71;
            else
                v267 = v252;
            end;

            ApplySlotStroke(v261, v267);
        end;
    end;

    if not u69 then
        u69 = u65:Clone();
        u69.Name = "Slot_Buy";
        u69.Visible = true;
        u69.Parent = u64;
        local Class_Name = u69:FindFirstChild("Class_Name");

        if Class_Name then
            Class_Name.Visible = false;
        end;

        local Class_Level = u69:FindFirstChild("Class_Level");

        if Class_Level then
            Class_Level.Visible = false;
        end;

        local Class_Rarity = u69:FindFirstChild("Class_Rarity");

        if Class_Rarity then
            Class_Rarity.Visible = false;
        end;

        local Selection_Button = u69:FindFirstChild("Selection_Button");

        if Selection_Button then
            Selection_Button.Visible = false;
        end;

        local Lock_Button = u69:FindFirstChild("Lock_Button");

        if Lock_Button then
            Lock_Button.Visible = false;
        end;

        local Shadow = u69:FindFirstChild("Shadow");

        if Shadow then
            Shadow.Visible = false;
        end;

        local Aspect_Icon = u69:FindFirstChild("Aspect_Icon");

        if Aspect_Icon then
            Aspect_Icon.Visible = false;
        end;
    end;

    u69.LayoutOrder = #v249 + 1;
    ApplySlotStroke(u69, false);
    local u268 = v248.CoinSlotsPurchased or 0;
    local Buy_Cover = u69:FindFirstChild("Buy_Cover");

    if Buy_Cover then
        Buy_Cover.Visible = true;
        local Cost = Buy_Cover:FindFirstChild("Cost");

        if Cost then
            Cost.Text = u268 == 0 and "1k Coins" or (u268 == 1 and "1.5k Coins" or (u268 == 2 and "15k Coins" or "134 R$"));
        end;

        if u70 then
            u70:Disconnect();
            u70 = nil;
        end;

        local v269 = Buy_Cover:FindFirstChildWhichIsA("ImageButton", true) or Buy_Cover:FindFirstChildWhichIsA("TextButton", true);

        if v269 then
            u70 = v269.MouseButton1Click:Connect(function() -- Line: 1792
                -- upvalues: u9 (ref), u268 (copy), u75 (ref), u148 (ref)
                if u9 then
                    return;
                end;

                if u268 >= 3 then
                    local v270, v271 = u75:PurchaseSlotRobux():await();

                    if not (v270 and (v271 and v271.Success)) then
                        warn("[SummoningController] Robux slot purchase:", v271 and v271.Reason or "failed");
                    end;
                else
                    local v272, v273 = u75:PurchaseSlot():await();

                    if v272 and (v273 and v273.Success) then
                        u148();

                        return;
                    end;

                    warn("[SummoningController] Slot purchase failed:", v273 and v273.Reason or "unknown");
                end;
            end);
        end;
    end;
end;

local function OnOpen() -- Line: 1816
    -- upvalues: u8 (ref), ResolveWorldReferences (copy), FreezePlayer (copy), u58 (ref), u59 (ref), u60 (ref), u48 (ref), PopulateClassList (copy), SummoningData (copy), LocalPlayer (copy), Class_Data (copy), UpdateClassNameDisplay (copy), UpdateAspectDisplay (copy), CreateClone (copy), u56 (ref), u57 (ref), u50 (ref), u148 (ref), u62 (ref)
    if u8 then
        return;
    end;

    if not ResolveWorldReferences() then
        warn("[SummoningController] Cannot open: summoning area models not available");

        return;
    end;

    u8 = true;
    FreezePlayer();

    if u58 then
        u58.Enabled = false;
    end;

    if u59 then
        u59.Enabled = true;
    end;

    if u60 and u60.Data then
        u48 = u60.Data.CelestialFocus or "";
    end;

    PopulateClassList(SummoningData.NormalSpin);
    local v274 = LocalPlayer:GetAttribute("Active_Class") or "Ronin";
    UpdateClassNameDisplay(v274, Class_Data.GetRarity(v274) or "Rare");
    UpdateAspectDisplay(LocalPlayer:GetAttribute("Active_Aspect"));
    CreateClone();
    local workspace_CurrentCamera = workspace.CurrentCamera;
    u56 = workspace_CurrentCamera.CameraType;
    u57 = workspace_CurrentCamera.CFrame;
    local v275 = u50:FindFirstChildOfClass("Part") or (u50:FindFirstChild("Camera") or u50);
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    workspace_CurrentCamera.CFrame = v275.CFrame;
    UpdateSpinCounts();
    u148();

    if not u62 then
        return;
    end;

    u62.Text = string.format("Guaranteed Celestial in: %d/%d", u60 and u60.Data.CelestialPityCounter or 0, SummoningData.CELESTIAL_PITY_CAP or 200);
end;

local function OnClose() -- Line: 1863
    -- upvalues: u8 (ref), u14 (ref), u47 (ref), u46 (copy), DestroyClone (copy), u56 (ref), u59 (ref), u58 (ref), UnfreezePlayer (copy)
    if not u8 then
        return;
    end;

    u8 = false;
    u14 = tick();

    if u47 and u46[u47] then
        for _, v in u46[u47] do
            v.Visible = false;
        end;
    end;

    u47 = nil;
    DestroyClone();
    workspace.CurrentCamera.CameraType = u56 or Enum.CameraType.Custom;

    if u59 then
        u59.Enabled = false;
    end;

    if u58 then
        u58.Enabled = true;
    end;

    UnfreezePlayer();
end;

function v1.Open(p276) -- Line: 1893
    -- upvalues: u8 (ref), u20 (ref), OnOpen (copy)
    if u8 then
        return;
    end;

    if not u20 then
        return;
    end;

    u20:open();
    OnOpen();
end;

function v1.Close(p277) -- Line: 1900
    -- upvalues: u8 (ref), u20 (ref)
    if not u8 then
        return;
    end;

    if not u20 then
        return;
    end;

    u20:close();
end;

function v1.Toggle(p278) -- Line: 1907
    -- upvalues: u8 (ref)
    if u8 then
        p278:Close();

        return;
    end;

    p278:Open();
end;

function v1.IsOpen(p279) -- Line: 1915
    -- upvalues: u8 (ref)
    return u8;
end;

function v1.KnitInit(p280) -- Line: 1921
    -- upvalues: Knit (copy), u19 (ref), u2 (ref), u20 (ref), OnClose (copy), u44 (ref), u26 (ref), u27 (ref), u30 (ref), u31 (ref), u28 (ref), u29 (ref), u21 (ref), u22 (ref), u23 (ref), u24 (ref), u74 (ref), u32 (ref), u33 (ref), u34 (ref), u35 (ref), u36 (ref), u39 (ref), u40 (ref), u41 (ref), u42 (ref), u37 (ref), u171 (copy), u61 (ref), u62 (ref), u63 (ref), u64 (ref), u65 (ref), u25 (ref), SummoningData (copy), u45 (copy), u49 (ref), u50 (ref), u51 (ref), u58 (ref), Lighting (copy), u59 (ref)
    u19 = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("Frames"):FindFirstChild("Classes");

    if not u19 then
        warn("[SummoningController] Classes frame not found in Main.Frames");

        return;
    end;

    u2 = require(script.Parent.UIController);
    u19:SetAttribute("HideHUD", true);
    u20 = u2._cached[u19] or u2.new(u19);
    u20.onClose = OnClose;
    u20.noBlur = true;
    u2.exceptions[u19] = true;
    u44 = u19:FindFirstChild("Exit") or (u19:FindFirstChild("ExitButton") or u19:FindFirstChild("Exit_Button") or (u19:FindFirstChild("Close") or u19:FindFirstChild("CloseButton")));
    local Spins = u19:FindFirstChild("Spins");
    local v281;

    if Spins then
        v281 = Spins:FindFirstChild("Spin");
    else
        v281 = Spins;
    end;

    if v281 then
        u26 = v281:FindFirstChild("Normal");
        u27 = v281:FindFirstChild("Lucky");
    else
        warn("[SummoningController] Classes.Spins.Spin not found, spin buttons unhooked");
    end;

    if u26 then
        local Shadow = u26:FindFirstChild("Shadow");

        if Shadow then
            Shadow = Shadow:FindFirstChild("Text");
        end;

        u30 = Shadow;
    end;

    if u27 then
        local Shadow = u27:FindFirstChild("Shadow");

        if Shadow then
            Shadow = Shadow:FindFirstChild("Text");
        end;

        u31 = Shadow;
    end;

    if Spins then
        u28 = Spins:FindFirstChild("Normal_Amount");
        u29 = Spins:FindFirstChild("Lucky_Amount");
    end;

    u21 = u19:FindFirstChild("Class_Name");
    u22 = u19:FindFirstChild("Class_Description");
    u23 = u19:FindFirstChild("Class_Level");
    u24 = u19:FindFirstChild("Class_Rarity");
    u74 = u19:FindFirstChild("Aspect");

    if Spins then
        Spins = Spins:FindFirstChild("Add");
    end;

    u32 = Spins;
    u33 = u19:FindFirstChild("Spins_Frame");

    if u33 then
        u33.Visible = false;
        local Exit = u33:FindFirstChild("Exit");

        if Exit then
            Exit.Activated:Connect(function() -- Line: 2008
                -- upvalues: u33 (ref), u34 (ref)
                u33.Visible = false;
                u34 = false;
            end);
        end;
    end;

    u35 = u19:FindFirstChild("AspectIndex");
    u36 = u19:FindFirstChild("Aspects");

    if u36 then
        u36.Visible = false;
        u39 = u36:FindFirstChild("SpinRates");
        u40 = u36:FindFirstChild("GemRates");
        u41 = u36:FindFirstChild("SpinTip");
        u42 = u36:FindFirstChild("Gamepass_Status");
        local Exit = u36:FindFirstChild("Exit");

        if Exit then
            Exit.Activated:Connect(function() -- Line: 2029
                -- upvalues: u36 (ref), u37 (ref)
                u36.Visible = false;
                u37 = false;
            end);
        end;
    end;

    for _, child in u19:GetChildren() do
        if child.Name == "Filters" then
            if child:IsA("Frame") then
                u171.frame = child;
            elseif child:IsA("GuiButton") then
                u171.button = child;
            end;
        end;
    end;

    if u171.frame then
        u171.frame.Visible = false;
        local Exit = u171.frame:FindFirstChild("Exit");

        if Exit and Exit:IsA("GuiButton") then
            Exit.Activated:Connect(function() -- Line: 2053
                -- upvalues: u171 (ref)
                u171.frame.Visible = false;
                u171.open = false;
            end);
        end;
    end;

    local Currency = u19:FindFirstChild("Currency");

    if Currency then
        u61 = Currency:FindFirstChild("CurrencyLabel");
    end;

    u62 = u19:FindFirstChild("Celestial_Pity", true);
    u63 = u19:FindFirstChild("Slot_List");

    if u63 then
        u64 = u63:FindFirstChildWhichIsA("ScrollingFrame");
        u65 = u64 and u64:FindFirstChild("Class_Template");

        if u65 then
            u65.Visible = false;
        end;
    end;

    u25 = u19:FindFirstChild("Class_List");

    if not u25 then
        warn("[SummoningController] Class_List not found in Classes frame, rarity buttons will not populate");
    end;

    if u25 then
        for _, v in SummoningData.RarityOrder do
            local v282 = u25:FindFirstChild(v .. "_Button");

            if v282 then
                u45[v] = {
                    Button = v282,
                    TextLabel = v282:FindFirstChild("Shadow") or v282:FindFirstChildWhichIsA("TextLabel")
                };
            end;
        end;
    end;

    u49 = workspace:FindFirstChild("Summoning_Area");

    if u49 then
        u50 = u49:FindFirstChild("Camera_Model");
        u51 = u49:FindFirstChild("Summoning_Location_Model");
    else
        warn("[SummoningController] workspace.Summoning_Area not found");
    end;

    u58 = Lighting:FindFirstChild("Default_DOF");
    u59 = Lighting:FindFirstChild("Summoning_DOF");

    if not u58 then
        warn("[SummoningController] Lighting.Default_DOF not found");
    end;

    if not u59 then
        warn("[SummoningController] Lighting.Summoning_DOF not found");
    end;
end;

function v1.KnitStart(u283) -- Line: 2120
    -- upvalues: u19 (ref), u20 (ref), u75 (ref), Knit (copy), u3 (ref), u4 (ref), u5 (ref), u171 (copy), ApplyFilterCheckboxVisual (copy), MonetizationList (copy), MarketplaceService (copy), Players (copy), u148 (ref), u60 (ref), Registry (copy), u61 (ref), SharedUtils (copy), u62 (ref), SummoningData (copy), u48 (ref), RefreshCelestialFocusVisuals (copy), u38 (ref), ApplyAspectRatesMode (copy), u43 (ref), u8 (ref), u14 (ref), LocalPlayer (copy), u44 (ref), u9 (ref), u47 (ref), u46 (copy), DestroyClone (copy), u56 (ref), u59 (ref), u58 (ref), u2 (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref), u72 (ref), u26 (ref), u12 (ref), u11 (ref), CheckSpinWarning (copy), DoSpin (copy), u10 (ref), u27 (ref), u45 (copy), u32 (ref), u33 (ref), u34 (ref), u35 (ref), u36 (ref), u37 (ref), BuildAspectIndex (copy), u39 (ref), u40 (ref), BuildFilterList (copy), RefreshFilterVisuals (copy), UpdateRarityRateLabels (copy)
    if u19 then
        u19.Visible = false;
    end;

    if u20 then
        u20.isOpen = false;
    end;

    pcall(function() -- Line: 2131
        -- upvalues: u75 (ref), Knit (ref)
        u75 = Knit.GetService("SummoningService");
    end);
    u3 = Knit.GetController("WarningController");
    pcall(function() -- Line: 2139
        -- upvalues: u4 (ref), Knit (ref)
        u4 = Knit.GetController("NotificationController");
    end);
    pcall(function() -- Line: 2144
        -- upvalues: u5 (ref), Knit (ref)
        u5 = Knit.GetController("SoundController");
    end);
    pcall(function() -- Line: 2149
        -- upvalues: u171 (ref), Knit (ref)
        u171.settingsController = Knit.GetController("SettingsController");
    end);
    pcall(function() -- Line: 2152
        -- upvalues: u171 (ref), Knit (ref)
        u171.settingsService = Knit.GetService("SettingsService");
    end);

    if u171.settingsService and u171.settingsService.SettingChanged then
        u171.settingsService.SettingChanged:Connect(function(p284, p285) -- Line: 2160
            -- upvalues: u171 (ref), ApplyFilterCheckboxVisual (ref)
            if u171.rows[p284] then
                ApplyFilterCheckboxVisual(u171.rows[p284], p285 == true, false);
            end;
        end);
    end;

    local u286 = MonetizationList.ClassSlotRobux and MonetizationList.ClassSlotRobux.Id;

    if u286 then
        MarketplaceService.PromptProductPurchaseFinished:Connect(function(p287, p288, p289) -- Line: 2170
            -- upvalues: Players (ref), u286 (copy), u148 (ref)
            if p287 ~= Players.LocalPlayer.UserId then
                return;
            end;

            if p288 ~= u286 then
                return;
            end;

            if not p289 then
                return;
            end;

            task.delay(0.5, function() -- Line: 2176
                -- upvalues: u148 (ref)
                u148();
            end);
        end);
    end;

    u60 = Registry:Get("PlayerData");

    if u60 and u61 then
        u61.Text = SharedUtils.FormatCashString(u60.Data.Currency or 0);

        if u62 then
            u62.Text = string.format("Guaranteed Celestial in: %d/%d", u60 and u60.Data.CelestialPityCounter or 0, SummoningData.CELESTIAL_PITY_CAP or 200);
        end;

        u60:OnChange(function(p290, p291) -- Line: 2193
            -- upvalues: u61 (ref), SharedUtils (ref), u60 (ref), u48 (ref), RefreshCelestialFocusVisuals (ref), u62 (ref), SummoningData (ref), u38 (ref), ApplyAspectRatesMode (ref), u43 (ref)
            if p291[1] == "Currency" then
                u61.Text = SharedUtils.FormatCashString(u60.Data.Currency or 0);

                return;
            end;

            if p291[1] == "NormalSpins" or p291[1] == "LuckySpins" then
                UpdateSpinCounts();

                return;
            end;

            if p291[1] == "CelestialFocus" then
                u48 = u60.Data.CelestialFocus or "";
                RefreshCelestialFocusVisuals();

                return;
            end;

            if p291[1] ~= "CelestialPityCounter" then
                if p291[1] == "PermanentItems" and u38 then
                    ApplyAspectRatesMode(u43);
                end;

                return;
            end;

            if not u62 then
                return;
            end;

            u62.Text = string.format("Guaranteed Celestial in: %d/%d", u60 and u60.Data.CelestialPityCounter or 0, SummoningData.CELESTIAL_PITY_CAP or 200);
        end);
    end;

    task.spawn(function() -- Line: 2218
        -- upvalues: u8 (ref), u14 (ref), LocalPlayer (ref), u283 (copy)
        local v292 = workspace:WaitForChild("Prompts"):WaitForChild("Classes"):FindFirstChildOfClass("ProximityPrompt");

        if not v292 then
            warn("[SummoningController] No ProximityPrompt found inside workspace.Prompts.Classes");

            return;
        end;

        v292.PromptShown:Connect(function() -- Line: 2229
            -- upvalues: u8 (ref), u14 (ref), LocalPlayer (ref), u283 (ref)
            if u8 then
                return;
            end;

            if tick() - u14 < 0.6 then
                return;
            end;

            LocalPlayer:SetAttribute("Disable_ShiftLock", true);
            task.wait(0.3);

            if u8 then
                LocalPlayer:SetAttribute("Disable_ShiftLock", nil);

                return;
            end;

            u283:Open();
        end);
        v292.PromptHidden:Connect(function() -- Line: 2254
        end);
    end);

    if u44 then
        u44.Activated:Connect(function() -- Line: 2261
            -- upvalues: u283 (copy)
            u283:Close();
        end);
    else
        warn("[SummoningController] No Exit button found in Classes frame");
    end;

    LocalPlayer.CharacterAdded:Connect(function() -- Line: 2271
        -- upvalues: u8 (ref), u9 (ref), u14 (ref), u47 (ref), u46 (ref), DestroyClone (ref), u56 (ref), u59 (ref), u58 (ref), u20 (ref), u2 (ref), LocalPlayer (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref)
        if not u8 then
            return;
        end;

        u8 = false;
        u9 = false;
        u14 = 0;

        if u47 and u46[u47] then
            for _, v in u46[u47] do
                v.Visible = false;
            end;
        end;

        u47 = nil;
        DestroyClone();
        workspace.CurrentCamera.CameraType = u56 or Enum.CameraType.Custom;

        if u59 then
            u59.Enabled = false;
        end;

        if u58 then
            u58.Enabled = true;
        end;

        if u20 then
            u20._frame.Visible = false;
            u20.isOpen = false;
            u2.currentWindow = nil;
            u2.update();
        end;

        LocalPlayer:SetAttribute("Disable_ShiftLock", nil);
        u15 = nil;
        u16 = nil;
        u17 = nil;
        u18 = nil;
    end);

    local function GuardActiveSlotLock() -- Line: 2312
        -- upvalues: u72 (ref), u4 (ref)
        if not u72 then
            return true;
        end;

        if u4 then
            u4.Alert("Custom", "This slot is locked. Unlock it to spin.", 3);
        end;

        return false;
    end;

    if u26 then
        u26.Activated:Connect(function() -- Line: 2321
            -- upvalues: u9 (ref), u12 (ref), u11 (ref), u72 (ref), u4 (ref), CheckSpinWarning (ref), DoSpin (ref), u10 (ref)
            if u9 then
                if not u12 then
                    u11 = true;
                end;
            else
                local v293;

                if u72 then
                    if u4 then
                        u4.Alert("Custom", "This slot is locked. Unlock it to spin.", 3);
                        v293 = false;
                    else
                        v293 = false;
                    end;
                else
                    v293 = true;
                end;

                if not v293 then
                    return;
                end;

                if not CheckSpinWarning("Normal") then
                    return;
                end;

                DoSpin("Normal", u10);
            end;
        end);
    end;

    if u27 then
        u27.Activated:Connect(function() -- Line: 2333
            -- upvalues: u9 (ref), u12 (ref), u11 (ref), u72 (ref), u4 (ref), CheckSpinWarning (ref), DoSpin (ref)
            if u9 then
                if not u12 then
                    u11 = true;
                end;
            else
                local v294;

                if u72 then
                    if u4 then
                        u4.Alert("Custom", "This slot is locked. Unlock it to spin.", 3);
                        v294 = false;
                    else
                        v294 = false;
                    end;
                else
                    v294 = true;
                end;

                if not v294 then
                    return;
                end;

                if not CheckSpinWarning("Lucky") then
                    return;
                end;

                DoSpin("Lucky");
            end;
        end);
    end;

    for i, v in u45 do
        v.Button.Activated:Connect(function() -- Line: 2346
            -- upvalues: i (copy), u47 (ref), u46 (ref)
            local v295 = i;

            if u47 and u46[u47] then
                for _, v2 in u46[u47] do
                    v2.Visible = false;
                end;
            end;

            if u47 == v295 then
                u47 = nil;

                return;
            end;

            u47 = v295;

            if u46[v295] then
                for _, v2 in u46[v295] do
                    v2.Visible = true;
                end;
            end;
        end);
    end;

    if u32 and u33 then
        u32.Activated:Connect(function() -- Line: 2353
            -- upvalues: u34 (ref), u33 (ref)
            u34 = not u34;
            u33.Visible = u34;
        end);
    end;

    if u35 and u36 then
        u35.Activated:Connect(function() -- Line: 2362
            -- upvalues: u37 (ref), u38 (ref), BuildAspectIndex (ref), ApplyAspectRatesMode (ref), u43 (ref), u171 (ref), u36 (ref)
            u37 = not u37;

            if u37 then
                if u38 then
                    ApplyAspectRatesMode(u43);
                else
                    BuildAspectIndex();
                end;

                if u171.frame then
                    u171.frame.Visible = false;
                    u171.open = false;
                end;
            end;

            u36.Visible = u37;
        end);
    end;

    if u39 then
        u39.Activated:Connect(function() -- Line: 2385
            -- upvalues: ApplyAspectRatesMode (ref)
            ApplyAspectRatesMode("Spin");
        end);
    end;

    if u40 then
        u40.Activated:Connect(function() -- Line: 2390
            -- upvalues: ApplyAspectRatesMode (ref)
            ApplyAspectRatesMode("Gem");
        end);
    end;

    if u171.button and u171.frame then
        u171.button.Activated:Connect(function() -- Line: 2398
            -- upvalues: u171 (ref), BuildFilterList (ref), RefreshFilterVisuals (ref), u36 (ref), u37 (ref)
            u171.open = not u171.open;

            if u171.open then
                if not u171.built then
                    BuildFilterList();
                end;

                RefreshFilterVisuals();

                if u36 then
                    u36.Visible = false;
                    u37 = false;
                end;
            end;

            u171.frame.Visible = u171.open;
        end);
    end;

    if u19 then
        local NormalRates = u19:FindFirstChild("NormalRates");
        local LuckyRates = u19:FindFirstChild("LuckyRates");

        local function ApplyRateSelection(p296: boolean) -- Line: 2421
            -- upvalues: UpdateRarityRateLabels (ref), SummoningData (ref), NormalRates (copy), LuckyRates (copy)
            UpdateRarityRateLabels(p296 and SummoningData.LuckySpin or SummoningData.NormalSpin);
            local v297 = NormalRates and NormalRates:FindFirstChild("Selected");

            if v297 then
                v297.Visible = not p296;
            end;

            local v298 = LuckyRates and LuckyRates:FindFirstChild("Selected");

            if v298 then
                v298.Visible = p296;
            end;
        end;

        if NormalRates then
            NormalRates.Activated:Connect(function() -- Line: 2434
                -- upvalues: UpdateRarityRateLabels (ref), SummoningData (ref), NormalRates (copy), LuckyRates (copy)
                UpdateRarityRateLabels(SummoningData.NormalSpin);
                local v299 = NormalRates and NormalRates:FindFirstChild("Selected");

                if v299 then
                    v299.Visible = true;
                end;

                local v300 = LuckyRates and LuckyRates:FindFirstChild("Selected");

                if v300 then
                    v300.Visible = false;
                end;
            end);
        end;

        if LuckyRates then
            LuckyRates.Activated:Connect(function() -- Line: 2440
                -- upvalues: UpdateRarityRateLabels (ref), SummoningData (ref), NormalRates (copy), LuckyRates (copy)
                UpdateRarityRateLabels(SummoningData.LuckySpin or SummoningData.NormalSpin);
                local v301 = NormalRates and NormalRates:FindFirstChild("Selected");

                if v301 then
                    v301.Visible = false;
                end;

                local v302 = LuckyRates and LuckyRates:FindFirstChild("Selected");

                if v302 then
                    v302.Visible = true;
                end;
            end);
        end;

        UpdateRarityRateLabels(SummoningData.NormalSpin);
        local v303 = NormalRates and NormalRates:FindFirstChild("Selected");

        if v303 then
            v303.Visible = true;
        end;

        local v304 = LuckyRates and LuckyRates:FindFirstChild("Selected");

        if v304 then
            v304.Visible = false;
        end;
    end;
end;

return v1;