--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AccessConfig
  Path:     game.ReplicatedStorage.GameInfo.AccessConfig
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    EARLY_ACCESS_AFK = false,
    ELIGIBILITY_PLAYTIME_HOURS = 24,
    ROLE_LOOKUP_FAIL_MODE = "open",
    EAPLUS_ENTRY_NORMAL_SPINS = 25,
    EAPLUS_ENTRY_LUCKY_SPINS = 15,
    CURRENCY_DRIP = {
        Coins = {
            IntervalSeconds = 300,
            Amount = 200,
            Field = "Currency"
        },
        Stars = {
            IntervalSeconds = 600,
            Amount = 50,
            Field = "Stars"
        }
    },
    CHEST_PACKAGE_PREFIX = "RarityChest_",
    CHEST_DRIP = {
        IntervalSeconds = 1200,
        MythicPity = 10,
        CelestialPity = 30,
        Weights = { {
                Rarity = "Common",
                Weight = 40
            }, {
                Rarity = "Uncommon",
                Weight = 25
            }, {
                Rarity = "Rare",
                Weight = 15
            }, {
                Rarity = "Epic",
                Weight = 10
            }, {
                Rarity = "Legendary",
                Weight = 6
            }, {
                Rarity = "Mythic",
                Weight = 3
            }, {
                Rarity = "Celestial",
                Weight = 1
            } }
    },
    AFK_LOOT_DUNGEONS = { "Bandits Den", "Goblins", "Knights", "Catacombs", "Snow", "Demon" },
    TRACKS = {
        EarlyAccess = {
            {
                Key = "EA_1h",
                Hours = 1,
                Type = "NormalSpins",
                Amount = 10
            },
            {
                Key = "EA_2h",
                Hours = 2,
                Type = "Currency",
                Amount = 5000
            },
            {
                Key = "EA_3h",
                Hours = 3,
                Type = "LuckySpins",
                Amount = 3
            },
            {
                Key = "EA_4h",
                Hours = 4,
                Type = "Stars",
                Amount = 150
            },
            {
                Key = "EA_6h",
                Hours = 6,
                Type = "NormalSpins",
                Amount = 20
            },
            {
                Key = "EA_8h",
                Hours = 8,
                Type = "Currency",
                Amount = 15000
            },
            {
                Key = "EA_10h",
                Hours = 10,
                Type = "LuckySpins",
                Amount = 6
            },
            {
                Key = "EA_12h",
                Hours = 12,
                Type = "Stars",
                Amount = 350
            },
            {
                Key = "EA_14h",
                Hours = 14,
                Type = "Consumable",
                Amount = 1,
                Id = "AspectGem"
            },
            {
                Key = "EA_16h",
                Hours = 16,
                Type = "NormalSpins",
                Amount = 40
            },
            {
                Key = "EA_18h",
                Hours = 18,
                Type = "Currency",
                Amount = 50000
            },
            {
                Key = "EA_20h",
                Hours = 20,
                Type = "LuckySpins",
                Amount = 12
            },
            {
                Key = "EA_21h",
                Hours = 21,
                Type = "Stars",
                Amount = 750
            },
            {
                Key = "EA_22h",
                Hours = 22,
                Type = "Consumable",
                Amount = 2,
                Id = "AspectGem"
            },
            {
                Key = "EA_24h",
                Hours = 24,
                Type = "EarlyAccess",
                Amount = 1
            }
        },
        Standard = {}
    }
};

function u1.GetActiveTrack() -- Line: 143
    -- upvalues: u1 (copy)
    return u1.EARLY_ACCESS_AFK and u1.TRACKS.EarlyAccess or u1.TRACKS.Standard;
end;

function u1.GetAllRewards() -- Line: 152
    -- upvalues: u1 (copy)
    local v2 = {};

    for _, v in u1.TRACKS do
        for _, v3 in v do
            table.insert(v2, v3);
        end;
    end;

    return v2;
end;

return u1;