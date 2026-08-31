--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Hysteria
  Path:     game.ReplicatedStorage.Classes.Sinister Trigger.Skills.Hysteria
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:01 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local SkillRuntime = require(ServerScriptService.Management.Modules.SkillRuntime);
local u1 = {
    Cooldown = 10,
    DamageMultiplier = 1.4,
    FinisherMultiplier = 2,
    AnimationName = "Ability_4",
    BaseHitCount = 7,
    BaseFX = "Shot",
    AltAnimationName = "Ability_4_Alt",
    AltHitCount = 9,
    AltFX = "Demon_Shot",
    AltDamageBonus = 1.45,
    ComboThreshold = 500,
    HitboxSize = Vector3.new(20, 12, 30),
    HitboxRange = 28,
    MaxDuration = 4
};

function u1._PerformHit(p2, p3) -- Line: 67
    -- upvalues: u1 (copy)
    local HitboxSize = p2.ClassData.HitboxSize;
    local Range = p2.ClassData.Range;
    p2.ClassData.HitboxSize = u1.HitboxSize;
    p2.ClassData.Range = u1.HitboxRange;
    local v4 = p2:Hitbox();
    p2.ClassData.HitboxSize = HitboxSize;
    p2.ClassData.Range = Range;
    local v5 = {};

    for _, v in v4 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p2:ApplyDamage(v, (p2:ResolveSkillDamage(p3, v)));
            table.insert(v5, v);
        end;
    end;

    return v5;
end;

function u1.CanActivate(p6) -- Line: 92
    if p6.Is_Attacking then
        return false, "Attacking";
    end;

    if p6.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p6.Is_Dodging then
        return false, "Dodging";
    end;

    if p6.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u7, p8) -- Line: 100
    -- upvalues: u1 (copy), SkillRuntime (copy), SharedUtils (copy)
    local v9 = (u7.Player and (u7.Player:GetAttribute("Hit_Count") or 0) or 0) > u1.ComboThreshold;
    local v10 = v9 and u1.AltAnimationName or u1.AnimationName;
    local u11 = v9 and u1.AltHitCount or u1.BaseHitCount;
    local u12 = v9 and u1.AltFX or u1.BaseFX;
    local u13 = u1.DamageMultiplier * (v9 and u1.AltDamageBonus or 1);
    local v14 = SkillRuntime.EnsureAnimation(u7, v10);

    if not v14 then
        warn("[Hysteria] Animation not found:", v10);

        return;
    end;

    local Character = u7.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u7.Is_Using_Skill = true;
    u7.Is_Attacking = true;
    SkillRuntime.StopAttackAnims(u7);
    v14:Play(0, 1, 1);
    local u15 = 0;
    local u20 = v14:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 130
        -- upvalues: u7 (copy), u15 (ref), u11 (copy), u13 (copy), u1 (ref), u12 (copy), SharedUtils (ref)
        local v16 = u7.Character and u7.Character:FindFirstChild("HumanoidRootPart");

        if not v16 then
            return;
        end;

        u15 = u15 + 1;
        local v17 = u11 <= u15;
        local v18 = u13 * (v17 and u1.FinisherMultiplier or 1);
        u7:PlayFX(u12);
        SharedUtils.PlaySoundAt(v16, u15 % 2 == 1 and "Revolver_1" or "Revolver_1_2", 0.5, 0.05);
        u7:ShakeCamera(v17 and "SkillMedium" or "SkillLight");
        local v19 = u1._PerformHit(u7, v18);

        if #v19 > 0 then
            u7:_FireMasteryPassive("OnSkillHit", {
                HitTargets = v19
            });
        end;
    end);
    v14.Stopped:Once(function() -- Line: 152
        -- upvalues: u20 (ref), u7 (copy)
        if u20 then
            u20:Disconnect();
        end;

        u7.Is_Using_Skill = false;
        u7.Is_Attacking = false;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 159
        -- upvalues: u7 (copy), u20 (ref)
        if u7.Is_Using_Skill then
            u7.Is_Using_Skill = false;
            u7.Is_Attacking = false;
        end;

        if u20 then
            u20:Disconnect();
        end;
    end);
end;

return u1;