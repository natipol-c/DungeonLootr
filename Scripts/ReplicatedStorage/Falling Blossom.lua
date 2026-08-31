--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Falling Blossom
  Path:     game.ReplicatedStorage.Classes.Ronin.Skills.Falling Blossom
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
    Cooldown = 13,
    AnimationName = "Ability_4",
    Skill_SFX = nil,
    BurstHits = 3,
    BurstDamageMult = 0.87,
    SliceDamageMult = 0.48,
    BurstHitboxSize = Vector3.new(20, 10, 20),
    SliceHitboxSize = Vector3.new(20, 10, 20),
    SliceHitboxRange = 20,
    DashSpeed = 45,
    DashDuration = 0.2,
    ParryDuration = 0.6,
    MaxDuration = 3
};

function u1._EnsureAnimation(p2) -- Line: 55
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

function u1._PerformHit(p7, p8) -- Line: 83
    -- upvalues: u1 (copy)
    local v9 = u1.BurstHits < p8;
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = v9 and u1.SliceHitboxSize or u1.BurstHitboxSize;

    if v9 then
        p7.ClassData.Range = u1.SliceHitboxRange;
    end;

    local v10 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;
    local v11 = v9 and u1.SliceDamageMult or u1.BurstDamageMult;
    local v12 = 0;

    for _, v in v10 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(v11, v)));
            v12 = v12 + 1;
        end;
    end;

    return v12;
end;

function u1.CanActivate(p13) -- Line: 115
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

function u1.Activate(u14, p15) -- Line: 123
    -- upvalues: u1 (copy), Debris (copy)
    local v16 = u1._EnsureAnimation(u14);

    if not v16 then
        warn("[Falling Blossom] Animation not found");

        return;
    end;

    local Character = u14.Character;
    local v17;

    if Character then
        v17 = Character:FindFirstChild("HumanoidRootPart");
    else
        v17 = Character;
    end;

    if not v17 then
        return;
    end;

    u14.Is_Using_Skill = true;
    u14.Is_Attacking = true;

    for i, v in u14.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    u14:ShakeCamera("SkillLight");
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v17.CFrame.LookVector * u1.DashSpeed;
    BodyVelocity.Parent = v17;
    Debris:AddItem(BodyVelocity, u1.DashDuration);
    Character:SetAttribute("Parry", true);
    task.delay(u1.ParryDuration, function() -- Line: 157
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    v16:Play(0, 1, 1);
    local u18 = 0;
    local u20 = v16:GetMarkerReachedSignal("hit"):Connect(function(p19) -- Line: 169
        -- upvalues: u18 (ref), u1 (ref), u14 (copy)
        u18 = u18 + 1;
        u14:PlayCombatSound(u1.Skill_SFX or (u14.ClassData.SwingSoundFolder or "Sword_Swings"), nil, u14.ClassData.SwingVolume or 0.5);

        if p19 == "" or not p19 then
            p19 = nil;
        end;

        u14:PlayTurnFX(p19);
        u14:ShakeCamera("SkillLight");
        u1._PerformHit(u14, u18);
    end);
    local u21 = false;

    local function releaseState() -- Line: 180
        -- upvalues: u21 (ref), u14 (copy)
        if u21 then
            return;
        end;

        u21 = true;
        u14.Is_Using_Skill = false;
        u14.Is_Attacking = false;
    end;

    local u22 = v16:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v16.Stopped:Once(function() -- Line: 191
        -- upvalues: u21 (ref), u14 (copy), u20 (ref), u22 (copy), Character (copy)
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

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 201
        -- upvalues: u21 (ref), u14 (copy), u20 (ref), u22 (copy), Character (copy)
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

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
end;

return u1;