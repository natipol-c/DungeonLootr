--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Mutations.Verdant.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:07 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StatusEffectScheduler = require(ReplicatedStorage.Modules.StatusEffectScheduler);
local Color3_fromRGB_ret = Color3.fromRGB(120, 210, 70);

return {
    Name = "Verdant",
    Procs = {
        {
            Name = "Verdant_Poison",
            Trigger = "OnBasicHit",
            Cooldown = 0,

            Execute = function(p1, p2) -- Line: 42, Name: OnBasicHit
                -- upvalues: StatusEffectScheduler (copy), Color3_fromRGB_ret (copy)
                if math.random() > 0.15 then
                    return;
                end;

                local HitTargets = p2.HitTargets;

                if not HitTargets or #HitTargets == 0 then
                    return;
                end;

                local Character = p1.Character;

                if not Character then
                    return;
                end;

                for _, v in HitTargets do
                    if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") and p1:CanApplyStatusTo(v)) then
                        local v3 = v:GetAttribute("Verdant_Stacks") or 0;
                        local v4 = p1:ResolveSkillDamage(0.15, v);

                        if v3 >= 5 then
                            StatusEffectScheduler:Apply({
                                Ticks = 5,
                                Interval = 1,
                                Prefix = "-",
                                EffectId = "Verdant",
                                StackPolicy = "refresh",
                                Target = v,
                                Attacker = Character,
                                Damage = v4,
                                Color = Color3_fromRGB_ret
                            });
                        else
                            v:SetAttribute("Verdant_Stacks", v3 + 1);
                            StatusEffectScheduler:Apply({
                                Ticks = 5,
                                Interval = 1,
                                Prefix = "-",
                                EffectId = "Verdant",
                                StackPolicy = "stack",
                                Target = v,
                                Attacker = Character,
                                Damage = v4,
                                Color = Color3_fromRGB_ret,

                                OnComplete = function() -- Line: 92, Name: OnComplete
                                    -- upvalues: v (copy)
                                    if v and v.Parent then
                                        v:SetAttribute("Verdant_Stacks", nil);
                                    end;
                                end
                            });
                        end;
                    end;
                end;
            end
        }
    }
};