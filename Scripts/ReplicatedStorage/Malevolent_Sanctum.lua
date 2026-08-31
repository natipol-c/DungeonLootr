--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Malevolent_Sanctum
  Path:     game.ReplicatedStorage.Classes.Cursed King.Skill_Modules.Malevolent_Sanctum
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:45 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local ForgeVFXUtil = require(ReplicatedStorage.Modules.ForgeVFXUtil);
local u1 = nil;
local v3 = {
    init = function(p2) -- Line: 64, Name: init
        -- upvalues: u1 (ref)
        u1 = p2;
    end
};
local CFrame_new_ret = CFrame.new(0, -2.97, 0);
local CFrame_new_ret2 = CFrame.new(0, -15.501, 17.584);
local CFrame_new_ret3 = CFrame.new(0, -2.99, 0);
local u4 = Enum.RenderPriority.Camera.Value + 2;

local function getCutsceneFolder() -- Line: 126
    local v5 = script.Parent and script.Parent.Parent;

    if v5 then
        v5 = v5:FindFirstChild("Cutscene");
    end;

    return v5;
end;

local function beat(u6, p7, u8) -- Line: 132
    task.delay(p7, function() -- Line: 133
        -- upvalues: u6 (copy), u8 (copy)
        if u6.cancelled then
            return;
        end;

        u8();
    end);
end;

local function resolve(p9: userdata?, p10: string) -- Line: 140
    return p9 and p9:FindFirstChild(p10, true) or nil;
end;

local function placeAt(p11: userdata, p12) -- Line: 145
    if not p11:IsA("Model") then
        if p11:IsA("BasePart") then
            p11.CFrame = p12;
        end;

        return;
    end;

    local v13 = not p11.PrimaryPart and p11:FindFirstChildWhichIsA("BasePart");

    if v13 then
        p11.PrimaryPart = v13;
    end;

    p11:PivotTo(p12);
end;

local function setParticles(p14: userdata, p15: boolean) -- Line: 157
    for _, descendant in p14:GetDescendants() do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
            descendant.Enabled = p15;
        end;
    end;
end;

local function tween(u16, u17, u18) -- Line: 165
    -- upvalues: TweenService (copy)
    pcall(function() -- Line: 166
        -- upvalues: TweenService (ref), u16 (copy), u17 (copy), u18 (copy)
        TweenService:Create(u16, TweenInfo.new(u17, Enum.EasingStyle.Linear), u18):Play();
    end);
end;

local function getFootCFrame(p19: userdata, p20) -- Line: 174
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { p19 };
    local v21 = workspace:Raycast(p20.Position, Vector3.new(0, -60, 0), RaycastParams_new_ret);
    local v22;

    if v21 then
        v22 = v21.Position.Y;
    else
        local BoundingBox, v23 = p19:GetBoundingBox();
        v22 = BoundingBox.Position.Y - v23.Y / 2;
    end;

    local Vector3_new_ret = Vector3.new(p20.Position.X, v22, p20.Position.Z);
    local LookVector = p20.LookVector;
    local Vector3_new_ret2 = Vector3.new(LookVector.X, 0, LookVector.Z);

    return CFrame.lookAt(Vector3_new_ret, Vector3_new_ret + (Vector3_new_ret2.Magnitude < 0.001 and Vector3.new(0, 0, -1) or Vector3_new_ret2).Unit);
end;

local function forgeEmitRig(p24: any, p25: userdata?, p26) -- Line: 200
    -- upvalues: ForgeVFXUtil (copy)
    if not (p25 and p25:IsA("PVInstance")) then
        return;
    end;

    local v27 = ForgeVFXUtil.Emit(p25, {
        MaxDistance = (1 / 0),
        StripCameraShake = true,
        CFrame = p26
    });

    if v27 then
        table.insert(p24.forgeClears, v27.Clear);
    end;
end;

