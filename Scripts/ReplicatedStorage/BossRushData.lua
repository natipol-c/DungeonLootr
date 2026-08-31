--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BossRushData
  Path:     game.ReplicatedStorage.GameInfo.BossRushData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    MAX_FLOORS = 100,
    MAX_PARTY_SIZE = 4,
    STARTING_LIVES = 3,
    INTERMISSION_TIME = 1.5,
    POTION_INTERVAL = 10,
    EXTRACT_INTERVAL = 10,
    POTION_REFILL_COUNT = 2,
    POTION_LIFETIME = 15,
    EXTRACT_LIFETIME = 60,
    SKIP_TICKET_ID = "BossRushSkipTicket",
    SKIP_STEP = 10,
    MIN_SKIP_FLOOR = 10,
    MAX_SKIP_FLOOR = 50,
    SKIP_TICKETS_PER_STEP = 5
};

function u1.GetSkipCost(p2: number) -- Line: 43
    -- upvalues: u1 (copy)
    if type(p2) ~= "number" then
        return 0;
    end;

    local math_floor_ret = math.floor(p2);

    return not u1.IsValidSkipFloor(math_floor_ret) and 0 or math_floor_ret / u1.SKIP_STEP * u1.SKIP_TICKETS_PER_STEP;
end;

function u1.IsValidSkipFloor(p3: number) -- Line: 52
    -- upvalues: u1 (copy)
    if type(p3) ~= "number" then
        return false;
    end;

    local math_floor_ret = math.floor(p3);

    if math_floor_ret < u1.MIN_SKIP_FLOOR or u1.MAX_SKIP_FLOOR < math_floor_ret then
        return false;
    end;

    return math_floor_ret % u1.SKIP_STEP == 0;
end;

u1.CHEST_INTERVAL = 10;
u1.CHEST_INTERMISSION_TIME = 8;
u1.CHEST_CANDIDATE_COUNT = 3;
u1.CHEST_NONGEAR_CHANCE = 0.35;
u1.CHEST_LEVEL_VARIANCE = 5;
u1.CHEST_MATERIAL_SHARE = 0.65;
u1.CHEST_FINAL_TIMEOUT = 45;
u1.PURITY_STONE_MIN_FLOOR = 40;
u1.PURITY_STONE_CHANCE = 0.05;
u1.CHEST_EQUIPMENT_TIERS = { {
        Dungeon = "Bandits Den",
        Weight = 30
    }, {
        Dungeon = "Goblins",
        Weight = 26
    }, {
        Dungeon = "Knights",
        Weight = 21
    }, {
        Dungeon = "Catacombs",
        Weight = 16
    }, {
        Dungeon = "Snow",
        Weight = 4.5
    }, {
        Dungeon = "Demon",
        Weight = 2.5
    } };
u1.CHEST_MATERIAL_TIERS = { {
        Id = "Iron Scrap",
        Rarity = "Common",
        Weight = 32,
        Min = 2,
        Max = 5
    }, {
        Id = "Iron Ore",
        Rarity = "Uncommon",
        Weight = 26,
        Min = 2,
        Max = 4
    }, {
        Id = "Gold Ore",
        Rarity = "Rare",
        Weight = 20,
        Min = 1,
        Max = 3
    }, {
        Id = "Obsidian Ore",
        Rarity = "Epic",
        Weight = 12,
        Min = 1,
        Max = 2
    }, {
        Id = "Infernal Ore",
        Rarity = "Legendary",
        Weight = 6,
        Min = 1,
        Max = 1
    }, {
        Id = "Radiant Ore",
        Rarity = "Mythic",
        Weight = 3,
        Min = 1,
        Max = 1
    }, {
        Id = "Celestial Ore",
        Rarity = "Celestial",
        Weight = 1.5,
        Min = 1,
        Max = 1
    }, {
        Id = "Epic Ingot",
        Rarity = "Epic",
        Weight = 2.5,
        Min = 1,
        Max = 1
    }, {
        Id = "Legendary Ingot",
        Rarity = "Legendary",
        Weight = 1.5,
        Min = 1,
        Max = 1
    } };
