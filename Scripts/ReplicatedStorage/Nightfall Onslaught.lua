--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Nightfall Onslaught
  Path:     game.ReplicatedStorage.Classes.Sunless.Skills.Nightfall Onslaught
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:00 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 10,
    MaxCharges = 1,
    HitCount = 4,
    DamageMultiplier = 2,
    AnimationName = "Ability_3",
    EffectModule = "Nightfall_Onslaught",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(45, 20, 50),
    HitboxRange = 40,
    DodgeDuration = 2.35,
    ChargeParam = "Charge",
    ChargeSFX = "Sonido",
    FinalHitSFX = "Wukong_Smash4",
    MaxDuration = 2.9
};

function u1._EnsureAnimation(p2) -- Line: 56
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

function u1._PerformHit(p7) -- Line: 82
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    p7.ClassData.Range = u1.HitboxRange;
    local v8 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;

    for _, v in v8 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(u1.DamageMultiplier, v)));
        end;
    end;
end;

function u1.CanActivate(p9) -- Line: 104
    if p9.Is_Attacking then
        return false, "Attacking";
    end;

    if p9.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p9.Is_Dodging then
        return false, "Dodging";
    end;

    if p9.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u10, p11) -- Line: 112
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v12 = u1._EnsureAnimation(u10);

    if not v12 then
        warn("[Nightfall Onslaught] Animation not found");

        return;
    end;

    local Character = u10.Character;
    local v13;

    if Character then
        v13 = Character:FindFirstChild("HumanoidRootPart");
    else
        v13 = Character;
    end;

    if not v13 then
        return;
    end;

    u10.Is_Using_Skill = true;
    u10.Is_Attacking = true;

    for i, v in u10.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    Character:SetAttribute("Dodge", true);
    task.delay(u1.DodgeDuration, function() -- Line: 136
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
    v12:Play(0, 1, 1);
    local u14 = {};

    local function disconnectAll() -- Line: 144
        -- upvalues: u14 (copy)
        for _, v in u14 do
            v:Disconnect();
        end;

        table.clear(u14);
    end;

    local u15 = false;

    local function cleanup() -- Line: 150
        -- upvalues: u15 (ref), u10 (copy), Character (copy), u14 (copy)
        if u15 then
            return;
        end;

        u15 = true;
        u10.Is_Using_Skill = false;
        u10.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;

        for _, v in u14 do
            v:Disconnect();
        end;

        table.clear(u14);
    end;

    u14[#u14 + 1] = v12:GetMarkerReachedSignal("VFX"):Connect(function(p16) -- Line: 163
        -- upvalues: u10 (copy), u1 (ref), SharedUtils (ref)
        if not p16 or p16 == "" then
            return;
        end;

        local v17 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if not v17 then
            return;
        end;

        if p16 == u1.ChargeParam then
            SharedUtils.PlaySoundAt(v17, u1.ChargeSFX, 0.85);
        end;

        u10:PlayEffectModule(u1.EffectModule, "Emit", v17.CFrame, p16);
    end);
    local u18 = 0;
    u14[#u14 + 1] = v12:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 177
        -- upvalues: u18 (ref), u10 (copy), u1 (ref), SharedUtils (ref)
        u18 = u18 + 1;
        u10:ShakeCamera("Hit");
        u10:PlayCombatSound(u1.Skill_SFX or u10.ClassData.SwingSoundFolder or "Electric_Swing", nil, u10.ClassData.SwingVolume or 1);

        if u18 >= u1.HitCount then
            local v19 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

            if v19 then
                SharedUtils.PlaySoundAt(v19, u1.FinalHitSFX, 0.9);
            end;

            u10:ShakeCamera("SkillHeavy");
        end;

        u1._PerformHit(u10);
    end);
    u14[#u14 + 1] = v12:GetMarkerReachedSignal("DBreset"):Connect(cleanup);
    v12.Stopped:Once(cleanup);
    task.delay(u1.MaxDuration, cleanup);
end;

return u1;