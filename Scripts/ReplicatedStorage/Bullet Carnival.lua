--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Bullet Carnival
  Path:     game.ReplicatedStorage.Classes.Witch Gunner.Skills.Bullet Carnival
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:53 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {
    Cooldown = 8,
    DamageMultiplier = 1,
    AnimationName = "Ability_2",
    Skill_SFX = nil,
    FX_Name = "Carnival",
    HitboxSize = Vector3.new(35, 17, 35),
    HitboxRange = 0,
    MaxDuration = 1.8
};

function u1._EnsureAnimation(p2) -- Line: 41
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

function u1._PerformHit(p7) -- Line: 67
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

function u1.CanActivate(p10) -- Line: 94
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

function u1.Activate(u11, p12) -- Line: 102
    -- upvalues: u1 (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Bullet Carnival] Animation not found");

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

    local function setFX(p14) -- Line: 124
        -- upvalues: u11 (copy), u1 (ref)
        u11:SetLoopFX(u1.FX_Name, p14);
    end;

    local u15 = v13:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 130
        -- upvalues: u11 (copy), u1 (ref)
        u11:SetLoopFX(u1.FX_Name, true);
    end);
    local u16 = v13:GetMarkerReachedSignal("End"):Connect(function() -- Line: 136
        -- upvalues: u11 (copy), u1 (ref)
        u11:SetLoopFX(u1.FX_Name, false);
    end);
    local u18 = v13:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 142
        -- upvalues: u1 (ref), u11 (copy)
        u11:PlayCombatSound(u1.Skill_SFX or (u11.ClassData.SwingSoundFolder or "Gun_Shots"), nil, u11.ClassData.SwingVolume or 0.5);

        if p17 ~= "" then
            u11:PlayTurnFX(p17);
        end;

        u11:ShakeCamera("Hit");
        u1._PerformHit(u11);
    end);
    local u19 = false;

    local function releaseState() -- Line: 158
        -- upvalues: u19 (ref), u11 (copy)
        if u19 then
            return;
        end;

        u19 = true;
        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;
    end;

    local u20 = v13:GetMarkerReachedSignal("DBreset"):Connect(releaseState);

    local function cleanupAll() -- Line: 169
        -- upvalues: u18 (ref), u15 (ref), u16 (ref), u20 (ref), u11 (copy), u1 (ref), u19 (ref)
        if u18 then
            u18:Disconnect();
            u18 = nil;
        end;

        if u15 then
            u15:Disconnect();
            u15 = nil;
        end;

        if u16 then
            u16:Disconnect();
            u16 = nil;
        end;

        if u20 then
            u20:Disconnect();
            u20 = nil;
        end;

        u11:SetLoopFX(u1.FX_Name, false);

        if u19 then
            return;
        end;

        u19 = true;
        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;
    end;

    v13.Stopped:Once(function() -- Line: 181
        -- upvalues: cleanupAll (copy)
        cleanupAll();
    end);
    task.delay(u1.MaxDuration, function() -- Line: 186
        -- upvalues: cleanupAll (copy)
        cleanupAll();
    end);
end;

return u1;