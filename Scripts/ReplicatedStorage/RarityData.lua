--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     RarityData
  Path:     game.ReplicatedStorage.GameInfo.RarityData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local v1 = {
    RarityOrder = { "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Celestial", "Impossible", "Exotic", "ERROR", "Admin", "Owner" },
    RarityIndex = {}
};

for i, v in v1.RarityOrder do
    v1.RarityIndex[v] = i;
end;

v1.GearRarityTabs = { "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Celestial", "Exotic" };
v1.RarityWeights = {
    Common = 0.04,
    Uncommon = 0.02857142857142857,
    Rare = 0.014285714285714285,
    Epic = 0.004,
    Legendary = 0.0003333333333333333,
    Mythic = 0.00005,
    Celestial = 0.000011111111111111112
};
v1.RarityLuckWeights = {
    Common = 1,
    Uncommon = 1.5,
    Rare = 1.85,
    Epic = 2,
    Legendary = 3.25,
    Mythic = 3.5,
    Celestial = 3.75
};
v1.BaseIncome = {
    Common = 10,
    Uncommon = 25,
    Rare = 60,
    Epic = 150,
    Legendary = 300,
    Mythic = 600,
    Celestial = 1200,
    Exotic = 2000
};
v1.BasePrice = {
    Common = 500,
    Uncommon = 2000,
    Rare = 8000,
    Epic = 50000,
    Legendary = 350000,
    Mythic = 1750000,
    Celestial = 10000000,
    Exotic = 25000000
};
v1.UnlockChances = {
    Common = 0.0125,
    Uncommon = 0.0125,
    Rare = 0.016666666666666666,
    Epic = 0.022222222222222223,
    Legendary = 0.04,
    Mythic = 0.05,
    Celestial = 0.06666666666666667
};

return v1;