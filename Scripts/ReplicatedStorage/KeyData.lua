--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     KeyData
  Path:     game.ReplicatedStorage.GameInfo.KeyData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local Image_Data = require(script.Parent:WaitForChild("Image_Data"));
local u1 = {
    Tiers = {
        {
            Name = "Bronze Key",
            DropRate = 0.03,
            MinDungeonTier = 1,
            Color = Color3.fromRGB(139, 90, 43)
        },
        {
            Name = "Silver Key",
            DropRate = 0.02,
            MinDungeonTier = 2,
            Color = Color3.fromRGB(192, 192, 192)
        },
        {
            Name = "Gold Key",
            DropRate = 0.015,
            MinDungeonTier = 3,
            Color = Color3.fromRGB(255, 200, 50)
        },
        {
            Name = "Platinum Key",
            DropRate = 0.012,
            MinDungeonTier = 4,
            Color = Color3.fromRGB(100, 200, 230)
        },
        {
            Name = "Celestial Key",
            DropRate = 0.01,
            MinDungeonTier = 5,
            Color = Color3.fromRGB(180, 80, 220)
        }
    },
    MAX_TIER = 5,
    MASTER_KEY_ID = "Master",
    MASTER_KEY_NAME = "Master Key",
    MASTER_KEY_COLOR = Color3.fromRGB(255, 255, 255),
    MASTER_KEY_DROP_RATE = 0.005,
    LOCKED_ROOM_TIER_WEIGHTS = { { {
                Tier = 1,
                Weight = 0.9
            }, {
                Tier = 2,
                Weight = 0.1
            } }, { {
                Tier = 1,
                Weight = 0.7
            }, {
                Tier = 2,
                Weight = 0.3
            } }, { {
                Tier = 1,
                Weight = 0.4
            }, {
                Tier = 2,
                Weight = 0.45
            }, {
                Tier = 3,
                Weight = 0.15
            } }, { {
                Tier = 1,
                Weight = 0.2
            }, {
                Tier = 2,
                Weight = 0.45
            }, {
                Tier = 3,
                Weight = 0.35
            } } }
};

function u1.RollLockedRoomTier(p2: number) -- Line: 79
    -- upvalues: u1 (copy)
    local v3 = u1.LOCKED_ROOM_TIER_WEIGHTS[p2];

    if not v3 then
        return 1;
    end;

    local math_random_ret = math.random();
    local v4 = 0;

    for _, v in v3 do
        v4 = v4 + v.Weight;

        if math_random_ret <= v4 then
            return v.Tier;
        end;
    end;

    return 1;
end;

u1.DIFFICULTY_LOCKED_ROOM_TIER_WEIGHTS = {
    Easy = { {
            Tier = 1,
            Weight = 0.75
        }, {
            Tier = 2,
            Weight = 0.2
        }, {
            Tier = 3,
            Weight = 0.05
        } },
    Normal = { {
            Tier = 1,
            Weight = 0.45
        }, {
            Tier = 2,
            Weight = 0.35
        }, {
            Tier = 3,
            Weight = 0.15
        }, {
            Tier = 4,
            Weight = 0.05
        } },
    Hard = { {
            Tier = 1,
            Weight = 0.15
        }, {
            Tier = 2,
            Weight = 0.3
        }, {
            Tier = 3,
            Weight = 0.35
        }, {
            Tier = 4,
            Weight = 0.15
        }, {
            Tier = 5,
            Weight = 0.05
        } },
    Nightmare = { {
            Tier = 2,
            Weight = 0.15
        }, {
            Tier = 3,
            Weight = 0.4
        }, {
            Tier = 4,
            Weight = 0.35
        }, {
            Tier = 5,
            Weight = 0.1
        } },
    Endless = { {
            Tier = 1,
            Weight = 0.05
        }, {
            Tier = 2,
            Weight = 0.2
        }, {
            Tier = 3,
            Weight = 0.35
        }, {
            Tier = 4,
            Weight = 0.3
        }, {
            Tier = 5,
            Weight = 0.1
        } }
};

function u1.RollLockedRoomTierByDifficulty(p5: string) -- Line: 135
    -- upvalues: u1 (copy)
    local v6 = u1.DIFFICULTY_LOCKED_ROOM_TIER_WEIGHTS[p5] or u1.DIFFICULTY_LOCKED_ROOM_TIER_WEIGHTS.Easy;
    local math_random_ret = math.random();
    local v7 = 0;

    for _, v in v6 do
        v7 = v7 + v.Weight;

        if math_random_ret <= v7 then
            return v.Tier;
        end;
    end;

    return 1;
end;

