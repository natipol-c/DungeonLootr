--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Cross Slash
  Path:     game.ReplicatedStorage.Classes.Assassin.Skills.Cross Slash
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:59 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 7,
    MaxCharges = 2,
    DamageMultiplier = 1.125,
    AnimationName = "Ability_3",
    Skill_SFX = nil,
    DashSpeed = 70,
    DashDuration = 0.15,
    CastSFX = "Sonido",
    CastVolume = 1,
    ParryDuration = 0.5,
    HitboxSize = Vector3.new(20, 10, 20),
    MaxDuration = 1.4
};

local function resolveDashDirection(p2) -- Line: 61
    local Humanoid = p2.Humanoid;
    local v3 = p2.Character and p2.Character:FindFirstChild("HumanoidRootPart");

    if Humanoid and Humanoid.MoveDirection.Magnitude > 0.1 then
        local MoveDirection = Humanoid.MoveDirection;

        return Vector3.new(MoveDirection.X, 0, MoveDirection.Z).Unit;
    end;

    if not v3 then
        return Vector3.new(0, 0, -1);
    end;

    local LookVector = v3.CFrame.LookVector;

    return Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
end;

function u1._EnsureAnimation(p4) -- Line: 78
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    local AnimationName = u1.AnimationName;

    if p4.Animations[AnimationName] then
        return p4.Animations[AnimationName];
    end;

    local v5 = ReplicatedStorage.Classes:FindFirstChild(p4.ClassName);

    if not v5 then
        return nil;
    end;

    local Skill_Animations = v5:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local v6 = Skill_Animations:FindFirstChild(u1.AnimationName);

    if not v6 then
        return nil;
    end;

    local v7 = p4.Humanoid and p4.Humanoid:FindFirstChildOfClass("Animator");

    if not v7 then
        return nil;
    end;

    local v8 = v7:LoadAnimation(v6);
    v8.Priority = Enum.AnimationPriority.Action3;
    v8:Play(0, 0, 0);
    v8:Stop(0);
    p4.Animations[AnimationName] = v8;

    return v8;
end;

function u1._PerformHit(p9) -- Line: 104
    -- upvalues: u1 (copy)
    local HitboxSize = p9.ClassData.HitboxSize;
    p9.ClassData.HitboxSize = u1.HitboxSize;
    local v10 = p9:Hitbox();
    p9.ClassData.HitboxSize = HitboxSize;
    local v11 = 0;

    for _, v in v10 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p9:ApplyDamage(v, (p9:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v11 = v11 + 1;
        end;
    end;

    return v11;
end;

function u1.CanActivate(p12) -- Line: 127
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

function u1.Activate(u13, p14) -- Line: 135
    -- upvalues: u1 (copy), resolveDashDirection (copy), Debris (copy), SharedUtils (copy)
    local v15 = u1._EnsureAnimation(u13);

    if not v15 then
        warn("[Cross Slash] Animation not found");

        return;
    end;

    local Character = u13.Character;
    local v16;

    if Character then
        v16 = Character:FindFirstChild("HumanoidRootPart");
    else
        v16 = Character;
    end;

    if not v16 then
        return;
    end;

    u13.Is_Using_Skill = true;
    u13.Is_Attacking = true;

    for i, v in u13.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    local v17 = resolveDashDirection(u13);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v17 * u1.DashSpeed;
    BodyVelocity.Parent = v16;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
    SharedUtils.PlaySoundAt(v16, u1.CastSFX, u1.CastVolume);
    Character:SetAttribute("Parry", true);
    task.delay(u1.ParryDuration, function() -- Line: 171
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    v15:Play(0, 1, 1);
    local u19 = v15:GetMarkerReachedSignal("hit"):Connect(function(p18) -- Line: 180
        -- upvalues: u13 (copy), u1 (ref)
        u13:PlayCombatSound(u13.ClassData.SwingSoundFolder or "Ninja", nil, u13.ClassData.SwingVolume or 0.5);

        if p18 == "" or not p18 then
            p18 = nil;
        end;

        u13:PlayTurnFX(p18);
        u13:ShakeCamera("SkillLight");
        u1._PerformHit(u13);
    end);
    v15.Stopped:Once(function() -- Line: 193
        -- upvalues: u19 (ref), u13 (copy), Character (copy)
        if u19 then
            u19:Disconnect();
        end;

        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 203
        -- upvalues: u13 (copy), u19 (ref), Character (copy)
        if u13.Is_Using_Skill then
            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        if u19 then
            u19:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
end;

return u1;