local function forgeEmitHost(p28: any, u29: userdata) -- Line: 215
    -- upvalues: ForgeVFXUtil (copy)
    local u30 = ForgeVFXUtil.GetForge().emit(u29);
    local u31 = false;

    local function clear() -- Line: 218
        -- upvalues: u31 (ref), u30 (copy), u29 (copy)
        if u31 then
            return;
        end;

        u31 = true;
        pcall(function() -- Line: 221
            -- upvalues: u30 (ref)
            u30.Clear();
        end);

        if u29.Parent then
            u29:Destroy();
        end;
    end;

    u30.Finished:finally(function() -- Line: 224
        -- upvalues: u29 (copy)
        if u29.Parent then
            u29:Destroy();
        end;
    end);
    table.insert(p28.forgeClears, clear);
end;

local function runCasterCutscene(u32, p33, u34) -- Line: 238
    -- upvalues: Players (copy), RunService (copy), u4 (copy)
    local v35 = script.Parent and script.Parent.Parent;

    if v35 then
        v35 = v35:FindFirstChild("Cutscene");
    end;

    if v35 then
        v35 = v35:FindFirstChild("CameraFrames");
    end;

    local u36;

    if v35 then
        u36 = v35:FindFirstChild("Frames");
    else
        u36 = v35;
    end;

    if not u36 then
        warn("[Malevolent_Sanctum] Cutscene/CameraFrames/Frames missing — skipping camera cutscene");

        return;
    end;

    local FOV = v35:FindFirstChild("FOV");
    local HumanoidRootPart = p33:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u37 = 0;

    for _, child in u36:GetChildren() do
        local v38 = tonumber(child.Name);

        if v38 and u37 < v38 then
            u37 = v38;
        end;
    end;

    if u37 <= 0 then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local LocalPlayer = Players.LocalPlayer;
    local CameraType = workspace_CurrentCamera.CameraType;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    LocalPlayer:SetAttribute("Disable_ShiftLock", true);
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local v39 = LocalPlayer:FindFirstChildOfClass("PlayerGui");
    local u40, u41;

    if v39 then
        u40 = Instance.new("ScreenGui");
        u40.Name = "MalevolentSanctum_Cover";
        u40.IgnoreGuiInset = true;
        u40.ResetOnSpawn = false;
        u40.DisplayOrder = 1000;
        u41 = Instance.new("Frame");
        u41.Size = UDim2.fromScale(1, 1);
        u41.BackgroundColor3 = Color3.new(0, 0, 0);
        u41.BackgroundTransparency = 1;
        u41.BorderSizePixel = 0;
        u41.Parent = u40;
        u40.Parent = v39;
    else
        u41 = nil;
        u40 = nil;
    end;

    local u42 = false;

    local function endCutscene() -- Line: 287
        -- upvalues: u42 (ref), RunService (ref), workspace_CurrentCamera (copy), CameraType (copy), FieldOfView (copy), LocalPlayer (copy), u40 (ref)
        if u42 then
            return;
        end;

        u42 = true;
        RunService:UnbindFromRenderStep("MalevolentSanctum_Cutscene");

        if workspace_CurrentCamera.CameraType == Enum.CameraType.Scriptable then
            workspace_CurrentCamera.CameraType = CameraType or Enum.CameraType.Custom;
        end;

        workspace_CurrentCamera.FieldOfView = FieldOfView;
        LocalPlayer:SetAttribute("Disable_ShiftLock", nil);

        if u40 then
            u40:Destroy();
            u40 = nil;
        end;
    end;

    u32.endCutscene = endCutscene;
    local u43 = 0;
    RunService:UnbindFromRenderStep("MalevolentSanctum_Cutscene");
    RunService:BindToRenderStep("MalevolentSanctum_Cutscene", u4, function(p44) -- Line: 302
        -- upvalues: u32 (copy), HumanoidRootPart (copy), endCutscene (copy), u43 (ref), u37 (ref), u36 (copy), u34 (copy), workspace_CurrentCamera (copy), FOV (copy), u41 (ref)
        if u32.cancelled or not HumanoidRootPart.Parent then
            endCutscene();

            return;
        end;

        u43 = u43 + p44 * 60;
        local math_ceil_ret = math.ceil(u43);

        if u37 < math_ceil_ret then
            endCutscene();

            return;
        end;

        local v45 = u36:FindFirstChild((tostring(math_ceil_ret)));

        if v45 then
            local v46 = HumanoidRootPart;

            if u34 and (u34.Parent and (math_ceil_ret >= 288 and math_ceil_ret <= 476)) then
                v46 = u34;
            end;

            workspace_CurrentCamera.CFrame = v46.CFrame * v45.Value;
            local v47 = FOV and FOV:FindFirstChild((tostring(math_ceil_ret)));

            if v47 then
                workspace_CurrentCamera.FieldOfView = v47.Value;
            end;
        end;

        if u41 then
            local math_abs_ret = math.abs(math_ceil_ret - 288);
            local math_abs_ret2 = math.abs(math_ceil_ret - 477);
            local math_min_ret = math.min(math_abs_ret, math_abs_ret2);
            u41.BackgroundTransparency = math.clamp(math_min_ret / 12, 0, 1);
        end;
    end);