u1.DIFFICULTY_ELIGIBLE_TIERS = {
    Endless = nil,
    Easy = { 1, 2 },
    Normal = { 2, 3 },
    Hard = { 2, 3, 4 },
    Nightmare = { 3, 4, 5 }
};
u1.LOCKED_ROOM_RARITY_WINDOW = { {
        Floor = "Rare",
        Ceiling = "Epic"
    }, {
        Floor = "Epic",
        Ceiling = "Legendary"
    }, {
        Floor = "Legendary",
        Ceiling = "Mythic"
    }, {
        Floor = "Mythic",
        Ceiling = "Celestial"
    }, {
        Floor = "Celestial",
        Ceiling = "Celestial"
    } };
u1.LOCKED_ROOM_FLOOR_WEIGHT = 0.75;
u1.LOCKED_ROOM_CEILING_WEIGHT = 0.25;
u1.MIMIC_CHANCE = 0.25;
u1.MIMIC_TIER_SCALING = { {
        HealthMult = 1,
        DamageMult = 1,
        MobCount = 3
    }, {
        HealthMult = 1.3,
        DamageMult = 1.2,
        MobCount = 3
    }, {
        HealthMult = 1.6,
        DamageMult = 1.4,
        MobCount = 4
    }, {
        HealthMult = 2,
        DamageMult = 1.7,
        MobCount = 4
    }, {
        HealthMult = 2.5,
        DamageMult = 2,
        MobCount = 5
    } };
u1.POST_MIMIC_FLOOR_SHIFT = 1;

function u1.GetKeyName(p8) -- Line: 201
    -- upvalues: u1 (copy)
    if p8 == u1.MASTER_KEY_ID then
        return u1.MASTER_KEY_NAME;
    end;

    local v9 = u1.Tiers[p8];

    return v9 and v9.Name or "T" .. tostring(p8) .. " Key";
end;

function u1.GetKeyColor(p10) -- Line: 210
    -- upvalues: u1 (copy)
    if p10 == u1.MASTER_KEY_ID then
        return u1.MASTER_KEY_COLOR;
    end;

    local v11 = u1.Tiers[p10];

    return v11 and v11.Color or Color3.fromRGB(200, 200, 200);
end;

function u1.GetKeyIcon(p12) -- Line: 223
    -- upvalues: u1 (copy), Image_Data (copy)
    local v13 = p12 == u1.MASTER_KEY_ID and u1.MASTER_KEY_ID or "T" .. tostring(p12);
    local v14 = Image_Data.Keys[v13];

    if v14 and v14 ~= "" then
        return v14;
    end;

    return nil;
end;

function u1.GetEligibleTiers(p15: number) -- Line: 234
    -- upvalues: u1 (copy)
    local v16 = {};

    for i = 1, u1.MAX_TIER do
        local v17;

        if u1.Tiers[i].MinDungeonTier <= p15 then
            table.insert(v16, i);
            v17 = i;
        else
            v17 = i;
        end;
    end;

    return v16;
end;

function u1.RollKeyTier(p18: number) -- Line: 248
    -- upvalues: u1 (copy)
    local EligibleTiers = u1.GetEligibleTiers(p18);

    if #EligibleTiers == 0 then
        return nil;
    end;

    local v19 = {};
    local v20 = 0;

    for _, v in EligibleTiers do
        local DropRate = u1.Tiers[v].DropRate;
        table.insert(v19, {
            Tier = v,
            Weight = DropRate
        });
        v20 = v20 + DropRate;
    end;

    if v20 <= 0 then
        return EligibleTiers[1];
    end;

    local v21 = math.random() * v20;
    local v22 = 0;

    for _, v in v19 do
        v22 = v22 + v.Weight;

        if v21 <= v22 then
            return v.Tier;
        end;
    end;

    return v19[#v19].Tier;
end;

function u1.RollKeyDrop(p23: number, p24: string?) -- Line: 282
    -- upvalues: u1 (copy)
    local v25;

    if p24 and u1.DIFFICULTY_ELIGIBLE_TIERS[p24] then
        v25 = u1.DIFFICULTY_ELIGIBLE_TIERS[p24];
    else
        v25 = u1.GetEligibleTiers(p23);
    end;

    if #v25 == 0 then
        return nil;
    end;

    local table_clone_ret = table.clone(v25);
    table.sort(table_clone_ret, function(p26, p27) -- Line: 296
        return p27 < p26;
    end);
    local math_random_ret = math.random();
    local v28 = 0;

    for _, v in table_clone_ret do
        v28 = v28 + u1.Tiers[v].DropRate;

        if math_random_ret <= v28 then
            return v;
        end;
    end;

    return nil;
end;

function u1.CanOpenDoor(p29: any, p30: number) -- Line: 312
    -- upvalues: u1 (copy)
    if p29 == u1.MASTER_KEY_ID then
        return true;
    end;

    local v31;

    if type(p29) == "number" then
        v31 = p30 <= p29;
    else
        v31 = false;
    end;

    return v31;
end;

return u1;