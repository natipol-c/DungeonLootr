--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ItemData
  Path:     game.ReplicatedStorage.GameInfo.ItemData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Image_Data = require(ReplicatedStorage.GameInfo.Image_Data);
local u1 = {
    Common = 5,
    Uncommon = 15,
    Rare = 50,
    Epic = 150,
    Legendary = 500,
    Mythic = 2000,
    Celestial = 8000
};

local function Material(p2, p3, p4, p5) -- Line: 69
    -- upvalues: u1 (copy)
    local v6 = {
        Category = "Material",
        MaxStack = 999,
        Icon = "",
        Rarity = p2,
        SellPrice = u1[p2] or 0,
        Description = p4 or "Used to craft " .. p2 .. " upgrade materials.",
        Dungeon = p3
    };

    if p5 then
        for i, v in p5 do
            v6[i] = v;
        end;
    end;

    return v6;
end;

local u7 = {};
local v8 = {
    SellPrice = 0,
    Icon = Image_Data.ForgeMaterials["Forge Stone"]
};
local v9 = {
    Category = "Material",
    Rarity = "Mythic",
    MaxStack = 999,
    Description = "Consumed to forge T4+ equipment beyond its stat caps.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Mythic or 0
};

if v8 then
    for i, v in v8 do
        v9[i] = v;
    end;
end;

u7["Forge Stone"] = v9;
local v10 = {
    SellPrice = 0,
    Icon = Image_Data.ForgeMaterials["Reforge Stone"]
};
local v11 = {
    Category = "Material",
    Rarity = "Mythic",
    MaxStack = 999,
    Description = "Consumed to re-roll an item\'s selected forge stats.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Mythic or 0
};

if v10 then
    for i, v in v10 do
        v11[i] = v;
    end;
end;

u7["Reforge Stone"] = v11;
local v12 = {
    SellPrice = 0,
    Icon = Image_Data.Ingots.Common
};
local v13 = {
    Category = "Material",
    Rarity = "Common",
    MaxStack = 999,
    Description = "Refined ingot used to upgrade Common equipment at the Forge.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Common or 0
};

if v12 then
    for i, v in v12 do
        v13[i] = v;
    end;
end;

u7["Common Ingot"] = v13;
local v14 = {
    SellPrice = 0,
    Icon = Image_Data.Ingots.Uncommon
};
local v15 = {
    Category = "Material",
    Rarity = "Uncommon",
    MaxStack = 999,
    Description = "Refined ingot used to upgrade Uncommon equipment at the Forge.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Uncommon or 0
};

if v14 then
    for i, v in v14 do
        v15[i] = v;
    end;
end;

u7["Uncommon Ingot"] = v15;
local v16 = {
    SellPrice = 0,
    Icon = Image_Data.Ingots.Rare
};
local v17 = {
    Category = "Material",
    Rarity = "Rare",
    MaxStack = 999,
    Description = "Refined ingot used to upgrade Rare equipment at the Forge.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Rare or 0
};

if v16 then
    for i, v in v16 do
        v17[i] = v;
    end;
end;

u7["Rare Ingot"] = v17;
local v18 = {
    SellPrice = 0,
    Icon = Image_Data.Ingots.Epic
};
local v19 = {
    Category = "Material",
    Rarity = "Epic",
    MaxStack = 999,
    Description = "Refined ingot used to upgrade Epic equipment at the Forge.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Epic or 0
};

if v18 then
    for i, v in v18 do
        v19[i] = v;
    end;
end;

u7["Epic Ingot"] = v19;
local v20 = {
    SellPrice = 0,
    Icon = Image_Data.Ingots.Legendary
};
local v21 = {
    Category = "Material",
    Rarity = "Legendary",
    MaxStack = 999,
    Description = "Refined ingot used to upgrade Legendary equipment at the Forge.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Legendary or 0
};

if v20 then
    for i, v in v20 do
        v21[i] = v;
    end;
end;

