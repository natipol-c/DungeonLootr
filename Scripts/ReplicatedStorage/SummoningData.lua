--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SummoningData
  Path:     game.ReplicatedStorage.GameInfo.SummoningData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u10 = {
    NormalSpin = {
        Rare = 70,
        Epic = 20,
        Legendary = 8,
        Mythic = 2,
        Celestial = 0.5,
        Exotic = 0.05
    },
    LuckySpin = {
        Rare = 20,
        Epic = 40,
        Legendary = 22,
        Mythic = 16,
        Celestial = 3,
        Exotic = 0.1
    },
    RarityOrder = { "Rare", "Epic", "Legendary", "Mythic", "Celestial", "Exotic" },
    CELESTIAL_FOCUS_MULTIPLIER = 3,
    CELESTIAL_PITY_CAP = 300,

    GetRates = function(p1: table) -- Line: 57, Name: GetRates
        -- upvalues: ReplicatedStorage (copy)
        local Class_Data = require(ReplicatedStorage.Classes.Class_Data);
        local v2 = {};
        local v3 = 0;

        for i, v in p1 do
            if #Class_Data.GetSummonableClassesByRarity(i) > 0 then
                v2[i] = v;
                v3 = v3 + v;
            end;
        end;

        local v4 = {};

        for i, v in v2 do
            v4[i] = v / v3 * 100;
        end;

        return v4;
    end,

    RollRarity = function(p5: table) -- Line: 83, Name: RollRarity
        -- upvalues: ReplicatedStorage (copy)
        local Class_Data = require(ReplicatedStorage.Classes.Class_Data);
        local v6 = {};
        local v7 = 0;

        for i, v in p5 do
            if #Class_Data.GetSummonableClassesByRarity(i) > 0 then
                table.insert(v6, {
                    Rarity = i,
                    Weight = v
                });
                v7 = v7 + v;
            end;
        end;

        local v8 = math.random() * v7;
        local v9 = 0;

        for _, v in v6 do
            v9 = v9 + v.Weight;

            if v8 <= v9 then
                return v.Rarity;
            end;
        end;

        return v6[#v6].Rarity;
    end
};

function u10.RollClassInRarity(p11: string, p12: string?) -- Line: 116
    -- upvalues: ReplicatedStorage (copy), u10 (copy)
    local SummonableClassesByRarity = require(ReplicatedStorage.Classes.Class_Data).GetSummonableClassesByRarity(p11);

    if #SummonableClassesByRarity == 0 then
        warn("[SummoningData] No classes found for rarity:", p11);

        return "";
    end;

    if not p12 or (p12 == "" or not table.find(SummonableClassesByRarity, p12)) then
        return SummonableClassesByRarity[math.random(1, #SummonableClassesByRarity)];
    end;

    local CELESTIAL_FOCUS_MULTIPLIER = u10.CELESTIAL_FOCUS_MULTIPLIER;
    local v13 = math.random() * (#SummonableClassesByRarity - 1 + CELESTIAL_FOCUS_MULTIPLIER);
    local v14 = 0;

    for _, v in SummonableClassesByRarity do
        v14 = v14 + (v == p12 and CELESTIAL_FOCUS_MULTIPLIER and CELESTIAL_FOCUS_MULTIPLIER or 1);

        if v13 <= v14 then
            return v;
        end;
    end;

    return SummonableClassesByRarity[#SummonableClassesByRarity];
end;

function u10.Roll(p15: table, p16: string?) -- Line: 148
    -- upvalues: u10 (copy)
    local v17 = u10.RollRarity(p15);

    return u10.RollClassInRarity(v17, p16), v17;
end;

function u10.FormatRate(p18: number) -- Line: 158
    if p18 >= 1 then
        return string.format("%.0f%%", p18);
    end;

    local string_format_ret = string.format("%." .. (p18 < 0.01 and 3 or (p18 < 0.1 and 2 or 1)) .. "f", p18);

    if string_format_ret:find("%.") then
        string_format_ret = string_format_ret:gsub("0+$", ""):gsub("%.$", ".0");
    end;

    return string_format_ret .. "%";
end;

return u10;