--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Crashing Talon
  Path:     game.ReplicatedStorage.Classes.Mori.Skills.Crashing Talon
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:00 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");
local u2 = {
    Cooldown = 6,
    DamageMultiplier = 4,
    AnimationName = "Ability_1",
    DashSpeed = 60,
    DashDuration = 0.16,
    IFrameDuration = 0.5,
    CastSFX = "Sonido",
    CastVolume = 0.9,
    HitSFX = "HardHit_1",
    HitVolume = 1,
    HitVFX = { "Left_Slash", "Right_Slash" },
    HitboxSize = Vector3.new(26, 18, 28),
    HitboxRange = 24,
    CloneCount = 3,
    CloneInterval = 0.04,
    CloneFadeDuration = 0.7,
    CloneColor = Color3.fromRGB(120, 180, 255),
    CloneSpread = 3,
    MaxDuration = 1.5
};

function u2._EnsureAnimation(p3) -- Line: 71
    -- upvalues: u2 (copy), ReplicatedStorage (copy)
    local AnimationName = u2.AnimationName;

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

    local v5 = Skill_Animations:FindFirstChild(u2.AnimationName);

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

function u2._PerformHit(p8) -- Line: 98
    -- upvalues: u2 (copy)
    local HitboxSize = p8.ClassData.HitboxSize;
    local Range = p8.ClassData.Range;
    p8.ClassData.HitboxSize = u2.HitboxSize;
    p8.ClassData.Range = u2.HitboxRange;
    local v9 = p8:Hitbox();
    p8.ClassData.HitboxSize = HitboxSize;
    p8.ClassData.Range = Range;

    for _, v in v9 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p8:ApplyDamage(v, (p8:ResolveSkillDamage(u2.DamageMultiplier, v)));
        end;
    end;
end;

local function RandomOffset(p10) -- Line: 119
    local v11 = (math.random() * 2 - 1) * p10;
    local v12 = (math.random() * 2 - 1) * p10;

    return Vector3.new(v11, 0, v12);
end;

function u2._SpawnClones(u13) -- Line: 128
    -- upvalues: u1 (copy), u2 (copy)
    if not u1 then
        return;
    end;

    task.spawn(function() -- Line: 131
        -- upvalues: u2 (ref), u13 (copy), u1 (ref)
        for i = 1, u2.CloneCount do
            if not u13.Is_Using_Skill then
                break;
            end;

            local Player = u13.Player;
            local v14 = {
                Action = "Clone",
                FadeDuration = u2.CloneFadeDuration,
                Color = u2.CloneColor
            };
            local CloneSpread = u2.CloneSpread;
            local v15 = (math.random() * 2 - 1) * CloneSpread;
            local v16 = (math.random() * 2 - 1) * CloneSpread;
            v14.Offset = Vector3.new(v15, 0, v16);
            u1:FireAllClients(Player, v14);
            local v17;

            if i < u2.CloneCount then
                task.wait(u2.CloneInterval);
                v17 = i;
            else
                v17 = i;
            end;
        end;
    end);
end;

function u2.CanActivate(p18) -- Line: 151
    if p18.Is_Attacking then
        return false, "Attacking";
    end;

    if p18.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p18.Is_Dodging then
        return false, "Dodging";
    end;

    if p18.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u2.Activate(u19, p20) -- Line: 159
    -- upvalues: u2 (copy), Debris (copy), SharedUtils (copy)
    local v21 = u2._EnsureAnimation(u19);

    if not v21 then
        warn("[Crashing Talon] Animation not found");

        return;
    end;

    local Character = u19.Character;
    local v22;

    if Character then
        v22 = Character:FindFirstChild("HumanoidRootPart");
    else
        v22 = Character;
    end;

    if not v22 then
        return;
    end;

    u19.Is_Using_Skill = true;
    u19.Is_Attacking = true;
    Character:SetAttribute("Skill_Camera_Stabilize", true);

    for i, v in u19.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    local Humanoid = u19.Humanoid;
    local v23 = Humanoid and (Humanoid.MoveDirection.Magnitude > 0 and Humanoid.MoveDirection.Unit) or v22.CFrame.LookVector;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v23 * u2.DashSpeed;
    BodyVelocity.Parent = v22;
    Debris:AddItem(BodyVelocity, u2.DashDuration);
    u2._SpawnClones(u19);
    SharedUtils.PlaySoundAt(v22, u2.CastSFX, u2.CastVolume);
    u19:ShakeCamera("SkillLight");

    if u19.Player then
        u19.Player:SetAttribute("iFrame", true);
    end;

    Character:SetAttribute("iFrame", true);
    task.delay(u2.IFrameDuration, function() -- Line: 208
        -- upvalues: u19 (copy)
        local Player = u19.Player;
        local Character2 = u19.Character;

        if Player then
            Player:SetAttribute("iFrame", false);
        end;

        if Character2 then
            Character2:SetAttribute("iFrame", false);
        end;
    end);
    v21:Play(0, 1, 1);
    local u24 = {};

    local function disconnectAll() -- Line: 219
        -- upvalues: u24 (copy)
        for _, v in u24 do
            v:Disconnect();
        end;

        table.clear(u24);
    end;

    local u25 = false;

    local function releaseState() -- Line: 225
        -- upvalues: u25 (ref), u19 (copy)
        if u25 then
            return;
        end;

        u25 = true;
        u19.Is_Using_Skill = false;
        u19.Is_Attacking = false;
    end;

    u24[#u24 + 1] = v21:GetMarkerReachedSignal("hit"):Connect(function(p26) -- Line: 234
        -- upvalues: u19 (copy), SharedUtils (ref), u2 (ref)
        local v27 = u19.Character and u19.Character:FindFirstChild("HumanoidRootPart");

        if v27 then
            SharedUtils.PlaySoundAt(v27, u2.HitSFX, u2.HitVolume);
        end;

        u19:PlayFX(u2.HitVFX[math.random(1, #u2.HitVFX)]);
        u19:ShakeCamera("SkillHeavy");
        u2._PerformHit(u19);
    end);
    u24[#u24 + 1] = v21:GetMarkerReachedSignal("DBreset"):Connect(releaseState);

    local function fullCleanup() -- Line: 250
        -- upvalues: u25 (ref), u19 (copy), u24 (copy)
        if not u25 then
            u25 = true;
            u19.Is_Using_Skill = false;
            u19.Is_Attacking = false;
        end;

        for _, v in u24 do
            v:Disconnect();
        end;

        table.clear(u24);

        if u19.Character then
            u19.Character:SetAttribute("Skill_Camera_Stabilize", false);
        end;
    end;

    v21.Stopped:Once(fullCleanup);
    task.delay(u2.MaxDuration, fullCleanup);
end;

return u2;