--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Wolfs Fang
  Path:     game.ReplicatedStorage.Classes.Boxer.Skills.Wolfs Fang
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:53 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 13,
    DamageMultiplier = 2.5,
    AnimationName = "Ability_4",
    HitboxSize = Vector3.new(22, 12, 26),
    HitboxRange = 26,
    JojoVolume = 0.85,
    ExplosionVolume = 0.9,
    RoarVolume = 0.9,
    MaxDuration = 2.5
};

function u1._EnsureAnimation(p2) -- Line: 44
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
    v6.Priority = Enum.AnimationPriority.Action4;
    v6:Play(0, 0, 0);
    v6:Stop(0);
    p2.Animations[AnimationName] = v6;

    return v6;
end;

function u1._PerformHit(p7) -- Line: 71
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

function u1.CanActivate(p10) -- Line: 97
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

function u1.Activate(u11, p12) -- Line: 105
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v13 = u1._EnsureAnimation(u11);

    if not v13 then
        warn("[Wolfs Fang] Animation not found");

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

    local function disconnectAll() -- Line: 128
        -- upvalues: u14 (copy)
        for _, v in u14 do
            v:Disconnect();
        end;

        table.clear(u14);
    end;

    local u15 = false;

    local function releaseState() -- Line: 136
        -- upvalues: u15 (ref), u11 (copy)
        if u15 then
            return;
        end;

        u15 = true;
        u11.Is_Using_Skill = false;
        u11.Is_Attacking = false;
    end;

    local u16 = 0;
    u14[#u14 + 1] = v13:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 148
        -- upvalues: u16 (ref), u11 (copy), SharedUtils (ref), u1 (ref)
        u16 = u16 + 1;
        local v18 = u11.Character and u11.Character:FindFirstChild("HumanoidRootPart");

        if v18 then
            if u16 == 1 then
                SharedUtils.PlaySoundAt(v18, "jojo punch", u1.JojoVolume);
            else
                SharedUtils.PlaySoundAt(v18, "explosion_punch", u1.ExplosionVolume);
                SharedUtils.PlaySoundAt(v18, "Tiger_Roar", u1.RoarVolume);
            end;
        end;

        if p17 == "" or not p17 then
            p17 = nil;
        end;

        u11:PlayTurnFX(p17);
        u11:ShakeCamera(u16 >= 2 and "SkillHeavy" or "SkillMedium");
        u1._PerformHit(u11);
    end);
    u14[#u14 + 1] = v13:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v13.Stopped:Once(function() -- Line: 170
        -- upvalues: u15 (ref), u11 (copy), u14 (copy)
        if not u15 then
            u15 = true;
            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;
        end;

        for _, v in u14 do
            v:Disconnect();
        end;

        table.clear(u14);
    end);
    task.delay(u1.MaxDuration, function() -- Line: 175
        -- upvalues: u15 (ref), u11 (copy), u14 (copy)
        if not u15 then
            u15 = true;
            u11.Is_Using_Skill = false;
            u11.Is_Attacking = false;
        end;

        for _, v in u14 do
            v:Disconnect();
        end;

        table.clear(u14);
    end);
end;

return u1;