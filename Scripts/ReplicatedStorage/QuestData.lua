--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     QuestData
  Path:     game.ReplicatedStorage.GameInfo.QuestData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Class_Data = require(ReplicatedStorage.Classes.Class_Data);
local RarityData = require(ReplicatedStorage.GameInfo.RarityData);
local Celestial = RarityData.RarityIndex.Celestial;

local function isClassQuestEligible(p1: string) -- Line: 45
    -- upvalues: Class_Data (copy), RarityData (copy), Celestial (copy)
    local Rarity = Class_Data.GetRarity(p1);

    return (Rarity and RarityData.RarityIndex[Rarity] or 0) <= Celestial;
end;

local u2 = {
    Categories = {
        Daily = {
            Slots = 6,
            Interval = 86400
        },
        Weekly = {
            Slots = 5,
            Interval = 604800
        }
    },
    CategoryOrder = { "Daily", "Weekly" },
    Dungeons = { {
            Id = "Bandits Den",
            Name = "Bandit\'s Den",
            Boss = "Bandit Chief",
            Tier = 1
        }, {
            Id = "Goblins",
            Name = "Goblin\'s Stronghold",
            Boss = "Goblin Chief",
            Tier = 2
        }, {
            Id = "Knights",
            Name = "Forgotten Ruins",
            Boss = "Knight Lord",
            Tier = 3
        }, {
            Id = "Catacombs",
            Name = "The Catacombs",
            Boss = "Verath",
            Tier = 4
        }, {
            Id = "Snow",
            Name = "Frostspire Bastion",
            Boss = "Valkskar",
            Tier = 5
        }, {
            Id = "Demon",
            Name = "Underworld Gate",
            Boss = "Underworld Gatekeeper",
            Tier = 6
        } },
    ObjectiveType = {
        KillNPCs = "KillNPCs",
        KillEnemy = "KillEnemy",
        KillInDungeon = "KillInDungeon",
        CompleteDifficulty = "CompleteDifficulty",
        IdentifyEquipment = "IdentifyEquipment",
        SellItems = "SellItems",
        CompleteDungeon = "CompleteDungeon",
        KillBoss = "KillBoss",
        SpendCoins = "SpendCoins",
        EarnCoins = "EarnCoins",
        ForgeEquipment = "ForgeEquipment",
        LootChests = "LootChests",
        CompleteDungeonUnderTime = "CompleteDungeonUnderTime",
        CompleteWithClass = "CompleteWithClass"
    },
    RewardType = {
        Currency = "Currency",
        Stars = "Stars",
        NormalSpins = "NormalSpins",
        LuckySpins = "LuckySpins",
        Equipment = "Equipment"
    },
    DailyPool = {},
    WeeklyPool = {}
};

local function addQuest(p3) -- Line: 137
    -- upvalues: u2 (copy)
    if p3.Category == "Weekly" then
        table.insert(u2.WeeklyPool, p3);

        return;
    end;

    table.insert(u2.DailyPool, p3);
end;

local function bumpDifficulty(p4: string) -- Line: 146
    return p4 == "Easy" and "Medium" or "Hard";
end;

for _, v in ipairs(u2.Dungeons) do
    local v5 = v.Tier <= 2 and 3 or 2;
    local v6 = math.ceil(v.Tier / 2) + 1;
    local v7 = v.Tier <= 3 and "Medium" or "Hard";
    local v8 = {
        Kind = "Boss",
        Category = "Daily",
        Name = "Bounty Board",
        ObjectiveType = "KillBoss",
        Id = `d_boss_{v.Id}`,
        Objective = `Defeat {v.Boss} {v5} Times`,
        ObjectiveParams = {
            LocationId = v.Id
        },
        Target = v5,
        Reward = {
            Type = "NormalSpins",
            Amount = v6
        },
        Difficulty = v7,
        RequiresDungeon = v.Id
    };

    if v8.Category == "Weekly" then
        table.insert(u2.WeeklyPool, v8);
    else
        table.insert(u2.DailyPool, v8);
    end;

    local v9 = {
        Kind = "Boss",
        Category = "Weekly",
        Name = "Grand Bounty",
        ObjectiveType = "KillBoss",
        Id = `w_boss_{v.Id}`,
        Objective = `Defeat {v.Boss} {v5 * 3} Times`,
        ObjectiveParams = {
            LocationId = v.Id
        },
        Target = v5 * 3,
        Reward = {
            Type = "LuckySpins",
            Amount = v6 * 3
        },
        Difficulty = v7 == "Easy" and "Medium" or "Hard",
        RequiresDungeon = v.Id
    };

    if v9.Category == "Weekly" then
        table.insert(u2.WeeklyPool, v9);
    else
        table.insert(u2.DailyPool, v9);
    end;
