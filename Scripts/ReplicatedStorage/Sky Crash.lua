--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Sky Crash
  Path:     game.ReplicatedStorage.Classes.Awakened Devil EX.Skills.Sky Crash
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:52 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u13 = {
    Cooldown = 9,
    AnimationName = "Ability_3",
    GroundEffectModule = "Sky_Crash_Ground",
    DamageMultiplier = 6,
    HitboxSize = Vector3.new(22, 25, 50),
    HitboxRange = 40,
    GroundHitSFX = "power_spin_04",
    GroundHitVolume = 1,
    DashSpeed = 70,
    DashDuration = 0.15,
    AirAnimationName = "Ability_3_Air",
    AirEffectModule = "Sky_Crash_Air",
    AirDamageMultiplier = 1.9,
    AirHitboxSize = Vector3.new(20, 18, 34),
    AirHitboxRange = 32,
    AirFirstHitSFX = "claw3",
    AirFirstHitVolume = 0.9,
    DiveForwardSpeed = 40,
    DiveDownSpeed = 100,
    DiveDuration = 0.05,
    MaxDuration = 2,

    _EnsureAnimation = function(p1, p2) -- Line: 72, Name: _EnsureAnimation
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

    _PerformHit = function(p7, p8, p9, p10) -- Line: 99, Name: _PerformHit
        local HitboxSize = p7.ClassData.HitboxSize;
        local Range = p7.ClassData.Range;
        p7.ClassData.HitboxSize = p9;
        p7.ClassData.Range = p10;
        local v11 = p7:Hitbox();
        p7.ClassData.HitboxSize = HitboxSize;
        p7.ClassData.Range = Range;
        local v12 = 0;

        for _, v in v11 do
            if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
                p7:ApplyDamage(v, (p7:ResolveSkillDamage(p8, v)));
                v12 = v12 + 1;
            end;
        end;

        return v12;
    end
};

function u13._DoCastDash(p14) -- Line: 125
    -- upvalues: u13 (copy), Debris (copy)
    local v15 = p14.Character and p14.Character:FindFirstChild("HumanoidRootPart");

    if not v15 then
        return;
    end;

    local Humanoid = p14.Humanoid;
    local v16;

    if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
        v16 = Humanoid.MoveDirection.Unit;
    else
        v16 = v15.CFrame.LookVector;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v16 * u13.DashSpeed;
    BodyVelocity.Parent = v15;
    Debris:AddItem(BodyVelocity, u13.DashDuration);
end;

function u13._Dive(p17) -- Line: 149
    -- upvalues: u13 (copy), Debris (copy)
    local v18 = p17.Character and p17.Character:FindFirstChild("HumanoidRootPart");

    if not v18 then
        return;
    end;

    local LookVector = v18.CFrame.LookVector;
    local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);

    if Vector3_new_ret.Magnitude > 0 then
        Vector3_new_ret = Vector3_new_ret.Unit;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkyCrashDive";
    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
    BodyVelocity.Velocity = Vector3_new_ret * u13.DiveForwardSpeed + Vector3.new(0, -u13.DiveDownSpeed, 0);
    BodyVelocity.Parent = v18;
    Debris:AddItem(BodyVelocity, u13.DiveDuration);
end;

function u13.CanActivate(p19) -- Line: 170
    if p19.Is_Attacking then
        return false, "Attacking";
    end;

    if p19.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p19.Is_Dodging then
        return false, "Dodging";
    end;

    if p19.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u13.Activate(p20, p21) -- Line: 179
    -- upvalues: u13 (copy)
    if p20.IsInAir and p20:IsInAir() then
        u13._ActivateAir(p20, p21);

        return;
    end;

    u13._ActivateGround(p20, p21);
end;

