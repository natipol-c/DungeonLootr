--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     LootChestData
  Path:     game.ReplicatedStorage.GameInfo.LootChestData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local Image_Data = require(script.Parent:WaitForChild("Image_Data"));
local u1 = { "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Celestial" };
local u2 = {};
local u3 = {};

for i, v in u1 do
    u2[v] = i;
end;

function u3.GetNextRarity(p4: string) -- Line: 37
    -- upvalues: u2 (copy), u1 (copy)
    local v5 = u2[p4];

    if v5 then
        return u1[v5 + 1];
    end;

    return nil;
end;

u3.Chests = {
    CommonLootChest = {
        Name = "Common Loot Chest",
        Rarity = "Common",
        Contents = { {
                Id = "Cash_500",
                Type = "Cash",
                Amount = 500,
                Chance = 50,
                DisplayName = "500 CASH"
            }, {
                Id = "Cash_1K",
                Type = "Cash",
                Amount = 1000,
                Chance = 25,
                DisplayName = "1,000 CASH"
            }, {
                Id = "Stone_Common",
                Type = "UpgradeStone",
                StoneRarity = "Common",
                Chance = 30,
                DisplayName = "COMMON STONES",
                Amount = { 2, 5 }
            }, {
                Id = "Stone_Uncommon",
                Type = "UpgradeStone",
                StoneRarity = "Uncommon",
                Chance = 8,
                DisplayName = "UNCOMMON STONES",
                Amount = { 1, 2 }
            }, {
                Id = "Scroll_1",
                Type = "ProtectionScroll",
                Amount = 1,
                Chance = 0.5,
                DisplayName = "PROTECTION SCROLL"
            }, {
                Id = "Weapon_Common",
                Type = "RarityWeapon",
                WeaponRarity = "Common",
                Chance = 2,
                DisplayName = "COMMON WEAPON",
                FallbackStones = 5
            } }
    },
    UncommonLootChest = {
        Name = "Uncommon Loot Chest",
        Rarity = "Uncommon",
        Contents = { {
                Id = "Cash_2K",
                Type = "Cash",
                Amount = 2000,
                Chance = 45,
                DisplayName = "2,000 CASH"
            }, {
                Id = "Cash_5K",
                Type = "Cash",
                Amount = 5000,
                Chance = 20,
                DisplayName = "5,000 CASH"
            }, {
                Id = "Stars_10",
                Type = "Stars",
                Amount = 10,
                Chance = 15,
                DisplayName = "10 STARS"
            }, {
                Id = "Stone_Uncommon",
                Type = "UpgradeStone",
                StoneRarity = "Uncommon",
                Chance = 28,
                DisplayName = "UNCOMMON STONES",
                Amount = { 2, 5 }
            }, {
                Id = "Stone_Rare",
                Type = "UpgradeStone",
                StoneRarity = "Rare",
                Chance = 7,
                DisplayName = "RARE STONES",
                Amount = { 1, 2 }
            }, {
                Id = "Scroll_1",
                Type = "ProtectionScroll",
                Amount = 1,
                Chance = 0.5,
                DisplayName = "PROTECTION SCROLL"
            }, {
                Id = "Weapon_Uncommon",
                Type = "RarityWeapon",
                WeaponRarity = "Uncommon",
                Chance = 2,
                DisplayName = "UNCOMMON WEAPON",
                FallbackStones = 5
            } }
    },
    RareLootChest = {
        Name = "Rare Loot Chest",
        Rarity = "Rare",
        Contents = { {
                Id = "Cash_5K",
                Type = "Cash",
                Amount = 5000,
                Chance = 20,
                DisplayName = "5,000 CASH"
            }, {
                Id = "Cash_15K",
                Type = "Cash",
                Amount = 15000,
                Chance = 8,
                DisplayName = "15,000 CASH"
            }, {
                Id = "Stars_25",
                Type = "Stars",
                Amount = 25,
                Chance = 5,
                DisplayName = "25 STARS"
            }, {
                Id = "Stone_Rare",
                Type = "UpgradeStone",
                StoneRarity = "Rare",
                Chance = 30,
                DisplayName = "RARE STONES",
                Amount = { 2, 5 }
            }, {
                Id = "Stone_Epic",
                Type = "UpgradeStone",
                StoneRarity = "Epic",
                Chance = 8,
                DisplayName = "EPIC STONES",
                Amount = { 1, 2 }
            }, {
                Id = "Scroll_1",
                Type = "ProtectionScroll",
                Amount = 1,
                Chance = 1,
                DisplayName = "PROTECTION SCROLL"
            }, {
                Id = "Weapon_Rare",
                Type = "RarityWeapon",
                WeaponRarity = "Rare",
                Chance = 12,
                DisplayName = "RARE WEAPON",
                FallbackStones = 5
            } }
    },
    EpicLootChest = {
        Name = "Epic Loot Chest",
        Rarity = "Epic",
        Contents = { {
                Id = "Stone_Epic",
                Type = "UpgradeStone",
                StoneRarity = "Epic",
                Chance = 35,
                DisplayName = "EPIC STONES",
                Amount = { 3, 6 }
            }, {
                Id = "Stone_Legendary",
                Type = "UpgradeStone",
                StoneRarity = "Legendary",
                Chance = 10,
                DisplayName = "LEGENDARY STONES",
                Amount = { 1, 3 }
            }, {
                Id = "Scroll_1",
                Type = "ProtectionScroll",
                Amount = 1,
                Chance = 5,
                DisplayName = "PROTECTION SCROLL"
            }, {
                Id = "Weapon_Epic",
                Type = "RarityWeapon",
                WeaponRarity = "Epic",
                Chance = 50,
                DisplayName = "EPIC WEAPON",
                FallbackStones = 5
            } }
    },
    LegendaryLootChest = {
        Name = "Legendary Loot Chest",
        Rarity = "Legendary",
        Contents = { {
                Id = "Stone_Legendary",
                Type = "UpgradeStone",
                StoneRarity = "Legendary",
                Chance = 30,
                DisplayName = "LEGENDARY STONES",
                Amount = { 3, 6 }
            }, {
                Id = "Stone_Mythic",
                Type = "UpgradeStone",
                StoneRarity = "Mythic",
                Chance = 8,
                DisplayName = "MYTHIC STONES",
                Amount = { 1, 3 }
            }, {
                Id = "Scroll_1",
                Type = "ProtectionScroll",
                Amount = 1,
                Chance = 7,
                DisplayName = "PROTECTION SCROLL"
            }, {
                Id = "Weapon_Legendary",
                Type = "RarityWeapon",
                WeaponRarity = "Legendary",
                Chance = 55,
                DisplayName = "LEGENDARY WEAPON",
                FallbackStones = 5
            } }
    },
    MythicLootChest = {
        Name = "Mythic Loot Chest",
        Rarity = "Mythic",
        Contents = { {
                Id = "Stone_Mythic",
                Type = "UpgradeStone",
                StoneRarity = "Mythic",
                Chance = 28,
                DisplayName = "MYTHIC STONES",
                Amount = { 3, 6 }
            }, {
                Id = "Stone_Celestial",
                Type = "UpgradeStone",
                StoneRarity = "Celestial",
                Chance = 7,
                DisplayName = "CELESTIAL STONES",
                Amount = { 1, 3 }
            }, {
                Id = "Scroll_1",
                Type = "ProtectionScroll",
                Amount = 1,
                Chance = 5,
                DisplayName = "PROTECTION SCROLL"
            }, {
                Id = "Weapon_Mythic",
                Type = "RarityWeapon",
                WeaponRarity = "Mythic",
                Chance = 60,
                DisplayName = "MYTHIC WEAPON",
                FallbackStones = 5
            } }
    },
    CelestialLootChest = {
        Name = "Celestial Loot Chest",
        Rarity = "Celestial",
        Contents = { {
                Id = "Stone_Celestial",
                Type = "UpgradeStone",
                StoneRarity = "Celestial",
                Chance = 25,
                DisplayName = "CELESTIAL STONES",
                Amount = { 3, 6 }
            }, {
                Id = "Scroll_1",
                Type = "ProtectionScroll",
                Amount = 1,
                Chance = 10,
                DisplayName = "PROTECTION SCROLL"
            }, {
                Id = "Weapon_Celestial",
                Type = "RarityWeapon",
                WeaponRarity = "Celestial",
                Chance = 65,
                DisplayName = "CELESTIAL WEAPON",
                FallbackStones = 5
            } }
    }
};
u3.CHEST_TIMEOUT = 60;
u3.REVEAL_DISPLAY_TIME = 4;
u3.AnticipationDurations = {
    Common = 1,
    Uncommon = 1.2,
    Rare = 1.5,
    Epic = 2,
    Legendary = 2.5,
    Mythic = 3,
    Celestial = 3.5
};
u3.RewardToTier = {
    Cash = "Common",
    Stars = "Uncommon",
    UpgradeStone = "Uncommon",
    ProtectionScroll = "Rare",
    RarityWeapon = "Legendary"
};
u3.RarityColors = {
    Common = Color3.fromRGB(180, 180, 180),
    Uncommon = Color3.fromRGB(80, 200, 80),
    Rare = Color3.fromRGB(60, 120, 255),
    Epic = Color3.fromRGB(180, 60, 255),
    Legendary = Color3.fromRGB(255, 180, 0),
    Mythic = Color3.fromRGB(255, 60, 60),
    Celestial = Color3.fromRGB(255, 100, 220)
};
u3.ELITE_CHEST_CHANCE = 0.25;
u3.RARITY_TO_MODEL = {
    Common = "Common_Chest",
    Uncommon = "Uncommon_Chest",
    Rare = "Rare_Chest",
    Epic = "Epic_Chest",
    Legendary = "Legendary_Chest",
    Mythic = "Mythic_Chest",
    Celestial = "Celestial_Chest"
};
u3.RARITY_TO_CHEST_ID = {
    Common = "CommonLootChest",
    Uncommon = "UncommonLootChest",
    Rare = "RareLootChest",
    Epic = "EpicLootChest",
    Legendary = "LegendaryLootChest",
    Mythic = "MythicLootChest",
    Celestial = "CelestialLootChest"
};
u3.HighlightConfig = {
    FillTransparency = 0.8,
    OutlineTransparency = 0.6,
    StartColor = Color3.fromRGB(60, 60, 60),
    PeakColor = Color3.fromRGB(255, 255, 255)
};
u3.RewardIcons = {
    RarityWeapon = "",
    Cash = Image_Data.Rewards.Cash,
    Stars = Image_Data.Rewards.Stars,
    UpgradeStone = Image_Data.UpgradeStones.Common,
    ProtectionScroll = Image_Data.Rewards.ProtectionScroll
};
u3.UpgradeStoneImages = Image_Data.UpgradeStones;

function u3.GetChest(p6: string) -- Line: 391
    -- upvalues: u3 (copy)
    return u3.Chests[p6];
end;

function u3.GetChestForRarity(p7: string) -- Line: 395
    -- upvalues: u3 (copy)
    local v8 = u3.RARITY_TO_CHEST_ID[p7];
    local v9;

    if v8 then
        v9 = u3.Chests[v8];
    else
        v9 = v8;
    end;

    return v9, v8;
end;

function u3.GetWeightedContents(p10: string) -- Line: 400
    -- upvalues: u3 (copy)
    local v11 = u3.Chests[p10];

    if not v11 then
        return nil;
    end;

    local v12 = {};

    for _, v in ipairs(v11.Contents) do
        v12[v.Id] = v.Chance;
    end;

    return v12;
end;

function u3.GetItemFromChest(p13: string, p14: string) -- Line: 411
    -- upvalues: u3 (copy)
    local v15 = u3.Chests[p13];

    if not v15 then
        return nil;
    end;

    for _, v in ipairs(v15.Contents) do
        if v.Id == p14 then
            return v;
        end;
    end;

    return nil;
end;

return u3;