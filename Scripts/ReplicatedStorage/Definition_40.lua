--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Mutations.Fulmin.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:06 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Fulmin",
    Procs = {
        {
            Name = "Fulmin_Strike",
            Trigger = "OnBasicHit",
            Cooldown = 0,

            Execute = function(p1, p2) -- Line: 33, Name: OnBasicHit
                if os.clock() < (p1._fulminCDUntil or 0) then
                    return;
                end;

                if math.random() > 0.1 then
                    return;
                end;

                local HitTargets = p2.HitTargets;

                if not HitTargets or #HitTargets == 0 then
                    return;
                end;

                local v3 = nil;
                local v4 = nil;

                for _, v in HitTargets do
                    if not (v:HasTag("Ignore_Damage") or v:GetAttribute("Dead")) then
                        local v5 = v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart;

                        if v5 then
                            v3 = v5.Position;
                            v4 = v5;
                            break;
                        end;
                    end;
                end;

                if not v3 then
                    return;
                end;

                p1._fulminCDUntil = os.clock() + 15;
                p1:PlayAspectBurst("Fulmin_Explode", v4, "lightningcrash");

                for _, v in p1:FindEnemiesNearPosition(v3, 20) do
                    if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
                        p1:ApplyDamage(v, (p1:ResolveSkillDamage(4, v)));
                        local EnemyNPC = p1:GetEnemyNPC(v);

                        if EnemyNPC and not EnemyNPC.IsBoss then
                            EnemyNPC:ApplyStun(7);
                        end;
                    end;
                end;
            end
        }
    }
};