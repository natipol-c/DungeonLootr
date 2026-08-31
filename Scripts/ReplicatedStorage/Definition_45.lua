--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Mutations.Aegis.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:07 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Aegis",
    Procs = {
        {
            Name = "Aegis_Nova",
            Trigger = "OnParry",
            Cooldown = 0,

            Execute = function(u1, p2) -- Line: 39, Name: OnParry
                local Character = u1.Character;

                if Character then
                    Character = Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart;
                end;

                if not Character then
                    return;
                end;

                u1:PlayAspectBurst("Aegis_Explode", Character, "Aegis_Explode");

                for _, v in u1:FindEnemiesNearPosition(Character.Position, 18) do
                    if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
                        u1:ApplyDamage(v, (u1:ResolveSkillDamage(2.5, v)));
                        local EnemyNPC = u1:GetEnemyNPC(v);

                        if EnemyNPC and not EnemyNPC.IsBoss then
                            EnemyNPC:ApplyStun(3);
                        end;
                    end;
                end;

                u1._aegisBuffUntil = os.clock() + 5;

                if not u1._aegisBuffActive then
                    local v3 = u1:GetEffectiveStat("DamageMultiplier") * 0.25;
                    u1._aegisBuffActive = true;
                    u1._aegisBuffDelta = v3;
                    u1:ModifyStat("DamageMultiplier", v3);
                    task.spawn(function() -- Line: 70
                        -- upvalues: u1 (copy)
                        while os.clock() < (u1._aegisBuffUntil or 0) do
                            task.wait(0.25);

                            if not u1._aegisBuffActive then
                                return;
                            end;
                        end;

                        u1:ModifyStat("DamageMultiplier", -(u1._aegisBuffDelta or 0));
                        u1._aegisBuffActive = false;
                    end);
                end;
            end
        }
    }
};