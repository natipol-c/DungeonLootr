--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     8 Layered Demon Core
  Path:     game.ReplicatedStorage.Classes.Chaotic Fist.Skills.8 Layered Demon Core
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:58 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 12,
    DamageMultiplier = 0.5,
    AnimationName = "Ability_3",
    HitboxSize = Vector3.new(20, 10, 20),
    HitboxRange = 20,
    DashSpeed = 38,
    DashDuration = 0.15,
    DuplicateDelay = 0.1,
    CloneCount = 1,
    CloneInterval = 0.04,
    CloneFadeDuration = 0.6,
    CloneColor = Color3.fromRGB(148, 0, 211),
    CloneSpread = 4,
    FinalHitNumber = 5,
    RegularHitFX = "Front_Hit_Special",
    FinalHitFX = "Ability_4",
    FinalHitSFX = "explosion_punch",
    FinalHitVolume = 0.9,
    MaxDuration = 2.5
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

function u1._EnsureAnimation(p3) -- Line: 74
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    local AnimationName = u1.AnimationName;

    if p3.Animations[AnimationName] then
        return p3.Animations[AnimationName];
    end;

    local v4 = ReplicatedStorage.Classes:FindFirstChild(p3.ClassName);

    if not v4 then
        return nil;
    end;

    local Skill_Animations = v4:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local v5 = Skill_Animations:FindFirstChild(u1.AnimationName);

    if not v5 then
        return nil;
    end;

    local v6 = p3.Humanoid and p3.Humanoid:FindFirstChildOfClass("Animator");

    if not v6 then
        return nil;
    end;

    local v7 = v6:LoadAnimation(v5);
    v7.Priority = Enum.AnimationPriority.Action3;
    v7:Play(0, 0, 0);
    v7:Stop(0);
    p3.Animations[AnimationName] = v7;

    return v7;
end;

local function resolveDashDirection(p8) -- Line: 102
    local Humanoid = p8.Humanoid;
    local v9 = p8.Character and p8.Character:FindFirstChild("HumanoidRootPart");

    if Humanoid and Humanoid.MoveDirection.Magnitude > 0.1 then
        local MoveDirection = Humanoid.MoveDirection;

        return Vector3.new(MoveDirection.X, 0, MoveDirection.Z).Unit;
    end;

    if not v9 then
        return Vector3.new(0, 0, -1);
    end;

    local LookVector = v9.CFrame.LookVector;

    return Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
end;

function u1._PerformHit(p10) -- Line: 119
    -- upvalues: u1 (copy)
    local HitboxSize = p10.ClassData.HitboxSize;
    local Range = p10.ClassData.Range;
    p10.ClassData.HitboxSize = u1.HitboxSize;
    p10.ClassData.Range = u1.HitboxRange;
    local v11 = p10:Hitbox();
    p10.ClassData.HitboxSize = HitboxSize;
    p10.ClassData.Range = Range;
    local v12 = 0;

    for _, v in v11 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p10:ApplyDamage(v, (p10:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v12 = v12 + 1;
        end;
    end;

    return v12;
end;

local function RandomOffset(p13) -- Line: 144
    local v14 = (math.random() * 2 - 1) * p13;
    local v15 = (math.random() * 2 - 1) * p13;

    return Vector3.new(v14, 0, v15);
end;

function u1._SpawnClones(u16) -- Line: 153
    -- upvalues: u2 (copy), u1 (copy)
    if not u2 then
        return;
    end;

    task.spawn(function() -- Line: 156
        -- upvalues: u1 (ref), u16 (copy), u2 (ref)
        for i = 1, u1.CloneCount do
            if not u16.Is_Using_Skill then
                break;
            end;

            local Player = u16.Player;
            local v17 = {
                Action = "Clone",
                FadeDuration = u1.CloneFadeDuration,
                Color = u1.CloneColor
            };
            local CloneSpread = u1.CloneSpread;
            local v18 = (math.random() * 2 - 1) * CloneSpread;
            local v19 = (math.random() * 2 - 1) * CloneSpread;
            v17.Offset = Vector3.new(v18, 0, v19);
            u2:FireAllClients(Player, v17);
            local v20;

            if i < u1.CloneCount then
                task.wait(u1.CloneInterval);
                v20 = i;
            else
                v20 = i;
            end;
        end;
    end);
end;

function u1._FireHitFX(p21, p22) -- Line: 177
    -- upvalues: u1 (copy)
    p21:PlayFX(u1.FinalHitNumber <= p22 and u1.FinalHitFX or u1.RegularHitFX);
end;

function u1.CanActivate(p23) -- Line: 184
    if p23.Is_Attacking then
        return false, "Attacking";
    end;

    if p23.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p23.Is_Dodging then
        return false, "Dodging";
    end;

    if p23.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u24, p25) -- Line: 192
    -- upvalues: u1 (copy), SharedUtils (copy), resolveDashDirection (copy), Debris (copy)
    local v26 = u1._EnsureAnimation(u24);

    if not v26 then
        warn("[8 Layered Demon Core] Animation not found");

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
    local u27 = 0;
    local u32 = v26:GetMarkerReachedSignal("hit"):Connect(function(p28) -- Line: 222
        -- upvalues: u27 (ref), u24 (copy), u1 (ref), SharedUtils (ref), resolveDashDirection (ref), Debris (ref)
        u27 = u27 + 1;
        local u29 = u27;
        local v30 = u24.Character and u24.Character:FindFirstChild("HumanoidRootPart");

        if not v30 then
            return;
        end;

        if u1.FinalHitNumber <= u29 then
            SharedUtils.PlaySoundAt(v30, u1.FinalHitSFX, u1.FinalHitVolume);
        else
            u24:PlayCombatSound(u24.ClassData.SwingSoundFolder or "Naoya_Punches", nil, u24.ClassData.SwingVolume or 0.5);
        end;

        u24:ShakeCamera("Hit");
        local v31 = resolveDashDirection(u24);
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "DemonCore_Dash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v31 * u1.DashSpeed;
        BodyVelocity.Parent = v30;
        Debris:AddItem(BodyVelocity, u1.DashDuration);
        u1._FireHitFX(u24, u29);
        u1._PerformHit(u24);
        task.delay(u1.DuplicateDelay, function() -- Line: 256
            -- upvalues: u24 (ref), u1 (ref), u29 (copy)
            u24:PlayCombatSound(u24.ClassData.SwingSoundFolder or "Naoya_Punches", nil, u24.ClassData.SwingVolume or 0.5);
            u1._FireHitFX(u24, u29);
            u1._PerformHit(u24);
            u1._SpawnClones(u24);
        end);
    end);
    local u33 = false;

    local function releaseState() -- Line: 273
        -- upvalues: u33 (ref), u24 (copy)
        if u33 then
            return;
        end;

        u33 = true;
        u24.Is_Using_Skill = false;
        u24.Is_Attacking = false;
    end;

    local u34 = v26:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v26.Stopped:Once(function() -- Line: 284
        -- upvalues: u33 (ref), u24 (copy), u32 (ref), u34 (copy)
        if not u33 then
            u33 = true;
            u24.Is_Using_Skill = false;
            u24.Is_Attacking = false;
        end;

        if u32 then
            u32:Disconnect();
        end;

        if u34 then
            u34:Disconnect();
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 291
        -- upvalues: u33 (ref), u24 (copy), u32 (ref), u34 (copy)
        if not u33 then
            u33 = true;
            u24.Is_Using_Skill = false;
            u24.Is_Attacking = false;
        end;

        if u32 then
            u32:Disconnect();
        end;

        if u34 then
            u34:Disconnect();
        end;
    end);
end;

return u1;