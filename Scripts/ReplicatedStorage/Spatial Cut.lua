--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Spatial Cut
  Path:     game.ReplicatedStorage.Classes.Azure Devil.Skills.Spatial Cut
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:50 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u7 = {
    Cooldown = 4,
    MaxCharges = 3,
    DamageMultiplier = 1.8,
    AnimationName = "Ability_1",
    HitboxSize = Vector3.new(25, 10, 35),
    HitboxRange = 35,
    DashSpeed = 70,
    DashDuration = 0.15,
    AirAnimationName = "Ability_1_Air",
    AirHitboxSize = Vector3.new(20, 30, 30),
    AirHitboxRange = 30,
    AirFreezeTime = 0.15,
    AirSlamSpeed = 120,
    AirSlamDuration = 0.45,
    HitUltemaVolume = 0.8,
    SheatheVolume = 0.8,
    JudgementVolume = 0.8,
    MaxDuration = 1.2,

    _EnsureAnimation = function(p1, p2) -- Line: 70, Name: _EnsureAnimation
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
    end
};

function u7._PerformHit(p8, p9, p10) -- Line: 97
    -- upvalues: u7 (copy)
    local HitboxSize = p8.ClassData.HitboxSize;
    local Range = p8.ClassData.Range;
    p8.ClassData.HitboxSize = p9;
    p8.ClassData.Range = p10;
    local v11 = p8:Hitbox();
    p8.ClassData.HitboxSize = HitboxSize;
    p8.ClassData.Range = Range;
    local v12 = 0;

    for _, v in v11 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p8:ApplyDamage(v, (p8:ResolveSkillDamage(u7.DamageMultiplier, v)));
            v12 = v12 + 1;
        end;
    end;

    return v12;
end;

function u7._AirLaunch(u13) -- Line: 124
    -- upvalues: u7 (copy), Debris (copy)
    local Character = u13.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SpatialCutAirFreeze";
    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
    BodyVelocity.Velocity = Vector3.new(0, 0, 0);
    BodyVelocity.Parent = Character;
    task.delay(u7.AirFreezeTime, function() -- Line: 135
        -- upvalues: BodyVelocity (copy), u13 (copy), u7 (ref), Debris (ref)
        if BodyVelocity then
            BodyVelocity:Destroy();
        end;

        local v14 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if not v14 then
            return;
        end;

        local BodyVelocity2 = Instance.new("BodyVelocity");
        BodyVelocity2.Name = "SpatialCutAirSlam";
        BodyVelocity2.MaxForce = Vector3.new(100000, 100000, 100000);
        BodyVelocity2.Velocity = Vector3.new(0, -u7.AirSlamSpeed, 0);
        BodyVelocity2.Parent = v14;
        Debris:AddItem(BodyVelocity2, u7.AirSlamDuration);
    end);
end;

function u7._Dash(p15) -- Line: 151
    -- upvalues: u7 (copy), Debris (copy)
    local Character = p15.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local Humanoid = p15.Humanoid;
    local v16;

    if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
        v16 = Humanoid.MoveDirection.Unit;
    else
        v16 = Character.CFrame.LookVector;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v16 * u7.DashSpeed;
    BodyVelocity.Parent = Character;
    Debris:AddItem(BodyVelocity, u7.DashDuration);
end;

function u7.CanActivate(p17) -- Line: 175
    if p17.Is_Attacking then
        return false, "Attacking";
    end;

    if p17.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p17.Is_Dodging then
        return false, "Dodging";
    end;

    if p17.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u7.Activate(p18, p19) -- Line: 185
    -- upvalues: u7 (copy)
    if p18.IsInAir and p18:IsInAir() then
        u7._ActivateAir(p18, p19);

        return;
    end;

    u7._ActivateGround(p18, p19);
end;

