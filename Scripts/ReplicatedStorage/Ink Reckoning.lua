--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Ink Reckoning
  Path:     game.ReplicatedStorage.Classes.Wanderer.Skills.Ink Reckoning
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:58 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 15,
    AnimationName = "Ability_4",
    Skill_SFX = nil,
    SwordDmgMult = 0.7,
    SwordHitboxSize = Vector3.new(20, 10, 25),
    SwordHitboxRange = 25,
    ExplosionDmgMult = 1.5,
    ExplosionHitboxSize = Vector3.new(25, 25, 35),
    ExplosionHitboxRange = 20,
    ExplosionSFX = "lightningcrash",
    MaxDuration = 4
};

function u1._EnsureAnimation(p2) -- Line: 53
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

function u1._PerformHit(p7, p8, p9, p10) -- Line: 80
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = p9;
    p7.ClassData.Range = p10;
    local v11 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;
    local v12 = 0;

    for _, v in v11 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(p8, v)));
            v12 = v12 + 1;
        end;
    end;

    return v12;
end;

function u1.CanActivate(p13) -- Line: 106
    if p13.Is_Attacking then
        return false, "Attacking";
    end;

    if p13.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p13.Is_Dodging then
        return false, "Dodging";
    end;

    if p13.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u14, p15) -- Line: 114
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v16 = u1._EnsureAnimation(u14);

    if not v16 then
        warn("[Ink Reckoning] Animation not found");

        return;
    end;

    local Character = u14.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u14.Is_Using_Skill = true;
    u14.Is_Attacking = true;

    for i, v in u14.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v16:Play(0, 1, 1);
    local u17 = 0;
    local u20 = v16:GetMarkerReachedSignal("hit"):Connect(function(p18) -- Line: 144
        -- upvalues: u17 (ref), u14 (copy), u1 (ref), SharedUtils (ref)
        u17 = u17 + 1;

        if u17 <= 5 then
            u14:PlayCombatSound(u14.ClassData.SwingSoundFolder or "Magic_Swings", nil, u14.ClassData.SwingVolume or 0.5);

            if p18 == "" or not p18 then
                p18 = nil;
            end;

            u14:PlayTurnFX(p18);
            u14:ShakeCamera("Hit");
            u1._PerformHit(u14, u1.SwordDmgMult, u1.SwordHitboxSize, u1.SwordHitboxRange);

            return;
        end;

        local v19 = u14.Character and u14.Character:FindFirstChild("HumanoidRootPart");

        if v19 then
            SharedUtils.PlaySoundAt(v19, u1.ExplosionSFX, 1);
        end;

        if p18 == "" or not p18 then
            p18 = nil;
        end;

        u14:PlayTurnFX(p18);
        u14:ShakeCamera("SkillHeavy");
        u1._PerformHit(u14, u1.ExplosionDmgMult, u1.ExplosionHitboxSize, u1.ExplosionHitboxRange);
    end);
    local u21 = false;

    local function releaseState() -- Line: 179
        -- upvalues: u21 (ref), u14 (copy)
        if u21 then
            return;
        end;

        u21 = true;
        u14.Is_Using_Skill = false;
        u14.Is_Attacking = false;
    end;

    local u22 = v16:GetMarkerReachedSignal("DBreset"):Connect(releaseState);

    local function cleanup() -- Line: 190
        -- upvalues: u20 (ref), u22 (ref), u21 (ref), u14 (copy)
        if u20 then
            u20:Disconnect();
            u20 = nil;
        end;

        if u22 then
            u22:Disconnect();
            u22 = nil;
        end;

        if u21 then
            return;
        end;

        u21 = true;
        u14.Is_Using_Skill = false;
        u14.Is_Attacking = false;
    end;

    v16.Stopped:Once(function() -- Line: 198
        -- upvalues: u20 (ref), u22 (ref), u21 (ref), u14 (copy)
        if u20 then
            u20:Disconnect();
            u20 = nil;
        end;

        if u22 then
            u22:Disconnect();
            u22 = nil;
        end;

        if u21 then
            return;
        end;

        u21 = true;
        u14.Is_Using_Skill = false;
        u14.Is_Attacking = false;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 203
        -- upvalues: u20 (ref), u22 (ref), u21 (ref), u14 (copy)
        if u20 then
            u20:Disconnect();
            u20 = nil;
        end;

        if u22 then
            u22:Disconnect();
            u22 = nil;
        end;

        if u21 then
            return;
        end;

        u21 = true;
        u14.Is_Using_Skill = false;
        u14.Is_Attacking = false;
    end);
end;

return u1;