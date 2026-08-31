--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Killer Instinct
  Path:     game.ReplicatedStorage.Classes.Unrestricted.Skills.Killer Instinct
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:50 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    EffectModule = "Killer_Instinct",
    SwordAnim = "Ability_2",
    SwordCooldown = 11,
    SwordTickMult = 0.25,
    SwordTickInterval = 0.1,
    SwordHitboxSize = Vector3.new(22, 16, 26),
    SwordHitRange = 20,
    SwordMaxDuration = 3,
    SpearAnim = "Special_Ability_2",
    SpearCooldown = 7,
    SpearMultiplier = 5,
    SpearHitboxSize = Vector3.new(26, 22, 30),
    SpearHitRange = 26,
    LiftSpeed = 90,
    LiftDuration = 0.1,
    WarpSearchRange = 60,
    WarpBehindOffset = 5,
    SpearMaxDuration = 1.6,
    Cooldown = 11,
    DualCooldown = true
};

function u1.GetCooldown(p2) -- Line: 45
    -- upvalues: u1 (copy)
    return (p2.SpecialMoveset or 0) > 0 and u1.SpearCooldown or u1.SwordCooldown;
end;

local function ensureAnim(p3, p4) -- Line: 49
    -- upvalues: ReplicatedStorage (copy)
    local v5 = p3.Animations[p4];

    if v5 then
        return v5;
    end;

    local v6 = p3.Humanoid and p3.Humanoid:FindFirstChild("Animator");

    if not v6 then
        return nil;
    end;

    local Skill_Animations = ReplicatedStorage.Classes[p3.ClassName]:FindFirstChild("Skill_Animations");

    if Skill_Animations then
        Skill_Animations = Skill_Animations:FindFirstChild(p4);
    end;

    if not Skill_Animations then
        return nil;
    end;

    local v7 = v6:LoadAnimation(Skill_Animations);
    v7.Priority = Enum.AnimationPriority.Action3;
    v7:Play(0, 0, 0);
    v7:Stop(0);
    p3.Animations[p4] = v7;

    return v7;
end;

local function performHit(p8, p9, p10, p11) -- Line: 65
    local ClassData = p8.ClassData;
    local HitboxSize = ClassData.HitboxSize;
    local Range = ClassData.Range;
    ClassData.HitboxSize = p10;
    ClassData.Range = p11;
    local v12 = p8:Hitbox();
    ClassData.HitboxSize = HitboxSize;
    ClassData.Range = Range;

    for _, v in ipairs(v12) do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p8:ApplyDamage(v, p8:ResolveSkillDamage(p9, v));
        end;
    end;
end;

local function forwardVFX(u13, p14, p15) -- Line: 78
    -- upvalues: u1 (copy)
    local function emit(p16) -- Line: 79
        -- upvalues: u13 (copy), u1 (ref)
        if not p16 or p16 == "" then
            return;
        end;

        local v17 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v17 then
            u13:PlayEffectModule(u1.EffectModule, "Emit", v17.CFrame, p16);
        end;
    end;

    local MarkerReachedSignal = p14:GetMarkerReachedSignal("VFX");
    table.insert(p15, MarkerReachedSignal:Connect(emit));
    local MarkerReachedSignal2 = p14:GetMarkerReachedSignal("VFX_2");
    table.insert(p15, MarkerReachedSignal2:Connect(emit));
    local MarkerReachedSignal3 = p14:GetMarkerReachedSignal("VFX_3");
    table.insert(p15, MarkerReachedSignal3:Connect(emit));
end;

local function stopM1(p18) -- Line: 89
    for i, v in pairs(p18.Animations) do
        if type(i) == "string" and (i:match("^Attack_") and v.IsPlaying) then
            v:Stop();
        end;
    end;
end;

local function findNearestEnemy(p19) -- Line: 95
    -- upvalues: u1 (copy), CollectionService (copy)
    local Position = p19.Position;
    local v20 = u1.WarpSearchRange + 1;
    local v21 = nil;

    for _, v in ipairs(CollectionService:GetTagged("Enemy")) do
        if v.Parent and not v:GetAttribute("Dead") then
            local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart then
                local Magnitude = (HumanoidRootPart.Position - Position).Magnitude;

                if Magnitude <= u1.WarpSearchRange and Magnitude < v20 then
                    v21 = HumanoidRootPart;
                    v20 = Magnitude;
                end;
            end;
        end;
    end;

    return v21;
