--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Skull Splitter
  Path:     game.ReplicatedStorage.Classes.Greatsword.Skills.Skull Splitter
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:49 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 5,
    MaxCharges = 2,
    DamageMultiplier = 3.25,
    AnimationName = "Ability_1",
    Skill_SFX = nil,
    IFrameDuration = 0.5,
    DashSpeed = 80,
    DashDuration = 0.2,
    DashSFX = "Fire_Woosh",
    DashVolume = 1,
    HitSFX = "hit_sword_L",
    HitVolume = 1,
    HitboxSize = Vector3.new(25, 30, 30),
    MaxDuration = 2.5
};

function u1._EnsureAnimation(p2) -- Line: 54
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

function u1._PerformHit(p7) -- Line: 80
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    local v8 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    local v9 = 0;

    for _, v in v8 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v9 = v9 + 1;
        end;
    end;

    return v9;
end;

function u1.CanActivate(p10) -- Line: 103
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

function u1.Activate(u11, p12) -- Line: 111
    -- upvalues: u1 (copy), SharedUtils (copy), Debris (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Skull Splitter] Animation not found");

        return;
    end;

    local Character = u11.Character;
    local v14;

    if Character then
        v14 = Character:FindFirstChild("HumanoidRootPart");
    else
        v14 = Character;
    end;

    if not v14 then
        return;
    end;

    u11.Is_Using_Skill = true;
    u11.Is_Attacking = true;

    for i, v in u11.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    if u11.Player then
        u11.Player:SetAttribute("iFrame", true);
    end;

    Character:SetAttribute("iFrame", true);
    task.delay(u1.IFrameDuration, function() -- Line: 136
        -- upvalues: u11 (copy)
        local Player = u11.Player;
        local Character2 = u11.Character;

        if Player then
            Player:SetAttribute("iFrame", false);
        end;

        if Character2 then
            Character2:SetAttribute("iFrame", false);
        end;
    end);

    local function clearIFrame() -- Line: 143
        -- upvalues: u11 (copy)
        if u11.Player then
            u11.Player:SetAttribute("iFrame", false);
        end;

        if u11.Character then
            u11.Character:SetAttribute("iFrame", false);
        end;
    end;

    v13:Play(0, 1, 1);
    local u15 = {};

    local function disconnectAll() -- Line: 153
        -- upvalues: u15 (copy)
        for _, v in u15 do
            v:Disconnect();
        end;

        table.clear(u15);
    end;

    local u16 = false;
    u15[#u15 + 1] = v13:GetMarkerReachedSignal("jump"):Connect(function() -- Line: 163
        -- upvalues: u16 (ref), u11 (copy), SharedUtils (ref), u1 (ref), Debris (ref)
        if u16 then
            return;
        end;

        local v17 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if not v17 then
            return;
        end;

        u16 = true;
        SharedUtils.PlaySoundAt(v17, u1.DashSFX, u1.DashVolume);
        local _lastSkillDir = u11._lastSkillDir;

        if not _lastSkillDir then
            local v18 = u11.Humanoid and u11.Humanoid.MoveDirection;

            if v18 and v18.Magnitude > 0.1 then
                _lastSkillDir = v18.Unit;
            else
                _lastSkillDir = v17.CFrame.LookVector;
            end;
        end;

        local Vector3_new_ret = Vector3.new(_lastSkillDir.X, 0, _lastSkillDir.Z);
        local v19 = Vector3_new_ret.Magnitude > 0 and Vector3_new_ret.Unit or v17.CFrame.LookVector;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkullSplitter_Dash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v19 * u1.DashSpeed;
        BodyVelocity.Parent = v17;
        Debris:AddItem(BodyVelocity, u1.DashDuration);
    end);
    u15[#u15 + 1] = v13:GetMarkerReachedSignal("hit"):Connect(function(p20) -- Line: 195
        -- upvalues: u11 (copy), SharedUtils (ref), u1 (ref)
        local v21 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v21 then
            SharedUtils.PlaySoundAt(v21, u1.HitSFX, u1.HitVolume);
        end;

        if p20 == "" or not p20 then
            p20 = nil;
        end;

        u11:PlayTurnFX(p20);
        u11:ShakeCamera("SkillLight");
        u1._PerformHit(u11);
    end);
    local u22 = false;

    local function releaseState() -- Line: 209
        -- upvalues: u22 (ref), u11 (copy)
        if u22 then
            return;
        end;

        u22 = true;
        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;
    end;

    u15[#u15 + 1] = v13:GetMarkerReachedSignal("DBreset"):Connect(releaseState);

    local function fullCleanup() -- Line: 220
        -- upvalues: u22 (ref), u11 (copy), u15 (copy)
        if not u22 then
            u22 = true;
            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;
        end;

        if u11.Player then
            u11.Player:SetAttribute("iFrame", false);
        end;

        if u11.Character then
            u11.Character:SetAttribute("iFrame", false);
        end;

        for _, v in u15 do
            v:Disconnect();
        end;

        table.clear(u15);
    end;

    v13.Stopped:Once(fullCleanup);
    task.delay(u1.MaxDuration, fullCleanup);
end;

return u1;