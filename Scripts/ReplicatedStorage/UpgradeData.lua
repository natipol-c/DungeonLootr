--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     UpgradeData
  Path:     game.ReplicatedStorage.GameInfo.UpgradeData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    MAX_LEVEL = 20,
    LevelNames = {
        [16] = "PRI",
        [17] = "DUO",
        [18] = "TRI",
        [19] = "TET",
        [20] = "PEN"
    }
};

function u1.GetLevelName(p2: number) -- Line: 36
    -- upvalues: u1 (copy)
    if u1.LevelNames[p2] then
        return u1.LevelNames[p2];
    end;

    return "+" .. tostring(p2);
end;

u1.DOWNGRADE_THRESHOLD = 15;
u1.StoneCosts = { {
        MaxLevel = 7,
        Cost = 1
    }, {
        MaxLevel = 14,
        Cost = 2
    }, {
        MaxLevel = 15,
        Cost = 3
    }, {
        MaxLevel = 16,
        Cost = 5
    }, {
        MaxLevel = 17,
        Cost = 5
    }, {
        MaxLevel = 18,
        Cost = 7
    }, {
        MaxLevel = 19,
        Cost = 7
    }, {
        MaxLevel = 20,
        Cost = 10
    } };
u1.SuccessRates = { 1, 1, 1, 0.95, 0.95, 0.9, 0.9, 0.85, 0.8, 0.75, 0.65, 0.55, 0.45, 0.35, 0.3, 0.3, 0.2, 0.1, 0.03, 0.01 };
u1.DOWNGRADE_LEVELS = 1;
u1.RarityToStone = {
    Common = "Common",
    Uncommon = "Uncommon",
    Rare = "Rare",
    Epic = "Epic",
    Legendary = "Legendary",
    Mythic = "Mythic",
    Exotic = "Mythic",
    Celestial = "Celestial",
    Admin = "Celestial",
    Owner = "Celestial"
};
u1.StoneRarities = { "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Celestial" };

function u1.GetStoneCost(p3: number) -- Line: 121
    -- upvalues: u1 (copy)
    for _, v in ipairs(u1.StoneCosts) do
        if p3 <= v.MaxLevel then
            return v.Cost;
        end;
    end;

    return 5;
end;

function u1.GetSuccessRate(p4: number) -- Line: 131
    -- upvalues: u1 (copy)
    return u1.SuccessRates[p4] or 0;
end;

function u1.CanDowngrade(p5: number) -- Line: 136
    -- upvalues: u1 (copy)
    return u1.DOWNGRADE_THRESHOLD <= p5;
end;

function u1.GetStoneRarity(p6: string) -- Line: 141
    -- upvalues: u1 (copy)
    return u1.RarityToStone[p6];
end;

function u1.GetDamageMultiplier(p7: number) -- Line: 147
    if p7 <= 0 then
        return 1;
    end;

    if p7 <= 15 then
        return p7 * 0.03 + 1;
    end;

    return (p7 - 15) * 0.09 + 1.45;
end;

return u1;