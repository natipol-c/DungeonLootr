--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Rising Tempest
  Path:     game.ReplicatedStorage.Classes.Spell Breaker.Skills.Rising Tempest
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:59 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u12 = {
    Cooldown = 7,
    MaxCharges = 2,
    AnimationName = "Ability_2",
    DamageMultiplier = 1.67,
    HitboxSize = Vector3.new(24, 26, 28),
    HitboxRange = 25,
    LiftSpeed = 90,
    LiftDuration = 0.1,
    AirAnimationName = "Ability_2_Air",
    AirDamageMultiplier = 4,
    AirHitboxSize = Vector3.new(20, 18, 24),
    AirHitboxRange = 22,
    DiveForwardSpeed = 40,
    DiveDownSpeed = 100,
    DiveDuration = 0.05,
    AirHitSFX = "claw3",
    AirHitVolume = 0.9,
    MaxDuration = 2.5,

    _EnsureAnimation = function(p1, p2) -- Line: 65, Name: _EnsureAnimation
        -- upvalues: ReplicatedStorage (copy)
        if p1.Animations[p2] then
            return p1.Animations[p2];
        end;

        local v3 = ReplicatedStorage.Classes:FindFirstChild(p1.ClassName);

        if not v3 then
            return nil;
        end;

        local Skill_Animations = v3:FindFirstChild("Skill_Animations");

        if not Skill_Animations then
            return nil;
        end;

        local v4 = Skill_Animations:FindFirstChild(p2);

        if not v4 then
            return nil;
        end;

        local v5 = p1.Humanoid and p1.Humanoid:FindFirstChildOfClass("Animator");

        if not v5 then
            return nil;
        end;

        local v6 = v5:LoadAnimation(v4);
        v6.Priority = Enum.AnimationPriority.Action3;
        v6:Play(0, 0, 0);
        v6:Stop(0);
        p1.Animations[p2] = v6;

        return v6;
    end,

    _PerformHit = function(p7, p8, p9, p10) -- Line: 92, Name: _PerformHit
        local HitboxSize = p7.ClassData.HitboxSize;
        local Range = p7.ClassData.Range;
        p7.ClassData.HitboxSize = p9;
        p7.ClassData.Range = p10;
        local v11 = p7:Hitbox();
        p7.ClassData.HitboxSize = HitboxSize;
        p7.ClassData.Range = Range;

        for _, v in v11 do
            if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
                p7:ApplyDamage(v, (p7:ResolveSkillDamage(p8, v)));
            end;
        end;
    end
};

function u12._Dive(p13) -- Line: 115
    -- upvalues: u12 (copy), Debris (copy)
    local v14 = p13.Character and p13.Character:FindFirstChild("HumanoidRootPart");

    if not v14 then
        return;
    end;

    local LookVector = v14.CFrame.LookVector;
    local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);

    if Vector3_new_ret.Magnitude > 0 then
        Vector3_new_ret = Vector3_new_ret.Unit;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "RisingTempestDive";
    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
    BodyVelocity.Velocity = Vector3_new_ret * u12.DiveForwardSpeed + Vector3.new(0, -u12.DiveDownSpeed, 0);
    BodyVelocity.Parent = v14;
    Debris:AddItem(BodyVelocity, u12.DiveDuration);
end;

function u12.CanActivate(p15) -- Line: 136
    if p15.Is_Attacking then
        return false, "Attacking";
    end;

    if p15.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p15.Is_Dodging then
        return false, "Dodging";
    end;

    if p15.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u12.Activate(p16, p17) -- Line: 145
    -- upvalues: u12 (copy)
    if p16.IsInAir and p16:IsInAir() then
        u12._ActivateAir(p16, p17);

        return;
    end;

    u12._ActivateGround(p16, p17);
end;

