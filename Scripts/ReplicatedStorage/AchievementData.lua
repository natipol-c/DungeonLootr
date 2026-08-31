--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AchievementData
  Path:     game.ReplicatedStorage.GameInfo.AchievementData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    Categories = { {
            Key = "Combat",
            Label = "Combat"
        }, {
            Key = "Collection",
            Label = "Collection"
        }, {
            Key = "Economy",
            Label = "Economy"
        }, {
            Key = "Dungeons",
            Label = "Dungeons"
        }, {
            Key = "Milestones",
            Label = "Milestones"
        } },
    CategorySet = {}
};

for _, v in u1.Categories do
    u1.CategorySet[v.Key] = true;
end;

u1.CategoryThemes = {
    Combat = {
        GradientRotation = -90,
        StrokeColor = Color3.fromRGB(85, 0, 0),
        GradientStart = Color3.fromRGB(85, 0, 0),
        GradientEnd = Color3.fromRGB(255, 85, 127),
        AccentColor = Color3.fromRGB(255, 85, 127)
    },
    Collection = {
        GradientRotation = -90,
        StrokeColor = Color3.fromRGB(0, 60, 85),
        GradientStart = Color3.fromRGB(0, 50, 80),
        GradientEnd = Color3.fromRGB(80, 180, 255),
        AccentColor = Color3.fromRGB(80, 180, 255)
    },
    Economy = {
        GradientRotation = -90,
        StrokeColor = Color3.fromRGB(85, 70, 0),
        GradientStart = Color3.fromRGB(80, 65, 0),
        GradientEnd = Color3.fromRGB(255, 210, 50),
        AccentColor = Color3.fromRGB(255, 210, 50)
    },
    Dungeons = {
        GradientRotation = -90,
        StrokeColor = Color3.fromRGB(40, 0, 85),
        GradientStart = Color3.fromRGB(35, 0, 75),
        GradientEnd = Color3.fromRGB(160, 80, 255),
        AccentColor = Color3.fromRGB(160, 80, 255)
    },
    Milestones = {
        GradientRotation = -90,
        StrokeColor = Color3.fromRGB(0, 70, 30),
        GradientStart = Color3.fromRGB(0, 60, 25),
        GradientEnd = Color3.fromRGB(80, 220, 120),
        AccentColor = Color3.fromRGB(80, 220, 120)
    }
};
u1.StatKeys = { "TotalKills", "NPCsCollected", "DungeonClears", "BossKills", "HeroesStolen", "QuestsCompleted", "ChestsOpened", "CapturePointsWon", "EnhanceAttempts", "EnhanceSuccesses", "TimePlayed", "CashEarned", "StarsEarned", "WeaponsBought" };
u1.StatKeySet = {};

for _, v in u1.StatKeys do
    u1.StatKeySet[v] = true;
end;

u1.StatBoostCaps = {
    MaxHealth = 500,
    DamagePercent = 25,
    AttackSpeed = 15,
    DodgeCooldown = 0.5,
    ParryFrames = 3
};
u1.ChestRarityOrder = { "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Celestial" };
u1.ChestRarityIndex = {};

for i, v in u1.ChestRarityOrder do
    u1.ChestRarityIndex[v] = i;
end;

