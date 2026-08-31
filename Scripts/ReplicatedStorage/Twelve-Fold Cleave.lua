--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Twelve-Fold Cleave
  Path:     game.ReplicatedStorage.Classes.Anti Magic.Skills.Twelve-Fold Cleave
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:47 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 15,
    AnimationName = "Ability_2",
    MainMultiplier = 0.43,
    FinisherMultiplier = 0.38,
    HitboxSize = Vector3.new(25, 25, 35),
    HitboxRange = 35,
    MaxDuration = 3.5
};

function u1._EnsureAnimation(p2) -- Line: 45
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

function u1._PerformHit(p7, p8) -- Line: 71
    -- upvalues: u1 (copy)
    local HitboxSize = p7.ClassData.HitboxSize;
    local Range = p7.ClassData.Range;
    p7.ClassData.HitboxSize = u1.HitboxSize;
    p7.ClassData.Range = u1.HitboxRange;
    local v9 = p7:Hitbox();
    p7.ClassData.HitboxSize = HitboxSize;
    p7.ClassData.Range = Range;
    local v10 = 0;

    for _, v in v9 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p7:ApplyDamage(v, (p7:ResolveSkillDamage(p8, v)));
            v10 = v10 + 1;
        end;
    end;

    return v10;
end;

function u1.CanActivate(p11) -- Line: 97
    if p11.Is_Attacking then
        return false, "Attacking";
    end;

    if p11.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p11.Is_Dodging then
        return false, "Dodging";
    end;

    if p11.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u12, p13) -- Line: 105
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v14 = u1._EnsureAnimation(u12);

    if not v14 then
        warn("[Twelve-Fold Cleave] Animation not found");

        return;
    end;

    local Character = u12.Character;

    if not Character then
        return;
    end;

    u12.Is_Using_Skill = true;
    u12.Is_Attacking = true;

    for i, v in u12.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    Character:SetAttribute("Parry", true);
    v14:Play(0, 1, 1);
    local u15 = 0;
    local u19 = v14:GetMarkerReachedSignal("hit"):Connect(function(p16) -- Line: 135
        -- upvalues: u15 (ref), u12 (copy), Character (copy), SharedUtils (ref), u1 (ref)
        u15 = u15 + 1;
        u12:PlayCombatSound(u12.ClassData.SwingSoundFolder or "Sword_Swings", nil, u12.ClassData.SwingVolume or 0.5);
        local v17 = u15 == 10 and Character:FindFirstChild("HumanoidRootPart");

        if v17 then
            SharedUtils.PlaySoundAt(v17, "Electric Explosion 2", 1);
        end;

        if p16 == "" or not p16 then
            p16 = nil;
        end;

        u12:PlayTurnFX(p16);
        u12:ShakeCamera("Hit");
        local v18;

        if u15 <= 9 then
            v18 = u1.MainMultiplier;
        else
            v18 = u1.FinisherMultiplier;
        end;

        u1._PerformHit(u12, v18);
    end);
    v14.Stopped:Once(function() -- Line: 162
        -- upvalues: u19 (ref), Character (copy), u12 (copy)
        if u19 then
            u19:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;

        u12.Is_Using_Skill = false;
        u12.Is_Attacking = false;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 171
        -- upvalues: u12 (copy), u19 (ref), Character (copy)
        if u12.Is_Using_Skill then
            u12.Is_Using_Skill = false;
            u12.Is_Attacking = false;
        end;

        if u19 then
            u19:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
end;

return u1;