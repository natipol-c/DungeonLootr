--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Gravity Well
  Path:     game.ReplicatedStorage.Classes.Demonbane.Skills.Gravity Well
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:47 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local RigUtil = require(ReplicatedStorage.Modules.RigUtil);
local u1 = {
    Cooldown = 15,
    AnimationName = "Ability_3",
    WellDistance = 10,
    WellDuration = 5,
    WellPulseInterval = 0.2,
    WellPullRadius = 18,
    WellPullStrength = 40,
    WellPullDuration = 0.15,
    AnchorLifetime = 5.5,
    VisualLifetime = 5,
    ShrinkStart = 4,
    ShrinkDuration = 1,
    FadeOutDelay = 2,
    WellSFX = "Ronan_Spell_01",
    MaxDuration = 2.5
};

local function GetPlacedEffectRemote() -- Line: 56
    -- upvalues: ReplicatedStorage (copy)
    local v2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes");

    if not v2 then
        return nil;
    end;

    local PlacedEffect = v2:FindFirstChild("PlacedEffect");

    if not PlacedEffect then
        PlacedEffect = Instance.new("RemoteEvent");
        PlacedEffect.Name = "PlacedEffect";
        PlacedEffect.Parent = v2;
    end;

    return PlacedEffect;
end;

function u1._EnsureAnimation(p3) -- Line: 69
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    local AnimationName = u1.AnimationName;

    if p3.Animations[AnimationName] then
        return p3.Animations[AnimationName];
    end;

    local v4 = ReplicatedStorage.Classes:FindFirstChild(p3.ClassName);

    if not v4 then
        return nil;
    end;

    local Skill_Animations = v4:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local v5 = Skill_Animations:FindFirstChild(u1.AnimationName);

    if not v5 then
        return nil;
    end;

    local v6 = p3.Humanoid and p3.Humanoid:FindFirstChildOfClass("Animator");

    if not v6 then
        return nil;
    end;

    local v7 = v6:LoadAnimation(v5);
    v7.Priority = Enum.AnimationPriority.Action3;
    v7:Play(0, 0, 0);
    v7:Stop(0);
    p3.Animations[AnimationName] = v7;

    return v7;
end;

local function findEnemiesNearPosition(p8, p9, p10) -- Line: 96
    -- upvalues: RigUtil (copy)
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.ExcludeInstances = { p8.Character };
    local Vector3_new_ret = Vector3.new(p10 * 2, p10 * 2, p10 * 2);
    local v11 = {};

    for _, v in workspace:GetPartBoundsInBox(CFrame.new(p9), Vector3_new_ret, OverlapParams_new_ret) do
        local v12 = v:FindFirstAncestorOfClass("Model");

        if v12 and (not v11[v12] and (RigUtil.IsHittableTarget(v12) and (v12:HasTag("Enemy") and not (v12:HasTag("Ignore_Damage") or v12:GetAttribute("Dead"))))) then
            v11[v12] = true;
        end;
    end;

    return v11;
end;

local function runGravityWell(p13, p14) -- Line: 120
    -- upvalues: u1 (copy), findEnemiesNearPosition (copy), Debris (copy)
    local math_floor_ret = math.floor(u1.WellDuration / u1.WellPulseInterval);

    for i = 1, math_floor_ret do
        if not (p13.Character and (p13.Character.Parent and (p14 and p14.Parent))) then
            break;
        end;

        local Position = p14.Position;

        for i2 in findEnemiesNearPosition(p13, Position, u1.WellPullRadius) do
            local HumanoidRootPart = i2:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart then
                local v15 = Position - HumanoidRootPart.Position;

                if v15.Magnitude >= 1 then
                    local BodyVelocity = Instance.new("BodyVelocity");
                    BodyVelocity.Name = "GravityPull";
                    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                    BodyVelocity.Velocity = v15.Unit * u1.WellPullStrength;
                    BodyVelocity.Parent = HumanoidRootPart;
                    Debris:AddItem(BodyVelocity, u1.WellPullDuration);
                end;
            end;
        end;

        if i < math_floor_ret then
            task.wait(u1.WellPulseInterval);
        end;
    end;
end;

function u1.CanActivate(p16) -- Line: 153
    if p16.Is_Attacking then
        return false, "Attacking";
    end;

    if p16.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p16.Is_Dodging then
        return false, "Dodging";
    end;

    if p16.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u17, p18) -- Line: 161
    -- upvalues: u1 (copy), ReplicatedStorage (copy), Debris (copy), GetPlacedEffectRemote (copy), SharedUtils (copy), runGravityWell (copy)
    local v19 = u1._EnsureAnimation(u17);

    if not v19 then
        warn("[Gravity Well] Animation not found");

        return;
    end;

    local Character = u17.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local v20 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Effects") and ReplicatedStorage.Assets.Effects:FindFirstChild("Blackhole");

    if not v20 then
        warn("[Gravity Well] Blackhole template not found in ReplicatedStorage.Assets.Effects");

        return;
    end;

    u17.Is_Using_Skill = true;
    u17.Is_Attacking = true;

    for i, v in u17.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v19:Play(0, 1, 1);
    local v21 = Character.Position + Character.CFrame.LookVector * u1.WellDistance;
    local Part = Instance.new("Part");
    Part.Name = "GravityWellAnchor";
    Part.Size = Vector3.new(1, 1, 1);
    Part.Transparency = 1;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Position = v21;
    Part.Parent = workspace;
    Debris:AddItem(Part, u1.AnchorLifetime);
    local v22 = GetPlacedEffectRemote();

    if v22 then
        v22:FireAllClients({
            EffectName = "Blackhole",
            Position = v21,
            Lifetime = u1.VisualLifetime,
            ShrinkStart = u1.ShrinkStart,
            ShrinkDuration = u1.ShrinkDuration,
            FadeOutDelay = u1.FadeOutDelay
        });
    end;

    SharedUtils.PlaySoundAt(Part, u1.WellSFX, 1);
    u17:ShakeCamera("SkillLight");
    task.spawn(runGravityWell, u17, Part);
    v19.Stopped:Once(function() -- Line: 232
        -- upvalues: u17 (copy)
        u17.Is_Using_Skill = false;
        u17.Is_Attacking = false;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 238
        -- upvalues: u17 (copy)
        if u17.Is_Using_Skill then
            u17.Is_Using_Skill = false;
            u17.Is_Attacking = false;
        end;
    end);
end;

return u1;