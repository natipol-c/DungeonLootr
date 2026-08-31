--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Phantom Swarm
  Path:     game.ReplicatedStorage.Classes.Assassin.Skills.Phantom Swarm
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:59 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 10,
    DamageMultiplier = 1.25,
    AnimationName = "Ability_4",
    Skill_SFX = nil,
    DashSpeed = 80,
    DashDuration = 0.15,
    DashSFX = "Sonido",
    DashVolume = 1,
    ParryDuration = 0.3,
    IFrameDuration = 0.6,
    CloneColor = Color3.fromRGB(85, 40, 120),
    CloneFadeDuration = 1,
    HitboxSize = Vector3.new(20, 12, 24),
    HitboxRange = 22,
    MaxDuration = 3
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

local function resolveDashDirection(p3) -- Line: 67
    local Humanoid = p3.Humanoid;
    local v4 = p3.Character and p3.Character:FindFirstChild("HumanoidRootPart");

    if Humanoid and Humanoid.MoveDirection.Magnitude > 0.1 then
        local MoveDirection = Humanoid.MoveDirection;

        return Vector3.new(MoveDirection.X, 0, MoveDirection.Z).Unit;
    end;

    if not v4 then
        return Vector3.new(0, 0, -1);
    end;

    local LookVector = v4.CFrame.LookVector;

    return Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
end;

function u1._EnsureAnimation(p5) -- Line: 84
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    local AnimationName = u1.AnimationName;

    if p5.Animations[AnimationName] then
        return p5.Animations[AnimationName];
    end;

    local v6 = ReplicatedStorage.Classes:FindFirstChild(p5.ClassName);

    if not v6 then
        return nil;
    end;

    local Skill_Animations = v6:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local v7 = Skill_Animations:FindFirstChild(u1.AnimationName);

    if not v7 then
        return nil;
    end;

    local v8 = p5.Humanoid and p5.Humanoid:FindFirstChildOfClass("Animator");

    if not v8 then
        return nil;
    end;

    local v9 = v8:LoadAnimation(v7);
    v9.Priority = Enum.AnimationPriority.Action3;
    v9:Play(0, 0, 0);
    v9:Stop(0);
    p5.Animations[AnimationName] = v9;

    return v9;
end;

function u1._PerformHit(p10) -- Line: 110
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

function u1._SpawnClone(p13) -- Line: 135
    -- upvalues: u2 (copy), u1 (copy)
    if not u2 then
        return;
    end;

    if not p13.Player then
        return;
    end;

    u2:FireAllClients(p13.Player, {
        Action = "Clone",
        FadeDuration = u1.CloneFadeDuration,
        Color = u1.CloneColor
    });
end;

function u1.CanActivate(p14) -- Line: 148
    if p14.Is_Attacking then
        return false, "Attacking";
    end;

    if p14.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p14.Is_Dodging then
        return false, "Dodging";
    end;

    if p14.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u15, p16) -- Line: 156
    -- upvalues: u1 (copy), resolveDashDirection (copy), Debris (copy), SharedUtils (copy)
    local v17 = u1._EnsureAnimation(u15);

    if not v17 then
        warn("[Phantom Swarm] Animation not found");

        return;
    end;

    local Character = u15.Character;
    local v18;

    if Character then
        v18 = Character:FindFirstChild("HumanoidRootPart");
    else
        v18 = Character;
    end;

    if not v18 then
        return;
    end;

    u15.Is_Using_Skill = true;
    u15.Is_Attacking = true;

    for i, v in u15.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    Character:SetAttribute("Parry", true);
    task.delay(u1.ParryDuration, function() -- Line: 180
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    u15.Player:SetAttribute("iFrame", true);
    u15.Character:SetAttribute("iFrame", true);
    v17:Play(0, 1, 1);
    local u19 = {};

    local function disconnectAll() -- Line: 193
        -- upvalues: u19 (copy)
        for _, v in u19 do
            v:Disconnect();
        end;

        table.clear(u19);
    end;

    local u20 = false;
    u19[#u19 + 1] = v17:GetMarkerReachedSignal("dash"):Connect(function() -- Line: 200
        -- upvalues: u20 (ref), u15 (copy), u1 (ref), resolveDashDirection (ref), Debris (ref), SharedUtils (ref)
        if u20 then
            return;
        end;

        u20 = true;
        local v21 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

        if not v21 then
            return;
        end;

        u1._SpawnClone(u15);
        local v22 = resolveDashDirection(u15);
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "PhantomSwarm_Dash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v22 * u1.DashSpeed;
        BodyVelocity.Parent = v21;
        Debris:AddItem(BodyVelocity, u1.DashDuration);
        SharedUtils.PlaySoundAt(v21, u1.DashSFX, u1.DashVolume);
        u15:ShakeCamera("SkillLight");
    end);
    u19[#u19 + 1] = v17:GetMarkerReachedSignal("hit"):Connect(function(p23) -- Line: 225
        -- upvalues: u15 (copy), u1 (ref)
        u15:PlayCombatSound(u15.ClassData.SwingSoundFolder or "Ninja", nil, u15.ClassData.SwingVolume or 0.5);

        if p23 == "" or not p23 then
            p23 = nil;
        end;

        u15:PlayTurnFX(p23);
        u15:ShakeCamera("SkillLight");
        u1._PerformHit(u15);
    end);
    v17.Stopped:Once(function() -- Line: 238
        -- upvalues: u19 (copy), u15 (copy)
        for _, v in u19 do
            v:Disconnect();
        end;

        table.clear(u19);
        u15.Is_Using_Skill = false;
        u15.Is_Attacking = false;
    end);
    task.delay(u1.IFrameDuration, function() -- Line: 246
        -- upvalues: u15 (copy)
        if u15.Player then
            u15.Player:SetAttribute("iFrame", false);
        end;

        if u15.Character then
            u15.Character:SetAttribute("iFrame", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 252
        -- upvalues: u15 (copy), u19 (copy), Character (copy)
        if u15.Is_Using_Skill then
            u15.Is_Using_Skill = false;
            u15.Is_Attacking = false;
        end;

        for _, v in u19 do
            v:Disconnect();
        end;

        table.clear(u19);

        if u15.Player then
            u15.Player:SetAttribute("iFrame", false);
        end;

        if u15.Character then
            u15.Character:SetAttribute("iFrame", false);
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
end;

return u1;