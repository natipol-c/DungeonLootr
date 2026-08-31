--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PhantomAttackFX
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.PhantomAttackFX
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Modules.SharedUtils);
local Class_Data = require(ReplicatedStorage.Classes.Class_Data);
local Weld_Manager = require(ReplicatedStorage.Globals.Modules.Weld_Manager);
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = { "Assets", "Effects", "Shadow_Clone" };

for _, v in { "Script", "LocalScript", "ModuleScript", "Fire", "Smoke", "Sparkles", "Trail", "Beam", "Sound", "BodyVelocity", "BodyForce", "BodyGyro", "BodyPosition", "LinearVelocity", "AlignPosition", "AlignOrientation", "VectorForce", "BillboardGui", "SurfaceGui", "ProximityPrompt", "ClickDetector", "Highlight", "SelectionBox", "ForceField", "AnimationController", "WeldConstraint" } do
    u1[v] = true;
end;

local function GetShadowCloneTemplate() -- Line: 86
    -- upvalues: ReplicatedStorage (copy), u2 (copy)
    local v3 = ReplicatedStorage;

    for _, v in u2 do
        v3 = v3:FindFirstChild(v);

        if not v3 then
            return nil;
        end;
    end;

    return v3;
end;

local function CloneShadowRig() -- Line: 98
    -- upvalues: ReplicatedStorage (copy), u2 (copy)
    local u4 = ReplicatedStorage;

    for _, v in u2 do
        u4 = u4:FindFirstChild(v);

        if not u4 then
            u4 = nil;
            break;
        end;
    end;

    if not u4 then
        warn("[PhantomAttackFX] Shadow_Clone template not found at RS.Assets.Effects.Shadow_Clone");

        return nil;
    end;

    local success, result = pcall(function() -- Line: 105
        -- upvalues: u4 (copy)
        return u4:Clone();
    end);

    if success and result then
        return result;
    end;

    warn("[PhantomAttackFX] Shadow_Clone clone failed:", result);

    return nil;
end;

local function FilterHolderFX(p5: userdata?, p6: table?) -- Line: 121
    if not p5 then
        return;
    end;

    local FX = p5:FindFirstChild("FX");

    if not FX then
        return;
    end;

    if not p6 or #p6 == 0 then
        return;
    end;

    local v7 = {};

    for _, v in p6 do
        v7[v] = true;
    end;

    for _, child in FX:GetChildren() do
        if not v7[child.Name] then
            child:Destroy();
        end;
    end;
end;

local function AttachClassHolder(p8: userdata, p9: string) -- Line: 142
    -- upvalues: ReplicatedStorage (copy), Class_Data (copy), Weld_Manager (copy)
    local v10 = ReplicatedStorage.Classes:FindFirstChild(p9);

    if not v10 then
        return nil;
    end;

    local Prefabs = v10:FindFirstChild("Prefabs");

    if not Prefabs then
        return nil;
    end;

    local Holder = Prefabs:FindFirstChild("Holder");

    if not Holder then
        return nil;
    end;

    local v11 = Class_Data.Get(p9) or {};

    return Weld_Manager.Weld(Holder, p8, "PhantomClone_Holder", {
        WeldOverrides = v11.WeldOverrides,
        Motor6D_Overrides = v11.Motor6D_Overrides,
        SkipDefaultWelds = v11.SkipDefaultWelds
    });
end;

local function StripClone(p12: userdata) -- Line: 163
    -- upvalues: u1 (copy)
    for _, descendant in p12:GetDescendants() do
        if u1[descendant.ClassName] then
            descendant:Destroy();
        elseif descendant:IsA("Decal") or (descendant:IsA("Texture") or descendant:IsA("SurfaceAppearance")) then
            descendant:Destroy();
        end;
    end;
end;

local function StyleClone(p13: userdata, p14) -- Line: 174
    local v15 = {};

    for _, descendant in p13:GetDescendants() do
        if descendant:IsA("BasePart") then
            if descendant.Name == "HumanoidRootPart" then
                descendant.Anchored = true;
            end;

            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.CastShadow = false;
            descendant.Material = Enum.Material.SmoothPlastic;
            descendant.Color = p14;

            if descendant.Transparency < 1 then
                descendant.Transparency = 0.3;
                table.insert(v15, descendant);
            end;

            local v16 = descendant:FindFirstChildWhichIsA("SpecialMesh") or descendant:FindFirstChildWhichIsA("FileMesh");

            if v16 then
                v16.TextureId = "";
            end;
        end;
    end;

    for _, descendant in p13:GetDescendants() do
        if descendant:IsA("MeshPart") then
            descendant.TextureID = "";
        end;
    end;

    return v15;
