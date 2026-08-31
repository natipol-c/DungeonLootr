--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Annihilation Type
  Path:     game.ReplicatedStorage.Classes.Chaotic Fist.Skills.Annihilation Type
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:58 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 4,
    MaxCharges = 3,
    DamageMultiplier = 3,
    AnimationName = "Ability_2",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(20, 20, 30),
    HitboxRange = 30,
    DashSpeed = 70,
    DashDuration = 0.15,
    ParryOnCast = true,
    MaxDuration = 2
};

function u1._EnsureAnimation(p2) -- Line: 45
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

function u1._PerformHit(p7) -- Line: 71
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

function u1.CanActivate(p10) -- Line: 97
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

function u1.Activate(u11, p12) -- Line: 105
    -- upvalues: u1 (copy), SharedUtils (copy), Debris (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Annihilation Type] Animation not found");

        return;
    end;

    local Character = u11.Character;
    local v14;

    if Character then
        v14 = Character:FindFirstChild("HumanoidRootPart");
    else
        v14 = Character;
    end;

    if not v14 then
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
    Character:SetAttribute("Parry", true);
    local u18 = v13:GetMarkerReachedSignal("hit"):Connect(function(p15) -- Line: 135
        -- upvalues: u11 (copy), SharedUtils (ref), u1 (ref), Debris (ref)
        local v16 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v16 then
            SharedUtils.PlaySoundAt(v16, "anime_explode", 1);
        end;

        u11:PlayFX("Ability_4");
        u11:ShakeCamera("SkillHeavy");

        if v16 then
            local Humanoid = u11.Humanoid;
            local v17 = Humanoid and (Humanoid.MoveDirection.Magnitude > 0 and Humanoid.MoveDirection.Unit) or v16.CFrame.LookVector;
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.Name = "SkillDash";
            BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
            BodyVelocity.Velocity = v17 * u1.DashSpeed;
            BodyVelocity.Parent = v16;
            Debris:AddItem(BodyVelocity, u1.DashDuration);
        end;

        u1._PerformHit(u11);
    end);
    local u19 = false;

    local function releaseState() -- Line: 168
        -- upvalues: u19 (ref), u11 (copy)
        if u19 then
            return;
        end;

        u19 = true;
        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;
    end;

    local u20 = v13:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v13.Stopped:Once(function() -- Line: 179
        -- upvalues: u19 (ref), u11 (copy), u18 (ref), u20 (copy), Character (copy)
        if not u19 then
            u19 = true;
            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;
        end;

        if u18 then
            u18:Disconnect();
        end;

        if u20 then
            u20:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 190
        -- upvalues: u19 (ref), u11 (copy), u18 (ref), u20 (copy), Character (copy)
        if not u19 then
            u19 = true;
            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;
        end;

        if u18 then
            u18:Disconnect();
        end;

        if u20 then
            u20:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
end;

return u1;