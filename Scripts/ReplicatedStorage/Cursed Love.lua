--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Cursed Love
  Path:     game.ReplicatedStorage.Classes.Cursed Child.Skills.Cursed Love
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:51 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local SkillRuntime = require(ServerScriptService.Management.Modules.SkillRuntime);
local u2 = {
    Cooldown = 15,
    AnimationName = "Ability_4",
    EffectModule = "Cursed_Love",
    Skill_SFX = nil,
    TickMultiplier = 0.33,
    TickInterval = 0.08,
    MaxHits = 15,
    TickHitboxSize = Vector3.new(30, 30, 45),
    TickHitboxRange = 40,
    VoiceSFX = "Rika",
    StartSFX1 = "RikaScream1",
    StartSFX2 = "Sieghart_Spell_15",
    SFXVolume = 1,
    MaxDuration = 5,

    CanActivate = function(p1) -- Line: 61, Name: CanActivate
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

function u2.Activate(u3, p4) -- Line: 69
    -- upvalues: SkillRuntime (copy), u2 (copy), SharedUtils (copy)
    local v5 = SkillRuntime.EnsureAnimation(u3, u2.AnimationName);

    if not v5 then
        warn("[Cursed Love] Animation not found");

        return;
    end;

    local Character = u3.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u3.Is_Using_Skill = true;
    u3.Is_Attacking = true;
    SkillRuntime.StopAttackAnims(u3);
    v5:Play(0, 1, 1);
    local u6 = nil;
    local v7 = SkillRuntime.MakeLifecycle(u3, v5, u2.MaxDuration, function() -- Line: 90
        -- upvalues: u6 (ref), u3 (copy)
        if u6 then
            u6();
        end;

        u3.Is_Using_Skill = false;
        u3.Is_Attacking = false;
    end);
    local conns = v7.conns;

    for _, v in SkillRuntime.BindVFXMarkers(u3, v5, u2.EffectModule, 2) do
        conns[#conns + 1] = v;
    end;

    conns[#conns + 1] = v5:GetMarkerReachedSignal("Voice"):Connect(function() -- Line: 103
        -- upvalues: u3 (copy), SharedUtils (ref), u2 (ref)
        local v8 = u3.Character and u3.Character:FindFirstChild("HumanoidRootPart");

        if v8 then
            SharedUtils.PlaySoundAt(v8, u2.VoiceSFX, u2.SFXVolume);
        end;
    end);
    conns[#conns + 1] = v5:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 109
        -- upvalues: u6 (ref), u3 (copy), SharedUtils (ref), u2 (ref), SkillRuntime (ref)
        if u6 then
            return;
        end;

        local v9 = u3.Character and u3.Character:FindFirstChild("HumanoidRootPart");

        if v9 then
            SharedUtils.PlaySoundAt(v9, u2.StartSFX1, u2.SFXVolume);
            SharedUtils.PlaySoundAt(v9, u2.StartSFX2, u2.SFXVolume);
        end;

        u6 = SkillRuntime.TickFlurry(u3, {
            Interval = u2.TickInterval,
            MaxHits = u2.MaxHits,
            Hitbox = {
                Multiplier = u2.TickMultiplier,
                Size = u2.TickHitboxSize,
                Range = u2.TickHitboxRange
            },

            onTick = function() -- Line: 126, Name: onTick
                -- upvalues: u3 (ref)
                u3:ShakeCamera("SkillLight");
            end
        });
    end);
    conns[#conns + 1] = v5:GetMarkerReachedSignal("DBreset"):Connect(v7.cleanup);
end;

return u2;