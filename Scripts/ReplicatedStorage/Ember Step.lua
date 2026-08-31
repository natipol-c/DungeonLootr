--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Ember Step
  Path:     game.ReplicatedStorage.Classes.Flame Bastion.Skills.Ember Step
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
    Cooldown = 7,
    MaxCharges = 2,
    DamageMultiplier = 2.25,
    AnimationName = "Ability_3",
    Skill_SFX = nil,
    DashSpeed = 70,
    DashDuration = 0.2,
    IFrameDuration = 0.5,
    HitboxSize = Vector3.new(20, 10, 20),
    MaxDuration = 1.5
};

function u1._EnsureAnimation(p2) -- Line: 44
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

function u1._PerformHit(p7) -- Line: 70
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

function u1.CanActivate(p10) -- Line: 93
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

function u1.Activate(u11, p12) -- Line: 101
    -- upvalues: u1 (copy), Debris (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Ember Step] Animation not found");

        return;
    end;

    local Character = u11.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u11.Is_Using_Skill = true;
    u11.Is_Attacking = true;
    u11.Player:SetAttribute("iFrame", true);
    u11.Character:SetAttribute("iFrame", true);

    for i, v in u11.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v13:Play(0, 1, 1);
    local u16 = v13:GetMarkerReachedSignal("hit"):Connect(function(p14) -- Line: 132
        -- upvalues: u11 (copy), u1 (ref), Debris (ref)
        local v15 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v15 then
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.Name = "SkillDash";
            BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
            BodyVelocity.Velocity = v15.CFrame.LookVector * u1.DashSpeed;
            BodyVelocity.Parent = v15;
            Debris:AddItem(BodyVelocity, u1.DashDuration);
        end;

        u11:PlayCombatSound(u1.Skill_SFX or (u11.ClassData.SwingSoundFolder or "Flame_Swing"), nil, u11.ClassData.SwingVolume or 0.5);

        if p14 == "" or not p14 then
            p14 = nil;
        end;

        u11:PlayTurnFX(p14);
        u11:ShakeCamera("SkillLight");
        u1._PerformHit(u11);
    end);
    local u17 = false;

    local function releaseState() -- Line: 154
        -- upvalues: u17 (ref), u11 (copy)
        if u17 then
            return;
        end;

        u17 = true;
        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;
    end;

    local u18 = v13:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v13.Stopped:Once(function() -- Line: 165
        -- upvalues: u17 (ref), u11 (copy), u16 (ref), u18 (copy)
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
    end);
    task.delay(u1.IFrameDuration, function() -- Line: 172
        -- upvalues: u11 (copy)
        if u11.Player then
            u11.Player:SetAttribute("iFrame", false);
        end;

        if u11.Character then
            u11.Character:SetAttribute("iFrame", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 182
        -- upvalues: u17 (ref), u11 (copy), u16 (ref), u18 (copy)
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

        if u11.Player then
            u11.Player:SetAttribute("iFrame", false);
        end;

        if u11.Character then
            u11.Character:SetAttribute("iFrame", false);
        end;
    end);
end;

return u1;