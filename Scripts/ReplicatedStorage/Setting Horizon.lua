--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Setting Horizon
  Path:     game.ReplicatedStorage.Classes.Ronin.Skills.Setting Horizon
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:55 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local u1 = {
    Cooldown = 5,
    MaxCharges = 2,
    AnimationName = "Ability_2",
    Skill_SFX = nil,
    DamageMultiplier = 1,
    FinisherDamageMult = 1.5,
    HitboxSize = Vector3.new(20, 10, 20),
    HitboxRange = 20,
    FinisherHitboxSize = Vector3.new(25, 10, 25),
    FinisherHitboxRange = 25,
    FinisherHit = 3,
    DashSpeed = 55,
    DashDuration = 0.2,
    MaxDuration = 1.8
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

function u1._PerformHit(p7, p8) -- Line: 81
    -- upvalues: u1 (copy)
    local v9 = p8 == u1.FinisherHit;
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = v9 and u1.FinisherHitboxSize or u1.HitboxSize;
    p7.ClassData.Range = v9 and u1.FinisherHitboxRange or u1.HitboxRange;
    local v10 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;
    local v11 = v9 and u1.FinisherDamageMult or u1.DamageMultiplier;
    local v12 = 0;

    for _, v in v10 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(v11, v)));
            v12 = v12 + 1;
        end;
    end;

    return v12;
end;

local function ApplyDash(p13) -- Line: 111
    -- upvalues: u1 (copy), Debris (copy)
    local v14 = p13.Character and p13.Character:FindFirstChild("HumanoidRootPart");

    if not v14 then
        return;
    end;

    local _lastSkillDir = p13._lastSkillDir;

    if not _lastSkillDir then
        local Humanoid = p13.Humanoid;

        if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
            _lastSkillDir = Humanoid.MoveDirection.Unit;
        end;
    end;

    local v15 = _lastSkillDir or v14.CFrame.LookVector;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v15 * u1.DashSpeed;
    BodyVelocity.Parent = v14;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
end;

function u1.CanActivate(p16) -- Line: 134
    if p16.Is_Attacking then
        return false, "Attacking";
    end;

    if p16.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p16.Is_Dodging then
        return false, "Dodging";
    end;

    if p16.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u17, p18) -- Line: 142
    -- upvalues: u1 (copy), ApplyDash (copy)
    local v19 = u1._EnsureAnimation(u17);

    if not v19 then
        warn("[Setting Horizon] Animation not found");

        return;
    end;

    u17.Is_Using_Skill = true;
    u17.Is_Attacking = true;

    for i, v in u17.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    u17:ShakeCamera("SkillLight");
    ApplyDash(u17);
    v19:Play(0, 1, 1);
    local u20 = 0;
    local u22 = v19:GetMarkerReachedSignal("hit"):Connect(function(p21) -- Line: 170
        -- upvalues: u20 (ref), u1 (ref), u17 (copy)
        u20 = u20 + 1;
        u17:PlayCombatSound(u1.Skill_SFX or (u17.ClassData.SwingSoundFolder or "Sword_Swings"), nil, u17.ClassData.SwingVolume or 0.5);

        if p21 == "" or not p21 then
            p21 = nil;
        end;

        u17:PlayTurnFX(p21);
        u17:ShakeCamera("SkillLight");
        u1._PerformHit(u17, u20);
    end);
    local u23 = false;

    local function releaseState() -- Line: 181
        -- upvalues: u23 (ref), u17 (copy)
        if u23 then
            return;
        end;

        u23 = true;
        u17.Is_Using_Skill = false;
        u17.Is_Attacking = false;
    end;

    local u24 = v19:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v19.Stopped:Once(function() -- Line: 192
        -- upvalues: u23 (ref), u17 (copy), u22 (ref), u24 (copy)
        if not u23 then
            u23 = true;
            u17.Is_Using_Skill = false;
            u17.Is_Attacking = false;
        end;

        if u22 then
            u22:Disconnect();
        end;

        if u24 then
            u24:Disconnect();
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 198
        -- upvalues: u23 (ref), u17 (copy), u22 (ref), u24 (copy)
        if not u23 then
            u23 = true;
            u17.Is_Using_Skill = false;
            u17.Is_Attacking = false;
        end;

        if u22 then
            u22:Disconnect();
        end;

        if u24 then
            u24:Disconnect();
        end;
    end);
end;

return u1;