end;

local v10 = {
    Id = "d_spend_5000",
    Kind = "Spend",
    Category = "Daily",
    Name = "Big Spender",
    Objective = "Spend 5,000 Coins",
    ObjectiveType = "SpendCoins",
    Target = 5000,
    Difficulty = "Easy",
    Reward = {
        Type = "Currency",
        Amount = 5500
    }
};

if v10.Category == "Weekly" then
    table.insert(u2.WeeklyPool, v10);
else
    table.insert(u2.DailyPool, v10);
end;

local v11 = {
    Id = "w_spend_15000",
    Kind = "Spend",
    Category = "Weekly",
    Name = "High Roller",
    Objective = "Spend 15,000 Coins",
    ObjectiveType = "SpendCoins",
    Target = 15000,
    Difficulty = "Medium",
    Reward = {
        Type = "Currency",
        Amount = 16500
    }
};

if v11.Category == "Weekly" then
    table.insert(u2.WeeklyPool, v11);
else
    table.insert(u2.DailyPool, v11);
end;

local v12 = {
    Id = "d_earn_10000",
    Kind = "Earn",
    Category = "Daily",
    Name = "Treasure Hoard",
    Objective = "Earn 10,000 Coins",
    ObjectiveType = "EarnCoins",
    Target = 10000,
    Difficulty = "Medium",
    Reward = {
        Type = "Stars",
        Amount = 30
    }
};

if v12.Category == "Weekly" then
    table.insert(u2.WeeklyPool, v12);
else
    table.insert(u2.DailyPool, v12);
end;

local v13 = {
    Id = "w_earn_30000",
    Kind = "Earn",
    Category = "Weekly",
    Name = "Dragon\'s Hoard",
    Objective = "Earn 30,000 Coins",
    ObjectiveType = "EarnCoins",
    Target = 30000,
    Difficulty = "Hard",
    Reward = {
        Type = "Stars",
        Amount = 300
    }
};

if v13.Category == "Weekly" then
    table.insert(u2.WeeklyPool, v13);
else
    table.insert(u2.DailyPool, v13);
end;

local v14 = { 4, 4, 3, 3, 2, 2 };
local v15 = { 500, 750, 1000, 1250, 1500, 2000 };

for _, v in ipairs(u2.Dungeons) do
    local v16 = v14[v.Tier];
    local v17 = v15[v.Tier];
    local v18 = v.Tier <= 2 and "Easy" or (v.Tier <= 4 and "Medium" or "Hard");
    local v19 = {
        Kind = "Clear",
        Category = "Daily",
        ObjectiveType = "CompleteDungeon",
        Id = `d_clear_{v.Id}`,
        Name = `{v.Name} Patrol`,
        Objective = `Complete {v.Name} {v16} Times`,
        ObjectiveParams = {
            LocationId = v.Id
        },
        Target = v16,
        Reward = {
            Type = "Currency",
            Amount = v17
        },
        Difficulty = v18,
        RequiresDungeon = v.Id
    };

    if v19.Category == "Weekly" then
        table.insert(u2.WeeklyPool, v19);
    else
        table.insert(u2.DailyPool, v19);
    end;

    local v20 = {
        Kind = "Clear",
        Category = "Weekly",
        ObjectiveType = "CompleteDungeon",
        Id = `w_clear_{v.Id}`,
        Name = `{v.Name} Campaign`,
        Objective = `Complete {v.Name} {v16 * 3} Times`,
        ObjectiveParams = {
            LocationId = v.Id
        },
        Target = v16 * 3,
        Reward = {
            Type = "Currency",
            Amount = v17 * 3 * 3
        },
        Difficulty = v18 == "Easy" and "Medium" or "Hard",
        RequiresDungeon = v.Id
    };

    if v20.Category == "Weekly" then
        table.insert(u2.WeeklyPool, v20);
    else
        table.insert(u2.DailyPool, v20);
    end;
