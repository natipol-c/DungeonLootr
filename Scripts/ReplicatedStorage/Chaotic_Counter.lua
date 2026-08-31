--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Chaotic_Counter
  Path:     game.ReplicatedStorage.Classes.Chaotic Fist.Mastery_Passives.Chaotic_Counter
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:58 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return {
    Name = "Chaotic_Counter",
    Trigger = "OnParry",
    Cooldown = 0,
    Level = 13,

    Execute = function(p1, p2) -- Line: 21, Name: Execute
        -- upvalues: ReplicatedStorage (copy)
        if p1.Is_Using_Skill then
            return;
        end;

        local v3 = ReplicatedStorage.Classes:FindFirstChild(p1.ClassName);

        if not v3 then
            return;
        end;

        local Skills = v3:FindFirstChild("Skills");

        if not Skills then
            return;
        end;

        local v4 = Skills:FindFirstChild("Annihilation Type");

        if not v4 then
            return;
        end;

        require(v4).Activate(p1, 2);
    end
};