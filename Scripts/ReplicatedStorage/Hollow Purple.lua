--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Hollow Purple
  Path:     game.ReplicatedStorage.Classes.Honored One.Skills.Hollow Purple
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
local u2 = {
    Cooldown = 30,
    AnimationName = "Ability_3",
    InstantAnimationName = "Ability_3_Instant",
    VFXModel = "Purple",
    InstantVFXModel = "Purple_Instant",
    EffectModule = "Hollow_Purple",
    StartSFX = "Blue_Spell_Fast",
    StartVolume = 1,
    EndSFX = "explosion_punch",
    EndVolume = 3,
    Multiplier = 8,
    HitboxSize = Vector3.new(30, 30, 50),
    HitboxRange = 40,
    MaxDuration = 6,

    CanActivate = function(p1) -- Line: 70, Name: CanActivate
        if p1.Is_Attacking then
            return false, "Attacking";
        end;

        if p1.Is_Using_Skill then
            return false, "Skill in progress";
        end;

        if p1.Is_Dodging then
            return false, "Dodging";
        end;

        if p1.Is_Stunned then
            return false, "Stunned";
        end;

        return true;
    end
};

function u2.Activate(u3, p4) -- Line: 78
    -- upvalues: u2 (copy), SkillRuntime (copy), SharedUtils (copy)
    local u5 = (u3.SpecialMoveset or 0) > 0;
    local v6 = u5 and u2.InstantAnimationName or u2.AnimationName;
    local u7 = u5 and u2.InstantVFXModel or u2.VFXModel;
    local v8 = SkillRuntime.EnsureAnimation(u3, v6);

    if not v8 then
        warn((`[Hollow Purple] Animation "{v6}" not found`));

        return;
    end;

    local Character = u3.Character;
    local u9;

    if Character then
        u9 = Character:FindFirstChild("HumanoidRootPart");
    else
        u9 = Character;
    end;

    if not u9 then
        return;
    end;

    u3.Is_Using_Skill = true;
    u3.Is_Attacking = true;
    local u10 = SkillRuntime.AnchorHRP(u3);
    SkillRuntime.StopAttackAnims(u3);
    v8:Play(0, 1, 1);

    if not u5 then
        u3:PlayEffectModule(u2.EffectModule, "Emit", u9.CFrame, u7);
    end;

    local u11 = false;
    local conns = SkillRuntime.MakeLifecycle(u3, v8, u2.MaxDuration, function() -- Line: 116
        -- upvalues: u10 (copy), Character (copy), u3 (copy)
        u10(false);
        Character:SetAttribute("Skill_Camera_Stabilize", false);
        u3.Is_Using_Skill = false;
        u3.Is_Attacking = false;
    end).conns;
    conns[#conns + 1] = v8:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 125
        -- upvalues: u10 (copy), Character (copy), SharedUtils (ref), u9 (copy), u2 (ref)
        u10(true);
        Character:SetAttribute("Skill_Camera_Stabilize", true);
        SharedUtils.PlaySoundAt(u9, u2.StartSFX, u2.StartVolume);
    end);
    conns[#conns + 1] = v8:GetMarkerReachedSignal("End"):Connect(function() -- Line: 134
        -- upvalues: u11 (ref), u10 (copy), Character (copy), u5 (copy), u3 (copy), u2 (ref), u9 (copy), u7 (copy), SharedUtils (ref), SkillRuntime (ref)
        if u11 then
            return;
        end;

        u11 = true;
        u10(false);
        Character:SetAttribute("Skill_Camera_Stabilize", false);

        if u5 then
            u3:PlayEffectModule(u2.EffectModule, "Emit", u9.CFrame, u7);
        end;

        u3:PlayEffectModule(u2.EffectModule, "ScreenEffect", u9.CFrame);
        u3:ShakeCamera("SkillHeavy");
        SharedUtils.PlaySoundAt(u9, u2.EndSFX, u2.EndVolume);
        SkillRuntime.HitboxSweep(u3, {
            Multiplier = u2.Multiplier,
            Size = u2.HitboxSize,
            Range = u2.HitboxRange
        });
    end);
end;

return u2;