end;

local function runFXTimeline(u48: any, u49, u50: userdata, p51: userdata, u52: userdata, u53: userdata) -- Line: 337
    -- upvalues: CFrame_new_ret (copy), forgeEmitHost (copy), placeAt (copy), CFrame_new_ret2 (copy), TweenService (copy), getFootCFrame (copy), forgeEmitRig (copy), CFrame_new_ret3 (copy), Debris (copy)
    local u54;

    if p51 then
        u54 = p51:FindFirstChild("Aura Shrine", true) or nil;
    else
        u54 = nil;
    end;

    local u55;

    if p51 then
        u55 = p51:FindFirstChild("startaura", true) or nil;
    else
        u55 = nil;
    end;

    local SukunaCutscenePart = p51:FindFirstChild("SukunaCutscenePart");
    local SukunaCutscenePart2 = p51:FindFirstChild("SukunaCutscenePart2");

    local function u57() -- Line: 345
        -- upvalues: u55 (copy), u49 (copy), CFrame_new_ret (ref), u50 (copy), forgeEmitHost (ref), u48 (copy)
        if not u55 then
            return;
        end;

        local Part = Instance.new("Part");
        Part.Name = "StartAuraHost";
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.Transparency = 1;
        Part.Size = Vector3.new(1, 1, 1);
        Part.CFrame = u49 * CFrame_new_ret;
        Part.Parent = u50;
        local v56 = u55:Clone();
        v56.CFrame = CFrame.identity;
        v56.Parent = Part;
        forgeEmitHost(u48, Part);
    end;

    task.delay(6.279999999999999, function() -- Line: 133
        -- upvalues: u48 (copy), u57 (copy)
        if u48.cancelled then
            return;
        end;

        u57();
    end);
    local u58 = nil;

    local function u64() -- Line: 366
        -- upvalues: u54 (copy), placeAt (ref), u49 (copy), CFrame_new_ret2 (ref), u50 (copy), u58 (ref), TweenService (ref)
        if not u54 then
            return;
        end;

        local u59 = u54:Clone();
        placeAt(u59, u49 * CFrame_new_ret2);
        u59.Parent = u50;
        u58 = u59;

        if u59:IsA("Model") and u59.PrimaryPart then
            local PrimaryPart = u59.PrimaryPart;
            local u60 = {
                CFrame = u59.PrimaryPart.CFrame + Vector3.new(0, 22.389, 0)
            };
            local u61 = 1.06;
            pcall(function() -- Line: 166
                -- upvalues: TweenService (ref), PrimaryPart (copy), u61 (copy), u60 (copy)
                TweenService:Create(PrimaryPart, TweenInfo.new(u61, Enum.EasingStyle.Linear), u60):Play();
            end);
        end;

        task.delay(20, function() -- Line: 376
            -- upvalues: u59 (copy), TweenService (ref)
            if not u59.Parent then
                return;
            end;

            if u59:IsA("Model") and u59.PrimaryPart then
                local PrimaryPart = u59.PrimaryPart;
                local u62 = {
                    CFrame = u59.PrimaryPart.CFrame + Vector3.new(0, -20, 0)
                };
                local u63 = 2;
                pcall(function() -- Line: 166
                    -- upvalues: TweenService (ref), PrimaryPart (copy), u63 (copy), u62 (copy)
                    TweenService:Create(PrimaryPart, TweenInfo.new(u63, Enum.EasingStyle.Linear), u62):Play();
                end);
            end;

            task.delay(2.1, function() -- Line: 381
                -- upvalues: u59 (ref)
                if u59.Parent then
                    u59:Destroy();
                end;
            end);
        end);
    end;

    task.delay(5.22, function() -- Line: 133
        -- upvalues: u48 (copy), u64 (copy)
        if u48.cancelled then
            return;
        end;

        u64();
    end);

    local function u68() -- Line: 388
        -- upvalues: u58 (ref), TweenService (ref)
        if not (u58 and u58.Parent) then
            return;
        end;

        local u65 = u58:FindFirstChildWhichIsA("Highlight", true);

        if u65 then
            local u66 = {
                FillTransparency = 1,
                OutlineTransparency = 1
            };
            local u67 = 4.25;
            pcall(function() -- Line: 166
                -- upvalues: TweenService (ref), u65 (copy), u67 (copy), u66 (copy)
                TweenService:Create(u65, TweenInfo.new(u67, Enum.EasingStyle.Linear), u66):Play();
            end);
        end;
    end;

    task.delay(8.6, function() -- Line: 133
        -- upvalues: u48 (copy), u68 (copy)
        if u48.cancelled then
            return;
        end;

        u68();
    end);

    local function u74() -- Line: 400
        -- upvalues: u52 (copy), getFootCFrame (ref), u53 (copy), u49 (copy), u50 (copy), u48 (copy), TweenService (ref)
        local Domain = u52:FindFirstChild("Domain");

        if not Domain then
            warn("[Malevolent_Sanctum] Cutscene/Domain model missing");

            return;
        end;

        local u69 = Domain:Clone();

        for _, descendant in u69:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = true;
                descendant.CanCollide = false;
            elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = true;
            end;
        end;

        u69:PivotTo(getFootCFrame(u53, u49));
        u69.Parent = u50;
        local u70 = u48;

        local function u73() -- Line: 419
            -- upvalues: u69 (copy), TweenService (ref)
            if not u69.Parent then
                return;
            end;

            local shrinedomain = u69:FindFirstChild("shrinedomain");

            if shrinedomain and shrinedomain:IsA("BasePart") then
                local u71 = {
                    Transparency = 1
                };
                local u72 = 1;
                pcall(function() -- Line: 166
                    -- upvalues: TweenService (ref), shrinedomain (copy), u72 (copy), u71 (copy)
                    TweenService:Create(shrinedomain, TweenInfo.new(u72, Enum.EasingStyle.Linear), u71):Play();
                end);
            end;

            task.delay(1, function() -- Line: 425
                -- upvalues: u69 (ref)
                if u69.Parent then
                    u69:Destroy();
                end;
            end);
        end;

        task.delay(9.7, function() -- Line: 133
            -- upvalues: u70 (copy), u73 (copy)
            if u70.cancelled then
                return;
            end;

            u73();
        end);
    end;

    task.delay(7.95, function() -- Line: 133
        -- upvalues: u48 (copy), u74 (copy)
        if u48.cancelled then
            return;
        end;

        u74();
    end);

    local function u77() -- Line: 434
        -- upvalues: forgeEmitRig (ref), u48 (copy), SukunaCutscenePart (copy), u49 (copy), SukunaCutscenePart2 (copy), CFrame_new_ret3 (ref), u53 (copy), Debris (ref)
        forgeEmitRig(u48, SukunaCutscenePart, u49);
        forgeEmitRig(u48, SukunaCutscenePart2, u49 * CFrame_new_ret3);
        local SFX = game:GetService("SoundService"):FindFirstChild("SFX");

        if SFX then
            SFX = SFX:FindFirstChild("CurseKingSlash", true);
        end;

        local v75 = SFX and (SFX:IsA("Sound") and u53:FindFirstChild("HumanoidRootPart"));

        if v75 then
            local v76 = SFX:Clone();
            v76.Parent = v75;
            v76:Play();
            Debris:AddItem(v76, v76.TimeLength > 0 and v76.TimeLength or 5);
        end;
    end;

    task.delay(12.65, function() -- Line: 133
        -- upvalues: u48 (copy), u77 (copy)
        if u48.cancelled then
            return;
        end;

        u77();
    end);