u7["Legendary Ingot"] = v21;
local v22 = {
    SellPrice = 0,
    Icon = Image_Data.Ingots.Mythic
};
local v23 = {
    Category = "Material",
    Rarity = "Mythic",
    MaxStack = 999,
    Description = "Refined ingot used to upgrade Mythic equipment at the Forge.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Mythic or 0
};

if v22 then
    for i, v in v22 do
        v23[i] = v;
    end;
end;

u7["Mythic Ingot"] = v23;
local v24 = {
    SellPrice = 0,
    Icon = Image_Data.Ingots.Celestial
};
local v25 = {
    Category = "Material",
    Rarity = "Celestial",
    MaxStack = 999,
    Description = "Refined ingot used to upgrade Celestial equipment at the Forge.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Celestial or 0
};

if v24 then
    for i, v in v24 do
        v25[i] = v;
    end;
end;

u7["Celestial Ingot"] = v25;
local v26 = {
    SellPrice = 0,
    Icon = Image_Data.Ingots.Exotic
};
local v27 = {
    Category = "Material",
    Rarity = "Exotic",
    MaxStack = 999,
    Description = "Refined ingot used to upgrade Exotic equipment at the Forge.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Exotic or 0
};

if v26 then
    for i, v in v26 do
        v27[i] = v;
    end;
end;

u7["Exotic Ingot"] = v27;
local v28 = {
    SellPrice = 0,
    Icon = "rbxassetid://95204563492668"
};
local v29 = {
    Category = "Material",
    Rarity = "Exotic",
    MaxStack = 999,
    Description = "Condensed exotic power. Consumed to craft Exotic equipment at the bench.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Exotic or 0
};

if v28 then
    for i, v in v28 do
        v29[i] = v;
    end;
end;

u7["Exotic Essence"] = v29;
local v30 = {
    SellPrice = 0,
    Icon = "rbxassetid://103615932936480"
};
local v31 = {
    Category = "Material",
    Rarity = "Exotic",
    MaxStack = 999,
    Description = "The shattered remains of a fallen Exotic. Reforged into new Exotic equipment at the bench.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Exotic or 0
};

if v30 then
    for i, v in v30 do
        v31[i] = v;
    end;
end;

u7["Exotic Shattered Armor"] = v31;
local v32 = {
    SellPrice = 0,
    Icon = Image_Data.Ores.ExoticOre
};
local v33 = {
    Category = "Material",
    Rarity = "Exotic",
    MaxStack = 999,
    Description = "Otherworldly ore torn from the Crimson Revenant. Refined into Exotic Ingots at the bench.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Exotic or 0
};

if v32 then
    for i, v in v32 do
        v33[i] = v;
    end;
end;

u7["Exotic Ore"] = v33;
local v34 = {
    SellPrice = 0,
    Icon = "rbxassetid://98197382653594"
};
local v35 = {
    Category = "Material",
    Rarity = "Exotic",
    MaxStack = 999,
    Description = "A shard of nullified magic left by the Anti Mage. Collect 50 to craft the Anti Magic Claymore at the bench.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Exotic or 0
};

if v34 then
    for i, v in v34 do
        v35[i] = v;
    end;
end;

u7["Anti Magic Fragment"] = v35;
local v36 = {
    SellPrice = 0,
    Icon = "rbxassetid://134413637295957"
};
local v37 = {
    Category = "Material",
    Rarity = "Exotic",
    MaxStack = 999,
    Description = "A splinter of the Cursed King\'s idol, humming with cursed energy. Collect 50 to craft the Cursed Shrine at the bench.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Exotic or 0
};

if v36 then
    for i, v in v36 do
        v37[i] = v;
    end;
end;

u7["Cursed Fragment"] = v37;
local v38 = {
    SellPrice = 0,
    Icon = "rbxassetid://76397678683502"
};
local v39 = {
    Category = "Material",
    Rarity = "Exotic",
    MaxStack = 999,
    Description = "A mote of boundless power shed by the Honored One. Collect 50 to craft the Infinity Core at the bench.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Exotic or 0
};

if v38 then
    for i, v in v38 do
        v39[i] = v;
    end;
