--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Surface Slash
  Path:     game.ReplicatedStorage.Classes.Streamline.Skills.Surface Slash
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:44 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 5,
    DamageMultiplier = 4,
    AnimationName = "Ability_2",
    EffectModule = "Surface_Slash",
    Skill_SFX = nil,
    CDResetChance = 0.15,
    CDResetSlots = { 1, 3 },
    ParryDuration = 0.6,
    HitboxSize = Vector3.new(40, 30, 40),
    HitboxRange = 0,
    ImpactSFX = "power_spin_01",
    ImpactVolume = 1,
    MaxDuration = 1.5
};

function u1._EnsureAnimation(p2) -- Line: 55
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    local AnimationName = u1.AnimationName;

    if p2.Animations[AnimationName] then
        return p2.Animations[AnimationName];
    end;

    local v3 = ReplicatedStorage.Classes:FindFirstChild(p2.ClassName);

    if not v3 then
        return nil;
    end;

    local Skill_Animations = v3:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local v4 = Skill_Animations:FindFirstChild(u1.AnimationName);

    if not v4 then
        return nil;
    end;

    local v5 = p2.Humanoid and p2.Humanoid:FindFirstChildOfClass("Animator");

    if not v5 then
        return nil;
    end;

    local v6 = v5:LoadAnimation(v4);
    v6.Priority = Enum.AnimationPriority.Action3;
    v6:Play(0, 0, 0);
    v6:Stop(0);
    p2.Animations[AnimationName] = v6;

    return v6;
end;

function u1._PerformHit(p7) -- Line: 81
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    p7.ClassData.Range = u1.HitboxRange;
    local v8 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;
    local v9 = 0;

    for _, v in v8 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v9 = v9 + 1;
        end;
    end;

    return v9;
end;

function u1.CanActivate(p10) -- Line: 108
    if p10.Is_Attacking then
        return false, "Attacking";
    end;

    if p10.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p10.Is_Dodging then
        return false, "Dodging";
    end;

    if p10.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u11, p12) -- Line: 116
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Surface Slash] Animation not found");

        return;
    end;

    local Character = u11.Character;
    local v14;

    if Character then
        v14 = Character:FindFirstChild("HumanoidRootPart");
    else
        v14 = Character;
    end;

    if not v14 then
        return;
    end;

    u11.Is_Using_Skill = true;
    u11.Is_Attacking = true;

    for i, v in u11.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    Character:SetAttribute("Parry", true);
    task.delay(u1.ParryDuration, function() -- Line: 140
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    v13:Play(0, 1, 1);

    if math.random() < u1.CDResetChance then
        for _, v in u1.CDResetSlots do
            u11:RefreshSkillCooldown(v);
        end;
    end;

    local function onVFX(p15) -- Line: 160
        -- upvalues: u11 (copy), u1 (ref)
        if not p15 or p15 == "" then
            return;
        end;

        local v16 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if not v16 then
            return;
        end;

        u11:PlayEffectModule(u1.EffectModule, "Emit", v16.CFrame, p15);
    end;

    local u17 = v13:GetMarkerReachedSignal("VFX"):Connect(onVFX);
    local u18 = v13:GetMarkerReachedSignal("VFX_2"):Connect(onVFX);
    local u21 = v13:GetMarkerReachedSignal("hit"):Connect(function(p19) -- Line: 171
        -- upvalues: u11 (copy), SharedUtils (ref), u1 (ref)
        local v20 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v20 then
            SharedUtils.PlaySoundAt(v20, u1.ImpactSFX, u1.ImpactVolume);
        end;

        u11:PlayCombatSound(u1.Skill_SFX or u11.ClassData.SwingSoundFolder or "Water_Swings", nil, u11.ClassData.SwingVolume or 0.5);
        u1._PerformHit(u11);
        u11:ShakeCamera("SkillMedium");
    end);
    v13.Stopped:Once(function() -- Line: 193
        -- upvalues: u21 (ref), u17 (copy), u18 (copy), u11 (copy), Character (copy)
        if u21 then
            u21:Disconnect();
        end;

        if u17 then
            u17:Disconnect();
        end;

        if u18 then
            u18:Disconnect();
        end;

        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 207
        -- upvalues: u11 (copy), u21 (ref), u17 (copy), u18 (copy), Character (copy)
        if u11.Is_Using_Skill then
            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;
        end;

        if u21 then
            u21:Disconnect();
        end;

        if u17 then
            u17:Disconnect();
        end;

        if u18 then
            u18:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
end;

return u1;