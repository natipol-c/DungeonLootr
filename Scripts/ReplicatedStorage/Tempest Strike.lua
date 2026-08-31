--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Tempest Strike
  Path:     game.ReplicatedStorage.Classes.Artemis.Skills.Tempest Strike
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:56 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 7,
    MaxCharges = 2,
    DamageMultiplier = 1.67,
    AnimationName = "Ability_3",
    HitboxSize = Vector3.new(40, 20, 30),
    HitboxRange = 25,
    DashSpeed = 70,
    DashDuration = 0.25,
    IFrameDuration = 0.5,
    HitSFX = "arrowhit",
    HitVolume = 1,
    MaxDuration = 2
};

function u1._EnsureAnimation(p2) -- Line: 48
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

function u1._PerformHit(p7) -- Line: 75
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

function u1._DoCastDash(p9) -- Line: 96
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

function u1.CanActivate(p12) -- Line: 119
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

function u1.Activate(u13, p14) -- Line: 127
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v15 = u1._EnsureAnimation(u13);

    if not v15 then
        warn("[Tempest Strike] Animation not found");

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

    for i, v in u13.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    u1._DoCastDash(u13);

    if u13.Player then
        u13.Player:SetAttribute("iFrame", true);
    end;

    Character:SetAttribute("iFrame", true);
    task.delay(u1.IFrameDuration, function() -- Line: 153
        -- upvalues: u13 (copy)
        local Player = u13.Player;
        local Character2 = u13.Character;

        if Player then
            Player:SetAttribute("iFrame", false);
        end;

        if Character2 then
            Character2:SetAttribute("iFrame", false);
        end;
    end);
    v15:Play(0, 1, 1);
    local u17 = {};

    local function disconnectAll() -- Line: 165
        -- upvalues: u17 (copy)
        for _, v in u17 do
            v:Disconnect();
        end;

        table.clear(u17);
    end;

    local u18 = false;

    local function releaseState() -- Line: 173
        -- upvalues: u18 (ref), u13 (copy)
        if u18 then
            return;
        end;

        u18 = true;
        local ClassData = u13.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u13, nil);
        end;

        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;
    end;

    u17[#u17 + 1] = v15:GetMarkerReachedSignal("hit"):Connect(function(p19) -- Line: 185
        -- upvalues: u13 (copy), SharedUtils (ref), u1 (ref)
        local v20 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v20 then
            SharedUtils.PlaySoundAt(v20, u1.HitSFX, u1.HitVolume);
        end;

        if p19 == "" or not p19 then
            p19 = nil;
        end;

        u13:PlayTurnFX(p19);
        u13:ShakeCamera("Hit");
        u1._PerformHit(u13);
    end);
    u17[#u17 + 1] = v15:GetMarkerReachedSignal("DBreset"):Connect(releaseState);

    local function fullCleanup() -- Line: 200
        -- upvalues: u18 (ref), u13 (copy), u17 (copy)
        if not u18 then
            u18 = true;
            local ClassData = u13.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u13, nil);
            end;

            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        for _, v in u17 do
            v:Disconnect();
        end;

        table.clear(u17);

        if u13.Player then
            u13.Player:SetAttribute("iFrame", false);
        end;

        if u13.Character then
            u13.Character:SetAttribute("iFrame", false);
        end;
    end;

    v15.Stopped:Once(fullCleanup);
    task.delay(u1.MaxDuration, fullCleanup);
end;

return u1;