end;

u7["Infinity Fragment"] = v39;
local v40 = {
    Icon = Image_Data.Ores.IronScrap
};
local v41 = {
    Category = "Material",
    Rarity = "Common",
    MaxStack = 999,
    Description = "Raw scrap salvaged from Bandit & Goblin dungeons. Refined into low-rarity Ingots.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Common or 0
};

if v40 then
    for i, v in v40 do
        v41[i] = v;
    end;
end;

u7["Iron Scrap"] = v41;
local v42 = {
    Icon = Image_Data.Ores.IronOre
};
local v43 = {
    Category = "Material",
    Rarity = "Uncommon",
    MaxStack = 999,
    Description = "Rough iron ore from the Knight ruins. Refined into low-rarity Ingots.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Uncommon or 0
};

if v42 then
    for i, v in v42 do
        v43[i] = v;
    end;
end;

u7["Iron Ore"] = v43;
local v44 = {
    Icon = Image_Data.Ores.GoldOre
};
local v45 = {
    Category = "Material",
    Rarity = "Rare",
    MaxStack = 999,
    Description = "Precious gold ore from the Catacombs & Frostspire. Refined into mid-rarity Ingots.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Rare or 0
};

if v44 then
    for i, v in v44 do
        v45[i] = v;
    end;
end;

u7["Gold Ore"] = v45;
local v46 = {
    Icon = Image_Data.Ores.ObsidianOre
};
local v47 = {
    Category = "Material",
    Rarity = "Epic",
    MaxStack = 999,
    Description = "Volcanic glass from Frostspire & the Underworld. Refined into high-rarity Ingots.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Epic or 0
};

if v46 then
    for i, v in v46 do
        v47[i] = v;
    end;
end;

u7["Obsidian Ore"] = v47;
local v48 = {
    Icon = Image_Data.Ores.InfernalOre
};
local v49 = {
    Category = "Material",
    Rarity = "Legendary",
    MaxStack = 999,
    Description = "Molten ore torn from the deepest Underworld. Refined into Legendary Ingots.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Legendary or 0
};

if v48 then
    for i, v in v48 do
        v49[i] = v;
    end;
end;

u7["Infernal Ore"] = v49;
local v50 = {
    Icon = Image_Data.Ores.RadiantOre
};
local v51 = {
    Category = "Material",
    Rarity = "Mythic",
    MaxStack = 999,
    Description = "Luminous ore that glows from within. Refined into Mythic Ingots.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Mythic or 0
};

if v50 then
    for i, v in v50 do
        v51[i] = v;
    end;
end;

u7["Radiant Ore"] = v51;
local v52 = {
    Icon = Image_Data.Ores.CelestialOre
};
local v53 = {
    Category = "Material",
    Rarity = "Celestial",
    MaxStack = 999,
    Description = "Otherworldly ore forged beyond the Underworld. Refined into Celestial Ingots.",
    Icon = "",
    Dungeon = nil,
    SellPrice = u1.Celestial or 0
};

if v52 then
    for i, v in v52 do
        v53[i] = v;
    end;
end;

u7["Celestial Ore"] = v53;

for i, v in u7 do
    v.Id = i;

    if v.Name == nil then
        v.Name = i;
    end;
end;

local u54 = {
    ["Forest Challenge"] = "Bandits Den"
};
local u55 = { "Iron Scrap", "Iron Ore", "Gold Ore", "Obsidian Ore", "Infernal Ore", "Radiant Ore", "Celestial Ore" };
local u56 = {
    Forest = 1,
    ["Bandits Den"] = 1,
    Goblins = 1,
    Knights = 2,
    Catacombs = 3,
    Snow = {
        Easy = 3,
        Normal = 3,
        Hard = 4,
        Nightmare = 4,
        Endless = 4
    },
    Demon = {
        Easy = 4,
        Normal = 4,
        Hard = 5,
        Nightmare = 6,
        Endless = 7
    }
};

local function ResolveDungeonId(p57: string) -- Line: 213
    -- upvalues: u54 (copy)
    return u54[p57] or p57;
