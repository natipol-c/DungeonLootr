--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Black Hurricane
  Path:     game.ReplicatedStorage.Classes.Anti Magic.Skills.Black Hurricane
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:47 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local ProjectileUtil = require(ReplicatedStorage.Globals.Modules.ProjectileUtil);
local u1 = {
    Cooldown = 15,
    DamageMultiplier = 1.3,
    AnimationName = "Ability_1",
    HitboxSize = Vector3.new(25, 25, 35),
    HitboxRange = 35,
    ProjectileName = "Projectile",
    ProjectileDmgMult = 0.37,
    ProjectileSpeed = 30,
    ProjectileLifetime = 1.5,
    ProjectileHitbox = Vector3.new(20, 12, 20),
    SpawnOffset = 5,
    MaxDuration = 2
};

function u1._EnsureAnimation(p2) -- Line: 52
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

function u1._PerformHit(p7) -- Line: 78
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

function u1._LaunchProjectile(p10) -- Line: 102
    -- upvalues: u1 (copy), ProjectileUtil (copy)
    local FXTemplate = p10:GetFXTemplate(u1.ProjectileName);

    if not FXTemplate then
        warn("[Black Hurricane] FX part not found: " .. u1.ProjectileName);

        return;
    end;

    local v11 = p10.Character and p10.Character:FindFirstChild("HumanoidRootPart");

    if not v11 then
        return;
    end;

    local v12 = math.random() * 3.141592653589793 * 2;
    local v13 = v11.CFrame * CFrame.new(0, 0, -u1.SpawnOffset) * CFrame.Angles(0, 0, v12);
    ProjectileUtil.Launch({
        damageInterval = 0.05,
        activateFX = true,
        hitOncePerTarget = true,
        sourcePart = FXTemplate,
        origin = v13,
        direction = v11.CFrame.LookVector,
        speed = u1.ProjectileSpeed,
        lifetime = u1.ProjectileLifetime,
        hitboxSize = u1.ProjectileHitbox,
        damageMultiplier = u1.ProjectileDmgMult,
        classState = p10
    });
end;

function u1.CanActivate(p14) -- Line: 136
    if p14.Is_Attacking then
        return false, "Attacking";
    end;

    if p14.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p14.Is_Dodging then
        return false, "Dodging";
    end;

    if p14.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u15, p16) -- Line: 144
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v17 = u1._EnsureAnimation(u15);

    if not v17 then
        warn("[Black Hurricane] Animation not found");

        return;
    end;

    u15.Is_Using_Skill = true;
    u15.Is_Attacking = true;

    for i, v in u15.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v17:Play(0, 1, 1);
    local u18 = 0;
    local u21 = v17:GetMarkerReachedSignal("hit"):Connect(function(p19) -- Line: 170
        -- upvalues: u18 (ref), u15 (copy), SharedUtils (ref), u1 (ref)
        u18 = u18 + 1;
        local v20 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

        if v20 then
            if u18 == 1 then
                SharedUtils.PlaySoundAt(v20, "power_spin_01", 1);
            elseif u18 == 2 then
                SharedUtils.PlaySoundAt(v20, "power_spin_02", 1);
            elseif u18 == 3 then
                SharedUtils.PlaySoundAt(v20, "power_spin_03", 1);
                SharedUtils.PlaySoundAt(v20, "jojo punch", 1);
            end;
        end;

        if p19 == "" or not p19 then
            p19 = nil;
        end;

        u15:PlayTurnFX(p19);
        u15:ShakeCamera("SkillLight");
        u1._PerformHit(u15);
        u1._LaunchProjectile(u15);
    end);
    v17.Stopped:Once(function() -- Line: 191
        -- upvalues: u21 (ref), u15 (copy)
        if u21 then
            u21:Disconnect();
        end;

        u15.Is_Using_Skill = false;
        u15.Is_Attacking = false;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 198
        -- upvalues: u15 (copy), u21 (ref)
        if u15.Is_Using_Skill then
            u15.Is_Using_Skill = false;
            u15.Is_Attacking = false;
        end;

        if u21 then
            u21:Disconnect();
        end;
    end);
end;

return u1;