--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ItemShop
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.ItemShop
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local GameInfo = ReplicatedStorage:WaitForChild("GameInfo");
local EquipmentShopData = require(GameInfo:WaitForChild("EquipmentShopData"));
local EquipmentTemplates = require(GameInfo:WaitForChild("EquipmentTemplates"));
local RarityData = require(GameInfo:WaitForChild("RarityData"));
local Image_Data = require(GameInfo:WaitForChild("Image_Data"));
local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local Knit = require(ReplicatedStorage.Packages.Knit);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local RevealCascade = require(script.Parent.Parent.ClientUtils.RevealCascade);
local EquipmentStatLines = require(script.Parent.Parent.ClientUtils.EquipmentStatLines);
local TabStyles = require(script.Parent.Parent.ClientUtils.TabStyles);
local Color3_new_ret = Color3.new(1, 1, 1);
local u1 = {
    Head = 1,
    Body = 2,
    Ring = 3
};
local RarityIndex = RarityData.RarityIndex;
local u2 = RarityIndex.Mythic or 6;
local GearRarityTabs = RarityData.GearRarityTabs;
local TweenInfo_new_ret = TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.In);
local u3 = {};
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = "Buy";
local u11 = {};
local u12 = nil;
local u13 = 0;
local u14 = false;
local u15 = nil;
local u16 = false;
local u17 = {};
local u18 = {};
local u19 = false;
u3.Rows = {};
u3.SellRows = {};
local u20 = {};
local u21 = 0;
local u22 = {};
local u23 = 0;
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
local u34 = {};
local u35 = nil;
local u36 = nil;
local u37 = nil;
local u38 = nil;
local u39 = nil;
local u40 = nil;
local u41 = nil;
local u42 = nil;
local u43 = nil;
local u44 = nil;
local u45 = nil;
local u46 = nil;
local u47 = nil;
local u48 = nil;
local u49 = nil;
local u50 = nil;
local u51 = nil;
local u52 = nil;
local u53 = nil;
local u54 = nil;
local u55 = nil;

local function TweenScale(p56: userdata, p57: number, p58: userdata) -- Line: 165
    -- upvalues: u22 (copy), TweenService (copy)
    local v59 = u22[p56];

    if v59 then
        v59:Cancel();
    end;

    local v60 = TweenService:Create(p56, p58, {
        Scale = p57
    });
    u22[p56] = v60;
    v60:Play();

    return v60;
end;

local function ScaleOf(p61) -- Line: 176
    return p61 and p61:FindFirstChildWhichIsA("UIScale") or nil;
end;

local function SetRowSelected(p62: any, p63: boolean) -- Line: 183
    -- upvalues: TweenScale (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy)
    if p62 then
        p62 = p62:FindFirstChild("Selected");
    end;

    local v64 = p62 and p62:FindFirstChildWhichIsA("UIScale") or nil;

    if not v64 then
        return;
    end;

    TweenScale(v64, p63 and 1 or 0, p63 and TweenInfo_new_ret or TweenInfo_new_ret2);
end;

local function RarityColorOf(p65: string?) -- Line: 190
    -- upvalues: RarityColors (copy), Color3_new_ret (copy)
    local v66 = RarityColors[p65];

    return v66 and v66.TextColor3 or Color3_new_ret;
end;

local function RarityIndexOf(p67: string?) -- Line: 195
    -- upvalues: RarityIndex (copy)
    return RarityIndex[p67] or 1;
end;

local function FormatCoins(p68: number) -- Line: 199
    -- upvalues: SharedUtils (copy)
    return SharedUtils.FormatNumber(p68);
end;

local function FormatTimer(p69: number) -- Line: 203
    local math_floor_ret = math.floor(p69 / 3600);
    local math_floor_ret2 = math.floor(p69 % 3600 / 60);

    return string.format("RESTOCK IN: %02d:%02d:%02d", math_floor_ret, math_floor_ret2, p69 % 60);
end;

local function IconFor(p70: string) -- Line: 211
    -- upvalues: Image_Data (copy), EquipmentTemplates (copy)
    local v71 = Image_Data.Equipment and Image_Data.Equipment[p70];

    if not v71 or (v71 == "" or v71 == "rbxassetid://0") then
        local Template = EquipmentTemplates.GetTemplate(p70);
        v71 = Template and Template.ImageId or "";
    end;

    return v71 == "rbxassetid://0" and "" or v71;
end;

local function DisplayNameFor(p72: string) -- Line: 221
    -- upvalues: EquipmentTemplates (copy)
    local Template = EquipmentTemplates.GetTemplate(p72);

    return Template and Template.DisplayName or (p72 or "???");
end;

local function NameWithUpgrade(p73) -- Line: 227
    -- upvalues: EquipmentTemplates (copy)
    local ItemId = p73.ItemId;
    local Template = EquipmentTemplates.GetTemplate(ItemId);
    local v74 = Template and Template.DisplayName or (ItemId or "???");
    local v75 = p73.ForgeLevel or 0;
    local v76 = p73.EnchantLevel or 0;

    if v75 > 0 then
        return v74 .. " +" .. v75;
    end;

    if v76 > 0 then
        v74 = v74 .. " +" .. v76;
    end;

    return v74;
end;

local function IsEquippedGUID(p77: string) -- Line: 239
    -- upvalues: u5 (ref)
    local Equipment = u5.Data.Equipment;

    if not Equipment then
        return false;
    end;

    for _, v in { "Head", "Body", "Ring" } do
        local v78 = Equipment[v];

        if type(v78) == "table" and v78.GUID == p77 then
            return true;
        end;
    end;

    return false;
end;

local function IsUnsellable(p79) -- Line: 252
    -- upvalues: EquipmentTemplates (copy)
    local Template = EquipmentTemplates.GetTemplate(p79.ItemId);

    if Template then
        Template = Template.Unsellable;
    end;

    return Template == true;
end;

local function IsSellable(p80) -- Line: 261
    -- upvalues: IsEquippedGUID (copy), EquipmentTemplates (copy)
    if type(p80) ~= "table" or not p80.GUID then
        return false;
    end;

    if p80.Locked then
        return false;
    end;

    if IsEquippedGUID(p80.GUID) then
        return false;
    end;

    local Template = EquipmentTemplates.GetTemplate(p80.ItemId);

    if Template then
        Template = Template.Unsellable;
    end;

    return Template ~= true;
end;

