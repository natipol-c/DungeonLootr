--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Fadeaway Shot
  Path:     game.ReplicatedStorage.Classes.Bowman.Skills.Fadeaway Shot
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
    Cooldown = 5,
    DamageMultiplier = 4,
    AnimationName = "Ability_1",
    Skill_SFX = nil,
    DashSpeed = 32.5,
    DashDuration = 0.25,
    IFrameDuration = 1,
    HitboxSize = Vector3.new(20, 10, 35),
    HitboxRange = 32,
    MaxDuration = 2
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

function u1._PerformHit(p7) -- Line: 69
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

function u1.CanActivate(p10) -- Line: 96
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

function u1.Activate(u11, p12) -- Line: 104
    -- upvalues: u1 (copy), Debris (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Fadeaway Shot] Animation not found");

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
    local u17 = v13:GetMarkerReachedSignal("dash"):Connect(function(p14) -- Line: 135
        -- upvalues: u11 (copy), u1 (ref), Debris (ref)
        local v15 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if not v15 then
            return;
        end;

        local v16;

        if p14 == "Back" then
            v16 = -v15.CFrame.LookVector;
        else
            v16 = v15.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v16 * u1.DashSpeed;
        BodyVelocity.Parent = v15;
        Debris:AddItem(BodyVelocity, u1.DashDuration);
    end);
    local u19 = v13:GetMarkerReachedSignal("hit"):Connect(function(p18) -- Line: 156
        -- upvalues: u1 (ref), u11 (copy)
        u11:PlayCombatSound(u1.Skill_SFX or (u11.ClassData.SwingSoundFolder or "Bow_Shot"), nil, u11.ClassData.SwingVolume or 0.5);

        if p18 == "" or not p18 then
            p18 = nil;
        end;

        u11:PlayTurnFX(p18);
        u11:ShakeCamera("SkillLight");
        u1._PerformHit(u11);
    end);
    local u20 = false;

    local function releaseState() -- Line: 166
        -- upvalues: u20 (ref), u11 (copy)
        if u20 then
            return;
        end;

        u20 = true;
        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;
    end;

    local u21 = v13:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v13.Stopped:Once(function() -- Line: 177
        -- upvalues: u20 (ref), u11 (copy), u19 (ref), u17 (ref), u21 (copy)
        if not u20 then
            u20 = true;
            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;
        end;

        if u19 then
            u19:Disconnect();
        end;

        if u17 then
            u17:Disconnect();
        end;

        if u21 then
            u21:Disconnect();
        end;
    end);
    task.delay(u1.IFrameDuration, function() -- Line: 185
        -- upvalues: u11 (copy)
        if u11.Player then
            u11.Player:SetAttribute("iFrame", false);
        end;

        if u11.Character then
            u11.Character:SetAttribute("iFrame", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 195
        -- upvalues: u20 (ref), u11 (copy), u19 (ref), u17 (ref), u21 (copy)
        if not u20 then
            u20 = true;
            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;
        end;

        if u19 then
            u19:Disconnect();
        end;

        if u17 then
            u17:Disconnect();
        end;

        if u21 then
            u21:Disconnect();
        end;
    end);
end;

return u1;