function u1.GetScaledChestRarity(p2: string, p3: number, p4: number) -- Line: 121
    -- upvalues: u1 (copy)
    local v5 = (u1.ChestRarityIndex[p2] or 1) + math.floor((p3 - 1) / p4);
    local math_min_ret = math.min(v5, #u1.ChestRarityOrder);

    return u1.ChestRarityOrder[math_min_ret];
end;

local u6 = { "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX" };

function u1.ToRoman(p7: number) -- Line: 137
    -- upvalues: u6 (copy)
    return p7 <= 0 and "" or (u6[p7] or tostring(p7));
end;

u1.Achievements = {
    {
        Id = "kill_100",
        Chain = "Slayer",
        ChainOrder = 1,
        Category = "Combat",
        Name = "Slayer",
        Description = "Defeat {target} enemies",
        Stat = "TotalKills",
        Target = 100,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Rare",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "DamagePercent",
                Amount = 5
            } }
    },
    {
        Id = "kill_500",
        Chain = "Slayer",
        ChainOrder = 2,
        Category = "Combat",
        Name = "Slayer",
        Description = "Defeat {target} enemies",
        Stat = "TotalKills",
        Target = 500,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Epic",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "DamagePercent",
                Amount = 5
            } }
    },
    {
        Id = "kill_1000",
        Chain = "Slayer",
        ChainOrder = 3,
        Category = "Combat",
        Name = "Slayer",
        Description = "Defeat {target} enemies",
        Stat = "TotalKills",
        Target = 1000,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Legendary",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "DamagePercent",
                Amount = 5
            } }
    },
    {
        Id = "kill_5000",
        Chain = "Slayer",
        ChainOrder = 4,
        Category = "Combat",
        Name = "Slayer",
        Description = "Defeat {target} enemies",
        Stat = "TotalKills",
        Target = 5000,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Mythic",
                Amount = 4
            }, {
                Type = "StatBoost",
                Stat = "DamagePercent",
                Amount = 5
            } }
    },
    {
        Id = "kill_10000",
        Chain = "Slayer",
        ChainOrder = 5,
        Category = "Combat",
        Name = "Slayer",
        Description = "Defeat {target} enemies",
        Stat = "TotalKills",
        Target = 10000,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Celestial",
                Amount = 4
            }, {
                Type = "StatBoost",
                Stat = "DamagePercent",
                Amount = 5
            } }
    },
    {
        Id = "kill_50000",
        Chain = "Slayer",
        ChainOrder = 6,
        Category = "Combat",
        Name = "Slayer",
        Description = "Defeat {target} enemies",
        Stat = "TotalKills",
        Target = 50000,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Celestial",
                Amount = 4
            }, {
                Type = "Title",
                Id = "LegendOfTheBlade"
            }, {
                Type = "Cash",
                Amount = 25000000
            } }
    },
    {
        Id = "kill_infinite",
        Chain = "Slayer",
        ChainOrder = 7,
        Category = "Combat",
        Name = "Slayer",
        Description = "Defeat {target} enemies",
        Stat = "TotalKills",
        Infinite = true,
        StartsAfter = 100000,
        Interval = 50000,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Mythic",
                Amount = 5
            } },
        RewardScale = {
            ChestUpgradeEvery = 5
        }
    },
    {
        Id = "boss_5",
        Chain = "Boss Hunter",
        ChainOrder = 1,
        Category = "Combat",
        Name = "Boss Hunter",
        Description = "Defeat {target} bosses",
        Stat = "BossKills",
        Target = 5,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Rare",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "MaxHealth",
                Amount = 20
            } }
    },
    {
        Id = "boss_10",
        Chain = "Boss Hunter",
        ChainOrder = 2,
        Category = "Combat",
        Name = "Boss Hunter",
        Description = "Defeat {target} bosses",
        Stat = "BossKills",
        Target = 10,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Epic",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "MaxHealth",
                Amount = 25
            } }
    },
    {
        Id = "boss_25",
        Chain = "Boss Hunter",
        ChainOrder = 3,
        Category = "Combat",
        Name = "Boss Hunter",
        Description = "Defeat {target} bosses",
        Stat = "BossKills",
        Target = 25,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Legendary",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "MaxHealth",
                Amount = 35
            } }
    },
    {
        Id = "boss_50",
        Chain = "Boss Hunter",
        ChainOrder = 4,
        Category = "Combat",
        Name = "Boss Hunter",
        Description = "Defeat {target} bosses",
        Stat = "BossKills",
        Target = 50,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Mythic",
                Amount = 4
            }, {
                Type = "StatBoost",
                Stat = "MaxHealth",
                Amount = 50
            } }
    },
    {
        Id = "boss_100",
        Chain = "Boss Hunter",
        ChainOrder = 5,
        Category = "Combat",
        Name = "Boss Hunter",
        Description = "Defeat {target} bosses",
        Stat = "BossKills",
        Target = 100,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Celestial",
                Amount = 4
            }, {
                Type = "Title",
                Id = "BossSlayer"
            }, {
                Type = "Cash",
                Amount = 250000
            }, {
                Type = "StatBoost",
                Stat = "MaxHealth",
                Amount = 50
            } }
    },
    {
        Id = "steal_10",
        Chain = "Thief",
        ChainOrder = 1,
        Category = "Combat",
        Name = "Thief",
        Description = "Steal {target} heroes from other players",
        Stat = "HeroesStolen",
        Target = 10,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Rare",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "AttackSpeed",
                Amount = 2
            } }
    },
    {
        Id = "steal_25",
        Chain = "Thief",
        ChainOrder = 2,
        Category = "Combat",
        Name = "Thief",
        Description = "Steal {target} heroes from other players",
        Stat = "HeroesStolen",
        Target = 25,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Epic",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "AttackSpeed",
                Amount = 2
            } }
    },
    {
        Id = "steal_50",
        Chain = "Thief",
        ChainOrder = 3,
        Category = "Combat",
        Name = "Thief",
        Description = "Steal {target} heroes from other players",
        Stat = "HeroesStolen",
        Target = 50,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Legendary",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "AttackSpeed",
                Amount = 3
            } }
    },
    {
        Id = "steal_100",
        Chain = "Thief",
        ChainOrder = 4,
        Category = "Combat",
        Name = "Thief",
        Description = "Steal {target} heroes from other players",
        Stat = "HeroesStolen",
        Target = 100,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Mythic",
                Amount = 4
            }, {
                Type = "StatBoost",
                Stat = "AttackSpeed",
                Amount = 3
            } }
    },
    {
        Id = "steal_200",
        Chain = "Thief",
        ChainOrder = 5,
        Category = "Combat",
        Name = "Thief",
        Description = "Steal {target} heroes from other players",
        Stat = "HeroesStolen",
        Target = 200,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Celestial",
                Amount = 4
            }, {
                Type = "Title",
                Id = "ShadowRaider"
            }, {
                Type = "Cash",
                Amount = 500000
            }, {
                Type = "StatBoost",
                Stat = "AttackSpeed",
                Amount = 3
            } }
    },
    {
        Id = "capture_5",
        Chain = "Zone Champion",
        ChainOrder = 1,
        Category = "Combat",
        Name = "Zone Champion",
        Description = "Win {target} capture point events",
        Stat = "CapturePointsWon",
        Target = 5,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Rare",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "ParryFrames",
                Amount = 0.5
            } }
    },
    {
        Id = "capture_10",
        Chain = "Zone Champion",
        ChainOrder = 2,
        Category = "Combat",
        Name = "Zone Champion",
        Description = "Win {target} capture point events",
        Stat = "CapturePointsWon",
        Target = 10,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Epic",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "ParryFrames",
                Amount = 0.5
            } }
    },
    {
        Id = "capture_25",
        Chain = "Zone Champion",
        ChainOrder = 3,
        Category = "Combat",
        Name = "Zone Champion",
        Description = "Win {target} capture point events",
        Stat = "CapturePointsWon",
        Target = 25,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Legendary",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "ParryFrames",
                Amount = 0.5
            } }
    },
    {
        Id = "capture_50",
        Chain = "Zone Champion",
        ChainOrder = 4,
        Category = "Combat",
        Name = "Zone Champion",
        Description = "Win {target} capture point events",
        Stat = "CapturePointsWon",
        Target = 50,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Mythic",
                Amount = 4
            }, {
                Type = "StatBoost",
                Stat = "ParryFrames",
                Amount = 0.5
            } }
    },
    {
        Id = "capture_100",
        Chain = "Zone Champion",
        ChainOrder = 5,
        Category = "Combat",
        Name = "Zone Champion",
        Description = "Win {target} capture point events",
        Stat = "CapturePointsWon",
        Target = 100,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Celestial",
                Amount = 4
            }, {
                Type = "Title",
                Id = "KingOfTheHill"
            }, {
                Type = "Cash",
                Amount = 500000
            }, {
                Type = "StatBoost",
                Stat = "ParryFrames",
                Amount = 1
            } }
    },
    {
        Id = "collect_15",
        Chain = "Collector",
        ChainOrder = 1,
        Category = "Collection",
        Name = "Collector",
        Description = "Deposit {target} heroes at your base",
        Stat = "NPCsCollected",
        Target = 15,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Rare",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "MaxHealth",
                Amount = 25
            } }
    },
    {
        Id = "collect_50",
        Chain = "Collector",
        ChainOrder = 2,
        Category = "Collection",
        Name = "Collector",
        Description = "Deposit {target} heroes at your base",
        Stat = "NPCsCollected",
        Target = 50,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Epic",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "MaxHealth",
                Amount = 25
            } }
    },
    {
        Id = "collect_250",
        Chain = "Collector",
        ChainOrder = 3,
        Category = "Collection",
        Name = "Collector",
        Description = "Deposit {target} heroes at your base",
        Stat = "NPCsCollected",
        Target = 250,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Legendary",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "MaxHealth",
                Amount = 35
            } }
    },
    {
        Id = "collect_500",
        Chain = "Collector",
        ChainOrder = 4,
        Category = "Collection",
        Name = "Collector",
        Description = "Deposit {target} heroes at your base",
        Stat = "NPCsCollected",
        Target = 500,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Mythic",
                Amount = 4
            }, {
                Type = "StatBoost",
                Stat = "MaxHealth",
                Amount = 40
            } }
    },
    {
        Id = "collect_1000",
        Chain = "Collector",
        ChainOrder = 5,
        Category = "Collection",
        Name = "Collector",
        Description = "Deposit {target} heroes at your base",
        Stat = "NPCsCollected",
        Target = 1000,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Celestial",
                Amount = 4
            }, {
                Type = "Title",
                Id = "KeeperOfLegends"
            }, {
                Type = "Cash",
                Amount = 1000000
            }, {
                Type = "StatBoost",
                Stat = "MaxHealth",
                Amount = 50
            } }
    },
    {
        Id = "collect_infinite",
        Chain = "Collector",
        ChainOrder = 6,
        Category = "Collection",
        Name = "Collector",
        Description = "Deposit {target} heroes at your base",
        Stat = "NPCsCollected",
        Infinite = true,
        StartsAfter = 2500,
        Interval = 1250,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Mythic",
                Amount = 5
            } },
        RewardScale = {
            ChestUpgradeEvery = 4
        }
    },
    {
        Id = "chest_25",
        Chain = "Chest Hunter",
        ChainOrder = 1,
        Category = "Collection",
        Name = "Chest Hunter",
        Description = "Open {target} chests",
        Stat = "ChestsOpened",
        Target = 25,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Rare",
                Amount = 3
            } }
    },
    {
        Id = "chest_50",
        Chain = "Chest Hunter",
        ChainOrder = 2,
        Category = "Collection",
        Name = "Chest Hunter",
        Description = "Open {target} chests",
        Stat = "ChestsOpened",
        Target = 50,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Epic",
                Amount = 3
            } }
    },
    {
        Id = "chest_100",
        Chain = "Chest Hunter",
        ChainOrder = 3,
        Category = "Collection",
        Name = "Chest Hunter",
        Description = "Open {target} chests",
        Stat = "ChestsOpened",
        Target = 100,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Legendary",
                Amount = 3
            } }
    },
    {
        Id = "chest_250",
        Chain = "Chest Hunter",
        ChainOrder = 4,
        Category = "Collection",
        Name = "Chest Hunter",
        Description = "Open {target} chests",
        Stat = "ChestsOpened",
        Target = 250,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Mythic",
                Amount = 4
            } }
    },
    {
        Id = "chest_500",
        Chain = "Chest Hunter",
        ChainOrder = 5,
        Category = "Collection",
        Name = "Chest Hunter",
        Description = "Open {target} chests",
        Stat = "ChestsOpened",
        Target = 500,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Celestial",
                Amount = 4
            }, {
                Type = "Title",
                Id = "LootGoblin"
            }, {
                Type = "Cash",
                Amount = 2000000
            } }
    },
    {
        Id = "cash_10000",
        Chain = "Earner",
        ChainOrder = 1,
        Category = "Economy",
        Name = "Earner",
        Description = "Earn {target} coins total",
        Stat = "CashEarned",
        Target = 10000,
        Reward = { {
                Type = "Ingot",
                Rarity = "Rare",
                Amount = 5
            } }
    },
    {
        Id = "cash_50000",
        Chain = "Earner",
        ChainOrder = 2,
        Category = "Economy",
        Name = "Earner",
        Description = "Earn {target} coins total",
        Stat = "CashEarned",
        Target = 50000,
        Reward = { {
                Type = "Ingot",
                Rarity = "Epic",
                Amount = 5
            } }
    },
    {
        Id = "cash_100000",
        Chain = "Earner",
        ChainOrder = 3,
        Category = "Economy",
        Name = "Earner",
        Description = "Earn {target} coins total",
        Stat = "CashEarned",
        Target = 100000,
        Reward = { {
                Type = "Ingot",
                Rarity = "Epic",
                Amount = 8
            } }
    },
    {
        Id = "cash_500000",
        Chain = "Earner",
        ChainOrder = 4,
        Category = "Economy",
        Name = "Earner",
        Description = "Earn {target} coins total",
        Stat = "CashEarned",
        Target = 500000,
        Reward = { {
                Type = "Ingot",
                Rarity = "Legendary",
                Amount = 5
            } }
    },
    {
        Id = "cash_1000000",
        Chain = "Earner",
        ChainOrder = 5,
        Category = "Economy",
        Name = "Earner",
        Description = "Earn {target} coins total",
        Stat = "CashEarned",
        Target = 1000000,
        Reward = { {
                Type = "Ingot",
                Rarity = "Legendary",
                Amount = 8
            } }
    },
    {
        Id = "cash_5000000",
        Chain = "Earner",
        ChainOrder = 6,
        Category = "Economy",
        Name = "Earner",
        Description = "Earn {target} coins total",
        Stat = "CashEarned",
        Target = 5000000,
        Reward = { {
                Type = "Ingot",
                Rarity = "Mythic",
                Amount = 5
            } }
    },
    {
        Id = "cash_10000000",
        Chain = "Earner",
        ChainOrder = 7,
        Category = "Economy",
        Name = "Earner",
        Description = "Earn {target} coins total",
        Stat = "CashEarned",
        Target = 10000000,
        Reward = { {
                Type = "Ingot",
                Rarity = "Mythic",
                Amount = 8
            }, {
                Type = "Title",
                Id = "Tycoon"
            }, {
                Type = "Cash",
                Amount = 1000000
            } }
    },
    {
        Id = "cash_infinite",
        Chain = "Earner",
        ChainOrder = 8,
        Category = "Economy",
        Name = "Earner",
        Description = "Earn {target} coins total",
        Stat = "CashEarned",
        Infinite = true,
        StartsAfter = 50000000,
        Interval = 25000000,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Mythic",
                Amount = 5
            } },
        RewardScale = {
            ChestUpgradeEvery = 5
        }
    },
    {
        Id = "stars_150",
        Chain = "Star Gazer",
        ChainOrder = 1,
        Category = "Economy",
        Name = "Star Gazer",
        Description = "Earn {target} stars total",
        Stat = "StarsEarned",
        Target = 150,
        Reward = { {
                Type = "ProtectionScroll",
                Amount = 1
            } }
    },
    {
        Id = "stars_750",
        Chain = "Star Gazer",
        ChainOrder = 2,
        Category = "Economy",
        Name = "Star Gazer",
        Description = "Earn {target} stars total",
        Stat = "StarsEarned",
        Target = 750,
        Reward = { {
                Type = "ProtectionScroll",
                Amount = 2
            } }
    },
    {
        Id = "stars_1500",
        Chain = "Star Gazer",
        ChainOrder = 3,
        Category = "Economy",
        Name = "Star Gazer",
        Description = "Earn {target} stars total",
        Stat = "StarsEarned",
        Target = 1500,
        Reward = { {
                Type = "ProtectionScroll",
                Amount = 3
            } }
    },
    {
        Id = "stars_7500",
        Chain = "Star Gazer",
        ChainOrder = 4,
        Category = "Economy",
        Name = "Star Gazer",
        Description = "Earn {target} stars total",
        Stat = "StarsEarned",
        Target = 7500,
        Reward = { {
                Type = "ProtectionScroll",
                Amount = 4
            } }
    },
    {
        Id = "stars_15000",
        Chain = "Star Gazer",
        ChainOrder = 5,
        Category = "Economy",
        Name = "Star Gazer",
        Description = "Earn {target} stars total",
        Stat = "StarsEarned",
        Target = 15000,
        Reward = { {
                Type = "ProtectionScroll",
                Amount = 5
            }, {
                Type = "GoldenHammer",
                Amount = 1
            }, {
                Type = "Title",
                Id = "Constellation"
            } }
    },
    {
        Id = "enhance_50",
        Chain = "Blacksmith",
        ChainOrder = 1,
        Category = "Economy",
        Name = "Blacksmith",
        Description = "Attempt {target} weapon enhancements",
        Stat = "EnhanceAttempts",
        Target = 50,
        Reward = { {
                Type = "Ingot",
                Rarity = "Epic",
                Amount = 5
            } }
    },
    {
        Id = "enhance_100",
        Chain = "Blacksmith",
        ChainOrder = 2,
        Category = "Economy",
        Name = "Blacksmith",
        Description = "Attempt {target} weapon enhancements",
        Stat = "EnhanceAttempts",
        Target = 100,
        Reward = { {
                Type = "Ingot",
                Rarity = "Epic",
                Amount = 7
            } }
    },
    {
        Id = "enhance_200",
        Chain = "Blacksmith",
        ChainOrder = 3,
        Category = "Economy",
        Name = "Blacksmith",
        Description = "Attempt {target} weapon enhancements",
        Stat = "EnhanceAttempts",
        Target = 200,
        Reward = { {
                Type = "Ingot",
                Rarity = "Epic",
                Amount = 10
            }, {
                Type = "ProtectionScroll",
                Amount = 2
            } }
    },
    {
        Id = "enhance_500",
        Chain = "Blacksmith",
        ChainOrder = 4,
        Category = "Economy",
        Name = "Blacksmith",
        Description = "Attempt {target} weapon enhancements",
        Stat = "EnhanceAttempts",
        Target = 500,
        Reward = { {
                Type = "Ingot",
                Rarity = "Legendary",
                Amount = 5
            }, {
                Type = "ProtectionScroll",
                Amount = 3
            } }
    },
    {
        Id = "enhance_1000",
        Chain = "Blacksmith",
        ChainOrder = 5,
        Category = "Economy",
        Name = "Blacksmith",
        Description = "Attempt {target} weapon enhancements",
        Stat = "EnhanceAttempts",
        Target = 1000,
        Reward = { {
                Type = "Ingot",
                Rarity = "Legendary",
                Amount = 10
            }, {
                Type = "ProtectionScroll",
                Amount = 5
            }, {
                Type = "Title",
                Id = "MasterBlacksmith"
            } }
    },
    {
        Id = "enhancesuc_25",
        Chain = "Lucky Hammer",
        ChainOrder = 1,
        Category = "Economy",
        Name = "Lucky Hammer",
        Description = "Successfully enhance weapons {target} times",
        Stat = "EnhanceSuccesses",
        Target = 25,
        Reward = { {
                Type = "ProtectionScroll",
                Amount = 2
            } }
    },
    {
        Id = "enhancesuc_50",
        Chain = "Lucky Hammer",
        ChainOrder = 2,
        Category = "Economy",
        Name = "Lucky Hammer",
        Description = "Successfully enhance weapons {target} times",
        Stat = "EnhanceSuccesses",
        Target = 50,
        Reward = { {
                Type = "ProtectionScroll",
                Amount = 3
            } }
    },
    {
        Id = "enhancesuc_100",
        Chain = "Lucky Hammer",
        ChainOrder = 3,
        Category = "Economy",
        Name = "Lucky Hammer",
        Description = "Successfully enhance weapons {target} times",
        Stat = "EnhanceSuccesses",
        Target = 100,
        Reward = { {
                Type = "ProtectionScroll",
                Amount = 5
            }, {
                Type = "GoldenHammer",
                Amount = 1
            } }
    },
    {
        Id = "enhancesuc_250",
        Chain = "Lucky Hammer",
        ChainOrder = 4,
        Category = "Economy",
        Name = "Lucky Hammer",
        Description = "Successfully enhance weapons {target} times",
        Stat = "EnhanceSuccesses",
        Target = 250,
        Reward = { {
                Type = "ProtectionScroll",
                Amount = 7
            }, {
                Type = "GoldenHammer",
                Amount = 1
            }, {
                Type = "Title",
                Id = "GoldenTouch"
            } }
    },
    {
        Id = "dungeon_5",
        Chain = "Dungeon Runner",
        ChainOrder = 1,
        Category = "Dungeons",
        Name = "Dungeon Runner",
        Description = "Complete {target} dungeon runs",
        Stat = "DungeonClears",
        Target = 5,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Rare",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "DodgeCooldown",
                Amount = 0.1
            } }
    },
    {
        Id = "dungeon_25",
        Chain = "Dungeon Runner",
        ChainOrder = 2,
        Category = "Dungeons",
        Name = "Dungeon Runner",
        Description = "Complete {target} dungeon runs",
        Stat = "DungeonClears",
        Target = 25,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Epic",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "DodgeCooldown",
                Amount = 0.1
            } }
    },
    {
        Id = "dungeon_50",
        Chain = "Dungeon Runner",
        ChainOrder = 3,
        Category = "Dungeons",
        Name = "Dungeon Runner",
        Description = "Complete {target} dungeon runs",
        Stat = "DungeonClears",
        Target = 50,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Legendary",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "DodgeCooldown",
                Amount = 0.1
            } }
    },
    {
        Id = "dungeon_100",
        Chain = "Dungeon Runner",
        ChainOrder = 4,
        Category = "Dungeons",
        Name = "Dungeon Runner",
        Description = "Complete {target} dungeon runs",
        Stat = "DungeonClears",
        Target = 100,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Mythic",
                Amount = 4
            }, {
                Type = "StatBoost",
                Stat = "DodgeCooldown",
                Amount = 0.1
            } }
    },
    {
        Id = "dungeon_250",
        Chain = "Dungeon Runner",
        ChainOrder = 5,
        Category = "Dungeons",
        Name = "Dungeon Runner",
        Description = "Complete {target} dungeon runs",
        Stat = "DungeonClears",
        Target = 250,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Celestial",
                Amount = 4
            }, {
                Type = "Title",
                Id = "AbyssWalker"
            }, {
                Type = "Cash",
                Amount = 1000000
            }, {
                Type = "StatBoost",
                Stat = "DodgeCooldown",
                Amount = 0.1
            } }
    },
    {
        Id = "dungeon_infinite",
        Chain = "Dungeon Runner",
        ChainOrder = 6,
        Category = "Dungeons",
        Name = "Dungeon Runner",
        Description = "Complete {target} dungeon runs",
        Stat = "DungeonClears",
        Infinite = true,
        StartsAfter = 500,
        Interval = 250,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Mythic",
                Amount = 5
            } },
        RewardScale = {
            ChestUpgradeEvery = 4
        }
    },
    {
        Id = "quest_10",
        Chain = "Questmaster",
        ChainOrder = 1,
        Category = "Dungeons",
        Name = "Questmaster",
        Description = "Complete {target} quests",
        Stat = "QuestsCompleted",
        Target = 10,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Rare",
                Amount = 3
            } }
    },
    {
        Id = "quest_25",
        Chain = "Questmaster",
        ChainOrder = 2,
        Category = "Dungeons",
        Name = "Questmaster",
        Description = "Complete {target} quests",
        Stat = "QuestsCompleted",
        Target = 25,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Epic",
                Amount = 3
            } }
    },
    {
        Id = "quest_50",
        Chain = "Questmaster",
        ChainOrder = 3,
        Category = "Dungeons",
        Name = "Questmaster",
        Description = "Complete {target} quests",
        Stat = "QuestsCompleted",
        Target = 50,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Legendary",
                Amount = 3
            } }
    },
    {
        Id = "quest_100",
        Chain = "Questmaster",
        ChainOrder = 4,
        Category = "Dungeons",
        Name = "Questmaster",
        Description = "Complete {target} quests",
        Stat = "QuestsCompleted",
        Target = 100,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Mythic",
                Amount = 4
            } }
    },
    {
        Id = "quest_200",
        Chain = "Questmaster",
        ChainOrder = 5,
        Category = "Dungeons",
        Name = "Questmaster",
        Description = "Complete {target} quests",
        Stat = "QuestsCompleted",
        Target = 200,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Celestial",
                Amount = 4
            }, {
                Type = "Title",
                Id = "LegendaryAdventurer"
            }, {
                Type = "Cash",
                Amount = 2000000
            } }
    },
    {
        Id = "time_3600",
        Chain = "Dedicated",
        ChainOrder = 1,
        Category = "Milestones",
        Name = "Dedicated",
        Description = "Play for {target} seconds",
        Stat = "TimePlayed",
        Target = 3600,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Rare",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "MaxHealth",
                Amount = 25
            } }
    },
    {
        Id = "time_10800",
        Chain = "Dedicated",
        ChainOrder = 2,
        Category = "Milestones",
        Name = "Dedicated",
        Description = "Play for {target} seconds",
        Stat = "TimePlayed",
        Target = 10800,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Epic",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "MaxHealth",
                Amount = 25
            } }
    },
    {
        Id = "time_36000",
        Chain = "Dedicated",
        ChainOrder = 3,
        Category = "Milestones",
        Name = "Dedicated",
        Description = "Play for {target} seconds",
        Stat = "TimePlayed",
        Target = 36000,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Legendary",
                Amount = 3
            }, {
                Type = "StatBoost",
                Stat = "MaxHealth",
                Amount = 35
            } }
    },
    {
        Id = "time_108000",
        Chain = "Dedicated",
        ChainOrder = 4,
        Category = "Milestones",
        Name = "Dedicated",
        Description = "Play for {target} seconds",
        Stat = "TimePlayed",
        Target = 108000,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Mythic",
                Amount = 4
            }, {
                Type = "StatBoost",
                Stat = "MaxHealth",
                Amount = 50
            } }
    },
    {
        Id = "time_360000",
        Chain = "Dedicated",
        ChainOrder = 5,
        Category = "Milestones",
        Name = "Dedicated",
        Description = "Play for {target} seconds",
        Stat = "TimePlayed",
        Target = 360000,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Celestial",
                Amount = 4
            }, {
                Type = "Title",
                Id = "NoLife"
            }, {
                Type = "Cash",
                Amount = 10000000
            }, {
                Type = "StatBoost",
                Stat = "MaxHealth",
                Amount = 75
            }, {
                Type = "StatBoost",
                Stat = "DamagePercent",
                Amount = 5
            } }
    },
    {
        Id = "time_infinite",
        Chain = "Dedicated",
        ChainOrder = 6,
        Category = "Milestones",
        Name = "Dedicated",
        Description = "Play for {target} seconds",
        Stat = "TimePlayed",
        Infinite = true,
        StartsAfter = 360000,
        Interval = 180000,
        Reward = { {
                Type = "RarityChest",
                Rarity = "Mythic",
                Amount = 5
            } },
        RewardScale = {
            ChestUpgradeEvery = 5
        }
    }
};
u1.AchievementById = {};
u1.AchievementsByStat = {};
u1.AchievementsByCategory = {};
u1.AchievementsByChain = {};

