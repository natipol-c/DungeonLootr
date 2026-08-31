--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Ichimonji
  Path:     game.ReplicatedStorage.Classes.Ronin.Skills.Ichimonji
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
    DamageMultiplier = 2.5,
    AnimationName = "Ability_1",
    Skill_SFX = nil,
    DashSpeed = 65,
    DashDuration = 0.2,
    IFrameDuration = 0.8,
    HitboxSize = Vector3.new(20, 10, 20),
    MaxDuration = 1.5
};

function u1._EnsureAnimation(p2) -- Line: 43
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

local function ApplyDash(p10) -- Line: 93
    -- upvalues: u1 (copy), Debris (copy)
    local v11 = p10.Character and p10.Character:FindFirstChild("HumanoidRootPart");

    if not v11 then
        return;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v11.CFrame.LookVector * u1.DashSpeed;
    BodyVelocity.Parent = v11;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
end;

function u1.CanActivate(p12) -- Line: 107
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

function u1.Activate(u13, p14) -- Line: 115
    -- upvalues: u1 (copy), ApplyDash (copy)
    local v15 = u1._EnsureAnimation(u13);

    if not v15 then
        warn("[Ichimonji] Animation not found");

        return;
    end;

    u13.Is_Using_Skill = true;
    u13.Is_Attacking = true;
    u13.Player:SetAttribute("iFrame", true);
    u13.Character:SetAttribute("iFrame", true);

    for i, v in u13.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    u13:ShakeCamera("SkillLight");
    ApplyDash(u13);
    v15:Play(0, 1, 1);
    local u17 = v15:GetMarkerReachedSignal("hit"):Connect(function(p16) -- Line: 146
        -- upvalues: u1 (ref), u13 (copy)
        u13:PlayCombatSound(u1.Skill_SFX or (u13.ClassData.SwingSoundFolder or "Sword_Swings"), nil, u13.ClassData.SwingVolume or 0.5);

        if p16 == "" or not p16 then
            p16 = nil;
        end;

        u13:PlayTurnFX(p16);
        u13:ShakeCamera("SkillLight");
        u1._PerformHit(u13);
    end);
    local u18 = false;

    local function releaseState() -- Line: 156
        -- upvalues: u18 (ref), u13 (copy)
        if u18 then
            return;
        end;

        u18 = true;
        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;
    end;

    local u19 = v15:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v15.Stopped:Once(function() -- Line: 167
        -- upvalues: u18 (ref), u13 (copy), u17 (ref), u19 (copy)
        if not u18 then
            u18 = true;
            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        if u17 then
            u17:Disconnect();
        end;

        if u19 then
            u19:Disconnect();
        end;
    end);
    task.delay(u1.IFrameDuration, function() -- Line: 174
        -- upvalues: u13 (copy)
        if u13.Player then
            u13.Player:SetAttribute("iFrame", false);
        end;

        if u13.Character then
            u13.Character:SetAttribute("iFrame", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 183
        -- upvalues: u18 (ref), u13 (copy), u17 (ref), u19 (copy)
        if not u18 then
            u18 = true;
            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        if u17 then
            u17:Disconnect();
        end;

        if u19 then
            u19:Disconnect();
        end;
    end);
end;

return u1;