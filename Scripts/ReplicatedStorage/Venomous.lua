--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Venomous
  Path:     game.ReplicatedStorage.Weapons.Weapon_Traits.Trait_Effects.Venomous
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:07 2026
]]

-- Decompiled with Potassium's decompiler.

require(game.ReplicatedStorage.Modules.SharedUtils);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StatusEffectScheduler = require(ReplicatedStorage.Modules.StatusEffectScheduler);
local v1 = {
    Init = function() -- Line: 8, Name: Init
        return {};
    end,

    Hooks = {}
};

function v1.Hooks.OnHit(p2, p3, p4, p5) -- Line: 14
    -- upvalues: StatusEffectScheduler (copy)
    StatusEffectScheduler:Apply({
        Ticks = 5,
        Interval = 1,
        EffectId = "Venomous",
        StackPolicy = "refresh",
        Target = p4,
        Attacker = p3.Player.Character,
        Damage = math.floor(p5 * 0.15),
        Color = Color3.fromRGB(80, 200, 50)
    });
end;

return v1;