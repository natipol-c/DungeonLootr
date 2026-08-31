--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Water Wheel
  Path:     game.ReplicatedStorage.Classes.Streamline.Skills.Water Wheel
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:44 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 7,
    DamageMultiplier = 0.68,
    FinisherMultiplier = 2.3,
    AnimationName = "Ability_1",
    EffectModule = "Water_Wheel",
    Skill_SFX = nil,
    DashSpeed = 35,
    DashDuration = 0.4,
    ParryDuration = 1.5,
    HitboxSize = Vector3.new(20, 20, 29),
    HitboxRange = 25,
    OpeningSFX = "power_spin_03",
    FinisherSFX = "claw_slam_01",
    OpeningVolume = 1,
    FinisherVolume = 1.5,
    TotalHits = 5,
    MaxDuration = 2.5
};

function u1._EnsureAnimation(p2) -- Line: 60
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

function u1._PerformHit(p7, p8) -- Line: 86
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

function u1.CanActivate(p11) -- Line: 113
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

function u1.Activate(u12, p13) -- Line: 121
    -- upvalues: u1 (copy), SharedUtils (copy), Debris (copy)
    local v14 = u1._EnsureAnimation(u12);

    if not v14 then
        warn("[Water Wheel] Animation not found");

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

    Character:SetAttribute("Parry", true);
    task.delay(u1.ParryDuration, function() -- Line: 145
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    v14:Play(0, 1, 1);
    local u16 = 0;
    local u19 = v14:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 158
        -- upvalues: u16 (ref), u12 (copy), SharedUtils (ref), u1 (ref)
        u16 = u16 + 1;
        local v18 = u12.Character and u12.Character:FindFirstChild("HumanoidRootPart");

        if u16 == 1 and v18 then
            SharedUtils.PlaySoundAt(v18, u1.OpeningSFX, u1.OpeningVolume);
        end;

        u12:PlayCombatSound(u1.Skill_SFX or (u12.ClassData.SwingSoundFolder or "Water_Swings"), nil, u12.ClassData.SwingVolume or 0.5);

        if u16 >= u1.TotalHits then
            if v18 then
                SharedUtils.PlaySoundAt(v18, u1.FinisherSFX, u1.FinisherVolume);
            end;

            u1._PerformHit(u12, u1.FinisherMultiplier);
        else
            u1._PerformHit(u12, u1.DamageMultiplier);
        end;

        u12:ShakeCamera("Hit");
    end);
    local u22 = v14:GetMarkerReachedSignal("VFX"):Connect(function(p20) -- Line: 192
        -- upvalues: u12 (copy), u1 (ref)
        if not p20 or p20 == "" then
            return;
        end;

        local v21 = u12.Character and u12.Character:FindFirstChild("HumanoidRootPart");

        if not v21 then
            return;
        end;

        u12:PlayEffectModule(u1.EffectModule, "Emit", v21.CFrame, p20);
    end);
    local u26 = v14:GetMarkerReachedSignal("dash"):Connect(function(p23) -- Line: 201
        -- upvalues: u12 (copy), u1 (ref), Debris (ref)
        local v24 = u12.Character and u12.Character:FindFirstChild("HumanoidRootPart");

        if not v24 then
            return;
        end;

        local v25;

        if p23 == "Back" then
            v25 = -v24.CFrame.LookVector;
        else
            v25 = v24.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v25 * u1.DashSpeed;
        BodyVelocity.Parent = v24;
        Debris:AddItem(BodyVelocity, u1.DashDuration);
    end);
    v14.Stopped:Once(function() -- Line: 221
        -- upvalues: u19 (ref), u26 (ref), u22 (ref), u12 (copy), Character (copy)
        if u19 then
            u19:Disconnect();
        end;

        if u26 then
            u26:Disconnect();
        end;

        if u22 then
            u22:Disconnect();
        end;

        u12.Is_Using_Skill = false;
        u12.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 235
        -- upvalues: u12 (copy), u19 (ref), u26 (ref), u22 (ref), Character (copy)
        if u12.Is_Using_Skill then
            u12.Is_Using_Skill = false;
            u12.Is_Attacking = false;
        end;

        if u19 then
            u19:Disconnect();
        end;

        if u26 then
            u26:Disconnect();
        end;

        if u22 then
            u22:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
end;

return u1;