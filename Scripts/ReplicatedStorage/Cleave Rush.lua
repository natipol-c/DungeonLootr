--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Cleave Rush
  Path:     game.ReplicatedStorage.Classes.Cursed King.Skills.Cleave Rush
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
    Cooldown = 10,
    AnimationName = "Ability_1",
    EffectModule = "Cleave_Rush",
    DamageMultiplier = 0.25,
    HitInterval = 0.05,
    MaxHits = (1 / 0),
    HitboxSize = Vector3.new(30, 12, 30),
    HitboxRange = 0,
    IFrameDuration = 1,
    CastSFX = { "Sonido", "claw_combo" },
    CastVolume = 1,
    MaxDuration = 2.5,

    CanActivate = function(p1) -- Line: 66, Name: CanActivate
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

function u2.Activate(u3, p4) -- Line: 74
    -- upvalues: SkillRuntime (copy), u2 (copy), SharedUtils (copy)
    local v5 = SkillRuntime.EnsureAnimation(u3, u2.AnimationName);

    if not v5 then
        warn("[Cleave Rush] Animation not found");

        return;
    end;

    local Character = u3.Character;
    local u6;

    if Character then
        u6 = Character:FindFirstChild("HumanoidRootPart");
    else
        u6 = Character;
    end;

    if not u6 then
        return;
    end;

    local u7 = SkillRuntime.AnchorHRP(u3);
    u3.Is_Using_Skill = true;
    u3.Is_Attacking = true;
    Character:SetAttribute("Skill_Camera_Stabilize", true);
    local u8 = SkillRuntime.GrantIFrame(u3, u2.IFrameDuration);
    SkillRuntime.StopAttackAnims(u3);
    v5:Play(0, 1, 1);
    local u9 = nil;
    local v10 = SkillRuntime.MakeLifecycle(u3, v5, u2.MaxDuration, function() -- Line: 107
        -- upvalues: u9 (ref), u3 (copy), u8 (copy), u7 (copy), Character (copy), u2 (ref), u6 (copy)
        if u9 then
            u9();
        end;

        u3.Is_Using_Skill = false;
        u3.Is_Attacking = false;
        u8();
        u7(false);
        Character:SetAttribute("Skill_Camera_Stabilize", false);
        u3:PlayEffectModule(u2.EffectModule, "DBreset", u6.CFrame);
    end);
    local conns = v10.conns;
    conns[#conns + 1] = v5:GetMarkerReachedSignal("Start"):Connect(function() -- Line: 121
        -- upvalues: u9 (ref), u7 (copy), u6 (copy), u3 (copy), u2 (ref), SharedUtils (ref), SkillRuntime (ref)
        if u9 then
            return;
        end;

        u7(true);
        u3:PlayEffectModule(u2.EffectModule, "Start", u6.CFrame);

        for _, v in u2.CastSFX do
            SharedUtils.PlaySoundAt(u6, v, u2.CastVolume);
        end;

        u9 = SkillRuntime.TickFlurry(u3, {
            Interval = u2.HitInterval,
            MaxHits = u2.MaxHits,
            Hitbox = {
                Multiplier = u2.DamageMultiplier,
                Size = u2.HitboxSize,
                Range = u2.HitboxRange
            },

            onTick = function() -- Line: 148, Name: onTick
                -- upvalues: u3 (ref)
                u3:ShakeCamera("SkillMedium");
            end
        });
    end);
    conns[#conns + 1] = v5:GetMarkerReachedSignal("End"):Connect(function() -- Line: 155
        -- upvalues: u9 (ref), u7 (copy), u3 (copy)
        if u9 then
            u9();
        end;

        u7(false);
        u3:ShakeCamera("SkillHeavy");
    end);
    conns[#conns + 1] = v5:GetMarkerReachedSignal("DBreset"):Connect(v10.cleanup);
end;

return u2;