local function FindEquipmentByGUID(p81: string) -- Line: 269
    -- upvalues: u5 (ref)
    local EquipmentInventory = u5.Data.EquipmentInventory;

    if not EquipmentInventory then
        return nil;
    end;

    for _, v in EquipmentInventory do
        if type(v) == "table" and v.GUID == p81 then
            return v;
        end;
    end;

    return nil;
end;

local function SellPriceOf(p82) -- Line: 280
    -- upvalues: EquipmentShopData (copy)
    return EquipmentShopData.GetSellPrice(p82.Rarity or "Common");
end;

local function SortForDisplay(p83: table) -- Line: 290
    -- upvalues: u1 (copy), RarityIndex (copy), EquipmentTemplates (copy)
    table.sort(p83, function(p84, p85) -- Line: 291
        -- upvalues: u1 (ref), RarityIndex (ref), EquipmentTemplates (ref)
        local v86 = u1[p84.Slot] or 99;
        local v87 = u1[p85.Slot] or 99;

        if v86 ~= v87 then
            return v86 < v87;
        end;

        local v88 = RarityIndex[p84.Rarity] or 1;
        local v89 = RarityIndex[p85.Rarity] or 1;

        if v88 ~= v89 then
            return v88 < v89;
        end;

        local ItemId = p84.ItemId;
        local Template = EquipmentTemplates.GetTemplate(ItemId);
        local v90 = Template and Template.DisplayName or (ItemId or "???");
        local ItemId2 = p85.ItemId;
        local Template2 = EquipmentTemplates.GetTemplate(ItemId2);

        return v90 < (Template2 and Template2.DisplayName or (ItemId2 or "???"));
    end);
end;

local function ClearLeftList() -- Line: 308
    -- upvalues: u3 (copy), u22 (copy)
    for _, v in u3.Rows do
        if v and v.Parent then
            local Selected = v:FindFirstChild("Selected");
            local v91 = Selected and Selected:FindFirstChildWhichIsA("UIScale") or nil;

            if v91 then
                local v92 = u22[v91];

                if v92 then
                    v92:Cancel();
                end;

                u22[v91] = nil;
            end;

            v:Destroy();
        end;
    end;

    table.clear(u3.Rows);
end;

local function PaintRow(p93: any, p94: any, p95: number) -- Line: 326
    -- upvalues: RarityColors (copy), Color3_new_ret (copy), EquipmentTemplates (copy), Image_Data (copy)
    p93.Name = "Row_" .. p94.GUID;
    p93.LayoutOrder = p95;
    p93.Visible = true;
    local Background = p93:FindFirstChild("Background");

    if Background then
        Background = Background:FindFirstChildWhichIsA("UIStroke");
    end;

    if Background then
        local v96 = RarityColors[p94.Rarity];
        Background.Color = v96 and v96.TextColor3 or Color3_new_ret;
    end;

    local Item_Name = p93:FindFirstChild("Item_Name");

    if Item_Name then
        local ItemId = p94.ItemId;
        local Template = EquipmentTemplates.GetTemplate(ItemId);
        local v97 = Template and Template.DisplayName or (ItemId or "???");
        local v98 = p94.ForgeLevel or 0;
        local v99 = p94.EnchantLevel or 0;

        if v98 > 0 then
            v97 = v97 .. " +" .. v98;
        elseif v99 > 0 then
            v97 = v97 .. " +" .. v99;
        end;

        Item_Name.Text = v97;
        local v100 = RarityColors[p94.Rarity];
        Item_Name.TextColor3 = v100 and v100.TextColor3 or Color3_new_ret;
        Item_Name.Visible = true;
    end;

    local Item_Level = p93:FindFirstChild("Item_Level");

    if Item_Level then
        Item_Level.Text = "lvl. " .. (p94.LevelReq or 1);
        Item_Level.Visible = true;
    end;

    local ItemImage = p93:FindFirstChild("ItemImage");

    if ItemImage then
        local ItemId = p94.ItemId;
        local v101 = Image_Data.Equipment and Image_Data.Equipment[ItemId];

        if not v101 or (v101 == "" or v101 == "rbxassetid://0") then
            local Template = EquipmentTemplates.GetTemplate(ItemId);
            v101 = Template and Template.ImageId or "";
        end;

        local v102 = v101 == "rbxassetid://0" and "" or v101;
        ItemImage.Image = v102;
        ItemImage.Visible = v102 ~= "";
    end;

    local Amount = p93:FindFirstChild("Amount");

    if Amount then
        Amount.Visible = false;
    end;

    local Equipped = p93:FindFirstChild("Equipped");

    if Equipped then
        Equipped.Visible = false;
    end;

    local Lock_Image = p93:FindFirstChild("Lock_Image");

    if Lock_Image then
        Lock_Image.Visible = false;
    end;

    local ViewportFrame = p93:FindFirstChild("ViewportFrame");

    if ViewportFrame then
        ViewportFrame.Visible = false;
    end;

    local Sell_Cover = p93:FindFirstChild("Sell_Cover");

    if Sell_Cover then
        Sell_Cover.Visible = false;
    end;

    local Selected = p93:FindFirstChild("Selected");

    if Selected then
        Selected.Visible = true;
        local v103 = Selected and Selected:FindFirstChildWhichIsA("UIScale") or nil;

        if v103 then
            v103.Scale = 0;
        end;
    end;
end;

local function IsEquipmentRecord(p104) -- Line: 390
    return p104.Slot ~= nil;
end;

