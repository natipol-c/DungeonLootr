--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DungeonData
  Path:     game.ReplicatedStorage.GameInfo.DungeonData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

require(game:GetService("ReplicatedStorage").GameInfo.RarityData);

local function SpawnPool(p1, p2, p3) -- Line: 44
    return {
        Pool = p1,
        Waves = p2,
        Overrides = p3
    };
end;

local function BossConfig(p4, p5, p6, p7, p8, p9, p10) -- Line: 59
    return {
        SpawnChance = nil,
        Collectable = true,
        HeroId = p4,
        Name = p5,
        Scale = p6,
        Health = p7 * 1.5,
        Damage = p8 * 1.5,
        Multiplier = p9,
        HealthBars = p10
    };
end;

local function EliteConfig(p11, p12, p13, p14, p15, p16) -- Line: 69
    return {
        Aura = "Gold",
        SpawnInterval = p11,
        LuckMultiplier = p12,
        BuffDuration = p13,
        HealthMultiplier = p14,
        DamageMultiplier = p15,
        Scale = p16
    };
end;

local function Rewards(p17, p18, p19, p20) -- Line: 78
    return {
        BaseCash = p17,
        BaseStars = p18,
        BonusItems = p19 or {},
        HyperCrystalChance = p20 or 0
    };
end;

local function BonusItem(p21, p22, p23) -- Line: 87
    return {
        ItemId = p21,
        Amount = { p22, p23 or p22 }
    };
end;

local function RoomConfig(p24, p25, p26) -- Line: 94
    return {
        Pool = p24,
        Waves = p25,
        Overrides = p26
    };
end;

local u27 = {
    Legacy = true,
    MaxNPCs = 10,
    SpawnInterval = 5,
    MaxPortals = 2,
    InitialNPCs = 5,
    PvpEnabled = false,
    CashCost = 0,
    BossKill = nil,
    RebirthLevel = 0,
    Difficulty = 0,
    LevelRange = {
        Min = 0,
        Max = 100
    },
    RarityOverrides = nil,
    SpawnPools = nil,
    EliteMob = nil,
    TimeLimit = 180,
    FailRewardMultiplier = 0,
    Rewards = nil,
    Boss = nil,
    BossRespawnTime = 60,
    LootChest = nil,
    LootChestChance = 0,
    LootChestCount = nil,
    Lives = 1,
    LockedRooms = nil,
    RoomsByDifficulty = nil,
    OpenWorld = false,
    BiomeId = nil,
    CombatRoomCount = nil,
    CombatRoomCountByDifficulty = nil,
    LootRoomChance = 0.3,
    EnemyPool = nil,
    MobsPerRoom = 10,
    EnemyOverrides = nil,
    LightingPreset = nil,
    ChallengeMode = false,
    ChallengeMap = nil,
    MinLevel = 0,
    Locked = false,
    RewardPreviewDungeon = nil
};

local function entry(p28) -- Line: 195
    -- upvalues: u27 (copy)
    local v29 = {};

    for i, v in u27 do
        v29[i] = v;
    end;

    for i, v in p28 do
        v29[i] = v;
    end;

    return v29;
end;

