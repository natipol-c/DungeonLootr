--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Flash Step
  Path:     game.ReplicatedStorage.Classes.Vacio.Skills.Flash Step
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:47 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local CollectionService = game:GetService("CollectionService");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local SkillRuntime = require(ServerScriptService.Management.Modules.SkillRuntime);
local u1 = {
    Cooldown = 5,
    MaxCharges = 3,
    DamageMultiplier = 1.25,
    AnimationName = "Ability_1",
    EffectModule = "Flash_Step",
    DashSpeed = 80,
    DashDuration = 0.15,
    ParryDuration = 0.3,
    IFrameDuration = 0.6,
    CastSFX = "Sonido",
    CastVolume = 1,
    HitSFX = "hit_ultema_s_1",
    HitVolume = 1,
    MaxPhantoms = 3,
    PhantomSearchRange = 50,
    PhantomSpawnRadius = 6,
    PhantomSpawnDelay = 0.15,
    PhantomColor = Color3.fromRGB(144, 238, 144),
    PhantomFadeDuration = 0.8,
    PhantomPauseAtEnd = 0.3,
    HitboxSize = Vector3.new(25, 15, 30),
    HitboxRange = 30,
    MaxDuration = 3
};
local u2 = nil;

local function GetPhantomRemote() -- Line: 85
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

local function FireParticles(p4: userdata) -- Line: 101
    if not p4:HasTag("ParticleObject") then
        p4:AddTag("ParticleObject");
    end;

    p4:SetAttribute("Fire", not p4:GetAttribute("Fire"));
end;

function u1._EnsureAnimation(p5) -- Line: 108
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

local function resolveDashDirection(p10) -- Line: 136
    local Humanoid = p10.Humanoid;
    local v11 = p10.Character and p10.Character:FindFirstChild("HumanoidRootPart");

    if Humanoid and Humanoid.MoveDirection.Magnitude > 0.1 then
        local MoveDirection = Humanoid.MoveDirection;

        return Vector3.new(MoveDirection.X, 0, MoveDirection.Z).Unit;
    end;

    if not v11 then
        return Vector3.new(0, 0, -1);
    end;

    local LookVector = v11.CFrame.LookVector;

    return Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
end;