local function ShowBuyInfo(p105) -- Line: 400
    -- upvalues: u12 (ref), u36 (ref), EquipmentTemplates (copy), RarityColors (copy), Color3_new_ret (copy), u37 (ref), u43 (ref), Image_Data (copy), u44 (ref), SharedUtils (copy), u5 (ref), u38 (ref), u41 (ref), u40 (ref), EquipmentStatLines (copy), u42 (ref), u39 (ref), u3 (copy), TweenScale (copy), TweenInfo_new_ret2 (copy), TweenInfo_new_ret (copy)
    local v106 = u12;
    u12 = p105.GUID;
    local v107 = p105.Slot ~= nil;

    if u36 then
        local ItemId = p105.ItemId;
        local Template = EquipmentTemplates.GetTemplate(ItemId);
        u36.Text = Template and Template.DisplayName or (ItemId or "???");
        local v108 = RarityColors[p105.Rarity];
        u36.TextColor3 = v108 and v108.TextColor3 or Color3_new_ret;
    end;

    if u37 then
        u37.Text = p105.Rarity or "Common";
        local v109 = RarityColors[p105.Rarity];
        u37.TextColor3 = v109 and v109.TextColor3 or Color3_new_ret;
    end;

    if u43 then
        local ItemId = p105.ItemId;
        local v110 = Image_Data.Equipment and Image_Data.Equipment[ItemId];

        if not v110 or (v110 == "" or v110 == "rbxassetid://0") then
            local Template = EquipmentTemplates.GetTemplate(ItemId);
            v110 = Template and Template.ImageId or "";
        end;

        local v111 = v110 == "rbxassetid://0" and "" or v110;
        u43.Image = v111;
        u43.Visible = v111 ~= "";
    end;

    if u44 then
        u44.Text = SharedUtils.FormatNumber(p105.Cost or 0);
        u44.TextColor3 = (u5.Data.Currency or 0) >= (p105.Cost or 0) and Color3_new_ret or Color3.fromRGB(255, 75, 75);
    end;

    if v107 then
        if u38 then
            u38.Visible = false;
        end;

        if u41 then
            u41.Visible = true;
        end;

        if u40 then
            u40.Visible = true;
        end;

        local v112;

        if p105.Slot then
            v112 = u5.Data.Equipment[p105.Slot] or nil;
        else
            v112 = nil;
        end;

        EquipmentStatLines.render(u40, u42, {
            Slot = p105.Slot,
            BaseDamage = p105.BaseDamage,
            GuaranteedStat = p105.GuaranteedStat,
            ForgeBonuses = p105.ForgeBonuses,
            StatLines = EquipmentStatLines.build(p105.Stats, p105.Slot)
        }, v112);
    else
        if u41 then
            u41.Visible = false;
        end;

        if u40 then
            u40.Visible = false;
        end;

        if u38 then
            u38.Visible = true;
        end;

        if u39 then
            u39.Text = p105.Description or "";
        end;
    end;

    if v106 and v106 ~= u12 then
        local v113 = u3.Rows[v106];

        if v113 then
            v113 = v113:FindFirstChild("Selected");
        end;

        local v114 = v113 and v113:FindFirstChildWhichIsA("UIScale") or nil;

        if v114 then
            TweenScale(v114, 0, TweenInfo_new_ret2);
        end;
    end;

    local v115 = u3.Rows[u12];

    if v115 then
        v115 = v115:FindFirstChild("Selected");
    end;

    local v116 = v115 and v115:FindFirstChildWhichIsA("UIScale") or nil;

    if not v116 then
        return;
    end;

    TweenScale(v116, 1, TweenInfo_new_ret or TweenInfo_new_ret2);
end;