function u13._ActivateGround(u22, p23) -- Line: 189
    -- upvalues: u13 (copy), SharedUtils (copy)
    local v24 = u13._EnsureAnimation(u22, u13.AnimationName);

    if not v24 then
        warn("[Sky Crash] Ground animation not found");

        return;
    end;

    u22.Is_Using_Skill = true;
    u22.Is_Attacking = true;

    for i, v in u22.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    u13._DoCastDash(u22);
    v24:Play(0, 1, 1);
    local u25 = {};

    local function disconnectAll() -- Line: 215
        -- upvalues: u25 (copy)
        for _, v in u25 do
            v:Disconnect();
        end;

        table.clear(u25);
    end;

    local u26 = false;

    local function releaseState() -- Line: 221
        -- upvalues: u26 (ref), u22 (copy)
        if u26 then
            return;
        end;

        u26 = true;
        local ClassData = u22.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u22, nil);
        end;

        u22.Is_Using_Skill = false;
        u22.Is_Attacking = false;
    end;

    local function emitVFX(p27) -- Line: 234
        -- upvalues: u22 (copy), u13 (ref)
        if not p27 or p27 == "" then
            return;
        end;

        local v28 = u22.Character and u22.Character:FindFirstChild("HumanoidRootPart");

        if not v28 then
            return;
        end;

        u22:PlayEffectModule(u13.GroundEffectModule, "Emit", v28.CFrame, p27);
    end;

    u25[#u25 + 1] = v24:GetMarkerReachedSignal("VFX"):Connect(emitVFX);
    u25[#u25 + 1] = v24:GetMarkerReachedSignal("VFX_2"):Connect(emitVFX);
    u25[#u25 + 1] = v24:GetMarkerReachedSignal("hit"):Connect(function(p29) -- Line: 244
        -- upvalues: u22 (copy), SharedUtils (ref), u13 (ref)
        local v30 = u22.Character and u22.Character:FindFirstChild("HumanoidRootPart");

        if v30 then
            SharedUtils.PlaySoundAt(v30, u13.GroundHitSFX, u13.GroundHitVolume);
        end;

        u22:ShakeCamera("Hit");
        u13._PerformHit(u22, u13.DamageMultiplier, u13.HitboxSize, u13.HitboxRange);
    end);
    u25[#u25 + 1] = v24:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v24.Stopped:Once(function() -- Line: 259
        -- upvalues: u26 (ref), u22 (copy), u25 (copy)
        if not u26 then
            u26 = true;
            local ClassData = u22.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u22, nil);
            end;

            u22.Is_Using_Skill = false;
            u22.Is_Attacking = false;
        end;

        for _, v in u25 do
            v:Disconnect();
        end;

        table.clear(u25);
    end);
    task.delay(u13.MaxDuration, function() -- Line: 264
        -- upvalues: u26 (ref), u22 (copy), u25 (copy)
        if not u26 then
            u26 = true;
            local ClassData = u22.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u22, nil);
            end;

            u22.Is_Using_Skill = false;
            u22.Is_Attacking = false;
        end;

        for _, v in u25 do
            v:Disconnect();
        end;

        table.clear(u25);
    end);
end;

function u13._ActivateAir(u31, p32) -- Line: 271
    -- upvalues: u13 (copy), SharedUtils (copy)
    local v33 = u13._EnsureAnimation(u31, u13.AirAnimationName);

    if not v33 then
        warn("[Sky Crash] Air animation not found");

        return;
    end;

    u31.Is_Using_Skill = true;
    u31.Is_Attacking = true;

    for i, v in u31.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v33:Play(0, 1, 1);
    u13._Dive(u31);
    local u34 = {};

    local function _() -- Line: 297
        -- upvalues: u34 (copy)
        for _, v in u34 do
            v:Disconnect();
        end;

        table.clear(u34);
    end;

    local u35 = false;

    local function v36() -- Line: 303
        -- upvalues: u35 (ref), u31 (copy)
        if u35 then
            return;
        end;

        u35 = true;
        local ClassData = u31.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u31, nil);
        end;

        u31.Is_Using_Skill = false;
        u31.Is_Attacking = false;
    end;

    local function v39(p37) -- Line: 316
        -- upvalues: u31 (copy), u13 (ref)
        if not p37 or p37 == "" then
            return;
        end;

        local v38 = u31.Character and u31.Character:FindFirstChild("HumanoidRootPart");

        if not v38 then
            return;
        end;

        u31:PlayEffectModule(u13.AirEffectModule, "Emit", v38.CFrame, p37);
    end;

    u34[#u34 + 1] = v33:GetMarkerReachedSignal("VFX"):Connect(v39);
    u34[#u34 + 1] = v33:GetMarkerReachedSignal("VFX_2"):Connect(v39);
    local u40 = 0;
    u34[#u34 + 1] = v33:GetMarkerReachedSignal("hit"):Connect(function(p41) -- Line: 327
        -- upvalues: u40 (ref), u31 (copy), SharedUtils (ref), u13 (ref)
        u40 = u40 + 1;
        local v42 = u31.Character and u31.Character:FindFirstChild("HumanoidRootPart");

        if u40 == 1 and v42 then
            SharedUtils.PlaySoundAt(v42, u13.AirFirstHitSFX, u13.AirFirstHitVolume);
        end;

        u31:ShakeCamera("Hit");
        u13._PerformHit(u31, u13.AirDamageMultiplier, u13.AirHitboxSize, u13.AirHitboxRange);
    end);
    u34[#u34 + 1] = v33:GetMarkerReachedSignal("DBreset"):Connect(v36);
    v33.Stopped:Once(function() -- Line: 344
        -- upvalues: u35 (ref), u31 (copy), u34 (copy)
        if not u35 then
            u35 = true;
            local ClassData = u31.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u31, nil);
            end;

            u31.Is_Using_Skill = false;
            u31.Is_Attacking = false;
        end;

        for _, v in u34 do
            v:Disconnect();
        end;

        table.clear(u34);
    end);
    task.delay(u13.MaxDuration, function() -- Line: 349
        -- upvalues: u35 (ref), u31 (copy), u34 (copy)
        if not u35 then
            u35 = true;
            local ClassData = u31.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u31, nil);
            end;

            u31.Is_Using_Skill = false;
            u31.Is_Attacking = false;
        end;

        for _, v in u34 do
            v:Disconnect();
        end;

        table.clear(u34);
    end);
end;

return u13;