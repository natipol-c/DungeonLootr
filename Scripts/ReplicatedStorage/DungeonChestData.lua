--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DungeonChestData
  Path:     game.ReplicatedStorage.GameInfo.DungeonChestData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RarityData = require(ReplicatedStorage.GameInfo.RarityData);
local u1 = {
    SPAWN_ROLL = {
        Chest = 0.55,
        Book = 0
    },
    FIRST_CHEST_CHANCE = 0.7,
    SECOND_CHEST_CHANCE = 0.1,
    BOSS_ROOM_GUARANTEED = true,
    BOOK_TIERS = {
        Low = {
            Model = "Low_EXP_Book",
            XPPercent = 3,
            DisplayName = "Faded Tome"
        },
        Mid = {
            Model = "Mid_EXP_Book",
            XPPercent = 8,
            DisplayName = "Arcane Tome"
        },
        High = {
            Model = "High_EXP_Book",
            XPPercent = 15,
            DisplayName = "Radiant Tome"
        }
    },
    BOOK_XP_OVERLEVEL_FALLOFF_PER_LEVEL = 0.05,
    BOOK_XP_OVERLEVEL_FLOOR_MULT = 0.2
};

function u1.GetScaledBookXPPercent(p2: number, p3: number, p4: number?) -- Line: 110
    -- upvalues: u1 (copy)
    if not p2 or p2 <= 0 then
        return 0;
    end;

    if not (p3 and p4) then
        return p2;
    end;

    if p3 <= p4 then
        return p2;
    end;

    return p2 * math.max(1 - (p3 - p4) * u1.BOOK_XP_OVERLEVEL_FALLOFF_PER_LEVEL, u1.BOOK_XP_OVERLEVEL_FLOOR_MULT);
end;

u1.CLASS_XP_TOME_BASE_MULT = 1.2;
u1.CLASS_XP_TOME_PER_PRESTIGE = 0.2;

function u1.GetClassTomeMultiplier(p5: number?) -- Line: 160
    -- upvalues: u1 (copy)
    return u1.CLASS_XP_TOME_BASE_MULT + (p5 or 0) * u1.CLASS_XP_TOME_PER_PRESTIGE;
end;

u1.BOOK_TIER_WEIGHTS = {
    Easy = {
        Low = 75,
        Mid = 20,
        High = 5
    },
    Normal = {
        Low = 65,
        Mid = 28,
        High = 7
    },
    Hard = {
        Low = 50,
        Mid = 35,
        High = 15
    },
    Nightmare = {
        Low = 35,
        Mid = 40,
        High = 25
    },
    Endless = {
        Low = 40,
        Mid = 38,
        High = 22
    }
};

function u1.RollBookTier(p6: string) -- Line: 197
    -- upvalues: u1 (copy)
    local v7 = u1.BOOK_TIER_WEIGHTS[p6] or u1.BOOK_TIER_WEIGHTS.Easy;
    local v8 = 0;

    for _, v in v7 do
        v8 = v8 + v;
    end;

    local v9 = math.random() * v8;
    local v10 = 0;

    for i, v in v7 do
        v10 = v10 + v;

        if v9 <= v10 then
            return i;
        end;
    end;

    return "Low";
end;

u1.LOCKED_ROOM_BOOK_TIER_WEIGHTS = { {
        Low = 85,
        Mid = 15,
        High = 0
    }, {
        Low = 60,
        Mid = 35,
        High = 5
    }, {
        Low = 25,
        Mid = 50,
        High = 25
    }, {
        Low = 5,
        Mid = 45,
        High = 50
    }, {
        Low = 0,
        Mid = 25,
        High = 75
    } };

function u1.RollLockedRoomBookTier(p11: number) -- Line: 233
    -- upvalues: u1 (copy)
    local v12 = u1.LOCKED_ROOM_BOOK_TIER_WEIGHTS[p11] or u1.LOCKED_ROOM_BOOK_TIER_WEIGHTS[1];
    local v13 = 0;

    for _, v in v12 do
        v13 = v13 + v;
    end;

    local v14 = math.random() * v13;
    local v15 = 0;

    for i, v in v12 do
        v15 = v15 + v;

        if v14 <= v15 then
            return i;
        end;
    end;

    return "Low";
