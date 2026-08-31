--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Spatial Divide
  Path:     game.ReplicatedStorage.Classes.Awakened Devil EX.Skills.Spatial Divide
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
    Cooldown = 4,
    MaxCharges = 3,
    DamageMultiplier = 0.75,
    AnimationName = "Ability_2",
    TapEffectModule = "Spatial_Divide_Tap",
    HitboxSize = Vector3.new(25, 10, 35),
    HitboxRange = 35,
    DashSpeed = 70,
    DashDuration = 0.15,
    HoldAnimationName = "Ability_2_Hold",
    HoldEffectModule = "Spatial_Divide_Hold",
    HoldDamageMultiplier = 3,
    HoldHitboxSize = Vector3.new(20, 18, 26),
    HoldHitboxRange = 24,
    HoldCastSFX = { "Sonido", "claw3" },
    HoldCastVolume = 1,
    LiftSpeed = 110,
    LiftDuration = 0.1,
    HoldMaxDuration = 3,
    SheatheVolume = 0.8,
    JudgementVolume = 0.8,
    MaxDuration = 1.5,

    _EnsureAnimation = function(p1, p2) -- Line: 81, Name: _EnsureAnimation
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

    _PerformHit = function(p7, p8, p9, p10) -- Line: 108, Name: _PerformHit
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

function u13._Dash(p14) -- Line: 133
    -- upvalues: u13 (copy), Debris (copy)
    local Character = p14.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local Humanoid = p14.Humanoid;
    local v15;

    if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
        v15 = Humanoid.MoveDirection.Unit;
    else
        v15 = Character.CFrame.LookVector;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v15 * u13.DashSpeed;
    BodyVelocity.Parent = Character;
    Debris:AddItem(BodyVelocity, u13.DashDuration);
end;

function u13.CanActivate(p16) -- Line: 157
    if p16.Is_Attacking then
        return false, "Attacking";
    end;

    if p16.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p16.Is_Dodging then
        return false, "Dodging";
    end;

    if p16.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u13.Activate(u17, p18) -- Line: 166
    -- upvalues: u13 (copy), SharedUtils (copy)
    local v19 = u13._EnsureAnimation(u17, u13.AnimationName);

    if not v19 then
        warn("[Spatial Divide] Animation not found");

        return;
    end;

    u17.Is_Using_Skill = true;
    u17.Is_Attacking = true;

    for i, v in u17.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v19:Play(0, 1, 1);
    local u20 = {};

    local function disconnectAll() -- Line: 189
        -- upvalues: u20 (copy)
        for _, v in u20 do
            v:Disconnect();
        end;

        table.clear(u20);
    end;

    local u21 = false;

    local function releaseState() -- Line: 195
        -- upvalues: u21 (ref), u17 (copy)
        if u21 then
            return;
        end;

        u21 = true;
        local ClassData = u17.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u17, nil);
        end;

        u17.Is_Using_Skill = false;
        u17.Is_Attacking = false;
    end;

    local function emitVFX(p22) -- Line: 208
        -- upvalues: u17 (copy), u13 (ref)
        if not p22 or p22 == "" then
            return;
        end;

        local v23 = u17.Character and u17.Character:FindFirstChild("HumanoidRootPart");

        if not v23 then
            return;
        end;

        u17:PlayEffectModule(u13.TapEffectModule, "Emit", v23.CFrame, p22);
    end;

    u20[#u20 + 1] = v19:GetMarkerReachedSignal("VFX"):Connect(emitVFX);
    u20[#u20 + 1] = v19:GetMarkerReachedSignal("VFX_2"):Connect(emitVFX);
    local u24 = false;
    u20[#u20 + 1] = v19:GetMarkerReachedSignal("hit"):Connect(function(p25) -- Line: 220
        -- upvalues: u24 (ref), u17 (copy), SharedUtils (ref), u13 (ref)
        if not u24 then
            u24 = true;
            local v26 = u17.Character and u17.Character:FindFirstChild("HumanoidRootPart");

            if v26 then
                SharedUtils.PlaySoundAt(v26, "Judgement_Cut", u13.JudgementVolume);
            end;

            u13._Dash(u17);
        end;

        u17:ShakeCamera("SkillMedium");
        u13._PerformHit(u17, u13.DamageMultiplier, u13.HitboxSize, u13.HitboxRange);
    end);
    u20[#u20 + 1] = v19:GetMarkerReachedSignal("sheathe"):Connect(function() -- Line: 236
        -- upvalues: u17 (copy), SharedUtils (ref), u13 (ref)
        local v27 = u17.Character and u17.Character:FindFirstChild("HumanoidRootPart");

        if v27 then
            SharedUtils.PlaySoundAt(v27, "Sheathe_1", u13.SheatheVolume);
        end;
    end);
    u20[#u20 + 1] = v19:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v19.Stopped:Once(function() -- Line: 247
        -- upvalues: u21 (ref), u17 (copy), u20 (copy)
        if not u21 then
            u21 = true;
            local ClassData = u17.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u17, nil);
            end;

            u17.Is_Using_Skill = false;
            u17.Is_Attacking = false;
        end;

        for _, v in u20 do
            v:Disconnect();
        end;

        table.clear(u20);
    end);
    task.delay(u13.MaxDuration, function() -- Line: 252
        -- upvalues: u21 (ref), u17 (copy), u20 (copy)
        if not u21 then
            u21 = true;
            local ClassData = u17.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u17, nil);
            end;

            u17.Is_Using_Skill = false;
            u17.Is_Attacking = false;
        end;

        for _, v in u20 do
            v:Disconnect();
        end;

        table.clear(u20);
    end);
