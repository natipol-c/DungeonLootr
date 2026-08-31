--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Javelin Toss
  Path:     game.ReplicatedStorage.Classes.Vacio.Skills.Javelin Toss
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:47 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local SkillRuntime = require(ServerScriptService.Management.Modules.SkillRuntime);
local u1 = {
    Cooldown = 16,
    AnimationName = "Ability_4",
    EffectModule = "Javelin_Toss",
    JumpSFX = "Sonido",
    JumpVolume = 1,
    HitSFX = "claw4",
    HitVolume = 1.5,
    DamageMultiplier = 4,
    HitboxSize = Vector3.new(30, 40, 40),
    HitboxRange = 40,
    DetonationDelay = 0.4,
    ExplosionSFX = "explosion_1",
    ExplosionVolume = 2,
    LiftSpeed = 0,
    LiftDuration = 0,
    MaxDuration = 3
};

function u1._EnsureAnimation(p2) -- Line: 68
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    local AnimationName = u1.AnimationName;

    if p2.Animations[AnimationName] then
        return p2.Animations[AnimationName];
    end;

    local v3 = ReplicatedStorage.Classes:FindFirstChild(p2.ClassName);

    if not v3 then
        return nil;
    end;

    local Skill_Animations = v3:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local v4 = Skill_Animations:FindFirstChild(u1.AnimationName);

    if not v4 then
        return nil;
    end;

    local v5 = p2.Humanoid and p2.Humanoid:FindFirstChildOfClass("Animator");

    if not v5 then
        return nil;
    end;

    local v6 = v5:LoadAnimation(v4);
    v6.Priority = Enum.AnimationPriority.Action3;
    v6:Play(0, 0, 0);
    v6:Stop(0);
    p2.Animations[AnimationName] = v6;

    return v6;
end;

function u1._PerformHit(p7, p8, p9, p10) -- Line: 96
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = p9;
    p7.ClassData.Range = p10;
    local v11 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;

    for _, v in v11 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(p8, v)));
        end;
    end;
end;

function u1.CanActivate(p12) -- Line: 118
    if p12.Is_Attacking then
        return false, "Attacking";
    end;

    if p12.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p12.Is_Dodging then
        return false, "Dodging";
    end;

    if p12.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u13, p14) -- Line: 126
    -- upvalues: u1 (copy), SkillRuntime (copy), SharedUtils (copy)
    local v15 = u1._EnsureAnimation(u13);

    if not v15 then
        warn("[Javelin Toss] Animation not found");

        return;
    end;

    local Character = u13.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u13.Is_Using_Skill = true;
    u13.Is_Attacking = true;

    for i, v in u13.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v15:Play(0, 1, 1);
    local u16 = nil;

    local function releaseAirHold() -- Line: 154
        -- upvalues: u16 (ref)
        if u16 then
            u16:Destroy();
            u16 = nil;
        end;
    end;

    local u17 = {};

    local function disconnectAll() -- Line: 163
        -- upvalues: u17 (copy)
        for _, v in u17 do
            v:Disconnect();
        end;

        table.clear(u17);
    end;

    local u18 = false;

    local function releaseState() -- Line: 169
        -- upvalues: u18 (ref), u13 (copy)
        if u18 then
            return;
        end;

        u18 = true;
        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;
    end;

    for _, v in SkillRuntime.BindVFXMarkers(u13, v15, u1.EffectModule, 3) do
        u17[#u17 + 1] = v;
    end;

    u17[#u17 + 1] = v15:GetMarkerReachedSignal("jump"):Connect(function() -- Line: 182
        -- upvalues: u13 (copy), u16 (ref), SharedUtils (ref), u1 (ref)
        local v19 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if not v19 then
            return;
        end;

        if u16 then
            return;
        end;

        SharedUtils.PlaySoundAt(v19, u1.JumpSFX, u1.JumpVolume);
        u16 = Instance.new("BodyVelocity");
        u16.Name = "JavelinToss_Lift";
        u16.MaxForce = Vector3.new(100000, 100000, 100000);
        u16.Velocity = Vector3.new(0, u1.LiftSpeed, 0);
        u16.Parent = v19;
        task.delay(u1.LiftDuration, function() -- Line: 194
            -- upvalues: u16 (ref)
            if u16 and u16.Parent then
                u16.Velocity = Vector3.new(0, 0, 0);
            end;
        end);
    end);
    u17[#u17 + 1] = v15:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 202
        -- upvalues: u13 (copy), SharedUtils (ref), u1 (ref), releaseAirHold (copy)
        local v20 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v20 then
            SharedUtils.PlaySoundAt(v20, u1.HitSFX, u1.HitVolume);
            SharedUtils.PlaySoundAt(v20, u1.ExplosionSFX, u1.ExplosionVolume);
        end;

        u13:ShakeCamera("SkillHeavy");
        u1._PerformHit(u13, u1.DamageMultiplier, u1.HitboxSize, u1.HitboxRange);
        task.delay(u1.DetonationDelay, releaseAirHold);
    end);
    v15.Stopped:Once(function() -- Line: 218
        -- upvalues: u17 (copy), u18 (ref), u13 (copy)
        for _, v in u17 do
            v:Disconnect();
        end;

        table.clear(u17);

        if u18 then
            return;
        end;

        u18 = true;
        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 224
        -- upvalues: u17 (copy), u16 (ref), u18 (ref), u13 (copy)
        for _, v in u17 do
            v:Disconnect();
        end;

        table.clear(u17);

        if u16 then
            u16:Destroy();
            u16 = nil;
        end;

        if u18 then
            return;
        end;

        u18 = true;
        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;
    end);
end;

return u1;