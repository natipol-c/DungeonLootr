--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Ashen Onslaught
  Path:     game.ReplicatedStorage.Classes.Flame Bastion.Skills.Ashen Onslaught
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:50 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local u1 = {
    Cooldown = 10,
    DamageMultiplier = 1,
    HitCount = 5,
    AnimationName = "Ability_4",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(20, 10, 20),
    DashSpeed = 40,
    DashDuration = 0.14,
    MaxDuration = 2.5
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

function u1._PerformHit(p7) -- Line: 68
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    local v8 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    local v9 = 0;

    for _, v in v8 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v9 = v9 + 1;
        end;
    end;

    return v9;
end;

function u1._DoDash(p10) -- Line: 91
    -- upvalues: u1 (copy), Debris (copy)
    local v11 = p10.Character and p10.Character:FindFirstChild("HumanoidRootPart");

    if not v11 then
        return;
    end;

    local Humanoid = p10.Humanoid;
    local v12;

    if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
        v12 = Humanoid.MoveDirection.Unit;
    else
        v12 = v11.CFrame.LookVector;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v12 * u1.DashSpeed;
    BodyVelocity.Parent = v11;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
end;

function u1.CanActivate(p13) -- Line: 113
    if p13.Is_Attacking then
        return false, "Attacking";
    end;

    if p13.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p13.Is_Dodging then
        return false, "Dodging";
    end;

    if p13.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u14, p15) -- Line: 121
    -- upvalues: u1 (copy)
    local v16 = u1._EnsureAnimation(u14);

    if not v16 then
        warn("[Ashen Onslaught] Animation not found");

        return;
    end;

    u14.Is_Using_Skill = true;
    u14.Is_Attacking = true;

    for i, v in u14.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v16:Play(0, 1, 1);
    local u17 = 0;
    local u20 = v16:GetMarkerReachedSignal("hit"):Connect(function(p18) -- Line: 145
        -- upvalues: u17 (ref), u1 (ref), u14 (copy)
        u17 = u17 + 1;
        local v19 = u17 >= u1.HitCount;
        u14:PlayCombatSound(u1.Skill_SFX or (u14.ClassData.SwingSoundFolder or "Flame_Swing"), nil, u14.ClassData.SwingVolume or 0.5);

        if p18 and p18 ~= "" then
            u14:PlayTurnFX(p18);
        end;

        u1._DoDash(u14);
        u14:ShakeCamera(v19 and "SkillHeavy" or "SkillLight");
        u1._PerformHit(u14);
    end);
    local u21 = false;

    local function releaseState() -- Line: 162
        -- upvalues: u21 (ref), u14 (copy)
        if u21 then
            return;
        end;

        u21 = true;
        u14.Is_Using_Skill = false;
        u14.Is_Attacking = false;
    end;

    local u22 = v16:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v16.Stopped:Once(function() -- Line: 173
        -- upvalues: u21 (ref), u14 (copy), u20 (ref), u22 (copy)
        if not u21 then
            u21 = true;
            u14.Is_Using_Skill = false;
            u14.Is_Attacking = false;
        end;

        if u20 then
            u20:Disconnect();
        end;

        if u22 then
            u22:Disconnect();
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 180
        -- upvalues: u21 (ref), u14 (copy), u20 (ref), u22 (copy)
        if not u21 then
            u21 = true;
            u14.Is_Using_Skill = false;
            u14.Is_Attacking = false;
        end;

        if u20 then
            u20:Disconnect();
        end;

        if u22 then
            u22:Disconnect();
        end;
    end);
end;

return u1;