end;

function u1.CanActivate(p22) -- Line: 111
    if p22.Is_Attacking then
        return false, "Attacking";
    end;

    if p22.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p22.Is_Dodging then
        return false, "Dodging";
    end;

    if p22.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1._ActivateSword(u23) -- Line: 119
    -- upvalues: ensureAnim (copy), u1 (copy), stopM1 (copy), forwardVFX (copy), RunService (copy), performHit (copy)
    local Character = u23.Character;
    local v24;

    if Character then
        v24 = Character:FindFirstChild("HumanoidRootPart");
    else
        v24 = Character;
    end;

    if not v24 then
        return;
    end;

    local v25 = ensureAnim(u23, u1.SwordAnim);

    if not v25 then
        return;
    end;

    u23.Is_Using_Skill = true;
    u23.Is_Attacking = true;
    stopM1(u23);
    v25:Play();
    local u26 = {};
    local u27 = nil;
    local u28 = 0;

    local function stopTicks() -- Line: 131
        -- upvalues: u27 (ref)
        if u27 then
            u27:Disconnect();
            u27 = nil;
        end;
    end;

    local function cleanup() -- Line: 134
        -- upvalues: u26 (copy), u27 (ref), Character (copy), u23 (copy)
        for _, v in ipairs(u26) do
            if v.Connected then
                v:Disconnect();
            end;
        end;

        table.clear(u26);

        if u27 then
            u27:Disconnect();
            u27 = nil;
        end;

        Character:SetAttribute("Parry", false);
        u23.Is_Using_Skill = false;
        u23.Is_Attacking = false;
    end;

    forwardVFX(u23, v25, u26);
    local MarkerReachedSignal = v25:GetMarkerReachedSignal("Start");
    table.insert(u26, MarkerReachedSignal:Connect(function() -- Line: 143
        -- upvalues: Character (copy), u28 (ref), u27 (ref), RunService (ref), u1 (ref), u23 (copy), performHit (ref)
        Character:SetAttribute("Parry", true);
        u28 = 0;
        u27 = RunService.Heartbeat:Connect(function(p29) -- Line: 146
            -- upvalues: u28 (ref), u1 (ref), u23 (ref), performHit (ref)
            u28 = u28 + p29;

            while u28 >= u1.SwordTickInterval do
                u28 = u28 - u1.SwordTickInterval;
                u23:PlayCombatSound(u23.ClassData.SwingSoundFolder, nil, 0.8);
                u23:ShakeCamera("SkillLight");
                performHit(u23, u1.SwordTickMult, u1.SwordHitboxSize, u1.SwordHitRange);
            end;
        end);
    end));
    local MarkerReachedSignal2 = v25:GetMarkerReachedSignal("End");
    table.insert(u26, MarkerReachedSignal2:Connect(function() -- Line: 156
        -- upvalues: u27 (ref), Character (copy), u23 (copy)
        if u27 then
            u27:Disconnect();
            u27 = nil;
        end;

        Character:SetAttribute("Parry", false);
        u23:ShakeCamera("SkillHeavy");
    end));
    local MarkerReachedSignal3 = v25:GetMarkerReachedSignal("DBreset");
    table.insert(u26, MarkerReachedSignal3:Connect(cleanup));
    v25.Stopped:Once(cleanup);
    task.delay(u1.SwordMaxDuration, function() -- Line: 163
        -- upvalues: u23 (copy), cleanup (copy)
        if u23.Is_Using_Skill then
            cleanup();
        end;
    end);
end;

