--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Executioner
  Path:     game.ReplicatedStorage.Weapons.Weapon_Traits.Trait_Effects.Executioner
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:07 2026
]]

-- Decompiled with Potassium's decompiler.

local v1 = {
    Init = function() -- Line: 15, Name: Init
        return {};
    end,

    Hooks = {}
};

function v1.Hooks.OnHit(p2, p3, p4, p5) -- Line: 21
    if p4 then
        p4 = p4:FindFirstChild("Humanoid");
    end;

    if not p4 or p4.Health <= 0 then
        return;
    end;

    if p4.Health / p4.MaxHealth <= 0.25 then
        p3._TraitDamageMult = (p3._TraitDamageMult or 1) + 0.5;
    end;
end;

return v1;