--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CraftingData
  Path:     game.ReplicatedStorage.GameInfo.CraftingData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local GameInfo = game:GetService("ReplicatedStorage"):WaitForChild("GameInfo");
local ItemData = require(GameInfo:WaitForChild("ItemData"));
local PotionData = require(GameInfo:WaitForChild("PotionData"));
local BuffPotionData = require(GameInfo:WaitForChild("BuffPotionData"));
local PackageData = require(GameInfo:WaitForChild("PackageData"));
local CosmeticData = require(GameInfo:WaitForChild("CosmeticData"));
local QuestItemData = require(GameInfo:WaitForChild("QuestItemData"));
local ClassItemData = require(GameInfo:WaitForChild("ClassItemData"));
local EquipmentTemplates = require(GameInfo:WaitForChild("EquipmentTemplates"));
local RarityData = require(GameInfo:WaitForChild("RarityData"));
local u1 = {
    MAX_MATERIAL_TYPES = 10,
    Categories = { "Equipment", "Items", "Materials", "Cosmetics" },
    Recipes = {
        ["Purity Stone"] = {
            Category = "Items",
            OutputType = "QuestItem",
            Materials = { {
                    Id = "Gold Ore",
                    Amount = 10
                }, {
                    Id = "Obsidian Ore",
                    Amount = 5
                }, {
                    Id = "Celestial Ore",
                    Amount = 2
                } }
        },
        ["Common Ingot"] = {
            Category = "Materials",
            OutputType = "CraftingMaterial",
            CoinCost = 75,
            Materials = { {
                    Id = "Iron Scrap",
                    Amount = 2
                } }
        },
        ["Uncommon Ingot"] = {
            Category = "Materials",
            OutputType = "CraftingMaterial",
            CoinCost = 175,
            Materials = { {
                    Id = "Iron Scrap",
                    Amount = 3
                }, {
                    Id = "Iron Ore",
                    Amount = 1
                } }
        },
        ["Rare Ingot"] = {
            Category = "Materials",
            OutputType = "CraftingMaterial",
            CoinCost = 300,
            Materials = { {
                    Id = "Iron Ore",
                    Amount = 3
                }, {
                    Id = "Gold Ore",
                    Amount = 1
                } }
        },
        ["Epic Ingot"] = {
            Category = "Materials",
            OutputType = "CraftingMaterial",
            CoinCost = 550,
            Materials = { {
                    Id = "Gold Ore",
                    Amount = 3
                }, {
                    Id = "Obsidian Ore",
                    Amount = 1
                } }
        },
        ["Legendary Ingot"] = {
            Category = "Materials",
            OutputType = "CraftingMaterial",
            CoinCost = 800,
            Materials = { {
                    Id = "Obsidian Ore",
                    Amount = 3
                }, {
                    Id = "Infernal Ore",
                    Amount = 1
                } }
        },
        ["Mythic Ingot"] = {
            Category = "Materials",
            OutputType = "CraftingMaterial",
            CoinCost = 1000,
            Materials = { {
                    Id = "Infernal Ore",
                    Amount = 3
                }, {
                    Id = "Radiant Ore",
                    Amount = 1
                } }
        },
        ["Celestial Ingot"] = {
            Category = "Materials",
            OutputType = "CraftingMaterial",
            CoinCost = 1500,
            Materials = { {
                    Id = "Celestial Ore",
                    Amount = 5
                } }
        },
        ["Exotic Ingot"] = {
            Category = "Materials",
            OutputType = "CraftingMaterial",
            CoinCost = 2000,
            Materials = { {
                    Id = "Exotic Ore",
                    Amount = 5
                } }
        },
        ["Iron Ore"] = {
            Category = "Materials",
            OutputType = "CraftingMaterial",
            Materials = { {
                    Id = "Iron Scrap",
                    Amount = 3
                } }
        },
        ["Gold Ore"] = {
            Category = "Materials",
            OutputType = "CraftingMaterial",
            Materials = { {
                    Id = "Iron Ore",
                    Amount = 3
                } }
        },
        ["Obsidian Ore"] = {
            Category = "Materials",
            OutputType = "CraftingMaterial",
            Materials = { {
                    Id = "Gold Ore",
                    Amount = 3
                } }
        },
        ["Infernal Ore"] = {
            Category = "Materials",
            OutputType = "CraftingMaterial",
            Materials = { {
                    Id = "Obsidian Ore",
                    Amount = 3
                } }
        },
        ["Radiant Ore"] = {
            Category = "Materials",
            OutputType = "CraftingMaterial",
            Materials = { {
                    Id = "Infernal Ore",
                    Amount = 3
                } }
        },
        ["Celestial Ore"] = {
            Category = "Materials",
            OutputType = "CraftingMaterial",
            Materials = { {
                    Id = "Radiant Ore",
                    Amount = 3
                } }
        },
        KingsCrown = {
            Category = "Equipment",
            OutputType = "Equipment",
            Slot = "Head",
            Rarity = "Exotic",
            GenerateStats = false,
            CraftAtPlayerLevel = true,
            Materials = { {
                    Id = "Exotic Essence",
                    Amount = 25
                }, {
                    Id = "Celestial Ore",
                    Amount = 300
                }, {
                    Id = "Exotic Shattered Armor",
                    Amount = 1
                } }
        },
        LivingArmor = {
            Category = "Equipment",
            OutputType = "Equipment",
            Slot = "Body",
            Rarity = "Exotic",
            GenerateStats = false,
            CraftAtPlayerLevel = true,
            Materials = { {
                    Id = "Exotic Essence",
                    Amount = 25
                }, {
                    Id = "Celestial Ore",
                    Amount = 300
                }, {
                    Id = "Exotic Shattered Armor",
                    Amount = 1
                } }
        },
        SupernovaRing = {
            Category = "Equipment",
            OutputType = "Equipment",
            Slot = "Ring",
            Rarity = "Exotic",
            GenerateStats = false,
            CraftAtPlayerLevel = true,
            Materials = { {
                    Id = "Exotic Essence",
                    Amount = 25
                }, {
                    Id = "Celestial Ore",
                    Amount = 300
                }, {
                    Id = "Exotic Shattered Armor",
                    Amount = 1
                } }
        },
        ["Anti Magic Claymore"] = {
            Category = "Equipment",
            OutputType = "ClassItem",
            Icon = "rbxassetid://120849327926749",
            Materials = { {
                    Id = "Anti Magic Fragment",
                    Amount = 50
                } }
        },
        ["Cursed Shrine"] = {
            Category = "Equipment",
            OutputType = "ClassItem",
            Icon = "rbxassetid://140002396428813",
            Materials = { {
                    Id = "Cursed Fragment",
                    Amount = 50
                } }
        },
        ["Infinity Core"] = {
            Category = "Equipment",
            OutputType = "ClassItem",
            Icon = "rbxassetid://128507028070506",
            Materials = { {
                    Id = "Infinity Fragment",
                    Amount = 50
                } }
        }
    }
};

