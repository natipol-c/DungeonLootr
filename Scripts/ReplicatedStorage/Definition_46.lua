--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Mutations.Tempest.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:07 2026
]]

-- Decompiled with Potassium's decompiler.

local function fireLightningStorm(p1: any, p2: number) -- Line: 48
    local Character = p1.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart;
    end;

    if not Character then
        return;
    end;

    p1:PlayAspectBurst("Fulmin_Explode", Character, "Fulmin_Explode");

    for _, v in p1:FindEnemiesNearPosition(Character.Position, 22) do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) and p1:CanApplyStatusTo(v) then
            p1:ApplyDamage(v, p1:ResolveSkillDamage(2, v) * (p2 or 1));
            local EnemyNPC = p1:GetEnemyNPC(v);

            if EnemyNPC and not EnemyNPC.IsBoss then
                EnemyNPC:ApplyStun(1);
            end;
        end;
    end;
end;

return {
    Name = "Tempest",
    Procs = {
        {
            Name = "Tempest_Storm",
            Trigger = "OnSkillUse",
            Cooldown = 0,

            Execute = function(p3, p4) -- Line: 74, Name: OnSkillUse
                -- upvalues: fireLightningStorm (copy)
                local v5 = p3._tempestStacks or 0;

                if v5 < 8 then
                    local v6 = v5 + 1;
                    p3._tempestStacks = v6;
                    p3._aspectSkillDamageMult = 1 + v6 * 0.05;

                    return;
                end;

                local v7 = p3._aspectSkillDamageMult or 1;
                p3._tempestStacks = 0;
                p3._aspectSkillDamageMult = 1;
                fireLightningStorm(p3, v7);
            end
        }
    }
};