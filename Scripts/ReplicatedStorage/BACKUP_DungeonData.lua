--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BACKUP_DungeonData
  Path:     game.ReplicatedStorage.GameInfo.BACKUP_DungeonData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

require(game:GetService("ReplicatedStorage").GameInfo.RarityData);
local u1 = {
    Legacy = true,
    MaxNPCs = 10,
    SpawnInterval = 5,
    MaxPortals = 2,
    InitialNPCs = 5,
    PvpEnabled = false,
    RarityOverrides = nil,
    Requirements = nil,
    Boss = nil,
    SpawnPools = nil,
    TimeLimit = 180,
    FailRewardMultiplier = 0,
    Rewards = nil,
    BossRespawnTime = 60
};

local function entry(p2) -- Line: 75
    -- upvalues: u1 (copy)
    local v3 = {};

    for i, v in u1 do
        v3[i] = v;
    end;

    for i, v in p2 do
        v3[i] = v;
    end;

    return v3;
end;

local v4 = {};
local v5 = {
    DisplayName = "Training Grounds",
    DisplayOrder = 1,
    Legacy = true,
    PvpEnabled = false,
    MaxNPCs = 10,
    InitialNPCs = 5,
    SpawnInterval = 5,
    MaxPortals = 2,
    Requirements = nil,
    Boss = nil
};
local u6 = {};

for i, v in u1 do
    v4[i] = v;
end;

for i, v in v5 do
    v4[i] = v;
end;

u6.Small = v4;
local v7 = {};
local v8 = {
    DisplayName = "The Wilds",
    DisplayOrder = 2,
    Legacy = true,
    PvpEnabled = true,
    MaxNPCs = 15,
    InitialNPCs = 8,
    SpawnInterval = 5,
    MaxPortals = 2,
    Requirements = {
        RebirthLevel = 0,
        BossKill = nil
    },
    RarityOverrides = {
        Common = 0.02,
        Uncommon = 0.025,
        Rare = 0.03333333333333333,
        Epic = 0.013333333333333334,
        Legendary = 0.002,
        Mythic = 0.0002,
        Cosmic = 0.00004
    },
    Boss = {
        HeroId = "Bastion",
        Name = "Bastion, The Flame Brazier",
        Scale = 1.5,
        Health = 3000,
        Damage = 30,
        Multiplier = 2.5,
        SpawnChance = 0.02,
        Collectable = true
    }
};

for i, v in u1 do
    v7[i] = v;
end;

for i, v in v8 do
    v7[i] = v;
end;

u6.PVP = v7;
local v9 = {};
local v10 = {
    DisplayName = "The Abyss",
    DisplayOrder = 1,
    Legacy = true,
    PvpEnabled = true,
    MaxNPCs = 15,
    InitialNPCs = 8,
    SpawnInterval = 5,
    MaxPortals = 2,
    Requirements = {
        RebirthLevel = 2,
        BossKill = "Desert"
    },
    RarityOverrides = {
        Common = 0.0033333333333333335,
        Uncommon = 0.005,
        Rare = 0.03333333333333333,
        Epic = 0.013333333333333334,
        Legendary = 0.01,
        Mythic = 0.0033333333333333335,
        Cosmic = 0.0025
    },
    Boss = {
        HeroId = "Koga",
        Name = "Koga, The Abyssal Champion",
        Scale = 1.8,
        Health = 8000,
        Damage = 55,
        Multiplier = 4,
        SpawnChance = 0.013333333333333334,
        Collectable = true
    }
};

for i, v in u1 do
    v9[i] = v;
end;

for i, v in v10 do
    v9[i] = v;
end;

u6.GOD = v9;
local v11 = {};
local v12 = {
    DisplayName = "Frostmire I",
    DisplayOrder = 2,
    Legacy = true,
    PvpEnabled = true,
    MaxNPCs = 20,
    InitialNPCs = 8,
    SpawnInterval = 5,
    MaxPortals = 3,
    Requirements = {
        RebirthLevel = 3,
        BossKill = "Desert"
    },
    RarityOverrides = {
        Common = 0.02,
        Uncommon = 0.025,
        Rare = 0.03333333333333333,
        Epic = 0.014285714285714285,
        Legendary = 0.0020833333333333333,
        Mythic = 0.0002127659574468085,
        Cosmic = 0.00005
    }
};

for i, v in u1 do
    v11[i] = v;
end;

for i, v in v12 do
    v11[i] = v;
end;

u6["Frostmire I"] = v11;
local v13 = {};
local v14 = {
    DisplayName = "The Badlands",
    DisplayOrder = 0,
    Legacy = false,
    PvpEnabled = true,
    MaxNPCs = 15,
    InitialNPCs = 8,
    SpawnInterval = 5,
    MaxPortals = 2,
    TimeLimit = 180,
    FailRewardMultiplier = 0,
    BossRespawnTime = 60,
    Requirements = {
        RebirthLevel = 1,
        BossKill = nil
    },
    SpawnPools = {
        ["1"] = {
            Pool = { "Bandit", "Assassin", "Corsair" },
            Waves = { 5 }
        },
        ["2"] = {
            Pool = { "Bandit", "Assassin", "Corsair" },
            Waves = { 5 }
        },
        ["3"] = {
            Pool = { "Corsair", "Garm" },
            Waves = { 4 }
        },
        ["4"] = {
            Pool = { "Garm", "Vagrant" },
            Waves = { 3 }
        }
    },
    Rewards = {
        BaseCash = 5000,
        BaseStars = 10,
        HyperCrystalChance = 0,
        BonusItems = { {
                ItemId = "Bastion Crystal",
                Amount = { 1, 3 }
            } }
    },
    Boss = {
        HeroId = "Bastion",
        Name = "Bastion, The Flame Brazier",
        Scale = 1.5,
        Health = 1500,
        Damage = 20,
        Multiplier = 2.5,
        SpawnChance = nil,
        Collectable = true
    }
};