end;

local function playTheme(p78, p79) -- Line: 454
    -- upvalues: Debris (copy)
    local SFX = game:GetService("SoundService"):FindFirstChild("SFX");

    if SFX then
        SFX = SFX:FindFirstChild("Cutscene");
    end;

    if SFX then
        SFX = SFX:FindFirstChild("CursedKing");
    end;

    if not (SFX and SFX:IsA("Sound")) then
        return;
    end;

    local HumanoidRootPart = p79:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v80 = SFX:Clone();
    v80.Name = "MalevolentSanctum_Theme";
    v80.Parent = HumanoidRootPart;
    v80:Play();
    p78.theme = v80;
    Debris:AddItem(v80, (v80.TimeLength > 0 and v80.TimeLength or 16) + 1);
end;

function v3.Activate(p81, p82) -- Line: 477
    -- upvalues: Players (copy), runFXTimeline (copy), playTheme (copy), setParticles (copy), placeAt (copy), runCasterCutscene (copy)
    if not (p81 and p81.Parent) then
        return;
    end;

    local v83 = p82 or p81:GetPivot();
    local v84 = workspace:FindFirstChild("Effects") and workspace.Effects:FindFirstChild(p81.Name);

    if not v84 then
        return;
    end;

    local v85 = script.Parent and script.Parent.Parent;

    if v85 then
        v85 = v85:FindFirstChild("Cutscene");
    end;

    if not v85 then
        warn("[Malevolent_Sanctum] Cutscene folder missing");

        return;
    end;

    local v86 = p81 == Players.LocalPlayer.Character;
    local u87 = {
        cancelled = false,
        forgeClears = {}
    };

    local function teardown() -- Line: 494
        -- upvalues: u87 (copy)
        if u87.cancelled then
            return;
        end;

        u87.cancelled = true;

        if u87.endCutscene then
            u87.endCutscene();
        end;

        if u87.theme then
            pcall(function() -- Line: 498
                -- upvalues: u87 (ref)
                u87.theme:Stop();
                u87.theme:Destroy();
            end);
            u87.theme = nil;
        end;

        for _, v in u87.forgeClears do
            pcall(v);
        end;
    end;

    p81.Destroying:Once(teardown);
    local CurseKing = v85:FindFirstChild("CurseKing");

    if CurseKing then
        runFXTimeline(u87, v83, v84, CurseKing, v85, p81);
    else
        warn("[Malevolent_Sanctum] Cutscene/CurseKing template missing");
    end;

    playTheme(u87, p81);
    task.delay(24, function() -- Line: 133
        -- upvalues: u87 (copy), teardown (copy)
        if u87.cancelled then
            return;
        end;

        teardown();
    end);

    if v86 and not Players.LocalPlayer:GetAttribute("DisableCutscenes") then
        local v88 = nil;
        local SukunaCutscenePart = v85:FindFirstChild("SukunaCutscenePart");
        local v89;

        if SukunaCutscenePart then
            local u90 = SukunaCutscenePart:Clone();
            setParticles(u90, true);
            placeAt(u90, CFrame.new(v83.Position.X, -5000, v83.Position.Z));
            u90.Parent = v84;
            v89 = u90:FindFirstChild("SukunaCamera");

            if v89 then
                if not v89:IsA("BasePart") then
                    v89 = v88;
                end;
            else
                v89 = v88;
            end;

            local function u91() -- Line: 535
                -- upvalues: u90 (copy)
                if u90 and u90.Parent then
                    u90:Destroy();
                end;
            end;

            task.delay(22, function() -- Line: 133
                -- upvalues: u87 (copy), u91 (copy)
                if u87.cancelled then
                    return;
                end;

                u91();
            end);
        else
            v89 = v88;
        end;

        runCasterCutscene(u87, p81, v89);
    end;
end;

return v3;