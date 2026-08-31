--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DungeonRarityData
  Path:     game.ReplicatedStorage.GameInfo.DungeonRarityData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RarityData = require(ReplicatedStorage.GameInfo.RarityData);
local u1 = {
    RARITY_INDEX = {
        [RarityData.RarityOrder[1]] = 1,
        [RarityData.RarityOrder[2]] = 2,
        [RarityData.RarityOrder[3]] = 3,
        [RarityData.RarityOrder[4]] = 4,
        [RarityData.RarityOrder[5]] = 5,
        [RarityData.RarityOrder[6]] = 6,
        [RarityData.RarityOrder[7]] = 7
    },
    MAX_RARITY_INDEX = 7,
    Weights = {
        ["Bandits Den"] = {
            Common = 100,
            Uncommon = 60,
            Rare = 30,
            Epic = 10,
            Legendary = 3,
            Mythic = 1,
            Celestial = 0.3
        },
        Goblins = {
            Common = 60,
            Uncommon = 100,
            Rare = 60,
            Epic = 20,
            Legendary = 6,
            Mythic = 2,
            Celestial = 0.5
        },
        Knights = {
            Common = 30,
            Uncommon = 60,
            Rare = 100,
            Epic = 40,
            Legendary = 12,
            Mythic = 4,
            Celestial = 1
        },
        Catacombs = {
            Common = 15,
            Uncommon = 30,
            Rare = 60,
            Epic = 100,
            Legendary = 30,
            Mythic = 10,
            Celestial = 2
        },
        Snow = {
            Common = 6,
            Uncommon = 15,
            Rare = 30,
            Epic = 60,
            Legendary = 100,
            Mythic = 25,
            Celestial = 5
        },
        Demon = {
            Common = 3,
            Uncommon = 8,
            Rare = 15,
            Epic = 30,
            Legendary = 60,
            Mythic = 100,
            Celestial = 12
        }
    }
};
local u2 = {
    ["Forest Challenge"] = "Bandits Den",
    ["Double Dungeon"] = "Snow",
    ["Throne Room"] = "Snow"
};
local u3 = u1.Weights["Bandits Den"];
u1.Tilt = {
    Easy = 0.85,
    Normal = 1,
    Hard = 1.2,
    Nightmare = 1.5,
    Endless = 1.4
};
u1.LUCK_ATTRIBUTES = { "Stat_LootBias", "DungeonMod_LuckBonus", "Perk_LootLuck", "Buff_LuckRate", "Buff_LuckTier1", "Buff_LuckTier2", "Buff_LuckTier3" };
u1.INCREASED_LUCK_PERK = 0.3;

function u1.ComputePlayerLuck(p4: userdata?) -- Line: 109
    -- upvalues: u1 (copy)
    if not p4 then
        return 0;
    end;

    local v5 = 0;

    for _, v in u1.LUCK_ATTRIBUTES do
        v5 = v5 + (p4:GetAttribute(v) or 0);
    end;

    return v5;
end;

u1.SPECIAL_DROP_LUCK_ATTRIBUTES = { "Perk_LootLuck", "Buff_LuckRate" };

function u1.ComputeSpecialDropLuckMultiplier(p6: userdata?) -- Line: 137
    -- upvalues: u1 (copy)
    if not p6 then
        return 1;
    end;

    local v7 = 0;

    for _, v in u1.SPECIAL_DROP_LUCK_ATTRIBUTES do
        v7 = v7 + (p6:GetAttribute(v) or 0);
    end;

    return math.max(0, v7) + 1;
end;

local function ResolveWeights(p8: string) -- Line: 150
    -- upvalues: u1 (copy), u2 (copy), u3 (copy)
    return u1.Weights[p8] or (u1.Weights[u2[p8] or ""] or u3);
end;

local function BuildWeightedEntries(p9: string, p10: string, p11: number?) -- Line: 163
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), RarityData (copy)
    local v12 = u1.Weights[p9] or (u1.Weights[u2[p9] or ""] or u3);
    local v13 = u1.Tilt[p10] or 1;
    local v14 = p11 or 0;
    local v15 = {};
    local v16 = 0;

    for i = 1, 7 do
        local v17 = RarityData.RarityOrder[i];
        local v18 = v12[v17];
        local v19;

        if v18 and v18 > 0 then
            local v20 = v18 * v13 ^ (i - 1);

            if v14 ~= 0 then
                v20 = v20 * (RarityData.RarityLuckWeights[v17] or 1) ^ v14;
            end;

            table.insert(v15, {
                Name = v17,
                Weight = v20
            });
            v16 = v16 + v20;
            v19 = i;
        else
            v19 = i;
        end;
    end;

    return v15, v16;
end;

function u1.Roll(p21: string, p22: string, p23: userdata?, p24: number?) -- Line: 194
    -- upvalues: BuildWeightedEntries (copy), RarityData (copy)
    local v25, v26 = BuildWeightedEntries(p21, p22, p24);

    if #v25 == 0 or v26 <= 0 then
        return RarityData.RarityOrder[1];
    end;

    local v27 = (p23 and p23:NextNumber() or math.random()) * v26;
    local v28 = 0;

    for _, v in v25 do
        v28 = v28 + v.Weight;

        if v27 <= v28 then
            return v.Name;
        end;
    end;

    return v25[#v25].Name;
end;

function u1.RollN(p29: string, p30: string, p31: number, p32: userdata?, p33: number?) -- Line: 214
    -- upvalues: u1 (copy)
    local v34 = {};

    for i = 1, p31 do
        table.insert(v34, u1.Roll(p29, p30, p32, p33));
        local _ = i;
    end;

    return v34;
end;

function u1.GetProbabilities(p35: string, p36: string, p37: number?) -- Line: 224
    -- upvalues: BuildWeightedEntries (copy)
    local v38, v39 = BuildWeightedEntries(p35, p36, p37);
    local v40 = {};

    for _, v in v38 do
        v40[v.Name] = v39 > 0 and (v.Weight / v39 or 0) or 0;
    end;

    return v40;
end;

return u1;