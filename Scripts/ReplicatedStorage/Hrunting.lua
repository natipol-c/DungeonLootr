--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Hrunting
  Path:     game.ReplicatedStorage.Classes.Forge Archon.Skills.Hrunting
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:58 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u7 = {
    Cooldown = 9,
    AnimationName = "Ability_3",
    AirAnimationName = "Ability_3_Air",
    EffectModule = "Hrunting",
    DamageMultiplier = 4,
    HitboxSize = Vector3.new(30, 40, 45),
    HitboxRange = 40,
    LiftSpeed = 130,
    LiftDuration = 0.08,
    IFrameDuration = 0.6,
    ChargeSFX = "Fire_Woosh",
    ChargeVol = 0.9,
    HitSFX = "Red_Fast",
    HitVol = 0.9,
    MaxDuration = 2.5,

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
    end
};

function u7._PerformHit(p8) -- Line: 98
    -- upvalues: u7 (copy)
    local HitboxSize = p8.ClassData.HitboxSize;
    local Range = p8.ClassData.Range;
    p8.ClassData.HitboxSize = u7.HitboxSize;
    p8.ClassData.Range = u7.HitboxRange;
    local v9 = p8:Hitbox();
    p8.ClassData.HitboxSize = HitboxSize;
    p8.ClassData.Range = Range;

    for _, v in v9 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p8:ApplyDamage(v, (p8:ResolveSkillDamage(u7.DamageMultiplier, v)));
        end;
    end;
end;

function u7.CanActivate(p10) -- Line: 120
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

function u7.Activate(p11, p12) -- Line: 131
    -- upvalues: u7 (copy)
    if p11.IsInAir and p11:IsInAir() then
        u7._Run(p11, p12, u7.AirAnimationName, false);

        return;
    end;

    u7._Run(p11, p12, u7.AnimationName, true);
end;

