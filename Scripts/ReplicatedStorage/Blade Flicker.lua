--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Blade Flicker
  Path:     game.ReplicatedStorage.Classes.Jetstream.Skills.Blade Flicker
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
local u1 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");
local u2 = {
    Cooldown = 8,
    MaxCharges = 4,
    DamageMultiplier = 1.6666666666666667,
    AnimationName = "Ability_1",
    EffectModule = "Blade_Flicker",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(20, 10, 25),
    HitboxRange = 25,
    ParryDuration = 0.55,
    CastSFX = "anime_explode",
    DashSpeeds = { 100, 120 },
    DashDuration = 0.15,
    CloneCount = 2,
    CloneInterval = 0.04,
    CloneFadeDuration = 0.6,
    CloneColor = Color3.fromRGB(255, 60, 60),
    CloneSpread = 3,
    MaxDuration = 1.5
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

    for _, v in v9 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p8:ApplyDamage(v, (p8:ResolveSkillDamage(u2.DamageMultiplier, v)));
        end;
    end;
end;

local function RandomOffset(p10) -- Line: 112
    local v11 = (math.random() * 2 - 1) * p10;
    local v12 = (math.random() * 2 - 1) * p10;

    return Vector3.new(v11, 0, v12);
end;

function u2._SpawnClones(u13) -- Line: 120
    -- upvalues: u1 (copy), u2 (copy)
    if not u1 then
        return;
    end;

    task.spawn(function() -- Line: 123
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

function u2._Dash(p18, p19) -- Line: 141
    -- upvalues: u2 (copy), Debris (copy)
    local v20 = p18.Character and p18.Character:FindFirstChild("HumanoidRootPart");

    if not v20 then
        return;
    end;

    local v21 = u2.DashSpeeds[p19] or u2.DashSpeeds[#u2.DashSpeeds];
    local Humanoid = p18.Humanoid;
    local v22;

    if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
        v22 = Humanoid.MoveDirection.Unit;
    else
        v22 = v20.CFrame.LookVector;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "SkillDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v22 * v21;
    BodyVelocity.Parent = v20;
    Debris:AddItem(BodyVelocity, u2.DashDuration);
end;

function u2.CanActivate(p23) -- Line: 165
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

function u2.Activate(u24, p25) -- Line: 173
    -- upvalues: u2 (copy), SharedUtils (copy)
    local v26 = u2._EnsureAnimation(u24);

    if not v26 then
        warn("[Blade Flicker] Animation not found");

        return;
    end;

    local Character = u24.Character;
    local v27;

    if Character then
        v27 = Character:FindFirstChild("HumanoidRootPart");
    else
        v27 = Character;
    end;

    if not v27 then
        return;
    end;

    u24.Is_Using_Skill = true;
    u24.Is_Attacking = true;

    for i, v in u24.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    Character:SetAttribute("Parry", true);
    task.delay(u2.ParryDuration, function() -- Line: 197
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    v26:Play(0, 1, 1);
    local u28 = {};

    local function disconnectAll() -- Line: 206
        -- upvalues: u28 (copy)
        for _, v in u28 do
            v:Disconnect();
        end;

        table.clear(u28);
    end;

    local u29 = false;

    local function cleanup() -- Line: 212
        -- upvalues: u29 (ref), u24 (copy), Character (copy), u28 (copy)
        if u29 then
            return;
        end;

        u29 = true;
        u24.Is_Using_Skill = false;
        u24.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Parry", false);
        end;

        for _, v in u28 do
            v:Disconnect();
        end;

        table.clear(u28);
    end;

    u28[#u28 + 1] = v26:GetMarkerReachedSignal("VFX"):Connect(function(p30) -- Line: 224
        -- upvalues: u24 (copy), SharedUtils (ref), u2 (ref)
        if not p30 or p30 == "" then
            return;
        end;

        local v31 = u24.Character and u24.Character:FindFirstChild("HumanoidRootPart");

        if not v31 then
            return;
        end;

        if p30 == "1" then
            SharedUtils.PlaySoundAt(v31, u2.CastSFX, 0.8);
        end;

        u24:PlayEffectModule(u2.EffectModule, "Emit", v31.CFrame, p30);
    end);
    local u32 = 0;
    u28[#u28 + 1] = v26:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 238
        -- upvalues: u32 (ref), u24 (copy), u2 (ref)
        u32 = u32 + 1;
        local v33 = u32;
        u24:ShakeCamera("Hit");
        u24:PlayCombatSound(u2.Skill_SFX or (u24.ClassData.SwingSoundFolder or "Electric_Swing"), nil, u24.ClassData.SwingVolume or 1);

        if v33 <= 2 then
            u2._SpawnClones(u24);
            u2._Dash(u24, v33);
        end;

        u2._PerformHit(u24);
    end);
    u28[#u28 + 1] = v26:GetMarkerReachedSignal("DBreset"):Connect(cleanup);
    v26.Stopped:Once(cleanup);
    task.delay(u2.MaxDuration, cleanup);
end;

return u2;