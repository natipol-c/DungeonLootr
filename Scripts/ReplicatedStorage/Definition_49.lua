--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Mutations.Alacrity.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:07 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Alacrity",
    Procs = {
        {
            Name = "Alacrity_Haste",
            Trigger = "OnBasicHit",
            Cooldown = 0,

            Execute = function(u1, p2) -- Line: 46, Name: OnBasicHit
                if u1._alacrityBuffActive then
                    return;
                end;

                if os.clock() < (u1._alacrityCDUntil or 0) then
                    return;
                end;

                if math.random() > 0.2 then
                    return;
                end;

                local v3 = u1:GetEffectiveStat("AttackSpeed") * 0.6;

                if v3 <= 0 then
                    return;
                end;

                u1._alacrityBuffActive = true;
                u1._alacrityBuffDelta = v3;
                u1:ModifyStat("AttackSpeed", v3);
                task.delay(10, function() -- Line: 65
                    -- upvalues: u1 (copy)
                    if not u1._alacrityBuffActive then
                        return;
                    end;

                    u1:ModifyStat("AttackSpeed", -(u1._alacrityBuffDelta or 0));
                    u1._alacrityBuffActive = false;
                    u1._alacrityBuffDelta = nil;
                    u1._alacrityCDUntil = os.clock() + 7;
                end);
            end
        }
    }
};