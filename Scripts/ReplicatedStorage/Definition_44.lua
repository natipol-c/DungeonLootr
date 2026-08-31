--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Mutations.Umbral.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:07 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Umbral",
    Procs = {
        {
            Name = "Umbral_Burst",
            Trigger = "OnCrit",
            Cooldown = 0,

            Execute = function(p1, p2) -- Line: 40, Name: OnCrit
                if os.clock() < (p1._umbralCDUntil or 0) then
                    return;
                end;

                local Target = p2.Target;

                if not Target then
                    return;
                end;

                if Target:HasTag("Ignore_Damage") then
                    return;
                end;

                if Target:GetAttribute("Dead") and not Target:GetAttribute("Can_Finish") then
                    return;
                end;

                if not p1:CanApplyStatusTo(Target) then
                    return;
                end;

                if math.random() > 0.35 then
                    return;
                end;

                local v3 = Target:FindFirstChild("HumanoidRootPart") or Target.PrimaryPart;

                if not v3 then
                    return;
                end;

                p1._umbralCDUntil = os.clock() + 3;
                p1:PlayAspectBurst("Umbral_Explode", v3, "Red_Fast");

                for _, v in p1:FindEnemiesNearPosition(v3.Position, 15) do
                    if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
                        p1:ApplyDamage(v, (p1:ResolveSkillDamage(1.5, v)));
                        local EnemyNPC = p1:GetEnemyNPC(v);

                        if EnemyNPC and not EnemyNPC.IsBoss then
                            EnemyNPC:ApplyStun(1.5);
                        end;
                    end;
                end;
            end
        }
    }
};