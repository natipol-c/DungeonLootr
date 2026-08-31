--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Slash Combo
  Path:     game.ReplicatedStorage.Classes.Cursed King.Skills.Slash Combo
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
    Cooldown = 6,
    AnimationName = "Ability_2",
    EffectModule = "Slash_Combo",
    DamageMultiplier = 0.26,
    HitInterval = 0.05,
    MaxHits = (1 / 0),
    HitboxSize = Vector3.new(20, 12, 22),
    HitboxRange = 18,
    IFrameDuration = 1,
    HitSFX = "hit_ultema_s_1",
    HitVolume = 1,
    MaxDuration = 2.5,

    CanActivate = function(p1) -- Line: 62, Name: CanActivate
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

function u2.Activate(u3, p4) -- Line: 70
    -- upvalues: SkillRuntime (copy), u2 (copy), SharedUtils (copy)
    local v5 = SkillRuntime.EnsureAnimation(u3, u2.AnimationName);

    if not v5 then
        warn("[Slash Combo] Animation not found");

        return;
    end;

    local Character = u3.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local u6 = SkillRuntime.AnchorHRP(u3);
    u3.Is_Using_Skill = true;
    u3.Is_Attacking = true;
    local u7 = SkillRuntime.GrantIFrame(u3, u2.IFrameDuration);
    SkillRuntime.StopAttackAnims(u3);
    v5:Play(0, 1, 1);
    local u8 = nil;
    local v9 = SkillRuntime.MakeLifecycle(u3, v5, u2.MaxDuration, function() -- Line: 98
        -- upvalues: u8 (ref), u3 (copy), u7 (copy), u6 (copy), u2 (ref), Character (copy)
        if u8 then
            u8();
        end;

        u3.Is_Using_Skill = false;
        u3.Is_Attacking = false;
        u7();
        u6(false);
        u3:PlayEffectModule(u2.EffectModule, "DBreset", Character.CFrame);
    end);
    local conns = v9.conns;
    conns[#conns + 1] = v5:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 111
        -- upvalues: u8 (ref), u6 (copy), Character (copy), u3 (copy), u2 (ref), SkillRuntime (ref), SharedUtils (ref)
        if u8 then
            return;
        end;

        u6(true);
        u3:PlayEffectModule(u2.EffectModule, "Start", Character.CFrame);
        u8 = SkillRuntime.TickFlurry(u3, {
            Interval = u2.HitInterval,
            MaxHits = u2.MaxHits,
            Hitbox = {
                Multiplier = u2.DamageMultiplier,
                Size = u2.HitboxSize,
                Range = u2.HitboxRange
            },

            onTick = function() -- Line: 133, Name: onTick
                -- upvalues: SharedUtils (ref), Character (ref), u2 (ref), u3 (ref)
                SharedUtils.PlaySoundAt(Character, u2.HitSFX, u2.HitVolume);
                u3:ShakeCamera("SkillLight");
            end
        });
    end);
    conns[#conns + 1] = v5:GetMarkerReachedSignal("End"):Connect(function() -- Line: 141
        -- upvalues: u8 (ref), u6 (copy)
        if u8 then
            u8();
        end;

        u6(false);
    end);
    conns[#conns + 1] = v5:GetMarkerReachedSignal("DBreset"):Connect(v9.cleanup);
end;

return u2;