end;

function u13.ActivateHold(u28, p29) -- Line: 259
    -- upvalues: u13 (copy), SharedUtils (copy)
    local v30 = u13._EnsureAnimation(u28, u13.HoldAnimationName);

    if not v30 then
        warn("[Spatial Divide] Hold animation not found");

        return;
    end;

    local Character = u28.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u28.Is_Using_Skill = true;
    u28.Is_Attacking = true;

    for i, v in u28.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    for _, v in u13.HoldCastSFX do
        SharedUtils.PlaySoundAt(Character, v, u13.HoldCastVolume);
    end;

    u28:ShakeCamera("SkillMedium");
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SpatialDivideLift";
    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
    BodyVelocity.Velocity = Vector3.new(0, u13.LiftSpeed, 0);
    BodyVelocity.Parent = Character;
    task.delay(u13.LiftDuration, function() -- Line: 296
        -- upvalues: BodyVelocity (ref)
        if BodyVelocity and BodyVelocity.Parent then
            BodyVelocity.Velocity = Vector3.new(0, 0, 0);
        end;
    end);

    local function releaseAirHold() -- Line: 302
        -- upvalues: BodyVelocity (ref)
        if BodyVelocity then
            BodyVelocity:Destroy();
            BodyVelocity = nil;
        end;
    end;

    v30:Play(0, 1, 1);
    local u31 = {};

    local function _() -- Line: 314
        -- upvalues: u31 (copy)
        for _, v in u31 do
            v:Disconnect();
        end;

        table.clear(u31);
    end;

    local u32 = false;

    local function _() -- Line: 320
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

    local function v35(p33) -- Line: 333
        -- upvalues: u28 (copy), u13 (ref)
        if not p33 or p33 == "" then
            return;
        end;

        local v34 = u28.Character and u28.Character:FindFirstChild("HumanoidRootPart");

        if not v34 then
            return;
        end;

        u28:PlayEffectModule(u13.HoldEffectModule, "Emit", v34.CFrame, p33);
    end;

    u31[#u31 + 1] = v30:GetMarkerReachedSignal("VFX"):Connect(v35);
    u31[#u31 + 1] = v30:GetMarkerReachedSignal("VFX_2"):Connect(v35);
    u31[#u31 + 1] = v30:GetMarkerReachedSignal("hit"):Connect(function(p36) -- Line: 343
        -- upvalues: u28 (copy), u13 (ref)
        u28:ShakeCamera("Hit");
        u13._PerformHit(u28, u13.HoldDamageMultiplier, u13.HoldHitboxSize, u13.HoldHitboxRange);
    end);
    u31[#u31 + 1] = v30:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 350
        -- upvalues: BodyVelocity (ref), u32 (ref), u28 (copy)
        if BodyVelocity then
            BodyVelocity:Destroy();
            BodyVelocity = nil;
        end;

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
    end);

    local function fullCleanup() -- Line: 356
        -- upvalues: u32 (ref), u28 (copy), u31 (copy), BodyVelocity (ref)
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

        if BodyVelocity then
            BodyVelocity:Destroy();
            BodyVelocity = nil;
        end;
    end;

    v30.Stopped:Once(fullCleanup);
    task.delay(u13.HoldMaxDuration, fullCleanup);
end;

return u13;