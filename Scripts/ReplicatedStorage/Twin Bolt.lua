--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Twin Bolt
  Path:     game.ReplicatedStorage.Classes.Artemis.Skills.Twin Bolt
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:56 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local u1 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");
local u14 = {
    Cooldown = 4,
    MaxCharges = 3,
    DamageMultiplier = 2.2,
    AnimationName = "Ability_1",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(20, 15, 25),
    HitboxRange = 25,
    DashSpeeds = { 60, 70 },
    DashDuration = 0.15,
    DodgeDuration = 1,
    CloneCount = 2,
    CloneInterval = 0.04,
    CloneFadeDuration = 0.6,
    CloneColor = Color3.fromRGB(180, 220, 255),
    CloneSpread = 3,
    HoldAnimationName = "Ability_1_Hold",
    HoldDamageMultiplier = 2.5,
    HoldHitboxSize = Vector3.new(20, 18, 26),
    HoldHitboxRange = 24,
    LiftSpeed = 90,
    LiftDuration = 0.12,
    HoldPushSpeed = 30,
    HoldPushDuration = 0.2,
    HoldMaxDuration = 3,
    MaxDuration = 1,

    _EnsureAnimation = function(p2, p3) -- Line: 80, Name: _EnsureAnimation
        -- upvalues: ReplicatedStorage (copy)
        if p2.Animations[p3] then
            return p2.Animations[p3];
        end;

        local v4 = ReplicatedStorage.Classes:FindFirstChild(p2.ClassName);

        if not v4 then
            return nil;
        end;

        local Skill_Animations = v4:FindFirstChild("Skill_Animations");

        if not Skill_Animations then
            return nil;
        end;

        local v5 = Skill_Animations:FindFirstChild(p3);

        if not v5 then
            return nil;
        end;

        local v6 = p2.Humanoid and p2.Humanoid:FindFirstChildOfClass("Animator");

        if not v6 then
            return nil;
        end;

        local v7 = v6:LoadAnimation(v5);
        v7.Priority = Enum.AnimationPriority.Action3;
        v7:Play(0, 0, 0);
        v7:Stop(0);
        p2.Animations[p3] = v7;

        return v7;
    end,

    _PerformHit = function(p8, p9, p10, p11) -- Line: 107, Name: _PerformHit
        local HitboxSize = p8.ClassData.HitboxSize;
        local Range = p8.ClassData.Range;
        p8.ClassData.HitboxSize = p10;
        p8.ClassData.Range = p11;
        local v12 = p8:Hitbox();
        p8.ClassData.HitboxSize = HitboxSize;
        p8.ClassData.Range = Range;
        local v13 = 0;

        for _, v in v12 do
            if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
                p8:ApplyDamage(v, (p8:ResolveSkillDamage(p9, v)));
                v13 = v13 + 1;
            end;
        end;

        return v13;
    end
};

local function RandomOffset(p15) -- Line: 131
    local v16 = (math.random() * 2 - 1) * p15;
    local v17 = (math.random() * 2 - 1) * p15;

    return Vector3.new(v16, 0, v17);
end;

function u14._SpawnClones(u18) -- Line: 139
    -- upvalues: u1 (copy), u14 (copy)
    if not u1 then
        return;
    end;

    task.spawn(function() -- Line: 142
        -- upvalues: u14 (ref), u18 (copy), u1 (ref)
        for i = 1, u14.CloneCount do
            if not u18.Is_Using_Skill then
                break;
            end;

            local Player = u18.Player;
            local v19 = {
                Action = "Clone",
                FadeDuration = u14.CloneFadeDuration,
                Color = u14.CloneColor
            };
            local CloneSpread = u14.CloneSpread;
            local v20 = (math.random() * 2 - 1) * CloneSpread;
            local v21 = (math.random() * 2 - 1) * CloneSpread;
            v19.Offset = Vector3.new(v20, 0, v21);
            u1:FireAllClients(Player, v19);
            local v22;

            if i < u14.CloneCount then
                task.wait(u14.CloneInterval);
                v22 = i;
            else
                v22 = i;
            end;
        end;
    end);