for _, v in u1.Achievements do
    local v8 = not u1.AchievementById[v.Id];
    local v9 = `Duplicate achievement ID: {v.Id}`;
    assert(v8, v9);
    u1.AchievementById[v.Id] = v;

    if not u1.AchievementsByStat[v.Stat] then
        u1.AchievementsByStat[v.Stat] = {};
    end;

    table.insert(u1.AchievementsByStat[v.Stat], v);

    if not u1.AchievementsByCategory[v.Category] then
        u1.AchievementsByCategory[v.Category] = {};
    end;

    table.insert(u1.AchievementsByCategory[v.Category], v);

    if v.Chain then
        if not u1.AchievementsByChain[v.Chain] then
            u1.AchievementsByChain[v.Chain] = {};
        end;

        table.insert(u1.AchievementsByChain[v.Chain], v);
    end;
end;

for _, v in u1.AchievementsByChain do
    table.sort(v, function(p10, p11) -- Line: 946
        return (p10.ChainOrder or 0) < (p11.ChainOrder or 0);
    end);
end;

u1.ChainOrder = {};
local v12 = {};

for _, v in u1.Achievements do
    if v.Chain and not v12[v.Chain] then
        v12[v.Chain] = true;
        table.insert(u1.ChainOrder, v.Chain);
    end;
