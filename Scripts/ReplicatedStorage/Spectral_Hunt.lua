--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Spectral_Hunt
  Path:     game.ReplicatedStorage.Classes.Artemis.Mastery_Passives.Spectral_Hunt
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:56 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = {};
local Color3_fromRGB_ret = Color3.fromRGB(120, 220, 160);
v1.Name = "Spectral_Hunt";
v1.Trigger = "OnSkillUse";
v1.Cooldown = 0;
v1.Level = 13;
local u2 = nil;

local function GetMoonfallModule() -- Line: 38
    -- upvalues: u2 (ref), ReplicatedStorage (copy)
    if u2 then
        return u2;
    end;

    local Artemis = ReplicatedStorage.Classes:FindFirstChild("Artemis");

    if Artemis then
        Artemis = Artemis:FindFirstChild("Skills");
    end;

    if Artemis then
        Artemis = Artemis:FindFirstChild("Moonfall");
    end;

    if not Artemis then
        return nil;
    end;

    local success, result = pcall(require, Artemis);

    if success then
        u2 = result;
    end;

    return u2;
end;

function v1.Execute(p3, p4) -- Line: 51
    -- upvalues: GetMoonfallModule (copy), Color3_fromRGB_ret (copy)
    if not p4 or p4.SkillModule ~= GetMoonfallModule() then
        return;
    end;

    p3:SummonClones({
        Count = 1,
        Lifetime = 15,
        DamageRate = 0.5,
        Color = Color3_fromRGB_ret
    });
end;

return v1;