--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Cero Blast
  Path:     game.ReplicatedStorage.Classes.Vacio.Skills.Cero Blast
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
    Cooldown = 12,
    DamageMultiplier = 4,
    AnimationName = "Ability_2",
    EffectModule = "Cero_Blast",
    HitSFX = "Cero_Phantom",
    HitVolume = 1.5,
    HitboxSize = Vector3.new(20, 20, 40),
    HitboxRange = 35,
    MaxDuration = 3
};

function u1._EnsureAnimation(p2) -- Line: 48
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

function u1._PerformHit(p7) -- Line: 74
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    p7.ClassData.Range = u1.HitboxRange;
    local v8 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;
    local v9 = 0;

    for _, v in v8 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v9 = v9 + 1;
        end;
    end;

    return v9;
end;

function u1.CanActivate(p10) -- Line: 100
    if p10.Is_Attacking then
        return false, "Attacking";
    end;

    if p10.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p10.Is_Dodging then
        return false, "Dodging";
    end;

    if p10.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u11, p12) -- Line: 108
    -- upvalues: u1 (copy), SkillRuntime (copy), SharedUtils (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Cero Blast] Animation not found");

        return;
    end;

    local Character = u11.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u11.Is_Using_Skill = true;
    u11.Is_Attacking = true;

    for i, v in u11.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v13:Play(0, 1, 1);
    local u14 = {};

    local function disconnectAll() -- Line: 135
        -- upvalues: u14 (copy)
        for _, v in u14 do
            v:Disconnect();
        end;

        table.clear(u14);
    end;

    local u15 = false;

    local function releaseState() -- Line: 141
        -- upvalues: u15 (ref), u11 (copy)
        if u15 then
            return;
        end;

        u15 = true;
        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;
    end;

    for _, v in SkillRuntime.BindVFXMarkers(u11, v13, u1.EffectModule, 3) do
        u14[#u14 + 1] = v;
    end;

    u14[#u14 + 1] = v13:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 154
        -- upvalues: u11 (copy), SharedUtils (ref), u1 (ref)
        local v16 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v16 then
            SharedUtils.PlaySoundAt(v16, u1.HitSFX, u1.HitVolume);
        end;

        u11:ShakeCamera("SkillHeavy");
        u1._PerformHit(u11);
    end);
    v13.Stopped:Once(function() -- Line: 165
        -- upvalues: u14 (copy), u15 (ref), u11 (copy)
        for _, v in u14 do
            v:Disconnect();
        end;

        table.clear(u14);

        if u15 then
            return;
        end;

        u15 = true;
        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 170
        -- upvalues: u14 (copy), u15 (ref), u11 (copy)
        for _, v in u14 do
            v:Disconnect();
        end;

        table.clear(u14);

        if u15 then
            return;
        end;

        u15 = true;
        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;
    end);
end;

return u1;