for i, v in u1.Recipes do
    v.Id = i;
    v.OutputId = v.OutputId or i;
    v.Amount = v.Amount or 1;

    if v.ShowDescription == nil then
        v.ShowDescription = true;
    end;

    v.Materials = v.Materials or {};

    if #v.Materials > u1.MAX_MATERIAL_TYPES then
        warn((`[CraftingData] Recipe "{i}" exceeds MAX_MATERIAL_TYPES ({u1.MAX_MATERIAL_TYPES}); extra entries ignored`));
        local v2 = v;

        for i2 = #v.Materials, u1.MAX_MATERIAL_TYPES + 1, -1 do
            v2.Materials[i2] = nil;
            local _ = i2;
        end;
    end;
end;

local function ResolveSource(p3) -- Line: 401
    -- upvalues: ItemData (copy), PotionData (copy), BuffPotionData (copy), PackageData (copy), EquipmentTemplates (copy), CosmeticData (copy), QuestItemData (copy), ClassItemData (copy)
    local OutputType = p3.OutputType;
    local OutputId = p3.OutputId;

    if OutputType == "CraftingMaterial" then
        local Material = ItemData.GetMaterial(OutputId);

        if Material then
            return {
                Name = Material.Name,
                Rarity = Material.Rarity,
                Icon = Material.Icon,
                Description = Material.Description
            };
        end;
    elseif OutputType == "Potion" then
        local Potion = PotionData.GetPotion(OutputId);

        if Potion then
            return {
                Rarity = nil,
                Name = Potion.Name,
                Icon = Potion.Icon,
                Description = Potion.Description
            };
        end;
    elseif OutputType == "BuffPotion" then
        local Potion = BuffPotionData.GetPotion(OutputId);

        if Potion then
            return {
                Rarity = nil,
                Name = Potion.Name,
                Icon = Potion.Icon,
                Description = Potion.Description
            };
        end;
    elseif OutputType == "Package" then
        local v4 = PackageData.Get(OutputId);

        if v4 then
            return {
                Name = v4.Name,
                Rarity = v4.Rarity,
                Icon = v4.Icon,
                Description = v4.Description
            };
        end;
    elseif OutputType == "Equipment" then
        local v5 = EquipmentTemplates.GetTemplate and EquipmentTemplates.GetTemplate(OutputId);

        if v5 then
            return {
                Rarity = nil,
                Name = v5.DisplayName,
                Icon = v5.ImageId,
                Description = v5.Description
            };
        end;
    elseif OutputType == "Cosmetic" then
        local v6 = CosmeticData.Get and CosmeticData.Get(OutputId);

        if v6 then
            return {
                Name = v6.Name or OutputId,
                Rarity = v6.Rarity,
                Icon = v6.Icon,
                Description = v6.Description
            };
        end;
    elseif OutputType == "QuestItem" then
        local v7 = QuestItemData.Get(OutputId);

        if v7 then
            return {
                Name = v7.DisplayName,
                Rarity = v7.Rarity,
                Icon = v7.Icon,
                Description = v7.Description
            };
        end;
    else
        local v8 = OutputType == "ClassItem" and ClassItemData.Get(OutputId);

        if v8 then
            return {
                Icon = nil,
                Name = OutputId,
                Rarity = v8.Rarity,
                Description = v8.Description
            };
        end;
    end;

    return {};
