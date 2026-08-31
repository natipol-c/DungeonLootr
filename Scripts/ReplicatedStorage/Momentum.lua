--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Momentum
  Path:     game.ReplicatedStorage.Weapons.Weapon_Traits.Trait_Effects.Momentum
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:07 2026
]]

-- Decompiled with Potassium's decompiler.

local SharedUtils = require(game.ReplicatedStorage.Modules.SharedUtils);
local v1 = {
    Init = function() -- Line: 22, Name: Init
        return {
            Stacks = 0,
            HitThisSwing = false
        };
    end,

    Hooks = {}
};

function v1.Hooks.OnHit(p2, p3, p4, p5) -- Line: 31
    -- upvalues: SharedUtils (copy)
    p2.Stacks = math.min(p2.Stacks + 1, 15);
    p2.HitThisSwing = true;
    p3._TraitDamageMult = (p3._TraitDamageMult or 1) + p2.Stacks * 0.04;

    if p2.Stacks % 5 == 0 then
        local v6 = p3.Character and p3.Character:FindFirstChild("HumanoidRootPart");

        if v6 then
            SharedUtils.ShowText(v6, "Momentum x" .. p2.Stacks, Color3.fromRGB(255, 180, 50));
        end;
    end;
end;

function v1.Hooks.OnSwingEnd(p7, p8) -- Line: 51
    if not p7.HitThisSwing then
        p7.Stacks = 0;
    end;

    p7.HitThisSwing = false;
end;

function v1.Hooks.OnDodge(p9, p10, p11) -- Line: 59
    p9.Stacks = 0;
end;

return v1;