function u3.OnBuyClicked() -- Line: 467
    -- upvalues: u16 (ref), u6 (ref), u12 (ref), u7 (ref), u11 (ref), u5 (ref), u9 (ref), u8 (ref), u55 (ref)
    if u16 or not u6 then
        return;
    end;

    if not u12 then
        if u7 then
            u7:Show("Custom", "Select an item first!");
        end;

        return;
    end;

    local u117 = u12;
    local v118 = nil;

    for _, v in u11 do
        if v.GUID == u117 then
            v118 = v;
            break;
        end;
    end;

    if not v118 then
        return;
    end;

    if (u5.Data.Currency or 0) < v118.Cost then
        if u7 then
            u7:Show("Custom", "Not enough coins!");
        end;

        return;
    end;

    u16 = true;
    local Data = u5.Data;
    local v119 = (Data.MaxInventorySlots or 60) - (Data.EquipmentInventory and #Data.EquipmentInventory or 0);

    if v119 <= 0 then
        if u7 then
            u7:Show("Custom", "Inventory full — make room before buying equipment.", 4, Color3.fromRGB(255, 100, 100), Color3.fromRGB(80, 30, 30), "Error");
        end;

        u16 = false;

        return;
    end;

    if v119 < 5 and (u9 and not u9:Prompt({
        ConfirmText = "Buy Anyway",
        DenyText = "Cancel",
        Message = `Your inventory is nearly full — <b>{v119}</b> slot(s) free.\nPurchased gear that doesn't fit will overflow to Loot Storage.\nBuy anyway?`
    })) then
        u16 = false;

        return;
    end;

    u6:BuyEquipment(u117):andThen(function(p120, p121) -- Line: 530
        -- upvalues: u8 (ref), u7 (ref), u11 (ref), u117 (copy), u12 (ref), u55 (ref)
        if not p120 then
            local v122 = {
                NO_CASH = "Not enough coins!",
                ITEM_NOT_FOUND = "Item no longer available.",
                TOO_FAST = "Too fast! Try again."
            };

            if u7 then
                if p121 == "INVENTORY_FULL" then
                    u7:Show("INVENTORY_FULL");

                    return;
                end;

                u7:Show("Custom", v122[p121] or "Purchase failed.");
            end;

            return;
        end;

        if u8 then
            u8:Play("ItemPurchased");
        end;

        if u7 then
            u7:Show("Custom", "Equipment purchased!");
        end;

        for i, v in u11 do
            if v.GUID == u117 then
                table.remove(u11, i);
                break;
            end;
        end;

        if u12 == u117 then
            u12 = nil;
        end;

        u55();
    end):catch(function(p123) -- Line: 559
        warn("[ItemShop] BuyEquipment failed:", p123);
    end):finally(function() -- Line: 561
        -- upvalues: u16 (ref)
        u16 = false;
    end);
end;

local function IsSelectedForSell(p124: string) -- Line: 570
    -- upvalues: u18 (copy)
    return u18[p124] == true;
end;

local function UpdateSellCovers() -- Line: 575
    -- upvalues: u3 (copy), u18 (copy)
    for i, v in u3.Rows do
        local Sell_Cover = v:FindFirstChild("Sell_Cover");

        if Sell_Cover then
            Sell_Cover.Visible = u18[i] == true;
        end;
    end;
end;

local function AddToSell(p125: string) -- Line: 585
    -- upvalues: u18 (copy), u17 (copy), u53 (ref), UpdateSellCovers (copy), u52 (ref)
    if u18[p125] then
        return;
    end;

    u18[p125] = true;
    table.insert(u17, p125);
    u53(p125);
    UpdateSellCovers();
    u52();
end;

local function RemoveFromSell(p126: string) -- Line: 595
    -- upvalues: u18 (copy), u17 (copy), u54 (ref), UpdateSellCovers (copy), u52 (ref)
    if not u18[p126] then
        return;
    end;

    u18[p126] = nil;

    for i, v in u17 do
        if v == p126 then
            table.remove(u17, i);
            break;
        end;
    end;

    u54(p126);
    UpdateSellCovers();
    u52();
end;

local function ToggleSell(p127: string) -- Line: 609
    -- upvalues: u18 (copy), RemoveFromSell (copy), u17 (copy), u53 (ref), UpdateSellCovers (copy), u52 (ref)
    if u18[p127] then
        RemoveFromSell(p127);

        return;
    end;

    if u18[p127] then
        return;
    end;

    u18[p127] = true;
    table.insert(u17, p127);
    u53(p127);
    UpdateSellCovers();
    u52();
end;

local function SetRarityTabActive(p128: any, p129: boolean) -- Line: 623
    -- upvalues: TabStyles (copy)
    TabStyles.setStateActive(p128, p129);
end;

local function SellableEntries() -- Line: 629
    -- upvalues: u5 (ref), IsEquippedGUID (copy), EquipmentTemplates (copy)
    local v130 = {};
    local EquipmentInventory = u5.Data.EquipmentInventory;

    if EquipmentInventory then
        for _, v in EquipmentInventory do
            local v131;

            if type(v) == "table" and v.GUID and not (v.Locked or IsEquippedGUID(v.GUID)) then
                local Template = EquipmentTemplates.GetTemplate(v.ItemId);

                if Template then
                    Template = Template.Unsellable;
                end;

                v131 = Template ~= true;
            else
                v131 = false;
            end;

            if v131 then
                table.insert(v130, v);
            end;
        end;
    end;

    return v130;
end;

local function ToggleRaritySelection(p132: string?) -- Line: 645
    -- upvalues: SellableEntries (copy), u18 (copy), RemoveFromSell (copy), u17 (copy), u53 (ref), UpdateSellCovers (copy), u52 (ref)
    local v133 = {};

    for _, v in SellableEntries() do
        if p132 == nil or v.Rarity == p132 then
            table.insert(v133, v);
        end;
    end;

    if #v133 == 0 then
        return;
    end;

    local v134 = true;

    for _, v in v133 do
        if not u18[v.GUID] then
            v134 = false;
            break;
        end;
    end;

    for _, v in v133 do
        if v134 then
            RemoveFromSell(v.GUID);
        else
            local GUID = v.GUID;

            if not u18[GUID] then
                u18[GUID] = true;
                table.insert(u17, GUID);
                u53(GUID);
                UpdateSellCovers();
                u52();
            end;
        end;
    end;
end;

local function UpdateRarityTabStates() -- Line: 675
    -- upvalues: u31 (ref), u10 (ref), SellableEntries (copy), u18 (copy), u32 (ref), TabStyles (copy), u34 (copy)
    if not u31 or u10 ~= "Sell" then
        return;
    end;

    local v135 = {};
    local v136 = 0;
    local v137 = {};
    local v138 = 0;

    for _, v in SellableEntries() do
        local v139 = v.Rarity or "Common";
        v135[v139] = (v135[v139] or 0) + 1;
        v136 = v136 + 1;

        if u18[v.GUID] then
            v137[v139] = (v137[v139] or 0) + 1;
            v138 = v138 + 1;
        end;
    end;

    if u32 then
        local v140;

        if v136 > 0 then
            v140 = v138 == v136;
        else
            v140 = false;
        end;

        TabStyles.setStateActive(u32, v140);
    end;

    for i, v in u34 do
        local v141 = v135[i] or 0;
        local v142;

        if v141 > 0 then
            v142 = (v137[i] or 0) == v141;
        else
            v142 = false;
        end;

        TabStyles.setStateActive(v, v142);
    end;
end;

local function BuildRarityTabs() -- Line: 703
    -- upvalues: u33 (ref), u31 (ref), GearRarityTabs (copy), TabStyles (copy), ToggleRaritySelection (copy), u34 (copy)
    if not (u33 and u31) then
        return;
    end;

    for i, v in GearRarityTabs do
        local v143 = u33:Clone();
        v143.Name = "Rarity_" .. v;
        v143.LayoutOrder = i;
        v143.Visible = true;
        local u144 = v;

        for _, v2 in { "Active", "Inactive" } do
            local v145 = v143:FindFirstChild(v2);

            if v145 then
                v145 = v145:FindFirstChild("Text");
            end;

            if v145 then
                v145.Text = u144;
            end;
        end;

        TabStyles.setStateActive(v143, false);
        v143.MouseButton1Click:Connect(function() -- Line: 719
            -- upvalues: ToggleRaritySelection (ref), u144 (copy)
            ToggleRaritySelection(u144);
        end);
        v143.Parent = u31;
        u34[u144] = v143;
    end;
end;

local function PruneSellSelection() -- Line: 729
    -- upvalues: u18 (copy), FindEquipmentByGUID (copy), IsEquippedGUID (copy), EquipmentTemplates (copy), RemoveFromSell (copy)
    local v146 = {};

    for i in u18 do
        local v147 = FindEquipmentByGUID(i);

        if v147 then
            local v148;

            if type(v147) == "table" and v147.GUID and not (v147.Locked or IsEquippedGUID(v147.GUID)) then
                local Template = EquipmentTemplates.GetTemplate(v147.ItemId);

                if Template then
                    Template = Template.Unsellable;
                end;

                v148 = Template ~= true;
            else
                v148 = false;
            end;

            if not v148 then
                table.insert(v146, i);
            end;
        else
            table.insert(v146, i);
        end;
    end;

    for _, v in v146 do
        RemoveFromSell(v);
    end;
end;

local function GetSellTotal() -- Line: 742
    -- upvalues: u17 (copy), FindEquipmentByGUID (copy), EquipmentShopData (copy)
    local v149 = 0;

    for _, v in u17 do
        local v150 = FindEquipmentByGUID(v);

        if v150 then
            v149 = v149 + EquipmentShopData.GetSellPrice(v150.Rarity or "Common");
        end;
    end;

    return v149;
end;

local function HasAboveMythicSelected() -- Line: 754
    -- upvalues: u17 (copy), FindEquipmentByGUID (copy), RarityIndex (copy), u2 (copy)
    for _, v in u17 do
        local v151 = FindEquipmentByGUID(v);

        if v151 and u2 < (RarityIndex[v151.Rarity] or 1) then
            return true;
        end;
    end;

    return false;
end;

local function ClearSellRows() -- Line: 770
    -- upvalues: u3 (copy), u22 (copy), u20 (copy)
    for _, v in u3.SellRows do
        if v and v.Parent then
            local v152;

            if v then
                v152 = v:FindFirstChildWhichIsA("UIScale") or nil;
            else
                v152 = nil;
            end;

            if v152 then
                local v153 = u22[v152];

                if v153 then
                    v153:Cancel();
                end;

                u22[v152] = nil;
            end;

            v:Destroy();
        end;
    end;

    table.clear(u3.SellRows);

    for _, v in u20 do
        if v and v.Parent then
            local v154;

            if v then
                v154 = v:FindFirstChildWhichIsA("UIScale") or nil;
            else
                v154 = nil;
            end;

            if v154 then
                local v155 = u22[v154];

                if v155 then
                    v155:Cancel();
                end;

                u22[v154] = nil;
            end;

            v:Destroy();
        end;
    end;

    table.clear(u20);
end;

local function BuildSellRow(u156: string) -- Line: 800
    -- upvalues: u48 (ref), u47 (ref), FindEquipmentByGUID (copy), u21 (ref), EquipmentTemplates (copy), RarityColors (copy), Color3_new_ret (copy), Image_Data (copy), EquipmentShopData (copy), SharedUtils (copy), RemoveFromSell (copy)
    if not (u48 and u47) then
        return nil;
    end;

    local v157 = FindEquipmentByGUID(u156);

    if not v157 then
        return nil;
    end;

    local v158 = u48:Clone();
    v158.Name = "SellRow_" .. u156;
    v158.Visible = true;
    u21 = u21 + 1;
    v158.LayoutOrder = u21;
    local Frame = v158:FindFirstChild("Frame");

    if Frame then
        local ItemName = Frame:FindFirstChild("ItemName");

        if ItemName then
            local ItemId = v157.ItemId;
            local Template = EquipmentTemplates.GetTemplate(ItemId);
            local v159 = Template and Template.DisplayName or (ItemId or "???");
            local v160 = v157.ForgeLevel or 0;
            local v161 = v157.EnchantLevel or 0;

            if v160 > 0 then
                v159 = v159 .. " +" .. v160;
            elseif v161 > 0 then
                v159 = v159 .. " +" .. v161;
            end;

            ItemName.Text = v159;
            local v162 = RarityColors[v157.Rarity];
            ItemName.TextColor3 = v162 and v162.TextColor3 or Color3_new_ret;
        end;

        local ItemImage = Frame:FindFirstChild("ItemImage");

        if ItemImage then
            local ItemId = v157.ItemId;
            local v163 = Image_Data.Equipment and Image_Data.Equipment[ItemId];

            if not v163 or (v163 == "" or v163 == "rbxassetid://0") then
                local Template = EquipmentTemplates.GetTemplate(ItemId);
                v163 = Template and Template.ImageId or "";
            end;

            local v164 = v163 == "rbxassetid://0" and "" or v163;
            ItemImage.Image = v164;
            ItemImage.Visible = v164 ~= "";
        end;

        local SellValue = Frame:FindFirstChild("SellValue");

        if SellValue then
            local SellPrice = EquipmentShopData.GetSellPrice(v157.Rarity or "Common");
            SellValue.Text = SharedUtils.FormatNumber(SellPrice) .. "c";
            local v165 = RarityColors[v157.Rarity];
            SellValue.TextColor3 = v165 and v165.TextColor3 or Color3_new_ret;
        end;

        local SellAmount = Frame:FindFirstChild("SellAmount");

        if SellAmount then
            SellAmount.Text = "x1";
        end;
    end;

    local Remove = v158:FindFirstChild("Remove");

    if Remove then
        Remove.Visible = false;
        v158.MouseEnter:Connect(function() -- Line: 843
            -- upvalues: Remove (copy)
            Remove.Visible = true;
        end);
        v158.MouseLeave:Connect(function() -- Line: 846
            -- upvalues: Remove (copy)
            Remove.Visible = false;
        end);
    end;

    v158.MouseButton1Click:Connect(function() -- Line: 852
        -- upvalues: RemoveFromSell (ref), u156 (copy)
        RemoveFromSell(u156);
    end);
    local v166;

    if v158 then
        v166 = v158:FindFirstChildWhichIsA("UIScale") or nil;
    else
        v166 = nil;
    end;

    if v166 then
        v166.Scale = 0;
    end;

    v158.Parent = u47;

    return v158;
end;

u53 = function(p167: string) -- Line: 865, Name: AddSellRow
    -- upvalues: u20 (copy), u3 (copy), TweenScale (copy), TweenInfo_new_ret (copy), BuildSellRow (copy)
    local v168 = u20[p167];

    if v168 then
        u20[p167] = nil;

        if v168.Parent then
            u3.SellRows[p167] = v168;
            local v169 = v168 and v168:FindFirstChildWhichIsA("UIScale") or nil;

            if v169 then
                TweenScale(v169, 1, TweenInfo_new_ret);
            end;

            return;
        end;
    end;

    if u3.SellRows[p167] then
        return;
    end;

    local v170 = BuildSellRow(p167);

    if not v170 then
        return;
    end;

    u3.SellRows[p167] = v170;
    local v171 = v170 and v170:FindFirstChildWhichIsA("UIScale") or nil;

    if v171 then
        TweenScale(v171, 1, TweenInfo_new_ret);
    end;
end;

u54 = function(u172: string) -- Line: 890, Name: RemoveSellRow
    -- upvalues: u3 (copy), u20 (copy), TweenScale (copy), TweenInfo_new_ret2 (copy), u22 (copy)
    local u173 = u3.SellRows[u172];

    if not u173 then
        return;
    end;

    u3.SellRows[u172] = nil;
    local u174;

    if u173 then
        u174 = u173:FindFirstChildWhichIsA("UIScale") or nil;
    else
        u174 = nil;
    end;

    if not u174 then
        u173:Destroy();

        return;
    end;

    u20[u172] = u173;
    TweenScale(u174, 0, TweenInfo_new_ret2).Completed:Once(function() -- Line: 904
        -- upvalues: u20 (ref), u172 (copy), u173 (copy), u22 (ref), u174 (copy)
        if u20[u172] ~= u173 then
            return;
        end;

        u20[u172] = nil;
        u22[u174] = nil;

        if u173.Parent then
            u173:Destroy();
        end;
    end);
end;

local function RebuildSellRows() -- Line: 916
    -- upvalues: ClearSellRows (copy), u17 (copy), u53 (ref)
    ClearSellRows();

    for _, v in u17 do
        u53(v);
    end;
end;

u52 = function() -- Line: 924, Name: RefreshSellSummary
    -- upvalues: u17 (copy), u49 (ref), u50 (ref), GetSellTotal (copy), SharedUtils (copy), UpdateRarityTabStates (copy)
    local v175 = #u17;

    if u49 then
        u49.Text = "Items Selected: " .. v175;
    end;

    if u50 then
        local v176 = GetSellTotal();
        u50.Text = SharedUtils.FormatNumber(v176);
    end;

    UpdateRarityTabStates();
end;

function u3.OnSellClicked() -- Line: 939
    -- upvalues: u19 (ref), u6 (ref), u17 (copy), u7 (ref), GetSellTotal (copy), HasAboveMythicSelected (copy), u9 (ref), FormatCoins (copy), u8 (ref), u18 (copy), ClearSellRows (copy), u52 (ref), u24 (ref), u10 (ref), u55 (ref)
    if u19 or not u6 then
        return;
    end;

    local v177 = #u17;

    if v177 == 0 then
        if u7 then
            u7:Show("Custom", "No items selected!");
        end;

        return;
    end;

    local u178 = GetSellTotal();

    if HasAboveMythicSelected() and u9 then
        if not u9:Prompt({
            ConfirmText = "Sell",
            DenyText = "Cancel",
            Message = string.format("WARNING: your selection includes gear above Mythic rarity!\n\nSell %d item%s for %s coins?", v177, v177 > 1 and "s" or "", FormatCoins(u178))
        }) then
            return;
        end;

        if #u17 == 0 then
            return;
        end;
    end;

    u19 = true;
    local table_clone_ret = table.clone(u17);
    u6:SellEquipment(table_clone_ret):andThen(function(p179, p180, p181) -- Line: 973
        -- upvalues: u8 (ref), u7 (ref), table_clone_ret (copy), FormatCoins (ref), u178 (copy), u18 (ref), u17 (ref), ClearSellRows (ref), u52 (ref), u24 (ref), u10 (ref), u55 (ref)
        if not p179 then
            local v182 = {
                ITEM_EQUIPPED = "Cannot sell equipped items!",
                ITEM_LOCKED = "Cannot sell locked items!",
                ITEM_NOT_FOUND = "Item no longer in inventory.",
                TOO_FAST = "Too fast! Try again.",
                NO_ITEMS = "No items to sell.",
                UNSELLABLE = "Some items cannot be sold!",
                TOO_MANY = "Too many items selected! Try a smaller batch."
            };

            if u7 then
                u7:Show("Custom", v182[p181] or "Sell failed.");
            end;

            return;
        end;

        if u8 then
            u8:Play("UI_Sale");
        end;

        if u7 then
            u7:Show("Custom", string.format("Sold %d item%s for %s coins!", #table_clone_ret, #table_clone_ret > 1 and "s" or "", FormatCoins(p180 or u178)));
        end;

        table.clear(u18);
        table.clear(u17);
        ClearSellRows();
        u52();
        task.delay(0.1, function() -- Line: 989
            -- upvalues: u24 (ref), u10 (ref), u55 (ref)
            if u24.Visible and u10 == "Sell" then
                u55();
            end;
        end);
    end):catch(function(p183) -- Line: 1008
        warn("[ItemShop] SellEquipment failed:", p183);
    end):finally(function() -- Line: 1010
        -- upvalues: u19 (ref)
        u19 = false;
    end);
end;

u55 = function() -- Line: 1020, Name: BuildLeftList
    -- upvalues: ClearLeftList (copy), u29 (ref), u28 (ref), u23 (ref), u10 (ref), u11 (ref), PruneSellSelection (copy), u5 (ref), IsEquippedGUID (copy), EquipmentTemplates (copy), u1 (copy), RarityIndex (copy), PaintRow (copy), ShowBuyInfo (copy), u18 (copy), RemoveFromSell (copy), u17 (copy), u53 (ref), UpdateSellCovers (copy), u52 (ref), u3 (copy), RevealCascade (copy), u24 (ref), u12 (ref)
    ClearLeftList();

    if not (u29 and u28) then
        return;
    end;

    u23 = u23 + 1;
    local u184 = u23;
    local u185 = u10;
    local v186 = {};

    if u10 == "Buy" then
        for _, v in u11 do
            table.insert(v186, v);
        end;
    else
        PruneSellSelection();
        local EquipmentInventory = u5.Data.EquipmentInventory;

        if EquipmentInventory then
            for _, v in EquipmentInventory do
                local v187;

                if type(v) == "table" and v.GUID and not (v.Locked or IsEquippedGUID(v.GUID)) then
                    local Template = EquipmentTemplates.GetTemplate(v.ItemId);

                    if Template then
                        Template = Template.Unsellable;
                    end;

                    v187 = Template ~= true;
                else
                    v187 = false;
                end;

                if v187 then
                    table.insert(v186, v);
                end;
            end;
        end;
    end;

    table.sort(v186, function(p188, p189) -- Line: 291
        -- upvalues: u1 (ref), RarityIndex (ref), EquipmentTemplates (ref)
        local v190 = u1[p188.Slot] or 99;
        local v191 = u1[p189.Slot] or 99;

        if v190 ~= v191 then
            return v190 < v191;
        end;

        local v192 = RarityIndex[p188.Rarity] or 1;
        local v193 = RarityIndex[p189.Rarity] or 1;

        if v192 ~= v193 then
            return v192 < v193;
        end;

        local ItemId = p188.ItemId;
        local Template = EquipmentTemplates.GetTemplate(ItemId);
        local v194 = Template and Template.DisplayName or (ItemId or "???");
        local ItemId2 = p189.ItemId;
        local Template2 = EquipmentTemplates.GetTemplate(ItemId2);

        return v194 < (Template2 and Template2.DisplayName or (ItemId2 or "???"));
    end);
    local v195 = {};

    for i, v in v186 do
        local v196 = u29:Clone();
        PaintRow(v196, v, i);
        local Selection_Button = v196:FindFirstChild("Selection_Button");

        if Selection_Button then
            local GUID = v.GUID;

            if u185 == "Buy" then
                Selection_Button.MouseButton1Click:Connect(function() -- Line: 1057
                    -- upvalues: ShowBuyInfo (ref), v (copy)
                    ShowBuyInfo(v);
                end);
            else
                Selection_Button.MouseButton1Click:Connect(function() -- Line: 1062
                    -- upvalues: GUID (copy), u18 (ref), RemoveFromSell (ref), u17 (ref), u53 (ref), UpdateSellCovers (ref), u52 (ref)
                    local v197 = GUID;

                    if u18[v197] then
                        RemoveFromSell(v197);

                        return;
                    end;

                    if u18[v197] then
                        return;
                    end;

                    u18[v197] = true;
                    table.insert(u17, v197);
                    u53(v197);
                    UpdateSellCovers();
                    u52();
                end);
            end;
        end;

        v196.Parent = u28;
        u3.Rows[v.GUID] = v196;
        table.insert(v195, v196);
    end;

    if u10 == "Sell" then
        UpdateSellCovers();
    end;

    RevealCascade.play(v195, {
        isCurrent = function() -- Line: 1078, Name: isCurrent
            -- upvalues: u24 (ref), u23 (ref), u184 (copy), u10 (ref), u185 (copy)
            local Visible = u24.Visible;

            if Visible then
                if u23 == u184 then
                    Visible = u10 == u185;
                else
                    Visible = false;
                end;
            end;

            return Visible;
        end
    });

    if u10 == "Buy" then
        if #v186 > 0 then
            local v198;

            if u12 == nil then
                v198 = false;
            else
                v198 = u3.Rows[u12] ~= nil;
            end;

            if v198 then
                for _, v in v186 do
                    if v.GUID == u12 then
                        ShowBuyInfo(v);

                        return;
                    end;
                end;

                return;
            end;

            ShowBuyInfo(v186[1]);

            return;
        end;

        u12 = nil;
    end;
end;

local function SetTabActive(p199: any, p200: boolean) -- Line: 1109
    -- upvalues: TabStyles (copy)
    TabStyles.setGradientTabActive(p199, p200);
end;

local function SwitchTab(p201: string) -- Line: 1113
    -- upvalues: u10 (ref), u25 (ref), TabStyles (copy), u26 (ref), u35 (ref), u46 (ref), u27 (ref), u31 (ref), u18 (copy), u17 (copy), ClearSellRows (copy), RebuildSellRows (ref), u52 (ref), u55 (ref)
    if u10 == p201 then
        return;
    end;

    u10 = p201;
    TabStyles.setGradientTabActive(u25, p201 == "Buy");
    TabStyles.setGradientTabActive(u26, p201 == "Sell");

    if u35 then
        u35.Visible = p201 == "Buy";
    end;

    if u46 then
        u46.Visible = p201 == "Sell";
    end;

    if u27 then
        u27.Visible = p201 == "Buy";
    end;

    if u31 then
        u31.Visible = p201 == "Sell";
    end;

    if p201 == "Buy" then
        table.clear(u18);
        table.clear(u17);
        ClearSellRows();
    else
        RebuildSellRows();
    end;

    u52();
    u55();
end;

function u3.SetMode(p202: string) -- Line: 1147
    -- upvalues: SwitchTab (copy)
    if p202 ~= "Buy" and p202 ~= "Sell" then
        return;
    end;

    SwitchTab(p202);
end;

function u3.GetMode() -- Line: 1154
    -- upvalues: u10 (ref)
    return u10;
end;

local function UpdateTimerDisplay() -- Line: 1162
    -- upvalues: u27 (ref), u14 (ref), u13 (ref)
    if not u27 then
        return;
    end;

    if not u14 then
        u27.Text = "Loading...";

        return;
    end;

    if u13 <= 0 then
        u27.Text = "Stock is fresh!";

        return;
    end;

    local v203 = u13;
    local math_floor_ret = math.floor(v203 / 3600);
    local math_floor_ret2 = math.floor(v203 % 3600 / 60);
    u27.Text = string.format("RESTOCK IN: %02d:%02d:%02d", math_floor_ret, math_floor_ret2, v203 % 60);
end;

local function LoadShop() -- Line: 1174
    -- upvalues: u6 (ref), u11 (ref), u13 (ref), u14 (ref), UpdateTimerDisplay (ref), u10 (ref), u55 (ref)
    if not u6 then
        return;
    end;

    u6:GetEquipmentShopInfo():andThen(function(p204, p205) -- Line: 1177
        -- upvalues: u11 (ref), u13 (ref), u14 (ref), UpdateTimerDisplay (ref), u10 (ref), u55 (ref)
        u11 = p204 or {};
        u13 = p205 or 0;
        u14 = true;
        UpdateTimerDisplay();

        if u10 == "Buy" then
            u55();
        end;
    end):catch(function(p206) -- Line: 1185
        warn("[ItemShop] GetEquipmentShopInfo failed:", p206);
    end);
end;

local function StartTimerCountdown() -- Line: 1190
    -- upvalues: u15 (ref), u13 (ref), UpdateTimerDisplay (ref), LoadShop (ref)
    if u15 then
        pcall(task.cancel, u15);
    end;

    u15 = task.spawn(function() -- Line: 1195
        -- upvalues: u13 (ref), UpdateTimerDisplay (ref), LoadShop (ref)
        while true do
            repeat
                task.wait(1);
            until u13 > 0;

            u13 = u13 - 1;
            UpdateTimerDisplay();

            if u13 <= 0 then
                LoadShop();
            end;
        end;
    end);
end;

function u3._Init(p207) -- Line: 1213
    -- upvalues: u4 (ref), u5 (ref), Registry (copy), u6 (ref), Knit (copy), u7 (ref), u8 (ref), u9 (ref), u24 (ref), u25 (ref), u26 (ref), u27 (ref), u28 (ref), u29 (ref), u30 (ref), u31 (ref), u32 (ref), u33 (ref), BuildRarityTabs (copy), TabStyles (copy), ToggleRaritySelection (copy), u35 (ref), u36 (ref), u44 (ref), u37 (ref), u38 (ref), u39 (ref), u43 (ref), u41 (ref), u40 (ref), u42 (ref), u45 (ref), u3 (copy), u46 (ref), u49 (ref), u50 (ref), u47 (ref), u48 (ref), u51 (ref), SwitchTab (copy), u10 (ref), RebuildSellRows (ref), u52 (ref), u55 (ref), u12 (ref), u11 (ref), ShowBuyInfo (copy), LoadShop (ref), PruneSellSelection (copy), u18 (copy), u17 (copy), ClearSellRows (copy), u15 (ref), u13 (ref), UpdateTimerDisplay (ref)
    u4 = p207;
    u5 = Registry:Get("PlayerData");
    u6 = Knit.GetService("ShopService");
    pcall(function() -- Line: 1218
        -- upvalues: u7 (ref), Knit (ref)
        u7 = Knit.GetController("NotificationController");
    end);
    pcall(function() -- Line: 1219
        -- upvalues: u8 (ref), Knit (ref)
        u8 = Knit.GetController("SoundController");
    end);
    pcall(function() -- Line: 1220
        -- upvalues: u9 (ref), Knit (ref)
        u9 = Knit.GetController("WarningController");
    end);
    u24 = u4.Frames.ItemShop;
    u25 = u24:WaitForChild("Buy");
    u26 = u24:WaitForChild("Sell");
    u27 = u24:FindFirstChild("Restock_Time");
    local Contents = u24:WaitForChild("Contents");
    local LeftSection = Contents:WaitForChild("LeftSection");
    local RightSection = Contents:WaitForChild("RightSection");
    u28 = LeftSection:WaitForChild("Selection");
    u29 = u28:WaitForChild("TemplateFrame");
    u29.Visible = false;
    u30 = LeftSection:FindFirstChild("Tabs");

    if u30 then
        u30.Visible = false;
    end;

    u31 = LeftSection:FindFirstChild("RarityTabs");

    if u31 then
        u32 = u31:FindFirstChild("All");
        u33 = u31:FindFirstChild("Template");

        if u33 then
            u33.Visible = false;
        end;

        BuildRarityTabs();

        if u32 then
            TabStyles.setStateActive(u32, false);
            u32.MouseButton1Click:Connect(function() -- Line: 1252
                -- upvalues: ToggleRaritySelection (ref)
                ToggleRaritySelection(nil);
            end);
        end;

        u31.Visible = false;
    end;

    u35 = RightSection:WaitForChild("ItemInfo");
    u36 = u35:FindFirstChild("ItemName");
    u44 = u35:FindFirstChild("CoinCost");
    local Info = u35:FindFirstChild("Info");

    if Info then
        local Rarity = Info:FindFirstChild("Rarity");

        if Rarity then
            Rarity = Rarity:FindFirstChild("Info");
        end;

        u37 = Rarity;
        u38 = Info:FindFirstChild("Description");
        local v208 = u38 and u38:FindFirstChild("Info");
        u39 = v208;
        u43 = Info:FindFirstChild("ItemImage");
        u41 = Info:FindFirstChild("StatsTitle");
        u40 = Info:FindFirstChild("Stats");
        u42 = u40 and u40:FindFirstChild("Template");

        if u42 then
            u42.Visible = false;
        end;
    else
        warn("[ItemShop] ItemInfo.Info not found");
    end;

    local Button = u35:FindFirstChild("Button");

    if Button then
        Button = Button:FindFirstChild("Buy");
    end;

    u45 = Button;

    if u45 then
        u45.MouseButton1Click:Connect(function() -- Line: 1290
            -- upvalues: u3 (ref)
            u3.OnBuyClicked();
        end);
    else
        warn("[ItemShop] ItemInfo.Button.Buy not found");
    end;

    u46 = RightSection:WaitForChild("SellInfo");
    u49 = u46:FindFirstChild("ItemsSelected");
    u50 = u46:FindFirstChild("CoinCost");
    u47 = u46:WaitForChild("Selection");
    u48 = u47:WaitForChild("Template");
    u48.Visible = false;
    local Button2 = u46:FindFirstChild("Button");

    if Button2 then
        Button2 = Button2:FindFirstChild("Sell");
    end;

    u51 = Button2;

    if u51 then
        u51.MouseButton1Click:Connect(function() -- Line: 1310
            -- upvalues: u3 (ref)
            u3.OnSellClicked();
        end);
    else
        warn("[ItemShop] SellInfo.Button.Sell not found");
    end;

    u25.MouseButton1Click:Connect(function() -- Line: 1318
        -- upvalues: SwitchTab (ref)
        SwitchTab("Buy");
    end);
    u26.MouseButton1Click:Connect(function() -- Line: 1319
        -- upvalues: u10 (ref), u25 (ref), TabStyles (ref), u26 (ref), u35 (ref), u46 (ref), u27 (ref), u31 (ref), RebuildSellRows (ref), u52 (ref), u55 (ref)
        if u10 == "Sell" then
            return;
        end;

        u10 = "Sell";
        TabStyles.setGradientTabActive(u25, false);
        TabStyles.setGradientTabActive(u26, true);

        if u35 then
            u35.Visible = false;
        end;

        if u46 then
            u46.Visible = true;
        end;

        if u27 then
            u27.Visible = false;
        end;

        if u31 then
            u31.Visible = true;
        end;

        RebuildSellRows();
        u52();
        u55();
    end);
    u10 = "Buy";
    TabStyles.setGradientTabActive(u25, true);
    TabStyles.setGradientTabActive(u26, false);
    u35.Visible = true;
    u46.Visible = false;

    if u27 then
        u27.Visible = true;
    end;

    u52();
    u5:OnChange(function(p209, p210) -- Line: 1331
        -- upvalues: u10 (ref), u12 (ref), u11 (ref), ShowBuyInfo (ref), LoadShop (ref), u24 (ref), PruneSellSelection (ref), u55 (ref), u52 (ref)
        local v211 = p210[1];

        if v211 == "Currency" then
            if u10 == "Buy" and u12 then
                for _, v in u11 do
                    if v.GUID == u12 then
                        ShowBuyInfo(v);

                        return;
                    end;
                end;
            end;
        else
            if v211 == "EquipmentShopStock" then
                LoadShop();

                return;
            end;

            if v211 == "EquipmentInventory" or v211 == "Equipment" then
                if not u24.Visible then
                    return;
                end;

                if u10 == "Sell" then
                    PruneSellSelection();
                    u55();
                    u52();

                    return;
                end;

                if v211 == "Equipment" and u12 then
                    for _, v in u11 do
                        if v.GUID == u12 then
                            ShowBuyInfo(v);

                            return;
                        end;
                    end;
                end;
            end;
        end;
    end);
    u24:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 1373
        -- upvalues: u24 (ref), LoadShop (ref), u55 (ref), u18 (ref), u17 (ref), ClearSellRows (ref), u52 (ref)
        if u24.Visible then
            LoadShop();
            u55();

            return;
        end;

        table.clear(u18);
        table.clear(u17);
        ClearSellRows();
        u52();
    end);

    if u15 then
        pcall(task.cancel, u15);
    end;

    u15 = task.spawn(function() -- Line: 1195
        -- upvalues: u13 (ref), UpdateTimerDisplay (ref), LoadShop (ref)
        while true do
            repeat
                task.wait(1);
            until u13 > 0;

            u13 = u13 - 1;
            UpdateTimerDisplay();

            if u13 <= 0 then
                LoadShop();
            end;
        end;
    end);
    LoadShop();
end;

return u3;