for i, v in u1 do
    v13[i] = v;
end;

for i, v in v14 do
    v13[i] = v;
end;

u6.Desert = v13;
local v15 = {};
local v16 = {
    DisplayName = "The Frostmire II",
    DisplayOrder = 3,
    Legacy = false,
    PvpEnabled = true,
    MaxNPCs = 35,
    InitialNPCs = 8,
    SpawnInterval = 5,
    MaxPortals = 2,
    TimeLimit = 300,
    FailRewardMultiplier = 0.05,
    BossRespawnTime = 60,
    Requirements = {
        RebirthLevel = 3,
        BossKill = nil
    },
    SpawnPools = {
        ["1"] = {
            Pool = { "Goblin Chief", "Bandit Chief", "Vagrant" },
            Waves = { 3, 3 }
        },
        ["2"] = {
            Pool = { "Sigrune", "Valkyria", "Paladin" },
            Waves = { 3, 2 }
        },
        ["3"] = {
            Pool = { "Astraeon", "Garm" },
            Waves = { 2, 2 }
        },
        ["4"] = {
            Pool = { "Astraeon", "Garm" },
            Waves = { 2, 1 }
        }
    },
    Rewards = {
        BaseCash = 1000000,
        BaseStars = 25,
        HyperCrystalChance = 0.3,
        BonusItems = { {
                ItemId = "Avalen Crystal",
                Amount = { 1, 3 }
            } }
    },
    Boss = {
        HeroId = "Avalen",
        Name = "Avalen, The Frost Guardian",
        Scale = 1.6,
        Health = 7000,
        Damage = 85,
        Multiplier = 2.5,
        SpawnChance = nil,
        Collectable = true
    }
};

for i, v in u1 do
    v15[i] = v;
end;

for i, v in v16 do
    v15[i] = v;
end;

u6["Frostmire II"] = v15;
local v17 = {};
local v18 = {
    DisplayName = "The Frostmire III",
    DisplayOrder = 4,
    Legacy = false,
    PvpEnabled = true,
    MaxNPCs = 35,
    InitialNPCs = 8,
    SpawnInterval = 5,
    MaxPortals = 2,
    TimeLimit = 300,
    FailRewardMultiplier = 0.02,
    BossRespawnTime = 60,
    Requirements = {
        RebirthLevel = 4,
        BossKill = nil
    },
    SpawnPools = {
        ["1"] = {
            Pool = { "Sigrune", "Wanderer", "Paladin" },
            Waves = { 5 }
        },
        ["2"] = {
            Pool = { "Melody", "Wanderer", "Bastion" },
            Waves = { 3 }
        },
        ["3"] = {
            Pool = { "Avalen", "Bastion" },
            Waves = { 2 }
        },
        ["4"] = {
            Pool = { "Frosty", "Galran" },
            Waves = { 2 }
        }
    },
    Rewards = {
        BaseCash = 5000000,
        BaseStars = 30,
        HyperCrystalChance = 0.7,
        BonusItems = { {
                ItemId = "Avalen Crystal",
                Amount = { 1, 3 }
            }, {
                ItemId = "Bastion Crystal",
                Amount = { 1, 3 }
            }, {
                ItemId = "Astraeon Crystal",
                Amount = { 1, 3 }
            }, {
                ItemId = "Garm Crystal",
                Amount = { 1, 3 }
            } }
    },
    Boss = {
        HeroId = "Astraeon",
        Name = "Astraeon, The Godslayer",
        Scale = 1.6,
        Health = 15000,
        Damage = 85,
        Multiplier = 2.8,
        SpawnChance = nil,
        Collectable = true
    }
};

for i, v in u1 do
    v17[i] = v;
end;

for i, v in v18 do
    v17[i] = v;
end;

u6["Frostmire III"] = v17;
local v19 = {};

for i, _ in u6 do
    table.insert(v19, i);
end;

table.sort(v19, function(p20, p21) -- Line: 406
    -- upvalues: u6 (copy)
    return u6[p20].DisplayOrder < u6[p21].DisplayOrder;
end);

return {
    Dungeons = u6,
    DisplayOrder = v19,

    GetDungeon = function(p22: string) -- Line: 412, Name: GetDungeon
        -- upvalues: u6 (copy)
        return u6[p22];
    end,

    GetBoss = function(p23: string) -- Line: 416, Name: GetBoss
        -- upvalues: u6 (copy)
        local v24 = u6[p23];

        return v24 and v24.Boss or nil;
    end,

    IsLegacy = function(p25: string) -- Line: 421, Name: IsLegacy
        -- upvalues: u6 (copy)
        local v26 = u6[p25];

        if v26 then
            v26 = v26.Legacy ~= false;
        end;

        return v26;
    end,

    CanEnter = function(p27: any, p28: string) -- Line: 428, Name: CanEnter
        -- upvalues: u6 (copy)
        local v29 = u6[p28];

        if not v29 then
            return false, "Unknown dungeon";
        end;

        local Requirements = v29.Requirements;

        if not Requirements then
            return true, nil;
        end;

        if Requirements.RebirthLevel and (p27.Data.Rebirths or 0) < Requirements.RebirthLevel then
            return false, `Requires Rebirth {Requirements.RebirthLevel}`;
        end;

        if Requirements.BossKill and not (p27.Data.BossKills or {})[Requirements.BossKill] then
            return false, `Defeat {u6[Requirements.BossKill] and u6[Requirements.BossKill].Boss and u6[Requirements.BossKill].Boss.Name or Requirements.BossKill} first`;
        end;

        return true, nil;
    end
};