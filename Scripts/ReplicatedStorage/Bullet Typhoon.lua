--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Bullet Typhoon
  Path:     game.ReplicatedStorage.Classes.Hitman.Skills.Bullet Typhoon
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:01 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");
local u2 = {
    Cooldown = 10,
    DamageMultiplier = 2.7,
    AnimationName = "Ability_4",
    Skill_SFX = nil,
    DodgeDuration = 4,
    HitboxSize = Vector3.new(15, 10, 25),
    HitboxRange = 25,
    DashSpeed = 50,
    DashDuration = 0.1,
    CloneFadeDuration = 0.8,
    CloneColor = Color3.fromRGB(255, 240, 150),
    MaxDuration = 4.5
};

function u2._EnsureAnimation(p3) -- Line: 54
    -- upvalues: u2 (copy), ReplicatedStorage (copy)
    local AnimationName = u2.AnimationName;

    if p3.Animations[AnimationName] then
        return p3.Animations[AnimationName];
    end;

    local v4 = ReplicatedStorage.Classes:FindFirstChild(p3.ClassName);

    if not v4 then
        return nil;
    end;

    local Skill_Animations = v4:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local v5 = Skill_Animations:FindFirstChild(u2.AnimationName);

    if not v5 then
        return nil;
    end;

    local v6 = p3.Humanoid and p3.Humanoid:FindFirstChildOfClass("Animator");

    if not v6 then
        return nil;
    end;

    local v7 = v6:LoadAnimation(v5);
    v7.Priority = Enum.AnimationPriority.Action3;
    v7:Play(0, 0, 0);
    v7:Stop(0);
    p3.Animations[AnimationName] = v7;

    return v7;
end;

function u2._PerformHit(p8) -- Line: 80
    -- upvalues: u2 (copy)
    local HitboxSize = p8.ClassData.HitboxSize;
    local Range = p8.ClassData.Range;
    p8.ClassData.HitboxSize = u2.HitboxSize;
    p8.ClassData.Range = u2.HitboxRange;
    local v9 = p8:Hitbox();
    p8.ClassData.HitboxSize = HitboxSize;
    p8.ClassData.Range = Range;

    for _, v in v9 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p8:ApplyDamage(v, (p8:ResolveSkillDamage(u2.DamageMultiplier, v)));
        end;
    end;
end;

function u2._SpawnClone(p10) -- Line: 100
    -- upvalues: u1 (copy), u2 (copy)
    if not u1 then
        return;
    end;

    u1:FireAllClients(p10.Player, {
        Action = "Clone",
        FadeDuration = u2.CloneFadeDuration,
        Color = u2.CloneColor
    });
end;

function u2.CanActivate(p11) -- Line: 112
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

function u2.Activate(u12, p13) -- Line: 120
    -- upvalues: u2 (copy), Debris (copy), SharedUtils (copy)
    local v14 = u2._EnsureAnimation(u12);

    if not v14 then
        warn("[Bullet Typhoon] Animation not found");

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

    Character:SetAttribute("Dodge", true);
    task.delay(u2.DodgeDuration, function() -- Line: 145
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
    v14:Play(0, 1, 1);
    local u16 = 0;
    local u20 = v14:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 157
        -- upvalues: u16 (ref), u12 (copy), u2 (ref), Debris (ref), SharedUtils (ref)
        u16 = u16 + 1;
        local v18 = u12.Character and u12.Character:FindFirstChild("HumanoidRootPart");

        if not v18 then
            return;
        end;

        u12:PlayFX("Ability_4");
        u2._SpawnClone(u12);
        local Humanoid = u12.Humanoid;
        local v19;

        if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
            v19 = Humanoid.MoveDirection.Unit;
        else
            v19 = v18.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v19 * u2.DashSpeed;
        BodyVelocity.Parent = v18;
        Debris:AddItem(BodyVelocity, u2.DashDuration);
        SharedUtils.PlaySoundAt(v18, u16 % 2 == 1 and "Revolver_1_2" or "Revolver_1", 0.5, 0.05);
        u2._PerformHit(u12);
        u12:ShakeCamera("Hit");
    end);
    v14.Stopped:Once(function() -- Line: 192
        -- upvalues: u20 (ref), u12 (copy), Character (copy)
        if u20 then
            u20:Disconnect();
        end;

        u12.Is_Using_Skill = false;
        u12.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
    task.delay(u2.MaxDuration, function() -- Line: 204
        -- upvalues: u12 (copy), u20 (ref), Character (copy)
        if u12.Is_Using_Skill then
            u12.Is_Using_Skill = false;
            u12.Is_Attacking = false;
        end;

        if u20 then
            u20:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
end;

return u2;