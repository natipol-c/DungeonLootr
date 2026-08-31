--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Sovereign of Shadows
  Path:     game.ReplicatedStorage.Classes.Shadow Vagrant.Skills.Sovereign of Shadows
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:48 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 30,
    MaxCharges = 1,
    DamageMultiplier = 6,
    AnimationName = "Ultimate",
    EffectModule = "Sovereign_of_Shadows",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(36, 18, 40),
    HitboxRange = 30,
    CastParam = "Cast",
    CastSFX = "Black_Flash_Sukuna",
    HitSFX = "Aegis_Explode",
    SummonCount = 4,
    SummonLifetime = 20,
    SummonColor = Color3.fromRGB(10, 10, 14),
    SummonDamageRate = 0.5,
    MaxDuration = 2.6
};

function u1._EnsureAnimation(p2) -- Line: 69
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

function u1._PerformHit(p7) -- Line: 95
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

function u1._SpawnSummon(p9) -- Line: 118
    -- upvalues: u1 (copy)
    p9:SummonClones({
        Count = u1.SummonCount,
        Lifetime = u1.SummonLifetime,
        Color = u1.SummonColor,
        DamageRate = u1.SummonDamageRate
    });
end;

function u1.CanActivate(p10) -- Line: 129
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

function u1.Activate(u11, p12) -- Line: 137
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Sovereign of Shadows] Animation not found");

        return;
    end;

    local Character = u11.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u11.Is_Using_Skill = true;
    u11.Is_Attacking = true;

    for i, v in u11.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v13:Play(0, 1, 1);
    local u14 = {};

    local function disconnectAll() -- Line: 163
        -- upvalues: u14 (copy)
        for _, v in u14 do
            v:Disconnect();
        end;

        table.clear(u14);
    end;

    local u15 = false;

    local function cleanup() -- Line: 169
        -- upvalues: u15 (ref), u11 (copy), u14 (copy)
        if u15 then
            return;
        end;

        u15 = true;
        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;

        for _, v in u14 do
            v:Disconnect();
        end;

        table.clear(u14);
    end;

    u14[#u14 + 1] = v13:GetMarkerReachedSignal("VFX"):Connect(function(p16) -- Line: 181
        -- upvalues: u11 (copy), u1 (ref), SharedUtils (ref)
        if not p16 or p16 == "" then
            return;
        end;

        local v17 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if not v17 then
            return;
        end;

        if p16 == u1.CastParam then
            SharedUtils.PlaySoundAt(v17, u1.CastSFX, 0.9);
        end;

        u11:PlayEffectModule(u1.EffectModule, "Emit", v17.CFrame, p16);
    end);
    u14[#u14 + 1] = v13:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 194
        -- upvalues: u11 (copy), SharedUtils (ref), u1 (ref)
        local v18 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v18 then
            SharedUtils.PlaySoundAt(v18, u1.HitSFX, 0.9);
        end;

        u11:ShakeCamera("SkillHeavy");
        u1._PerformHit(u11);
        u1._SpawnSummon(u11);
    end);
    u14[#u14 + 1] = v13:GetMarkerReachedSignal("DBreset"):Connect(cleanup);
    v13.Stopped:Once(cleanup);
    task.delay(u1.MaxDuration, cleanup);
end;

return u1;