end;

local function FindCloneFXParts(p17: userdata) -- Line: 217
    local v18 = {};

    for _, descendant in p17:GetDescendants() do
        if descendant.Name == "FX" and descendant:IsA("Folder") then
            for _, child in descendant:GetChildren() do
                v18[child.Name] = child;
            end;

            return v18;
        end;
    end;

    return v18;
end;

local function EmitFXPart(p19: userdata, p20: number?) -- Line: 235
    local v21 = p20 or 15;

    for _, descendant in p19:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(v21);
        end;
    end;
end;

local function FadeAndDestroy(p22: userdata, p23: table, p24: number) -- Line: 245
    -- upvalues: TweenService (copy), Debris (copy)
    local TweenInfo_new_ret = TweenInfo.new(p24, Enum.EasingStyle.Quad, Enum.EasingDirection.In);

    for _, v in p23 do
        TweenService:Create(v, TweenInfo_new_ret, {
            Transparency = 1
        }):Play();
    end;

    Debris:AddItem(p22, p24 + 0.1);
end;

local function SpawnPhantom(u25) -- Line: 258
    -- upvalues: CloneShadowRig (copy), AttachClassHolder (copy), FilterHolderFX (copy), StripClone (copy), StyleClone (copy), FindCloneFXParts (copy), Debris (copy), ReplicatedStorage (copy), FadeAndDestroy (copy), EmitFXPart (copy)
    local u26 = CloneShadowRig();

    if not u26 then
        return;
    end;

    u26.Name = "PhantomClone";
    local v27 = u25.ClassName or "";
    FilterHolderFX(AttachClassHolder(u26, v27), u25.FXNames);
    StripClone(u26);
    local u28 = StyleClone(u26, u25.Color or Color3.new(1, 1, 1));

    if u26.PrimaryPart and u25.Position then
        u26:PivotTo(u25.Position);
    end;

    local u29 = FindCloneFXParts(u26);
    u26.Parent = workspace;
    local v30 = u26:FindFirstChildOfClass("Humanoid");

    if not v30 then
        Debris:AddItem(u26, 0.1);

        return;
    end;

    v30.EvaluateStateMachine = false;
    local v31 = v30:FindFirstChildOfClass("Animator");

    if not v31 then
        v31 = Instance.new("Animator");
        v31.Parent = v30;
    end;

    local v32 = u25.AnimationName or "Attack_1";
    local v33 = ReplicatedStorage:FindFirstChild("Classes") and ReplicatedStorage.Classes:FindFirstChild(v27);
    local v34;

    if v33 then
        v34 = v33:FindFirstChild("Animations");
    else
        v34 = v33;
    end;

    if v34 then
        v34 = v34:FindFirstChild(v32);
    end;

    if not v34 then
        if v33 then
            v34 = v33:FindFirstChild("Skill_Animations");
        else
            v34 = v33;
        end;

        if v34 then
            v34 = v34:FindFirstChild(v32);
        end;
    end;

    if not v34 then
        warn("[PhantomAttackFX] Animation not found:", v27, v32);
        FadeAndDestroy(u26, u28, u25.FadeDuration or 0.8);

        return;
    end;

    local u35 = v31:LoadAnimation(v34);
    u35.Priority = Enum.AnimationPriority.Action4;

    if not u25.EffectModule or u25.EffectModule == "" then
        local u36 = u25.FXNames or {};
        local u37 = 0;
        local u38 = false;
        u35:GetMarkerReachedSignal("hit"):Connect(function(p39) -- Line: 392
            -- upvalues: u37 (ref), u36 (copy), u29 (copy), EmitFXPart (ref), u25 (copy), u26 (copy), u38 (ref), u35 (copy), FadeAndDestroy (ref), u28 (copy)
            u37 = u37 + 1;

            if not p39 or (p39 == "" or not p39) then
                p39 = u36[u37] or u36[1];
            end;

            if p39 and u29[p39] then
                EmitFXPart(u29[p39]);
            end;

            if u25.SwingSoundFolder then
                u26:FindFirstChild("HumanoidRootPart");
            end;

            if not u38 then
                u38 = true;
                task.delay(0.15, function() -- Line: 416
                    -- upvalues: u26 (ref), u35 (ref), u25 (ref), FadeAndDestroy (ref), u28 (ref)
                    if not (u26 and u26.Parent) then
                        return;
                    end;

                    u35:AdjustSpeed(0.2);
                    task.delay(u25.PauseAtEnd or 0.3, function() -- Line: 419
                        -- upvalues: u26 (ref), FadeAndDestroy (ref), u28 (ref), u25 (ref)
                        if u26 and u26.Parent then
                            FadeAndDestroy(u26, u28, u25.FadeDuration or 0.8);
                        end;
                    end);
                end);
            end;
        end);
        u35.Ended:Connect(function() -- Line: 429
            -- upvalues: u38 (ref), u25 (copy), u26 (copy), FadeAndDestroy (ref), u28 (copy)
            if u38 then
                return;
            end;

            task.delay(u25.PauseAtEnd or 0.3, function() -- Line: 431
                -- upvalues: u26 (ref), FadeAndDestroy (ref), u28 (ref), u25 (ref)
                if u26 and u26.Parent then
                    FadeAndDestroy(u26, u28, u25.FadeDuration or 0.8);
                end;
            end);
        end);
        u35:Play(0, 1, u25.AttackSpeed or 1);

        return;
    end;

    if u25.OwnerUserId then
        u26:SetAttribute("ForgeVFX_ScreenOwner", u25.OwnerUserId);
    end;

    if v33 then
        v33 = v33:FindFirstChild("Skill_Modules");
    end;

    if v33 then
        v33 = v33:FindFirstChild(u25.EffectModule);
    end;

    if v33 then
        local success, result = pcall(require, v33);

        if success and (result and result.Emit) then
            local function emit(p40) -- Line: 350
                -- upvalues: u26 (copy), result (copy)
                if not p40 or p40 == "" then
                    return;
                end;

                if u26.Parent then
                    result.Emit(u26, u26:GetPivot(), p40);
                end;
            end;

            u35:GetMarkerReachedSignal("VFX"):Connect(emit);
            u35:GetMarkerReachedSignal("VFX_" .. 2):Connect(emit);
            u35:GetMarkerReachedSignal("VFX_" .. 3):Connect(emit);
            u35:GetMarkerReachedSignal("VFX_" .. 4):Connect(emit);
        end;
    end;

    local u41 = false;

    local function finish() -- Line: 369
        -- upvalues: u41 (ref), u25 (copy), u26 (copy), FadeAndDestroy (ref), u28 (copy)
        if u41 then
            return;
        end;

        u41 = true;
        task.delay(u25.PauseAtEnd or 0.3, function() -- Line: 372
            -- upvalues: u26 (ref), FadeAndDestroy (ref), u28 (ref), u25 (ref)
            if u26 and u26.Parent then
                FadeAndDestroy(u26, u28, u25.FadeDuration or 0.8);
            end;
        end);
    end;

    u35.Looped = false;
    u35.Ended:Connect(finish);
    task.delay(u25.Lifetime or 4, finish);
    u35:Play(0, 1, u25.AttackSpeed or 1);
end;

return function(p42, p43) -- Line: 444
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), SpawnPhantom (copy)
    local PhantomAttack = ReplicatedStorage.Player.Remotes:WaitForChild("PhantomAttack", 10);

    if PhantomAttack then
        PhantomAttack.OnClientEvent:Connect(function(p44: userdata, p45: any) -- Line: 451
            -- upvalues: LocalPlayer (ref), SpawnPhantom (ref)
            if not p45 then
                return;
            end;

            p45.OwnerUserId = p44 and p44.UserId or nil;
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            if Character and (p45.Position and (p45.Position.Position - Character.Position).Magnitude > 150) then
                return;
            end;

            task.spawn(SpawnPhantom, p45);
        end);

        return;
    end;

    warn("[PhantomAttackFX] PhantomAttack remote not found after 10s");
end;