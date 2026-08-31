--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Ink Mirage
  Path:     game.ReplicatedStorage.Classes.Wanderer.Skills.Ink Mirage
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:57 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 11,
    DamageMultiplier = 0.5,
    AnimationName = "Ability_1",
    Skill_SFX = nil,
    EffectDuration = 2,
    TickInterval = 0.2,
    HitboxSize = Vector3.new(30, 30, 30),
    HitboxRange = 0,
    PhantomColor = Color3.fromRGB(255, 255, 255),
    PhantomFadeDuration = 0.6,
    PhantomPauseAtEnd = 0.2,
    PhantomSpawnRadius = 15,
    ActivateSFX = "Fire Punch",
    ExitSFX = "Fire Punch",
    MaxDuration = 5.5
};
local u2 = nil;

local function GetPhantomRemote() -- Line: 67
    -- upvalues: u2 (ref), ReplicatedStorage (copy)
    if u2 then
        return u2;
    end;

    local v3 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes");

    if not v3 then
        return nil;
    end;

    u2 = v3:FindFirstChild("PhantomAttack");

    if not u2 then
        u2 = Instance.new("RemoteEvent");
        u2.Name = "PhantomAttack";
        u2.Parent = v3;
    end;

    return u2;
end;

function u1._EnsureAnimation(p4) -- Line: 85
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    local AnimationName = u1.AnimationName;

    if p4.Animations[AnimationName] then
        return p4.Animations[AnimationName];
    end;

    local v5 = ReplicatedStorage.Classes:FindFirstChild(p4.ClassName);

    if not v5 then
        return nil;
    end;

    local Skill_Animations = v5:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local v6 = Skill_Animations:FindFirstChild(u1.AnimationName);

    if not v6 then
        return nil;
    end;

    local v7 = p4.Humanoid and p4.Humanoid:FindFirstChildOfClass("Animator");

    if not v7 then
        return nil;
    end;

    local v8 = v7:LoadAnimation(v6);
    v8.Priority = Enum.AnimationPriority.Action3;
    v8:Play(0, 0, 0);
    v8:Stop(0);
    p4.Animations[AnimationName] = v8;

    return v8;
end;

local function hideCharacter(p9: userdata) -- Line: 118
    local v10 = {};

    for _, descendant in p9:GetDescendants() do
        if (descendant:IsA("BasePart") or descendant:IsA("MeshPart")) and descendant.Transparency < 1 then
            v10[descendant] = descendant.Transparency;
            descendant.Transparency = 0.99;
        end;
    end;

    return v10;
end;

local function restoreCharacter(p11: table) -- Line: 129
    for i, v in p11 do
        if i and i.Parent then
            i.Transparency = v;
        end;
    end;
end;

function u1._PerformTick(p12) -- Line: 138
    -- upvalues: u1 (copy)
    local HitboxSize = p12.ClassData.HitboxSize;
    local Range = p12.ClassData.Range;
    p12.ClassData.HitboxSize = u1.HitboxSize;
    p12.ClassData.Range = u1.HitboxRange;
    local v13 = p12:Hitbox();
    p12.ClassData.HitboxSize = HitboxSize;
    p12.ClassData.Range = Range;

    for _, v in v13 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p12:ApplyDamage(v, (p12:ResolveSkillDamage(u1.DamageMultiplier, v)));
        end;
    end;

    u1._SpawnPhantomAroundPlayer(p12);
end;

function u1._SpawnPhantomAroundPlayer(p14) -- Line: 164
    -- upvalues: GetPhantomRemote (copy), u1 (copy)
    local v15 = GetPhantomRemote();

    if not v15 then
        return;
    end;

    local Player = p14.Player;

    if not Player then
        return;
    end;

    local v16 = p14.Character and p14.Character:FindFirstChild("HumanoidRootPart");

    if not v16 then
        return;
    end;

    local v17 = math.random() * 3.141592653589793 * 2;
    local v18 = math.random() * u1.PhantomSpawnRadius;
    local v19 = math.cos(v17) * v18;
    local v20 = math.sin(v17) * v18;
    local Vector3_new_ret = Vector3.new(v19, 0, v20);
    local CFrame_lookAt_ret = CFrame.lookAt(v16.Position + Vector3_new_ret, v16.Position);
    v15:FireAllClients(Player, {
        ClassName = Player:GetAttribute("Active_Class") or (p14.ClassName or ""),
        AnimationName = "Attack_" .. tostring(math.random(1, p14.ClassData.TurnCount or 4)),
        FXNames = { "Ability_1" },
        Color = u1.PhantomColor,
        FadeDuration = u1.PhantomFadeDuration,
        PauseAtEnd = u1.PhantomPauseAtEnd,
        AttackSpeed = p14:GetEffectiveStat("AttackSpeed") or 1,
        SwingSoundFolder = p14.ClassData.SwingSoundFolder,
        Position = CFrame_lookAt_ret
    });
