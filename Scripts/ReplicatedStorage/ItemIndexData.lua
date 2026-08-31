--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ItemIndexData
  Path:     game.ReplicatedStorage.GameInfo.ItemIndexData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GameInfo = ReplicatedStorage:WaitForChild("GameInfo");
local ItemData = require(GameInfo:WaitForChild("ItemData"));
local QuestItemData = require(GameInfo:WaitForChild("QuestItemData"));
local ConsumableData = require(GameInfo:WaitForChild("ConsumableData"));
local BuffPotionData = require(GameInfo:WaitForChild("BuffPotionData"));
local ClassItemData = require(GameInfo:WaitForChild("ClassItemData"));
local PackageData = require(GameInfo:WaitForChild("PackageData"));
local ItemDescriptions = require(GameInfo:WaitForChild("ItemDescriptions"));
local Image_Data = require(GameInfo:WaitForChild("Image_Data"));
local RarityData = require(GameInfo:WaitForChild("RarityData"));
local RarityColors = require(ReplicatedStorage:WaitForChild("SharedDictionaries"):WaitForChild("RarityColors"));
local u1 = {
    Tabs = { "All", "Materials", "Consumable", "Quest", "ClassItem", "Package" }
};
local Color3_fromRGB_ret = Color3.fromRGB(95, 235, 130);

local function toHex(p2) -- Line: 58
    return string.format("#%02X%02X%02X", math.floor(p2.R * 255 + 0.5), math.floor(p2.G * 255 + 0.5), (math.floor(p2.B * 255 + 0.5)));
end;

local function span(p3: string, p4) -- Line: 63
    return `<font color="{string.format("#%02X%02X%02X", math.floor(p4.R * 255 + 0.5), math.floor(p4.G * 255 + 0.5), (math.floor(p4.B * 255 + 0.5)))}">{p3}</font>`;
end;

local function rar(p5: string) -- Line: 68
    -- upvalues: RarityColors (copy)
    local v6 = RarityColors[p5];
    local v7 = v6 and v6.TextColor3 or Color3.new(1, 1, 1);

    return `<font color="{string.format("#%02X%02X%02X", math.floor(v7.R * 255 + 0.5), math.floor(v7.G * 255 + 0.5), (math.floor(v7.B * 255 + 0.5)))}">{p5}</font>`;
end;

local function loc(p8: string) -- Line: 74
    -- upvalues: Color3_fromRGB_ret (copy)
    local v9 = Color3_fromRGB_ret;

    return `<font color="{string.format("#%02X%02X%02X", math.floor(v9.R * 255 + 0.5), math.floor(v9.G * 255 + 0.5), (math.floor(v9.B * 255 + 0.5)))}">{p8}</font>`;
end;

