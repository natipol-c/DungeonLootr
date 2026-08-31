--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Domain Shatter
  Path:     game.ReplicatedStorage.Classes.Unrestricted.Skills.Domain Shatter
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:50 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    EffectModule = "Domain_Shatter",
    SwordAnim = "Ability_3",
    SwordCooldown = 13,
    SwordTickMult = 0.6,
    SwordTickInterval = 0.1,
    SwordHitboxSize = Vector3.new(28, 20, 30),
    SwordHitRange = 22,
    SwordMaxDuration = 2.2,
    SpearAnim = "Special_Ability_3",
    SpearCooldown = 15,
    SpearTickMult = 0.25,
    SpearTickInterval = 0.1,
    SpearHitboxSize = Vector3.new(40, 40, 40),
    SpearHitRange = 0,
    SpearMaxDuration = 3.6,
    Cooldown = 13,
    DualCooldown = true
};

function u1.GetCooldown(p2) -- Line: 42
    -- upvalues: u1 (copy)
    return (p2.SpecialMoveset or 0) > 0 and u1.SpearCooldown or u1.SwordCooldown;
end;

local function ensureAnim(p3, p4) -- Line: 46
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

local function performHit(p8, p9, p10, p11) -- Line: 62
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

local function forwardVFX(u13, p14, p15) -- Line: 75
    -- upvalues: u1 (copy)
    local function emit(p16) -- Line: 76
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

local function stopM1(p18) -- Line: 86
    for i, v in pairs(p18.Animations) do
        if type(i) == "string" and (i:match("^Attack_") and v.IsPlaying) then
            v:Stop();
        end;
    end;
end;

local function runFlurry(u19, p20, u21) -- Line: 93
    -- upvalues: stopM1 (copy), forwardVFX (copy), RunService (copy), performHit (copy)
    local Character = u19.Character;
    u19.Is_Using_Skill = true;
    u19.Is_Attacking = true;
    stopM1(u19);
    p20:Play();
    local u22 = {};
    local u23 = nil;
    local u24 = 0;
    local u25 = 0;

    local function stopTicks() -- Line: 101
        -- upvalues: u23 (ref)
        if u23 then
            u23:Disconnect();
            u23 = nil;
        end;
    end;

    local function cleanup() -- Line: 104
        -- upvalues: u22 (copy), u23 (ref), u21 (copy), Character (copy), u19 (copy)
        for _, v in ipairs(u22) do
            if v.Connected then
                v:Disconnect();
            end;
        end;

        table.clear(u22);

        if u23 then
            u23:Disconnect();
            u23 = nil;
        end;

        if u21.parry then
            Character:SetAttribute("Parry", false);
        end;

        u19.Is_Using_Skill = false;
        u19.Is_Attacking = false;
    end;

    forwardVFX(u19, p20, u22);
    local MarkerReachedSignal = p20:GetMarkerReachedSignal("Start");
    table.insert(u22, MarkerReachedSignal:Connect(function() -- Line: 113
        -- upvalues: u21 (copy), Character (copy), u24 (ref), u25 (ref), u23 (ref), RunService (ref), u19 (copy), performHit (ref)
        if u21.parry then
            Character:SetAttribute("Parry", true);
        end;

        if u21.onStart then
            u21.onStart();
        end;

        u24 = 0;
        u25 = 0;
        u23 = RunService.Heartbeat:Connect(function(p26) -- Line: 117
            -- upvalues: u24 (ref), u21 (ref), u25 (ref), u19 (ref), performHit (ref)
            u24 = u24 + p26;

            while u24 >= u21.interval do
                u24 = u24 - u21.interval;
                u25 = u25 + 1;

                if u21.perTickSound then
                    u19:PlayCombatSound(u19.ClassData.SwingSoundFolder, nil, 0.8);
                end;

                if u25 % 3 == 0 then
                    u19:ShakeCamera("SkillLight");
                end;

                performHit(u19, u21.mult, u21.size, u21.range);
            end;
        end);
    end));
    local MarkerReachedSignal2 = p20:GetMarkerReachedSignal("End");
    table.insert(u22, MarkerReachedSignal2:Connect(function() -- Line: 130
        -- upvalues: u23 (ref), u21 (copy), Character (copy), u19 (copy)
        if u23 then
            u23:Disconnect();
            u23 = nil;
        end;

        if u21.parry then
            Character:SetAttribute("Parry", false);
        end;

        if u21.onEnd then
            u21.onEnd();
        end;

        u19:ShakeCamera("SkillHeavy");
    end));
    local MarkerReachedSignal3 = p20:GetMarkerReachedSignal("DBreset");
    table.insert(u22, MarkerReachedSignal3:Connect(cleanup));
    p20.Stopped:Once(cleanup);
    task.delay(u21.maxDuration, function() -- Line: 138
        -- upvalues: u19 (copy), cleanup (copy)
        if u19.Is_Using_Skill then
            cleanup();
        end;
    end);
end;

function u1.CanActivate(p27) -- Line: 141
    if p27.Is_Attacking then
        return false, "Attacking";
    end;

    if p27.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p27.Is_Dodging then
        return false, "Dodging";
    end;

    if p27.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1._ActivateSword(p28) -- Line: 149
    -- upvalues: ensureAnim (copy), u1 (copy), runFlurry (copy), SharedUtils (copy)
    local Character = p28.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local v29 = ensureAnim(p28, u1.SwordAnim);

    if not v29 then
        return;
    end;

    runFlurry(p28, v29, {
        parry = false,
        perTickSound = false,
        interval = u1.SwordTickInterval,
        mult = u1.SwordTickMult,
        size = u1.SwordHitboxSize,
        range = u1.SwordHitRange,
        maxDuration = u1.SwordMaxDuration,

        onStart = function() -- Line: 163, Name: onStart
            -- upvalues: SharedUtils (ref), Character (copy)
            SharedUtils.PlaySoundAt(Character, "Sieghart_Spell_15", 1);
            SharedUtils.PlaySoundAt(Character, "claw_combo", 1);
        end,

        onEnd = function() -- Line: 167, Name: onEnd
            -- upvalues: SharedUtils (ref), Character (copy)
            SharedUtils.PlaySoundAt(Character, "anime_explode", 1);
        end
    });
end;

function u1._ActivateSpear(p30) -- Line: 173
    -- upvalues: ensureAnim (copy), u1 (copy), runFlurry (copy), SharedUtils (copy)
    local Character = p30.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local v31 = ensureAnim(p30, u1.SpearAnim);

    if not v31 then
        return u1._ActivateSword(p30);
    end;

    runFlurry(p30, v31, {
        parry = true,
        perTickSound = true,
        interval = u1.SpearTickInterval,
        mult = u1.SpearTickMult,
        size = u1.SpearHitboxSize,
        range = u1.SpearHitRange,
        maxDuration = u1.SpearMaxDuration,

        onEnd = function() -- Line: 187, Name: onEnd
            -- upvalues: SharedUtils (ref), Character (copy)
            SharedUtils.PlaySoundAt(Character, "claw_slam_01", 1);
        end
    });
end;

function u1.Activate(p32, p33) -- Line: 193
    -- upvalues: u1 (copy)
    if (p32.SpecialMoveset or 0) > 0 then
        u1._ActivateSpear(p32);

        return;
    end;

    u1._ActivateSword(p32);
end;

return u1;