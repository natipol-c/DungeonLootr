--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Flickering Step
  Path:     game.ReplicatedStorage.Classes.Shadow Vagrant.Skills.Flickering Step
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:48 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 4,
    MaxCharges = 3,
    DamageMultiplier = 1.6,
    AnimationName = "Ability_1",
    EffectModule = "Flickering_Step",
    Skill_SFX = nil,
    DashSpeed = 92,
    DashDuration = 0.16,
    IFrameDuration = 0.5,
    ParryDuration = 0.35,
    CastSFX = "anime_explode",
    CastVolume = 0.8,
    HitSFX = "claw_slam_01",
    HitVolume = 0.9,
    HitFX = "ShadowVagrant_Skill_1",
    HitFXLifetime = 2,
    HitboxSize = Vector3.new(30, 30, 30),
    HitboxRange = 10,
    MaxDuration = 1.5
};

function u1._EnsureAnimation(p2) -- Line: 75
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

function u1._PerformHit(p7) -- Line: 102
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    p7.ClassData.Range = u1.HitboxRange;
    local v8 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;
    local v9 = 0;

    for _, v in v8 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v9 = v9 + 1;
        end;
    end;

    return v9;
end;

local function getHolderCFrame(p10) -- Line: 129
    local v11;

    if p10 then
        v11 = p10:FindFirstChild("Holder");
    else
        v11 = p10;
    end;

    if v11 and v11:IsA("PVInstance") then
        return v11:GetPivot();
    end;

    if p10 then
        p10 = p10.CFrame;
    end;

    return p10;
end;

function u1._SpawnHitFX(p12) -- Line: 140
    -- upvalues: ReplicatedStorage (copy), u1 (copy), Debris (copy)
    if not p12 then
        return;
    end;

    local v13 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Effects") and ReplicatedStorage.Assets.Effects:FindFirstChild(u1.HitFX);

    if not v13 then
        return;
    end;

    local u14 = v13:Clone();
    local v15;

    if p12 then
        v15 = p12:FindFirstChild("Holder");
    else
        v15 = p12;
    end;

    if v15 and v15:IsA("PVInstance") then
        p12 = v15:GetPivot();
    elseif p12 then
        p12 = p12.CFrame;
    end;

    if u14:IsA("BasePart") then
        u14.CFrame = p12;
    elseif u14:IsA("Model") then
        u14:PivotTo(p12);
    end;

    u14.Parent = workspace;
    task.delay(0.025, function() -- Line: 159
        -- upvalues: u14 (copy)
        if u14 and u14.Parent then
            u14:SetAttribute("Fire", true);
        end;
    end);
    Debris:AddItem(u14, u1.HitFXLifetime);
end;

function u1.CanActivate(p16) -- Line: 170
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

