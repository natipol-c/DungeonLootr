--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AddPotionServer
  Path:     game.ReplicatedStorage.ExternalModules.Cmdr.Server commands.AddPotionServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local PotionData = require(ReplicatedStorage.GameInfo.PotionData);

return function(p1, p2, p3, p4) -- Line: 5
    -- upvalues: PotionData (copy), Knit (copy)
    local v5 = p4 or 1;
    local Potion = PotionData.GetPotion(p3);

    if Potion then
        Knit.GetService("PotionService"):AddPotions(p2, p3, v5);

        return string.format("Gave %d %s to %s", v5, Potion.Name, p2.Name);
    end;

    local v6 = {};

    for _, v in ipairs(PotionData.Potions) do
        table.insert(v6, v.Id);
    end;

    return "Invalid potion ID: " .. p3 .. "\nValid IDs: " .. table.concat(v6, ", ");
end;