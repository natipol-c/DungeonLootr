--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Mutations.Blaze.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:06 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StatusEffectScheduler = require(ReplicatedStorage.Modules.StatusEffectScheduler);
local Color3_fromRGB_ret = Color3.fromRGB(255, 110, 40);

local function AttachBurnVFX(p1: userdata) -- Line: 39
    -- upvalues: ReplicatedStorage (copy)
    local v2 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Effects");

    if v2 then
        v2 = v2:FindFirstChild("Burning");
    end;

    if not v2 then
        return nil;
    end;

    local v3 = p1:FindFirstChild("Torso") or (p1:FindFirstChild("UpperTorso") or p1:FindFirstChild("HumanoidRootPart"));

    if not v3 then
        return nil;
    end;

    local v4 = v2:Clone();
    v4.Name = "BlazeEffect";
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = v3;
    WeldConstraint.Part1 = v4;
    WeldConstraint.Parent = v4;
    v4.CFrame = v3.CFrame;
    v4.Parent = v3.Parent;

    return v4;
end;

return {
    Name = "Blaze",
    Procs = {
        {
            Name = "Blaze_Ignite",
            Trigger = "OnBasicHit",
            Cooldown = 0,

            Execute = function(p5, p6) -- Line: 64, Name: OnBasicHit
                -- upvalues: AttachBurnVFX (copy), StatusEffectScheduler (copy), Color3_fromRGB_ret (copy)
                if math.random() > 0.1 then
                    return;
                end;

                local HitTargets = p6.HitTargets;

                if not HitTargets or #HitTargets == 0 then
                    return;
                end;

                local Character = p5.Character;

                if not Character then
                    return;
                end;

                for _, v in HitTargets do
                    if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") and p5:CanApplyStatusTo(v)) then
                        local Attribute = v:GetAttribute("Blaze_Until");

                        if not Attribute or os.clock() >= Attribute then
                            v:SetAttribute("Blaze_Until", os.clock() + 10);
                            local u7 = AttachBurnVFX(v);
                            StatusEffectScheduler:Apply({
                                Ticks = 10,
                                Interval = 1,
                                Prefix = "-",
                                EffectId = "Blaze",
                                Target = v,
                                Attacker = Character,
                                Damage = p5:ResolveSkillDamage(0.7, v),
                                Color = Color3_fromRGB_ret,

                                OnComplete = function() -- Line: 101, Name: OnComplete
                                    -- upvalues: v (copy), u7 (copy)
                                    if v and v.Parent then
                                        v:SetAttribute("Blaze_Until", nil);
                                    end;

                                    if u7 and u7.Parent then
                                        u7:Destroy();
                                    end;
                                end
                            });
                        end;
                    end;
                end;
            end
        }
    },

    ModifyOutgoingDamage = function(p8: any, p9: any, p10: number) -- Line: 130, Name: ModifyOutgoingDamage
        if not p9 then
            return nil;
        end;

        local Attribute = p9:GetAttribute("Blaze_Until");

        if Attribute and os.clock() < Attribute then
            return p10 * 1.25;
        end;

        return nil;
    end
};