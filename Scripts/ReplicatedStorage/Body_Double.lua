--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Body_Double
  Path:     game.ReplicatedStorage.Classes.Hitman.Mastery_Passives.Body_Double
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:01 2026
]]

-- Decompiled with Potassium's decompiler.

local v1 = {};
local Color3_fromRGB_ret = Color3.fromRGB(255, 200, 60);
v1.Name = "Body_Double";
v1.Trigger = "OnDodge";
v1.Cooldown = 5;
v1.Level = 30;

function v1.Execute(p2, p3) -- Line: 37
    -- upvalues: Color3_fromRGB_ret (copy)
    if not (p2.Player and p2.Character) then
        return;
    end;

    if not p2.Character:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    p2:SummonClones({
        Count = 1,
        Lifetime = 5,
        DamageRate = 0.75,
        Color = Color3_fromRGB_ret
    });
end;

return v1;