function u7._Run(u13, p14, p15, p16) -- Line: 141
    -- upvalues: u7 (copy), SharedUtils (copy)
    local v17 = u7._EnsureAnimation(u13, p15);

    if not v17 then
        warn((`[Hrunting] Animation "{p15}" not found`));

        return;
    end;

    local Character = u13.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u13.Is_Using_Skill = true;
    u13.Is_Attacking = true;

    if u13.ClassData and u13.ClassData.EnterBowMode then
        u13.ClassData.EnterBowMode(u13);
    end;

    for i, v in u13.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    local u18 = 0;

    local function grantIFrame() -- Line: 171
        -- upvalues: u18 (ref), u13 (copy), u7 (ref)
        u18 = u18 + 1;
        local u19 = u18;

        if u13.Player then
            u13.Player:SetAttribute("iFrame", true);
        end;

        if u13.Character then
            u13.Character:SetAttribute("iFrame", true);
        end;

        task.delay(u7.IFrameDuration, function() -- Line: 176
            -- upvalues: u19 (copy), u18 (ref), u13 (ref)
            if u19 ~= u18 then
                return;
            end;

            if u13.Player then
                u13.Player:SetAttribute("iFrame", false);
            end;

            if u13.Character then
                u13.Character:SetAttribute("iFrame", false);
            end;
        end);
    end;

    local function clearIFrame() -- Line: 182
        -- upvalues: u18 (ref), u13 (copy)
        u18 = u18 + 1;

        if u13.Player then
            u13.Player:SetAttribute("iFrame", false);
        end;

        if u13.Character then
            u13.Character:SetAttribute("iFrame", false);
        end;
    end;

    grantIFrame();
    local u20 = nil;

    local function releaseAirHold() -- Line: 194
        -- upvalues: u20 (ref)
        if u20 then
            u20:Destroy();
            u20 = nil;
        end;
    end;

    local function freezeHRP() -- Line: 203
        -- upvalues: u20 (ref), u13 (copy)
        if u20 then
            u20:Destroy();
            u20 = nil;
        end;

        local v21 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v21 then
            v21.Anchored = true;
        end;
    end;

    local function unfreezeHRP() -- Line: 208
        -- upvalues: u13 (copy)
        local v22 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v22 and v22.Parent then
            v22.Anchored = false;
        end;
    end;

    v17:Play(0, 1, 1);
    local u23 = {};

    local function disconnectAll() -- Line: 218
        -- upvalues: u23 (copy)
        for _, v in u23 do
            v:Disconnect();
        end;

        table.clear(u23);
    end;

    local u24 = false;

    local function releaseState() -- Line: 224
        -- upvalues: u24 (ref), u13 (copy)
        if u24 then
            return;
        end;

        u24 = true;
        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;
    end;

    local function cleanup() -- Line: 232
        -- upvalues: u13 (copy), u20 (ref), u18 (ref), u24 (ref), u23 (copy)
        local v25 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v25 and v25.Parent then
            v25.Anchored = false;
        end;

        if u20 then
            u20:Destroy();
            u20 = nil;
        end;

        u18 = u18 + 1;

        if u13.Player then
            u13.Player:SetAttribute("iFrame", false);
        end;

        if u13.Character then
            u13.Character:SetAttribute("iFrame", false);
        end;

        if not u24 then
            u24 = true;
            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        for _, v in u23 do
            v:Disconnect();
        end;

        table.clear(u23);
    end;

    if p16 then
        u23[#u23 + 1] = v17:GetMarkerReachedSignal("jump"):Connect(function() -- Line: 242
            -- upvalues: u20 (ref), u24 (ref), u13 (copy), grantIFrame (copy), u7 (ref)
            if u20 or u24 then
                return;
            end;

            local v26 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

            if not v26 then
                return;
            end;

            grantIFrame();
            u20 = Instance.new("BodyVelocity");
            u20.Name = "HruntingLift";
            u20.MaxForce = Vector3.new(100000, 100000, 100000);
            u20.Velocity = Vector3.new(0, u7.LiftSpeed, 0);
            u20.Parent = v26;
            u13:ShakeCamera("SkillLight");
            task.delay(u7.LiftDuration, function() -- Line: 255
                -- upvalues: u20 (ref)
                if u20 and u20.Parent then
                    u20.Velocity = Vector3.new(0, 0, 0);
                end;
            end);
        end);
    end;

    u23[#u23 + 1] = v17:GetMarkerReachedSignal("charge"):Connect(function() -- Line: 264
        -- upvalues: u13 (copy), SharedUtils (ref), u7 (ref), u20 (ref)
        local v27 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v27 then
            SharedUtils.PlaySoundAt(v27, u7.ChargeSFX, u7.ChargeVol);
        end;

        if u20 then
            u20:Destroy();
            u20 = nil;
        end;

        local v28 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v28 then
            v28.Anchored = true;
        end;
    end);

    local function emitVFX(p29) -- Line: 276
        -- upvalues: u13 (copy), u7 (ref)
        if not p29 or p29 == "" then
            return;
        end;

        local v30 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if not v30 then
            return;
        end;

        u13:PlayEffectModule(u7.EffectModule, "Emit", v30.CFrame, p29);
    end;

    u23[#u23 + 1] = v17:GetMarkerReachedSignal("VFX"):Connect(emitVFX);
    u23[#u23 + 1] = v17:GetMarkerReachedSignal("VFX_2"):Connect(emitVFX);
    u23[#u23 + 1] = v17:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 286
        -- upvalues: u13 (copy), SharedUtils (ref), u7 (ref)
        local v31 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v31 then
            SharedUtils.PlaySoundAt(v31, u7.HitSFX, u7.HitVol);
        end;

        u13:ShakeCamera("SkillHeavy");
        u7._PerformHit(u13);
    end);
    u23[#u23 + 1] = v17:GetMarkerReachedSignal("DBreset"):Connect(cleanup);
    v17.Stopped:Once(cleanup);
    task.delay(u7.MaxDuration, cleanup);
end;

return u7;