u1.BASE_HP = 120000;
u1.BASE_DAMAGE = 65;
u1.BASE_WALKSPEED = 16;
u1.HP_SCALE_RATE = 0.037;
u1.DAMAGE_SCALE_RATE = 0.035;
u1.PARTY_HP_SCALE = 0.42;
u1.TIER_REGULAR = {
    HPMult = 1,
    DamageMult = 1,
    SpeedMult = 1,
    Label = "Regular"
};
u1.TIER_EMPOWERED = {
    HPMult = 1.5,
    DamageMult = 1.3,
    SpeedMult = 1,
    Label = "Empowered"
};
u1.TIER_ENRAGED = {
    HPMult = 2.5,
    DamageMult = 1.8,
    SpeedMult = 1.25,
    Label = "Enraged"
};

function u1.GetFloorTier(p4: number) -- Line: 162
    -- upvalues: u1 (copy)
    if p4 % 10 == 0 then
        return u1.TIER_ENRAGED;
    end;

    if p4 % 5 == 0 then
        return u1.TIER_EMPOWERED;
    end;

    return u1.TIER_REGULAR;
end;

function u1.IsChestFloor(p5: number) -- Line: 174
    -- upvalues: u1 (copy)
    local v6;

    if p5 % u1.CHEST_INTERVAL == 0 then
        v6 = p5 < u1.MAX_FLOORS;
    else
        v6 = false;
    end;

    return v6;
end;

function u1.GetLootDifficulty(p7: number) -- Line: 180
    return p7 >= 61 and "Nightmare" or (p7 >= 31 and "Hard" or "Normal");
end;

function u1.GetLootCoinTier(p8: number) -- Line: 192
    local math_ceil_ret = math.ceil(p8 / 17);

    return math.clamp(math_ceil_ret, 1, 6);
end;

function u1.CalcBossStats(p9: number, p10: number) -- Line: 198
    -- upvalues: u1 (copy)
    local FloorTier = u1.GetFloorTier(p9);
    local v11 = u1.BASE_DAMAGE * (1 + u1.DAMAGE_SCALE_RATE * (p9 - 1)) * FloorTier.DamageMult;
    local v12 = u1.BASE_WALKSPEED * FloorTier.SpeedMult;
    local v13 = u1.BASE_HP * (1 + u1.HP_SCALE_RATE * (p9 - 1)) * FloorTier.HPMult * (1 + u1.PARTY_HP_SCALE * (math.max(1, p10) - 1));

    return {
        Health = math.floor(v13),
        Damage = math.floor(v11),
        WalkSpeed = v12,
        Tier = FloorTier
    };
end;

u1.ENRAGED_POOL = { "Karasu", "Shadow Monarch", "Awakened Devil", "Kieru", "Forge Archon", "Mimika" };
u1.EMPOWERED_POOL = { "Bandit Chief", "Goblin Chief", "Knight Lord", "Verath", "Valkskar", "Tenebris", "Miyu" };
u1.FIXED_FLOORS = {};
u1.FINAL_BOSSES = {
    ["Cursed King"] = {
        BossId = "Cursed King",
        DisplayName = "Cursed King",
        RewardItemId = "Cursed Shrine",
        PityFragmentId = "Cursed Fragment",
        DropTiers = { {
                Floor = 100,
                Chance = 0.03
            }, {
                Floor = 80,
                Chance = 0.015
            }, {
                Floor = 70,
                Chance = 0.01
            }, {
                Floor = 30,
                Chance = 0.005
            } }
    },
    Satori = {
        BossId = "Satori",
        DisplayName = "Satori, The Honored One",
        RewardItemId = "Infinity Core",
        PityFragmentId = "Infinity Fragment",
        DropTiers = { {
                Floor = 100,
                Chance = 0.03
            }, {
                Floor = 80,
                Chance = 0.015
            }, {
                Floor = 70,
                Chance = 0.01
            }, {
                Floor = 30,
                Chance = 0.005
            } },
        CosmeticDrops = { {
                PackageId = "SatoriPack",
                Chance = 0.1
            }, {
                PackageId = "SatoriRawPack",
                Chance = 0.03
            } }
    },
    ["Anti Mage"] = {
        BossId = "Anti Mage",
        DisplayName = "Anti Mage",
        RewardItemId = "Anti Magic Claymore",
        PityFragmentId = "Anti Magic Fragment",
        DropTiers = { {
                Floor = 100,
                Chance = 0.03
            }, {
                Floor = 80,
                Chance = 0.015
            }, {
                Floor = 70,
                Chance = 0.01
            }, {
                Floor = 30,
                Chance = 0.005
            } }
    },
    ["Great Mage"] = {
        BossId = "Great Mage",
        DisplayName = "Great Mage",
        RewardItemId = "Great Mage Staff",
        DropTiers = { {
                Floor = 100,
                Chance = 0.03
            }, {
                Floor = 80,
                Chance = 0.015
            }, {
                Floor = 70,
                Chance = 0.01
            }, {
                Floor = 30,
                Chance = 0.005
            } },
        CosmeticDrops = { {
                PackageId = "DivineWheelPack",
                Chance = 0.1
            } }
    }
};
u1.FINAL_BOSS_ORDER = { "Cursed King", "Satori", "Anti Mage", "Great Mage" };
u1.DEFAULT_FINAL_BOSS = u1.FINAL_BOSS_ORDER[1];
u1.PITY_FRAGMENT_MIN = 8;
u1.PITY_FRAGMENT_MAX = 18;
u1.PITY_FRAGMENT_CRAFT_COST = 50;

