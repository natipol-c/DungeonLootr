--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Cleaving Rush
  Path:     game.ReplicatedStorage.Classes.Cursed King.Skills.Cleaving Rush
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:45 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local SkillRuntime = require(ServerScriptService.Management.Modules.SkillRuntime);
local u2 = {
    Cooldown = 8,
    AnimationName = "Ability_3",
    EffectModule = "Cleaving_Rush",
    PlaybackSpeed = 1.2,
    RangedDamageMultiplier = 0.95,
    RangedHitboxSize = Vector3.new(20, 15, 45),
    RangedHitboxRange = 45,
    FlurryDamageMultiplier = 0.38,
    FlurryHitboxSize = Vector3.new(20, 12, 22),
    FlurryHitboxRange = 18,
    HitInterval = 0.05,
    MaxHits = (1 / 0),
    IFrameDuration = 3,
    FinaleSFX = "claw_combo",
    FinaleVolume = 1,
    MaxDuration = 4,

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
    -- upvalues: SkillRuntime (copy), u2 (copy), SharedUtils (copy)
    local v5 = SkillRuntime.EnsureAnimation(u3, u2.AnimationName);

    if not v5 then
        warn("[Cleaving Rush] Animation not found");

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
    local u6 = SkillRuntime.GrantIFrame(u3, u2.IFrameDuration);
    SkillRuntime.StopAttackAnims(u3);
    v5:Play(0, 1, u2.PlaybackSpeed);
    local u7 = nil;
    local v8 = SkillRuntime.MakeLifecycle(u3, v5, u2.MaxDuration, function() -- Line: 103
        -- upvalues: u7 (ref), u3 (copy), u6 (copy), u2 (ref), Character (copy)
        if u7 then
            u7();
        end;

        u3.Is_Using_Skill = false;
        u3.Is_Attacking = false;
        u6();
        u3:PlayEffectModule(u2.EffectModule, "DBreset", Character.CFrame);
    end);
    local conns = v8.conns;
    conns[#conns + 1] = v5:GetMarkerReachedSignal("hit"):Connect(function(p9) -- Line: 115
        -- upvalues: SkillRuntime (ref), u3 (copy), u2 (ref), Character (copy)
        SkillRuntime.HitboxSweep(u3, {
            Multiplier = u2.RangedDamageMultiplier,
            Size = u2.RangedHitboxSize,
            Range = u2.RangedHitboxRange
        });
        u3:ShakeCamera("SkillHeavy");
        u3:PlayCombatSound(u3.ClassData.SwingSoundFolder or "Sword_Swings", nil, u3.ClassData.SwingVolume or 0.5);

        if p9 and p9 ~= "" then
            u3:PlayEffectModule(u2.EffectModule, "Hit", Character.CFrame, p9);
        end;
    end);
    conns[#conns + 1] = v5:GetMarkerReachedSignal("Start"):Connect(function(p10) -- Line: 137
        -- upvalues: u7 (ref), Character (copy), u3 (copy), u2 (ref), SharedUtils (ref), SkillRuntime (ref)
        if u7 then
            return;
        end;

        local CFrame = Character.CFrame;

        if p10 and p10 ~= "" then
            u3:PlayEffectModule(u2.EffectModule, "Start", CFrame, p10);
        end;

        SharedUtils.PlaySoundAt(Character, u2.FinaleSFX, u2.FinaleVolume);
        u7 = SkillRuntime.TickFlurry(u3, {
            Interval = u2.HitInterval,
            MaxHits = u2.MaxHits,
            Hitbox = {
                Multiplier = u2.FlurryDamageMultiplier,
                Size = u2.FlurryHitboxSize,
                Range = u2.FlurryHitboxRange
            },

            onTick = function() -- Line: 157, Name: onTick
                -- upvalues: u3 (ref)
                u3:ShakeCamera("SkillMedium");
            end
        });
    end);
    conns[#conns + 1] = v5:GetMarkerReachedSignal("End"):Connect(function() -- Line: 164
        -- upvalues: u7 (ref)
        if u7 then
            u7();
        end;
    end);
    conns[#conns + 1] = v5:GetMarkerReachedSignal("DBreset"):Connect(v8.cleanup);
end;

return u2;