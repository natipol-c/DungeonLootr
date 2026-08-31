--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Ruin Onslaught
  Path:     game.ReplicatedStorage.Classes.Oathbreaker.Skills.Ruin Onslaught
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:49 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {
    Cooldown = 15,
    DamageMultiplier = 1.15,
    BigHitMultiplier = 1.15,
    SmallHitMultiplier = 0.53,
    OnslaughtTicks = 5,
    TickInterval = 0.12,
    AnimationName = "Ability_2",
    Skill_SFX = nil,
    FXFallbackDuration = 3.5,
    HitboxSize = Vector3.new(20, 10, 20),
    MaxDuration = 2.5
};

function u1._EnsureAnimation(p2) -- Line: 50
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

function u1._PerformHit(p7, p8) -- Line: 79
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    local v9 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    local v10 = 0;

    for _, v in v9 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(p8, v)));
            v10 = v10 + 1;
        end;
    end;

    return v10;
end;

function u1.CanActivate(p11) -- Line: 102
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

function u1.Activate(u12, p13) -- Line: 110
    -- upvalues: u1 (copy)
    local v14 = u1._EnsureAnimation(u12);

    if not v14 then
        warn("[Ruin Onslaught] Animation not found");

        return;
    end;

    u12.Is_Using_Skill = true;
    u12.Is_Attacking = true;

    for i, v in u12.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    local u15 = false;
    v14:Play(0, 1, 1);
    local u16 = 0;
    local u18 = v14:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 137
        -- upvalues: u16 (ref), u1 (ref), u12 (copy), u15 (ref)
        u16 = u16 + 1;
        u12:PlayCombatSound(u1.Skill_SFX or (u12.ClassData.SwingSoundFolder or "Flame_Swing"), nil, u12.ClassData.SwingVolume or 0.5);
        u12:PlayTurnFX(p17);
        u12:ShakeCamera("Hit");

        if u16 <= 2 then
            u1._PerformHit(u12, u1.BigHitMultiplier);

            return;
        end;

        if not u15 then
            u12:SetLoopFX("Front_Explosion", true);
            u15 = true;
            task.delay(u1.FXFallbackDuration, function() -- Line: 155
                -- upvalues: u15 (ref), u12 (ref)
                if u15 then
                    u12:SetLoopFX("Front_Explosion", false);
                    u15 = false;
                end;
            end);
        end;

        for i = 1, u1.OnslaughtTicks do
            if i > 1 then
                task.wait(u1.TickInterval);
            end;

            if not u12.Is_Using_Skill then
                break;
            end;

            u1._PerformHit(u12, u1.SmallHitMultiplier);
            local _ = i;
        end;
    end);
    local u19 = v14:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 174
        -- upvalues: u15 (ref), u12 (copy)
        if u15 then
            u12:SetLoopFX("Front_Explosion", false);
            u15 = false;
        end;
    end);
    v14.Stopped:Once(function() -- Line: 182
        -- upvalues: u18 (ref), u19 (ref), u15 (ref), u12 (copy)
        if u18 then
            u18:Disconnect();
        end;

        if u19 then
            u19:Disconnect();
        end;

        if u15 then
            u12:SetLoopFX("Front_Explosion", false);
            u15 = false;
        end;

        u12.Is_Using_Skill = false;
        u12.Is_Attacking = false;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 197
        -- upvalues: u12 (copy), u18 (ref), u19 (ref), u15 (ref)
        if u12.Is_Using_Skill then
            u12.Is_Using_Skill = false;
            u12.Is_Attacking = false;
        end;

        if u18 then
            u18:Disconnect();
        end;

        if u19 then
            u19:Disconnect();
        end;

        if u15 then
            u12:SetLoopFX("Front_Explosion", false);
            u15 = false;
        end;
    end);
end;

return u1;