end;

function u14._PushBackward(p23, u24) -- Line: 163
    -- upvalues: u14 (copy), Debris (copy)
    local Character = p23.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local LookVector = Character.CFrame.LookVector;
    local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);

    if Vector3_new_ret.Magnitude < 0.05 then
        return;
    end;

    local v25 = -Vector3_new_ret.Unit * u14.HoldPushSpeed;

    if u24 and u24.Parent then
        u24.Velocity = Vector3.new(v25.X, 0, v25.Z);
        task.delay(u14.HoldPushDuration, function() -- Line: 177
            -- upvalues: u24 (copy)
            if u24 and u24.Parent then
                u24.Velocity = Vector3.new(0, 0, 0);
            end;
        end);

        return;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "TwinBoltPush";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v25;
    BodyVelocity.Parent = Character;
    Debris:AddItem(BodyVelocity, u14.HoldPushDuration);
end;

function u14.CanActivate(p26) -- Line: 195
    if p26.Is_Attacking then
        return false, "Attacking";
    end;

    if p26.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p26.Is_Dodging then
        return false, "Dodging";
    end;

    if p26.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u14.Activate(u27, p28) -- Line: 204
    -- upvalues: u14 (copy), Debris (copy)
    local v29 = u14._EnsureAnimation(u27, u14.AnimationName);

    if not v29 then
        warn("[Twin Bolt] Animation not found");

        return;
    end;

    local Character = u27.Character;
    local v30;

    if Character then
        v30 = Character:FindFirstChild("HumanoidRootPart");
    else
        v30 = Character;
    end;

    if not v30 then
        return;
    end;

    u27.Is_Using_Skill = true;
    u27.Is_Attacking = true;
    Character:SetAttribute("Dodge", true);
    task.delay(u14.DodgeDuration, function() -- Line: 222
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);

    for i, v in u27.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v29:Play(0, 1, 1);
    local u31 = 0;
    local u36 = v29:GetMarkerReachedSignal("hit"):Connect(function(p32) -- Line: 241
        -- upvalues: u31 (ref), u27 (copy), u14 (ref), Debris (ref)
        u31 = u31 + 1;
        local v33 = u27.Character and u27.Character:FindFirstChild("HumanoidRootPart");

        if not v33 then
            return;
        end;

        u27:PlayFX("Ability_1");
        u27:ShakeCamera("SkillLight");
        u14._SpawnClones(u27);
        local v34 = u14.DashSpeeds[u31] or u14.DashSpeeds[#u14.DashSpeeds];
        local Humanoid = u27.Humanoid;
        local v35;

        if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
            v35 = Humanoid.MoveDirection.Unit;
        else
            v35 = v33.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v35 * v34;
        BodyVelocity.Parent = v33;
        Debris:AddItem(BodyVelocity, u14.DashDuration);
        u27:PlayCombatSound(u14.Skill_SFX or u27.ClassData.SwingSoundFolder or "Bow_Shot2", nil, u27.ClassData.SwingVolume or 0.5);
        u14._PerformHit(u27, u14.DamageMultiplier, u14.HitboxSize, u14.HitboxRange);
    end);
    local u37 = nil;
    u37 = v29:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 281
        -- upvalues: u36 (ref), u27 (copy), Character (copy), u37 (ref)
        if u36 then
            u36:Disconnect();
        end;

        u27.Is_Using_Skill = false;
        u27.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;

        if u37 then
            u37:Disconnect();
        end;
    end);
    task.delay(u14.MaxDuration, function() -- Line: 295
        -- upvalues: u27 (copy), u36 (ref), Character (copy)
        if u27.Is_Using_Skill then
            u27.Is_Using_Skill = false;
            u27.Is_Attacking = false;
        end;

        if u36 then
            u36:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
end;

function u14.ActivateHold(u38, p39) -- Line: 309
    -- upvalues: u14 (copy)
    local v40 = u14._EnsureAnimation(u38, u14.HoldAnimationName);

    if not v40 then
        warn("[Twin Bolt] Hold animation not found");

        return;
    end;

    local Character = u38.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u38.Is_Using_Skill = true;
    u38.Is_Attacking = true;

    for i, v in u38.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    local u41 = nil;
    local u42 = false;

    local function startLift() -- Line: 337
        -- upvalues: u42 (ref), u38 (copy), u41 (ref), u14 (ref)
        if u42 then
            return;
        end;

        u42 = true;
        local v43 = u38.Character and u38.Character:FindFirstChild("HumanoidRootPart");

        if not v43 then
            return;
        end;

        u41 = Instance.new("BodyVelocity");
        u41.Name = "TwinBoltLift";
        u41.MaxForce = Vector3.new(100000, 100000, 100000);
        u41.Velocity = Vector3.new(0, u14.LiftSpeed, 0);
        u41.Parent = v43;
        u38:ShakeCamera("SkillLight");
        task.delay(u14.LiftDuration, function() -- Line: 351
            -- upvalues: u41 (ref)
            if u41 and u41.Parent then
                u41.Velocity = Vector3.new(0, 0, 0);
            end;
        end);
    end;

    local function releaseAirHold() -- Line: 358
        -- upvalues: u41 (ref)
        if u41 then
            u41:Destroy();
            u41 = nil;
        end;
    end;

    v40:Play(0, 1, 1);
    local u44 = {};

    local function disconnectAll() -- Line: 370
        -- upvalues: u44 (copy)
        for _, v in u44 do
            v:Disconnect();
        end;

        table.clear(u44);
    end;

    local u45 = false;

    local function releaseState() -- Line: 376
        -- upvalues: u45 (ref), u38 (copy)
        if u45 then
            return;
        end;

        u45 = true;
        local ClassData = u38.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u38, nil);
        end;

        u38.Is_Using_Skill = false;
        u38.Is_Attacking = false;
    end;

    u44[#u44 + 1] = v40:GetMarkerReachedSignal("dodge"):Connect(startLift);
    u44[#u44 + 1] = v40:GetMarkerReachedSignal("hit"):Connect(function(p46) -- Line: 391
        -- upvalues: u38 (copy), u14 (ref), u41 (ref)
        if p46 == "" or not p46 then
            p46 = nil;
        end;

        u38:PlayTurnFX(p46);
        u38:ShakeCamera("Hit");
        u38:PlayCombatSound(u14.Skill_SFX or u38.ClassData.SwingSoundFolder or "Bow_Shot2", nil, u38.ClassData.SwingVolume or 0.5);
        u14._PushBackward(u38, u41);
        u14._PerformHit(u38, u14.HoldDamageMultiplier, u14.HoldHitboxSize, u14.HoldHitboxRange);
    end);
    u44[#u44 + 1] = v40:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 404
        -- upvalues: u41 (ref), u45 (ref), u38 (copy)
        if u41 then
            u41:Destroy();
            u41 = nil;
        end;

        if u45 then
            return;
        end;

        u45 = true;
        local ClassData = u38.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u38, nil);
        end;

        u38.Is_Using_Skill = false;
        u38.Is_Attacking = false;
    end);

    local function fullCleanup() -- Line: 410
        -- upvalues: u45 (ref), u38 (copy), u44 (copy), u41 (ref)
        if not u45 then
            u45 = true;
            local ClassData = u38.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u38, nil);
            end;

            u38.Is_Using_Skill = false;
            u38.Is_Attacking = false;
        end;

        for _, v in u44 do
            v:Disconnect();
        end;

        table.clear(u44);

        if u41 then
            u41:Destroy();
            u41 = nil;
        end;
    end;

    v40.Stopped:Once(fullCleanup);
    task.delay(u14.HoldMaxDuration, fullCleanup);
end;

return u14;