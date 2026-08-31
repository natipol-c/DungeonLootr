--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Mutations.Glaciel.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:07 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Glaciel",
    Procs = {
        {
            Name = "Glaciel_Frost",
            Trigger = "OnBasicHit",
            Cooldown = 0,

            Execute = function(p1, p2) -- Line: 33, Name: OnBasicHit
                local HitTargets = p2.HitTargets;

                if not HitTargets or #HitTargets == 0 then
                    return;
                end;

                for _, v in HitTargets do
                    if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") and p1:CanApplyStatusTo(v)) then
                        local EnemyNPC = p1:GetEnemyNPC(v);

                        if EnemyNPC then
                            if EnemyNPC:IsFrozen() then
                                if os.clock() >= (p1._glacielBurstCDUntil or 0) and math.random() < 0.1 then
                                    p1._glacielBurstCDUntil = os.clock() + 10;
                                    p1:ApplyDamage(v, (p1:ResolveSkillDamage(2, v)));
                                    EnemyNPC:Unfreeze();
                                end;
                            elseif not EnemyNPC.IsBoss and math.random() < 0.025 then
                                EnemyNPC:ApplyFreeze(4);
                            end;
                        end;
                    end;
                end;
            end
        }
    }
};