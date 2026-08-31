--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Deadeye
  Path:     game.ReplicatedStorage.Classes.Bowman.Skills.Deadeye
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:50 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 10,
    DamageMultiplier = 4,
    AnimationName = "Ability_4",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(20, 10, 40),
    HitboxRange = 40,
    MaxDuration = 4
};

function u1._EnsureAnimation(p2) -- Line: 42
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

function u1._PerformHit(p7) -- Line: 68
    -- upvalues: u1 (copy)
    local v8 = 1 - p7:GetEffectiveStat("CritChance");

    if v8 > 0 then
        p7:ModifyStat("CritChance", v8);
    end;

    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    p7.ClassData.Range = u1.HitboxRange;
    local v9 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;
    local v10 = 0;

    for _, v in v9 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v10 = v10 + 1;
        end;
    end;

    if v8 > 0 then
        p7:ModifyStat("CritChance", -v8);
    end;

    return v10;
end;

function u1.CanActivate(p11) -- Line: 107
    if p11.Is_Attacking then
        return false, "Attacking";
    end;

    if p11.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p11.Is_Dodging then
        return false, "Dodging";
    end;

    if p11.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u12, p13) -- Line: 115
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v14 = u1._EnsureAnimation(u12);

    if not v14 then
        warn("[Deadeye] Animation not found");

        return;
    end;

    local Character = u12.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u12.Is_Using_Skill = true;
    u12.Is_Attacking = true;

    for i, v in u12.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v14:Play(0, 1, 1);
    local u15 = false;
    local u16 = v14:GetMarkerReachedSignal("Charging"):Connect(function() -- Line: 145
        -- upvalues: u15 (ref), u12 (copy), SharedUtils (ref), Character (copy)
        u15 = true;
        u12:SetLoopFX("Charge", true);
        SharedUtils.PlaySoundAt(Character, "magic_black_spell_45_fast", 2);
    end);
    local u18 = v14:GetMarkerReachedSignal("Release"):Connect(function(p17) -- Line: 157
        -- upvalues: u15 (ref), u12 (copy), u1 (ref), SharedUtils (ref), Character (copy)
        if u15 then
            u12:SetLoopFX("Charge", false);
            u15 = false;
        end;

        u12:PlayCombatSound(u1.Skill_SFX or u12.ClassData.SwingSoundFolder or "Bow_Shot", nil, u12.ClassData.SwingVolume or 0.5);
        SharedUtils.PlaySoundAt(Character, "Sieghart_Spell_15", 2);
        u12:PlayTurnFX("Power_Shot");
        u12:ShakeCamera("SkillHeavy");
        u1._PerformHit(u12);
    end);
    local u19 = false;

    local function releaseState() -- Line: 178
        -- upvalues: u19 (ref), u12 (copy)
        if u19 then
            return;
        end;

        u19 = true;
        u12.Is_Using_Skill = false;
        u12.Is_Attacking = false;
    end;

    local u20 = v14:GetMarkerReachedSignal("DBreset"):Connect(releaseState);

    local function teardown() -- Line: 189
        -- upvalues: u19 (ref), u12 (copy), u16 (ref), u18 (ref), u20 (copy), u15 (ref)
        if not u19 then
            u19 = true;
            u12.Is_Using_Skill = false;
            u12.Is_Attacking = false;
        end;

        if u16 then
            u16:Disconnect();
        end;

        if u18 then
            u18:Disconnect();
        end;

        if u20 then
            u20:Disconnect();
        end;

        if u15 then
            u12:SetLoopFX("Charge", false);
            u15 = false;
        end;
    end;

    v14.Stopped:Once(teardown);
    task.delay(u1.MaxDuration, teardown);
end;

return u1;