function u1._ActivateSpear(u30) -- Line: 166
    -- upvalues: ensureAnim (copy), u1 (copy), stopM1 (copy), forwardVFX (copy), SharedUtils (copy), findNearestEnemy (copy), performHit (copy)
    local Character = u30.Character;
    local u31;

    if Character then
        u31 = Character:FindFirstChild("HumanoidRootPart");
    else
        u31 = Character;
    end;

    if not u31 then
        return;
    end;

    local v32 = ensureAnim(u30, u1.SpearAnim);

    if not v32 then
        return u1._ActivateSword(u30);
    end;

    u30.Is_Using_Skill = true;
    u30.Is_Attacking = true;
    stopM1(u30);
    v32:Play();
    local u33 = {};
    local u34 = nil;

    local function killLift() -- Line: 178
        -- upvalues: u34 (ref)
        if u34 and u34.Parent then
            u34:Destroy();
        end;

        u34 = nil;
    end;

    local function u35() -- Line: 182
        -- upvalues: u33 (copy), u34 (ref), u30 (copy)
        for _, v in ipairs(u33) do
            if v.Connected then
                v:Disconnect();
            end;
        end;

        table.clear(u33);

        if u34 and u34.Parent then
            u34:Destroy();
        end;

        u34 = nil;
        u30.Is_Using_Skill = false;
        u30.Is_Attacking = false;
    end;

    forwardVFX(u30, v32, u33);
    local MarkerReachedSignal = v32:GetMarkerReachedSignal("Jump");
    table.insert(u33, MarkerReachedSignal:Connect(function() -- Line: 190
        -- upvalues: SharedUtils (ref), u31 (copy), Character (copy), u34 (ref), u1 (ref)
        SharedUtils.PlaySoundAt(u31, "Sonido", 1);
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return;
        end;

        if u34 and u34.Parent then
            u34:Destroy();
        end;

        u34 = nil;
        u34 = Instance.new("BodyVelocity");
        u34.Name = "KillerInstinctLift";
        u34.MaxForce = Vector3.new(100000, 100000, 100000);
        u34.Velocity = Vector3.new(0, u1.LiftSpeed, 0);
        u34.Parent = HumanoidRootPart;
        task.delay(u1.LiftDuration, function() -- Line: 200
            -- upvalues: u34 (ref)
            if u34 and u34.Parent then
                u34.Velocity = Vector3.new(0, 0, 0);
            end;
        end);
    end));
    local MarkerReachedSignal2 = v32:GetMarkerReachedSignal("Warp");
    table.insert(u33, MarkerReachedSignal2:Connect(function() -- Line: 204
        -- upvalues: SharedUtils (ref), u31 (copy), Character (copy), u34 (ref), findNearestEnemy (ref), u1 (ref), u30 (copy)
        SharedUtils.PlaySoundAt(u31, "Sonido", 1);
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return;
        end;

        if u34 and u34.Parent then
            u34:Destroy();
        end;

        u34 = nil;
        local v36 = findNearestEnemy(HumanoidRootPart);

        if v36 then
            local v37 = v36.CFrame * CFrame.new(0, 0, u1.WarpBehindOffset);
            HumanoidRootPart.CFrame = CFrame.new(v37.Position, v36.Position);
            u30:FaceCameraToward(v36.Position - v37.Position);
        end;
    end));
    local MarkerReachedSignal3 = v32:GetMarkerReachedSignal("hit");
    table.insert(u33, MarkerReachedSignal3:Connect(function() -- Line: 219
        -- upvalues: Character (copy), u31 (copy), SharedUtils (ref), u30 (copy), performHit (ref), u1 (ref)
        local v38 = Character:FindFirstChild("HumanoidRootPart") or u31;
        SharedUtils.PlaySoundAt(v38, "claw4", 1);
        SharedUtils.PlaySoundAt(v38, "claw_slam_01", 1);
        u30:ShakeCamera("SkillHeavy");
        performHit(u30, u1.SpearMultiplier, u1.SpearHitboxSize, u1.SpearHitRange);
    end));
    local MarkerReachedSignal4 = v32:GetMarkerReachedSignal("DBreset");
    table.insert(u33, MarkerReachedSignal4:Connect(u35));
    v32.Stopped:Once(u35);
    task.delay(u1.SpearMaxDuration, function() -- Line: 228
        -- upvalues: u30 (copy), u35 (copy)
        if u30.Is_Using_Skill then
            u35();
        end;
    end);
end;

function u1.Activate(p39, p40) -- Line: 231
    -- upvalues: u1 (copy)
    if (p39.SpecialMoveset or 0) > 0 then
        u1._ActivateSpear(p39);

        return;
    end;

    u1._ActivateSword(p39);
end;

return u1;