--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Blade Flurry
  Path:     game.ReplicatedStorage.Classes.Spell Breaker.Skills.Blade Flurry
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:59 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local u1 = {
    Cooldown = 10,
    DamageMultiplier = 1.25,
    TotalHits = 4,
    AnimationName = "Ability_3",
    AnimationSpeed = 1.4,
    DashSpeed = 55,
    DashDuration = 0.12,
    HitboxSize = Vector3.new(22, 18, 28),
    HitboxRange = 22,
    MaxDuration = 3
};

function u1._EnsureAnimation(p2) -- Line: 42
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

function u1._PerformHit(p7) -- Line: 69
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    p7.ClassData.Range = u1.HitboxRange;
    local v8 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;

    for _, v in v8 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
        end;
    end;
end;

function u1._DoDash(p9) -- Line: 90
    -- upvalues: u1 (copy), Debris (copy)
    local v10 = p9.Character and p9.Character:FindFirstChild("HumanoidRootPart");

    if not v10 then
        return;
    end;

    local Humanoid = p9.Humanoid;
    local v11;

    if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
        v11 = Humanoid.MoveDirection.Unit;
    else
        v11 = v10.CFrame.LookVector;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v11 * u1.DashSpeed;
    BodyVelocity.Parent = v10;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
end;

function u1.CanActivate(p12) -- Line: 113
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

function u1.Activate(u13, p14) -- Line: 121
    -- upvalues: u1 (copy)
    local v15 = u1._EnsureAnimation(u13);

    if not v15 then
        warn("[Blade Flurry] Animation not found");

        return;
    end;

    u13.Is_Using_Skill = true;
    u13.Is_Attacking = true;

    for i, v in u13.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v15:Play(0, 1, u1.AnimationSpeed);
    local u16 = {};

    local function disconnectAll() -- Line: 144
        -- upvalues: u16 (copy)
        for _, v in u16 do
            v:Disconnect();
        end;

        table.clear(u16);
    end;

    local u17 = false;

    local function releaseState() -- Line: 150
        -- upvalues: u17 (ref), u13 (copy)
        if u17 then
            return;
        end;

        u17 = true;
        local ClassData = u13.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u13, nil);
        end;

        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;
    end;

    u16[#u16 + 1] = v15:GetMarkerReachedSignal("hit"):Connect(function(p18) -- Line: 162
        -- upvalues: u1 (ref), u13 (copy)
        u1._DoDash(u13);
        u13:PlayCombatSound(u13.ClassData.SwingSoundFolder or "Ninja", nil, u13.ClassData.SwingVolume or 0.5);

        if p18 == "" or not p18 then
            p18 = nil;
        end;

        u13:PlayTurnFX(p18);
        u13:ShakeCamera("Hit");
        u1._PerformHit(u13);
    end);
    u16[#u16 + 1] = v15:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v15.Stopped:Once(function() -- Line: 177
        -- upvalues: u17 (ref), u13 (copy), u16 (copy)
        if not u17 then
            u17 = true;
            local ClassData = u13.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u13, nil);
            end;

            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        for _, v in u16 do
            v:Disconnect();
        end;

        table.clear(u16);
    end);
    task.delay(u1.MaxDuration, function() -- Line: 182
        -- upvalues: u17 (ref), u13 (copy), u16 (copy)
        if not u17 then
            u17 = true;
            local ClassData = u13.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u13, nil);
            end;

            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        for _, v in u16 do
            v:Disconnect();
        end;

        table.clear(u16);
    end);
end;

return u1;