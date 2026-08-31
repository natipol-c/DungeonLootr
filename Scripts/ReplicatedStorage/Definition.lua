--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.GameInfo.Consumables.AspectGem.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local MutationData = require(ReplicatedStorage.GameInfo.MutationData);

return {
    Id = "AspectGem",

    OnConsume = function(p1: userdata, p2: any) -- Line: 27, Name: OnConsume
        -- upvalues: MutationData (copy), Knit (copy)
        local v3 = MutationData.RollGuaranteedClassWeaponAspect();
        local v4, v5 = Knit.GetService("ClassWeaponService"):SetActiveAspect(p1, v3);

        if v4 then
            return true, v3, {
                ClassName = v5
            };
        end;

        return false, tostring(v5);
    end
};