end;

function u1.Get(p9: string) -- Line: 463
    -- upvalues: u1 (copy)
    return u1.Recipes[p9];
end;

function u1.Resolve(p10: string) -- Line: 471
    -- upvalues: u1 (copy), ResolveSource (copy)
    local v11 = u1.Recipes[p10];

    if not v11 then
        return nil;
    end;

    local v12 = ResolveSource(v11);

    return {
        RecipeId = p10,
        Category = v11.Category,
        OutputType = v11.OutputType,
        OutputId = v11.OutputId,
        Amount = v11.Amount,
        GenerateStats = v11.GenerateStats,
        Name = v11.Name or (v12.Name or p10),
        Rarity = v11.Rarity or (v12.Rarity or "Common"),
        Icon = v11.Icon or (v12.Icon or ""),
        Description = v11.Description or (v12.Description or ""),
        ShowDescription = v11.ShowDescription,
        CoinCost = v11.CoinCost or 0,
        Materials = v11.Materials
    };
end;

function u1.ResolveMaterial(p13: string) -- Line: 496
    -- upvalues: ItemData (copy)
    local Material = ItemData.GetMaterial(p13);

    return Material and {
        Name = Material.Name or p13,
        Rarity = Material.Rarity or "Common",
        Icon = Material.Icon or ""
    } or {
        Rarity = "Common",
        Icon = "",
        Name = p13
    };
end;

function u1.GetByCategory(p14: string?) -- Line: 507
    -- upvalues: RarityData (copy), u1 (copy)
    local RarityIndex = RarityData.RarityIndex;
    local u15 = {};

    local function rank(p16: string) -- Line: 515
        -- upvalues: u15 (copy), u1 (ref), RarityIndex (copy)
        local v17 = u15[p16];

        if v17 == nil then
            local v18 = u1.Resolve(p16);
            v17 = v18 and RarityIndex[v18.Rarity] or RarityIndex.Common;
            u15[p16] = v17;
        end;

        return v17;
    end;

    local v19 = {};

    for i, v in u1.Recipes do
        if p14 == nil or (p14 == "All" or v.Category == p14) then
            table.insert(v19, i);
        end;
    end;

    table.sort(v19, function(p20, p21) -- Line: 531
        -- upvalues: u15 (copy), u1 (ref), RarityIndex (copy)
        local v22 = u15[p20];

        if v22 == nil then
            local v23 = u1.Resolve(p20);
            v22 = v23 and RarityIndex[v23.Rarity] or RarityIndex.Common;
            u15[p20] = v22;
        end;

        local v24 = u15[p21];

        if v24 == nil then
            local v25 = u1.Resolve(p21);
            v24 = v25 and RarityIndex[v25.Rarity] or RarityIndex.Common;
            u15[p21] = v24;
        end;

        if v22 == v24 then
            return p20 < p21;
        end;

        return v22 < v24;
    end);

    return v19;
end;

return u1;