function u1.GetFinalBoss(p14: string?) -- Line: 369
    -- upvalues: u1 (copy)
    return p14 and u1.FINAL_BOSSES[p14] or nil;
end;

u1.BOSS_MAPS = {
    ["Great Mage"] = "Throne_Room",
    Satori = "Train",
    ["Cursed King"] = "Train",
    ["Anti Mage"] = "Legacy"
};
u1.DEFAULT_MAP = "Legacy";

function u1.GetMapForBoss(p15: string?) -- Line: 393
    -- upvalues: u1 (copy)
    return p15 and u1.BOSS_MAPS[p15] or u1.DEFAULT_MAP;
end;

u1.MAP_CONFIG = {
    Throne_Room = {
        LightingPreset = "Throne_Room"
    },
    Train = {
        LightingPreset = "Train"
    },
    Legacy = {
        LightingPreset = "Snow"
    }
};

function u1.GetMapLighting(p16: string?) -- Line: 409
    -- upvalues: u1 (copy)
    if p16 then
        p16 = u1.MAP_CONFIG[p16];
    end;

    return p16 and p16.LightingPreset or nil;
end;

u1.REGULAR_POOL = { "Bandit Chief", "Goblin Chief", "Knight Lord", "Verath", "Valkskar", "Ogge", "Broken Reality", "Bandit Enforcer", "Goblin Warchief", "Knight Champion", "Dark Revenant", "Frost Warden" };
u1.XP_REWARDS = {
    Regular = {
        PlayerXP = 30,
        ClassXP = 15
    },
    Empowered = {
        PlayerXP = 60,
        ClassXP = 30
    },
    Enraged = {
        PlayerXP = 120,
        ClassXP = 60
    },
    Complete = {
        PlayerXP = 5000,
        ClassXP = 2500
    }
};
u1.DROPS = {
    Regular = {
        ReforgeChance = 0.05,
        Materials = {}
    },
    Empowered = {
        ReforgeChance = 0.15,
        Materials = {}
    },
    Enraged = {
        ReforgeChance = 0.3,
        Materials = {}
    }
};
u1.MILESTONES = {
    {
        Floor = 5,
        Rewards = { {
                Type = "Currency",
                Amount = 5000
            } }
    },
    {
        Floor = 10,
        Rewards = { {
                Type = "Material",
                Id = "Iron Ore",
                Amount = 3
            } }
    },
    {
        Floor = 15,
        Rewards = { {
                Type = "NormalSpins",
                Amount = 20
            } }
    },
    {
        Floor = 20,
        Rewards = { {
                Type = "Stars",
                Amount = 50
            } }
    },
    {
        Floor = 25,
        Rewards = { {
                Type = "LuckySpins",
                Amount = 5
            } }
    },
    {
        Floor = 30,
        Rewards = { {
                Type = "Material",
                Id = "Rare Ingot",
                Amount = 2
            }, {
                Type = "NormalSpins",
                Amount = 25
            } }
    },
    {
        Floor = 35,
        Rewards = { {
                Type = "Currency",
                Amount = 20000
            }, {
                Type = "Stars",
                Amount = 60
            } }
    },
    {
        Floor = 40,
        Rewards = { {
                Type = "LuckySpins",
                Amount = 8
            }, {
                Type = "Material",
                Id = "Gold Ore",
                Amount = 3
            } }
    },
    {
        Floor = 45,
        Rewards = { {
                Type = "NormalSpins",
                Amount = 30
            }, {
                Type = "Stars",
                Amount = 75
            } }
    },
    {
        Floor = 50,
        Rewards = { {
                Type = "ReforgeStone",
                Amount = 1
            }, {
                Type = "Title",
                TitleId = "Boss_Slayer"
            } }
    },
    {
        Floor = 55,
        Rewards = { {
                Type = "Material",
                Id = "Epic Ingot",
                Amount = 2
            }, {
                Type = "LuckySpins",
                Amount = 10
            } }
    },
    {
        Floor = 60,
        Rewards = { {
                Type = "Currency",
                Amount = 50000
            }, {
                Type = "NormalSpins",
                Amount = 40
            } }
    },
    {
        Floor = 65,
        Rewards = { {
                Type = "Stars",
                Amount = 85
            }, {
                Type = "Material",
                Id = "Obsidian Ore",
                Amount = 2
            } }
    },
    {
        Floor = 70,
        Rewards = { {
                Type = "LuckySpins",
                Amount = 15
            }, {
                Type = "ReforgeStone",
                Amount = 2
            } }
    },
    {
        Floor = 75,
        Rewards = { {
                Type = "NormalSpins",
                Amount = 50
            }, {
                Type = "Stars",
                Amount = 100
            } }
    },
    {
        Floor = 80,
        Rewards = { {
                Type = "Material",
                Id = "Legendary Ingot",
                Amount = 2
            }, {
                Type = "LuckySpins",
                Amount = 20
            }, {
                Type = "Currency",
                Amount = 70000
            } }
    },
    {
        Floor = 85,
        Rewards = { {
                Type = "ReforgeStone",
                Amount = 3
            }, {
                Type = "NormalSpins",
                Amount = 50
            }, {
                Type = "Stars",
                Amount = 100
            } }
    },
    {
        Floor = 90,
        Rewards = { {
                Type = "Material",
                Id = "Mythic Ingot",
                Amount = 2
            }, {
                Type = "LuckySpins",
                Amount = 25
            }, {
                Type = "Currency",
                Amount = 95000
            } }
    },
    {
        Floor = 95,
        Rewards = { {
                Type = "ReforgeStone",
                Amount = 5
            }, {
                Type = "Title",
                TitleId = "Floor_Master"
            }, {
                Type = "LuckySpins",
                Amount = 30
            } }
    },
    {
        Floor = 100,
        Rewards = { {
                Type = "Package",
                Id = "VesselPack"
            } }
    }
};
u1._floorToMilestone = {};