local v30 = {};
local v31 = {
    DisplayName = "Bandit\'s Hollow",
    DisplayOrder = 1,
    Legacy = false,
    MaxNPCs = 12,
    InitialNPCs = 5,
    MaxPortals = 1,
    CashCost = 0,
    Difficulty = 1,
    Tier = 1,
    HideFromSelect = true,
    Theme = "DEX",
    EquipTierThreshold = 20,
    WorkspacePath = "Important.Dungeon_1",
    TimeLimit = 300,
    LootChest = "CommonLootChest",
    LevelRange = {
        Min = 1,
        Max = 15
    },
    DifficultyLevelBrackets = {
        Easy = {
            Min = 1,
            Max = 5
        },
        Normal = {
            Min = 4,
            Max = 15
        },
        Hard = {
            Min = 10,
            Max = 25
        },
        Nightmare = {
            Min = 20,
            Max = 40
        },
        Endless = {
            Min = 35,
            Max = 50
        }
    },
    Rooms = { {
            Overrides = nil,
            Pool = { "Bandit", "Bandit", "Rogue" },
            Waves = { 6 }
        }, {
            Overrides = nil,
            Pool = { "Rogue", "Archer", "Bandit" },
            Waves = { 6 }
        }, {
            Overrides = nil,
            Pool = { "Rogue", "Strong Bandit", "Rogue" },
            Waves = { 7 }
        }, {
            Overrides = nil,
            Pool = { "Strong Bandit", "Strong Bandit", "Strong Bandit", "Archer" },
            Waves = { 8 }
        }, {
            Overrides = nil,
            Pool = { "Rogue", "Rogue", "Rogue" },
            Waves = { 10 }
        }, {
            Overrides = nil,
            Pool = { "Strong Bandit", "Bandit", "Bandit", "Rogue", "Archer" },
            Waves = { 12 }
        }, {
            Overrides = nil,
            Pool = { "Strong Bandit", "Strong Bandit" },
            Waves = { 6 }
        } },
    Rewards = {
        BaseCash = 30,
        BaseStars = 5,
        HyperCrystalChance = 0,
        BonusItems = {}
    },
    Boss = {
        HeroId = "Bandit Chief",
        Name = "Bandit Chief, The Forest Warden",
        Scale = 1.3,
        Health = 2250,
        Damage = 22.5,
        Multiplier = 1.5,
        SpawnChance = nil,
        Collectable = true,
        HealthBars = nil
    },
    LootChestCount = { 1, 5 },
    LockedRooms = {
        Min = 1,
        Max = 2
    }
};
local u32 = {};
local v33 = {
    HeroId = "Scarlet Knight",
    Name = "Scarlet Knight, The Crimson Revenant",
    Scale = 1.4,
    Health = 90000,
    Damage = 127.5,
    Multiplier = 2,
    SpawnChance = nil,
    Collectable = true,
    HealthBars = 5
};
local v34 = {
    HeroId = "Imperator",
    Name = "Imperator, The Sovereign of Ruin",
    Scale = 1.5,
    Health = 112500,
    Damage = 150,
    Multiplier = 2,
    SpawnChance = nil,
    Collectable = true,
    HealthBars = 5
};
local v35 = {
    HeroId = "Shadow Knight",
    Name = "Shadow Knight",
    Scale = 1.5,
    Health = 120000,
    Damage = 142.5,
    Multiplier = 2,
    SpawnChance = nil,
    Collectable = true,
    HealthBars = 5
};
local v36 = {
    HeroId = "Unrestricted EX",
    Name = "Unrestricted EX",
    Scale = 1.5,
    Health = 120000,
    Damage = 142.5,
    Multiplier = 2,
    SpawnChance = nil,
    Collectable = true,
    HealthBars = 5
};
local v37 = {
    HeroId = "Awakened Devil",
    Name = "Awakened Devil",
    Scale = 1.5,
    Health = 97500,
    Damage = 135,
    Multiplier = 2,
    SpawnChance = nil,
    Collectable = true,
    HealthBars = 5
};
local v38 = {
    HeroId = "Frigid Monarch",
    Name = "Frigid Monarch",
    Scale = 1.6,
    Health = 142500,
    Damage = 157.5,
    Multiplier = 2,
    SpawnChance = nil,
    Collectable = true,
    HealthBars = 5
};

for i, v in u27 do
    v30[i] = v;
end;

for i, v in v31 do
    v30[i] = v;
end;

u32["Forest Challenge"] = v30;
local v39 = {};
local v40 = {
    DisplayName = "Bandit\'s Den",
    DisplayOrder = 0,
    Legacy = false,
    MaxNPCs = 12,
    InitialNPCs = 5,
    MaxPortals = 1,
    CashCost = 0,
    Difficulty = 1,
    Tier = 1,
    Theme = "DEX",
    EquipTierThreshold = 20,
    OpenWorld = true,
    BiomeId = "Wood",
    LightingPreset = "Wood",
    TimeLimit = 300,
    LootChest = "CommonLootChest",
    LevelRange = {
        Min = 1,
        Max = 15
    },
    DifficultyLevelBrackets = {
        Easy = {
            Min = 1,
            Max = 5
        },
        Normal = {
            Min = 4,
            Max = 15
        },
        Hard = {
            Min = 10,
            Max = 25
        },
        Nightmare = {
            Min = 20,
            Max = 40
        },
        Endless = {
            Min = 35,
            Max = 50
        }
    },
    EnemyPool = { "Bandit", "Strong Bandit", "Rogue", "Archer" },
    CombatRoomCount = {
        Min = 7,
        Max = 7
    },
    CombatRoomCountByDifficulty = {
        Easy = 4,
        Normal = 5,
        Hard = 6,
        Nightmare = 7
    },
    Rewards = {
        BaseCash = 30,
        BaseStars = 5,
        HyperCrystalChance = 0,
        BonusItems = {}
    },
    Boss = {
        HeroId = "Bandit Chief",
        Name = "Bandit Chief, The Forest Warden",
        Scale = 1.3,
        Health = 2250,
        Damage = 22.5,
        Multiplier = 1.5,
        SpawnChance = nil,
        Collectable = true,
        HealthBars = 2
    },
    MiniBoss = {
        HeroId = "Bandit Enforcer",
        Name = "Bandit Enforcer",
        Scale = 1.3,
        Health = 750,
        Damage = 15,
        BossDataKey = "Bandit Enforcer",
        GruntCount = 2
    },
    CosmeticRewards = { {
            PackageId = "ObsidianWolfPack",
            Chance = 0.005
        } },
    LootChestCount = { 1, 5 },
    LockedRooms = {
        Min = 1,
        Max = 2
    }
};

