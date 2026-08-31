--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     RewardCardRender
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.ClientUtils.RewardCardRender
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GameInfo = ReplicatedStorage:WaitForChild("GameInfo");
local EquipmentTemplates = require(GameInfo:WaitForChild("EquipmentTemplates"));
local BuffPotionData = require(GameInfo:WaitForChild("BuffPotionData"));
local CosmeticData = require(GameInfo:WaitForChild("CosmeticData"));
local ClassItemData = require(GameInfo:WaitForChild("ClassItemData"));
local PackageData = require(GameInfo:WaitForChild("PackageData"));
local QuestItemData = require(GameInfo:WaitForChild("QuestItemData"));
local ConsumableData = require(GameInfo:WaitForChild("ConsumableData"));
local ItemData = require(GameInfo:WaitForChild("ItemData"));
local Image_Data = require(GameInfo:WaitForChild("Image_Data"));
local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local RarityGradient = require(ReplicatedStorage.Modules.RarityGradient);
local v1 = {};

local function resolveReward(p2) -- Line: 64
    -- upvalues: EquipmentTemplates (copy), Image_Data (copy), SharedUtils (copy), BuffPotionData (copy), ItemData (copy), CosmeticData (copy), ClassItemData (copy), PackageData (copy), QuestItemData (copy), ConsumableData (copy)
    if type(p2) ~= "table" then
        return nil;
    end;

    local Type = p2.Type;
    local Id = p2.Id;
    local v3 = p2.Amount or 1;

    if Type == "Equipment" and Id then
        local Template = EquipmentTemplates.GetTemplate(Id);
        local v4 = {};
        local v5;

        if Template then
            v5 = Template.DisplayName or Id;
        else
            v5 = Id;
        end;

        v4.name = v5;
        v4.icon = Image_Data.Equipment and Image_Data.Equipment[Id] or (Template and Template.ImageId or nil);
        v4.rarity = p2.Rarity or "Common";

        return v4;
    end;

    if Type == "Coins" then
        return {
            name = "Coins",
            icon = Image_Data.Rewards and Image_Data.Rewards.Cash or nil,
            amountText = tostring(SharedUtils.FormatNumber(v3))
        };
    end;

    if Type == "Stars" then
        return {
            name = "Stars",
            icon = Image_Data.Rewards and Image_Data.Rewards.Stars or nil,
            amountText = tostring(SharedUtils.FormatNumber(v3))
        };
    end;

    if Type == "NormalSpins" then
        return {
            name = v3 == 1 and "Normal Spin" or "Normal Spins",
            icon = Image_Data.Rewards and Image_Data.Rewards.NormalSpins or nil,
            amountText = `x{v3}`,
            color = Color3.fromRGB(200, 200, 255)
        };
    end;

    if Type == "LuckySpins" then
        return {
            name = v3 == 1 and "Lucky Spin" or "Lucky Spins",
            icon = Image_Data.Rewards and Image_Data.Rewards.LuckySpins or nil,
            amountText = `x{v3}`,
            color = Color3.fromRGB(255, 220, 100)
        };
    end;

    if Type == "BuffPotion" and Id then
        local Potion = BuffPotionData.GetPotion(Id);
        local v6 = {};

        if Potion then
            Id = Potion.Name or Id;
        end;

        v6.name = Id;
        v6.icon = Potion and Potion.Icon or nil;
        v6.amountText = `x{v3}`;
        v6.color = Color3.fromRGB(200, 150, 255);

        return v6;
    end;

    if Type == "ClassEXPPotion" then
        return {
            name = "Class EXP Essence",
            icon = Image_Data.Potions and Image_Data.Potions.ClassXPEssence or nil,
            amountText = `x{v3}`,
            color = Color3.fromRGB(200, 255, 150)
        };
    end;

    if Type == "CraftingMaterial" and Id then
        local v7 = ItemData.Index and ItemData.Index[Id];
        local v8 = {};
        local v9;

        if v7 then
            v9 = v7.Name or Id;
        else
            v9 = Id;
        end;

        v8.name = v9;
        v8.icon = v7 and (v7.Icon and v7.Icon ~= "") and v7.Icon or Image_Data.ForgeMaterials and Image_Data.ForgeMaterials[Id] or (Image_Data.Materials and Image_Data.Materials[Id] or nil);
        v8.amountText = `x{v3}`;
        v8.rarity = v7 and v7.Rarity or nil;
        v8.color = Color3.fromRGB(150, 215, 255);

        return v8;
    end;

    if Type == "Cosmetic" and Id then
        local v10 = CosmeticData.Get(Id);
        local v11 = {};

        if v10 then
            Id = v10.DisplayName or Id;
        end;

        v11.name = Id;
        v11.icon = v10 and v10.Icon ~= "" and v10.Icon or (Image_Data.Rewards and Image_Data.Rewards.Cosmetic or nil);
        v11.rarity = v10 and v10.Rarity or nil;

        return v11;
    end;

    if Type == "Title" and Id then
        return {
            name = `Title: {Id}`,
            icon = Image_Data.Rewards and Image_Data.Rewards.Title or nil,
            color = Color3.fromRGB(255, 220, 120)
        };
    end;

    if Type == "ClassItem" and Id then
        local v12 = ClassItemData.Get(Id);

        return {
            name = Id,
            rarity = v12 and v12.Rarity or nil
        };
    end;

    if Type == "Package" and Id then
        local v13 = PackageData.Get(Id);
        local v14 = {};

        if v13 then
            Id = v13.Name or Id;
        end;

        v14.name = Id;
        local v15;

        if v13 and v13.Icon ~= "" then
            v15 = v13.Icon or nil;
        else
            v15 = nil;
        end;

        v14.icon = v15;
        v14.rarity = v13 and v13.Rarity or nil;

        return v14;
    end;

    if Type == "QuestItem" and Id then
        local v16 = QuestItemData.Get(Id);
        local v17 = {};

        if v16 then
            Id = v16.DisplayName or Id;
        end;

        v17.name = Id;
        local v18;

        if v16 and (v16.Icon and v16.Icon ~= "") then
            v18 = v16.Icon:gsub("%s+$", "") or nil;
        else
            v18 = nil;
        end;

        v17.icon = v18;
        v17.amountText = `x{v3}`;
        v17.rarity = v16 and v16.Rarity or nil;

        return v17;
    end;

    if Type == "ProtectionScroll" then
        return {
            name = "Protection Scroll",
            rarity = "Rare",
            icon = Image_Data.Rewards and Image_Data.Rewards.ProtectionScroll or nil,
            amountText = `x{v3}`
        };
    end;

    if Type ~= "Consumable" or not Id then
        return nil;
    end;

    local Consumable = ConsumableData.GetConsumable(Id);
    local v19 = {};

    if Consumable then
        Id = Consumable.Name or Id;
    end;

    v19.name = Id;
    local v20;

    if Consumable and (Consumable.Icon and Consumable.Icon ~= "") then
        v20 = Consumable.Icon or nil;
    else
        v20 = nil;
    end;

    v19.icon = v20;
    v19.amountText = `x{v3}`;
    v19.rarity = Consumable and Consumable.Rarity or nil;

    return v19;