function u7._ActivateGround(u20, p21) -- Line: 195
    -- upvalues: u7 (copy), SharedUtils (copy)
    local v22 = u7._EnsureAnimation(u20, u7.AnimationName);

    if not v22 then
        warn("[Spatial Cut] Ground animation not found");

        return;
    end;

    u20.Is_Using_Skill = true;
    u20.Is_Attacking = true;

    for i, v in u20.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v22:Play(0, 1, 1);
    local u23 = {};

    local function disconnectAll() -- Line: 218
        -- upvalues: u23 (copy)
        for _, v in u23 do
            v:Disconnect();
        end;

        table.clear(u23);
    end;

    local u24 = false;

    local function releaseState() -- Line: 227
        -- upvalues: u24 (ref), u20 (copy)
        if u24 then
            return;
        end;

        u24 = true;
        local ClassData = u20.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u20, nil);
        end;

        u20.Is_Using_Skill = false;
        u20.Is_Attacking = false;
    end;

    u23[#u23 + 1] = v22:GetMarkerReachedSignal("hit"):Connect(function(p25) -- Line: 240
        -- upvalues: u20 (copy), SharedUtils (ref), u7 (ref)
        local v26 = u20.Character and u20.Character:FindFirstChild("HumanoidRootPart");

        if v26 then
            SharedUtils.PlaySoundAt(v26, "Judgement_Cut", u7.JudgementVolume);
        end;

        u20:PlayFX("Judgement");
        u20:ShakeCamera("SkillMedium");
        u7._Dash(u20);
        u7._PerformHit(u20, u7.HitboxSize, u7.HitboxRange);
    end);
    u23[#u23 + 1] = v22:GetMarkerReachedSignal("sheathe"):Connect(function() -- Line: 253
        -- upvalues: u20 (copy), SharedUtils (ref), u7 (ref)
        local v27 = u20.Character and u20.Character:FindFirstChild("HumanoidRootPart");

        if v27 then
            SharedUtils.PlaySoundAt(v27, "Sheathe_1", u7.SheatheVolume);
        end;
    end);
    u23[#u23 + 1] = v22:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v22.Stopped:Once(function() -- Line: 265
        -- upvalues: u24 (ref), u20 (copy), u23 (copy)
        if not u24 then
            u24 = true;
            local ClassData = u20.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u20, nil);
            end;

            u20.Is_Using_Skill = false;
            u20.Is_Attacking = false;
        end;

        for _, v in u23 do
            v:Disconnect();
        end;

        table.clear(u23);
    end);
    task.delay(u7.MaxDuration, function() -- Line: 270
        -- upvalues: u24 (ref), u20 (copy), u23 (copy)
        if not u24 then
            u24 = true;
            local ClassData = u20.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u20, nil);
            end;

            u20.Is_Using_Skill = false;
            u20.Is_Attacking = false;
        end;

        for _, v in u23 do
            v:Disconnect();
        end;

        table.clear(u23);
    end);
end;

function u7._ActivateAir(u28, p29) -- Line: 277
    -- upvalues: u7 (copy), SharedUtils (copy)
    local v30 = u7._EnsureAnimation(u28, u7.AirAnimationName);

    if not v30 then
        warn("[Spatial Cut] Air animation not found");

        return;
    end;

    u28.Is_Using_Skill = true;
    u28.Is_Attacking = true;

    for i, v in u28.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v30:Play(0, 1, 1);
    u7._AirLaunch(u28);
    local u31 = {};

    local function _() -- Line: 303
        -- upvalues: u31 (copy)
        for _, v in u31 do
            v:Disconnect();
        end;

        table.clear(u31);
    end;

    local u32 = false;

    local function v33() -- Line: 309
        -- upvalues: u32 (ref), u28 (copy)
        if u32 then
            return;
        end;

        u32 = true;
        local ClassData = u28.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u28, nil);
        end;

        u28.Is_Using_Skill = false;
        u28.Is_Attacking = false;
    end;

    u31[#u31 + 1] = v30:GetMarkerReachedSignal("hit"):Connect(function(p34) -- Line: 321
        -- upvalues: u28 (copy), SharedUtils (ref), u7 (ref)
        local v35 = u28.Character and u28.Character:FindFirstChild("HumanoidRootPart");

        if v35 then
            SharedUtils.PlaySoundAt(v35, "hit_ultema_s_1", u7.HitUltemaVolume);
        end;

        u28:PlayFX("Final_Slash");
        u28:ShakeCamera("SkillMedium");
        u7._PerformHit(u28, u7.AirHitboxSize, u7.AirHitboxRange);
    end);
    u31[#u31 + 1] = v30:GetMarkerReachedSignal("DBreset"):Connect(v33);
    v30.Stopped:Once(function() -- Line: 336
        -- upvalues: u32 (ref), u28 (copy), u31 (copy)
        if not u32 then
            u32 = true;
            local ClassData = u28.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u28, nil);
            end;

            u28.Is_Using_Skill = false;
            u28.Is_Attacking = false;
        end;

        for _, v in u31 do
            v:Disconnect();
        end;

        table.clear(u31);
    end);
    task.delay(u7.MaxDuration, function() -- Line: 341
        -- upvalues: u32 (ref), u28 (copy), u31 (copy)
        if not u32 then
            u32 = true;
            local ClassData = u28.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u28, nil);
            end;

            u28.Is_Using_Skill = false;
            u28.Is_Attacking = false;
        end;

        for _, v in u31 do
            v:Disconnect();
        end;

        table.clear(u31);
    end);
end;

return u7;