for i, v in u27 do
    v39[i] = v;
end;

for i, v in v40 do
    v39[i] = v;
end;

u32["Bandits Den"] = v39;
local v41 = {};
local v42 = {
    DisplayName = "Goblin\'s Stronghold",
    DisplayOrder = 2,
    Legacy = false,
    MaxNPCs = 12,
    InitialNPCs = 5,
    MaxPortals = 1,
    CashCost = 0,
    Difficulty = 2,
    Tier = 2,
    Theme = "STR",
    EquipTierThreshold = 20,
    OpenWorld = true,
    BiomeId = "Forest",
    LightingPreset = "Forest",
    MobsPerRoom = 10,
    TimeLimit = 300,
    LootChest = "RareLootChest",
    LevelRange = {
        Min = 10,
        Max = 25
    },
    RequiresClear = {
        DungeonId = "Bandits Den",
        Difficulty = "Hard"
    },
    DifficultyLevelBrackets = {
        Easy = {
            Min = 8,
            Max = 15
        },
        Normal = {
            Min = 12,
            Max = 22
        },
        Hard = {
            Min = 18,
            Max = 30
        },
        Nightmare = {
            Min = 25,
            Max = 42
        },
        Endless = {
            Min = 38,
            Max = 50
        }
    },
    EnemyPool = { "Goblin", "Goblin Rogue", "Strong Goblin", "Goblin Shaman" },
    CombatRoomCount = {
        Min = 8,
        Max = 8
    },
    CombatRoomCountByDifficulty = {
        Easy = 5,
        Normal = 5,
        Hard = 6,
        Nightmare = 7
    },
    Rewards = {
        BaseCash = 50,
        BaseStars = 5,
        HyperCrystalChance = 0,
        BonusItems = {}
    },
    Boss = {
        HeroId = "Goblin Chief",
        Name = "Varek, The Feared",
        Scale = 1.5,
        Health = 6000,
        Damage = 34.5,
        Multiplier = 1.5,
        SpawnChance = nil,
        Collectable = true,
        HealthBars = 2
    },
    MiniBoss = {
        HeroId = "Goblin Warchief",
        Name = "Goblin Warchief",
        Scale = 1.4,
        Health = 2250,
        Damage = 27,
        BossDataKey = "Goblin Warchief",
        GruntCount = 2
    },
    LootChestCount = { 1, 5 },
    LockedRooms = {
        Min = 1,
        Max = 3
    }
};

for i, v in u27 do
    v41[i] = v;
end;

for i, v in v42 do
    v41[i] = v;
end;