end;

u1.DungeonRarityRange = {
    ["Bandits Den"] = {
        Floor = "Common",
        Ceiling = "Uncommon"
    },
    ["Forest Challenge"] = {
        Floor = "Common",
        Ceiling = "Uncommon"
    },
    Goblins = {
        Floor = "Uncommon",
        Ceiling = "Rare"
    },
    Knights = {
        Floor = "Uncommon",
        Ceiling = "Epic"
    },
    Catacombs = {
        Floor = "Rare",
        Ceiling = "Epic"
    },
    Snow = {
        Floor = "Epic",
        Ceiling = "Legendary"
    },
    Demon = {
        Floor = "Legendary",
        Ceiling = "Mythic"
    },
    ["Taiga Challenge"] = {
        Floor = "Uncommon",
        Ceiling = "Rare"
    },
    ["Desert Challenge"] = {
        Floor = "Rare",
        Ceiling = "Epic"
    },
    ["Obsidian Challenge"] = {
        Floor = "Epic",
        Ceiling = "Legendary"
    },
    ["Lava Challenge"] = {
        Floor = "Legendary",
        Ceiling = "Mythic"
    },
    ["Frostmire Challenge"] = {
        Floor = "Legendary",
        Ceiling = "Mythic"
    },
    Ultimate = {
        Floor = "Mythic",
        Ceiling = "Celestial"
    },
    ["Double Dungeon"] = {
        Floor = "Epic",
        Ceiling = "Legendary"
    },
    ["Throne Room"] = {
        Floor = "Epic",
        Ceiling = "Legendary"
    }
};
u1.DifficultyModifiers = {
    Easy = {
        FloorShift = 0,
        CeilingShift = 0
    },
    Normal = {
        FloorShift = 0,
        CeilingShift = 1
    },
    Hard = {
        FloorShift = 1,
        CeilingShift = 2
    },
    Nightmare = {
        FloorShift = 2,
        CeilingShift = 3
    },
    Endless = {
        FloorShift = 2,
        CeilingShift = 2
    }
};
local u16 = {
    [RarityData.RarityOrder[1]] = 1,
    [RarityData.RarityOrder[2]] = 2,
    [RarityData.RarityOrder[3]] = 3,
    [RarityData.RarityOrder[4]] = 4,
    [RarityData.RarityOrder[5]] = 5,
    [RarityData.RarityOrder[6]] = 6,
    [RarityData.RarityOrder[7]] = 7
};
u1.RARITY_INDEX = u16;
u1.MAX_RARITY_INDEX = 7;

function u1.GetEffectiveRange(p17: string, p18: string) -- Line: 313
    -- upvalues: u1 (copy), u16 (copy), RarityData (copy)
    local v19 = u1.DungeonRarityRange[p17];

    if not v19 then
        return nil;
    end;

    local v20 = u1.DifficultyModifiers[p18] or u1.DifficultyModifiers.Easy;
    local v21 = u16[v19.Ceiling] or 1;
    local math_clamp_ret = math.clamp((u16[v19.Floor] or 1) + v20.FloorShift, 1, 7);
    local math_clamp_ret2 = math.clamp(v21 + v20.CeilingShift, 1, 7);

    if math_clamp_ret2 < math_clamp_ret then
        math_clamp_ret = math_clamp_ret2;
    end;

    return {
        Floor = RarityData.RarityOrder[math_clamp_ret],
        Ceiling = RarityData.RarityOrder[math_clamp_ret2],
        FloorIndex = math_clamp_ret,
        CeilingIndex = math_clamp_ret2
    };
end;

