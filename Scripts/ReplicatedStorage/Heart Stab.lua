--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Heart Stab
  Path:     game.ReplicatedStorage.Classes.Kage.Skills.Heart Stab
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:59 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local RigUtil = require(ReplicatedStorage.Modules.RigUtil);
local u1 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");
local u11 = {
    Cooldown = 10,
    DamageMultiplier = 2.5,
    AnimationName = "Ability_2",
    ChainAnimName = "Attack_2",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(20, 15, 20),
    HitboxRange = 15,
    WarpSearchRange = 60,
    WarpBehindOffset = 5,
    MaxExtraTargets = 3,
    MinHPPercent = 0.2,
    DodgeDuration = 1.2,
    CloneFadeDuration = 0.6,
    CloneColor = Color3.fromRGB(60, 20, 80),
    MaxDuration = 8,

    _EnsureAnimation = function(p2, p3, p4) -- Line: 65, Name: _EnsureAnimation
        -- upvalues: ReplicatedStorage (copy)
        local v5 = "HeartStab_" .. p3;

        if p2.Animations[v5] then
            return p2.Animations[v5];
        end;

        local v6 = ReplicatedStorage.Classes:FindFirstChild(p2.ClassName);

        if not v6 then
            return nil;
        end;

        local v7 = v6:FindFirstChild(p4);

        if not v7 then
            return nil;
        end;

        local v8 = v7:FindFirstChild(p3);

        if not v8 then
            return nil;
        end;

        local v9 = p2.Humanoid and p2.Humanoid:FindFirstChildOfClass("Animator");

        if not v9 then
            return nil;
        end;

        local v10 = v9:LoadAnimation(v8);
        v10.Priority = Enum.AnimationPriority.Action3;
        v10:Play(0, 0, 0);
        v10:Stop(0);
        p2.Animations[v5] = v10;

        return v10;
    end
};

function u11._PerformHit(p12) -- Line: 91
    -- upvalues: u11 (copy)
    local HitboxSize = p12.ClassData.HitboxSize;
    local Range = p12.ClassData.Range;
    p12.ClassData.HitboxSize = u11.HitboxSize;
    p12.ClassData.Range = u11.HitboxRange;
    local v13 = p12:Hitbox();
    p12.ClassData.HitboxSize = HitboxSize;
    p12.ClassData.Range = Range;
    local v14 = 0;

    for _, v in v13 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p12:ApplyDamage(v, (p12:ResolveSkillDamage(u11.DamageMultiplier, v)));
            v14 = v14 + 1;
        end;
    end;

    return v14;
end;

function u11._GatherEligibleEnemies(p15, p16) -- Line: 116
    -- upvalues: CollectionService (copy), RigUtil (copy), u11 (copy)
    local v17 = p15.Character and p15.Character:FindFirstChild("HumanoidRootPart");

    if not v17 then
        return {};
    end;

    local Position = v17.Position;
    local v18 = {};

    for _, v in CollectionService:GetTagged("Enemy") do
        if v.Parent and not (v:GetAttribute("Dead") or p16 and p16[v]) and RigUtil.IsHittableTarget(v) then
            local v19 = v:FindFirstChildOfClass("Humanoid");

            if not v19 or v19.Health / v19.MaxHealth >= u11.MinHPPercent then
                local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart");

                if HumanoidRootPart then
                    local Magnitude = (HumanoidRootPart.Position - Position).Magnitude;

                    if Magnitude <= u11.WarpSearchRange then
                        table.insert(v18, {
                            model = v,
                            hrp = HumanoidRootPart,
                            distance = Magnitude
                        });
                    end;
                end;
            end;
        end;
    end;

    return v18;
end;

function u11._FindNearest(p20) -- Line: 152
    local v21 = (1 / 0);
    local v22 = nil;

    for _, v in p20 do
        if v.distance < v21 then
            v21 = v.distance;
            v22 = v;
        end;
    end;

    return v22;
end;

function u11._WarpBehind(p23, p24) -- Line: 164
    -- upvalues: u11 (copy)
    local v25 = p23.Character and p23.Character:FindFirstChild("HumanoidRootPart");

    if not (v25 and p24.hrp) then
        return;
    end;

    local v26 = p24.hrp.CFrame * CFrame.new(0, 0, u11.WarpBehindOffset);
    v25.CFrame = CFrame.new(v26.Position, p24.hrp.Position);
end;

function u11._SpawnClone(p27) -- Line: 172
    -- upvalues: u1 (copy), u11 (copy)
    if not u1 then
        return;
    end;

    u1:FireAllClients(p27.Player, {
        Action = "Clone",
        FadeDuration = u11.CloneFadeDuration,
        Color = u11.CloneColor
    });
end;

