--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Relentless
  Path:     game.ReplicatedStorage.Classes.Mori.Mastery_Passives.Relentless
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:00 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Relentless",
    Trigger = "OnSkillUse",
    Cooldown = 0,
    Level = 30,

    Execute = function(u1, u2) -- Line: 39, Name: Execute
        if u2 then
            u2 = u2.Slot;
        end;

        if type(u2) ~= "number" then
            return;
        end;

        if math.random() >= 0.2 then
            return;
        end;

        task.delay(0.05, function() -- Line: 44
            -- upvalues: u1 (copy), u2 (copy)
            if not u1.Player then
                return;
            end;

            local v3 = u1.Skill_Charges and u1.Skill_Charges[u2];

            if v3 then
                if v3.current < v3.max then
                    v3.current = v3.current + 1;
                    local v4 = "Skill" .. tostring(u2);
                    u1.Player:SetAttribute(v4 .. "_Charges", v3.current);

                    if u1.Player:GetAttribute(v4 .. "_OnCooldown") then
                        u1.Player:SetAttribute(v4 .. "_OnCooldown", false);
                    end;
                end;
            else
                u1:RefreshSkillCooldown(u2);
            end;
        end);
    end
};