--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BattlepassData
  Path:     game.ReplicatedStorage.GameInfo.BattlepassData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    CURRENT_SEASON = 3,
    SEASON_NAME = "Season 3: Trials of the Forge",
    MAX_TIER = 100,
    XP_PER_TIER = 1000,
    BP_KILL_XP = 2,
    BP_ELITE_KILL_XP = 5,
    BP_BOSS_KILL_XP = 30,
    BP_DUNGEON_CLEAR_XP = 70,
    BP_DIFFICULTY_MULT = {
        Easy = 1,
        Normal = 1.1,
        Hard = 1.15,
        Nightmare = 1.2,
        Endless = 1.25
    },
    DAILY_QUEST_COUNT = 13,
    QUEST_REFRESH_INTERVAL = 57600,
    QuestDifficulty = {
        Easy = {
            Order = 1,
            Gradient = "RestlessPlayer",
            SlotCount = 4
        },
        Normal = {
            Order = 2,
            Gradient = "Epic",
            SlotCount = 5
        },
        Hard = {
            Order = 3,
            Gradient = "Mythic",
            SlotCount = 2
        },
        Extreme = {
            Order = 4,
            Gradient = "Admin",
            SlotCount = 2
        }
    },
    DAILY_LOGIN_QUEST_ID = "bp_daily_login",
    RewardType = {
        Coins = "Coins",
        Stars = "Stars",
        NormalSpins = "NormalSpins",
        LuckySpins = "LuckySpins",
        ClassEXPPotion = "ClassEXPPotion",
        Equipment = "Equipment",
        Cosmetic = "Cosmetic",
        Title = "Title",
        ClassItem = "ClassItem",
        Package = "Package",
        CraftingMaterial = "CraftingMaterial",
        Emote = "Emote",
        BuffPotion = "BuffPotion"
    },
    Tiers = {
        [1] = {
            Free = {
                Type = "CraftingMaterial",
                Id = "Common Ingot",
                Amount = 10
            },
            Premium = {
                Type = "Package",
                Id = "BetaPack"
            }
        },
        [2] = {
            Free = {
                Type = "NormalSpins",
                Amount = 10
            },
            Premium = {
                Type = "NormalSpins",
                Amount = 15
            }
        },
        [3] = {
            Free = {
                Type = "CraftingMaterial",
                Id = "Common Ingot",
                Amount = 10
            },
            Premium = {
                Type = "CraftingMaterial",
                Id = "Uncommon Ingot",
                Amount = 10
            }
        },
        [6] = {
            Free = {
                Type = "Coins",
                Amount = 10000
            },
            Premium = {
                Type = "Coins",
                Amount = 10000
            }
        },
        [7] = {
            Free = {
                Type = "Package",
                Id = "MaterialBundle_Tier1",
                Amount = 10
            },
            Premium = {
                Type = "Package",
                Id = "MaterialBundle_Tier2",
                Amount = 15
            }
        },
        [9] = {
            Free = {
                Type = "NormalSpins",
                Amount = 10
            },
            Premium = {
                Type = "NormalSpins",
                Amount = 15
            }
        },
        [10] = {
            Free = {
                Type = "LuckySpins",
                Amount = 5
            },
            Premium = {
                Type = "LuckySpins",
                Amount = 5
            }
        },
        [12] = {
            Free = {
                Type = "CraftingMaterial",
                Id = "Uncommon Ingot",
                Amount = 10
            },
            Premium = {
                Type = "CraftingMaterial",
                Id = "Rare Ingot",
                Amount = 10
            }
        },
        [13] = {
            Free = {
                Type = "BuffPotion",
                Id = "LuckPotionT1",
                Amount = 3
            },
            Premium = {
                Type = "LuckySpins",
                Amount = 5
            }
        },
        [16] = {
            Free = {
                Type = "CraftingMaterial",
                Id = "Rare Ingot",
                Amount = 10
            },
            Premium = {
                Type = "CraftingMaterial",
                Id = "Rare Ingot",
                Amount = 10
            }
        },
        [17] = {
            Free = {
                Type = "NormalSpins",
                Amount = 10
            },
            Premium = {
                Type = "NormalSpins",
                Amount = 15
            }
        },
        [18] = {
            Free = {
                Type = "CraftingMaterial",
                Id = "Rare Ingot",
                Amount = 10
            },
            Premium = {
                Type = "Package",
                Id = "MaterialBundle_Tier1",
                Amount = 25
            }
        },
        [19] = {
            Free = {
                Type = "Package",
                Id = "RareGearPack"
            },
            Premium = {
                Type = "Package",
                Id = "EpicGearPack"
            }
        },
        [20] = {
            Free = {
                Type = "BuffPotion",
                Id = "LuckPotionT1",
                Amount = 3
            },
            Premium = {
                Type = "LuckySpins",
                Amount = 5
            }
        },
        [21] = {
            Free = {
                Type = "Coins",
                Amount = 10000
            },
            Premium = {
                Type = "Coins",
                Amount = 10000
            }
        },
        [22] = {
            Free = {
                Type = "CraftingMaterial",
                Id = "Epic Ingot",
                Amount = 10
            },
            Premium = {
                Type = "Package",
                Id = "MaterialBundle_Tier1",
                Amount = 25
            }
        },
        [24] = {
            Free = {
                Type = "CraftingMaterial",
                Id = "Epic Ingot",
                Amount = 10
            },
            Premium = {
                Type = "CraftingMaterial",
                Id = "Epic Ingot",
                Amount = 10
            }
        },
        [25] = {
            Free = {
                Type = "Emote",
                Id = "WarmUp"
            },
            Premium = {
                Type = "Package",
                Id = "ForgeArchonAura"
            }
        },
        [27] = {
            Free = {
                Type = "NormalSpins",
                Amount = 10
            },
            Premium = {
                Type = "NormalSpins",
                Amount = 15
            }
        },
        [28] = {
            Free = {
                Type = "Package",
                Id = "MaterialBundle_Tier2",
                Amount = 25
            },
            Premium = {
                Type = "CraftingMaterial",
                Id = "Epic Ingot",
                Amount = 10
            }
        },
        [29] = {
            Free = {
                Type = "Package",
                Id = "EpicGearPack"
            },
            Premium = {
                Type = "Coins",
                Amount = 15000
            }
        },
        [30] = {
            Free = {
                Type = "Title",
                Id = "S3Artisan"
            },
            Premium = {
                Type = "Title",
                Id = "S3Warsmith"
            }
        },
        [33] = {
            Free = {
                Type = "CraftingMaterial",
                Id = "Legendary Ingot",
                Amount = 10
            },
            Premium = {
                Type = "Package",
                Id = "MaterialBundle_Tier2",
                Amount = 25
            }
        },
        [34] = {
            Free = {
                Type = "LuckySpins",
                Amount = 5
            },
            Premium = {
                Type = "BuffPotion",
                Id = "LuckPotionT1",
                Amount = 4
            }
        },
        [37] = {
            Free = {
                Type = "Package",
                Id = "MaterialBundle_Tier2",
                Amount = 25
            },
            Premium = {
                Type = "CraftingMaterial",
                Id = "Legendary Ingot",
                Amount = 10
            }
        },
        [38] = {
            Free = {
                Type = "NormalSpins",
                Amount = 10
            },
            Premium = {
                Type = "NormalSpins",
                Amount = 15
            }
        },
        [40] = {
            Free = {
                Type = "LuckySpins",
                Amount = 5
            },
            Premium = {
                Type = "LuckySpins",
                Amount = 5
            }
        },
        [42] = {
            Free = {
                Type = "CraftingMaterial",
                Id = "Legendary Ingot",
                Amount = 10
            },
            Premium = {
                Type = "Package",
                Id = "MaterialBundle_Tier2",
                Amount = 25
            }
        },
        [43] = {
            Free = {
                Type = "BuffPotion",
                Id = "LuckPotionT2",
                Amount = 2
            },
            Premium = {
                Type = "LuckySpins",
                Amount = 5
            }
        },
        [44] = {
            Free = {
                Type = "Package",
                Id = "MaterialBundle_Tier2",
                Amount = 25
            },
            Premium = {
                Type = "CraftingMaterial",
                Id = "Legendary Ingot",
                Amount = 10
            }
        },
        [47] = {
            Free = {
                Type = "CraftingMaterial",
                Id = "Mythic Ingot",
                Amount = 10
            },
            Premium = {
                Type = "Package",
                Id = "MaterialBundle_Tier2",
                Amount = 25
            }
        },
        [49] = {
            Free = {
                Type = "NormalSpins",
                Amount = 10
            },
            Premium = {
                Type = "NormalSpins",
                Amount = 15
            }
        },
        [50] = {
            Free = {
                Type = "ClassItem",
                Id = "Great Mage Staff"
            },
            Premium = {
                Type = "Package",
                Id = "ForgeArchonPack"
            }
        },
        [53] = {
            Free = {
                Type = "Package",
                Id = "ForgeStonePackage"
            },
            Premium = {
                Type = "CraftingMaterial",
                Id = "Mythic Ingot",
                Amount = 10
            }
        },
        [54] = {
            Free = {
                Type = "LuckySpins",
                Amount = 5
            },
            Premium = {
                Type = "BuffPotion",
                Id = "LuckPotionT2",
                Amount = 3
            }
        },
        [57] = {
            Free = {
                Type = "CraftingMaterial",
                Id = "Mythic Ingot",
                Amount = 10
            },
            Premium = {
                Type = "Package",
                Id = "ReforgeStonePackage"
            }
        },
        [59] = {
            Free = {
                Type = "NormalSpins",
                Amount = 10
            },
            Premium = {
                Type = "NormalSpins",
                Amount = 15
            }
        },
        [60] = {
            Free = {
                Type = "LuckySpins",
                Amount = 5
            },
            Premium = {
                Type = "LuckySpins",
                Amount = 5
            }
        },
        [62] = {
            Free = {
                Type = "Package",
                Id = "MaterialBundle_Tier3",
                Amount = 25
            },
            Premium = {
                Type = "CraftingMaterial",
                Id = "Mythic Ingot",
                Amount = 10
            }
        },
        [63] = {
            Free = {
                Type = "BuffPotion",
                Id = "LuckPotionT1",
                Amount = 5
            },
            Premium = {
                Type = "LuckySpins",
                Amount = 5
            }
        },
        [66] = {
            Free = {
                Type = "CraftingMaterial",
                Id = "Celestial Ingot",
                Amount = 10
            },
            Premium = {
                Type = "Package",
                Id = "LegendaryGearPack"
            }
        },
        [68] = {
            Free = {
                Type = "Package",
                Id = "ForgeStonePackage"
            },
            Premium = {
                Type = "CraftingMaterial",
                Id = "Celestial Ingot",
                Amount = 10
            }
        },
        [71] = {
            Free = {
                Type = "NormalSpins",
                Amount = 10
            },
            Premium = {
                Type = "NormalSpins",
                Amount = 15
            }
        },
        [72] = {
            Free = {
                Type = "CraftingMaterial",
                Id = "Celestial Ingot",
                Amount = 10
            },
            Premium = {
                Type = "Package",
                Id = "ReforgeStonePackage"
            }
        },
        [74] = {
            Free = {
                Type = "Package",
                Id = "MaterialBundle_Tier3",
                Amount = 25
            },
            Premium = {
                Type = "CraftingMaterial",
                Id = "Celestial Ingot",
                Amount = 10
            }
        },
        [75] = {
            Free = {
                Type = "Package",
                Id = "BlackSwordsmanPack"
            },
            Premium = {
                Type = "Package",
                Id = "EclipsePack"
            }
        },
        [78] = {
            Free = {
                Type = "Package",
                Id = "LegendaryGearPack"
            },
            Premium = {
                Type = "CraftingMaterial",
                Id = "Celestial Ingot",
                Amount = 10
            }
        },
        [79] = {
            Free = {
                Type = "LuckySpins",
                Amount = 5
            },
            Premium = {
                Type = "LuckySpins",
                Amount = 5
            }
        },
        [80] = {
            Free = {
                Type = "LuckySpins",
                Amount = 5
            },
            Premium = {
                Type = "BuffPotion",
                Id = "LuckPotionT3",
                Amount = 1
            }
        },
        [82] = {
            Free = {
                Type = "Package",
                Id = "MaterialBundle_Tier3",
                Amount = 25
            },
            Premium = {
                Type = "Package",
                Id = "CelestialGearPack"
            }
        },
        [84] = {
            Free = {
                Type = "NormalSpins",
                Amount = 10
            },
            Premium = {
                Type = "NormalSpins",
                Amount = 15
            }
        },
        [86] = {
            Free = {
                Type = "CraftingMaterial",
                Id = "Celestial Ingot",
                Amount = 10
            },
            Premium = {
                Type = "Package",
                Id = "ReforgeStonePackage"
            }
        },
        [88] = {
            Free = {
                Type = "Package",
                Id = "ForgeStonePackage"
            },
            Premium = {
                Type = "CraftingMaterial",
                Id = "Celestial Ingot",
                Amount = 10
            }
        },
        [91] = {
            Free = {
                Type = "BuffPotion",
                Id = "LuckPotionT2",
                Amount = 2
            },
            Premium = {
                Type = "LuckySpins",
                Amount = 5
            }
        },
        [92] = {
            Free = {
                Type = "CraftingMaterial",
                Id = "Celestial Ingot",
                Amount = 10
            },
            Premium = {
                Type = "Package",
                Id = "CelestialRingPack"
            }
        },
        [94] = {
            Free = {
                Type = "Package",
                Id = "MaterialBundle_Tier3",
                Amount = 25
            },
            Premium = {
                Type = "CraftingMaterial",
                Id = "Celestial Ingot",
                Amount = 10
            }
        },
        [95] = {
            Free = {
                Type = "LuckySpins",
                Amount = 5
            },
            Premium = {
                Type = "BuffPotion",
                Id = "LuckPotionT3",
                Amount = 2
            }
        },
        [96] = {
            Free = {
                Type = "NormalSpins",
                Amount = 10
            },
            Premium = {
                Type = "NormalSpins",
                Amount = 15
            }
        },
        [97] = {
            Free = {
                Type = "CraftingMaterial",
                Id = "Celestial Ingot",
                Amount = 10
            },
            Premium = {
                Type = "Package",
                Id = "ForgeStonePackage"
            }
        },
        [98] = {
            Free = {
                Type = "Package",
                Id = "LegendaryGearPack"
            },
            Premium = {
                Type = "CraftingMaterial",
                Id = "Celestial Ingot",
                Amount = 10
            }
        },
        [99] = {
            Free = {
                Type = "CraftingMaterial",
                Id = "Celestial Ingot",
                Amount = 10
            },
            Premium = {
                Type = "CraftingMaterial",
                Id = "Celestial Ingot",
                Amount = 10
            }
        },
        [100] = {
            Free = {
                Type = "Package",
                Id = "GamePlayerPack"
            },
            Premium = {
                Type = "Title",
                Id = "S3Paragon"
            }
        }
    },
    FillRewards = {
        Coins = {
            Free = {
                Type = "Coins",
                Amount = 1000
            },
            Premium = {
                Type = "Coins",
                Amount = 1500
            }
        },
        Stars = {
            Free = {
                Type = "Stars",
                Amount = 100
            },
            Premium = {
                Type = "Stars",
                Amount = 150
            }
        }
    },
    InfiniteRewards = { {
            Type = "Stars",
            Amount = 75
        }, {
            Type = "Coins",
            Amount = 2500
        }, {
            Type = "CraftingMaterial",
            Id = "Obsidian Ore",
            Amount = 6
        }, {
            Type = "CraftingMaterial",
            Id = "Celestial Ore",
            Amount = 4
        }, {
            Type = "CraftingMaterial",
            Id = "Legendary Ingot",
            Amount = 3
        }, {
            Type = "CraftingMaterial",
            Id = "Mythic Ingot",
            Amount = 2
        } },
    CHECKPOINT_INTERVAL = 25,
    Checkpoints = {
        [25] = {
            Free = {
                Rarity = "Mythic",
                Category = "Emote",
                Title = "Warm Up",
                Description = "A Battlepass-exclusive limited emote — loosen up before the fight. Never sold in the Stars Shop."
            },
            Premium = {
                Rarity = "Celestial",
                Category = "Cosmetic",
                Description = "A radiant aura befitting the Forge Archon."
            }
        },
        [50] = {
            Free = {
                Rarity = "Celestial",
                Category = "Class Item",
                Description = "The towering staff of a great mage. Transforms the wielder into the Demonbane."
            },
            Premium = {
                Rarity = "Celestial",
                Category = "Cosmetic",
                Description = "The complete Forge Archon cosmetic set."
            }
        },
        [75] = {
            Free = {
                Rarity = "Mythic",
                Category = "Cosmetic",
                Description = "The complete Black Swordsman cosmetic set."
            },
            Premium = {
                Rarity = "Celestial",
                Category = "Cosmetic",
                Description = "The complete Eclipse cosmetic set."
            }
        },
        [100] = {
            Free = {
                Rarity = "Celestial",
                Category = "Cosmetic",
                Description = "The complete Game Player cosmetic set — proof the pass was finished."
            },
            Premium = {
                Rarity = "Celestial",
                Category = "Title",
                Description = "The Season 3 capstone title, reserved for those who finish the pass."
            }
        }
    }
};

