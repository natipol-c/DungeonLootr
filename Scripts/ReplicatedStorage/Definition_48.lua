--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Mutations.Ruin.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:07 2026
]]

-- Decompiled with Potassium's decompiler.

local function firstValidTarget(p1, p2) -- Line: 42
    for _, v in p2 do
        if v and (v.Parent and (not v:GetAttribute("Dead") and p1:CanApplyStatusTo(v))) then
            return v;
        end;
    end;

    return nil;
end;

return {
    Name = "Ruin",
    Procs = {
        {
            Name = "Ruin_Sunder",
            Trigger = "OnBasicHit",
            Cooldown = 0,

            Execute = function(p3, p4) -- Line: 51, Name: OnBasicHit
                -- upvalues: firstValidTarget (copy)
                local HitTargets = p4.HitTargets;

                if not HitTargets or #HitTargets == 0 then
                    return;
                end;

                local _ruinTarget = p3._ruinTarget;
                local v5 = false;

                if _ruinTarget and (_ruinTarget.Parent and not _ruinTarget:GetAttribute("Dead")) then
                    for _, v in HitTargets do
                        if v == _ruinTarget then
                            v5 = true;
                            break;
                        end;
                    end;
                end;

                if v5 then
                    p3._ruinStacks = math.min((p3._ruinStacks or 0) + 1, 30);
                else
                    if _ruinTarget and _ruinTarget.Parent then
                        _ruinTarget:SetAttribute("Ruin_Stacks", nil);
                    end;

                    local v6 = firstValidTarget(p3, HitTargets);

                    if not v6 then
                        p3._ruinTarget = nil;
                        p3._ruinStacks = 0;

                        return;
                    end;

                    p3._ruinTarget = v6;
                    p3._ruinStacks = 1;
                end;

                if p3._ruinTarget and p3._ruinTarget.Parent then
                    p3._ruinTarget:SetAttribute("Ruin_Stacks", p3._ruinStacks);
                end;
            end
        }
    },

    ModifyOutgoingDamage = function(p7: any, p8: any, p9: number) -- Line: 108, Name: ModifyOutgoingDamage
        if not p8 or p9 <= 0 then
            return nil;
        end;

        if p8 ~= p7._ruinTarget then
            return nil;
        end;

        local v10 = p7._ruinStacks or 0;

        if v10 <= 0 then
            return nil;
        end;

        return p9 * (math.min(v10 * 0.025, 0.75) + 1);
    end
};