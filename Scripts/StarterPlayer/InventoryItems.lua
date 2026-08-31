--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     InventoryItems
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.InventoryItems
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local GameInfo = game:GetService("ReplicatedStorage"):WaitForChild("GameInfo");
local PotionData = require(GameInfo:WaitForChild("PotionData"));
local BuffPotionData = require(GameInfo:WaitForChild("BuffPotionData"));
require(GameInfo:WaitForChild("LootChestData"));
local EquipmentTemplates = require(GameInfo:WaitForChild("EquipmentTemplates"));
local Image_Data = require(GameInfo:WaitForChild("Image_Data"));
local ItemDescriptions = require(GameInfo:WaitForChild("ItemDescriptions"));
local CosmeticData = require(GameInfo:WaitForChild("CosmeticData"));
local ClassItemData = require(GameInfo:WaitForChild("ClassItemData"));
local KeyData = require(GameInfo:WaitForChild("KeyData"));
local PackageData = require(GameInfo:WaitForChild("PackageData"));
local QuestItemData = require(GameInfo:WaitForChild("QuestItemData"));
local ItemData = require(GameInfo:WaitForChild("ItemData"));
local RarityData = require(GameInfo:WaitForChild("RarityData"));
local ConsumableData = require(GameInfo:WaitForChild("ConsumableData"));
local CosmeticViewport = require(script.Parent.Parent.ClientUtils.CosmeticViewport);
local EquipmentStatLines = require(script.Parent.Parent.ClientUtils.EquipmentStatLines);
local u1 = {};
local RarityIndex = RarityData.RarityIndex;

function u1.IsEquipped(p2: any, p3: string) -- Line: 48
    local Equipment = p2.Data.Equipment;

    for _, v in { "Head", "Body", "Ring" } do
        local v4 = Equipment[v];

        if type(v4) == "table" and v4.GUID == p3 then
            return true;
        end;
    end;

    return false;
end;

function u1.GetEquippedSlot(p5: any, p6: string) -- Line: 60
    local Equipment = p5.Data.Equipment;

    for _, v in { "Head", "Body", "Ring" } do
        local v7 = Equipment[v];

        if type(v7) == "table" and v7.GUID == p6 then
            return v;
        end;
    end;

    return nil;
end;

function u1.NormalizeEquipment(p8) -- Line: 81
    -- upvalues: EquipmentTemplates (copy), Image_Data (copy), EquipmentStatLines (copy), RarityIndex (copy)
    if type(p8) ~= "table" or not p8.GUID then
        return nil;
    end;

    local Template = EquipmentTemplates.GetTemplate(p8.ItemId);

    return {
        ItemType = "Equipment",
        Description = nil,
        OwnedCount = 1,
        Usable = true,
        IsEquipment = true,
        ItemId = p8.GUID,
        GUID = p8.GUID,
        DisplayName = Template and Template.DisplayName or (p8.ItemId or p8.Rarity .. " " .. p8.Slot),
        Category = "Equipment_" .. p8.Slot,
        Slot = p8.Slot,
        Rarity = p8.Rarity or "Common",
        Icon = Image_Data.Equipment and Image_Data.Equipment[p8.ItemId] or (Template and (Template.ImageId or "") or ""),
        StatLines = EquipmentStatLines.build(p8.Stats, p8.Slot),
        Stats = p8.Stats,
        BaseDamage = p8.BaseDamage,
        GuaranteedStat = p8.GuaranteedStat,
        EnchantLevel = p8.EnchantLevel or 0,
        ForgeLevel = p8.ForgeLevel or 0,
        ForgeBonuses = p8.ForgeBonuses,
        EquipTier = Template and (Template.EquipTier or 1) or nil,
        Locked = p8.Locked or false,
        Identified = p8.Identified ~= false,
        LevelReq = p8.LevelReq or 0,
        LayoutOrder = 50 + (13 - (RarityIndex[p8.Rarity] or 0))
    };
end;

function u1.BuildEquipped(p9) -- Line: 124
    -- upvalues: u1 (copy)
    local v10 = u1.NormalizeEquipment(p9);

    if v10 then
        v10.LayoutOrder = 0;
    end;

    return v10;
end;

local u11 = {};
u1.CountNormalizers = u11;

