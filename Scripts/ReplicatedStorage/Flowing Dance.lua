--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Flowing Dance
  Path:     game.ReplicatedStorage.Classes.Streamline.Skills.Flowing Dance
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:44 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u7 = {
    Cooldown = 8,
    DamageMultiplier = 0.83,
    Skill_SFX = nil,
    BaseAnim = "Ability_3",
    BaseEffect = "Flowing_Dance",
    VariantAnim = "Ability_3_2",
    VariantEffect = "Flowing_Dance_VAR",
    VariantChance = 0.35,
    VariantDamageBonus = 0.4,
    IFrameDuration = 1.7,
    OpeningSFX = "power_spin_04",
    OpeningVolume = 1,
    HitboxSize = Vector3.new(24, 20, 28),
    HitboxRange = 18,
    TotalHits = 6,
    MaxDuration = 2,

    _EnsureAnimation = function(p1, p2) -- Line: 64, Name: _EnsureAnimation
        -- upvalues: ReplicatedStorage (copy)
        if p1.Animations[p2] then
            return p1.Animations[p2];
        end;

        local v3 = ReplicatedStorage.Classes:FindFirstChild(p1.ClassName);

        if not v3 then
            return nil;
        end;

        local Skill_Animations = v3:FindFirstChild("Skill_Animations");

        if not Skill_Animations then
            return nil;
        end;

        local v4 = Skill_Animations:FindFirstChild(p2);

        if not v4 then
            return nil;
        end;

        local v5 = p1.Humanoid and p1.Humanoid:FindFirstChildOfClass("Animator");

        if not v5 then
            return nil;
        end;

        local v6 = v5:LoadAnimation(v4);
        v6.Priority = Enum.AnimationPriority.Action3;
        v6:Play(0, 0, 0);
        v6:Stop(0);
        p1.Animations[p2] = v6;

        return v6;
    end
};

function u7._PerformHit(p8, p9) -- Line: 89
    -- upvalues: u7 (copy)
    local HitboxSize = p8.ClassData.HitboxSize;
    local Range = p8.ClassData.Range;
    p8.ClassData.HitboxSize = u7.HitboxSize;
    p8.ClassData.Range = u7.HitboxRange;
    local v10 = p8:Hitbox();
    p8.ClassData.HitboxSize = HitboxSize;
    p8.ClassData.Range = Range;
    local v11 = 0;

    for _, v in v10 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p8:ApplyDamage(v, (p8:ResolveSkillDamage(p9, v)));
            v11 = v11 + 1;
        end;
    end;

    return v11;
end;

function u7.CanActivate(p12) -- Line: 115
    if p12.Is_Attacking then
        return false, "Attacking";
    end;

    if p12.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p12.Is_Dodging then
        return false, "Dodging";
    end;

    if p12.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u7.Activate(u13, p14) -- Line: 123
    -- upvalues: u7 (copy), SharedUtils (copy)
    local v15 = math.random() < u7.VariantChance;
    local v16 = v15 and u7.VariantAnim or u7.BaseAnim;
    local u17 = v15 and u7.VariantEffect or u7.BaseEffect;
    local u18 = v15 and u7.DamageMultiplier * (1 + u7.VariantDamageBonus) or u7.DamageMultiplier;
    local v19 = u7._EnsureAnimation(u13, v16);

    if not v19 then
        warn("[Flowing Dance] Animation not found:", v16);

        return;
    end;

    local Character = u13.Character;
    local v20;

    if Character then
        v20 = Character:FindFirstChild("HumanoidRootPart");
    else
        v20 = Character;
    end;

    if not v20 then
        return;
    end;

    u13.Is_Using_Skill = true;
    u13.Is_Attacking = true;

    for i, v in u13.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    if u13.Player then
        u13.Player:SetAttribute("iFrame", true);
    end;

    Character:SetAttribute("iFrame", true);
    task.delay(u7.IFrameDuration, function() -- Line: 157
        -- upvalues: u13 (copy)
        if u13.Player then
            u13.Player:SetAttribute("iFrame", false);
        end;

        if u13.Character then
            u13.Character:SetAttribute("iFrame", false);
        end;
    end);
    v19:Play(0, 1, 1);
    local u21 = {};

    local function disconnectAll() -- Line: 167
        -- upvalues: u21 (copy)
        for _, v in u21 do
            v:Disconnect();
        end;

        table.clear(u21);
    end;

    u21[#u21 + 1] = v19:GetMarkerReachedSignal("VFX"):Connect(function(p22) -- Line: 173
        -- upvalues: u13 (copy), u17 (copy)
        if not p22 or p22 == "" then
            return;
        end;

        local v23 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if not v23 then
            return;
        end;

        u13:PlayEffectModule(u17, "Emit", v23.CFrame, p22);
    end);
    local u24 = 0;
    u21[#u21 + 1] = v19:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 182
        -- upvalues: u24 (ref), u13 (copy), SharedUtils (ref), u7 (ref), u18 (copy)
        u24 = u24 + 1;
        local v25 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if u24 == 1 and v25 then
            SharedUtils.PlaySoundAt(v25, u7.OpeningSFX, u7.OpeningVolume);
        end;

        u13:PlayCombatSound(u7.Skill_SFX or u13.ClassData.SwingSoundFolder or "Water_Swings", nil, u13.ClassData.SwingVolume or 0.5);
        u7._PerformHit(u13, u18);
        u13:ShakeCamera("Hit");
    end);
    local u26 = false;

    local function releaseState() -- Line: 202
        -- upvalues: u26 (ref), u13 (copy)
        if u26 then
            return;
        end;

        u26 = true;
        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;
    end;

    u21[#u21 + 1] = v19:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v19.Stopped:Once(function() -- Line: 214
        -- upvalues: u26 (ref), u13 (copy), u21 (copy)
        if not u26 then
            u26 = true;
            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        for _, v in u21 do
            v:Disconnect();
        end;

        table.clear(u21);
    end);
    task.delay(u7.MaxDuration, function() -- Line: 218
        -- upvalues: u26 (ref), u13 (copy), u21 (copy)
        if not u26 then
            u26 = true;
            u13.Is_Using_Skill = false;
            u13.Is_Attacking = false;
        end;

        for _, v in u21 do
            v:Disconnect();
        end;

        table.clear(u21);
    end);
end;

return u7;