function u1.GetCheckpointForLevel(p2: number) -- Line: 273
    -- upvalues: u1 (copy)
    local CHECKPOINT_INTERVAL = u1.CHECKPOINT_INTERVAL;
    local v3 = math.max(p2, 1) / CHECKPOINT_INTERVAL;
    local v4 = math.ceil(v3) * CHECKPOINT_INTERVAL;

    return math.min(v4, u1.MAX_TIER);
end;

u1.ObjectiveType = {
    KillNPCs = "KillNPCs",
    KillEnemy = "KillEnemy",
    KillInDungeon = "KillInDungeon",
    KillOnDifficulty = "KillOnDifficulty",
    CompleteDungeon = "CompleteDungeon",
    CompleteDifficulty = "CompleteDifficulty",
    CompleteDungeonMultiplayer = "CompleteDungeonMultiplayer",
    IdentifyEquipment = "IdentifyEquipment",
    SellItems = "SellItems",
    ForgeEquipment = "ForgeEquipment",
    ClassSpins = "ClassSpins",
    EarnCoins = "EarnCoins",
    DailyLogin = "DailyLogin"
};
u1.QuestPool = {
    {
        Id = "bp_daily_login",
        Name = "Daily Devotion",
        Objective = "Log In to the Realm",
        ObjectiveType = "DailyLogin",
        Difficulty = "Easy",
        Target = 1,
        BPXPReward = 500
    },
    {
        Id = "bp_easy_kill_30",
        Name = "Warm-Up Swings",
        Objective = "Kill 30 Enemies",
        ObjectiveType = "KillNPCs",
        Difficulty = "Easy",
        Target = 30,
        BPXPReward = 700
    },
    {
        Id = "bp_easy_sell_8",
        Name = "Pocket Change",
        Objective = "Sell 8 Items to the Item Shop",
        ObjectiveType = "SellItems",
        Difficulty = "Easy",
        Target = 8,
        BPXPReward = 700
    },
    {
        Id = "bp_easy_forge_common_5",
        Name = "Apprentice Smith",
        Objective = "Forge Common Equipment 5 Times",
        ObjectiveType = "ForgeEquipment",
        Difficulty = "Easy",
        Target = 5,
        BPXPReward = 700,
        ObjectiveParams = {
            Rarity = "Common"
        }
    },
    {
        Id = "bp_easy_earn_7500",
        Name = "Loose Coin",
        Objective = "Earn 7,500 Coins",
        ObjectiveType = "EarnCoins",
        Difficulty = "Easy",
        Target = 7500,
        BPXPReward = 700
    },
    {
        Id = "bp_easy_spin_5",
        Name = "Test of Fate",
        Objective = "Spin for Classes 5 Times",
        ObjectiveType = "ClassSpins",
        Difficulty = "Easy",
        Target = 5,
        BPXPReward = 700
    },
    {
        Id = "bp_easy_dungeon_easy_2",
        Name = "Foot in the Door",
        Objective = "Complete Any Dungeon on Easy 2 Times",
        ObjectiveType = "CompleteDungeon",
        Difficulty = "Easy",
        Target = 2,
        BPXPReward = 800,
        ObjectiveParams = {
            Difficulty = "Easy"
        }
    },
    {
        Id = "bp_norm_kill_150",
        Name = "Proven Fighter",
        Objective = "Kill 150 Enemies",
        ObjectiveType = "KillNPCs",
        Difficulty = "Normal",
        Target = 150,
        BPXPReward = 1300
    },
    {
        Id = "bp_norm_kill_normal_75",
        Name = "Measured Carnage",
        Objective = "Kill 75 Enemies on Normal Difficulty",
        ObjectiveType = "KillOnDifficulty",
        Difficulty = "Normal",
        Target = 75,
        BPXPReward = 1400,
        ObjectiveParams = {
            Difficulty = "Normal"
        }
    },
    {
        Id = "bp_norm_bandits_normal_6",
        Name = "Den Raider",
        Objective = "Complete Bandits Den on Normal 5 Times",
        ObjectiveType = "CompleteDungeon",
        Difficulty = "Normal",
        Target = 5,
        BPXPReward = 1500,
        ObjectiveParams = {
            LocationId = "Bandits Den",
            Difficulty = "Normal"
        }
    },
    {
        Id = "bp_norm_goblins_normal_4",
        Name = "Goblin Cleanup",
        Objective = "Complete Goblins on Normal 4 Times",
        ObjectiveType = "CompleteDungeon",
        Difficulty = "Normal",
        Target = 4,
        BPXPReward = 1300,
        ObjectiveParams = {
            LocationId = "Goblins",
            Difficulty = "Normal"
        }
    },
    {
        Id = "bp_norm_knights_easy_5",
        Name = "Castle Rounds",
        Objective = "Complete Knights on Easy 5 Times",
        ObjectiveType = "CompleteDungeon",
        Difficulty = "Normal",
        Target = 5,
        BPXPReward = 1400,
        ObjectiveParams = {
            LocationId = "Knights",
            Difficulty = "Easy"
        }
    },
    {
        Id = "bp_norm_forge_uncommon_6",
        Name = "Journeyman Smith",
        Objective = "Forge Uncommon Equipment 6 Times",
        ObjectiveType = "ForgeEquipment",
        Difficulty = "Normal",
        Target = 6,
        BPXPReward = 1400,
        ObjectiveParams = {
            Rarity = "Uncommon"
        }
    },
    {
        Id = "bp_norm_forge_rare_4",
        Name = "Quality Work",
        Objective = "Forge Rare Equipment 4 Times",
        ObjectiveType = "ForgeEquipment",
        Difficulty = "Normal",
        Target = 4,
        BPXPReward = 1500,
        ObjectiveParams = {
            Rarity = "Rare"
        }
    },
    {
        Id = "bp_norm_sell_20",
        Name = "Merchant\'s Haul",
        Objective = "Sell 20 Items to the Item Shop",
        ObjectiveType = "SellItems",
        Difficulty = "Normal",
        Target = 20,
        BPXPReward = 1300
    },
    {
        Id = "bp_norm_earn_30k",
        Name = "Steady Income",
        Objective = "Earn 30,000 Coins",
        ObjectiveType = "EarnCoins",
        Difficulty = "Normal",
        Target = 30000,
        BPXPReward = 1500
    },
    {
        Id = "bp_norm_spin_20",
        Name = "Gacha Fever",
        Objective = "Spin for Classes 20 Times",
        ObjectiveType = "ClassSpins",
        Difficulty = "Normal",
        Target = 20,
        BPXPReward = 1400
    },
    {
        Id = "bp_norm_multi_4",
        Name = "Strength in Numbers",
        Objective = "Complete 4 Dungeons with Another Player",
        ObjectiveType = "CompleteDungeonMultiplayer",
        Difficulty = "Normal",
        Target = 4,
        BPXPReward = 1500
    },
    {
        Id = "bp_hard_kill_500",
        Name = "Legion Slayer",
        Objective = "Kill 500 Enemies",
        ObjectiveType = "KillNPCs",
        Difficulty = "Hard",
        Target = 500,
        BPXPReward = 2800
    },
    {
        Id = "bp_hard_kill_hard_300",
        Name = "Hard-Boiled",
        Objective = "Kill 300 Enemies on Hard Difficulty",
        ObjectiveType = "KillOnDifficulty",
        Difficulty = "Hard",
        Target = 300,
        BPXPReward = 3000,
        ObjectiveParams = {
            Difficulty = "Hard"
        }
    },
    {
        Id = "bp_hard_knights_hard_15",
        Name = "Siegebreaker",
        Objective = "Complete Knights on Hard 5 Times",
        ObjectiveType = "CompleteDungeon",
        Difficulty = "Hard",
        Target = 5,
        BPXPReward = 3000,
        ObjectiveParams = {
            LocationId = "Knights",
            Difficulty = "Hard"
        }
    },
    {
        Id = "bp_hard_cata_hard_15",
        Name = "Crypt Delver",
        Objective = "Complete Catacombs on Hard 5 Times",
        ObjectiveType = "CompleteDungeon",
        Difficulty = "Hard",
        Target = 5,
        BPXPReward = 3000,
        ObjectiveParams = {
            LocationId = "Catacombs",
            Difficulty = "Hard"
        }
    },
    {
        Id = "bp_hard_forge_epic_5",
        Name = "Master Smith",
        Objective = "Forge Epic Equipment 5 Times",
        ObjectiveType = "ForgeEquipment",
        Difficulty = "Hard",
        Target = 5,
        BPXPReward = 2800,
        ObjectiveParams = {
            Rarity = "Epic"
        }
    },
    {
        Id = "bp_hard_earn_75k",
        Name = "Small Fortune",
        Objective = "Earn 75,000 Coins",
        ObjectiveType = "EarnCoins",
        Difficulty = "Hard",
        Target = 75000,
        BPXPReward = 2800
    },
    {
        Id = "bp_hard_multi_6",
        Name = "Party Leader",
        Objective = "Complete 5 Dungeons with Another Player",
        ObjectiveType = "CompleteDungeonMultiplayer",
        Difficulty = "Hard",
        Target = 5,
        BPXPReward = 3000
    },
    {
        Id = "bp_hard_spin_50",
        Name = "High Roller",
        Objective = "Spin for Classes 50 Times",
        ObjectiveType = "ClassSpins",
        Difficulty = "Hard",
        Target = 50,
        BPXPReward = 2600
    },
    {
        Id = "bp_ext_kill_800",
        Name = "Legion Ender",
        Objective = "Kill 800 Enemies",
        ObjectiveType = "KillNPCs",
        Difficulty = "Extreme",
        Target = 800,
        BPXPReward = 5200
    },
    {
        Id = "bp_ext_kill_nm_500",
        Name = "Nightmare Reaper",
        Objective = "Kill 500 Enemies on Nightmare Difficulty",
        ObjectiveType = "KillOnDifficulty",
        Difficulty = "Extreme",
        Target = 500,
        BPXPReward = 6000,
        ObjectiveParams = {
            Difficulty = "Nightmare"
        }
    },
    {
        Id = "bp_ext_cata_nm_20",
        Name = "Catacomb Sovereign",
        Objective = "Complete Catacombs on Nightmare 5 Times",
        ObjectiveType = "CompleteDungeon",
        Difficulty = "Extreme",
        Target = 5,
        BPXPReward = 6000,
        ObjectiveParams = {
            LocationId = "Catacombs",
            Difficulty = "Nightmare"
        }
    },
    {
        Id = "bp_ext_forge_leg_4",
        Name = "Grandmaster Smith",
        Objective = "Forge Legendary Equipment 4 Times",
        ObjectiveType = "ForgeEquipment",
        Difficulty = "Extreme",
        Target = 4,
        BPXPReward = 5600,
        ObjectiveParams = {
            Rarity = "Legendary"
        }
    },
    {
        Id = "bp_ext_earn_150k",
        Name = "Trade Baron",
        Objective = "Earn 150,000 Coins",
        ObjectiveType = "EarnCoins",
        Difficulty = "Extreme",
        Target = 150000,
        BPXPReward = 5000
    },
    {
        Id = "bp_ext_multi_8",
        Name = "Raid Captain",
        Objective = "Complete 5 Dungeons with Another Player",
        ObjectiveType = "CompleteDungeonMultiplayer",
        Difficulty = "Extreme",
        Target = 5,
        BPXPReward = 5600
    }
};
u1._questById = {};
u1._questsByDifficulty = {};