end;

function u1.GetById(p13: string) -- Line: 965
    -- upvalues: u1 (copy)
    return u1.AchievementById[p13];
end;

function u1.GetByStat(p14: string) -- Line: 969
    -- upvalues: u1 (copy)
    return u1.AchievementsByStat[p14] or {};
end;

function u1.GetByCategory(p15: string) -- Line: 973
    -- upvalues: u1 (copy)
    return u1.AchievementsByCategory[p15] or {};
end;

function u1.GetChain(p16: string) -- Line: 977
    -- upvalues: u1 (copy)
    return u1.AchievementsByChain[p16] or {};
end;

function u1.IsInfinite(p17) -- Line: 981
    return p17.Infinite == true;
end;

function u1.GetMaxInfiniteTier(p18: any, p19: number) -- Line: 985
    return not p18.Infinite and 0 or (p19 < p18.StartsAfter and 0 or math.floor((p19 - p18.StartsAfter) / p18.Interval));
end;

function u1.GetInfiniteTierTarget(p20: any, p21: number) -- Line: 991
    if p20.Infinite then
        return p20.StartsAfter + p21 * p20.Interval;
    end;

    return p20.Target;
end;

function u1.GetCurrentChainStep(p22: string, p23: any, p24: any, p25: any) -- Line: 1001
    -- upvalues: u1 (copy)
    local v26 = u1.AchievementsByChain[p22];

    if not v26 or #v26 == 0 then
        return nil;
    end;

    local v27 = p23[v26[1].Stat] or 0;

    for _, v in v26 do
        if not (v.Infinite or p24[v.Id]) then
            if v.Target <= v27 then
                return v, "claimable", nil;
            end;

            return v, "locked", nil;
        end;
    end;

    for _, v in v26 do
        if v.Infinite then
            local MaxInfiniteTier = u1.GetMaxInfiniteTier(v, v27);
            local v28 = p25[v.Id] or 0;

            if v28 < MaxInfiniteTier then
                return v, "claimable", v28 + 1;
            end;

            return v, "locked", v28 + 1;
        end;
    end;

    return v26[#v26], "completed", nil;
end;

function u1.FormatDescription(p29: any, p30: number?) -- Line: 1042
    -- upvalues: u1 (copy)
    local v31;

    if p29.Infinite and p30 then
        v31 = u1.GetInfiniteTierTarget(p29, p30);
    else
        v31 = p29.Target;
    end;

    return string.gsub(p29.Description, "{target}", u1.FormatNumber(v31));
end;

function u1.FormatName(p32: any, p33: number?) -- Line: 1055
    -- upvalues: u1 (copy)
    if not p32.Chain then
        return p32.Name;
    end;

    if not p32.Infinite then
        return p32.Chain .. " " .. u1.ToRoman(p32.ChainOrder);
    end;

    local v34 = 0;

    for _, v in u1.GetChain(p32.Chain) do
        if not v.Infinite then
            v34 = v34 + 1;
        end;
    end;

    return p32.Chain .. " " .. u1.ToRoman(v34 + (p33 or 1));
end;

function u1.GetInfiniteReward(p35: any, p36: number) -- Line: 1075
    -- upvalues: u1 (copy)
    if not p35.Infinite then
        return p35.Reward;
    end;

    local RewardScale = p35.RewardScale;

    if not (RewardScale and RewardScale.ChestUpgradeEvery) then
        return p35.Reward;
    end;

    local v37 = {};

    for _, v in p35.Reward do
        local v38 = {};

        for i, v2 in v do
            v38[i] = v2;
        end;

        if v38.Type == "RarityChest" and v38.Rarity then
            v38.Rarity = u1.GetScaledChestRarity(v38.Rarity, p36, RewardScale.ChestUpgradeEvery);
        end;

        table.insert(v37, v38);
    end;

    return v37;
end;

local u39 = {
    TotalKills = "Kill NPCs",
    NPCsCollected = "Deposit Heroes",
    DungeonClears = "Complete Dungeons",
    BossKills = "Defeat Bosses",
    HeroesStolen = "Steal Heroes",
    QuestsCompleted = "Complete Quests",
    ChestsOpened = "Open Chests",
    CapturePointsWon = "Win Capture Points",
    EnhanceAttempts = "Enhance Weapons",
    EnhanceSuccesses = "Successful Enhances",
    TimePlayed = "Online For",
    CashEarned = "Earn Coins",
    StarsEarned = "Earn Stars"
};

function u1.GetTaskLabel(p40) -- Line: 1115
    -- upvalues: u39 (copy)
    return u39[p40.Stat] or p40.Stat;
end;

function u1.FormatNumber(p41: number) -- Line: 1119
    local math_floor_ret = math.floor(p41);
    local v42 = tostring(math_floor_ret);
    local v43;

    repeat
        v42, v43 = string.gsub(v42, "^(-?%d+)(%d%d%d)", "%1,%2");
    until v43 == 0;

    return v42;
end;

function u1.FormatTime(p44: number) -- Line: 1129
    local math_floor_ret = math.floor(p44);

    if math_floor_ret >= 3600 then
        return `{math.floor(math_floor_ret / 3600)}h {math.floor(math_floor_ret % 3600 / 60)}m`;
    end;

    return `{math.floor(math_floor_ret / 60)}m {math_floor_ret % 60}s`;
end;

function u1.FormatProgress(p45: any, p46: number, p47: number?) -- Line: 1138
    -- upvalues: u1 (copy)
    local v48;

    if p45.Infinite and p47 then
        v48 = u1.GetInfiniteTierTarget(p45, p47);
    else
        v48 = p45.Target;
    end;

    if p45.Stat == "TimePlayed" then
        return u1.FormatTime(p46) .. " / " .. u1.FormatTime(v48);
    end;

    return u1.FormatNumber(p46) .. " / " .. u1.FormatNumber(v48);
end;

function u1.FormatReward(p49) -- Line: 1152
    -- upvalues: u1 (copy)
    local Type = p49.Type;

    if Type == "Cash" then
        return "+" .. u1.FormatNumber(p49.Amount) .. " Coins";
    end;

    if Type == "Stars" then
        return "+" .. u1.FormatNumber(p49.Amount) .. " Stars";
    end;

    if Type == "Title" then
        return "Title: " .. (p49.Id or "???");
    end;

    if Type == "Weapon" then
        return "Weapon: " .. (p49.Id or "???");
    end;

    if Type == "RarityChest" then
        local v50 = p49.Amount or 1;

        return "+" .. v50 .. " " .. (p49.Rarity or "") .. " Chest" .. (v50 > 1 and "s" or "");
    end;

    if Type == "Ingot" then
        local v51 = p49.Amount or 1;

        return "+" .. v51 .. " " .. (p49.Rarity or "") .. " Ingot" .. (v51 > 1 and "s" or "");
    end;

    if Type == "ProtectionScroll" then
        local v52 = p49.Amount or 1;

        return "+" .. v52 .. " Scroll" .. (v52 > 1 and "s" or "");
    end;

    if Type == "GoldenHammer" then
        local v53 = p49.Amount or 1;

        return "+" .. v53 .. " Golden Hammer" .. (v53 > 1 and "s" or "");
    end;

    if Type ~= "StatBoost" then
        return p49.Type or "???";
    end;

    local v54 = p49.Stat or "";
    local v55 = p49.Amount or 0;

    if v54 == "DamagePercent" then
        return "+" .. v55 .. "% Damage";
    end;

    if v54 == "AttackSpeed" then
        return "+" .. v55 .. "% Attack Speed";
    end;

    if v54 == "MaxHealth" then
        return "+" .. v55 .. " Max HP";
    end;

    if v54 == "DodgeCooldown" then
        return "-" .. v55 .. "s Dodge CD";
    end;

    if v54 == "ParryFrames" then
        return "+" .. v55 .. " Parry Frames";
    end;

    return "+" .. v55 .. " " .. v54;
end;

function u1.FormatAllRewards(p56: any, p57: number?) -- Line: 1188
    -- upvalues: u1 (copy)
    local v58;

    if p56.Infinite and (p57 and p57 > 0) then
        v58 = u1.GetInfiniteReward(p56, p57);
    else
        v58 = p56.Reward;
    end;

    local v59 = {};

    for _, v in v58 do
        table.insert(v59, u1.FormatReward(v));
    end;

    return table.concat(v59, " · ");
end;

function u1.GetTheme(p60) -- Line: 1203
    -- upvalues: u1 (copy)
    return u1.CategoryThemes[p60.Category] or u1.CategoryThemes.Combat;
end;

return u1;