end;

function u1.CanActivate(p21) -- Line: 199
    if p21.Is_Attacking then
        return false, "Attacking";
    end;

    if p21.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p21.Is_Dodging then
        return false, "Dodging";
    end;

    if p21.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u22, p23) -- Line: 207
    -- upvalues: u1 (copy), SharedUtils (copy), hideCharacter (copy), RunService (copy)
    local u24 = u1._EnsureAnimation(u22);

    if not u24 then
        warn("[Ink Mirage] Animation not found");

        return;
    end;

    local Character = u22.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u22.Is_Using_Skill = true;
    u22.Is_Attacking = true;

    for i, v in u22.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    u24:Play(0, 1, 1);
    local u25 = false;
    local u26 = nil;
    local u27 = 0;
    local u28 = 0;
    local u29 = nil;
    local u30 = false;
    local u31 = nil;

    local function stopBarrage() -- Line: 244
        -- upvalues: u25 (ref), u26 (ref), u22 (copy), u29 (ref), SharedUtils (ref), u1 (ref), u30 (ref), u31 (ref), u24 (copy)
        if not u25 then
            return;
        end;

        u25 = false;

        if u26 then
            u26:Disconnect();
            u26 = nil;
        end;

        u22:SetLoopFX("Jade_Forest", false);

        if u29 then
            for i, v in u29 do
                if i and i.Parent then
                    i.Transparency = v;
                end;
            end;

            u29 = nil;
        end;

        if u22.Character then
            u22.Character:SetAttribute("Dodge", false);
        end;

        local v32 = u22.Character and u22.Character:FindFirstChild("HumanoidRootPart");

        if v32 then
            SharedUtils.PlaySoundAt(v32, u1.ExitSFX, 1);
        end;

        if not u30 then
            u30 = true;

            if u31 then
                u31:Disconnect();
                u31 = nil;
            end;

            if u24.IsPlaying then
                u24:Stop(0.15);
            end;

            u22.Is_Using_Skill = false;
            u22.Is_Attacking = false;
        end;
    end;

    u31 = u24:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 290
        -- upvalues: u25 (ref), u22 (copy), SharedUtils (ref), u1 (ref), u29 (ref), hideCharacter (ref), u27 (ref), u28 (ref), u26 (ref), RunService (ref), stopBarrage (copy)
        if u25 then
            return;
        end;

        u25 = true;
        local v33 = u22.Character and u22.Character:FindFirstChild("HumanoidRootPart");

        if not v33 then
            return;
        end;

        SharedUtils.PlaySoundAt(v33, u1.ActivateSFX, 1);
        u29 = hideCharacter(u22.Character);
        u22.Character:SetAttribute("Dodge", true);
        u22:SetLoopFX("Jade_Forest", true);
        u27 = 0;
        u28 = 0;
        u26 = RunService.Heartbeat:Connect(function(p34) -- Line: 312
            -- upvalues: u25 (ref), u22 (ref), stopBarrage (ref), u28 (ref), u1 (ref), u27 (ref)
            if not u25 then
                return;
            end;

            if not (u22.Character and u22.Character.Parent) then
                stopBarrage();

                return;
            end;

            u28 = u28 + p34;

            if u28 >= u1.EffectDuration then
                stopBarrage();

                return;
            end;

            u27 = u27 + p34;

            while u27 >= u1.TickInterval do
                u27 = u27 - u1.TickInterval;
                u1._PerformTick(u22);
                u22:PlayCombatSound(u22.ClassData.SwingSoundFolder or "Magic_Swings", nil, u22.ClassData.SwingVolume or 0.5);
                u22:ShakeCamera("Hit");
            end;
        end);
    end);
    u24.Stopped:Once(function() -- Line: 342
        -- upvalues: u31 (ref)
        if u31 then
            u31:Disconnect();
            u31 = nil;
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 347
        -- upvalues: u30 (ref), stopBarrage (copy)
        if not u30 then
            stopBarrage();
        end;
    end);
end;

return u1;