function u11._PlayChainStrike(u28) -- Line: 183
    -- upvalues: u11 (copy)
    local v29 = u11._EnsureAnimation(u28, u11.ChainAnimName, "Animations");

    if not v29 then
        return;
    end;

    v29:Play(0, 1, 1);
    local u30 = 2;
    local u31 = nil;
    local BindableEvent = Instance.new("BindableEvent");
    u31 = v29:GetMarkerReachedSignal("hit"):Connect(function(p32) -- Line: 193
        -- upvalues: u11 (ref), u28 (copy), u30 (ref), u31 (ref), BindableEvent (copy)
        u28:PlayCombatSound(u11.Skill_SFX or (u28.ClassData.SwingSoundFolder or "Magic_Swings"), nil, u28.ClassData.SwingVolume or 0.5);

        if p32 == "" or not p32 then
            p32 = nil;
        end;

        u28:PlayTurnFX(p32);
        u28:ShakeCamera("SkillLight");
        u11._PerformHit(u28);
        u30 = u30 - 1;

        if u30 <= 0 then
            if u31 then
                u31:Disconnect();
            end;

            BindableEvent:Fire();
        end;
    end);
    v29.Stopped:Once(function() -- Line: 207
        -- upvalues: u31 (ref), BindableEvent (copy)
        if u31 then
            u31:Disconnect();
        end;

        BindableEvent:Fire();
    end);
    BindableEvent.Event:Wait();
    BindableEvent:Destroy();
end;

function u11.CanActivate(p33) -- Line: 218
    if p33.Is_Attacking then
        return false, "Attacking";
    end;

    if p33.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p33.Is_Dodging then
        return false, "Dodging";
    end;

    if p33.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u11.Activate(u34, p35) -- Line: 226
    -- upvalues: u11 (copy), SharedUtils (copy)
    local v36 = u11._EnsureAnimation(u34, u11.AnimationName, "Skill_Animations");

    if not v36 then
        warn("[Heart Stab] Animation not found");

        return;
    end;

    local Character = u34.Character;
    local v37;

    if Character then
        v37 = Character:FindFirstChild("HumanoidRootPart");
    else
        v37 = Character;
    end;

    if not v37 then
        return;
    end;

    u34.Is_Using_Skill = true;
    u34.Is_Attacking = true;

    for i, v in u34.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    local v38 = u11._GatherEligibleEnemies(u34, nil);
    local u39 = u11._FindNearest(v38);
    v36:Play(0, 1, 1);
    local u42 = v36:GetMarkerReachedSignal("teleport"):Connect(function(p40) -- Line: 257
        -- upvalues: u34 (copy), SharedUtils (ref), u39 (copy), u11 (ref), Character (copy)
        local v41 = u34.Character and u34.Character:FindFirstChild("HumanoidRootPart");

        if not v41 then
            return;
        end;

        SharedUtils.PlaySoundAt(v41, "Dark_Chase", 1);

        if u39 then
            u11._WarpBehind(u34, u39);
        end;

        Character:SetAttribute("Dodge", true);
        task.delay(u11.DodgeDuration, function() -- Line: 270
            -- upvalues: Character (ref)
            if Character then
                Character:SetAttribute("Dodge", false);
            end;
        end);
    end);
    local u44 = v36:GetMarkerReachedSignal("hit"):Connect(function(p43) -- Line: 279
        -- upvalues: u11 (ref), u34 (copy)
        u34:PlayCombatSound(u11.Skill_SFX or (u34.ClassData.SwingSoundFolder or "Magic_Swings"), nil, u34.ClassData.SwingVolume or 0.5);

        if p43 == "" or not p43 then
            p43 = nil;
        end;

        u34:PlayTurnFX(p43);
        u34:ShakeCamera("SkillLight");
        u11._PerformHit(u34);
    end);
    v36.Stopped:Once(function() -- Line: 288
        -- upvalues: u44 (ref), u42 (ref), u39 (copy), u11 (ref), u34 (copy), SharedUtils (ref), Character (copy)
        if u44 then
            u44:Disconnect();
        end;

        if u42 then
            u42:Disconnect();
        end;

        local u45 = {};

        if u39 then
            u45[u39.model] = true;
        end;

        task.spawn(function() -- Line: 299
            -- upvalues: u11 (ref), u34 (ref), u45 (copy), SharedUtils (ref), Character (ref)
            for i = 1, u11.MaxExtraTargets do
                if not (u34.Character and u34.Character.Parent) then
                    break;
                end;

                local v46 = u11._GatherEligibleEnemies(u34, u45);

                if #v46 == 0 then
                    break;
                end;

                local v47 = v46[math.random(1, #v46)];
                u45[v47.model] = true;
                u11._SpawnClone(u34);
                SharedUtils.PlaySoundAt(u34.Character:FindFirstChild("HumanoidRootPart"), "Dark_Chase", 1);
                u11._WarpBehind(u34, v47);
                u11._PlayChainStrike(u34);
                local _ = i;
            end;

            u34.Is_Using_Skill = false;
            u34.Is_Attacking = false;

            if Character then
                Character:SetAttribute("Dodge", false);
            end;
        end);
    end);
    task.delay(u11.MaxDuration, function() -- Line: 336
        -- upvalues: u34 (copy), u44 (ref), u42 (ref), Character (copy)
        if u34.Is_Using_Skill then
            u34.Is_Using_Skill = false;
            u34.Is_Attacking = false;
        end;

        if u44 then
            u44:Disconnect();
        end;

        if u42 then
            u42:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
end;

return u11;