function u11.Potions(p12: string, p13: number) -- Line: 142
    -- upvalues: PotionData (copy), ItemDescriptions (copy)
    if p13 <= 0 then
        return nil;
    end;

    local Potion = PotionData.GetPotion(p12);

    return Potion and {
        Category = "Potion",
        ItemType = "Consumable",
        Rarity = "Common",
        Usable = true,
        SourceField = "Potions",
        ItemId = p12,
        DisplayName = Potion.Name,
        Description = ItemDescriptions.Get(p12),
        Icon = Potion.Icon or "",
        OwnedCount = p13,
        InstantUse = Potion.InstantUse or false,
        SourceId = p12,
        LayoutOrder = 100 + (Potion.LayoutOrder or 0)
    } or nil;
end;

function u11.CraftingMaterials(p14: string, p15: number) -- Line: 166
    -- upvalues: ItemData (copy), ItemDescriptions (copy), Image_Data (copy), RarityIndex (copy)
    if p15 <= 0 then
        return nil;
    end;

    if ItemData.Index and ItemData.Index[p14] then
        local v16 = ItemData.Index[p14];

        return {
            Category = "Material",
            ItemType = "Material",
            Usable = false,
            SourceField = "CraftingMaterials",
            ItemId = p14,
            DisplayName = v16.Name or p14,
            Rarity = v16.Rarity,
            Description = v16.Description ~= "" and v16.Description or ItemDescriptions.Get(p14),
            Icon = v16.Icon ~= "" and v16.Icon or (Image_Data.Materials and (Image_Data.Materials[p14] or "") or ""),
            OwnedCount = p15,
            SourceId = p14,
            LayoutOrder = 210 + (RarityIndex[v16.Rarity] or 0)
        };
    end;

    local string_gsub_ret = string.gsub(p14, " Crystal", "");

    return {
        Category = "Material",
        ItemType = "Material",
        Usable = false,
        SourceField = "CraftingMaterials",
        ItemId = p14,
        DisplayName = p14,
        Rarity = string_gsub_ret,
        Description = ItemDescriptions.Get(p14),
        Icon = Image_Data.Crystals[string_gsub_ret] or "",
        OwnedCount = p15,
        SourceId = p14,
        LayoutOrder = 200 + (RarityIndex[string_gsub_ret] or 0)
    };
end;

function u11.BuffPotions(p17: string, p18: number) -- Line: 208
    -- upvalues: BuffPotionData (copy), ItemDescriptions (copy)
    if p18 <= 0 then
        return nil;
    end;

    local Potion = BuffPotionData.GetPotion(p17);

    return Potion and {
        Category = "Potion",
        ItemType = "BuffPotion",
        Usable = true,
        SourceField = "BuffPotions",
        ItemId = p17,
        DisplayName = Potion.Name,
        Rarity = Potion.Tier >= 3 and "Rare" or (Potion.Tier == 2 and "Epic" or "Uncommon"),
        Description = ItemDescriptions.Get(p17),
        Icon = Potion.Icon or "",
        OwnedCount = p18,
        BuffType = Potion.BuffType,
        SourceId = p17,
        LayoutOrder = 600 + (Potion.LayoutOrder or 0)
    } or nil;
end;

function u11.Consumables(p19: string, p20: number) -- Line: 231
    -- upvalues: ConsumableData (copy), ItemDescriptions (copy)
    if p20 <= 0 then
        return nil;
    end;

    local Consumable = ConsumableData.GetConsumable(p19);

    return Consumable and {
        Category = "Consumable",
        ItemType = "ConsumableItem",
        SourceField = "Consumables",
        ItemId = p19,
        DisplayName = Consumable.Name,
        Rarity = Consumable.Rarity or "Rare",
        Description = Consumable.Description or ItemDescriptions.Get(p19),
        Icon = Consumable.Icon or "",
        OwnedCount = p20,
        Usable = Consumable.Usable ~= false,
        SourceId = p19,
        LayoutOrder = 700 + (Consumable.LayoutOrder or 0)
    } or nil;
end;

