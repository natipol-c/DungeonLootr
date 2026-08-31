--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Shattered Sweep
  Path:     game.ReplicatedStorage.Classes.Oathbreaker.Skills.Shattered Sweep
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:50 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {
    Cooldown = 10,
    DamageMultiplier = 1.67,
    AnimationName = "Ability_1",
    Skill_SFX = nil,
    ParryDuration = 0.6,
    AoEHitboxSize = Vector3.new(20, 15, 20),
    HitboxRange = 20,
    MaxDuration = 2
};

function u1._EnsureAnimation(p2) -- Line: 39
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

function u1._PerformHit(p7) -- Line: 65
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.AoEHitboxSize;
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

function u1.CanActivate(p10) -- Line: 93
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

function u1.Activate(u11, p12) -- Line: 101
    -- upvalues: u1 (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Shattered Sweep] Animation not found");

        return;
    end;

    local Character = u11.Character;

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

    Character:SetAttribute("Parry", true);
    task.delay(u1.ParryDuration, function() -- Line: 125
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    v13:Play(0, 1, 1);
    local u15 = v13:GetMarkerReachedSignal("hit"):Connect(function(p14) -- Line: 136
        -- upvalues: u1 (ref), u11 (copy)
        u11:PlayCombatSound(u1.Skill_SFX or u11.ClassData.SwingSoundFolder or "Flame_Swing", nil, u11.ClassData.SwingVolume or 0.5);
        u11:PlayTurnFX("Random_Slash");
        u11:ShakeCamera("SkillLight");
        u1._PerformHit(u11);
    end);
    v13.Stopped:Once(function() -- Line: 145
        -- upvalues: u15 (ref), u11 (copy), Character (copy)
        if u15 then
            u15:Disconnect();
        end;

        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 157
        -- upvalues: u11 (copy), u15 (ref), Character (copy)
        if u11.Is_Using_Skill then
            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;
        end;

        if u15 then
            u15:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
end;

return u1;