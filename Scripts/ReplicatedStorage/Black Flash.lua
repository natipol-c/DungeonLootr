--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Black Flash
  Path:     game.ReplicatedStorage.Classes.Divergent.Skills.Black Flash
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:46 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 9,
    DamageMultiplier = 4,
    AnimationName = "Ability_3",
    EffectModule = "Black_Flash",
    HitboxSize = Vector3.new(20, 22, 32),
    HitboxRange = 32,
    HitSFX = "BlackFlash",
    HitVolume = 1,
    MaxDuration = 1.5
};

function u1._EnsureAnimation(p2) -- Line: 48
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

function u1._PerformHit(p7) -- Line: 75
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

function u1.CanActivate(p9) -- Line: 97
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

function u1.Activate(u10, p11) -- Line: 105
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v12 = u1._EnsureAnimation(u10);

    if not v12 then
        warn("[Black Flash] Animation not found");

        return;
    end;

    u10.Is_Using_Skill = true;
    u10.Is_Attacking = true;

    for i, v in u10.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v12:Play(0, 1, 1);
    local u13 = {};

    local function disconnectAll() -- Line: 130
        -- upvalues: u13 (copy)
        for _, v in u13 do
            v:Disconnect();
        end;

        table.clear(u13);
    end;

    local u14 = false;

    local function releaseState() -- Line: 136
        -- upvalues: u14 (ref), u10 (copy), u1 (ref)
        if u14 then
            return;
        end;

        u14 = true;
        local ClassData = u10.ClassData;

        if ClassData and ClassData.OnSwingEnd then
            ClassData.OnSwingEnd(u10, nil);
        end;

        u10.Is_Using_Skill = false;
        u10.Is_Attacking = false;
        u10:PlayEffectModule(u1.EffectModule, "DBreset");
    end;

    local function emitVFX(p15) -- Line: 152
        -- upvalues: u10 (copy), u1 (ref)
        local v16 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if not v16 then
            return;
        end;

        u10:PlayEffectModule(u1.EffectModule, "Emit", v16.CFrame, p15);
    end;

    u13[#u13 + 1] = v12:GetMarkerReachedSignal("VFX"):Connect(emitVFX);
    u13[#u13 + 1] = v12:GetMarkerReachedSignal("VFX_2"):Connect(emitVFX);
    u13[#u13 + 1] = v12:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 161
        -- upvalues: u10 (copy), SharedUtils (ref), u1 (ref)
        local v18 = u10.Character and u10.Character:FindFirstChild("HumanoidRootPart");

        if v18 then
            SharedUtils.PlaySoundAt(v18, u1.HitSFX, u1.HitVolume);
        end;

        u10:ShakeCamera("SkillHeavy");
        u1._PerformHit(u10);
    end);
    u13[#u13 + 1] = v12:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v12.Stopped:Once(function() -- Line: 175
        -- upvalues: u14 (ref), u10 (copy), u1 (ref), u13 (copy)
        if not u14 then
            u14 = true;
            local ClassData = u10.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u10, nil);
            end;

            u10.Is_Using_Skill = false;
            u10.Is_Attacking = false;
            u10:PlayEffectModule(u1.EffectModule, "DBreset");
        end;

        for _, v in u13 do
            v:Disconnect();
        end;

        table.clear(u13);
    end);
    task.delay(u1.MaxDuration, function() -- Line: 180
        -- upvalues: u14 (ref), u10 (copy), u1 (ref), u13 (copy)
        if not u14 then
            u14 = true;
            local ClassData = u10.ClassData;

            if ClassData and ClassData.OnSwingEnd then
                ClassData.OnSwingEnd(u10, nil);
            end;

            u10.Is_Using_Skill = false;
            u10.Is_Attacking = false;
            u10:PlayEffectModule(u1.EffectModule, "DBreset");
        end;

        for _, v in u13 do
            v:Disconnect();
        end;

        table.clear(u13);
    end);
end;

return u1;