end;

function v1.isRenderable(p21) -- Line: 218
    -- upvalues: resolveReward (copy)
    return resolveReward(p21) ~= nil;
end;

function v1.populateRewardCard(p22: userdata, p23: any) -- Line: 226
    -- upvalues: resolveReward (copy), RarityColors (copy), RarityGradient (copy)
    local v24 = resolveReward(p23);

    if not v24 then
        return false;
    end;

    local v25 = p22:FindFirstChild("ItemName", true) or p22:FindFirstChild("Item_Name", true);

    if v25 and v25:IsA("TextLabel") then
        v25.Text = v24.name;

        if v24.rarity and RarityColors[v24.rarity] then
            v25.TextColor3 = RarityColors[v24.rarity].TextColor3;
        elseif v24.color then
            v25.TextColor3 = v24.color;
        end;
    end;

    local Amount = p22:FindFirstChild("Amount", true);

    if Amount and Amount:IsA("TextLabel") then
        if v24.amountText then
            Amount.Text = v24.amountText;
            Amount.Visible = true;
        else
            Amount.Visible = false;
        end;
    end;

    local ItemImage = p22:FindFirstChild("ItemImage", true);

    if ItemImage and (ItemImage:IsA("ImageLabel") and v24.icon) then
        ItemImage.Image = v24.icon;
    end;

    RarityGradient.apply(p22, v24.rarity);

    return true;
end;

return v1;