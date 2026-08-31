--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Zephyr Barrage
  Path:     game.ReplicatedStorage.Classes.Archer.Skills.Zephyr Barrage
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
    Cooldown = 10,
    DamageMultiplier = 0.5,
    AnimationName = "Ability_3",
    Skill_SFX = "Bow_Shot",
    ProjectilesPerHit = 2,
    LaunchAngleUp = 40,
    TrackSpeed = 18,
    SpreadAngle = 10,
    FanAngle = 25,
    DashSpeed = 70,
    DashDuration = 0.3,
    ParryDuration = 0.8,
    MaxDuration = 2.5
};

function u1._EnsureAnimation(p2) -- Line: 49
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

function u1.CanActivate(p7) -- Line: 77
    if p7.Is_Attacking then
        return false, "Attacking";
    end;

    if p7.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p7.Is_Dodging then
        return false, "Dodging";
    end;

    if p7.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u8, p9) -- Line: 85
    -- upvalues: u1 (copy), SharedUtils (copy), Debris (copy)
    local v10 = u1._EnsureAnimation(u8);

    if not v10 then
        warn("[Zephyr Barrage] Animation not found");

        return;
    end;

    local Character = u8.Character;
    local v11;

    if Character then
        v11 = Character:FindFirstChild("HumanoidRootPart");
    else
        v11 = Character;
    end;

    if not v11 then
        return;
    end;

    u8.Is_Using_Skill = true;
    u8.Is_Attacking = true;
    Character:SetAttribute("Parry", true);
    task.delay(u1.ParryDuration, function() -- Line: 103
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);

    for i, v in u8.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v10:Play(0, 1, 1);
    SharedUtils.PlaySoundAt(v11, "Bow_Shot", 1);
    local u13 = v10:GetMarkerReachedSignal("hit"):Connect(function(p12) -- Line: 124
        -- upvalues: u1 (ref), u8 (copy)
        u8:PlayCombatSound(u1.Skill_SFX or u8.ClassData.SwingSoundFolder or "Bow_Shot", nil, u8.ClassData.SwingVolume or 0.5);
        u8:ShakeCamera("Hit");

        for i = 1, u1.ProjectilesPerHit do
            u8:FireProjectile(u1.DamageMultiplier, {
                LaunchAngleUp = u1.LaunchAngleUp,
                TrackSpeed = u1.TrackSpeed,
                SpreadAngle = u1.SpreadAngle,
                FanAngle = u1.FanAngle
            });
            local _ = i;
        end;
    end);
    local u16 = v10:GetMarkerReachedSignal("dash"):Connect(function(p14) -- Line: 144
        -- upvalues: u8 (copy), u1 (ref), Debris (ref)
        local v15 = u8.Character and u8.Character:FindFirstChild("HumanoidRootPart");

        if not v15 then
            return;
        end;

        local LookVector = v15.CFrame.LookVector;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = LookVector * u1.DashSpeed;
        BodyVelocity.Parent = v15;
        Debris:AddItem(BodyVelocity, u1.DashDuration);
    end);
    v10.Stopped:Once(function() -- Line: 159
        -- upvalues: u13 (ref), u16 (ref), u8 (copy), Character (copy)
        if u13 then
            u13:Disconnect();
        end;

        if u16 then
            u16:Disconnect();
        end;

        u8.Is_Using_Skill = false;
        u8.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 172
        -- upvalues: u8 (copy), u13 (ref), u16 (ref), Character (copy)
        if u8.Is_Using_Skill then
            u8.Is_Using_Skill = false;
            u8.Is_Attacking = false;
        end;

        if u13 then
            u13:Disconnect();
        end;

        if u16 then
            u16:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
end;

return u1;