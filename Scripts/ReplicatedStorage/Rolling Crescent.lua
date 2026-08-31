--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Rolling Crescent
  Path:     game.ReplicatedStorage.Classes.Shadow Vagrant.Skills.Rolling Crescent
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:48 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u14 = {
    Cooldown = 7,
    AnimationName = "Ability_2",
    HoldAnimationName = "Ability_2_Hold",
    EffectModule = "Rolling_Crescent",
    Skill_SFX = nil,
    HitSFX = "hit_ultema_s_1",
    HitVolume = 1,
    DamageMultiplier = 0.83,
    HitboxSize = Vector3.new(24, 16, 26),
    HitboxRange = 14,
    HoldDamageMultiplier = 4,
    HoldHitboxSize = Vector3.new(25, 40, 40),
    HoldHitboxRange = 10,
    LiftSpeed = 110,
    LiftDuration = 0.1,
    HoldMaxDuration = 3,
    MaxDuration = 2,

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
    end,

    CanActivate = function(p13) -- Line: 134, Name: CanActivate
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
    end
};

function u14.Activate(u15, p16) -- Line: 145
    -- upvalues: u14 (copy), SharedUtils (copy)
    local v17 = u14._EnsureAnimation(u15, u14.AnimationName);

    if not v17 then
        warn("[Rolling Crescent] Ground animation not found");

        return;
    end;

    local Character = u15.Character;

    if not Character then
        return;
    end;

    u15.Is_Using_Skill = true;
    u15.Is_Attacking = true;
    Character:SetAttribute("Parry", true);

    for i, v in u15.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v17:Play(0, 1, 1);
    local u18 = {};

    local function disconnectAll() -- Line: 174
        -- upvalues: u18 (copy)
        for _, v in u18 do
            v:Disconnect();
        end;

        table.clear(u18);
    end;

    local function clearParry() -- Line: 179
        -- upvalues: u15 (copy)
        if u15.Character then
            u15.Character:SetAttribute("Parry", false);
        end;
    end;

    local u19 = false;

    local function releaseState() -- Line: 184
        -- upvalues: u19 (ref), u15 (copy)
        if u19 then
            return;
        end;

        u19 = true;
        u15.Is_Using_Skill = false;
        u15.Is_Attacking = false;
    end;

    local function cleanup() -- Line: 192
        -- upvalues: u19 (ref), u15 (copy), u18 (copy)
        if not u19 then
            u19 = true;
            u15.Is_Using_Skill = false;
            u15.Is_Attacking = false;
        end;

        if u15.Character then
            u15.Character:SetAttribute("Parry", false);
        end;

        for _, v in u18 do
            v:Disconnect();
        end;

        table.clear(u18);
    end;

    u18[#u18 + 1] = v17:GetMarkerReachedSignal("VFX"):Connect(function(p20) -- Line: 200
        -- upvalues: u15 (copy), u14 (ref)
        if not p20 or p20 == "" then
            return;
        end;

        local v21 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

        if not v21 then
            return;
        end;

        u15:PlayEffectModule(u14.EffectModule, "Emit", v21.CFrame, p20);
    end);
    u18[#u18 + 1] = v17:GetMarkerReachedSignal("hit"):Connect(function(p22) -- Line: 208
        -- upvalues: u15 (copy), SharedUtils (ref), u14 (ref)
        local v23 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

        if v23 then
            SharedUtils.PlaySoundAt(v23, u14.HitSFX, u14.HitVolume);
        end;

        u15:ShakeCamera("Hit");
        u14._PerformHit(u15, u14.DamageMultiplier, u14.HitboxSize, u14.HitboxRange);
    end);
    u18[#u18 + 1] = v17:GetMarkerReachedSignal("DBreset"):Connect(cleanup);
    v17.Stopped:Once(cleanup);
    task.delay(u14.MaxDuration, cleanup);
end;

function u14.ActivateHold(u24, p25) -- Line: 234
    -- upvalues: u14 (copy), SharedUtils (copy)
    local v26 = u14._EnsureAnimation(u24, u14.HoldAnimationName);

    if not v26 then
        warn("[Rolling Crescent] Hold animation not found");

        return;
    end;

    local Character = u24.Character;
    local v27;

    if Character then
        v27 = Character:FindFirstChild("HumanoidRootPart");
    else
        v27 = Character;
    end;

    if not v27 then
        return;
    end;

    u24.Is_Using_Skill = true;
    u24.Is_Attacking = true;
    Character:SetAttribute("Parry", true);

    for i, v in u24.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v26:Play(0, 1, 1);
    local u28 = nil;

    local function releaseAirHold() -- Line: 268
        -- upvalues: u28 (ref)
        if u28 then
            u28:Destroy();
            u28 = nil;
        end;
    end;

    local u29 = {};

    local function _() -- Line: 277
        -- upvalues: u29 (copy)
        for _, v in u29 do
            v:Disconnect();
        end;

        table.clear(u29);
    end;

    local function _() -- Line: 282
        -- upvalues: u24 (copy)
        if u24.Character then
            u24.Character:SetAttribute("Parry", false);
        end;
    end;

    local u30 = false;

    local function _() -- Line: 287
        -- upvalues: u30 (ref), u24 (copy)
        if u30 then
            return;
        end;

        u30 = true;
        u24.Is_Using_Skill = false;
        u24.Is_Attacking = false;
    end;

    local function v31() -- Line: 295
        -- upvalues: u28 (ref), u30 (ref), u24 (copy), u29 (copy)
        if u28 then
            u28:Destroy();
            u28 = nil;
        end;

        if not u30 then
            u30 = true;
            u24.Is_Using_Skill = false;
            u24.Is_Attacking = false;
        end;

        if u24.Character then
            u24.Character:SetAttribute("Parry", false);
        end;

        for _, v in u29 do
            v:Disconnect();
        end;

        table.clear(u29);
    end;

    u29[#u29 + 1] = v26:GetMarkerReachedSignal("jump"):Connect(function() -- Line: 303
        -- upvalues: u28 (ref), u30 (ref), u24 (copy), u14 (ref)
        if u28 or u30 then
            return;
        end;

        local v32 = u24.Character and u24.Character:FindFirstChild("HumanoidRootPart");

        if not v32 then
            return;
        end;

        u28 = Instance.new("BodyVelocity");
        u28.Name = "RollingCrescentLift";
        u28.MaxForce = Vector3.new(100000, 100000, 100000);
        u28.Velocity = Vector3.new(0, u14.LiftSpeed, 0);
        u28.Parent = v32;
        u24:ShakeCamera("SkillLight");
        task.delay(u14.LiftDuration, function() -- Line: 314
            -- upvalues: u28 (ref)
            if u28 and u28.Parent then
                u28.Velocity = Vector3.new(0, 0, 0);
            end;
        end);
    end);
    u29[#u29 + 1] = v26:GetMarkerReachedSignal("VFX"):Connect(function(p33) -- Line: 325
        -- upvalues: u24 (copy), u14 (ref)
        if not p33 or p33 == "" then
            return;
        end;

        local v34 = u24.Character and u24.Character:FindFirstChild("HumanoidRootPart");

        if not v34 then
            return;
        end;

        u24:PlayEffectModule(u14.EffectModule, "Emit", v34.CFrame, p33);
    end);
    u29[#u29 + 1] = v26:GetMarkerReachedSignal("hit"):Connect(function(p35) -- Line: 333
        -- upvalues: u24 (copy), SharedUtils (ref), u14 (ref)
        local v36 = u24.Character and u24.Character:FindFirstChild("HumanoidRootPart");

        if v36 then
            SharedUtils.PlaySoundAt(v36, u14.HitSFX, u14.HitVolume);
        end;

        u24:ShakeCamera("SkillHeavy");
        u14._PerformHit(u24, u14.HoldDamageMultiplier, u14.HoldHitboxSize, u14.HoldHitboxRange);
    end);
    u29[#u29 + 1] = v26:GetMarkerReachedSignal("DBreset"):Connect(v31);
    v26.Stopped:Once(v31);
    task.delay(u14.HoldMaxDuration, v31);
end;

return u14;