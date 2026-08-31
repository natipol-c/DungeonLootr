--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Phantom_Strikes
  Path:     game.ReplicatedStorage.Classes.Azure Devil.Mastery_Passives.Phantom_Strikes
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:50 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PhantomAttack = require(ReplicatedStorage.Modules.PhantomAttack);
local v1 = {};
local Color3_fromRGB_ret = Color3.fromRGB(0, 200, 255);
v1.Name = "Phantom_Strikes";
v1.Trigger = "OnBasicHit";
v1.Cooldown = 0;
v1.Level = 13;

function v1.Execute(p2, p3) -- Line: 36
    -- upvalues: PhantomAttack (copy), Color3_fromRGB_ret (copy)
    if (p2.Player:GetAttribute("Hit_Count") or 0) < 100 then
        return;
    end;

    if math.random() > 0.35 then
        return;
    end;

    local v4 = p3.TurnCount or 1;
    PhantomAttack.Fire(p2, {
        DamageMultiplier = 1.1,
        FadeDuration = 0.8,
        PauseAtEnd = 0.3,
        Color = Color3_fromRGB_ret,
        AnimationName = "Attack_" .. v4,
        FXNames = { (p2.ClassData.FX_Order or {})[v4] or "Right_Slash" },
        SwingSoundFolder = p2.ClassData.SwingSoundFolder,
        AttackSpeed = p2:GetEffectiveStat("AttackSpeed") or 1
    });
end;

return v1;