--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Ascetic Rite
  Path:     game.ReplicatedStorage.Classes.Hollow.Skills.Ascetic Rite
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
    Cooldown = 15,
    DamageMultiplier = 3,
    AnimationName = "Ability_3",
    EffectModule = "Ascetic_Rite",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(24, 12, 26),
    HitboxRange = 24,
    DodgeDuration = 0.75,
    HitSFX = "Fire_Woosh",
    SummonCount = 1,
    SummonLifetime = 10,
    SummonColor = Color3.fromRGB(255, 110, 40),
    SummonDamageRate = 0.75,
    MaxDuration = 1.2
};

function u1._EnsureAnimation(p2) -- Line: 60
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

function u1._PerformHit(p7) -- Line: 86
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

function u1._SpawnSummon(p9) -- Line: 109
    -- upvalues: u1 (copy)
    p9:SummonClones({
        Count = u1.SummonCount,
        Lifetime = u1.SummonLifetime,
        Color = u1.SummonColor,
        DamageRate = u1.SummonDamageRate
    });
end;

function u1.CanActivate(p10) -- Line: 120
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

function u1.Activate(u11, p12) -- Line: 128
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Ascetic Rite] Animation not found");

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

    Character:SetAttribute("Dodge", true);
    task.delay(u1.DodgeDuration, function() -- Line: 152
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
    v13:Play(0, 1, 1);
    local u15 = {};

    local function disconnectAll() -- Line: 160
        -- upvalues: u15 (copy)
        for _, v in u15 do
            v:Disconnect();
        end;

        table.clear(u15);
    end;

    local u16 = false;

    local function cleanup() -- Line: 166
        -- upvalues: u16 (ref), u11 (copy), Character (copy), u15 (copy)
        if u16 then
            return;
        end;

        u16 = true;
        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;

        for _, v in u15 do
            v:Disconnect();
        end;

        table.clear(u15);
    end;

    u15[#u15 + 1] = v13:GetMarkerReachedSignal("VFX"):Connect(function(p17) -- Line: 178
        -- upvalues: u11 (copy), u1 (ref)
        if not p17 or p17 == "" then
            return;
        end;

        local v18 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if not v18 then
            return;
        end;

        u11:PlayEffectModule(u1.EffectModule, "Emit", v18.CFrame, p17);
    end);
    u15[#u15 + 1] = v13:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 186
        -- upvalues: u11 (copy), SharedUtils (ref), u1 (ref)
        local v19 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v19 then
            SharedUtils.PlaySoundAt(v19, u1.HitSFX, 0.85);
        end;

        u11:ShakeCamera("SkillMedium");
        u1._PerformHit(u11);
        u1._SpawnSummon(u11);
    end);
    u15[#u15 + 1] = v13:GetMarkerReachedSignal("DBreset"):Connect(cleanup);
    v13.Stopped:Once(cleanup);
    task.delay(u1.MaxDuration, cleanup);
end;

return u1;