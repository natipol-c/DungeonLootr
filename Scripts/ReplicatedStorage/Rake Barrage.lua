--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Rake Barrage
  Path:     game.ReplicatedStorage.Classes.Prisma.Skills.Rake Barrage
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:56 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 15,
    AnimationName = "Ability_3",
    Skill_SFX = nil,
    EarlyDamageMult = 0.27,
    EarlyHitboxSize = Vector3.new(20, 10, 25),
    EarlyRange = 25,
    LateDamageMult = 1.05,
    LateHitboxSize = Vector3.new(25, 20, 30),
    LateRange = 30,
    MaxDuration = 4
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
    v6.Priority = Enum.AnimationPriority.Action3;
    v6:Play(0, 0, 0);
    v6:Stop(0);
    p2.Animations[AnimationName] = v6;

    return v6;
end;

function u1._PerformHit(p7, p8) -- Line: 70
    -- upvalues: u1 (copy)
    local v9 = p8 > 7;
    local v10 = v9 and u1.LateDamageMult or u1.EarlyDamageMult;
    local v11 = v9 and u1.LateRange or u1.EarlyRange;
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = v9 and u1.LateHitboxSize or u1.EarlyHitboxSize;
    p7.ClassData.Range = v11;
    local v12 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;

    for _, v in v12 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(v10, v)));
        end;
    end;
end;

function u1.CanActivate(p13) -- Line: 97
    if p13.Is_Attacking then
        return false, "Attacking";
    end;

    if p13.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p13.Is_Dodging then
        return false, "Dodging";
    end;

    if p13.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u14, p15) -- Line: 105
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v16 = u1._EnsureAnimation(u14);

    if not v16 then
        warn("[Rake Barrage] Animation not found");

        return;
    end;

    local Character = u14.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u14.Is_Using_Skill = true;
    u14.Is_Attacking = true;

    for i, v in u14.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v16:Play(0, 1, 1);
    local u17 = 0;
    local u21 = v16:GetMarkerReachedSignal("hit"):Connect(function(p18) -- Line: 133
        -- upvalues: u17 (ref), u14 (copy), SharedUtils (ref), u1 (ref)
        u17 = u17 + 1;
        local v19 = u17;
        local v20 = u14.Character and u14.Character:FindFirstChild("HumanoidRootPart");

        if not v20 then
            return;
        end;

        u14:PlayFX("Ability_3");

        if p18 == "" or not p18 then
            p18 = nil;
        end;

        u14:PlayTurnFX(p18);
        u14:ShakeCamera("Hit");
        u14:PlayCombatSound(u14.ClassData.HitSoundFolder or "Hit", nil, u14.ClassData.HitVolume or 1);

        if v19 == 9 then
            u14:PlayFX("Rose_Dash");
            SharedUtils.PlaySoundAt(v20, "Punch_Shot_1", 0.8);
        end;

        u1._PerformHit(u14, v19);
    end);
    local u22 = nil;
    u22 = v16:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 165
        -- upvalues: u21 (ref), u14 (copy), u22 (ref)
        if u21 then
            u21:Disconnect();
        end;

        u14.Is_Using_Skill = false;
        u14.Is_Attacking = false;

        if u22 then
            u22:Disconnect();
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 175
        -- upvalues: u14 (copy), u21 (ref)
        if u14.Is_Using_Skill then
            u14.Is_Using_Skill = false;
            u14.Is_Attacking = false;
        end;

        if u21 then
            u21:Disconnect();
        end;
    end);
end;

return u1;