for i, v in u1.MILESTONES do
    u1._floorToMilestone[v.Floor] = i;
end;

function u1.GetMilestoneForFloor(p17: number) -- Line: 564
    -- upvalues: u1 (copy)
    return u1._floorToMilestone[p17];
end;

function u1.GetUnlockedMilestones(p18: number) -- Line: 569
    -- upvalues: u1 (copy)
    local v19 = {};

    for i, v in u1.MILESTONES do
        if v.Floor <= p18 then
            table.insert(v19, i);
        end;
    end;

    return v19;
end;

u1.CURRENT_SEASON = 1;
u1.UNLOCK_LEVEL = 67;

function u1.CanEnter(p20: table) -- Line: 594
    -- upvalues: u1 (copy)
    local Data = p20.Data;

    if not Data then
        return false, "Data not loaded";
    end;

    if (Data.PlayerLevel or 0) >= u1.UNLOCK_LEVEL then
        return true, nil;
    end;

    return false, "Reach Player Level " .. u1.UNLOCK_LEVEL .. " to unlock Boss Rush";
end;

u1.SHOWCASE_REWARDS = {
    Coins = 5000,
    EXP = 5000,
    Items = { {
            Type = "ClassItem",
            Id = "Cursed Shrine",
            Amount = 1
        }, {
            Type = "ClassItem",
            Id = "Infinity Core",
            Amount = 1
        }, {
            Type = "ClassItem",
            Id = "Anti Magic Claymore",
            Amount = 1
        }, {
            Type = "Package",
            Id = "SatoriPack",
            Amount = 1
        }, {
            Type = "Package",
            Id = "SatoriRawPack",
            Amount = 1
        }, {
            Type = "Package",
            Id = "DivineWheelPack",
            Amount = 1
        }, {
            Type = "Material",
            Id = "Celestial Ingot",
            Amount = 1
        }, {
            Type = "Material",
            Id = "Mythic Ingot",
            Amount = 2
        }, {
            Type = "Material",
            Id = "Legendary Ingot",
            Amount = 3
        }, {
            Type = "Material",
            Id = "Epic Ingot",
            Amount = 5
        } }
};

return u1;