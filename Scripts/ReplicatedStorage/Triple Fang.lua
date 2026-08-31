--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Triple Fang
  Path:     game.ReplicatedStorage.Classes.Coyote.Skills.Triple Fang
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
local u1 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");
local u2 = {
    Cooldown = 6,
    MaxCharges = 3,
    DamageMultiplier = 1.5,
    AnimationName = "Ability_1",
    HitFX = { "Shot_1", "Shot_2", "Shot_3" },
    ClashSFX = "Clash",
    ClashVolume = 1,
    HitboxSize = Vector3.new(25, 15, 38),
    HitboxRange = 35,
    DashSpeeds = { 55, 65, 75 },
    DashDuration = 0.15,
    DodgeDuration = 1,
    CloneCount = 2,
    CloneInterval = 0.04,
    CloneFadeDuration = 0.6,
    CloneColor = Color3.fromRGB(120, 180, 255),
    CloneSpread = 3,
    MaxDuration = 1.2
};

function u2._EnsureAnimation(p3) -- Line: 66
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

function u2._PerformHit(p8) -- Line: 92
    -- upvalues: u2 (copy)
    local HitboxSize = p8.ClassData.HitboxSize;
    local Range = p8.ClassData.Range;
    p8.ClassData.HitboxSize = u2.HitboxSize;
    p8.ClassData.Range = u2.HitboxRange;
    local v9 = p8:Hitbox();
    p8.ClassData.HitboxSize = HitboxSize;
    p8.ClassData.Range = Range;
    local v10 = 0;

    for _, v in v9 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p8:ApplyDamage(v, (p8:ResolveSkillDamage(u2.DamageMultiplier, v)));
            v10 = v10 + 1;
        end;
    end;

    return v10;
end;

local function RandomOffset(p11) -- Line: 116
    local v12 = (math.random() * 2 - 1) * p11;
    local v13 = (math.random() * 2 - 1) * p11;

    return Vector3.new(v12, 0, v13);
end;

function u2._SpawnClones(u14) -- Line: 124
    -- upvalues: u1 (copy), u2 (copy)
    if not u1 then
        return;
    end;

    task.spawn(function() -- Line: 127
        -- upvalues: u2 (ref), u14 (copy), u1 (ref)
        for i = 1, u2.CloneCount do
            if not u14.Is_Using_Skill then
                break;
            end;

            local Player = u14.Player;
            local v15 = {
                Action = "Clone",
                FadeDuration = u2.CloneFadeDuration,
                Color = u2.CloneColor
            };
            local CloneSpread = u2.CloneSpread;
            local v16 = (math.random() * 2 - 1) * CloneSpread;
            local v17 = (math.random() * 2 - 1) * CloneSpread;
            v15.Offset = Vector3.new(v16, 0, v17);
            u1:FireAllClients(Player, v15);
            local v18;

            if i < u2.CloneCount then
                task.wait(u2.CloneInterval);
                v18 = i;
            else
                v18 = i;
            end;
        end;
    end);
end;

function u2.CanActivate(p19) -- Line: 147
    if p19.Is_Attacking then
        return false, "Attacking";
    end;

    if p19.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p19.Is_Dodging then
        return false, "Dodging";
    end;

    if p19.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u2.Activate(u20, p21) -- Line: 155
    -- upvalues: u2 (copy), Debris (copy), SharedUtils (copy)
    local v22 = u2._EnsureAnimation(u20);

    if not v22 then
        warn("[Triple Fang] Animation not found");

        return;
    end;

    local Character = u20.Character;
    local v23;

    if Character then
        v23 = Character:FindFirstChild("HumanoidRootPart");
    else
        v23 = Character;
    end;

    if not v23 then
        return;
    end;

    u20.Is_Using_Skill = true;
    u20.Is_Attacking = true;
    u20:ShakeCamera("SkillMedium");
    Character:SetAttribute("Dodge", true);
    task.delay(u2.DodgeDuration, function() -- Line: 175
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);

    for i, v in u20.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v22:Play(0, 1, 1);
    local u24 = {};

    local function disconnectAll() -- Line: 191
        -- upvalues: u24 (copy)
        for _, v in u24 do
            v:Disconnect();
        end;

        table.clear(u24);
    end;

    local u25 = false;

    local function releaseState() -- Line: 197
        -- upvalues: u25 (ref), u20 (copy)
        if u25 then
            return;
        end;

        u25 = true;
        u20.Is_Using_Skill = false;
        u20.Is_Attacking = false;
    end;

    local u26 = 0;
    u24[#u24 + 1] = v22:GetMarkerReachedSignal("hit"):Connect(function(p27) -- Line: 207
        -- upvalues: u26 (ref), u20 (copy), u2 (ref), Debris (ref), SharedUtils (ref)
        u26 = u26 + 1;
        local v28 = u26;
        local v29 = u20.Character and u20.Character:FindFirstChild("HumanoidRootPart");

        if not v29 then
            return;
        end;

        u20:PlayFX(u2.HitFX[v28] or u2.HitFX[#u2.HitFX]);
        u2._SpawnClones(u20);
        local v30 = u2.DashSpeeds[v28] or u2.DashSpeeds[#u2.DashSpeeds];
        local Humanoid = u20.Humanoid;
        local v31;

        if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
            v31 = Humanoid.MoveDirection.Unit;
        else
            v31 = v29.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "SkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v31 * v30;
        BodyVelocity.Parent = v29;
        Debris:AddItem(BodyVelocity, u2.DashDuration);
        u20:PlayCombatSound(u20.ClassData.SwingSoundFolder or "Cero_Shoot", nil, u20.ClassData.SwingVolume or 0.5);
        SharedUtils.PlaySoundAt(v29, u2.ClashSFX, u2.ClashVolume);
        u2._PerformHit(u20);
    end);
    u24[#u24 + 1] = v22:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v22.Stopped:Once(function() -- Line: 251
        -- upvalues: u25 (ref), u20 (copy), u24 (copy), Character (copy)
        if not u25 then
            u25 = true;
            u20.Is_Using_Skill = false;
            u20.Is_Attacking = false;
        end;

        for _, v in u24 do
            v:Disconnect();
        end;

        table.clear(u24);

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
    task.delay(u2.MaxDuration, function() -- Line: 257
        -- upvalues: u25 (ref), u20 (copy), u24 (copy), Character (copy)
        if not u25 then
            u25 = true;
            u20.Is_Using_Skill = false;
            u20.Is_Attacking = false;
        end;

        for _, v in u24 do
            v:Disconnect();
        end;

        table.clear(u24);

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
end;

return u2;