function u1.Build(p21) -- Line: 259
    -- upvalues: u1 (copy), u11 (copy), ItemDescriptions (copy), Image_Data (copy), QuestItemData (copy), PackageData (copy), CosmeticData (copy), CosmeticViewport (copy), ClassItemData (copy), KeyData (copy)
    local v22 = {};
    local Data = p21.Data;
    local EquipmentInventory = Data.EquipmentInventory;

    if EquipmentInventory then
        for _, v in EquipmentInventory do
            local v23 = u1.NormalizeEquipment(v);

            if v23 then
                table.insert(v22, v23);
            end;
        end;
    end;

    if Data.Potions then
        for i, v in Data.Potions do
            local v24 = u11.Potions(i, v);

            if v24 then
                table.insert(v22, v24);
            end;
        end;
    end;

    if Data.CraftingMaterials then
        for i, v in Data.CraftingMaterials do
            local v25 = u11.CraftingMaterials(i, v);

            if v25 then
                table.insert(v22, v25);
            end;
        end;
    end;

    local v26 = Data.ProtectionScrolls or 0;

    if v26 > 0 then
        local v27 = {
            ItemId = "ProtectionScroll",
            DisplayName = "Protection Scroll",
            Category = "Misc",
            ItemType = "Misc",
            Rarity = "Common",
            Usable = false,
            LayoutOrder = 400,
            Description = ItemDescriptions.Get("ProtectionScroll"),
            Icon = Image_Data.Rewards.ProtectionScroll or "",
            OwnedCount = v26
        };
        table.insert(v22, v27);
    end;

    local v28 = Data.GoldenHammers or 0;

    if v28 > 0 then
        local v29 = {
            ItemId = "GoldenHammer",
            DisplayName = "Golden Hammer",
            Category = "Misc",
            ItemType = "Misc",
            Rarity = "Common",
            Usable = false,
            LayoutOrder = 401,
            Description = ItemDescriptions.Get("GoldenHammer"),
            Icon = Image_Data.Rewards.GoldenHammer or "",
            OwnedCount = v28
        };
        table.insert(v22, v29);
    end;

    if Data.QuestItems then
        for i, v in Data.QuestItems do
            if v > 0 then
                local v30 = QuestItemData.Get(i);

                if v30 then
                    table.insert(v22, {
                        Category = "Misc",
                        ItemType = "QuestItem",
                        Usable = false,
                        ItemId = i,
                        DisplayName = v30.DisplayName or i,
                        Rarity = v30.Rarity or "Legendary",
                        Description = v30.Description or "",
                        Icon = v30.Icon or "",
                        OwnedCount = v,
                        LayoutOrder = v30.LayoutOrder or 450
                    });
                end;
            end;
        end;
    end;

    if Data.Packs then
        for i, v in Data.Packs do
            if v > 0 then
                local v31 = PackageData.Get(i);

                if v31 then
                    table.insert(v22, {
                        Category = "Misc",
                        ItemType = "Pack",
                        Usable = true,
                        LayoutOrder = 550,
                        ItemId = i,
                        DisplayName = v31.Name or i,
                        Rarity = v31.Rarity or "Legendary",
                        Description = v31.Description or "",
                        Icon = v31.Icon or "",
                        OwnedCount = v
                    });
                end;
            end;
        end;
    end;

    if Data.BuffPotions then
        for i, v in Data.BuffPotions do
            local v32 = u11.BuffPotions(i, v);

            if v32 then
                table.insert(v22, v32);
            end;
        end;
    end;

    if Data.Consumables then
        for i, v in Data.Consumables do
            local v33 = u11.Consumables(i, v);

            if v33 then
                table.insert(v22, v33);
            end;
        end;
    end;

    local OwnedCosmetics = Data.OwnedCosmetics;

    if OwnedCosmetics then
        local v34 = {};

        for _, v in OwnedCosmetics do
            table.insert(v34, v);
        end;

        table.sort(v34);

        for i, v in v34 do
            local v35 = CosmeticData.Get(v);

            if v35 then
                local SetSlots = CosmeticViewport.GetSetSlots(v);
                local v36 = 700 + (i - 1) * 10;
                local v37 = v;

                for _, v2 in SetSlots do
                    local v38 = {
                        Category = "Cosmetic",
                        ItemType = "Cosmetic",
                        OwnedCount = 1,
                        Usable = true,
                        IsCosmetic = true,
                        IsEquipment = false,
                        Locked = false,
                        ItemId = "cosmetic:" .. v37 .. ":" .. v2,
                        DisplayName = v35.DisplayName,
                        PieceName = CosmeticViewport.GetPieceName(v37, v2) or v35.DisplayName,
                        Rarity = v35.Rarity or "Common",
                        Description = v35.Description or "",
                        Icon = v35.Icon or "",
                        CosmeticSetId = v37,
                        CosmeticSlot = v2,
                        CosmeticSlotDisplay = CosmeticData.SLOT_DISPLAY[v2] or v2,
                        LayoutOrder = v36 + (CosmeticData.SLOT_ORDER[v2] or 0)
                    };
                    table.insert(v22, v38);
                end;
            end;
        end;
    end;

    local ClassItems = Data.ClassItems;

    if ClassItems then
        local v39 = Data.EquippedClassItem or "";
        local v40 = Image_Data.Class_Items or {};

        for i, v in ClassItems do
            local v41 = ClassItemData.Get(v);

            if v41 then
                local v42 = v40[string.gsub(v, "%s", "")];

                if not v42 and v41.ClassName then
                    v42 = v40[string.gsub(v41.ClassName, "%s", "")];
                end;

                table.insert(v22, {
                    Category = "ClassItem",
                    ItemType = "ClassItem",
                    OwnedCount = 1,
                    Usable = true,
                    IsClassItem = true,
                    Locked = true,
                    ItemId = "classitem:" .. v,
                    ClassItemId = v,
                    DisplayName = v,
                    Rarity = v41.Rarity or "Legendary",
                    Description = v41.Description or "Equip to become a " .. (v41.ClassName or "?") .. ".",
                    Icon = v42 or "",
                    IsEquipped = v39 == v,
                    ClassName = v41.ClassName,
                    LayoutOrder = 800 + i
                });
            end;
        end;
    end;

    local Keys = Data.Keys;

    if Keys then
        for i = 1, KeyData.MAX_TIER do
            local v43 = "T" .. i;
            local v44 = Keys[v43];
            local v45;

            if v44 and v44 > 0 then
                local KeyName = KeyData.GetKeyName(i);
                local v46 = {
                    Category = "Misc",
                    ItemType = "Key",
                    Rarity = "Common",
                    Usable = false,
                    IsEquipment = false,
                    Locked = true,
                    ItemId = "key:" .. v43,
                    DisplayName = KeyName,
                    Description = KeyName .. " — unlocks Tier " .. i .. " locked rooms in dungeons.",
                    Icon = Image_Data.Keys and Image_Data.Keys[v43] or "",
                    OwnedCount = v44,
                    LayoutOrder = i + 700,
                    KeyColor = KeyData.GetKeyColor(i)
                };
                table.insert(v22, v46);
                v45 = i;
            else
                v45 = i;
            end;
        end;

        local v47 = Keys[KeyData.MASTER_KEY_ID];

        if v47 and v47 > 0 then
            table.insert(v22, {
                ItemId = "key:Master",
                Category = "Misc",
                ItemType = "Key",
                Rarity = "Legendary",
                Description = "Master Key — opens any tier locked room.",
                Usable = false,
                IsEquipment = false,
                Locked = true,
                LayoutOrder = 706,
                DisplayName = KeyData.MASTER_KEY_NAME,
                Icon = Image_Data.Keys and Image_Data.Keys.Master or "",
                OwnedCount = v47,
                KeyColor = KeyData.MASTER_KEY_COLOR
            });
        end;
    end;

    local v48 = Image_Data.Rewards or {};
    local v49 = Data.NormalSpins or 0;

    if v49 > 0 then
        table.insert(v22, {
            ItemId = "spin:Normal",
            DisplayName = "Normal Spin",
            Category = "Misc",
            ItemType = "Spin",
            Rarity = "Uncommon",
            Description = "A Normal summon spin. Use it in the Summoning menu to roll for classes.",
            Usable = false,
            IsEquipment = false,
            Locked = true,
            LayoutOrder = 650,
            Icon = v48.NormalSpins or "",
            OwnedCount = v49
        });
    end;

    local v50 = Data.LuckySpins or 0;

    if v50 > 0 then
        table.insert(v22, {
            ItemId = "spin:Lucky",
            DisplayName = "Lucky Spin",
            Category = "Misc",
            ItemType = "Spin",
            Rarity = "Rare",
            Description = "A Lucky summon spin with boosted rates. Use it in the Summoning menu.",
            Usable = false,
            IsEquipment = false,
            Locked = true,
            LayoutOrder = 651,
            Icon = v48.LuckySpins or "",
            OwnedCount = v50
        });
    end;

    table.sort(v22, function(p51, p52) -- Line: 579
        if p51.LayoutOrder == p52.LayoutOrder then
            return p51.DisplayName < p52.DisplayName;
        end;

        return p51.LayoutOrder < p52.LayoutOrder;
    end);

    return v22;
end;

return u1;