u32.Goblins = v41;
local v43 = {};
local v44 = {
    DisplayName = "Forgotten Ruins",
    DisplayOrder = 3,
    Legacy = false,
    MaxNPCs = 12,
    InitialNPCs = 5,
    MaxPortals = 1,
    CashCost = 0,
    Difficulty = 3,
    Tier = 3,
    Theme = "VIT",
    EquipTierThreshold = 20,
    OpenWorld = true,
    BiomeId = "Castle",
    LightingPreset = "Castle",
    MobsPerRoom = 10,
    TimeLimit = 300,
    LootChest = "RareLootChest",
    LevelRange = {
        Min = 20,
        Max = 40
    },
    RequiresClear = {
        DungeonId = "Goblins",
        Difficulty = "Hard"
    },
    DifficultyLevelBrackets = {
        Easy = {
            Min = 15,
            Max = 25
        },
        Normal = {
            Min = 20,
            Max = 30
        },
        Hard = {
            Min = 25,
            Max = 38
        },
        Nightmare = {
            Min = 32,
            Max = 45
        },
        Endless = {
            Min = 40,
            Max = 50
        }
    },
    EnemyPool = { "Knight", "Knight Rogue", "Strong Knight", "Knight Archer" },
    CombatRoomCount = {
        Min = 8,
        Max = 8
    },
    CombatRoomCountByDifficulty = {
        Easy = 6,
        Normal = 6,
        Hard = 7,
        Nightmare = 7
    },
    Rewards = {
        BaseCash = 50,
        BaseStars = 5,
        HyperCrystalChance = 0,
        BonusItems = {}
    },
    Boss = {
        HeroId = "Knight Lord",
        Name = "Gilvan, The Oathbound",
        Scale = 1.7,
        Health = 15000,
        Damage = 52.5,
        Multiplier = 1.5,
        SpawnChance = nil,
        Collectable = true,
        HealthBars = 3
    },
    MiniBoss = {
        HeroId = "Knight Champion",
        Name = "Knight Champion",
        Scale = 1.5,
        Health = 6000,
        Damage = 42,
        BossDataKey = "Knight Champion",
        GruntCount = 2
    },
    CosmeticRewards = { {
            PackageId = "KnightLordPack",
            Chance = 0.01
        } },
    LootChestCount = { 1, 5 },
    LockedRooms = {
        Min = 1,
        Max = 4
    }
};

for i, v in u27 do
    v43[i] = v;
end;

for i, v in v44 do
    v43[i] = v;
end;

u32.Knights = v43;
local v45 = {};
local v46 = {
    DisplayName = "The Catacombs",
    DisplayOrder = 4,
    Legacy = false,
    MaxNPCs = 14,
    InitialNPCs = 6,
    MaxPortals = 1,
    CashCost = 0,
    Difficulty = 4,
    Tier = 4,
    Theme = "INT",
    EquipTierThreshold = 20,
    OpenWorld = true,
    BiomeId = "Catacombs",
    LightingPreset = "Catacombs",
    MobsPerRoom = 10,
    TimeLimit = 300,
    LootChest = "EpicLootChest",
    LevelRange = {
        Min = 30,
        Max = 50
    },
    RequiresClear = {
        DungeonId = "Knights",
        Difficulty = "Hard"
    },
    DifficultyLevelBrackets = {
        Easy = {
            Min = 22,
            Max = 32
        },
        Normal = {
            Min = 27,
            Max = 37
        },
        Hard = {
            Min = 32,
            Max = 42
        },
        Nightmare = {
            Min = 38,
            Max = 48
        },
        Endless = {
            Min = 42,
            Max = 50
        }
    },
    EnemyPool = { "Bone Soldier", "Dark Acolyte", "Wraith", "Fallen Knight" },
    CombatRoomCount = {
        Min = 8,
        Max = 8
    },
    CombatRoomCountByDifficulty = {
        Easy = 6,
        Normal = 7,
        Hard = 7,
        Nightmare = 7
    },
    Rewards = {
        BaseCash = 80,
        BaseStars = 8,
        HyperCrystalChance = 0,
        BonusItems = {}
    },
    Boss = {
        HeroId = "Verath",
        Name = "Verath, The Lichborn",
        Scale = 1.7,
        Health = 30000,
        Damage = 67.5,
        Multiplier = 2,
        SpawnChance = nil,
        Collectable = true,
        HealthBars = nil
    },
    MiniBoss = {
        HeroId = "Dark Revenant",
        Name = "Dark Revenant",
        Scale = 1.5,
        Health = 12000,
        Damage = 57,
        BossDataKey = "Dark Revenant",
        GruntCount = 2
    },
    LootChestCount = { 1, 5 },
    LockedRooms = {
        Min = 2,
        Max = 4
    }
};

for i, v in u27 do
    v45[i] = v;
end;

for i, v in v46 do
    v45[i] = v;
end;

