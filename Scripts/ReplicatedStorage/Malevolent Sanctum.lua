--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Malevolent Sanctum
  Path:     game.ReplicatedStorage.Classes.Cursed King.Skills.Malevolent Sanctum
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:45 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {
    Cooldown = 15,
    AnimationName = "Ultimate",
    EffectModule = "Malevolent_Sanctum",
    EffectMethod = "Activate",
    SlashDelay = 12.65,
    ActiveDuration = 5,
    TickInterval = 0.2,
    DamageMultiplier = 1.4,
    HitboxSize = Vector3.new(70, 40, 70),
    HitboxRange = 0,
    ReleasePadding = 0.5
};

function u1._EnsureAnimation(p2) -- Line: 68
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

function u1._PerformTick(p7) -- Line: 95
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

function u1.CanActivate(p9) -- Line: 117
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

function u1.Activate(u10, p11) -- Line: 125
    -- upvalues: u1 (copy)
    local v12 = u1._EnsureAnimation(u10);

    if not v12 then
        warn("[Malevolent Sanctum] Animation not found");

        return;
    end;

    local Character = u10.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local CFrame = Character.CFrame;
    u10.Is_Using_Skill = true;
    u10.Is_Attacking = true;

    for i, v in u10.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    u10:PlayEffectModule(u1.EffectModule, u1.EffectMethod, CFrame);
    v12:Play(0, 1, 1);
    local u13 = false;

    local function cleanup() -- Line: 160
        -- upvalues: u13 (ref), u10 (copy)
        if u13 then
            return;
        end;

        u13 = true;
        u10.Is_Using_Skill = false;
        u10.Is_Attacking = false;
    end;

    task.delay(u1.SlashDelay, function() -- Line: 169
        -- upvalues: u13 (ref), u1 (ref), u10 (copy)
        if u13 then
            return;
        end;

        local v14 = 0;

        while not u13 and (v14 < u1.ActiveDuration and (u10.Character and u10.Character.Parent)) do
            u1._PerformTick(u10);
            u10:ShakeCamera("SkillMedium");
            task.wait(u1.TickInterval);
            v14 = v14 + u1.TickInterval;
        end;

        if u13 then
            return;
        end;

        u13 = true;
        u10.Is_Using_Skill = false;
        u10.Is_Attacking = false;
    end);
    task.delay(u1.SlashDelay + u1.ActiveDuration + u1.ReleasePadding, cleanup);
end;

return u1;