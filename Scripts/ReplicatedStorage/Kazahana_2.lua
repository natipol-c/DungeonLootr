--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Kazahana
  Path:     game.ReplicatedStorage.Classes.Zero.Skills.Kazahana
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:57 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");
local u14 = {
    Cooldown = 8,
    MaxCharges = 2,
    DamageMultiplier = 1,
    AnimationName = "Ability_2",
    HitboxSize = Vector3.new(40, 10, 40),
    HitboxRange = 20,
    IFrameDuration = 1.2,
    SwingSFXFolder = "Cero_Shoot",
    ClonesPerHit = 2,
    CloneInterval = 0.04,
    CloneFadeDuration = 0.7,
    CloneColor = Color3.fromRGB(80, 150, 255),
    LoopFX = "Hunt",
    MaxDuration = 1.5,
    HoldAnimationName = "Ability_2_Hold",
    HoldDamageMultiplier = 3,
    HoldHitboxSize = Vector3.new(20, 18, 26),
    HoldHitboxRange = 24,
    HoldCastSFX = { "Sonido", "claw3" },
    HoldCastVolume = 1,
    LiftSpeed = 110,
    LiftDuration = 0.1,
    HoldMaxDuration = 3,

    _EnsureAnimation = function(p2, p3) -- Line: 87, Name: _EnsureAnimation
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

    _PerformHit = function(p8, p9, p10, p11) -- Line: 114, Name: _PerformHit
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

function u14._SpawnClones(u15) -- Line: 139
    -- upvalues: u1 (copy), u14 (copy)
    if not u1 then
        return;
    end;

    task.spawn(function() -- Line: 142
        -- upvalues: u14 (ref), u15 (copy), u1 (ref)
        for i = 1, u14.ClonesPerHit do
            if not u15.Is_Using_Skill then
                break;
            end;

            u1:FireAllClients(u15.Player, {
                Action = "Clone",
                FadeDuration = u14.CloneFadeDuration,
                Color = u14.CloneColor
            });
            local v16;

            if i < u14.ClonesPerHit then
                task.wait(u14.CloneInterval);
                v16 = i;
            else
                v16 = i;
            end;
        end;
    end);
end;

function u14.CanActivate(p17) -- Line: 161
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

function u14.Activate(u18, p19) -- Line: 170
    -- upvalues: u14 (copy)
    local v20 = u14._EnsureAnimation(u18, u14.AnimationName);

    if not v20 then
        warn("[Kazahana] Animation not found");

        return;
    end;

    u18.Is_Using_Skill = true;
    u18.Is_Attacking = true;

    if u18.Player then
        u18.Player:SetAttribute("iFrame", true);
    end;

    u18.Character:SetAttribute("iFrame", true);
    task.delay(u14.IFrameDuration, function() -- Line: 184
        -- upvalues: u18 (copy)
        local Player = u18.Player;
        local Character = u18.Character;

        if Player then
            Player:SetAttribute("iFrame", false);
        end;

        if Character then
            Character:SetAttribute("iFrame", false);
        end;
    end);
    u18.Character:SetAttribute("Skill_Camera_Stabilize", true);

    for i, v in u18.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v20:Play(0, 1, 1);
    local u21 = {};

    local function disconnectAll() -- Line: 205
        -- upvalues: u21 (copy)
        for _, v in u21 do
            v:Disconnect();
        end;

        table.clear(u21);
    end;

    local u22 = false;

    local function releaseState() -- Line: 211
        -- upvalues: u22 (ref), u18 (copy)
        if u22 then
            return;
        end;

        u22 = true;
        u18.Is_Using_Skill = false;
        u18.Is_Attacking = false;
    end;

    local u23 = false;

    local function disableHuntFX() -- Line: 221
        -- upvalues: u23 (ref), u18 (copy), u14 (ref)
        if not u23 then
            return;
        end;

        u23 = false;
        u18:SetLoopFX(u14.LoopFX, false);
    end;

    u21[#u21 + 1] = v20:GetMarkerReachedSignal("hit"):Connect(function(p24) -- Line: 228
        -- upvalues: u23 (ref), u18 (copy), u14 (ref)
        if not u23 then
            u23 = true;
            u18:SetLoopFX(u14.LoopFX, true);
        end;

        u18:PlayCombatSound(u14.SwingSFXFolder, nil, u18.ClassData.SwingVolume or 0.5);
        u18:ShakeCamera("SkillLight");
        u14._SpawnClones(u18);
        u14._PerformHit(u18, u14.DamageMultiplier, u14.HitboxSize, u14.HitboxRange);
    end);
    u21[#u21 + 1] = v20:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 243
        -- upvalues: u23 (ref), u18 (copy), u14 (ref), u22 (ref)
        if u23 then
            u23 = false;
            u18:SetLoopFX(u14.LoopFX, false);
        end;

        if u22 then
            return;
        end;

        u22 = true;
        u18.Is_Using_Skill = false;
        u18.Is_Attacking = false;
    end);
    v20.Stopped:Once(function() -- Line: 250
        -- upvalues: u22 (ref), u18 (copy), u23 (ref), u14 (ref), u21 (copy)
        if not u22 then
            u22 = true;
            u18.Is_Using_Skill = false;
            u18.Is_Attacking = false;
        end;

        if u23 then
            u23 = false;
            u18:SetLoopFX(u14.LoopFX, false);
        end;

        for _, v in u21 do
            v:Disconnect();
        end;

        table.clear(u21);

        if u18.Player then
            u18.Player:SetAttribute("iFrame", false);
        end;

        if u18.Character then
            u18.Character:SetAttribute("iFrame", false);
            u18.Character:SetAttribute("Skill_Camera_Stabilize", false);
        end;
    end);
    task.delay(u14.MaxDuration, function() -- Line: 261
        -- upvalues: u22 (ref), u18 (copy), u23 (ref), u14 (ref), u21 (copy)
        if not u22 then
            u22 = true;
            u18.Is_Using_Skill = false;
            u18.Is_Attacking = false;
        end;

        if u23 then
            u23 = false;
            u18:SetLoopFX(u14.LoopFX, false);
        end;

        for _, v in u21 do
            v:Disconnect();
        end;

        table.clear(u21);

        if u18.Player then
            u18.Player:SetAttribute("iFrame", false);
        end;

        if u18.Character then
            u18.Character:SetAttribute("iFrame", false);
            u18.Character:SetAttribute("Skill_Camera_Stabilize", false);
        end;
    end);
end;

function u14.ActivateHold(u25, p26) -- Line: 274
    -- upvalues: u14 (copy), SharedUtils (copy)
    local v27 = u14._EnsureAnimation(u25, u14.HoldAnimationName);

    if not v27 then
        warn("[Kazahana] Hold animation not found");

        return;
    end;

    local Character = u25.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u25.Is_Using_Skill = true;
    u25.Is_Attacking = true;

    for i, v in u25.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    for _, v in u14.HoldCastSFX do
        SharedUtils.PlaySoundAt(Character, v, u14.HoldCastVolume);
    end;

    u25:ShakeCamera("SkillMedium");
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "KazahanaLift";
    BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
    BodyVelocity.Velocity = Vector3.new(0, u14.LiftSpeed, 0);
    BodyVelocity.Parent = Character;
    task.delay(u14.LiftDuration, function() -- Line: 311
        -- upvalues: BodyVelocity (ref)
        if BodyVelocity and BodyVelocity.Parent then
            BodyVelocity.Velocity = Vector3.new(0, 0, 0);
        end;
    end);

    local function releaseAirHold() -- Line: 317
        -- upvalues: BodyVelocity (ref)
        if BodyVelocity then
            BodyVelocity:Destroy();
            BodyVelocity = nil;
        end;
    end;

    v27:Play(0, 1, 1);
    local u28 = {};

    local function _() -- Line: 329
        -- upvalues: u28 (copy)
        for _, v in u28 do
            v:Disconnect();
        end;

        table.clear(u28);
    end;

    local u29 = false;

    local function _() -- Line: 335
        -- upvalues: u29 (ref), u25 (copy)
        if u29 then
            return;
        end;

        u29 = true;
        u25.Is_Using_Skill = false;
        u25.Is_Attacking = false;
    end;

    u28[#u28 + 1] = v27:GetMarkerReachedSignal("hit"):Connect(function(p30) -- Line: 344
        -- upvalues: u25 (copy), u14 (ref)
        if p30 == "" or not p30 then
            p30 = nil;
        end;

        u25:PlayTurnFX(p30);
        u25:ShakeCamera("Hit");
        u14._PerformHit(u25, u14.HoldDamageMultiplier, u14.HoldHitboxSize, u14.HoldHitboxRange);
    end);
    u28[#u28 + 1] = v27:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 352
        -- upvalues: BodyVelocity (ref), u29 (ref), u25 (copy)
        if BodyVelocity then
            BodyVelocity:Destroy();
            BodyVelocity = nil;
        end;

        if u29 then
            return;
        end;

        u29 = true;
        u25.Is_Using_Skill = false;
        u25.Is_Attacking = false;
    end);

    local function fullCleanup() -- Line: 358
        -- upvalues: u29 (ref), u25 (copy), u28 (copy), BodyVelocity (ref)
        if not u29 then
            u29 = true;
            u25.Is_Using_Skill = false;
            u25.Is_Attacking = false;
        end;

        for _, v in u28 do
            v:Disconnect();
        end;

        table.clear(u28);

        if BodyVelocity then
            BodyVelocity:Destroy();
            BodyVelocity = nil;
        end;
    end;

    v27.Stopped:Once(fullCleanup);
    task.delay(u14.HoldMaxDuration, fullCleanup);
end;

return u14;