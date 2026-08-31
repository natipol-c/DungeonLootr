--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BuffPotionData
  Path:     game.ReplicatedStorage.GameInfo.BuffPotionData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local Image_Data = require(script.Parent:WaitForChild("Image_Data"));
local u1 = {
    BuffTypes = {
        DropRate = "DropRate",
        LuckRate = "LuckRate",
        MoveSpeed = "MoveSpeed",
        CashRate = "CashRate",
        DamagePercent = "DamagePercent",
        PlayerXP = "PlayerXP",
        ClassXP = "ClassXP",
        Luck = "Luck",
        DoubleEXP = "DoubleEXP",
        LuckTier1 = "LuckTier1",
        LuckTier2 = "LuckTier2",
        LuckTier3 = "LuckTier3"
    },
    BuffTypeNames = {
        DropRate = "Drop Rate",
        LuckRate = "Luck",
        MoveSpeed = "Movement Speed",
        CashRate = "Cash Rate",
        DamagePercent = "Damage",
        PlayerXP = "Player EXP",
        ClassXP = "Class EXP",
        Luck = "Luck",
        DoubleEXP = "Double EXP",
        LuckTier1 = "Luck",
        LuckTier2 = "Luck",
        LuckTier3 = "Luck"
    },
    Potions = {
        {
            Id = "MinorDropRate",
            Name = "Minor Drop Potion",
            BuffType = "DropRate",
            Modifier = 0.05,
            Duration = 300,
            Tier = 1,
            Description = "+5% Crystal & Star drops for 5 min.",
            LayoutOrder = 1,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.MinorDropRate or "rbxassetid://0") or "rbxassetid://0"
        },
        {
            Id = "MajorDropRate",
            Name = "Major Drop Potion",
            BuffType = "DropRate",
            Modifier = 0.3,
            Duration = 300,
            Tier = 2,
            Description = "+30% Crystal & Star drops for 5 min.",
            LayoutOrder = 2,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.MajorDropRate or "rbxassetid://0") or "rbxassetid://0"
        },
        {
            Id = "MinorLuckRate",
            Name = "Minor Luck Potion",
            BuffType = "LuckRate",
            Modifier = 0.05,
            Duration = 300,
            Tier = 1,
            Description = "+5% Loot Chest & Enchanting luck for 5 min.",
            LayoutOrder = 3,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.MinorLuckRate or "rbxassetid://0") or "rbxassetid://0"
        },
        {
            Id = "MajorLuckRate",
            Name = "Major Luck Potion",
            BuffType = "LuckRate",
            Modifier = 0.3,
            Duration = 300,
            Tier = 2,
            Description = "+30% Loot Chest & Enchanting luck for 5 min.",
            LayoutOrder = 4,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.MajorLuckRate or "rbxassetid://0") or "rbxassetid://0"
        },
        {
            Id = "MinorMoveSpeed",
            Name = "Minor Speed Potion",
            BuffType = "MoveSpeed",
            Modifier = 0.05,
            Duration = 300,
            Tier = 1,
            Description = "+5% Movement Speed for 5 min.",
            LayoutOrder = 5,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.MinorMoveSpeed or "rbxassetid://0") or "rbxassetid://0"
        },
        {
            Id = "MajorMoveSpeed",
            Name = "Major Speed Potion",
            BuffType = "MoveSpeed",
            Modifier = 0.3,
            Duration = 300,
            Tier = 2,
            Description = "+30% Movement Speed for 5 min.",
            LayoutOrder = 6,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.MajorMoveSpeed or "rbxassetid://0") or "rbxassetid://0"
        },
        {
            Id = "MinorCashRate",
            Name = "Minor Cash Potion",
            BuffType = "CashRate",
            Modifier = 0.05,
            Duration = 300,
            Tier = 1,
            Description = "+5% Cash earned from all sources for 5 min.",
            LayoutOrder = 7,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.MinorCashRate or "rbxassetid://0") or "rbxassetid://0"
        },
        {
            Id = "MajorCashRate",
            Name = "Major Cash Potion",
            BuffType = "CashRate",
            Modifier = 0.3,
            Duration = 300,
            Tier = 2,
            Description = "+30% Cash earned from all sources for 5 min.",
            LayoutOrder = 8,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.MajorCashRate or "rbxassetid://0") or "rbxassetid://0"
        },
        {
            Id = "SwiftPotion",
            Name = "Swift Potion",
            BuffType = "MoveSpeed",
            Modifier = 0.15,
            Duration = 900,
            Tier = 3,
            Description = "+15% Movement Speed for 15 min.",
            LayoutOrder = 10,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.SwiftPotion or "rbxassetid://0") or "rbxassetid://0"
        },
        {
            Id = "LuckyPotion",
            Name = "Lucky Potion",
            BuffType = "Luck",
            Modifier = 10,
            Duration = 1800,
            Tier = 3,
            Description = "+10 Luck for 30 min.",
            LayoutOrder = 11,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.LuckyPotion or "rbxassetid://0") or "rbxassetid://0"
        },
        {
            Id = "EXPPotion",
            Name = "EXP Potion",
            BuffType = "PlayerXP",
            Modifier = 0.25,
            Duration = 1800,
            Tier = 3,
            Description = "+25% Player EXP gain for 30 min.",
            LayoutOrder = 12,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.EXPPotion or "rbxassetid://0") or "rbxassetid://0"
        },
        {
            Id = "DamagePotion",
            Name = "Damage Potion",
            BuffType = "DamagePercent",
            Modifier = 0.2,
            Duration = 1800,
            Tier = 3,
            Description = "+20% Damage for 30 min.",
            LayoutOrder = 13,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.DamagePotion or "rbxassetid://0") or "rbxassetid://0"
        },
        {
            Id = "ClassXPPotion",
            Name = "Class EXP Potion",
            BuffType = "ClassXP",
            Modifier = 0.5,
            Duration = 1800,
            Tier = 3,
            Description = "+50% Class EXP gain for 30 min.",
            LayoutOrder = 14,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.ClassXPPotion or "rbxassetid://0") or "rbxassetid://0"
        },
        {
            Id = "DoubleEXPPotion",
            Name = "Double EXP Potion",
            BuffType = "DoubleEXP",
            Modifier = 1,
            Duration = 1800,
            Tier = 4,
            Description = "Doubles Player & Class EXP for 30 min. Stacks with 2x EXP gamepasses.",
            LayoutOrder = 15,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.DoubleEXPPotion or "rbxassetid://0") or "rbxassetid://0"
        },
        {
            Id = "LootLuckPotion",
            Name = "Loot Luck Potion",
            BuffType = "LuckRate",
            Modifier = 0.4,
            Duration = 1800,
            Tier = 4,
            Description = "Boosts dungeon loot luck for 30 min. Stacks with the Increased Luck perk.",
            LayoutOrder = 16,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.LootLuckPotion or "rbxassetid://0") or "rbxassetid://0"
        },
        {
            Id = "LuckPotionT1",
            Name = "Luck Potion I",
            BuffType = "LuckTier1",
            Modifier = 0.05,
            Duration = 600,
            Tier = 1,
            Description = "+5% Loot Luck for 10 min. Stacks with other Luck Potion tiers.",
            LayoutOrder = 17,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.LuckPotionT1 or "rbxassetid://0") or "rbxassetid://0"
        },
        {
            Id = "LuckPotionT2",
            Name = "Luck Potion II",
            BuffType = "LuckTier2",
            Modifier = 0.1,
            Duration = 600,
            Tier = 2,
            Description = "+10% Loot Luck for 10 min. Stacks with other Luck Potion tiers.",
            LayoutOrder = 18,
            Icon = Image_Data.BuffPotions and (Image_Data.BuffPotions.LuckPotionT2 or "rbxassetid://0") or "rbxassetid://0"
        },
        {
            Id = "LuckPotionT3",
            Name = "Luck Potion III",
            BuffType = "LuckTier3",
            Modifier = 0.15,
            Duration = 600,
            Tier = 3,
            Description = "+15% Loot Luck for 10 min. Stacks with other Luck Potion tiers.",
            LayoutOrder = 19,
            Icon = Image_Data.BuffPotions and Image_Data.BuffPotions.LuckPotionT3 or "rbxassetid://0"
        }
    },
    Index = {}
};

for _, v in ipairs(u1.Potions) do
    u1.Index[v.Id] = v;
end;

function u1.GetPotion(p2: string) -- Line: 343
    -- upvalues: u1 (copy)
    return u1.Index[p2];
end;

function u1.GetAllIds() -- Line: 348
    -- upvalues: u1 (copy)
    local v3 = {};

    for _, v in ipairs(u1.Potions) do
        table.insert(v3, v.Id);
    end;

    return v3;
end;

function u1.GetPotionsByType(p4: string) -- Line: 357
    -- upvalues: u1 (copy)
    local v5 = {};

    for _, v in ipairs(u1.Potions) do
        if v.BuffType == p4 then
            table.insert(v5, v);
        end;
    end;

    return v5;
end;

return u1;