u32.Catacombs = v45;
local v47 = {};
local v48 = {
    DisplayName = "Frostspire Bastion",
    DisplayOrder = 5,
    Legacy = false,
    MaxNPCs = 14,
    InitialNPCs = 6,
    MaxPortals = 1,
    CashCost = 0,
    Difficulty = 5,
    Tier = 5,
    Theme = "STR",
    EquipTierThreshold = 20,
    OpenWorld = true,
    BiomeId = "Snow",
    LightingPreset = "Snow",
    MobsPerRoom = 10,
    TimeLimit = 300,
    LootChest = "LegendaryLootChest",
    LevelRange = {
        Min = 40,
        Max = 60
    },
    RequiresClear = {
        DungeonId = "Catacombs",
        Difficulty = "Hard"
    },
    DifficultyLevelBrackets = {
        Easy = {
            Min = 30,
            Max = 40
        },
        Normal = {
            Min = 35,
            Max = 45
        },
        Hard = {
            Min = 40,
            Max = 50
        },
        Nightmare = {
            Min = 45,
            Max = 55
        },
        Endless = {
            Min = 50,
            Max = 60
        }
    },
    EnemyPool = { "Viking", "Wayfarer", "Berserker Wayfarer", "Tribal Archer" },
    CombatRoomCount = {
        Min = 8,
        Max = 8
    },
    Rewards = {
        BaseCash = 120,
        BaseStars = 10,
        HyperCrystalChance = 0,
        BonusItems = {}
    },
    Boss = {
        HeroId = "Valkskar",
        Name = "Valkskar, The Frostborn Warlord",
        Scale = 1.8,
        Health = 52500,
        Damage = 90,
        Multiplier = 2.5,
        SpawnChance = nil,
        Collectable = true,
        HealthBars = 4
    },
    SpecialBoss = {
        HeroId = "Awakened Devil",
        Name = "Awakened Devil, The Azure Nightmare",
        Scale = 2,
        Health = 90000,
        Damage = 105,
        Multiplier = 3,
        SpawnChance = nil,
        Collectable = true,
        HealthBars = 6
    },
    SpecialBossRareDrop = {
        ItemId = "Devil Heart",
        Chance = 0.35,
        MinDifficulty = "Nightmare"
    },
    SpecialBossSummonCost = {
        KeyTier = 4,
        Amount = 7
    },
    MiniBoss = {
        HeroId = "Frost Warden",
        Name = "Frost Warden",
        Scale = 1.6,
        Health = 22500,
        Damage = 75,
        BossDataKey = "Frost Warden",
        GruntCount = 2
    },
    LootChestCount = { 1, 5 },
    LockedRooms = {
        Min = 2,
        Max = 4
    }
};

for i, v in u27 do
    v47[i] = v;
end;

for i, v in v48 do
    v47[i] = v;
end;

u32.Snow = v47;
local v49 = {};
local v50 = {
    DisplayName = "Underworld Gate",
    DisplayOrder = 6,
    Legacy = false,
    MaxNPCs = 18,
    InitialNPCs = 8,
    MaxPortals = 1,
    CashCost = 0,
    Difficulty = 6,
    Tier = 6,
    Theme = "VIT",
    EquipTierThreshold = 20,
    OpenWorld = true,
    BiomeId = "Demon",
    LightingPreset = "Demon",
    MobsPerRoom = 12,
    TimeLimit = 360,
    LootChest = "MythicLootChest",
    LevelRange = {
        Min = 60,
        Max = 100
    },
    RequiresClear = {
        DungeonId = "Snow",
        Difficulty = "Nightmare"
    },
    DifficultyLevelBrackets = {
        Easy = {
            Min = 60,
            Max = 70
        },
        Normal = {
            Min = 65,
            Max = 75
        },
        Hard = {
            Min = 72,
            Max = 82
        },
        Nightmare = {
            Min = 80,
            Max = 90
        },
        Endless = {
            Min = 90,
            Max = 100
        }
    },
    EnemyPool = { "Daemon", "Rogue Daemon", "Archer Daemon" },
    CombatRoomCount = {
        Min = 10,
        Max = 10
    },
    CombatRoomCountByDifficulty = {
        Easy = 7,
        Normal = 7,
        Hard = 8,
        Nightmare = 8
    },
    Rewards = {
        BaseCash = 180,
        BaseStars = 15,
        HyperCrystalChance = 0,
        BonusItems = {}
    },
    ClassItemRewards = { "Underworld Glaive" },
    Boss = {
        HeroId = "Underworld Gatekeeper",
        Name = "Underworld Gatekeeper, The Infernal Warden",
        Scale = 2.3,
        Health = 131250,
        Damage = 180,
        Multiplier = 3,
        SpawnChance = nil,
        Collectable = true,
        HealthBars = 6
    },
    SpecialBoss = {
        HeroId = "Scarlet Knight",
        Name = "Scarlet Knight, The Crimson Revenant",
        Scale = 1.9,
        Health = 150000,
        Damage = 220.5,
        Multiplier = 3,
        SpawnChance = nil,
        Collectable = true,
        HealthBars = 6
    },
    SpecialBossRareDrop = { {
            ItemId = "Exotic Shattered Armor",
            Chance = 0.08,
            MinDifficulty = "Nightmare"
        }, {
            ItemId = "Exotic Ore",
            Chance = 1,
            MinDifficulty = "Nightmare"
        } },
    SpecialBossSummonCost = {
        KeyTier = 5,
        Amount = 5
    },
    MiniBoss = {
        HeroId = "Black Fang",
        Name = "Black Fang",
        Scale = 1.5,
        Health = 52500,
        Damage = 142.5,
        BossDataKey = "Black Fang",
        GruntCount = 2
    },
    LootChestCount = { 1, 5 },
    LockedRooms = {
        Min = 2,
        Max = 4
    }
};