end;

local v21 = {
    Id = "d_forge_4",
    Kind = "Forge",
    Category = "Daily",
    Name = "Smith\'s Order",
    Objective = "Forge Equipment 4 Times",
    ObjectiveType = "ForgeEquipment",
    Target = 4,
    Difficulty = "Easy",
    Reward = {
        Type = "Currency",
        Amount = 1000
    }
};

if v21.Category == "Weekly" then
    table.insert(u2.WeeklyPool, v21);
else
    table.insert(u2.DailyPool, v21);
end;

local v22 = {
    Id = "w_forge_12",
    Kind = "Forge",
    Category = "Weekly",
    Name = "Forge Contract",
    Objective = "Forge Equipment 12 Times",
    ObjectiveType = "ForgeEquipment",
    Target = 12,
    Difficulty = "Medium",
    Reward = {
        Type = "Currency",
        Amount = 15000
    }
};

if v22.Category == "Weekly" then
    table.insert(u2.WeeklyPool, v22);
else
    table.insert(u2.DailyPool, v22);
end;

local v23 = {
    Id = "d_chests_15",
    Kind = "Chests",
    Category = "Daily",
    Name = "Chest Hunter",
    Objective = "Loot 15 Chests",
    ObjectiveType = "LootChests",
    Target = 15,
    Difficulty = "Medium",
    Reward = {
        Type = "NormalSpins",
        Amount = 3
    }
};

if v23.Category == "Weekly" then
    table.insert(u2.WeeklyPool, v23);
else
    table.insert(u2.DailyPool, v23);
end;

local v24 = {
    Id = "w_chests_45",
    Kind = "Chests",
    Category = "Weekly",
    Name = "Master Looter",
    Objective = "Loot 45 Chests",
    ObjectiveType = "LootChests",
    Target = 45,
    Difficulty = "Hard",
    Reward = {
        Type = "LuckySpins",
        Amount = 9
    }
};

if v24.Category == "Weekly" then
    table.insert(u2.WeeklyPool, v24);
else
    table.insert(u2.DailyPool, v24);
end;

for _, v in ipairs(u2.Dungeons) do
    local v25 = v;

    for _, v2 in { "Normal", "Hard" } do
        local v26 = {
            Kind = "Speed",
            Category = "Daily",
            Name = "Speedrunner",
            ObjectiveType = "CompleteDungeonUnderTime",
            Target = 1,
            MaxTime = 240,
            Difficulty = "Hard",
            Id = `d_speed_{v25.Id}_{v2}`,
            Objective = `Beat {v25.Name} on {v2} in Under 4:00`,
            ObjectiveParams = {
                LocationId = v25.Id,
                Difficulty = v2
            },
            Reward = {
                Type = "LuckySpins",
                Amount = 2
            },
            RequiresDungeon = v25.Id
        };

        if v26.Category == "Weekly" then
            table.insert(u2.WeeklyPool, v26);
        else
            table.insert(u2.DailyPool, v26);
        end;

        local v27 = {
            Kind = "Speed",
            Category = "Weekly",
            Name = "Master Speedrunner",
            ObjectiveType = "CompleteDungeonUnderTime",
            Target = 3,
            MaxTime = 240,
            Difficulty = "Hard",
            Id = `w_speed_{v25.Id}_{v2}`,
            Objective = `Beat {v25.Name} on {v2} in Under 4:00, 3 Times`,
            ObjectiveParams = {
                LocationId = v25.Id,
                Difficulty = v2
            },
            Reward = {
                Type = "LuckySpins",
                Amount = 15
            },
            RequiresDungeon = v25.Id
        };

        if v27.Category == "Weekly" then
            table.insert(u2.WeeklyPool, v27);
        else
            table.insert(u2.DailyPool, v27);
        end;
    end;
