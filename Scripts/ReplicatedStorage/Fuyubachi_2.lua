--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Fuyubachi
  Path:     game.ReplicatedStorage.Classes.Zero.Skills.Fuyubachi
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:57 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u14 = {
    Cooldown = 6,
    MaxCharges = 2,
    DamageMultiplier = 1,
    AnimationName = "Ability_3",
    Skill_SFX = nil,
    DashSpeed = 40,
    DashDuration = 0.2,
    ParryDuration = 0.5,
    HitboxSize = Vector3.new(20, 10, 20),
    HitboxRange = 20,
    MaxDuration = 1.5,
    AirAnimationName = "Ability_3_Air",
    AirDamageMultiplier = 0.5,
    AirHitboxSize = Vector3.new(30, 30, 45),
    AirHitboxRange = 35,
    AirSwingSFXFolder = "Power_Swing_Fast",
    SheatheVolume = 0.8,
    AirMaxDuration = 3.5,

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

function u14.Activate(p15, p16) -- Line: 144
    -- upvalues: u14 (copy)
    if p15.IsInAir and p15:IsInAir() then
        u14._ActivateAir(p15, p16);

        return;
    end;

    u14._ActivateGround(p15, p16);
end;

function u14._ActivateGround(u17, p18) -- Line: 155
    -- upvalues: u14 (copy), Debris (copy)
    local v19 = u14._EnsureAnimation(u17, u14.AnimationName);

    if not v19 then
        warn("[Fuyubachi] Ground animation not found");

        return;
    end;

    local Character = u17.Character;
    local v20;

    if Character then
        v20 = Character:FindFirstChild("HumanoidRootPart");
    else
        v20 = Character;
    end;

    if not v20 then
        return;
    end;

    u17.Is_Using_Skill = true;
    u17.Is_Attacking = true;

    for i, v in u17.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    u17:ShakeCamera("SkillLight");
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v20.CFrame.LookVector * u14.DashSpeed;
    BodyVelocity.Parent = v20;
    Debris:AddItem(BodyVelocity, u14.DashDuration);
    Character:SetAttribute("Parry", true);
    task.delay(u14.ParryDuration, function() -- Line: 189
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    v19:Play(0, 1, 1);
    local u22 = v19:GetMarkerReachedSignal("hit"):Connect(function(p21) -- Line: 200
        -- upvalues: u14 (ref), u17 (copy)
        u17:PlayCombatSound(u14.Skill_SFX or (u17.ClassData.SwingSoundFolder or "Sword_Swings"), nil, u17.ClassData.SwingVolume or 0.5);

        if p21 == "" or not p21 then
            p21 = nil;
        end;

        u17:PlayTurnFX(p21);
        u17:ShakeCamera("SkillLight");
        u14._PerformHit(u17, u14.DamageMultiplier, u14.HitboxSize, u14.HitboxRange);
    end);
    local u23 = false;

    local function releaseState() -- Line: 211
        -- upvalues: u23 (ref), u17 (copy)
        if u23 then
            return;
        end;

        u23 = true;
        u17.Is_Using_Skill = false;
        u17.Is_Attacking = false;
    end;

    local u24 = v19:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v19.Stopped:Once(function() -- Line: 222
        -- upvalues: u23 (ref), u17 (copy), u22 (ref), u24 (copy), Character (copy)
        if not u23 then
            u23 = true;
            u17.Is_Using_Skill = false;
            u17.Is_Attacking = false;
        end;

        if u22 then
            u22:Disconnect();
        end;

        if u24 then
            u24:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    task.delay(u14.MaxDuration, function() -- Line: 233
        -- upvalues: u23 (ref), u17 (copy), u22 (ref), u24 (copy), Character (copy)
        if not u23 then
            u23 = true;
            u17.Is_Using_Skill = false;
            u17.Is_Attacking = false;
        end;

        if u22 then
            u22:Disconnect();
        end;

        if u24 then
            u24:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
end;

function u14._ActivateAir(u25, p26) -- Line: 246
    -- upvalues: u14 (copy), SharedUtils (copy)
    local v27 = u14._EnsureAnimation(u25, u14.AirAnimationName);

    if not v27 then
        warn("[Fuyubachi] Air animation not found");

        return;
    end;

    local Character = u25.Character;
    local v28;

    if Character then
        v28 = Character:FindFirstChild("HumanoidRootPart");
    else
        v28 = Character;
    end;

    if not v28 then
        return;
    end;

    u25.Is_Using_Skill = true;
    u25.Is_Attacking = true;
    Character:SetAttribute("NoKnockback", true);

    for i, v in u25.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "FuyubachiAirLock";
    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
    BodyVelocity.Velocity = Vector3.new(0, 0, 0);
    BodyVelocity.Parent = v28;

    local function releaseAirHold() -- Line: 282
        -- upvalues: BodyVelocity (ref)
        if BodyVelocity then
            BodyVelocity:Destroy();
            BodyVelocity = nil;
        end;
    end;

    v27:Play(0, 1, 1);
    local u29 = {};

    local function disconnectAll() -- Line: 294
        -- upvalues: u29 (copy)
        for _, v in u29 do
            v:Disconnect();
        end;

        table.clear(u29);
    end;

    local u30 = false;

    local function _() -- Line: 300
        -- upvalues: u30 (ref), u25 (copy)
        if u30 then
            return;
        end;

        u30 = true;
        u25.Is_Using_Skill = false;
        u25.Is_Attacking = false;
    end;

    local function cleanup() -- Line: 308
        -- upvalues: BodyVelocity (ref), u30 (ref), u25 (copy), u29 (copy)
        if BodyVelocity then
            BodyVelocity:Destroy();
            BodyVelocity = nil;
        end;

        if not u30 then
            u30 = true;
            u25.Is_Using_Skill = false;
            u25.Is_Attacking = false;
        end;

        for _, v in u29 do
            v:Disconnect();
        end;

        table.clear(u29);

        if u25.Character then
            u25.Character:SetAttribute("NoKnockback", false);
        end;
    end;

    u29[#u29 + 1] = v27:GetMarkerReachedSignal("hit"):Connect(function(p31) -- Line: 319
        -- upvalues: u25 (copy), u14 (ref)
        u25:PlayCombatSound(u14.AirSwingSFXFolder, nil, u25.ClassData.SwingVolume or 0.5);

        if p31 == "" or not p31 then
            p31 = nil;
        end;

        u25:PlayTurnFX(p31);
        u25:ShakeCamera("SkillLight");
        u14._PerformHit(u25, u14.AirDamageMultiplier, u14.AirHitboxSize, u14.AirHitboxRange);
    end);
    u29[#u29 + 1] = v27:GetMarkerReachedSignal("sheathe"):Connect(function() -- Line: 328
        -- upvalues: u25 (copy), SharedUtils (ref), u14 (ref)
        local v32 = u25.Character and u25.Character:FindFirstChild("HumanoidRootPart");

        if v32 then
            SharedUtils.PlaySoundAt(v32, "Sheathe_1", u14.SheatheVolume);
        end;
    end);
    u29[#u29 + 1] = v27:GetMarkerReachedSignal("DBreset"):Connect(cleanup);
    v27.Stopped:Once(cleanup);
    task.delay(u14.AirMaxDuration, cleanup);
end;

return u14;