function u1.Activate(u17, p18) -- Line: 178
    -- upvalues: u1 (copy), Debris (copy), SharedUtils (copy)
    local v19 = u1._EnsureAnimation(u17);

    if not v19 then
        warn("[Flickering Step] Animation not found");

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
    Character:SetAttribute("Skill_Camera_Stabilize", true);

    for i, v in u17.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    local Humanoid = u17.Humanoid;
    local v21 = Humanoid and (Humanoid.MoveDirection.Magnitude > 0 and Humanoid.MoveDirection.Unit) or v20.CFrame.LookVector;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v21 * u1.DashSpeed;
    BodyVelocity.Parent = v20;
    Debris:AddItem(BodyVelocity, u1.DashDuration);

    if u17.Player then
        u17.Player:SetAttribute("iFrame", true);
    end;

    Character:SetAttribute("iFrame", true);
    task.delay(u1.IFrameDuration, function() -- Line: 222
        -- upvalues: u17 (copy)
        local Player = u17.Player;
        local Character2 = u17.Character;

        if Player then
            Player:SetAttribute("iFrame", false);
        end;

        if Character2 then
            Character2:SetAttribute("iFrame", false);
        end;
    end);
    SharedUtils.PlaySoundAt(v20, u1.CastSFX, u1.CastVolume);
    u17:ShakeCamera("SkillLight");
    v19:Play(0, 1, 1);
    local u22 = {};

    local function disconnectAll() -- Line: 240
        -- upvalues: u22 (copy)
        for _, v in u22 do
            v:Disconnect();
        end;

        table.clear(u22);
    end;

    local function clearIFrame() -- Line: 245
        -- upvalues: u17 (copy)
        if u17.Player then
            u17.Player:SetAttribute("iFrame", false);
        end;

        if u17.Character then
            u17.Character:SetAttribute("iFrame", false);
        end;
    end;

    local u23 = 0;

    local function grantHitParry() -- Line: 253
        -- upvalues: u23 (ref), u17 (copy), u1 (ref)
        u23 = u23 + 1;
        local u24 = u23;

        if u17.Character then
            u17.Character:SetAttribute("Parry", true);
        end;

        task.delay(u1.ParryDuration, function() -- Line: 257
            -- upvalues: u24 (copy), u23 (ref), u17 (ref)
            if u24 ~= u23 then
                return;
            end;

            if u17.Character then
                u17.Character:SetAttribute("Parry", false);
            end;
        end);
    end;

    local u25 = false;

    local function releaseState() -- Line: 266
        -- upvalues: u25 (ref), u17 (copy)
        if u25 then
            return;
        end;

        u25 = true;
        u17.Is_Using_Skill = false;
        u17.Is_Attacking = false;
    end;

    u22[#u22 + 1] = v19:GetMarkerReachedSignal("VFX"):Connect(function(p26) -- Line: 277
        -- upvalues: u17 (copy), u1 (ref)
        if not p26 or p26 == "" then
            return;
        end;

        local v27 = u17.Character and u17.Character:FindFirstChild("HumanoidRootPart");

        if not v27 then
            return;
        end;

        u17:PlayEffectModule(u1.EffectModule, "Emit", v27.CFrame, p26);
    end);
    u22[#u22 + 1] = v19:GetMarkerReachedSignal("hit"):Connect(function(p28) -- Line: 285
        -- upvalues: u17 (copy), SharedUtils (ref), u1 (ref), u23 (ref)
        local v29 = u17.Character and u17.Character:FindFirstChild("HumanoidRootPart");

        if v29 then
            SharedUtils.PlaySoundAt(v29, u1.HitSFX, u1.HitVolume);
        end;

        u17:ShakeCamera("Hit");
        u23 = u23 + 1;
        local u30 = u23;

        if u17.Character then
            u17.Character:SetAttribute("Parry", true);
        end;

        task.delay(u1.ParryDuration, function() -- Line: 257
            -- upvalues: u30 (copy), u23 (ref), u17 (ref)
            if u30 ~= u23 then
                return;
            end;

            if u17.Character then
                u17.Character:SetAttribute("Parry", false);
            end;
        end);
        u1._PerformHit(u17);
    end);
    u22[#u22 + 1] = v19:GetMarkerReachedSignal("DBreset"):Connect(releaseState);

    local function fullCleanup() -- Line: 304
        -- upvalues: u25 (ref), u17 (copy), u22 (copy)
        if not u25 then
            u25 = true;
            u17.Is_Using_Skill = false;
            u17.Is_Attacking = false;
        end;

        for _, v in u22 do
            v:Disconnect();
        end;

        table.clear(u22);

        if u17.Player then
            u17.Player:SetAttribute("iFrame", false);
        end;

        if u17.Character then
            u17.Character:SetAttribute("iFrame", false);
        end;

        if u17.Character then
            u17.Character:SetAttribute("Parry", false);
            u17.Character:SetAttribute("Skill_Camera_Stabilize", false);
        end;
    end;

    v19.Stopped:Once(fullCleanup);
    task.delay(u1.MaxDuration, fullCleanup);
end;

return u1;