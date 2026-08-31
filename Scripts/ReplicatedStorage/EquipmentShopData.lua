--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     EquipmentShopData
  Path:     game.ReplicatedStorage.GameInfo.EquipmentShopData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    RESTOCK_INTERVAL = 600,
    MAX_ITEMS = 10,
    LEVEL_OFFSET = 5,
    RarityWeights = {
        Common = 100,
        Uncommon = 60,
        Rare = 25,
        Epic = 8,
        Legendary = 2,
        Mythic = 0,
        Celestial = 0
    },
    RarityCost = {
        Common = 50,
        Uncommon = 150,
        Rare = 500,
        Epic = 4000,
        Legendary = 25000,
        Mythic = 75000,
        Celestial = 250000
    },
    LEVEL_PRICE_THRESHOLD = 30,
    LEVEL_PRICE_PER_LEVEL = 0.01,
    LEVEL_PRICE_MAX_BONUS = 0.5
};

function u1.GetRarityCost(p2: string, p3: number?) -- Line: 69
    -- upvalues: u1 (copy)
    local v4 = u1.RarityCost[p2] or 1000;
    local v5 = p3 or 1;

    if v5 <= u1.LEVEL_PRICE_THRESHOLD then
        return v4;
    end;

    local v6 = v4 * (math.min((v5 - u1.LEVEL_PRICE_THRESHOLD) * u1.LEVEL_PRICE_PER_LEVEL, u1.LEVEL_PRICE_MAX_BONUS) + 1);

    return math.floor(v6);
end;

u1.SellPrice = {
    Common = 15,
    Uncommon = 45,
    Rare = 125,
    Epic = 500,
    Legendary = 1600,
    Mythic = 5000,
    Celestial = 15000
};

function u1.GetSellPrice(p7: string) -- Line: 98
    -- upvalues: u1 (copy)
    return u1.SellPrice[p7] or 0;
end;

return u1;