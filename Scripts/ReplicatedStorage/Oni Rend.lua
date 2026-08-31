--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Oni Rend
  Path:     game.ReplicatedStorage.Classes.Shinobi.Skills.Oni Rend
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:56 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 12,
    AnimationName = "Ability_4",
    MediumDamage = 1,
    HeavyDamage = 2,
    FinalHit = 4,
    DashSpeed = 80,
    DashDuration = 0.15,
    RegularSFX = "power_spin_03",
    FinalSFX = "claw_slam_01",
    SFXVolume = 0.9,
    ParryAfterHit = 3,
    ParryDuration = 0.6,
    HitboxSize = Vector3.new(20, 12, 20),
    HitboxRange = 20,
    MaxDuration = 2.5
};

function u1._EnsureAnimation(p2) -- Line: 54
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

function u1._PerformHit(p7, p8) -- Line: 80
    -- upvalues: u1 (copy)
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
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(p8, v)));
            v10 = v10 + 1;
        end;
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
    -- upvalues: u1 (copy), Debris (copy), SharedUtils (copy)
    local v14 = u1._EnsureAnimation(u12);

    if not v14 then
        warn("[Oni Rend] Animation not found");

        return;
    end;

    local Character = u12.Character;
    local v15;

    if Character then
        v15 = Character:FindFirstChild("HumanoidRootPart");
    else
        v15 = Character;
    end;

    if not v15 then
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
    local Humanoid = u12.Humanoid;
    local v16 = Humanoid and (Humanoid.MoveDirection.Magnitude > 0 and Humanoid.MoveDirection.Unit) or v15.CFrame.LookVector;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v16 * u1.DashSpeed;
    BodyVelocity.Parent = v15;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
    local u17 = 0;
    local u21 = v14:GetMarkerReachedSignal("hit"):Connect(function(p18) -- Line: 158
        -- upvalues: u17 (ref), u1 (ref), u12 (copy), SharedUtils (ref), Character (copy)
        u17 = u17 + 1;
        local v19 = u17 >= u1.FinalHit;
        local v20 = u12.Character and u12.Character:FindFirstChild("HumanoidRootPart");

        if v20 then
            SharedUtils.PlaySoundAt(v20, v19 and u1.FinalSFX or u1.RegularSFX, u1.SFXVolume);
        end;

        if p18 == "" or not p18 then
            p18 = nil;
        end;

        u12:PlayTurnFX(p18);
        u12:ShakeCamera(v19 and "SkillHeavy" or "Hit");
        u1._PerformHit(u12, v19 and u1.HeavyDamage or u1.MediumDamage);

        if u17 == u1.ParryAfterHit then
            Character:SetAttribute("Parry", true);
            task.delay(u1.ParryDuration, function() -- Line: 179
                -- upvalues: Character (ref)
                if Character then
                    Character:SetAttribute("Parry", false);
                end;
            end);
        end;
    end);
    v14.Stopped:Once(function() -- Line: 188
        -- upvalues: u21 (ref), u12 (copy), Character (copy)
        if u21 then
            u21:Disconnect();
        end;

        u12.Is_Using_Skill = false;
        u12.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 200
        -- upvalues: u12 (copy), u21 (ref), Character (copy)
        if u12.Is_Using_Skill then
            u12.Is_Using_Skill = false;
            u12.Is_Attacking = false;
        end;

        if u21 then
            u21:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
end;

return u1;