for i, v in u27 do
    v49[i] = v;
end;

for i, v in v50 do
    v49[i] = v;
end;

u32.Demon = v49;
local v51 = {};
local v52 = {
    DisplayName = "Double Dungeon",
    DisplayOrder = 0,
    ChallengeMode = true,
    ChallengeMap = "Double_Dungeon",
    Legacy = false,
    CashCost = 0,
    Difficulty = 5,
    MinLevel = 55,
    Theme = "DEX",
    EquipTierThreshold = 60,
    LightingPreset = "Double_Dungeon",
    RewardPreviewDungeon = "Snow",
    LevelRange = {
        Min = 55,
        Max = 100
    },
    EnemyPool = { "Fallen Knight", "Bone Soldier", "Wraith", "Dark Acolyte", "Dark Revenant" },
    Rewards = {
        BaseCash = 200,
        BaseStars = 20,
        HyperCrystalChance = 0,
        BonusItems = {}
    },
    Boss = v33,
    BossRotation = {
        v33,
        v34,
        v35,
        v36,
        v37,
        v38
    }
};

for i, v in u27 do
    v51[i] = v;
end;

for i, v in v52 do
    v51[i] = v;
end;

u32["Double Dungeon"] = v51;
local v53 = {};
local v54 = {
    DisplayName = "Throne Room",
    DisplayOrder = 1,
    ChallengeMode = true,
    ChallengeMap = "Throne_Room",
    Legacy = false,
    CashCost = 0,
    Difficulty = 5,
    MinLevel = 55,
    Locked = true,
    Theme = "STR",
    EquipTierThreshold = 60,
    LightingPreset = "Throne",
    RewardPreviewDungeon = "Snow",
    LevelRange = {
        Min = 55,
        Max = 100
    },
    EnemyPool = { "Knight", "Knight Archer", "Knight Champion", "Knight Rogue", "Strong Knight" },
    Rewards = {
        BaseCash = 220,
        BaseStars = 22,
        HyperCrystalChance = 0,
        BonusItems = {}
    },
    Boss = v34
};

for i, v in u27 do
    v53[i] = v;
end;

for i, v in v54 do
    v53[i] = v;
end;

u32["Throne Room"] = v53;
local v55 = {};
local v56 = {};
local u57 = {};

for i, v in u32 do
    if v.ChallengeMode then
        table.insert(v55, i);
    else
        table.insert(v56, i);

        if not v.Legacy then
            table.insert(u57, i);
        end;
    end;
end;

local function sortByOrder(p58, p59) -- Line: 618
    -- upvalues: u32 (copy)
    return u32[p58].DisplayOrder < u32[p59].DisplayOrder;
end;

table.sort(v56, sortByOrder);
table.sort(u57, sortByOrder);
table.sort(v55, sortByOrder);
local u60 = {};

local function IsChallengeMode(p61: string) -- Line: 639
    -- upvalues: u32 (copy)
    local v62 = u32[p61];

    if v62 then
        v62 = v62.ChallengeMode == true;
    end;

    return v62;
