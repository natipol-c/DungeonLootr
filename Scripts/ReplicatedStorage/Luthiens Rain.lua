--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Luthiens Rain
  Path:     game.ReplicatedStorage.Classes.Archer.Skills.Luthiens Rain
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
    DamageMultiplier = 1.67,
    AnimationName = "Ability_2",
    Skill_SFX = nil,
    ExplosionSequence = { "Explosion_Right", "Explosion_Center", "Explosion_Left" },
    DashSpeed = 60,
    DashDuration = 0.3,
    DodgeDuration = 1.6,
    MaxDuration = 2.5
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

function u1._DetonateAtPart(p7: any, p8: string) -- Line: 80
    -- upvalues: SharedUtils (copy), u1 (copy)
    p7:PlayFX(p8);
    local v9 = p7.Character and p7.Character:FindFirstChild("HumanoidRootPart");

    if v9 then
        SharedUtils.PlaySoundAt(v9, "Large_Explosion", 1);
    end;

    local HitboxSize = p7.ClassData.HitboxSize;
    p7.ClassData.HitboxSize = Vector3.new(20, 15, 30);
    local v10 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;

    for _, v in v10 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
        end;
    end;
end;

function u1.CanActivate(p11) -- Line: 109
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

function u1.Activate(u12, p13) -- Line: 117
    -- upvalues: u1 (copy), Debris (copy)
    local v14 = u1._EnsureAnimation(u12);

    if not v14 then
        warn("[Luthiens Rain] Animation not found");

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
    Character:SetAttribute("Dodge", true);
    task.delay(u1.DodgeDuration, function() -- Line: 135
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);

    for i, v in u12.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v14:Play(0, 1, 1);
    local u16 = 0;
    local u19 = v14:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 154
        -- upvalues: u16 (ref), u1 (ref), u12 (copy)
        u16 = u16 + 1;
        local v18 = u1.ExplosionSequence[u16];

        if not v18 then
            return;
        end;

        u12:ShakeCamera("SkillLight");
        u1._DetonateAtPart(u12, v18);
    end);
    local u23 = v14:GetMarkerReachedSignal("dash"):Connect(function(p20) -- Line: 166
        -- upvalues: u12 (copy), u1 (ref), Debris (ref)
        local v21 = u12.Character and u12.Character:FindFirstChild("HumanoidRootPart");

        if not v21 then
            return;
        end;

        local v22 = -v21.CFrame.LookVector;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v22 * u1.DashSpeed;
        BodyVelocity.Parent = v21;
        Debris:AddItem(BodyVelocity, u1.DashDuration);
    end);
    v14.Stopped:Once(function() -- Line: 181
        -- upvalues: u19 (ref), u23 (ref), u12 (copy), Character (copy)
        if u19 then
            u19:Disconnect();
        end;

        if u23 then
            u23:Disconnect();
        end;

        u12.Is_Using_Skill = false;
        u12.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 194
        -- upvalues: u12 (copy), u19 (ref), u23 (ref), Character (copy)
        if u12.Is_Using_Skill then
            u12.Is_Using_Skill = false;
            u12.Is_Attacking = false;
        end;

        if u19 then
            u19:Disconnect();
        end;

        if u23 then
            u23:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
end;

return u1;