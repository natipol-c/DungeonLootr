--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Killer Cadence
  Path:     game.ReplicatedStorage.Classes.Unrestricted.Skills.Killer Cadence
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:50 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    EffectModule = "Killer_Cadence",
    SwordAnim = "Ability_1",
    SwordCooldown = 7,
    SwordMultiplier = 5,
    SwordHitboxSize = Vector3.new(20, 18, 28),
    SwordHitRange = 26,
    SwordMaxDuration = 1.5,
    SpearAnim = "Special_Ability_1",
    SpearCooldown = 10,
    SpearMultiplier = 0.9,
    SpearHitboxSize = Vector3.new(34, 22, 34),
    SpearHitRange = 0,
    SpearDashSpeed = 45,
    SpearDashDuration = 0.12,
    SpearMaxDuration = 2.6,
    Cooldown = 7,
    DualCooldown = true
};

function u1.GetCooldown(p2) -- Line: 43
    -- upvalues: u1 (copy)
    return (p2.SpecialMoveset or 0) > 0 and u1.SpearCooldown or u1.SwordCooldown;
end;

local function ensureAnim(p3, p4) -- Line: 47
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

local function performHit(p8, p9, p10, p11) -- Line: 63
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

local function forwardVFX(u13, p14, p15) -- Line: 76
    -- upvalues: u1 (copy)
    local function emit(p16) -- Line: 77
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

local function stopM1(p18) -- Line: 87
    for i, v in pairs(p18.Animations) do
        if type(i) == "string" and (i:match("^Attack_") and v.IsPlaying) then
            v:Stop();
        end;
    end;
end;

function u1.CanActivate(p19) -- Line: 93
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

function u1._ActivateSword(u20) -- Line: 101
    -- upvalues: ensureAnim (copy), u1 (copy), stopM1 (copy), forwardVFX (copy), SharedUtils (copy), performHit (copy)
    local Character = u20.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local v21 = ensureAnim(u20, u1.SwordAnim);

    if not v21 then
        return;
    end;

    u20.Is_Using_Skill = true;
    u20.Is_Attacking = true;
    stopM1(u20);
    v21:Play();
    local u22 = {};

    local function cleanup() -- Line: 112
        -- upvalues: u22 (copy), u20 (copy)
        for _, v in ipairs(u22) do
            if v.Connected then
                v:Disconnect();
            end;
        end;

        table.clear(u22);
        u20.Is_Using_Skill = false;
        u20.Is_Attacking = false;
    end;

    forwardVFX(u20, v21, u22);
    local MarkerReachedSignal = v21:GetMarkerReachedSignal("hit");
    table.insert(u22, MarkerReachedSignal:Connect(function() -- Line: 119
        -- upvalues: SharedUtils (ref), Character (copy), u20 (copy), performHit (ref), u1 (ref)
        SharedUtils.PlaySoundAt(Character, "claw4", 1);
        u20:PlayCombatSound(u20.ClassData.SwingSoundFolder, nil, 1);
        u20:ShakeCamera("SkillHeavy");
        performHit(u20, u1.SwordMultiplier, u1.SwordHitboxSize, u1.SwordHitRange);
    end));
    local MarkerReachedSignal2 = v21:GetMarkerReachedSignal("DBreset");
    table.insert(u22, MarkerReachedSignal2:Connect(cleanup));
    v21.Stopped:Once(cleanup);
    task.delay(u1.SwordMaxDuration, function() -- Line: 127
        -- upvalues: u20 (copy), cleanup (copy)
        if u20.Is_Using_Skill then
            cleanup();
        end;
    end);
end;

function u1._ActivateSpear(u23) -- Line: 130
    -- upvalues: ensureAnim (copy), u1 (copy), stopM1 (copy), forwardVFX (copy), performHit (copy), Debris (copy)
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

    local v25 = ensureAnim(u23, u1.SpearAnim);

    if not v25 then
        return u1._ActivateSword(u23);
    end;

    u23.Is_Using_Skill = true;
    u23.Is_Attacking = true;
    stopM1(u23);
    v25:Play();
    local u26 = {};
    local u27 = 0;

    local function u28() -- Line: 142
        -- upvalues: u26 (copy), u23 (copy)
        for _, v in ipairs(u26) do
            if v.Connected then
                v:Disconnect();
            end;
        end;

        table.clear(u26);
        u23.Is_Using_Skill = false;
        u23.Is_Attacking = false;
    end;

    forwardVFX(u23, v25, u26);
    local MarkerReachedSignal = v25:GetMarkerReachedSignal("hit");
    table.insert(u26, MarkerReachedSignal:Connect(function() -- Line: 149
        -- upvalues: u27 (ref), u23 (copy), performHit (ref), u1 (ref), Character (copy), Debris (ref)
        u27 = u27 + 1;
        u23:PlayCombatSound(u23.ClassData.SwingSoundFolder, nil, 1);
        u23:ShakeCamera("Hit");
        performHit(u23, u1.SpearMultiplier, u1.SpearHitboxSize, u1.SpearHitRange);
        local v29 = u27 % 2 == 1 and Character:FindFirstChild("HumanoidRootPart");

        if v29 then
            local Humanoid = u23.Humanoid;
            local v30 = Humanoid and (Humanoid.MoveDirection.Magnitude > 0 and Humanoid.MoveDirection.Unit) or v29.CFrame.LookVector;
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.Name = "KillerCadenceDash";
            BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
            BodyVelocity.Velocity = v30 * u1.SpearDashSpeed;
            BodyVelocity.Parent = v29;
            Debris:AddItem(BodyVelocity, u1.SpearDashDuration);
        end;
    end));
    local MarkerReachedSignal2 = v25:GetMarkerReachedSignal("DBreset");
    table.insert(u26, MarkerReachedSignal2:Connect(u28));
    v25.Stopped:Once(u28);
    task.delay(u1.SpearMaxDuration, function() -- Line: 171
        -- upvalues: u23 (copy), u28 (copy)
        if u23.Is_Using_Skill then
            u28();
        end;
    end);
end;

function u1.Activate(p31, p32) -- Line: 174
    -- upvalues: u1 (copy)
    if (p31.SpecialMoveset or 0) > 0 then
        u1._ActivateSpear(p31);

        return;
    end;

    u1._ActivateSword(p31);
end;

return u1;