local v10 = {};
local v11 = {
    Id = "Iron Scrap",
    Tab = "Materials",
    Source = "ItemData",
    Obtain = `Drops from chests and enemies across the early {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Bandit</font>`}, {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Goblin</font>`} and {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Knight</font>`} dungeons. Refined into low-rarity Ingots at the Forge.`
};
local v12 = {
    Id = "Iron Ore",
    Tab = "Materials",
    Source = "ItemData",
    Obtain = `Drops from chests and enemies in the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Knight</font>`} ruins and above. Refined into Ingots at the Forge.`
};
local v13 = {
    Id = "Gold Ore",
    Tab = "Materials",
    Source = "ItemData",
    Obtain = `Drops from chests and enemies in the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Catacombs</font>`} and {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Frostspire</font>`}. Refined into mid-rarity Ingots.`
};
local v14 = {
    Id = "Obsidian Ore",
    Tab = "Materials",
    Source = "ItemData"
};
local v15 = `<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Frostspire</font>`;
local Hard = RarityColors.Hard;
local v16 = Hard and Hard.TextColor3 or Color3.new(1, 1, 1);
v14.Obtain = `Drops from chests and enemies in {v15} ({`<font color="{string.format("#%02X%02X%02X", math.floor(v16.R * 255 + 0.5), math.floor(v16.G * 255 + 0.5), (math.floor(v16.B * 255 + 0.5)))}">Hard</font>`}+) and the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Underworld</font>`}. Refined into high-rarity Ingots.`;
local v17 = {
    Id = "Infernal Ore",
    Tab = "Materials",
    Source = "ItemData"
};
local v18 = `<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Underworld</font>`;
local Hard2 = RarityColors.Hard;
local v19 = Hard2 and Hard2.TextColor3 or Color3.new(1, 1, 1);
local v20 = `<font color="{string.format("#%02X%02X%02X", math.floor(v19.R * 255 + 0.5), math.floor(v19.G * 255 + 0.5), (math.floor(v19.B * 255 + 0.5)))}">Hard</font>`;
local Legendary = RarityColors.Legendary;
local v21 = Legendary and Legendary.TextColor3 or Color3.new(1, 1, 1);
v17.Obtain = `Drops from chests and enemies in the {v18} on {v20} difficulty or above. Refined into {`<font color="{string.format("#%02X%02X%02X", math.floor(v21.R * 255 + 0.5), math.floor(v21.G * 255 + 0.5), (math.floor(v21.B * 255 + 0.5)))}">Legendary</font>`} Ingots.`;
local v22 = {
    Id = "Radiant Ore",
    Tab = "Materials",
    Source = "ItemData"
};
local v23 = `<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Underworld</font>`;
local Nightmare = RarityColors.Nightmare;
local v24 = Nightmare and Nightmare.TextColor3 or Color3.new(1, 1, 1);
local v25 = `<font color="{string.format("#%02X%02X%02X", math.floor(v24.R * 255 + 0.5), math.floor(v24.G * 255 + 0.5), (math.floor(v24.B * 255 + 0.5)))}">Nightmare</font>`;
local Mythic = RarityColors.Mythic;
local v26 = Mythic and Mythic.TextColor3 or Color3.new(1, 1, 1);
v22.Obtain = `Drops from chests and enemies in the {v23} on {v25}. Refined into {`<font color="{string.format("#%02X%02X%02X", math.floor(v26.R * 255 + 0.5), math.floor(v26.G * 255 + 0.5), (math.floor(v26.B * 255 + 0.5)))}">Mythic</font>`} Ingots.`;
local v27 = {
    Id = "Celestial Ore",
    Tab = "Materials",
    Source = "ItemData"
};
local v28 = `<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Underworld</font>`;
local Endless = RarityColors.Endless;
local v29 = Endless and Endless.TextColor3 or Color3.new(1, 1, 1);
local v30 = `<font color="{string.format("#%02X%02X%02X", math.floor(v29.R * 255 + 0.5), math.floor(v29.G * 255 + 0.5), (math.floor(v29.B * 255 + 0.5)))}">Endless</font>`;
local Celestial = RarityColors.Celestial;
local v31 = Celestial and Celestial.TextColor3 or Color3.new(1, 1, 1);
v27.Obtain = `Drops from chests and enemies in the {v28} on {v30}, or crafted at the Forge. Refined into {`<font color="{string.format("#%02X%02X%02X", math.floor(v31.R * 255 + 0.5), math.floor(v31.G * 255 + 0.5), (math.floor(v31.B * 255 + 0.5)))}">Celestial</font>`} Ingots.`;
local v32 = {
    Id = "Exotic Ore",
    Tab = "Materials",
    Source = "ItemData"
};
local v33 = `<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Scarlet Knight</font>`;
local v34 = `<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Underworld</font>`;
local Nightmare2 = RarityColors.Nightmare;
local v35 = Nightmare2 and Nightmare2.TextColor3 or Color3.new(1, 1, 1);
local v36 = `<font color="{string.format("#%02X%02X%02X", math.floor(v35.R * 255 + 0.5), math.floor(v35.G * 255 + 0.5), (math.floor(v35.B * 255 + 0.5)))}">Nightmare</font>`;
local Exotic = RarityColors.Exotic;
local v37 = Exotic and Exotic.TextColor3 or Color3.new(1, 1, 1);
v32.Obtain = `Guaranteed drop from the {v33} special boss in the {v34} ({v36}+). The sole source — refined into {`<font color="{string.format("#%02X%02X%02X", math.floor(v37.R * 255 + 0.5), math.floor(v37.G * 255 + 0.5), (math.floor(v37.B * 255 + 0.5)))}">Exotic</font>`} Ingots.`;
local v38 = {
    Id = "Common Ingot",
    Tab = "Materials",
    Source = "ItemData",
    Obtain = `Crafted at the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Forge</font>`} bench from raw ores. Also earned from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Battlepass</font>`}.`
};
local v39 = {
    Id = "Uncommon Ingot",
    Tab = "Materials",
    Source = "ItemData",
    Obtain = `Crafted at the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Forge</font>`} bench from raw ores. Also earned from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Battlepass</font>`}.`
};
local v40 = {
    Id = "Rare Ingot",
    Tab = "Materials",
    Source = "ItemData",
    Obtain = `Crafted at the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Forge</font>`} bench from raw ores. Also earned from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Battlepass</font>`} and {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Boss Rush</font>`}.`
};
local v41 = {
    Id = "Epic Ingot",
    Tab = "Materials",
    Source = "ItemData",
    Obtain = `Crafted at the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Forge</font>`} bench from raw ores. Also earned from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Battlepass</font>`} and {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Boss Rush</font>`}.`
};
local v42 = {
    Id = "Legendary Ingot",
    Tab = "Materials",
    Source = "ItemData",
    Obtain = `Crafted at the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Forge</font>`} bench from raw ores. Also earned from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Battlepass</font>`}, {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Boss Rush</font>`} and {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Challenge Dungeon</font>`}.`
};
local v43 = {
    Id = "Mythic Ingot",
    Tab = "Materials",
    Source = "ItemData",
    Obtain = `Crafted at the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Forge</font>`} bench from raw ores. Also earned from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Battlepass</font>`}, {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Boss Rush</font>`} and {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Challenge Dungeon</font>`}.`
};
local v44 = {
    Id = "Celestial Ingot",
    Tab = "Materials",
    Source = "ItemData"
};
local v45 = `<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Forge</font>`;
local Celestial2 = RarityColors.Celestial;
local v46 = Celestial2 and Celestial2.TextColor3 or Color3.new(1, 1, 1);
v44.Obtain = `Crafted at the {v45} bench from {`<font color="{string.format("#%02X%02X%02X", math.floor(v46.R * 255 + 0.5), math.floor(v46.G * 255 + 0.5), (math.floor(v46.B * 255 + 0.5)))}">Celestial</font>`} Ore. Also earned from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Battlepass</font>`}, {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Boss Rush</font>`} and {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Challenge Dungeon</font>`}.`;
local v47 = {
    Id = "Exotic Ingot",
    Tab = "Materials",
    Source = "ItemData"
};
local v48 = `<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Forge</font>`;
local Exotic2 = RarityColors.Exotic;
local v49 = Exotic2 and Exotic2.TextColor3 or Color3.new(1, 1, 1);
v47.Obtain = `Crafted at the {v48} bench from {`<font color="{string.format("#%02X%02X%02X", math.floor(v49.R * 255 + 0.5), math.floor(v49.G * 255 + 0.5), (math.floor(v49.B * 255 + 0.5)))}">Exotic</font>`} Ore — the only way to obtain it.`;
v10[1], v10[2], v10[3], v10[4], v10[5], v10[6], v10[7], v10[8], v10[9], v10[10], v10[11], v10[12], v10[13], v10[14], v10[15], v10[16] = v11, v12, v13, v14, v17, v22, v27, v32, v38, v39, v40, v41, v42, v43, v44, v47;
local v50 = {
    Id = "Reforge Stone",
    Tab = "Materials",
    Source = "ItemData"
};
local Mythic2 = RarityColors.Mythic;
local v51 = Mythic2 and Mythic2.TextColor3 or Color3.new(1, 1, 1);
local v52 = `<font color="{string.format("#%02X%02X%02X", math.floor(v51.R * 255 + 0.5), math.floor(v51.G * 255 + 0.5), (math.floor(v51.B * 255 + 0.5)))}">Mythic</font>`;
local Celestial3 = RarityColors.Celestial;
local v53 = Celestial3 and Celestial3.TextColor3 or Color3.new(1, 1, 1);
v50.Obtain = `Bonus drop from {v52}+ locked-room chests — 25% (Gold key), 40% (Platinum), 60% ({`<font color="{string.format("#%02X%02X%02X", math.floor(v53.R * 255 + 0.5), math.floor(v53.G * 255 + 0.5), (math.floor(v53.B * 255 + 0.5)))}">Celestial</font>`}). {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Boss Rush</font>`} bosses drop it by tier: 5% {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Regular</font>`}, 15% {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Empowered</font>`}, 30% {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Enraged</font>`}, plus milestone rewards. Also from {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Challenge Dungeon</font>`} milestones and the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Battlepass</font>`}. Used at the Forge to re-roll an item's stats.`;
local v54 = {
    Id = "Exotic Essence",
    Tab = "Materials",
    Source = "ItemData"
};
local v55 = `<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Challenge Dungeon</font>`;
local Exotic3 = RarityColors.Exotic;
local v56 = Exotic3 and Exotic3.TextColor3 or Color3.new(1, 1, 1);
v54.Obtain = `Dropped by {v55} bosses. A crafting input for {`<font color="{string.format("#%02X%02X%02X", math.floor(v56.R * 255 + 0.5), math.floor(v56.G * 255 + 0.5), (math.floor(v56.B * 255 + 0.5)))}">Exotic</font>`} equipment at the Forge.`;
local v57 = {
    Id = "Exotic Shattered Armor",
    Tab = "Materials",
    Source = "ItemData"
};
local Nightmare3 = RarityColors.Nightmare;
local v58 = Nightmare3 and Nightmare3.TextColor3 or Color3.new(1, 1, 1);
local v59 = `<font color="{string.format("#%02X%02X%02X", math.floor(v58.R * 255 + 0.5), math.floor(v58.G * 255 + 0.5), (math.floor(v58.B * 255 + 0.5)))}">Nightmare</font>`;
local v60 = `<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Scarlet Knight</font>`;
local v61 = `<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Underworld</font>`;
local Exotic4 = RarityColors.Exotic;
local v62 = Exotic4 and Exotic4.TextColor3 or Color3.new(1, 1, 1);
v57.Obtain = `Rare drop ({v59}+) from the {v60} in the {v61}. A crafting input for {`<font color="{string.format("#%02X%02X%02X", math.floor(v62.R * 255 + 0.5), math.floor(v62.G * 255 + 0.5), (math.floor(v62.B * 255 + 0.5)))}">Exotic</font>`} equipment.`;
local v63 = {
    Id = "Anti Magic Fragment",
    Tab = "Materials",
    Source = "ItemData",
    Obtain = `Guaranteed drop from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Anti Mage</font>`} at {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Boss Rush</font>`} Floor 100. Collect 50 to craft the Anti Magic Claymore.`
};
local v64 = {
    Id = "Cursed Fragment",
    Tab = "Materials",
    Source = "ItemData",
    Obtain = `Guaranteed drop from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Cursed King</font>`} at {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Boss Rush</font>`} Floor 100. Collect 50 to craft the Cursed Shrine.`
};
local v65 = {
    Id = "Infinity Fragment",
    Tab = "Materials",
    Source = "ItemData",
    Obtain = `Guaranteed drop from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Honored One</font>`} at {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Boss Rush</font>`} Floor 100. Collect 50 to craft the Infinity Core.`
};
local v66 = {
    Id = "LuckPotionT1",
    Tab = "Consumable",
    Source = "BuffPotion",
    Rarity = "Uncommon",
    Obtain = `Earned from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Battlepass</font>`}. Grants a temporary Loot Luck boost that stacks with other Luck tiers.`
};
local v67 = {
    Id = "LuckPotionT2",
    Tab = "Consumable",
    Source = "BuffPotion",
    Rarity = "Legendary",
    Obtain = `Earned from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Battlepass</font>`} and {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Challenge Dungeon</font>`} rewards. Grants a temporary Loot Luck boost.`
};
local v68 = {
    Id = "LuckPotionT3",
    Tab = "Consumable",
    Source = "BuffPotion",
    Rarity = "Exotic",
    Obtain = `Earned from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Battlepass</font>`} and {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Challenge Dungeon</font>`} rewards. Grants a strong temporary Loot Luck boost.`
};
local v69 = {
    Id = "ProtectionScroll",
    Tab = "Consumable",
    Source = "Scroll",
    Obtain = `Earned from {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Challenge Dungeon</font>`} rewards and {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Challenge Dungeon</font>`} chests, or bought from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">shop</font>`}. Protects a forge from downgrading on failure.`
};
local v70 = {
    Id = "AspectGem",
    Tab = "Consumable",
    Source = "Consumable",
    Obtain = `Earned from {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Challenge Dungeon</font>`} milestone rewards. Consume to roll a random Aspect onto your equipped class.`
};
local v71 = {
    Id = "BossRushSkipTicket",
    Tab = "Consumable",
    Source = "Consumable",
    Obtain = `Earned from {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Challenge Dungeon</font>`} milestone rewards. Spend at {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Boss Rush</font>`} to skip ahead in 10-floor steps.`
};
local v72 = {
    Id = "Purity Stone",
    Tab = "Consumable",
    Source = "QuestItem",
    Obtain = `Earned from {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Challenge Dungeon</font>`} and {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Boss Rush</font>`} rewards, or crafted at the Forge. Enhances a forge attempt's success chance.`
};
local v73 = {
    Id = "Devil Heart",
    Tab = "Quest",
    Source = "QuestItem"
};
local v74 = `<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Awakened Devil</font>`;
local v75 = `<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Frostspire</font>`;
local Nightmare4 = RarityColors.Nightmare;
local v76 = Nightmare4 and Nightmare4.TextColor3 or Color3.new(1, 1, 1);
v73.Obtain = `Rare extract from the {v74} on {v75} ({`<font color="{string.format("#%02X%02X%02X", math.floor(v76.R * 255 + 0.5), math.floor(v76.G * 255 + 0.5), (math.floor(v76.B * 255 + 0.5)))}">Nightmare</font>`}+). Turned in to Valen and Jetstream.`;
v10[17], v10[18], v10[19], v10[20], v10[21], v10[22], v10[23], v10[24], v10[25], v10[26], v10[27], v10[28], v10[29], v10[30], v10[31], v10[32] = v50, v54, v57, v63, v64, v65, v66, v67, v68, v69, v70, v71, v72, v73, {
    Id = "Heavenly Fragment",
    Tab = "Quest",
    Source = "QuestItem",
    Obtain = `A {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">15%</font>`} chance per player to drop from each {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Challenge Dungeon</font>`} boss wave past Wave 40 — the bosses headlining waves 50, 60, 70, and on. Turned in to the Unrestricted to forge the Inverted Spear.`
}, {
    Id = "Anti Magic Claymore",
    Tab = "ClassItem",
    Source = "ClassItem",
    Obtain = `Rare drop from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Anti Mage</font>`} at {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Boss Rush</font>`} Floor 100, or crafted from 50 Anti Magic Fragments.`
};
v10[33], v10[34], v10[35], v10[36], v10[37], v10[38], v10[39] = {
    Id = "Cursed Shrine",
    Tab = "ClassItem",
    Source = "ClassItem",
    Obtain = `Rare drop from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Cursed King</font>`} at {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Boss Rush</font>`} Floor 100, or crafted from 50 Cursed Fragments.`
}, {
    Id = "Infinity Core",
    Tab = "ClassItem",
    Source = "ClassItem",
    Obtain = `Rare drop from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Honored One</font>`} at {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Boss Rush</font>`} Floor 100, or crafted from 50 Infinity Fragments.`
}, {
    Id = "Great Mage Staff",
    Tab = "ClassItem",
    Source = "ClassItem",
    Obtain = `Awarded from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Battlepass</font>`} (Tier 50), or a rare drop from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Great Mage</font>`} at {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Boss Rush</font>`} Floor 100.`
}, {
    Id = "Underworld Glaive",
    Tab = "ClassItem",
    Source = "ClassItem",
    Obtain = `A rare class-item reward from clearing the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Underworld</font>`} dungeon.`
}, {
    Id = "MaterialBundle_Tier1",
    Tab = "Package",
    Source = "Package",
    Obtain = `Earned from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Battlepass</font>`}. Opens into a random early-tier ore.`
}, {
    Id = "MaterialBundle_Tier2",
    Tab = "Package",
    Source = "Package",
    Obtain = `Earned from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Battlepass</font>`}. Opens into a random mid-tier ore.`
}, {
    Id = "MaterialBundle_Tier3",
    Tab = "Package",
    Source = "Package",
    Obtain = `Earned from the {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Battlepass</font>`} and {`<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromRGB_ret.R * 255 + 0.5), math.floor(Color3_fromRGB_ret.G * 255 + 0.5), (math.floor(Color3_fromRGB_ret.B * 255 + 0.5)))}">Challenge Dungeon</font>`} rewards. Opens into a random high-tier ore.`
};
u1.Entries = v10;

local function ResolveClassItemIcon(p77: string, p78: any) -- Line: 191
    -- upvalues: Image_Data (copy)
    local v79 = Image_Data.Class_Items or {};
    local v80 = v79[string.gsub(p77, "%s", "")];

    if not v80 and (p78 and p78.ClassName) then
        v80 = v79[string.gsub(p78.ClassName, "%s", "")];
    end;

    return v80 or "";
end;

u1.Index = {};

local function ResolveSource(p81) -- Line: 200
    -- upvalues: ItemData (copy), QuestItemData (copy), ConsumableData (copy), BuffPotionData (copy), ClassItemData (copy), ResolveClassItemIcon (copy), PackageData (copy), Image_Data (copy), ItemDescriptions (copy)
    local Id = p81.Id;
    local Source = p81.Source;

    if Source == "ItemData" then
        local Material = ItemData.GetMaterial(Id);

        if Material then
            return {
                Name = Material.Name,
                Rarity = Material.Rarity,
                Icon = Material.Icon,
                Description = Material.Description
            };
        end;
    elseif Source == "QuestItem" then
        local v82 = QuestItemData.Get(Id);

        if v82 then
            return {
                Name = v82.DisplayName,
                Rarity = v82.Rarity,
                Icon = v82.Icon,
                Description = v82.Description
            };
        end;
    elseif Source == "Consumable" then
        local Consumable = ConsumableData.GetConsumable(Id);

        if Consumable then
            return {
                Name = Consumable.Name,
                Rarity = Consumable.Rarity,
                Icon = Consumable.Icon,
                Description = Consumable.Description
            };
        end;
    elseif Source == "BuffPotion" then
        local Potion = BuffPotionData.GetPotion(Id);

        if Potion then
            return {
                Rarity = nil,
                Name = Potion.Name,
                Icon = Potion.Icon,
                Description = Potion.Description
            };
        end;
    elseif Source == "ClassItem" then
        local v83 = ClassItemData.Get(Id);

        if v83 then
            return {
                Name = Id,
                Rarity = v83.Rarity,
                Icon = ResolveClassItemIcon(Id, v83),
                Description = v83.Description or "Equip to become a " .. (v83.ClassName or "?") .. "."
            };
        end;
    elseif Source == "Package" then
        local v84 = PackageData.Get(Id);

        if v84 then
            return {
                Name = v84.Name,
                Rarity = v84.Rarity,
                Icon = v84.Icon,
                Description = v84.Description
            };
        end;
    elseif Source == "Scroll" then
        return {
            Name = "Protection Scroll",
            Rarity = "Common",
            Icon = Image_Data.Rewards and Image_Data.Rewards.ProtectionScroll or "",
            Description = ItemDescriptions.Get("ProtectionScroll")
        };
    end;

    return {};
end;

for _, v in u1.Entries do
    u1.Index[v.Id] = v;
end;

local RarityIndex = RarityData.RarityIndex;
local u85 = {};
local u86 = {};

for _, v in u1.Entries do
    local v87 = ResolveSource(v);
    local v88 = v.Rarity or (v87.Rarity or "Common");
    u85[v] = v.Name or (v87.Name or v.Id);
    u86[v] = RarityIndex[v88] or (RarityIndex.Common or 0);
end;

local table_clone_ret = table.clone(u1.Entries);
table.sort(table_clone_ret, function(p89, p90) -- Line: 268
    -- upvalues: u86 (copy), u85 (copy)
    if u86[p89] == u86[p90] then
        return u85[p89] < u85[p90];
    end;

    return u86[p89] < u86[p90];
end);

for i, v in table_clone_ret do
    v.LayoutOrder = i;
end;

function u1.Get(p91: string) -- Line: 282
    -- upvalues: u1 (copy)
    return u1.Index[p91];
end;

function u1.Resolve(p92: string) -- Line: 289
    -- upvalues: u1 (copy), ResolveSource (copy)
    local v93 = u1.Index[p92];

    if not v93 then
        return nil;
    end;

    local v94 = ResolveSource(v93);

    return {
        Id = p92,
        Tab = v93.Tab,
        Name = v93.Name or (v94.Name or p92),
        Rarity = v93.Rarity or (v94.Rarity or "Common"),
        Icon = v93.Icon or (v94.Icon or ""),
        Description = v93.Description or (v94.Description or ""),
        Obtain = v93.Obtain or "",
        LayoutOrder = v93.LayoutOrder or 0
    };
end;

function u1.GetByTab(p95: string?) -- Line: 307
    -- upvalues: u1 (copy)
    local v96 = {};

    for _, v in u1.Entries do
        if p95 == nil or (p95 == "All" or v.Tab == p95) then
            table.insert(v96, v.Id);
        end;
    end;

    table.sort(v96, function(p97, p98) -- Line: 314
        -- upvalues: u1 (ref)
        return (u1.Index[p97].LayoutOrder or 0) < (u1.Index[p98].LayoutOrder or 0);
    end);

    return v96;
end;

return u1;