for _, v in ipairs(u1.QuestPool) do
    local v5 = not u1._questById[v.Id];
    local v6 = `Duplicate BP quest Id: {v.Id}`;
    assert(v5, v6);
    local v7 = u1.QuestDifficulty[v.Difficulty];
    local v8 = `Unknown BP quest Difficulty on {v.Id}: {tostring(v.Difficulty)}`;
    assert(v7, v8);
    u1._questById[v.Id] = v;
    local v9 = u1._questsByDifficulty[v.Difficulty];

    if not v9 then
        v9 = {};
        u1._questsByDifficulty[v.Difficulty] = v9;
    end;

    if v.Id ~= u1.DAILY_LOGIN_QUEST_ID then
        table.insert(v9, v);
    end;
end;

function u1.GetQuestById(p10: string) -- Line: 641
    -- upvalues: u1 (copy)
    return u1._questById[p10];
end;

function u1.GetTierReward(p11: number, p12: string) -- Line: 649
    -- upvalues: u1 (copy)
    if p11 < 1 then
        return nil;
    end;

    if u1.MAX_TIER < p11 then
        return nil;
    end;

    local v13 = u1.Tiers[p11];

    if v13 then
        return v13[p12];
    end;

    return (p11 % 5 == 0 and u1.FillRewards.Stars or u1.FillRewards.Coins)[p12];