u1.RARITY_TO_MODEL = {
    Common = "Common_Chest",
    Uncommon = "Uncommon_Chest",
    Rare = "Rare_Chest",
    Epic = "Epic_Chest",
    Legendary = "Legendary_Chest",
    Mythic = "Mythic_Chest",
    Celestial = "Celestial_Chest"
};
u1.REWARD_WEIGHTS_BY_RARITY = {
    Common = { {
            Type = "Gear",
            Weight = 40
        }, {
            Type = "Coins",
            Weight = 28
        }, {
            Type = "PotionRefill",
            Weight = 18
        }, {
            Type = "Stars",
            Weight = 14
        } },
    Uncommon = { {
            Type = "Gear",
            Weight = 50
        }, {
            Type = "Coins",
            Weight = 22
        }, {
            Type = "PotionRefill",
            Weight = 15
        }, {
            Type = "Stars",
            Weight = 13
        } },
    Rare = { {
            Type = "Gear",
            Weight = 80
        }, {
            Type = "Coins",
            Weight = 6
        }, {
            Type = "PotionRefill",
            Weight = 8
        }, {
            Type = "Stars",
            Weight = 6
        } },
    Epic = { {
            Type = "Gear",
            Weight = 100
        } },
    Legendary = { {
            Type = "Gear",
            Weight = 100
        } },
    Mythic = { {
            Type = "Gear",
            Weight = 100
        } },
    Celestial = { {
            Type = "Gear",
            Weight = 100
        } }
};

function u1.GetRewardWeights(p22: string) -- Line: 389
    -- upvalues: u1 (copy)
    return u1.REWARD_WEIGHTS_BY_RARITY[p22] or u1.REWARD_WEIGHTS_BY_RARITY.Common;
end;

u1.COIN_RANGES = { { 40, 80 }, { 55, 110 }, { 100, 200 }, { 250, 500 }, { 600, 1200 }, { 1500, 3000 } };
u1.COIN_DIFFICULTY_MULT = {
    Easy = 1,
    Normal = 1.35,
    Hard = 1.6,
    Nightmare = 1.95,
    Endless = 2
};

function u1.GetCoinMult(p23: string?) -- Line: 422
    -- upvalues: u1 (copy)
    return u1.COIN_DIFFICULTY_MULT[p23 or "Easy"] or 1;
end;

u1.STAR_RANGES = { { 1, 2 }, { 1, 3 }, { 2, 4 }, { 2, 5 }, { 3, 5 }, { 4, 7 } };
u1.ENDLESS_STAR_RANGES = { { 8, 15 }, { 12, 22 }, { 18, 32 }, { 28, 45 }, { 40, 65 }, { 60, 100 } };
u1.ENDLESS_STAR_PULL_CAP = 400;
u1.REFORGE_STONE_BONUS = {
    MinKeyTier = 3,
    MinRarityIndex = 6,
    ChanceByKeyTier = {
        [3] = 0.25,
        [4] = 0.4,
        [5] = 0.6
    }
};
u1.RAW_UPGRADE_MATERIAL_CHANCE = 0.07;
u1.CHALLENGE_SKIP_TICKET_CHANCE = 0.25;
u1.GEAR_DROP_CHANCE = 0.15;
u1.PROTECTION_SCROLL_CHALLENGE = {
    MinWave = 30,
    ChanceByRarity = {
        Uncommon = 0.02,
        Rare = 0.05,
        Epic = 0.055,
        Legendary = 0.085,
        Mythic = 0.15,
        Celestial = 0.35
    }
};

function u1.GetProtectionScrollChance(p24: string?) -- Line: 525
    -- upvalues: u1 (copy)
    return p24 and u1.PROTECTION_SCROLL_CHALLENGE.ChanceByRarity[p24] or 0;
end;

function u1.RollRewardType(p25: table) -- Line: 534
    local v26 = 0;

    for _, v in p25 do
        v26 = v26 + v.Weight;
    end;

    local v27 = math.random() * v26;
    local v28 = 0;

    for _, v in p25 do
        v28 = v28 + v.Weight;

        if v27 <= v28 then
            return v.Type;
        end;
    end;

    return p25[#p25].Type;
end;

return u1;