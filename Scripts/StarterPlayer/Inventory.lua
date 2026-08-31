--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Inventory
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.Inventory
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:12 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local GameInfo = ReplicatedStorage:WaitForChild("GameInfo");
local BuffPotionData = require(GameInfo:WaitForChild("BuffPotionData"));
local EquipmentTemplates = require(GameInfo:WaitForChild("EquipmentTemplates"));
local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
local Image_Data = require(GameInfo:WaitForChild("Image_Data"));
local CosmeticData = require(GameInfo:WaitForChild("CosmeticData"));
local RarityData = require(GameInfo:WaitForChild("RarityData"));
local GearScoreData = require(GameInfo:WaitForChild("GearScoreData"));
local EquipmentData = require(GameInfo:WaitForChild("EquipmentData"));
local PackageData = require(GameInfo:WaitForChild("PackageData"));
local Registry = require(script.Parent.Parent.Controllers.Registry);
local Knit = require(ReplicatedStorage.Packages.Knit);
local UIController = require(script.Parent.Parent.Controllers.UIController);
local SelectionHighlight = require(script.Parent.Parent.ClientUtils.SelectionHighlight);
local CosmeticViewport = require(script.Parent.Parent.ClientUtils.CosmeticViewport);
local InventoryLoadouts = require(script.Parent.InventoryLoadouts);
local InventoryItems = require(script.Parent.InventoryItems);
local InventoryItemInfo = require(script.Parent.InventoryItemInfo);
local InventoryCharacterPreview = require(script.Parent.InventoryCharacterPreview);
local InventoryStatUpgrade = require(script.Parent.InventoryStatUpgrade);
local InventoryCosmeticsList = require(script.Parent.InventoryCosmeticsList);
local InventoryStatInfo = require(script.Parent.InventoryStatInfo);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local RarityGradient = require(ReplicatedStorage.Modules.RarityGradient);
local u1 = {
    Templates = {},
    ItemCache = {}
};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = nil;
local u26 = nil;
local u27 = nil;
local u28 = nil;
local u29 = nil;
local u30 = nil;
local u31 = nil;
local u32 = nil;
local u33 = nil;
local u34 = nil;
local u35 = nil;
local u36 = nil;
local u37 = "All";
local u38 = "";
local u39 = nil;
local u40 = false;
local u41 = {};
local u42 = RarityData.RarityIndex.Mythic or 6;
local u49 = {
    All = nil,

    Equipment = function(p43) -- Line: 158, Name: Equipment
        return p43.IsEquipment == true;
    end,

    Items = function(p44) -- Line: 161, Name: Items
        local v45 = not p44.IsEquipment;

        if v45 then
            if p44.Category == "Material" then
                v45 = false;
            else
                v45 = p44.ItemType ~= "QuestItem";
            end;
        end;

        return v45;
    end,

    Materials = function(p46) -- Line: 169, Name: Materials
        return p46.Category == "Material";
    end,

    Special = function(p47) -- Line: 172, Name: Special
        return (p47.ItemType == "ClassItem" or p47.ItemType == "QuestItem") and true or p47.ItemType == "Key";
    end,

    Cosmetics = function(p48) -- Line: 177, Name: Cosmetics
        return p48.IsCosmetic == true;
    end
};

local function IsItemEquipped(p50: string) -- Line: 197
    -- upvalues: InventoryItems (copy), u3 (ref)
    return InventoryItems.IsEquipped(u3, p50);
end;

local function GetEquippedSlot(p51: string) -- Line: 202
    -- upvalues: InventoryItems (copy), u3 (ref)
    return InventoryItems.GetEquippedSlot(u3, p51);
end;

local function IsCardEquipped(p52: userdata) -- Line: 210
    -- upvalues: u3 (ref), IsItemEquipped (copy)
    if not u3 then
        return false;
    end;

    if p52.IsEquipment then
        return IsItemEquipped(p52.GUID or "");
    end;

    if p52.IsCosmetic then
        return (u3.Data.CosmeticSlots or {})[p52.CosmeticSlot] == p52.CosmeticSetId;
    end;

    if p52.IsClassItem then
        return (u3.Data.EquippedClassItem or "") == p52.ClassItemId;
    end;

    if p52.ItemType == "BuffPotion" then
        return u3.Data.EquippedPotion == p52.ItemId;
    end;

    return false;
end;

local function UpdateCardEquippedLabel(p53: userdata, p54: userdata) -- Line: 228
    -- upvalues: IsCardEquipped (copy)
    local Equipped = p53:FindFirstChild("Equipped");

    if Equipped then
        Equipped.Visible = IsCardEquipped(p54);
    end;
end;

local u56 = {
    {
        Frame = "Health",
        Key = "MaxHP",
        Kind = "abbrev"
    },
    {
        Frame = "DMG",
        Key = "BasicAttackDamage",
        Kind = "abbrev"
    },
    {
        Frame = "CRIT",
        Key = "CritRate",
        Kind = "percent"
    },
    {
        Frame = "DR",
        Kind = "percent1",

        Compute = function(p55) -- Line: 254, Name: Compute
            -- upvalues: EquipmentData (copy)
            return (1 - EquipmentData.ComputeDamageMultiplier(p55.Defense or 0, p55.DamageReduction or 0)) * 100;
        end
    }
};

local function FormatGearInfoStat(p57: number, p58: string) -- Line: 264
    -- upvalues: SharedUtils (copy)
    if p58 == "percent" then
        local math_floor_ret = math.floor(p57 + 0.5);

        return tostring(math_floor_ret) .. "%";
    end;

    if p58 == "percent1" then
        return string.format("%.1f", p57) .. "%";
    end;

    if p58 == "regen" then
        return string.format("%.1f", p57);
    end;

    return SharedUtils.AbbreviateStat10k(p57);
end;