end;

local function CanEnter(p63: any, p64: string) -- Line: 646
    -- upvalues: u32 (copy)
    local v65 = u32[p64];

    if not v65 then
        return false, "Unknown dungeon";
    end;

    local Data = p63.Data;

    if v65.CashCost > 0 and not (Data.UnlockedDungeons or {})[p64] then
        return false, `Locked — costs {v65.CashCost} coins to unlock`;
    end;

    if not v65.BossKill or (Data.BossKills or {})[v65.BossKill] then
        if v65.RequiresClear then
            local RequiresClear = v65.RequiresClear;

            if not ((Data.DungeonModeClears or {})[RequiresClear.DungeonId] or {})[RequiresClear.Difficulty] then
                local v66 = u32[RequiresClear.DungeonId];

                return false, `Clear {v66 and v66.DisplayName or RequiresClear.DungeonId} on {RequiresClear.Difficulty} first`;
            end;
        end;

        return true, nil;
    end;

    local v67 = u32[v65.BossKill] and u32[v65.BossKill].Boss;

    return false, `Defeat {v67 and v67.Name or v65.BossKill} first`;
end;

local function GetDungeon(p68: string) -- Line: 625
    -- upvalues: u32 (copy)
    return u32[p68];
end;

local function GetBoss(p69: string) -- Line: 629
    -- upvalues: u32 (copy)
    local v70 = u32[p69];

    return v70 and v70.Boss or nil;
end;

local function IsLegacy(p71: string) -- Line: 634
    -- upvalues: u32 (copy)
    local v72 = u32[p71];

    if v72 then
        v72 = v72.Legacy ~= false;
    end;

    return v72;
end;

for i, v in u32 do
    if v.Tier and v.Tier > 0 then
        if not u60[v.Tier] then
            u60[v.Tier] = {};
        end;

        table.insert(u60[v.Tier], i);
    end;
end;

return {
    Dungeons = u32,
    DisplayOrder = v56,
    ChallengeDisplayOrder = u57,
    ChallengeModeDisplayOrder = v55,
    GetDungeon = GetDungeon,
    GetBoss = GetBoss,
    IsLegacy = IsLegacy,
    IsChallengeMode = IsChallengeMode,
    CanEnter = CanEnter,

    GetEstimatedRoomCount = function(p73: string, p74: string?) -- Line: 724, Name: GetEstimatedRoomCount
        -- upvalues: u32 (copy)
        local v75 = u32[p73];

        if not v75 then
            return nil;
        end;

        if v75.RoomsByDifficulty and (p74 and v75.RoomsByDifficulty[p74]) then
            local v76 = #v75.RoomsByDifficulty[p74];

            return {
                Min = v76,
                Max = v76
            };
        end;

        if v75.OpenWorld then
            if v75.CombatRoomCountByDifficulty and (p74 and v75.CombatRoomCountByDifficulty[p74]) then
                local v77 = v75.CombatRoomCountByDifficulty[p74] + 1;

                return {
                    Min = v77,
                    Max = v77
                };
            end;

            if v75.CombatRoomCount then
                local v78 = v75.CombatRoomCount.Min or 7;

                return {
                    Min = v78 + 1,
                    Max = (v75.CombatRoomCount.Max or v78) + 1
                };
            end;
        end;

        if not v75.Rooms then
            return nil;
        end;

        local v79 = #v75.Rooms;

        return {
            Min = v79,
            Max = v79
        };
    end,

    GetNextTierDungeons = function(p80: string) -- Line: 700, Name: GetNextTierDungeons
        -- upvalues: u32 (copy), u60 (copy)
        local v81 = u32[p80];

        if not (v81 and v81.Tier) then
            return nil;
        end;

        local v82 = u60[v81.Tier + 1];

        if v82 and #v82 ~= 0 then
            return v82;
        end;

        return nil;
    end,

    GetLocationFromDoorNumber = function(p83: number) -- Line: 709, Name: GetLocationFromDoorNumber
        -- upvalues: u57 (copy)
        return u57[p83];
    end,

    GetDoorNumberFromLocation = function(p84: string) -- Line: 714, Name: GetDoorNumberFromLocation
        -- upvalues: u57 (copy)
        for i, v in u57 do
            if v == p84 then
                return i;
            end;
        end;

        return nil;
    end
};