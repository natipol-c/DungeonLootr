--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ItemShopData
  Path:     game.ReplicatedStorage.GameInfo.ItemShopData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local LootChestData = require(script.Parent:WaitForChild("LootChestData"));
local Image_Data = require(script.Parent:WaitForChild("Image_Data"));
local u1 = {
    RESTOCK_INTERVAL = 300,
    Items = {
        {
            Id = "SmallHealFlat",
            Name = "Minor Healing Potion",
            Type = "Potion",
            PotionId = "SmallHealFlat",
            Cost = 15,
            RequiredRebirth = 0,
            Description = "Restores 25 HP instantly.",
            LayoutOrder = 20,
            Icon = Image_Data.Potions.SmallHealFlat,
            StockConfig = {
                Chance = 1,
                MinStock = 2,
                MaxStock = 10
            }
        },
        {
            Id = "MediumHealFlat",
            Name = "Healing Potion",
            Type = "Potion",
            PotionId = "MediumHealFlat",
            Cost = 40,
            RequiredRebirth = 0,
            Description = "Restores 60 HP instantly.",
            LayoutOrder = 21,
            Icon = Image_Data.Potions.MediumHealFlat,
            StockConfig = {
                Chance = 0.7,
                MinStock = 2,
                MaxStock = 10
            }
        },
        {
            Id = "LargeHealFlat",
            Name = "Greater Healing Potion",
            Type = "Potion",
            PotionId = "LargeHealFlat",
            Cost = 200,
            RequiredRebirth = 1,
            Description = "Restores 150 HP instantly.",
            LayoutOrder = 22,
            Icon = Image_Data.Potions.LargeHealFlat,
            StockConfig = {
                Chance = 0.5,
                MinStock = 1,
                MaxStock = 10
            }
        },
        {
            Id = "CommonStone",
            Name = "Common Stone",
            Type = "UpgradeStone",
            StoneRarity = "Common",
            Cost = 10,
            RequiredRebirth = 0,
            Description = "Used to enhance Common weapons.",
            LayoutOrder = 1,
            RobuxProductKey_x1 = "Stone_Common_x1",
            RobuxProductKey_x10 = "Stone_Common_x10",
            Icon = LootChestData.UpgradeStoneImages.Common,
            StockConfig = {
                Chance = 1,
                MinStock = 5,
                MaxStock = 10
            }
        },
        {
            Id = "UncommonStone",
            Name = "Uncommon Stone",
            Type = "UpgradeStone",
            StoneRarity = "Uncommon",
            Cost = 30,
            RequiredRebirth = 0,
            Description = "Used to enhance Uncommon weapons.",
            LayoutOrder = 2,
            RobuxProductKey_x1 = "Stone_Uncommon_x1",
            RobuxProductKey_x10 = "Stone_Uncommon_x10",
            Icon = LootChestData.UpgradeStoneImages.Uncommon,
            StockConfig = {
                Chance = 1,
                MinStock = 2,
                MaxStock = 6
            }
        },
        {
            Id = "RareStone",
            Name = "Rare Stone",
            Type = "UpgradeStone",
            StoneRarity = "Rare",
            Cost = 60,
            RequiredRebirth = 0,
            Description = "Used to enhance Rare weapons.",
            LayoutOrder = 3,
            RobuxProductKey_x1 = "Stone_Rare_x1",
            RobuxProductKey_x10 = "Stone_Rare_x10",
            Icon = LootChestData.UpgradeStoneImages.Rare,
            StockConfig = {
                Chance = 0.85,
                MinStock = 2,
                MaxStock = 5
            }
        },
        {
            Id = "EpicStone",
            Name = "Epic Stone",
            Type = "UpgradeStone",
            StoneRarity = "Epic",
            Cost = 200,
            RequiredRebirth = 0,
            Description = "Used to enhance Epic weapons.",
            LayoutOrder = 4,
            RobuxProductKey_x1 = "Stone_Epic_x1",
            RobuxProductKey_x10 = "Stone_Epic_x10",
            Icon = LootChestData.UpgradeStoneImages.Epic,
            StockConfig = {
                Chance = 0.7,
                MinStock = 1,
                MaxStock = 4
            }
        },
        {
            Id = "LegendaryStone",
            Name = "Legendary Stone",
            Type = "UpgradeStone",
            StoneRarity = "Legendary",
            Cost = 600,
            RequiredRebirth = 2,
            Description = "Used to enhance Legendary weapons.",
            LayoutOrder = 5,
            RobuxProductKey_x1 = "Stone_Legendary_x1",
            RobuxProductKey_x10 = "Stone_Legendary_x10",
            Icon = LootChestData.UpgradeStoneImages.Legendary,
            StockConfig = {
                Chance = 0.5,
                MinStock = 1,
                MaxStock = 3
            }
        },
        {
            Id = "MythicStone",
            Name = "Mythic Stone",
            Type = "UpgradeStone",
            StoneRarity = "Mythic",
            Cost = 1500,
            RequiredRebirth = 3,
            Description = "Used to enhance Mythic weapons.",
            LayoutOrder = 6,
            RobuxProductKey_x1 = "Stone_Mythic_x1",
            RobuxProductKey_x10 = "Stone_Mythic_x10",
            Icon = LootChestData.UpgradeStoneImages.Mythic,
            StockConfig = {
                Chance = 0.35,
                MinStock = 1,
                MaxStock = 2
            }
        },
        {
            Id = "CelestialStone",
            Name = "Celestial Stone",
            Type = "UpgradeStone",
            StoneRarity = "Celestial",
            Cost = 4000,
            RequiredRebirth = 4,
            Description = "Used to enhance Celestial weapons.",
            LayoutOrder = 7,
            RobuxProductKey_x1 = "Stone_Celestial_x1",
            RobuxProductKey_x10 = "Stone_Celestial_x10",
            Icon = LootChestData.UpgradeStoneImages.Celestial,
            StockConfig = {
                Chance = 0.2,
                MinStock = 1,
                MaxStock = 1
            }
        },
        {
            Id = "ProtectionScroll",
            Name = "Protection Scroll",
            Type = "ProtectionScroll",
            Cost = 10000,
            RequiredRebirth = 3,
            Description = "Prevents weapon downgrade on failed enhancement.",
            LayoutOrder = 10,
            Icon = Image_Data.Rewards.ProtectionScroll
        }
    }
};

function u1.GetItem(p2: string) -- Line: 329
    -- upvalues: u1 (copy)
    for _, v in ipairs(u1.Items) do
        if v.Id == p2 then
            return v;
        end;
    end;

    return nil;
end;

function u1.GetAvailableItems(p3: number) -- Line: 339
    -- upvalues: u1 (copy)
    local v4 = {};

    for _, v in ipairs(u1.Items) do
        if v.RequiredRebirth <= p3 then
            table.insert(v4, v);
        end;
    end;

    return v4;
end;

function u1.HasStockLimit(p5: string) -- Line: 350
    -- upvalues: u1 (copy)
    local Item = u1.GetItem(p5);
    local v6;

    if Item == nil then
        v6 = false;
    else
        v6 = Item.StockConfig ~= nil;
    end;

    return v6;
end;

return u1;