local function u60() -- Line: 276
    -- upvalues: u29 (ref), u3 (ref), SharedUtils (copy)
    if not (u29 and u3) then
        return;
    end;

    local Data = u3.Data;
    local v59 = Data.MaxInventorySlots or 60;
    u29.Text = SharedUtils.AbbreviateNumber(Data.EquipmentInventory and #Data.EquipmentInventory or 0) .. "/" .. SharedUtils.AbbreviateNumber(v59);
end;

local function u62() -- Line: 289
    -- upvalues: u1 (copy), u40 (ref), u41 (copy), u28 (ref)
    for i, v in u1.Templates do
        local Delete_Cover = v:FindFirstChild("Delete_Cover");

        if Delete_Cover then
            Delete_Cover.Visible = u40 and u41[i] == true;
        end;
    end;

    if u28 then
        local v61 = 0;

        for _ in u41 do
            v61 = v61 + 1;
        end;

        if v61 > 0 then
            u28.Text = "DELETE";

            return;
        end;

        u28.Text = "Cancel";
    end;
end;

local function MatchesFilter(p63: userdata) -- Line: 317
    -- upvalues: u37 (ref), u39 (ref), u49 (copy), u38 (ref)
    if p63.IsCosmetic then
        if u37 ~= "Cosmetics" then
            return false;
        end;

        if u39 and not u39[p63.CosmeticSetId] then
            return false;
        end;
    elseif u37 == "Cosmetics" then
        return false;
    end;

    local v64 = u49[u37];

    if v64 and not v64(p63) then
        return false;
    end;

    if u38 ~= "" then
        local string_lower_ret = string.lower(p63.DisplayName);

        if not string.find(string_lower_ret, string.lower(u38), 1, true) then
            return false;
        end;
    end;

    return true;
end;

local function EnsureCosmeticPreview(p65: userdata, p66: userdata) -- Line: 352
    -- upvalues: CosmeticViewport (copy)
    if not p66.IsCosmetic then
        return;
    end;

    if p65:GetAttribute("_CosmeticRendered") then
        return;
    end;

    local ViewportFrame = p65:FindFirstChild("ViewportFrame");

    if not ViewportFrame then
        return;
    end;

    ViewportFrame.Visible = CosmeticViewport.Load(ViewportFrame, p66.CosmeticSetId, p66.CosmeticSlot);
    p65:SetAttribute("_CosmeticRendered", true);
end;

local function ApplyFilterAndSearch() -- Line: 364
    -- upvalues: u1 (copy), MatchesFilter (copy), EnsureCosmeticPreview (copy)
    for i, v in u1.Templates do
        local v67 = u1.ItemCache[i];

        if v67 then
            local v68 = MatchesFilter(v67);
            v.Visible = v68;

            if v68 then
                EnsureCosmeticPreview(v, v67);
            end;
        end;
    end;
end;

local function ApplyGradientColor(p69: userdata?, p70: string?) -- Line: 383
    -- upvalues: RarityGradient (copy)
    if not p69 then
        return;
    end;

    local v71 = RarityGradient.colorSequence(p70);

    if not v71 then
        p69.Enabled = false;

        return;
    end;

    p69.Color = v71;
    p69.Enabled = true;
end;

local function ApplyCardNameAndForge(p72: userdata, p73: userdata) -- Line: 399
    local Item_Name = p72:FindFirstChild("Item_Name");

    if Item_Name then
        local DisplayName = p73.DisplayName;

        if p73.IsEquipment then
            local v74 = p73.EnchantLevel or 0;

            if (p73.ForgeLevel or 0) == 0 and v74 > 0 then
                DisplayName = DisplayName .. " +" .. v74;
            end;
        end;

        Item_Name.Text = DisplayName;
    end;

    local Forge_Level = p72:FindFirstChild("Forge_Level");

    if Forge_Level then
        local v75 = p73.IsEquipment and (p73.ForgeLevel or 0) or 0;

        if v75 > 0 then
            Forge_Level.Text = "+" .. v75;
            Forge_Level.Visible = true;
        else
            Forge_Level.Visible = false;
        end;
    end;

    local Item_Tier = p72:FindFirstChild("Item_Tier");

    if Item_Tier then
        local v76 = p73.IsEquipment and p73.EquipTier;

        if v76 then
            Item_Tier.Text = "T" .. v76;
            Item_Tier.Visible = true;

            return;
        end;

        Item_Tier.Visible = false;
    end;
end;

local function ApplyCardRarityVisuals(p77: userdata, p78: userdata) -- Line: 452
    -- upvalues: RarityGradient (copy)
    local ColorFrame = p77:FindFirstChild("ColorFrame");

    if ColorFrame then
        RarityGradient.set(ColorFrame, p78.Rarity);
    end;

    local Item_Name = p77:FindFirstChild("Item_Name");

    if Item_Name then
        Item_Name.TextColor3 = Color3.new(1, 1, 1);
        RarityGradient.set(Item_Name, p78.Rarity, 90);
    end;
end;

local function CreateBodyTemplate(u79: userdata) -- Line: 466
    -- upvalues: u1 (copy), ApplyCardNameAndForge (copy), u3 (ref), IsCardEquipped (copy), ApplyCardRarityVisuals (copy), u40 (ref), InventoryItems (copy), u41 (copy), u62 (ref), u24 (ref), u36 (ref), u5 (ref)
    local ItemId = u79.ItemId;
    local v80 = u1.ItemTemplate:Clone();
    v80.Name = ItemId;
    v80.Visible = true;
    ApplyCardNameAndForge(v80, u79);
    local Item_Level = v80:FindFirstChild("Item_Level");

    if Item_Level then
        if u79.IsEquipment and (u79.LevelReq and u79.LevelReq > 0) then
            Item_Level.Text = "Lvl. " .. u79.LevelReq;
            Item_Level.Visible = true;

            if (u3.Data.PlayerLevel or 1) < u79.LevelReq then
                Item_Level.TextColor3 = Color3.fromRGB(255, 75, 75);
            else
                Item_Level.TextColor3 = Color3.fromRGB(180, 180, 180);
            end;
        else
            Item_Level.Visible = false;
        end;
    end;

    local ViewportFrame = v80:FindFirstChild("ViewportFrame");
    local ItemImage = v80:FindFirstChild("ItemImage");

    if u79.IsCosmetic then
        if ItemImage then
            ItemImage.Visible = false;
        end;

        if ViewportFrame then
            ViewportFrame.Visible = false;
        end;
    else
        if ViewportFrame then
            ViewportFrame.Visible = false;
        end;

        if ItemImage then
            local Icon = u79.Icon;

            if Icon and (Icon ~= "" and Icon ~= "rbxassetid://0") then
                ItemImage.Image = Icon;
                ItemImage.Visible = true;
            else
                ItemImage.Visible = false;
            end;
        end;
    end;

    local Lock_Image = v80:FindFirstChild("Lock_Image");

    if Lock_Image then
        Lock_Image.Visible = u79.IsEquipment and u79.Locked == true;
    end;

    local Equipped = v80:FindFirstChild("Equipped");

    if Equipped then
        Equipped.Visible = IsCardEquipped(u79);
    end;

    local Amount = v80:FindFirstChild("Amount");

    if Amount then
        if ((u79.ItemType == "BuffPotion" or (u79.ItemType == "ConsumableItem" or (u79.ItemType == "Pack" or (u79.ItemType == "Chest" or (u79.ItemType == "Material" or (u79.ItemType == "QuestItem" or (u79.ItemType == "Key" or (u79.ItemType == "Spin" or u79.ItemType == "Misc")))))))) and true or u79.InstantUse) and (u79.OwnedCount and u79.OwnedCount > 0) then
            Amount.Text = "x" .. u79.OwnedCount;
            Amount.Visible = true;
        else
            Amount.Visible = false;
        end;
    end;

    ApplyCardRarityVisuals(v80, u79);
    local Delete_Cover = v80:FindFirstChild("Delete_Cover");

    if Delete_Cover then
        Delete_Cover.Visible = false;
    end;

    local RebirthLock = v80:FindFirstChild("RebirthLock");

    if RebirthLock then
        RebirthLock.Visible = false;
    end;

    local OwnedLabel = v80:FindFirstChild("OwnedLabel");

    if OwnedLabel then
        OwnedLabel.Visible = false;
    end;

    local Selection_Button = v80:FindFirstChild("Selection_Button");

    if Selection_Button then
        Selection_Button.MouseButton1Click:Connect(function() -- Line: 567
            -- upvalues: u40 (ref), u79 (copy), InventoryItems (ref), u3 (ref), u41 (ref), ItemId (copy), u62 (ref), u1 (ref)
            if not u40 then
                u1.SelectItem(ItemId);

                return;
            end;

            if not u79.IsEquipment then
                return;
            end;

            if u79.Locked then
                return;
            end;

            if InventoryItems.IsEquipped(u3, u79.GUID) then
                return;
            end;

            if u41[ItemId] then
                u41[ItemId] = nil;
            else
                u41[ItemId] = true;
            end;

            u62();
        end);
        Selection_Button.MouseButton2Click:Connect(function() -- Line: 584
            -- upvalues: u40 (ref), u1 (ref), ItemId (copy)
            if u40 then
                return;
            end;

            u1.QuickUse(ItemId);
        end);
    end;

    if u24 then
        u24:BindHoverHighlight(v80, {
            IsLocked = function() -- Line: 596, Name: IsLocked
                -- upvalues: u36 (ref), ItemId (copy)
                return u36 == ItemId;
            end
        });
    end;

    v80.LayoutOrder = u79.LayoutOrder or 0;
    v80.Parent = u5;
    u1.Templates[ItemId] = v80;

    return v80;
end;

local function GetContextualActionText(p81: userdata) -- Line: 622
    -- upvalues: InventoryItems (copy), u3 (ref)
    return p81.IsEquipment and (InventoryItems.IsEquipped(u3, p81.GUID) and "Unequip" or "Equip") or (p81.IsCosmetic and ((u3.Data.CosmeticSlots or {})[p81.CosmeticSlot] == p81.CosmeticSetId and "Unequip" or "Equip") or (p81.IsClassItem and ((u3.Data.EquippedClassItem or "") == p81.ClassItemId and "Unequip" or "Equip") or ((p81.ItemType == "Pack" or p81.ItemType == "Chest") and "Open" or (p81.ItemType == "BuffPotion" and "Use" or (p81.Category == "Potion" and (p81.InstantUse and "Use" or (u3.Data.EquippedPotion == p81.ItemId and "Equipped" or "Equip")) or (p81.Usable and "Use" or "Equip"))))));
end;

local function IsEquippableItem(p82: userdata) -- Line: 647
    return (p82.IsEquipment or (p82.IsCosmetic or p82.IsClassItem)) and true or (p82.Category == "Potion" and not p82.InstantUse and true or false);
end;

local function SetEquipToggleVisual(p83: boolean) -- Line: 660
    -- upvalues: u26 (ref), u27 (ref)
    if u26 then
        u26.Visible = p83;
    end;

    if u27 then
        u27.Visible = not p83;
    end;
end;

local function ClearSelectedInfo() -- Line: 669
    -- upvalues: SelectionHighlight (copy), u35 (ref), u25 (ref), u26 (ref), u27 (ref), InventoryItemInfo (copy)
    SelectionHighlight.Set(u35, false);
    u35 = nil;

    if u25 then
        u25.Text = "Equip";
    end;

    if u26 then
        u26.Visible = false;
    end;

    if u27 then
        u27.Visible = true;
    end;

    InventoryItemInfo.Hide();
    InventoryItemInfo.ResetDeleteConfirm();
end;

local function UpdateSelectedInfo(p84: string) -- Line: 682
    -- upvalues: u1 (copy), SelectionHighlight (copy), u35 (ref), u25 (ref), GetContextualActionText (copy), u26 (ref), u27 (ref), InventoryItemInfo (copy)
    local v85 = u1.ItemCache[p84];

    if not v85 then
        return;
    end;

    SelectionHighlight.Set(u35, false);
    u35 = u1.Templates[p84];
    SelectionHighlight.Set(u35, true);

    if u25 then
        u25.Text = GetContextualActionText(v85);
    end;

    local v86 = (v85.IsEquipment or (v85.IsCosmetic or v85.IsClassItem)) and true or (v85.Category == "Potion" and not v85.InstantUse and true or false);

    if u26 then
        u26.Visible = v86;
    end;

    if u27 then
        u27.Visible = not v86;
    end;

    InventoryItemInfo.Populate(v85);
    InventoryItemInfo.Show();
end;

function u1.SelectItem(p87: string) -- Line: 713
    -- upvalues: u36 (ref), SelectionHighlight (copy), u35 (ref), u25 (ref), u26 (ref), u27 (ref), InventoryItemInfo (copy), UpdateSelectedInfo (copy)
    if u36 ~= p87 then
        u36 = p87;
        UpdateSelectedInfo(p87);

        return;
    end;

    u36 = nil;
    SelectionHighlight.Set(u35, false);
    u35 = nil;

    if u25 then
        u25.Text = "Equip";
    end;

    if u26 then
        u26.Visible = false;
    end;

    if u27 then
        u27.Visible = true;
    end;

    InventoryItemInfo.Hide();
    InventoryItemInfo.ResetDeleteConfirm();
end;

local function GetEquippedSlotFrame(p88: string) -- Line: 730
    -- upvalues: u10 (ref)
    local v89 = u10 and u10:FindFirstChild("Equipped");

    if v89 then
        v89 = v89:FindFirstChild(p88);
    end;

    return v89;
end;

local function SelectEquippedItem(p90: string) -- Line: 735
    -- upvalues: u3 (ref), u36 (ref), SelectionHighlight (copy), u35 (ref), u25 (ref), u26 (ref), u27 (ref), InventoryItemInfo (copy), InventoryItems (copy), u1 (copy), UpdateSelectedInfo (copy), u10 (ref)
    local v91 = u3.Data.Equipment[p90];

    if type(v91) ~= "table" or not v91.GUID then
        return;
    end;

    if u36 == v91.GUID then
        u36 = nil;
        SelectionHighlight.Set(u35, false);
        u35 = nil;

        if u25 then
            u25.Text = "Equip";
        end;

        if u26 then
            u26.Visible = false;
        end;

        if u27 then
            u27.Visible = true;
        end;

        InventoryItemInfo.Hide();
        InventoryItemInfo.ResetDeleteConfirm();

        return;
    end;

    local v92 = InventoryItems.BuildEquipped(v91);
    u1.ItemCache[v91.GUID] = v92;
    u36 = v91.GUID;
    UpdateSelectedInfo(v91.GUID);
    local v93 = u10 and u10:FindFirstChild("Equipped");

    if v93 then
        v93 = v93:FindFirstChild(p90);
    end;

    if v93 then
        v93 = v93:FindFirstChild("View");
    end;

    if v93 then
        u35 = v93;
        SelectionHighlight.Set(v93, true);
    end;
end;

local function SetupCharacterInfo() -- Line: 761
    -- upvalues: u10 (ref), u9 (ref), SelectEquippedItem (copy), u1 (copy)
    local v94 = u9 and u9:FindFirstChild("CharacterPreview");
    u10 = v94;

    if not u10 then
        return;
    end;

    for _, v in { "Head", "Body", "Ring" } do
        local v95 = u10 and u10:FindFirstChild("Equipped");

        if v95 then
            v95 = v95:FindFirstChild(v);
        end;

        if v95 then
            local v96 = v95:FindFirstChild("View") or v95;
            local SelectButton = v96:FindFirstChild("SelectButton");

            if not SelectButton then
                SelectButton = Instance.new("TextButton");
                SelectButton.Name = "SelectButton";
                SelectButton.BackgroundTransparency = 1;
                SelectButton.Text = "";
                SelectButton.Size = UDim2.fromScale(1, 1);
                SelectButton.ZIndex = v96.ZIndex + 5;
                SelectButton.Parent = v96;
            end;

            SelectButton.MouseButton1Click:Connect(function() -- Line: 784
                -- upvalues: SelectEquippedItem (ref), v (copy)
                SelectEquippedItem(v);
            end);
            SelectButton.MouseButton2Click:Connect(function() -- Line: 789
                -- upvalues: u1 (ref), v (copy)
                u1.QuickUnequipEquipment(v);
            end);
        end;
    end;
end;

local function u116() -- Line: 795
    -- upvalues: u3 (ref), u10 (ref), EquipmentTemplates (copy), Image_Data (copy), RarityGradient (copy), RarityData (copy), u42 (copy), CollectionService (copy), u32 (ref), u33 (ref), GearScoreData (copy), u34 (ref), u56 (copy), FormatGearInfoStat (copy), InventoryStatInfo (copy)
    local Data = u3.Data;

    if u10 then
        for _, v in { "Head", "Body", "Ring" } do
            local v97 = u10 and u10:FindFirstChild("Equipped");

            if v97 then
                v97 = v97:FindFirstChild(v);
            end;

            if v97 then
                local View = v97:FindFirstChild("View");
                local v98 = View and View:FindFirstChild("ItemImage") or v97:FindFirstChild("ItemImage");
                local v99;

                if View then
                    v99 = View:FindFirstChild("PlaceHolder");
                else
                    v99 = View;
                end;

                local ColorFrame = v97:FindFirstChild("ColorFrame");

                if not ColorFrame then
                    if View then
                        ColorFrame = View:FindFirstChild("ColorFrame");
                    else
                        ColorFrame = View;
                    end;
                end;

                local StrokeFrame = v97:FindFirstChild("StrokeFrame");

                if not StrokeFrame then
                    if View then
                        StrokeFrame = View:FindFirstChild("StrokeFrame");
                    else
                        StrokeFrame = View;
                    end;
                end;

                local v100;

                if View then
                    v100 = View:FindFirstChild("Item_Level");
                else
                    v100 = View;
                end;

                local v101;

                if View then
                    v101 = View:FindFirstChild("Forge_Level");
                else
                    v101 = View;
                end;

                if View then
                    View = View:FindFirstChild("Item_Tier");
                end;

                local v102 = Data.Equipment[v];
                local v103;

                if type(v102) == "table" then
                    v103 = v102.GUID ~= nil;
                else
                    v103 = false;
                end;

                local v104 = v103 and (v102.Rarity or "Common") or nil;

                if v103 then
                    local Template = EquipmentTemplates.GetTemplate(v102.ItemId);
                    local v105 = Image_Data.Equipment and Image_Data.Equipment[v102.ItemId] or (Template and Template.ImageId or "");

                    if v98 and v105 ~= "" then
                        v98.Image = v105;
                        v98.Visible = true;

                        if v99 then
                            v99.Visible = false;
                        end;
                    else
                        if v98 then
                            v98.Visible = false;
                        end;

                        if v99 then
                            v99.Visible = true;
                        end;
                    end;
                else
                    if v98 then
                        v98.Image = "";
                        v98.Visible = false;
                    end;

                    if v99 then
                        v99.Visible = true;
                    end;
                end;

                if ColorFrame then
                    ColorFrame = ColorFrame:FindFirstChildOfClass("UIGradient");
                end;

                if ColorFrame then
                    local v106 = RarityGradient.colorSequence(v104);

                    if v106 then
                        ColorFrame.Color = v106;
                        ColorFrame.Enabled = true;
                    else
                        ColorFrame.Enabled = false;
                    end;
                end;

                if StrokeFrame then
                    StrokeFrame = StrokeFrame:FindFirstChildOfClass("UIStroke");
                end;

                if StrokeFrame then
                    StrokeFrame = StrokeFrame:FindFirstChild("RarityGradient");
                end;

                if StrokeFrame and StrokeFrame:IsA("UIGradient") then
                    if StrokeFrame then
                        local v107 = RarityGradient.colorSequence(v104);

                        if v107 then
                            StrokeFrame.Color = v107;
                            StrokeFrame.Enabled = true;
                        else
                            StrokeFrame.Enabled = false;
                        end;
                    end;

                    local v108;

                    if v104 == nil then
                        v108 = false;
                    else
                        v108 = u42 < (RarityData.RarityIndex[v104] or 0);
                    end;

                    if v108 then
                        if not CollectionService:HasTag(StrokeFrame, "GradientRotate") then
                            CollectionService:AddTag(StrokeFrame, "GradientRotate");
                        end;
                    elseif CollectionService:HasTag(StrokeFrame, "GradientRotate") then
                        CollectionService:RemoveTag(StrokeFrame, "GradientRotate");
                    end;
                end;

                if v100 then
                    local v109 = v103 and (v102.LevelReq or 0) or 0;

                    if v109 > 0 then
                        v100.Text = "Lvl. " .. v109;
                        v100.TextColor3 = (Data.PlayerLevel or 1) < v109 and Color3.fromRGB(255, 75, 75) or Color3.fromRGB(180, 180, 180);
                        v100.Visible = true;
                    else
                        v100.Visible = false;
                    end;
                end;

                if v101 then
                    local v110 = v103 and (v102.ForgeLevel or 0) or 0;

                    if v110 > 0 then
                        v101.Text = "+" .. v110;
                        v101.Visible = true;
                    else
                        v101.Visible = false;
                    end;
                end;

                if View then
                    if v103 then
                        v103 = EquipmentTemplates.GetTier(v102.ItemId);
                    end;

                    if v103 then
                        View.Text = "T" .. v103;
                        View.Visible = true;
                    else
                        View.Visible = false;
                    end;
                end;
            end;
        end;
    end;

    if u32 then
        local PlayerLevel = u32:FindFirstChild("PlayerLevel");

        if PlayerLevel then
            PlayerLevel = PlayerLevel:FindFirstChild("Icon");
        end;

        if PlayerLevel then
            PlayerLevel = PlayerLevel:FindFirstChild("Amount");
        end;

        if PlayerLevel then
            PlayerLevel.Text = tostring(Data.PlayerLevel or 1);
        end;

        local ClassLevel = u32:FindFirstChild("ClassLevel");

        if ClassLevel then
            ClassLevel = ClassLevel:FindFirstChild("Icon");
        end;

        if ClassLevel then
            ClassLevel = ClassLevel:FindFirstChild("Amount");
        end;

        if ClassLevel then
            local ActiveClass = Data.ActiveClass;
            local v111 = ActiveClass and Data.ClassMastery and Data.ClassMastery[ActiveClass];
            ClassLevel.Text = tostring(v111 and v111.Level or 0);
        end;
    end;

    if u33 then
        local v112 = (Data.ComputedStats or {}).GearScore or 0;
        u33.Text = GearScoreData.FormatShort(v112);
        GearScoreData.ApplyBracketGradient(u33, v112);
    end;

    if u34 then
        local v113 = Data.ComputedStats or {};

        for _, v in u56 do
            local v114 = u34:FindFirstChild(v.Frame);

            if v114 then
                v114 = v114:FindFirstChild("Amount");
            end;

            if v114 then
                local v115;

                if v.Compute then
                    v115 = v.Compute(v113);
                else
                    v115 = v113[v.Key] or 0;
                end;

                v114.Text = FormatGearInfoStat(v115, v.Kind);
            end;
        end;
    end;

    InventoryStatInfo.Refresh();
end;

local function u118() -- Line: 961
    -- upvalues: u22 (ref), u30 (ref), u31 (ref)
    local _, v117 = u22:GetSkillPoints();

    if u30 then
        u30.Text = tostring(v117);
    end;

    if u31 then
        u31.Visible = (v117 or 0) > 0;
    end;
end;

local function SetupStatsInfo() -- Line: 979
    -- upvalues: u32 (ref), u30 (ref), u7 (ref), u31 (ref), u118 (ref)
    if u32 then
        local SkillPoints = u32:FindFirstChild("SkillPoints");

        if SkillPoints then
            SkillPoints = SkillPoints:FindFirstChild("Sp");
        end;

        if SkillPoints then
            SkillPoints = SkillPoints:FindFirstChild("Amount");
        end;

        u30 = SkillPoints;
    end;

    if u7 then
        local Stats = u7:FindFirstChild("Stats");

        if Stats then
            Stats = Stats:FindFirstChild("Notice");
        end;

        u31 = Stats;

        if u31 then
            u31.Visible = false;
        end;
    end;

    u118();
end;

local function ShowPackageRewardToasts(p119) -- Line: 1013
    -- upvalues: Registry (copy), BuffPotionData (copy), EquipmentTemplates (copy), Image_Data (copy), RarityColors (copy), CosmeticData (copy)
    if not p119 or #p119 == 0 then
        return;
    end;

    local v120 = Registry:Get("ItemNotification");

    if not v120 then
        return;
    end;

    for _, v in ipairs(p119) do
        local Type = v.Type;
        local Id = v.Id;
        local v121 = v.Amount or 1;

        if Type == "BuffPotion" and Id then
            local Potion = BuffPotionData.GetPotion(Id);

            if Potion then
                Id = Potion.Name or Id;
            end;

            v120.ShowItem(Id, Potion and Potion.Icon or nil, Color3.fromRGB(200, 150, 255), v121);
        elseif Type == "Equipment" and Id then
            local Template = EquipmentTemplates.GetTemplate(Id);
            local v122;

            if Template then
                v122 = Template.DisplayName or Id;
            else
                v122 = Id;
            end;

            local v123 = Image_Data.Equipment and Image_Data.Equipment[Id] or (Template and Template.ImageId or nil);
            local v124 = RarityColors[v.Rarity or "Common"];
            local v125 = v124 and v124.TextColor3 or Color3.fromRGB(255, 255, 255);
            v120.ShowItem(v122, v123, v125);
        elseif Type == "Cosmetic" and Id then
            local v126 = CosmeticData.Get(Id);

            if v126 then
                Id = v126.DisplayName or Id;
            end;

            local v127;

            if v126 and v126.Icon ~= "" then
                v127 = v126.Icon or nil;
            else
                v127 = nil;
            end;

            if v126 then
                v126 = RarityColors[v126.Rarity or ""];
            end;

            local v128 = v126 and v126.TextColor3 or Color3.fromRGB(255, 200, 255);
            v120.ShowItem(Id, v127, v128);
        elseif Type == "Title" and Id then
            v120.ShowItem(`Title: {Id}`, nil, Color3.fromRGB(255, 220, 120));
        elseif Type == "NormalSpins" then
            v120.ShowItem(v121 == 1 and "Normal Spin" or "Normal Spins", nil, Color3.fromRGB(200, 200, 255), v121);
        elseif Type == "LuckySpins" then
            v120.ShowItem(v121 == 1 and "Lucky Spin" or "Lucky Spins", nil, Color3.fromRGB(255, 220, 100), v121);
        elseif Type == "ClassEXPPotion" then
            v120.ShowItem("Class EXP Essence", Image_Data.Potions and Image_Data.Potions.ClassXPEssence or nil, Color3.fromRGB(200, 255, 150), v121);
        end;
    end;
end;

function u1.OnUseClicked() -- Line: 1083
    -- upvalues: u36 (ref), u1 (copy), u15 (ref), InventoryItems (copy), u3 (ref), Knit (copy), u23 (ref), u17 (ref), u16 (ref), u13 (ref), BuffPotionData (copy), u14 (ref), u11 (ref), u18 (ref), PackageData (copy), ShowPackageRewardToasts (copy), u20 (ref)
    if not u36 then
        return;
    end;

    local v129 = u1.ItemCache[u36];

    if not v129 then
        return;
    end;

    if v129.IsEquipment then
        if not u15 then
            return;
        end;

        if InventoryItems.IsEquipped(u3, v129.GUID) then
            local EquippedSlot = InventoryItems.GetEquippedSlot(u3, v129.GUID);

            if EquippedSlot then
                local v130, v131 = u15:Unequip(EquippedSlot):await();

                if v130 and v131 then
                    Knit.GetController("SoundController"):Play("Equip");

                    return;
                end;
            end;
        else
            local v132, v133 = u15:Equip(v129.GUID):await();

            if v132 and v133 then
                Knit.GetController("SoundController"):Play("Equip");
            end;
        end;

        return;
    end;

    if v129.IsCosmetic then
        if not u23 then
            return;
        end;

        if (u3.Data.CosmeticSlots or {})[v129.CosmeticSlot] == v129.CosmeticSetId then
            local v134, v135 = u23:Unequip(v129.CosmeticSlot):await();

            if v134 and v135 then
                Knit.GetController("SoundController"):Play("Equip");

                return;
            end;
        else
            local v136, v137 = u23:Equip(v129.CosmeticSetId, v129.CosmeticSlot):await();

            if v136 and v137 then
                Knit.GetController("SoundController"):Play("Equip");
            end;
        end;

        return;
    end;

    if v129.IsClassItem then
        if (u3.Data.EquippedClassItem or "") == v129.ClassItemId then
            if not u17 then
                return;
            end;

            local v138, v139 = u17:SwitchSlot(1):await();

            if v138 and (v139 and v139.Success) then
                Knit.GetController("SoundController"):Play("Equip");

                return;
            end;
        else
            if not u16 then
                return;
            end;

            local v140, v141 = u16:EquipClassItem(v129.ClassItemId):await();

            if v140 and v141 then
                Knit.GetController("SoundController"):Play("Equip");
            end;
        end;

        return;
    end;

    if not v129.Usable then
        return;
    end;

    if v129.ItemType == "BuffPotion" then
        if not u13 then
            return;
        end;

        local v142 = (u3.Data.ActiveBuffs or {})[v129.BuffType];

        if v142 and v142.PotionId ~= v129.ItemId then
            local Potion = BuffPotionData.GetPotion(v142.PotionId);
            local v143 = Potion and Potion.Name or v142.PotionId;

            if not Knit.GetController("WarningController"):Prompt({
                ConfirmText = "Overwrite",
                DenyText = "Cancel",
                Message = `You already have <b>{v143}</b> active.\nOverwrite with <b>{v129.DisplayName}</b>?\n<i>(Timer will reset)</i>`
            }) then
                return;
            end;
        end;

        local v144, _ = u13:UseBuff(v129.ItemId);

        if v144 then
            Knit.GetController("SoundController"):Play("sfx celeste Level Up");
        end;
    elseif v129.Category == "Consumable" then
        if not u14 then
            return;
        end;

        if v129.ItemId == "AspectGem" and not Knit.GetController("WarningController"):Prompt({
            ConfirmText = "Use",
            DenyText = "Cancel",
            Message = `<b>{v129.DisplayName}</b> is <b>extremely rare</b> and will be <b>consumed</b> when used.\nUse one now to roll a random Aspect onto your equipped class?`
        }) then
            return;
        end;

        local v145, v146 = u14:UseConsumable(v129.ItemId):await();

        if v145 and v146 then
            Knit.GetController("SoundController"):Play("sfx celeste Level Up");
        end;
    elseif v129.Category == "Potion" then
        if not u11 then
            return;
        end;

        if v129.InstantUse then
            local v147, v148 = u11:ConsumePotion(v129.ItemId):await();

            if v147 and v148 then
                Knit.GetController("SoundController"):Play("sfx celeste Level Up");
            end;
        elseif u11:EquipPotion(v129.ItemId) then
            Knit.GetController("SoundController"):Play("UI_Begin");
        end;
    elseif v129.ItemType == "Pack" then
        if not u18 then
            return;
        end;

        if PackageData.IsGearPackage(v129.ItemId) then
            local Data = u3.Data;
            local math_max_ret = math.max((Data.MaxInventorySlots or 60) - (Data.EquipmentInventory and #Data.EquipmentInventory or 0), 0);

            if math_max_ret < 5 and not Knit.GetController("WarningController"):Prompt({
                ConfirmText = "Open Anyway",
                DenyText = "Cancel",
                Message = `Your inventory is nearly full — <b>{math_max_ret}</b> slot(s) free.\n<b>{v129.DisplayName}</b> grants a full set of gear, and any items over your inventory limit will be <b>permanently DELETED</b>.\nOpen it anyway?`
            }) then
                return;
            end;
        end;

        local v149, v150, _, v151, v152 = u18:OpenPackage(v129.ItemId):await();

        if v149 and v150 then
            Knit.GetController("SoundController"):Play("UI_LegendaryChest");
            local Controller = Knit.GetController("RewardRevealController");

            if Controller then
                Controller = Controller:PlayEntries(v151, v129.DisplayName);
            end;

            if not Controller then
                ShowPackageRewardToasts(v151);
            end;

            if u20 and (v152 or 0) > 0 then
                u20:Show("Custom", v152 == 1 and "1 item didn\'t fit and was deleted." or v152 .. " items didn\'t fit and were deleted.", 4, Color3.fromRGB(255, 120, 120), Color3.fromRGB(60, 20, 20), "Error");
            end;
        end;
    end;
end;

function u1.OnDeleteClicked() -- Line: 1274
    -- upvalues: u36 (ref), u20 (ref), u1 (copy), InventoryItems (copy), u3 (ref), Knit (copy), u15 (ref), SelectionHighlight (copy), u35 (ref), u25 (ref), u26 (ref), u27 (ref), InventoryItemInfo (copy)
    if not u36 then
        if u20 then
            u20:Show("Custom", "Select an item first.", 3, Color3.fromRGB(255, 200, 80), Color3.fromRGB(60, 45, 15), "Error");
        end;

        return;
    end;

    local v153 = u1.ItemCache[u36];

    if not (v153 and v153.IsEquipment) then
        return;
    end;

    if v153.Locked then
        return;
    end;

    if InventoryItems.IsEquipped(u3, v153.GUID) then
        return;
    end;

    if not Knit.GetController("WarningController"):Prompt({
        ConfirmText = "Delete",
        DenyText = "Cancel",
        Message = `Delete <b>{v153.DisplayName}</b>?\nThis cannot be undone.`
    }) then
        return;
    end;

    if not u15 then
        return;
    end;

    local v154, v155 = u15:DeleteItem(v153.GUID):await();

    if v154 and v155 then
        u36 = nil;
        SelectionHighlight.Set(u35, false);
        u35 = nil;

        if u25 then
            u25.Text = "Equip";
        end;

        if u26 then
            u26.Visible = false;
        end;

        if u27 then
            u27.Visible = true;
        end;

        InventoryItemInfo.Hide();
        InventoryItemInfo.ResetDeleteConfirm();
        Knit.GetController("SoundController"):Play("UI_Delete");
    end;
end;

function u1.OnLockClicked() -- Line: 1311
    -- upvalues: u36 (ref), u20 (ref), u1 (copy), u15 (ref), Knit (copy)
    if not u36 then
        if u20 then
            u20:Show("Custom", "Select an item first.", 3, Color3.fromRGB(255, 200, 80), Color3.fromRGB(60, 45, 15), "Error");
        end;

        return;
    end;

    local v156 = u1.ItemCache[u36];

    if not (v156 and v156.IsEquipment) then
        return;
    end;

    if not u15 then
        return;
    end;

    local v157, v158 = u15:ToggleLock(v156.GUID):await();

    if v157 and v158 then
        Knit.GetController("SoundController"):Play("Click");
    end;
end;

function u1.ToggleMultiSelectMode() -- Line: 1338
    -- upvalues: u40 (ref), u41 (copy), Knit (copy), u15 (ref), u62 (ref), u28 (ref), u36 (ref), SelectionHighlight (copy), u35 (ref), u25 (ref), u26 (ref), u27 (ref), InventoryItemInfo (copy)
    if u40 then
        local v159 = 0;

        for _ in u41 do
            v159 = v159 + 1;
        end;

        if v159 > 0 and Knit.GetController("WarningController"):Prompt({
            ConfirmText = "Delete All",
            DenyText = "Cancel",
            Message = `Delete <b>{v159}</b> item(s)?\nThis cannot be undone.`
        }) then
            local u160 = {};

            for i in u41 do
                table.insert(u160, i);
            end;

            task.spawn(function() -- Line: 1360
                -- upvalues: u160 (copy), u15 (ref), Knit (ref)
                for _, v in u160 do
                    if u15 then
                        u15:DeleteItem(v):await();
                    end;
                end;

                Knit.GetController("SoundController"):Play("UI_Delete");
            end);
        end;

        u40 = false;
        table.clear(u41);
        u62();

        if u28 then
            u28.Text = "Select";
        end;
    else
        u40 = true;
        table.clear(u41);
        u62();

        if u28 then
            u28.Text = "Cancel";
        end;

        u36 = nil;
        SelectionHighlight.Set(u35, false);
        u35 = nil;

        if u25 then
            u25.Text = "Equip";
        end;

        if u26 then
            u26.Visible = false;
        end;

        if u27 then
            u27.Visible = true;
        end;

        InventoryItemInfo.Hide();
        InventoryItemInfo.ResetDeleteConfirm();
    end;
end;

function u1.QuickUse(p161: string) -- Line: 1394
    -- upvalues: u1 (copy), u15 (ref), InventoryItems (copy), u3 (ref), Knit (copy), u23 (ref)
    local v162 = u1.ItemCache[p161];

    if not v162 then
        return;
    end;

    if v162.IsEquipment then
        if not u15 then
            return;
        end;

        if InventoryItems.IsEquipped(u3, v162.GUID) then
            local EquippedSlot = InventoryItems.GetEquippedSlot(u3, v162.GUID);

            if EquippedSlot then
                local v163, v164 = u15:Unequip(EquippedSlot):await();

                if v163 and v164 then
                    Knit.GetController("SoundController"):Play("Equip");
                end;
            end;
        else
            local v165, v166 = u15:Equip(v162.GUID):await();

            if v165 and v166 then
                Knit.GetController("SoundController"):Play("Equip");
            end;
        end;
    elseif v162.IsCosmetic and u23 then
        if (u3.Data.CosmeticSlots or {})[v162.CosmeticSlot] == v162.CosmeticSetId then
            u23:Unequip(v162.CosmeticSlot):await();
        else
            u23:Equip(v162.CosmeticSetId, v162.CosmeticSlot):await();
        end;

        Knit.GetController("SoundController"):Play("Equip");
    end;
end;

function u1.QuickUnequipEquipment(p167: string) -- Line: 1431
    -- upvalues: u15 (ref), u3 (ref), Knit (copy)
    if not u15 then
        return;
    end;

    local v168 = u3.Data.Equipment[p167];

    if type(v168) ~= "table" or not v168.GUID then
        return;
    end;

    local v169, v170 = u15:Unequip(p167):await();

    if v169 and v170 then
        Knit.GetController("SoundController"):Play("Equip");
    end;
end;

function u1.QuickUnequipCosmetic(p171: string) -- Line: 1444
    -- upvalues: u23 (ref), u3 (ref), Knit (copy)
    if not u23 then
        return;
    end;

    local v172 = (u3.Data.CosmeticSlots or {})[p171];

    if not v172 or v172 == "" then
        return;
    end;

    local v173, v174 = u23:Unequip(p171):await();

    if v173 and v174 then
        Knit.GetController("SoundController"):Play("Equip");
    end;
end;

local function ScoreEquipItem(p175: userdata) -- Line: 1462
    -- upvalues: RarityData (copy)
    local v176 = 0 + (RarityData.RarityIndex[p175.Rarity] or 0) * 1000;

    if p175.Slot == "Ring" then
        v176 = v176 + (p175.BaseDamage or 0) * 10;
    end;

    if p175.Slot == "Body" and (p175.GuaranteedStat and p175.GuaranteedStat.Value) then
        v176 = v176 + p175.GuaranteedStat.Value * 10;
    end;

    if p175.Slot == "Head" and (p175.GuaranteedStat and p175.GuaranteedStat.Value) then
        v176 = v176 + p175.GuaranteedStat.Value * 10;
    end;

    if p175.StatLines then
        for _, v in p175.StatLines do
            v176 = v176 + math.abs(v.Value or 0) * 2;
        end;
    end;

    if p175.EnchantLevel and p175.EnchantLevel > 0 then
        v176 = v176 + p175.EnchantLevel * 50;
    end;

    return v176;
end;

function u1.OnEquipBestClicked() -- Line: 1503
    -- upvalues: u15 (ref), u3 (ref), EquipmentTemplates (copy), ScoreEquipItem (copy), Knit (copy)
    if not u15 then
        return;
    end;

    if not u3 then
        return;
    end;

    local Data = u3.Data;
    local v177 = Data.PlayerLevel or 1;
    local v178 = {
        Head = {},
        Body = {},
        Ring = {}
    };
    local EquipmentInventory = Data.EquipmentInventory;

    if not EquipmentInventory then
        return;
    end;

    for _, v in EquipmentInventory do
        if type(v) == "table" and (v.GUID and (v.Slot and (not v.Locked and (not v.LevelReq or v177 >= v.LevelReq)))) and v.Identified ~= false then
            local v179 = v178[v.Slot];

            if v179 then
                EquipmentTemplates.GetTemplate(v.ItemId);
                local v180 = {};
                local v181;

                if v.Stats then
                    v181 = v;

                    for i, v2 in v.Stats do
                        table.insert(v180, {
                            Key = i,
                            Value = v2
                        });
                    end;
                else
                    v181 = v;
                end;

                table.insert(v179, {
                    GUID = v181.GUID,
                    Slot = v181.Slot,
                    Rarity = v181.Rarity or "Common",
                    BaseDamage = v181.BaseDamage,
                    GuaranteedStat = v181.GuaranteedStat,
                    StatLines = v180,
                    EnchantLevel = v181.EnchantLevel or 0
                });
            end;
        end;
    end;

    local Equipment = Data.Equipment;

    for _, v in { "Head", "Body", "Ring" } do
        local v182 = Equipment[v];

        if type(v182) == "table" and (v182.GUID and v182.Identified ~= false) then
            local v183 = {};
            local v184;

            if v182.Stats then
                v184 = v;

                for i, v2 in v182.Stats do
                    table.insert(v183, {
                        Key = i,
                        Value = v2
                    });
                end;
            else
                v184 = v;
            end;

            table.insert(v178[v184], {
                _isEquipped = true,
                GUID = v182.GUID,
                Slot = v184,
                Rarity = v182.Rarity or "Common",
                BaseDamage = v182.BaseDamage,
                GuaranteedStat = v182.GuaranteedStat,
                StatLines = v183,
                EnchantLevel = v182.EnchantLevel or 0
            });
        end;
    end;

    local v185 = false;

    for _, v in { "Head", "Body", "Ring" } do
        local v186 = v178[v];

        if #v186 ~= 0 then
            local v187 = -1;
            local v188 = nil;

            for _, v2 in v186 do
                local v189 = ScoreEquipItem(v2);

                if v187 < v189 then
                    v188 = v2;
                    v187 = v189;
                end;
            end;

            if v188 and not v188._isEquipped then
                local v190, v191 = u15:Equip(v188.GUID):await();

                if v190 and v191 then
                    v185 = true;
                end;
            end;
        end;
    end;

    if v185 then
        Knit.GetController("SoundController"):Play("Equip");
    end;
end;

local function u197() -- Line: 1613
    -- upvalues: InventoryItems (copy), u3 (ref), u1 (copy), CreateBodyTemplate (copy), ApplyCardNameAndForge (copy), IsCardEquipped (copy), ApplyCardRarityVisuals (copy), MatchesFilter (copy), EnsureCosmeticPreview (copy), u36 (ref), UpdateSelectedInfo (copy), SelectionHighlight (copy), u35 (ref), u25 (ref), u26 (ref), u27 (ref), InventoryItemInfo (copy), u116 (ref), u60 (ref), u40 (ref), u41 (copy), u62 (ref)
    local v192 = InventoryItems.Build(u3);
    local v193 = {};

    for _, v in v192 do
        v193[v.ItemId] = true;
    end;

    for i, v in u1.Templates do
        if not v193[i] then
            v:Destroy();
            u1.Templates[i] = nil;
            u1.ItemCache[i] = nil;
        end;
    end;

    for _, v in v192 do
        local ItemId = v.ItemId;
        u1.ItemCache[ItemId] = v;

        if u1.Templates[ItemId] then
            local v194 = u1.Templates[ItemId];
            ApplyCardNameAndForge(v194, v);
            local Item_Level = v194:FindFirstChild("Item_Level");

            if Item_Level then
                if v.IsEquipment and (v.LevelReq and v.LevelReq > 0) then
                    Item_Level.Text = "Lvl. " .. v.LevelReq;
                    Item_Level.Visible = true;

                    if (u3.Data.PlayerLevel or 1) < v.LevelReq then
                        Item_Level.TextColor3 = Color3.fromRGB(255, 75, 75);
                    else
                        Item_Level.TextColor3 = Color3.fromRGB(180, 180, 180);
                    end;
                else
                    Item_Level.Visible = false;
                end;
            end;

            local Lock_Image = v194:FindFirstChild("Lock_Image");

            if Lock_Image then
                Lock_Image.Visible = v.IsEquipment and v.Locked == true;
            end;

            local Equipped = v194:FindFirstChild("Equipped");

            if Equipped then
                Equipped.Visible = IsCardEquipped(v);
            end;

            ApplyCardRarityVisuals(v194, v);
            local Amount = v194:FindFirstChild("Amount");

            if Amount then
                if ((v.ItemType == "BuffPotion" or (v.ItemType == "ConsumableItem" or (v.ItemType == "Pack" or (v.ItemType == "Chest" or (v.ItemType == "Material" or (v.ItemType == "QuestItem" or (v.ItemType == "Key" or (v.ItemType == "Spin" or v.ItemType == "Misc")))))))) and true or v.InstantUse) and (v.OwnedCount and v.OwnedCount > 0) then
                    Amount.Text = "x" .. v.OwnedCount;
                    Amount.Visible = true;
                else
                    Amount.Visible = false;
                end;
            end;
        else
            CreateBodyTemplate(v);
        end;

        local v195 = u1.Templates[ItemId];

        if v195 then
            local v196 = MatchesFilter(v);
            v195.Visible = v196;

            if v196 then
                EnsureCosmeticPreview(v195, v);
            end;
        end;
    end;

    if u36 then
        if u1.ItemCache[u36] then
            UpdateSelectedInfo(u36);
        else
            u36 = nil;
            SelectionHighlight.Set(u35, false);
            u35 = nil;

            if u25 then
                u25.Text = "Equip";
            end;

            if u26 then
                u26.Visible = false;
            end;

            if u27 then
                u27.Visible = true;
            end;

            InventoryItemInfo.Hide();
            InventoryItemInfo.ResetDeleteConfirm();
        end;
    end;

    u116();
    u60();

    if u40 then
        for i in u41 do
            if not u1.ItemCache[i] then
                u41[i] = nil;
            end;
        end;

        u62();
    end;
end;

local function SelectEquippedCosmetic(p198: string) -- Line: 1742
    -- upvalues: u3 (ref), u36 (ref), SelectionHighlight (copy), u35 (ref), u25 (ref), u26 (ref), u27 (ref), InventoryItemInfo (copy), u1 (copy), UpdateSelectedInfo (copy), InventoryCharacterPreview (copy)
    local v199 = (u3.Data.CosmeticSlots or {})[p198];

    if not v199 or v199 == "" then
        return;
    end;

    local v200 = "cosmetic:" .. v199 .. ":" .. p198;

    if u36 ~= v200 then
        if not u1.ItemCache[v200] then
            return;
        end;

        u36 = v200;
        UpdateSelectedInfo(v200);
        local SlotView = InventoryCharacterPreview.GetSlotView(p198);

        if SlotView then
            SelectionHighlight.Set(u35, false);
            u35 = SlotView;
            SelectionHighlight.Set(SlotView, true);
        end;

        return;
    end;

    u36 = nil;
    SelectionHighlight.Set(u35, false);
    u35 = nil;

    if u25 then
        u25.Text = "Equip";
    end;

    if u26 then
        u26.Visible = false;
    end;

    if u27 then
        u27.Visible = true;
    end;

    InventoryItemInfo.Hide();
    InventoryItemInfo.ResetDeleteConfirm();
end;

local function SetupTabs() -- Line: 1774
    -- upvalues: u6 (ref), u49 (copy), u37 (ref), u39 (ref), InventoryCosmeticsList (copy), ApplyFilterAndSearch (copy)
    local u201 = u6 and u6:FindFirstChild("Tabs");

    if not u201 then
        return;
    end;

    local function setTabVisual(p202: userdata, p203: boolean) -- Line: 1778
        local Active = p202:FindFirstChild("Active");
        local Inactive = p202:FindFirstChild("Inactive");

        if Active then
            Active.Visible = p203;
        end;

        if Inactive then
            Inactive.Visible = not p203;
        end;
    end;

    for _, child in u201:GetChildren() do
        if child:IsA("GuiButton") then
            local Name = child.Name;

            if u49[Name] ~= nil or Name == "All" then
                local Active = child:FindFirstChild("Active");
                local Inactive = child:FindFirstChild("Inactive");

                if Active then
                    Active = Active:FindFirstChild("Text");
                end;

                if Inactive then
                    Inactive = Inactive:FindFirstChild("Text");
                end;

                if Active and Inactive then
                    Active.Text = Inactive.Text;
                end;

                local v204 = Name == "All";
                local Active2 = child:FindFirstChild("Active");
                local Inactive2 = child:FindFirstChild("Inactive");

                if Active2 then
                    Active2.Visible = v204;
                end;

                if Inactive2 then
                    Inactive2.Visible = not v204;
                end;

                child.MouseButton1Click:Connect(function() -- Line: 1804
                    -- upvalues: u37 (ref), Name (copy), u39 (ref), InventoryCosmeticsList (ref), ApplyFilterAndSearch (ref), u201 (copy)
                    u37 = Name;
                    u39 = nil;

                    if Name == "Cosmetics" then
                        InventoryCosmeticsList.Show();
                    else
                        InventoryCosmeticsList.Hide();
                    end;

                    ApplyFilterAndSearch();

                    for _, child2 in u201:GetChildren() do
                        if child2:IsA("GuiButton") then
                            local v205 = child2.Name == Name;
                            local Active3 = child2:FindFirstChild("Active");
                            local Inactive3 = child2:FindFirstChild("Inactive");

                            if Active3 then
                                Active3.Visible = v205;
                            end;

                            if Inactive3 then
                                Inactive3.Visible = not v205;
                            end;
                        end;
                    end;
                end);
            end;
        end;
    end;
end;

local function SetupSearch() -- Line: 1829
end;

function u1._Init(p206) -- Line: 1838
    -- upvalues: u2 (ref), u4 (ref), UIController (copy), u9 (ref), u6 (ref), u5 (ref), u7 (ref), u8 (ref), u32 (ref), u33 (ref), u34 (ref), u1 (copy), u3 (ref), Registry (copy), u11 (ref), Knit (copy), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u17 (ref), u23 (ref), u18 (ref), u19 (ref), u20 (ref), u22 (ref), u21 (ref), u24 (ref), SetupTabs (copy), SetupCharacterInfo (copy), SetupStatsInfo (copy), u36 (ref), SelectionHighlight (copy), u35 (ref), u25 (ref), u26 (ref), u27 (ref), InventoryItemInfo (copy), InventoryCharacterPreview (copy), u10 (ref), SelectEquippedCosmetic (copy), IsItemEquipped (copy), IsCardEquipped (copy), GetContextualActionText (copy), InventoryStatUpgrade (copy), InventoryCosmeticsList (copy), u39 (ref), ApplyFilterAndSearch (copy), InventoryStatInfo (copy), InventoryLoadouts (copy), u28 (ref), u29 (ref), u197 (ref), u116 (ref), u118 (ref)
    u2 = p206;
    u4 = u2.Frames.Inventory;

    local function WireSwapButton(p207: string, u208: string) -- Line: 1844
        -- upvalues: u4 (ref), u2 (ref), UIController (ref)
        local v209 = u4:FindFirstChild(p207);

        if not (v209 and v209:IsA("GuiButton")) then
            return;
        end;

        v209.Activated:Connect(function() -- Line: 1847
            -- upvalues: u2 (ref), u208 (copy), UIController (ref)
            local v210 = u2.Frames:FindFirstChild(u208);
            local ByName = UIController.getByName(u208);

            if ByName then
                v210 = ByName;
            elseif v210 then
                v210 = UIController.new(v210);
            end;

            if v210 then
                v210:open();
            end;
        end);
    end;

    WireSwapButton("ClassInfo", "Class");
    WireSwapButton("Titles", "TitleIndex");
    WireSwapButton("ItemIndex", "ItemIndex");
    local Contents = u4:WaitForChild("Contents");
    local InventorySection = Contents:WaitForChild("InventorySection");
    u9 = Contents:FindFirstChild("LeftSection");
    u6 = InventorySection:WaitForChild("ItemPanel");
    u5 = u6:WaitForChild("ItemGrid");
    u7 = InventorySection:FindFirstChild("Buttons");
    u8 = InventorySection;
    local StatUpgrade = Contents:FindFirstChild("StatUpgrade");
    local v211 = u9 and u9:FindFirstChild("Stats");

    if v211 then
        v211 = v211:FindFirstChild("Contents");
    end;

    if v211 then
        v211 = v211:FindFirstChild("StatList");
    end;

    u32 = v211;
    local v212 = u9 and u9:FindFirstChild("GearScore");
    local v213;

    if v212 then
        v213 = v212:FindFirstChild("Score_Icon");
    else
        v213 = v212;
    end;

    if v213 then
        v213 = v213:FindFirstChild("Amount");
    end;

    u33 = v213;

    if v212 then
        v212 = v212:FindFirstChild("Info");
    end;

    u34 = v212;
    u1.ItemTemplate = u5:FindFirstChild("TemplateFrame");

    if u1.ItemTemplate then
        u1.ItemTemplate.Visible = false;
    end;

    u3 = Registry:Get("PlayerData");
    u11 = Knit.GetService("PotionService");
    u12 = Knit.GetService("ChestService");
    u13 = Knit.GetService("BuffService");
    u14 = Knit.GetService("ConsumableService");
    u15 = Knit.GetService("EquipmentService");
    u16 = Knit.GetService("ClassItemService");
    u17 = Knit.GetService("SummoningService");
    u23 = Knit.GetService("CosmeticService");
    u18 = Knit.GetService("PackageService");
    u19 = Knit.GetService("ShopService");
    pcall(function() -- Line: 1894
        -- upvalues: u20 (ref), Knit (ref)
        u20 = Knit.GetController("NotificationController");
    end);
    u22 = Knit.GetController("StatController");
    u21 = Knit.GetController("NoticeController");
    pcall(function() -- Line: 1899
        -- upvalues: u24 (ref), Knit (ref)
        u24 = Knit.GetController("UIAnimationController");
    end);
    u21:Register("Inventory", u2.HUD.Left.Inventory.Notice_Icon, function() -- Line: 1907
        -- upvalues: u22 (ref)
        local _, v214 = u22:GetSkillPoints();

        if v214 then
            v214 = v214 > 0;
        end;

        return v214;
    end);
    SetupTabs();
    SetupCharacterInfo();
    SetupStatsInfo();

    local function DeselectCurrent() -- Line: 1921
        -- upvalues: u36 (ref), SelectionHighlight (ref), u35 (ref), u25 (ref), u26 (ref), u27 (ref), InventoryItemInfo (ref)
        u36 = nil;
        SelectionHighlight.Set(u35, false);
        u35 = nil;

        if u25 then
            u25.Text = "Equip";
        end;

        if u26 then
            u26.Visible = false;
        end;

        if u27 then
            u27.Visible = true;
        end;

        InventoryItemInfo.Hide();
        InventoryItemInfo.ResetDeleteConfirm();
    end;

    InventoryCharacterPreview.Setup({
        PlayerData = u3,
        InventoryFrame = u4,
        CharacterInfoFrame = u10,
        OnCosmeticSlotClicked = SelectEquippedCosmetic,
        OnCosmeticSlotRightClicked = u1.QuickUnequipCosmetic
    });
    InventoryItemInfo.Setup(u9, {
        PlayerData = u3,
        IsItemEquipped = IsItemEquipped,
        IsCardEquipped = IsCardEquipped,
        GetContextualActionText = GetContextualActionText,
        OnUseClicked = u1.OnUseClicked,
        OnClosed = DeselectCurrent,
        SetVanityView = InventoryCharacterPreview.SetVanityView
    });
    InventoryStatUpgrade.Setup({
        StatUpgradeFrame = StatUpgrade,
        InvSectionFrame = u8,
        ButtonsFrame = u7,
        InventoryFrame = u4,
        PlayerData = u3,
        OnPanelOpened = DeselectCurrent
    });
    InventoryCosmeticsList.Setup({
        PlayerData = u3,
        ItemPanel = u6,

        OnGroupSelected = function(p215) -- Line: 1964, Name: OnGroupSelected
            -- upvalues: u39 (ref), ApplyFilterAndSearch (ref)
            u39 = p215;
            ApplyFilterAndSearch();
        end
    });
    InventoryStatInfo.Setup({
        StatInfoFrame = Contents:FindFirstChild("StatInfo"),
        InvSectionFrame = u8,
        ContentsFrame = Contents,
        StatInfoButton = u4:FindFirstChild("StatInfo"),
        InventoryFrame = u4,
        PlayerData = u3,
        OnPanelOpened = DeselectCurrent,
        ShowStatUpgrade = InventoryStatUpgrade.Show
    });
    InventoryLoadouts._Init(u2);

    if u7 then
        local Equip = u7:FindFirstChild("Equip");

        if Equip and Equip:IsA("GuiButton") then
            u25 = Equip:FindFirstChild("Title");
            u26 = Equip:FindFirstChild("On");
            u27 = Equip:FindFirstChild("Off");

            if u26 then
                u26.Visible = false;
            end;

            if u27 then
                u27.Visible = true;
            end;

            Equip.MouseButton1Click:Connect(function() -- Line: 1997
                -- upvalues: u1 (ref)
                u1.OnUseClicked();
            end);
        end;

        local Select = u7:FindFirstChild("Select");

        if Select and Select:IsA("GuiButton") then
            u28 = Select:FindFirstChild("Title");
            Select.MouseButton1Click:Connect(function() -- Line: 2006
                -- upvalues: u1 (ref)
                u1.ToggleMultiSelectMode();
            end);
        else
            warn("[Inventory] Buttons.Select NOT FOUND — multi-select delete unavailable!");
        end;

        local Lock = u7:FindFirstChild("Lock");

        if Lock and Lock:IsA("GuiButton") then
            Lock.MouseButton1Click:Connect(function() -- Line: 2016
                -- upvalues: u1 (ref)
                u1.OnLockClicked();
            end);
        end;

        local Loadouts = u7:FindFirstChild("Loadouts");

        if Loadouts and Loadouts:IsA("GuiButton") then
            Loadouts.MouseButton1Click:Connect(function() -- Line: 2024
                -- upvalues: InventoryLoadouts (ref)
                InventoryLoadouts.Show();
            end);
        end;

        for _, child in u7:GetChildren() do
            if child.Name == "EquipBest" and child:IsA("GuiButton") then
                local Title = child:FindFirstChild("Title");

                if Title and (Title:IsA("TextLabel") and Title.Text == "Equip Best") then
                    child.MouseButton1Click:Connect(function() -- Line: 2037
                        -- upvalues: u1 (ref)
                        u1.OnEquipBestClicked();
                    end);
                end;
            end;
        end;
    else
        warn("[Inventory] InventorySection.Buttons NOT FOUND — action buttons unavailable!");
    end;

    local SlotCapacity = InventorySection:FindFirstChild("SlotCapacity");

    if SlotCapacity then
        local Icon = SlotCapacity:FindFirstChild("Icon");

        if Icon then
            Icon = Icon:FindFirstChild("Amount");
        end;

        u29 = Icon;
        local Button = SlotCapacity:FindFirstChild("Button");

        if Button and Button:IsA("GuiButton") then
            Button.MouseButton1Click:Connect(function() -- Line: 2057
                -- upvalues: u19 (ref), Knit (ref)
                local v216, v217 = u19:GetExpansionInfo():await();

                if not v216 then
                    warn("[Inventory] GetExpansionInfo promise rejected:", v217);

                    return;
                end;

                if not v217 then
                    warn("[Inventory] GetExpansionInfo returned nil");

                    return;
                end;

                local Controller = Knit.GetController("WarningController");

                if not v217.NextCoinCost then
                    if not v217.CanBuyRobux then
                        Controller:Prompt({
                            ConfirmText = "OK",
                            DenyText = "OK",
                            Message = string.format("Your inventory is fully expanded! (<b>%d / %d</b>)", v217.CurrentMax, v217.MaxCap)
                        });

                        return;
                    end;

                    if not Controller:Prompt({
                        ConfirmText = "Purchase",
                        DenyText = "Cancel",
                        Message = string.format("All coin expansions purchased!\n\nBuy <b>+%d slots</b> for <b>75 Robux</b>?\n(%d / %d max)", v217.RobuxSlots, v217.CurrentMax, v217.MaxCap)
                    }) then
                        return;
                    end;

                    Knit.GetController("MarketplaceController"):PromptProduct(v217.RobuxProductId);

                    return;
                end;

                if not Controller:Prompt({
                    ConfirmText = "Buy",
                    DenyText = "Cancel",
                    Message = string.format("Expand inventory by <b>+%d slots</b> (%d → %d)?\n\nCost: <b>%s Coins</b>", v217.NextCoinSlots, v217.CurrentMax, v217.CurrentMax + v217.NextCoinSlots, (tostring(v217.NextCoinCost)))
                }) then
                    return;
                end;

                local v218, v219, v220 = u19:PurchaseExpansion():await();

                if not v218 then
                    warn("[Inventory] PurchaseExpansion promise rejected:", v219);

                    return;
                end;

                if v219 then
                    Knit.GetController("SoundController"):Play("ItemPurchased");

                    return;
                end;

                warn("[Inventory] PurchaseExpansion failed:", v220);
                Controller:Prompt({
                    ConfirmText = "OK",
                    DenyText = "OK",
                    Message = v220 == "INSUFFICIENT_FUNDS" and "You don\'t have enough <b>Coins</b> for this expansion!" or "Expansion purchase failed. Please try again."
                });
            end);
        end;
    end;

    SelectionHighlight.Set(u35, false);
    u35 = nil;

    if u25 then
        u25.Text = "Equip";
    end;

    if u26 then
        u26.Visible = false;
    end;

    if u27 then
        u27.Visible = true;
    end;

    InventoryItemInfo.Hide();
    InventoryItemInfo.ResetDeleteConfirm();
    u3:OnChange(function(p221, p222) -- Line: 2149
        -- upvalues: u197 (ref), InventoryCharacterPreview (ref), u116 (ref), InventoryStatUpgrade (ref)
        local v223 = p222[1];

        if v223 == "Potions" or (v223 == "CraftingMaterials" or (v223 == "ProtectionScrolls" or (v223 == "GoldenHammers" or (v223 == "LootChests" or (v223 == "BuffPotions" or (v223 == "ActiveBuffs" or (v223 == "Consumables" or (v223 == "EquippedPotion" or (v223 == "Equipment" or (v223 == "EquipmentInventory" or (v223 == "PlayerLevel" or (v223 == "MaxInventorySlots" or (v223 == "OwnedCosmetics" or (v223 == "CosmeticSlots" or (v223 == "ClassItems" or (v223 == "EquippedClassItem" or (v223 == "Packs" or (v223 == "QuestItems" or (v223 == "Keys" or (v223 == "NormalSpins" or v223 == "LuckySpins")))))))))))))))))))) then
            u197();
        end;

        if v223 == "CosmeticSlots" then
            InventoryCharacterPreview.RefreshCosmetics();
            InventoryCharacterPreview.RefreshViewportCosmetics();
        end;

        if v223 == "ComputedStats" or (v223 == "PlayerLevel" or (v223 == "ClassMastery" or v223 == "ActiveClass")) then
            u116();
        end;

        if v223 == "ActiveClass" then
            InventoryCharacterPreview.RebuildDeferred();
            InventoryCharacterPreview.RefreshClassIcon();
            InventoryStatUpgrade.RefreshRecommendations();
        end;
    end);
    u22:OnChanged(function() -- Line: 2205
        -- upvalues: u118 (ref), InventoryStatUpgrade (ref), u21 (ref)
        u118();
        InventoryStatUpgrade.Refresh();
        u21:Update("Inventory");
    end);
    u197();
end;

function u1.Destroy() -- Line: 2219
    -- upvalues: u1 (copy), u41 (copy), InventoryCharacterPreview (copy), InventoryStatUpgrade (copy), InventoryStatInfo (copy), u36 (ref), u35 (ref), u37 (ref), u38 (ref), u40 (ref)
    for _, v in u1.Templates do
        v:Destroy();
    end;

    table.clear(u1.Templates);
    table.clear(u1.ItemCache);
    table.clear(u41);
    InventoryCharacterPreview.Destroy();
    InventoryStatUpgrade.Destroy();
    InventoryStatInfo.Destroy();
    u36 = nil;
    u35 = nil;
    u37 = "All";
    u38 = "";
    u40 = false;
end;

return u1;