--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Swallow Cut
  Path:     game.ReplicatedStorage.Classes.Ronin.Skills.Swallow Cut
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
    Cooldown = 7,
    DamageMultiplier = 1,
    AnimationName = "Ability_3",
    Skill_SFX = nil,
    DashSpeed = 40,
    DashDuration = 0.2,
    ParryDuration = 0.5,
    HitboxSize = Vector3.new(20, 10, 20),
    HitboxRange = 20,
    MaxDuration = 1.5
};

function u1._EnsureAnimation(p2) -- Line: 46
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

function u1._PerformHit(p7) -- Line: 72
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

function u1.CanActivate(p10) -- Line: 99
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

function u1.Activate(u11, p12) -- Line: 107
    -- upvalues: u1 (copy), Debris (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Swallow Cut] Animation not found");

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

    u11:ShakeCamera("SkillLight");
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v14.CFrame.LookVector * u1.DashSpeed;
    BodyVelocity.Parent = v14;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
    Character:SetAttribute("Parry", true);
    task.delay(u1.ParryDuration, function() -- Line: 141
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    v13:Play(0, 1, 1);
    local u16 = v13:GetMarkerReachedSignal("hit"):Connect(function(p15) -- Line: 152
        -- upvalues: u1 (ref), u11 (copy)
        u11:PlayCombatSound(u1.Skill_SFX or (u11.ClassData.SwingSoundFolder or "Sword_Swings"), nil, u11.ClassData.SwingVolume or 0.5);

        if p15 == "" or not p15 then
            p15 = nil;
        end;

        u11:PlayTurnFX(p15);
        u11:ShakeCamera("SkillLight");
        u1._PerformHit(u11);
    end);
    local u17 = false;

    local function releaseState() -- Line: 162
        -- upvalues: u17 (ref), u11 (copy)
        if u17 then
            return;
        end;

        u17 = true;
        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;
    end;

    local u18 = v13:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v13.Stopped:Once(function() -- Line: 173
        -- upvalues: u17 (ref), u11 (copy), u16 (ref), u18 (copy), Character (copy)
        if not u17 then
            u17 = true;
            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;
        end;

        if u16 then
            u16:Disconnect();
        end;

        if u18 then
            u18:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 184
        -- upvalues: u17 (ref), u11 (copy), u16 (ref), u18 (copy), Character (copy)
        if not u17 then
            u17 = true;
            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;
        end;

        if u16 then
            u16:Disconnect();
        end;

        if u18 then
            u18:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
end;

return u1;