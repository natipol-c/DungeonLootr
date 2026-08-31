--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Stampede
  Path:     game.ReplicatedStorage.Classes.Hitman.Skills.Stampede
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
    Cooldown = 6,
    MaxCharges = 4,
    DamageMultiplier = 1.9,
    AnimationName = "Ability_1",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(20, 10, 25),
    HitboxRange = 25,
    DashSpeed = 45,
    DashDuration = 0.1,
    DodgeDuration = 1,
    CloneFadeDuration = 0.8,
    CloneColor = Color3.fromRGB(255, 240, 150),
    MaxDuration = 1.5
};

function u2._EnsureAnimation(p3) -- Line: 56
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

function u2._PerformHit(p8) -- Line: 82
    -- upvalues: u2 (copy)
    local HitboxSize = p8.ClassData.HitboxSize;
    local Range = p8.ClassData.Range;
    p8.ClassData.HitboxSize = u2.HitboxSize;
    p8.ClassData.Range = u2.HitboxRange;
    local v9 = p8:Hitbox();
    p8.ClassData.HitboxSize = HitboxSize;
    p8.ClassData.Range = Range;
    local v10 = 0;

    for _, v in v9 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p8:ApplyDamage(v, (p8:ResolveSkillDamage(u2.DamageMultiplier, v)));
            v10 = v10 + 1;
        end;
    end;

    return v10;
end;

function u2._SpawnClone(p11) -- Line: 106
    -- upvalues: u1 (copy), u2 (copy)
    if not u1 then
        return;
    end;

    u1:FireAllClients(p11.Player, {
        Action = "Clone",
        FadeDuration = u2.CloneFadeDuration,
        Color = u2.CloneColor
    });
end;

function u2.CanActivate(p12) -- Line: 118
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

function u2.Activate(u13, p14) -- Line: 126
    -- upvalues: u2 (copy), Debris (copy), SharedUtils (copy)
    local v15 = u2._EnsureAnimation(u13);

    if not v15 then
        warn("[Stampede] Animation not found");

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
    Character:SetAttribute("Dodge", true);
    task.delay(u2.DodgeDuration, function() -- Line: 144
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);

    for i, v in u13.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v15:Play(0, 1, 1);
    local u20 = v15:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 162
        -- upvalues: u13 (copy), u2 (ref), Debris (ref), SharedUtils (ref)
        local v18 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if not v18 then
            return;
        end;

        u13:PlayTurnFX("Left_Shot");
        u13:ShakeCamera("SkillLight");
        u2._SpawnClone(u13);
        local Humanoid = u13.Humanoid;
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
        SharedUtils.PlaySoundAt(v18, "Revolver_1", 0.6, 0.06);
        u2._PerformHit(u13);
    end);
    local u22 = v15:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 198
        -- upvalues: u13 (copy), SharedUtils (ref)
        local v21 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v21 then
            SharedUtils.PlaySoundAt(v21, "Revolver_Spin", 0.7);
        end;
    end);
    v15.Stopped:Once(function() -- Line: 204
        -- upvalues: u20 (ref), u22 (ref), u13 (copy), Character (copy)
        if u20 then
            u20:Disconnect();
        end;

        if u22 then
            u22:Disconnect();
        end;

        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
    task.delay(u2.MaxDuration, function() -- Line: 217
        -- upvalues: u13 (copy), u20 (ref), u22 (ref), Character (copy)
        if u13.Is_Using_Skill then
            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        if u20 then
            u20:Disconnect();
        end;

        if u22 then
            u22:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
end;

return u2;