function u12._ActivateGround(u18, p19) -- Line: 155
    -- upvalues: u12 (copy)
    local v20 = u12._EnsureAnimation(u18, u12.AnimationName);

    if not v20 then
        warn("[Rising Tempest] Ground animation not found");

        return;
    end;

    local Character = u18.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u18.Is_Using_Skill = true;
    u18.Is_Attacking = true;

    for i, v in u18.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "RisingTempestLift";
    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
    BodyVelocity.Velocity = Vector3.new(0, u12.LiftSpeed, 0);
    BodyVelocity.Parent = Character;
    task.delay(u12.LiftDuration, function() -- Line: 185
        -- upvalues: BodyVelocity (ref)
        if BodyVelocity and BodyVelocity.Parent then
            BodyVelocity.Velocity = Vector3.new(0, 0, 0);
        end;
    end);

    local function releaseAirHold() -- Line: 191
        -- upvalues: BodyVelocity (ref)
        if BodyVelocity then
            BodyVelocity:Destroy();
            BodyVelocity = nil;
        end;
    end;

    v20:Play(0, 1, 1);
    local u21 = {};

    local function disconnectAll() -- Line: 203
        -- upvalues: u21 (copy)
        for _, v in u21 do
            v:Disconnect();
        end;

        table.clear(u21);
    end;

    local u22 = false;

    local function releaseState() -- Line: 209
        -- upvalues: u22 (ref), u18 (copy)
        if u22 then
            return;
        end;

        u22 = true;
        local ClassData = u18.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u18, nil);
        end;

        u18.Is_Using_Skill = false;
        u18.Is_Attacking = false;
    end;

    u21[#u21 + 1] = v20:GetMarkerReachedSignal("hit"):Connect(function(p23) -- Line: 221
        -- upvalues: u18 (copy), u12 (ref)
        u18:PlayCombatSound(u18.ClassData.SwingSoundFolder or "Ninja", nil, u18.ClassData.SwingVolume or 0.5);

        if p23 == "" or not p23 then
            p23 = nil;
        end;

        u18:PlayTurnFX(p23);
        u18:ShakeCamera("Hit");
        u12._PerformHit(u18, u12.DamageMultiplier, u12.HitboxSize, u12.HitboxRange);
    end);
    u21[#u21 + 1] = v20:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 232
        -- upvalues: BodyVelocity (ref), u22 (ref), u18 (copy)
        if BodyVelocity then
            BodyVelocity:Destroy();
            BodyVelocity = nil;
        end;

        if u22 then
            return;
        end;

        u22 = true;
        local ClassData = u18.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u18, nil);
        end;

        u18.Is_Using_Skill = false;
        u18.Is_Attacking = false;
    end);

    local function fullCleanup() -- Line: 238
        -- upvalues: u22 (ref), u18 (copy), u21 (copy), BodyVelocity (ref)
        if not u22 then
            u22 = true;
            local ClassData = u18.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u18, nil);
            end;

            u18.Is_Using_Skill = false;
            u18.Is_Attacking = false;
        end;

        for _, v in u21 do
            v:Disconnect();
        end;

        table.clear(u21);

        if BodyVelocity then
            BodyVelocity:Destroy();
            BodyVelocity = nil;
        end;
    end;

    v20.Stopped:Once(fullCleanup);
    task.delay(u12.MaxDuration, fullCleanup);
end;

function u12._ActivateAir(u24, p25) -- Line: 248
    -- upvalues: u12 (copy), SharedUtils (copy)
    local v26 = u12._EnsureAnimation(u24, u12.AirAnimationName);

    if not v26 then
        warn("[Rising Tempest] Air animation not found");

        return;
    end;

    local Character = u24.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u24.Is_Using_Skill = true;
    u24.Is_Attacking = true;

    for i, v in u24.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v26:Play(0, 1, 1);
    u12._Dive(u24);
    local u27 = {};

    local function _() -- Line: 278
        -- upvalues: u27 (copy)
        for _, v in u27 do
            v:Disconnect();
        end;

        table.clear(u27);
    end;

    local u28 = false;

    local function v29() -- Line: 284
        -- upvalues: u28 (ref), u24 (copy)
        if u28 then
            return;
        end;

        u28 = true;
        local ClassData = u24.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u24, nil);
        end;

        u24.Is_Using_Skill = false;
        u24.Is_Attacking = false;
    end;

    u27[#u27 + 1] = v26:GetMarkerReachedSignal("hit"):Connect(function(p30) -- Line: 296
        -- upvalues: u24 (copy), SharedUtils (ref), u12 (ref)
        local v31 = u24.Character and u24.Character:FindFirstChild("HumanoidRootPart");

        if v31 then
            SharedUtils.PlaySoundAt(v31, u12.AirHitSFX, u12.AirHitVolume);
        end;

        if p30 == "" or not p30 then
            p30 = nil;
        end;

        u24:PlayTurnFX(p30);
        u24:ShakeCamera("Hit");
        u12._PerformHit(u24, u12.AirDamageMultiplier, u12.AirHitboxSize, u12.AirHitboxRange);
    end);
    u27[#u27 + 1] = v26:GetMarkerReachedSignal("DBreset"):Connect(v29);
    v26.Stopped:Once(function() -- Line: 312
        -- upvalues: u28 (ref), u24 (copy), u27 (copy)
        if not u28 then
            u28 = true;
            local ClassData = u24.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u24, nil);
            end;

            u24.Is_Using_Skill = false;
            u24.Is_Attacking = false;
        end;

        for _, v in u27 do
            v:Disconnect();
        end;

        table.clear(u27);
    end);
    task.delay(u12.MaxDuration, function() -- Line: 317
        -- upvalues: u28 (ref), u24 (copy), u27 (copy)
        if not u28 then
            u28 = true;
            local ClassData = u24.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u24, nil);
            end;

            u24.Is_Using_Skill = false;
            u24.Is_Attacking = false;
        end;

        for _, v in u27 do
            v:Disconnect();
        end;

        table.clear(u27);
    end);
end;

return u12;