end;

local function ResolveTopTier(p58: string, p59: string?) -- Line: 220
    -- upvalues: u56 (copy), u54 (copy)
    local v60 = u56[u54[p58] or p58];

    if type(v60) == "number" then
        return v60;
    end;

    if type(v60) == "table" then
        return v60[p59 or "Easy"] or v60.Easy;
    end;

    return nil;
end;

local u61 = {
    Normal = {
        Chance = 0.05,
        Min = 1,
        Max = 1
    },
    Elite = {
        Chance = 0.25,
        Min = 1,
        Max = 2
    },
    MiniBoss = {
        Chance = 0.75,
        Min = 1,
        Max = 2
    },
    Boss = {
        Chance = 1,
        Min = 2,
        Max = 4
    }
};
local u69 = {
    Index = u7,
    DisplayOrder = {},
    DUNGEON_POOL_ALIAS = u54,

    GetMaterial = function(p62: string) -- Line: 260, Name: GetMaterial
        -- upvalues: u7 (copy)
        return u7[p62];
    end,

    GetDungeonMaterialPool = function(p63: string, p64: string?) -- Line: 268, Name: GetDungeonMaterialPool
        -- upvalues: u56 (copy), u54 (copy), u7 (copy), u55 (copy)
        local v65 = u56[u54[p63] or p63];

        if type(v65) ~= "number" then
            if type(v65) == "table" then
                v65 = v65[p64 or "Easy"] or v65.Easy;
            else
                v65 = nil;
            end;
        end;

        if not v65 then
            return nil;
        end;

        local v66 = {};

        for i = v65, 1, -1 do
            local v67 = u7[u55[i]];
            local v68;

            if v67 then
                table.insert(v66, {
                    Material = v67,
                    Weight = 0.4 ^ (v65 - i)
                });
                v68 = i;
            else
                v68 = i;
            end;
        end;

        return #v66 > 0 and v66 and v66 or nil;
    end
};

function u69.RollDungeonMaterial(p70: string, p71: string?, p72: userdata?) -- Line: 286
    -- upvalues: u69 (copy)
    local DungeonMaterialPool = u69.GetDungeonMaterialPool(p70, p71);

    if not DungeonMaterialPool then
        return nil;
    end;

    local v73 = 0;

    for _, v in DungeonMaterialPool do
        v73 = v73 + v.Weight;
    end;

    local v74 = (p72 and p72:NextNumber() or math.random()) * v73;

    for _, v in DungeonMaterialPool do
        v74 = v74 - v.Weight;

        if v74 <= 0 then
            return v.Material;
        end;
    end;

    return DungeonMaterialPool[1].Material;
end;

local u75 = {
    Common = "Iron Scrap",
    Uncommon = "Iron Ore",
    Rare = "Gold Ore",
    Epic = "Obsidian Ore",
    Legendary = "Infernal Ore",
    Mythic = "Radiant Ore",
    Celestial = "Celestial Ore"
};

function u69.GetOreForRarity(p76: string?) -- Line: 316
    -- upvalues: u75 (copy), u7 (copy)
    local v77 = u75[p76 or ""];

    return v77 and u7[v77] or nil;
end;

u69.ENEMY_MATERIAL_DROP = u61;

function u69.RollEnemyMaterialDrop(p78: string, p79: string?, p80: string, p81: userdata?) -- Line: 330
    -- upvalues: u61 (copy), u69 (copy)
    local v82 = u61[p80];

    if not v82 then
        return nil, nil;
    end;

    if (p81 and p81:NextNumber() or math.random()) > v82.Chance then
        return nil, nil;
    end;

    local v83 = u69.RollDungeonMaterial(p78, p79, p81);

    if not v83 then
        return nil, nil;
    end;

    local Min = v82.Min;

    if v82.Max > v82.Min then
        Min = p81 and p81:NextInteger(v82.Min, v82.Max) or math.random(v82.Min, v82.Max);
    end;

    return v83.Id, Min;
end;

return u69;