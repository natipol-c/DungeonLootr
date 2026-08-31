--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Red
  Path:     game.ReplicatedStorage.Classes.Honored One.Skills.Red
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:53 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local SkillRuntime = require(ServerScriptService.Management.Modules.SkillRuntime);
local u1 = {
    Cooldown = 9,
    AnimationName = "Ability_2",
    HoldAnimationName = "Ability_2_Hold",
    EffectModule = "Red",
    SFX = "Red_Fast",
    SFXVolume = 2,
    MaxDuration = 2
};
u1.TapForm = {
    vfxMethod = "Tap",
    multiplier = 3.5,
    hitboxSize = Vector3.new(25, 20, 35),
    hitboxRange = 20,
    shake = "SkillHeavy",
    animName = u1.AnimationName
};
u1.HoldForm = {
    vfxMethod = "Hold",
    multiplier = 4,
    hitboxSize = Vector3.new(25, 25, 25),
    hitboxRange = 0,
    shake = "SkillHeavy",
    animName = u1.HoldAnimationName
};

local function runForm(u2, u3) -- Line: 70
    -- upvalues: SkillRuntime (copy), u1 (copy), SharedUtils (copy)
    local v4 = SkillRuntime.EnsureAnimation(u2, u3.animName);

    if not v4 then
        warn((`[Red] Animation "{u3.animName}" not found`));

        return;
    end;

    local Character = u2.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u2.Is_Using_Skill = true;
    u2.Is_Attacking = true;
    SkillRuntime.StopAttackAnims(u2);
    v4:Play(0, 1, 1);
    local u5 = false;
    local conns = SkillRuntime.MakeLifecycle(u2, v4, u1.MaxDuration, function() -- Line: 92
        -- upvalues: u2 (copy)
        u2.Is_Using_Skill = false;
        u2.Is_Attacking = false;
    end).conns;
    conns[#conns + 1] = v4:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 99
        -- upvalues: u5 (ref), u2 (copy), u1 (ref), u3 (copy), Character (copy), SharedUtils (ref), SkillRuntime (ref)
        if u5 then
            return;
        end;

        u5 = true;
        u2:PlayEffectModule(u1.EffectModule, u3.vfxMethod, Character.CFrame);
        SharedUtils.PlaySoundAt(Character, u1.SFX, u1.SFXVolume);
        u2:ShakeCamera(u3.shake);
        SkillRuntime.HitboxSweep(u2, {
            Multiplier = u3.multiplier,
            Size = u3.hitboxSize,
            Range = u3.hitboxRange
        });
    end);
end;

function u1.CanActivate(p6) -- Line: 119
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

function u1.Activate(p7, p8) -- Line: 128
    -- upvalues: runForm (copy), u1 (copy)
    runForm(p7, u1.TapForm);
end;

function u1.ActivateHold(p9, p10) -- Line: 133
    -- upvalues: runForm (copy), u1 (copy)
    runForm(p9, u1.HoldForm);
end;

return u1;