end;

function u1.GetInfiniteReward(p14: number) -- Line: 664
    -- upvalues: u1 (copy)
    local InfiniteRewards = u1.InfiniteRewards;

    return InfiniteRewards[Random.new(p14 * 7919 + u1.CURRENT_SEASON):NextInteger(1, #InfiniteRewards)];
end;

function u1.GetXPForTier(p15: number) -- Line: 676
    return p15 <= 25 and 1000 or (p15 <= 75 and 1500 or 2000);
end;

function u1.GetCurrentWindowIndex() -- Line: 684
    -- upvalues: u1 (copy)
    local v16 = DateTime.now().UnixTimestamp / u1.QUEST_REFRESH_INTERVAL;

    return math.floor(v16);
end;

function u1.GetQuestsForWindow(p17: number, p18: number?) -- Line: 696
    -- upvalues: u1 (copy)
    local Random_new_ret = Random.new(p17 * 7919 + (p18 or 0) * 131 + u1.CURRENT_SEASON * 31337);

    local function pickFrom(p19: string, p20: number, p21: table) -- Line: 703
        -- upvalues: u1 (ref), Random_new_ret (copy)
        local v22 = u1._questsByDifficulty[p19];

        if not v22 or #v22 == 0 then
            return;
        end;

        local table_clone_ret = table.clone(v22);

        for i = 1, math.min(p20, #table_clone_ret) do
            local v23 = Random_new_ret:NextInteger(i, #table_clone_ret);
            local v24 = table_clone_ret[i];
            table_clone_ret[i] = table_clone_ret[v23];
            table_clone_ret[v23] = v24;
            table.insert(p21, table_clone_ret[i]);
            local _ = i;
        end;
    end;

    local v25 = {};
    local v26 = u1._questById[u1.DAILY_LOGIN_QUEST_ID];

    if v26 then
        table.insert(v25, v26);
    end;

    pickFrom("Easy", u1.QuestDifficulty.Easy.SlotCount - 1, v25);
    pickFrom("Normal", u1.QuestDifficulty.Normal.SlotCount, v25);
    pickFrom("Hard", u1.QuestDifficulty.Hard.SlotCount, v25);
    pickFrom("Extreme", u1.QuestDifficulty.Extreme.SlotCount, v25);

    return v25;
end;

function u1.SecondsUntilNextWindow() -- Line: 733
    -- upvalues: u1 (copy)
    local UnixTimestamp = DateTime.now().UnixTimestamp;
    local QUEST_REFRESH_INTERVAL = u1.QUEST_REFRESH_INTERVAL;

    return QUEST_REFRESH_INTERVAL - UnixTimestamp % QUEST_REFRESH_INTERVAL;
end;

function u1.GetRewardDisplayText(p27: table) -- Line: 741
    local Type = p27.Type;
    local v28 = p27.Amount or 1;

    if Type == "Coins" then
        return `{v28} Coins`;
    end;

    if Type == "Stars" then
        return `{v28} Stars`;
    end;

    if Type == "NormalSpins" then
        return `{v28}x Normal Spin{v28 > 1 and "s" or ""}`;
    end;

    if Type == "LuckySpins" then
        return `{v28}x Lucky Spin{v28 > 1 and "s" or ""}`;
    end;

    if Type == "ClassEXPPotion" then
        return `{v28}x Class XP Essence`;
    end;

    if Type == "Cosmetic" then
        return p27.Id or "Cosmetic";
    end;

    if Type == "Title" then
        return `Title: {p27.Id or "???"}`;
    end;

    if Type == "Equipment" then
        return p27.Id or "Equipment";
    end;

    if Type == "ClassItem" then
        return p27.Id or "Class Item";
    end;

    if Type == "Package" then
        local v29 = require(script.Parent.PackageData).Get(p27.Id);

        return v29 and v29.Name or (p27.Id or "Package");
    end;

    if Type == "CraftingMaterial" then
        return `{v28}x {p27.Id or "Material"}`;
    end;

    if Type == "Emote" then
        local EmoteData = require(script.Parent.EmoteData);
        local v30 = p27.Id and EmoteData.Get(p27.Id);

        return `Emote: {v30 and v30.DisplayName or (p27.Id or "???")}`;
    end;

    if Type ~= "BuffPotion" then
        return "???";
    end;

    local BuffPotionData = require(script.Parent.BuffPotionData);
    local v31 = p27.Id and BuffPotionData.GetPotion(p27.Id);

    return `{v28}x {v31 and v31.Name or (p27.Id or "Potion")}`;
end;

function u1.GetRewardName(p32: table) -- Line: 785
    local Type = p32.Type;

    if Type == "Coins" then
        return "Coins";
    end;

    if Type == "Stars" then
        return "Stars";
    end;

    if Type == "NormalSpins" then
        return "Normal Spins";
    end;

    if Type == "LuckySpins" then
        return "Lucky Spins";
    end;

    if Type == "ClassEXPPotion" then
        return "Class XP Essence";
    end;

    if Type == "Cosmetic" then
        return p32.Id or "Cosmetic";
    end;

    if Type == "Title" then
        return `Title: {p32.Id or "???"}`;
    end;

    if Type == "Equipment" then
        return p32.Id or "Equipment";
    end;

    if Type == "ClassItem" then
        return p32.Id or "Class Item";
    end;

    if Type == "Package" then
        local v33 = require(script.Parent.PackageData).Get(p32.Id);

        return v33 and v33.Name or (p32.Id or "Package");
    end;

    if Type == "CraftingMaterial" then
        return p32.Id or "Material";
    end;

    if Type == "Emote" then
        local EmoteData = require(script.Parent.EmoteData);
        local v34 = p32.Id and EmoteData.Get(p32.Id);

        return v34 and v34.DisplayName or (p32.Id or "Emote");
    end;

    if Type ~= "BuffPotion" then
        return "???";
    end;

    local BuffPotionData = require(script.Parent.BuffPotionData);
    local v35 = p32.Id and BuffPotionData.GetPotion(p32.Id);

    return v35 and v35.Name or (p32.Id or "Potion");
end;

function u1.GetRewardNameAndCount(p36: table) -- Line: 829
    -- upvalues: u1 (copy)
    local RewardName = u1.GetRewardName(p36);
    local v37 = p36.Amount or 1;
    local string_match_ret = string.match(RewardName, "^(%d+)[xX]%s+");
    local string_match_ret2 = string.match(RewardName, "%s+[xX](%d+)$");

    if string_match_ret then
        return string.gsub(RewardName, "^%d+[xX]%s+", "", 1), v37 * tonumber(string_match_ret);
    end;

    if string_match_ret2 then
        RewardName = string.gsub(RewardName, "%s+[xX]%d+$", "", 1);
        v37 = v37 * tonumber(string_match_ret2);
    end;

    return RewardName, v37;
end;

return u1;