function u1._PerformHit(p12) -- Line: 153
    -- upvalues: u1 (copy)
    local HitboxSize = p12.ClassData.HitboxSize;
    local Range = p12.ClassData.Range;
    p12.ClassData.HitboxSize = u1.HitboxSize;
    p12.ClassData.Range = u1.HitboxRange;
    local v13 = p12:Hitbox();
    p12.ClassData.HitboxSize = HitboxSize;
    p12.ClassData.Range = Range;
    local v14 = 0;

    for _, v in v13 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p12:ApplyDamage(v, (p12:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v14 = v14 + 1;
        end;
    end;

    return v14;
end;

local function GetSpawnCFrame(p15: userdata, p16: number) -- Line: 178
    local v17 = math.random() * 3.141592653589793 * 2;
    local v18 = math.cos(v17) * p16;
    local v19 = math.sin(v17) * p16;
    local Vector3_new_ret = Vector3.new(v18, 0, v19);

    return CFrame.lookAt(p15.Position + Vector3_new_ret, p15.Position);
end;

function u1._PickPhantomTargets(p20: vector, p21: number, p22: number) -- Line: 189
    -- upvalues: CollectionService (copy)
    local v23 = {};

    for _, v in CollectionService:GetTagged("Enemy") do
        if v.Parent and not v:GetAttribute("Dead") then
            local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart then
                local Magnitude = (HumanoidRootPart.Position - p20).Magnitude;

                if Magnitude <= p21 then
                    table.insert(v23, {
                        model = v,
                        dist = Magnitude
                    });
                end;
            end;
        end;
    end;

    if #v23 == 0 then
        return {};
    end;

    table.sort(v23, function(p24, p25) -- Line: 209
        return p24.dist < p25.dist;
    end);
    local v26 = {};

    for i = 1, p22 do
        table.insert(v26, v23[(i - 1) % #v23 + 1].model);
        local _ = i;
    end;

    return v26;
end;

function u1._SpawnPhantom(u27, u28) -- Line: 222
    -- upvalues: GetPhantomRemote (copy), u1 (copy)
    local v29 = GetPhantomRemote();

    if not v29 then
        return;
    end;

    local Player = u27.Player;

    if not Player then
        return;
    end;

    local HumanoidRootPart = u28:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v30 = Player:GetAttribute("Active_Class") or "";
    local PhantomSpawnRadius = u1.PhantomSpawnRadius;
    local v31 = math.random() * 3.141592653589793 * 2;
    local v32 = math.cos(v31) * PhantomSpawnRadius;
    local v33 = math.sin(v31) * PhantomSpawnRadius;
    local Vector3_new_ret = Vector3.new(v32, 0, v33);
    local CFrame_lookAt_ret = CFrame.lookAt(HumanoidRootPart.Position + Vector3_new_ret, HumanoidRootPart.Position);
    task.spawn(function() -- Line: 236
        -- upvalues: u28 (copy), u27 (copy), u1 (ref)
        if not (u28 and u28.Parent) then
            return;
        end;

        if u28:GetAttribute("Dead") and not u28:GetAttribute("Can_Finish") then
            return;
        end;

        u27:ApplyDamage(u28, (u27:ResolveSkillDamage(u1.DamageMultiplier, u28)));
        local HumanoidRootPart2 = u28:FindFirstChild("HumanoidRootPart");
        local v34 = HumanoidRootPart2 and HumanoidRootPart2:FindFirstChild("NormalHit");

        if v34 then
            if not v34:HasTag("ParticleObject") then
                v34:AddTag("ParticleObject");
            end;

            v34:SetAttribute("Fire", not v34:GetAttribute("Fire"));
        end;
    end);
    v29:FireAllClients(Player, {
        ClassName = v30,
        AnimationName = u1.AnimationName,
        FXNames = { "Ability_1" },
        Color = u1.PhantomColor,
        FadeDuration = u1.PhantomFadeDuration,
        PauseAtEnd = u1.PhantomPauseAtEnd,
        AttackSpeed = u27:GetEffectiveStat("AttackSpeed") or 1,
        SwingSoundFolder = u27.ClassData.SwingSoundFolder,
        Position = CFrame_lookAt_ret
    });
end;

function u1.CanActivate(p35) -- Line: 268
    if p35.Is_Attacking then
        return false, "Attacking";
    end;

    if p35.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p35.Is_Dodging then
        return false, "Dodging";
    end;

    if p35.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u36, p37) -- Line: 276
    -- upvalues: u1 (copy), SharedUtils (copy), SkillRuntime (copy), resolveDashDirection (copy), Debris (copy)
    local v38 = u1._EnsureAnimation(u36);

    if not v38 then
        warn("[Flash Step] Animation not found");

        return;
    end;

    local Character = u36.Character;
    local v39;

    if Character then
        v39 = Character:FindFirstChild("HumanoidRootPart");
    else
        v39 = Character;
    end;

    if not v39 then
        return;
    end;

    u36.Is_Using_Skill = true;
    u36.Is_Attacking = true;

    for i, v in u36.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    Character:SetAttribute("Parry", true);
    task.delay(u1.ParryDuration, function() -- Line: 300
        -- upvalues: u36 (copy)
        local Character2 = u36.Character;

        if Character2 then
            Character2:SetAttribute("Parry", false);
        end;
    end);

    if u36.Player then
        u36.Player:SetAttribute("iFrame", true);
    end;

    Character:SetAttribute("iFrame", true);
    task.delay(u1.IFrameDuration, function() -- Line: 308
        -- upvalues: u36 (copy)
        local Player = u36.Player;
        local Character2 = u36.Character;

        if Player then
            Player:SetAttribute("iFrame", false);
        end;

        if Character2 then
            Character2:SetAttribute("iFrame", false);
        end;
    end);
    SharedUtils.PlaySoundAt(v39, u1.CastSFX, u1.CastVolume);
    v38:Stop(0);
    v38:Play(0, 1, 1);
    local u40 = {};

    local function disconnectAll() -- Line: 327
        -- upvalues: u40 (copy)
        for _, v in u40 do
            v:Disconnect();
        end;

        table.clear(u40);
    end;

    local u41 = false;

    local function releaseState() -- Line: 337
        -- upvalues: u41 (ref), u36 (copy)
        if u41 then
            return;
        end;

        u41 = true;
        u36.Is_Using_Skill = false;
        u36.Is_Attacking = false;
    end;

    for _, v in SkillRuntime.BindVFXMarkers(u36, v38, u1.EffectModule, 3) do
        u40[#u40 + 1] = v;
    end;

    u40[#u40 + 1] = v38:GetMarkerReachedSignal("dash"):Connect(function() -- Line: 350
        -- upvalues: u36 (copy), resolveDashDirection (ref), u1 (ref), Debris (ref)
        local v42 = u36.Character and u36.Character:FindFirstChild("HumanoidRootPart");

        if not v42 then
            return;
        end;

        local v43 = resolveDashDirection(u36);
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "FlashStep_Dash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v43 * u1.DashSpeed;
        BodyVelocity.Parent = v42;
        Debris:AddItem(BodyVelocity, u1.DashDuration);
    end);
    u40[#u40 + 1] = v38:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 366
        -- upvalues: u36 (copy), SharedUtils (ref), u1 (ref)
        local v44 = u36.Character and u36.Character:FindFirstChild("HumanoidRootPart");

        if not v44 then
            return;
        end;

        SharedUtils.PlaySoundAt(v44, u1.HitSFX, u1.HitVolume);
        u36:ShakeCamera("SkillMedium");
        u1._PerformHit(u36);

        for _, v in u1._PickPhantomTargets(v44.Position, u1.PhantomSearchRange, u1.MaxPhantoms) do
            task.delay(u1.PhantomSpawnDelay, function() -- Line: 382
                -- upvalues: v (copy), u1 (ref), u36 (ref)
                if not (v and v.Parent) then
                    return;
                end;

                if v:GetAttribute("Dead") then
                    return;
                end;

                u1._SpawnPhantom(u36, v);
            end);
        end;
    end);

    local function fullCleanup() -- Line: 391
        -- upvalues: u41 (ref), u36 (copy), u40 (copy)
        if not u41 then
            u41 = true;
            u36.Is_Using_Skill = false;
            u36.Is_Attacking = false;
        end;

        for _, v in u40 do
            v:Disconnect();
        end;

        table.clear(u40);
    end;

    v38.Stopped:Once(fullCleanup);
    task.delay(u1.MaxDuration, fullCleanup);
end;

return u1;