end;

for _, v in ipairs(Class_Data.GetAllClassNames()) do
    local Rarity = Class_Data.GetRarity(v);

    if (Rarity and (RarityData.RarityIndex[Rarity] or 0) or 0) <= Celestial then
        local v28 = {
            Kind = "Class",
            Category = "Daily",
            ObjectiveType = "CompleteWithClass",
            Target = 3,
            Difficulty = "Hard",
            Id = `d_class_{v}`,
            Name = `Way of the {v}`,
            Objective = `Complete 3 Dungeons using {v}`,
            ObjectiveParams = {
                ClassName = v
            },
            Reward = {
                Type = "NormalSpins",
                Amount = 3
            },
            RequiresClass = v
        };

        if v28.Category == "Weekly" then
            table.insert(u2.WeeklyPool, v28);
        else
            table.insert(u2.DailyPool, v28);
        end;

        local v29 = {
            Kind = "Class",
            Category = "Weekly",
            ObjectiveType = "CompleteWithClass",
            Target = 9,
            Difficulty = "Hard",
            Id = `w_class_{v}`,
            Name = `{v} Devotion`,
            Objective = `Complete 9 Dungeons using {v}`,
            ObjectiveParams = {
                ClassName = v
            },
            Reward = {
                Type = "LuckySpins",
                Amount = 9
            },
            RequiresClass = v
        };

        if v29.Category == "Weekly" then
            table.insert(u2.WeeklyPool, v29);
        else
            table.insert(u2.DailyPool, v29);
        end;
    end;
end;

u2._poolById = {};

for _, v in { u2.DailyPool, u2.WeeklyPool } do
    for _, v2 in ipairs(v) do
        local v30 = not u2._poolById[v2.Id];
        local v31 = `Duplicate quest Id: {v2.Id}`;
        assert(v30, v31);
        u2._poolById[v2.Id] = v2;
    end;
end;

function u2.GetQuestById(p32: string) -- Line: 368
    -- upvalues: u2 (copy)
    return u2._poolById[p32];
end;

function u2.GetPool(p33: string) -- Line: 372
    -- upvalues: u2 (copy)
    return p33 == "Weekly" and u2.WeeklyPool or u2.DailyPool;
end;

function u2.GetWindowIndex(p34: string) -- Line: 378
    -- upvalues: u2 (copy)
    local v35 = u2.Categories[p34];
    local v36 = DateTime.now().UnixTimestamp / v35.Interval;

    return math.floor(v36);
end;

function u2.SecondsUntilNextWindow(p37: string) -- Line: 385
    -- upvalues: u2 (copy)
    local v38 = u2.Categories[p37];
    local UnixTimestamp = DateTime.now().UnixTimestamp;

    return v38.Interval - UnixTimestamp % v38.Interval;
end;

function u2.GetRewardDisplayText(p39: table) -- Line: 392
    if p39.Type == "Currency" then
        return `{p39.Amount} Coins`;
    end;

    if p39.Type == "Stars" then
        return `{p39.Amount} Stars`;
    end;

    if p39.Type == "NormalSpins" then
        local v40 = p39.Amount or 1;

        return `{v40}x Normal Spin{v40 > 1 and "s" or ""}`;
    end;

    if p39.Type ~= "LuckySpins" then
        return p39.Type ~= "Equipment" and "???" or `{p39.Rarity or "Common"} Equipment`;
    end;

    local v41 = p39.Amount or 1;

    return `{v41}x Lucky Spin{v41 > 1 and "s" or ""}`;
end;

return u2;