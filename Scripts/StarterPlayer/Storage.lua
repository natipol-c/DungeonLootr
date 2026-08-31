--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Storage
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.Storage
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:12 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GameInfo = ReplicatedStorage:WaitForChild("GameInfo");
local RarityData = require(GameInfo:WaitForChild("RarityData"));
local BankData = require(GameInfo:WaitForChild("BankData"));
local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local Knit = require(ReplicatedStorage.Packages.Knit);
local RarityGradient = require(ReplicatedStorage.Modules.RarityGradient);
local RevealCascade = require(script.Parent.Parent.ClientUtils.RevealCascade);
local EquipmentStatLines = require(script.Parent.Parent.ClientUtils.EquipmentStatLines);
local TabStyles = require(script.Parent.Parent.ClientUtils.TabStyles);
local InventoryItems = require(script.Parent.InventoryItems);
local Color3_new_ret = Color3.new(1, 1, 1);
local CountSourceSet = BankData.CountSourceSet;
local u1 = { "All", "Equipment", "Items", "Materials" };
local u2 = {
    EquipmentInventory = true,
    Equipment = true,
    BankEquipment = true,
    BankCounts = true,
    CraftingMaterials = true,
    Consumables = true,
    Potions = true,
    BuffPotions = true
};
local u3 = {
    BankFull = "The bank is full!",
    InventoryFull = "Your inventory is full!",
    StackFull = "Your held stack is already full!",
    NoneToMove = "Nothing to move!",
    NoItems = "Nothing to move!",
    Unbankable = "That item can\'t be stored!",
    ItemNotFound = "Item not found.",
    ItemEquipped = "Unequip that item first!",
    TooFast = "Too fast! Try again.",
    TooMany = "Too many items selected!",
    NoData = "Data not loaded yet.",
    InvalidAmount = "Invalid amount.",
    InvalidSource = "Invalid request.",
    InvalidItem = "Invalid request.",
    InvalidInput = "Invalid request."
};
local u4 = {};
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = "Store";
local u10 = "All";
local u11 = nil;
local u12 = nil;
local u13 = false;
local u14 = false;
local u15 = 0;
local u16 = {};
local u17 = {};
u4.Rows = {};
local u18 = {};
local u19 = {};

local function Notify(p20: string) -- Line: 147
    -- upvalues: u8 (ref)
    if u8 then
        u8:Show("Custom", p20);
    end;
end;

local function RarityColorOf(p21: string?) -- Line: 153
    -- upvalues: RarityColors (copy), Color3_new_ret (copy)
    local v22 = p21 and RarityColors[p21] or nil;

    return v22 and v22.TextColor3 or Color3_new_ret;
end;

local function NameWithForge(p23) -- Line: 159
    local v24 = p23.DisplayName or "???";
    local v25 = p23.ForgeLevel or 0;
    local v26 = p23.EnchantLevel or 0;

    if v25 > 0 then
        return v24 .. " +" .. v25;
    end;

    if v26 > 0 then
        v24 = v24 .. " +" .. v26;
    end;

    return v24;
end;

local function EntryKey(p27) -- Line: 173
    if p27.IsEquipment then
        return p27.GUID;
    end;

    return (p27.SourceField or "?") .. "/" .. (p27.SourceId or (p27.ItemId or "?"));
end;

local function MatchesFilters(p28) -- Line: 180
    -- upvalues: u11 (ref), u10 (ref)
    if u11 and p28.Rarity ~= u11 then
        return false;
    end;

    if u10 == "Equipment" then
        return p28.IsEquipment == true;
    end;

    if u10 == "Materials" then
        return p28.Category == "Material";
    end;

    if u10 ~= "Items" then
        return true;
    end;

    return not p28.IsEquipment and p28.Category ~= "Material";
end;

local function BuildEntries() -- Line: 200
    -- upvalues: u9 (ref), InventoryItems (copy), u6 (ref), CountSourceSet (copy), BankData (copy)
    local v29 = {};

    if u9 == "Store" then
        for _, v in InventoryItems.Build(u6) do
            local v30 = v.IsEquipment or v.SourceField and CountSourceSet[v.SourceField] and not BankData.IsUnbankable(v.SourceField, v.SourceId);

            if v30 then
                table.insert(v29, v);
            end;
        end;

        return v29;
    end;

    local Data = u6.Data;
    local BankEquipment = Data.BankEquipment;

    if BankEquipment then
        for _, v in BankEquipment do
            local v31 = InventoryItems.NormalizeEquipment(v);

            if v31 then
                table.insert(v29, v31);
            end;
        end;
    end;

    local BankCounts = Data.BankCounts;

    if BankCounts then
        for i in CountSourceSet do
            local v32 = BankCounts[i];
            local v33 = InventoryItems.CountNormalizers[i];

            if v32 and v33 then
                for i2, v in v32 do
                    local v34 = v33(i2, v);

                    if v34 then
                        table.insert(v29, v34);
                    end;
                end;
            end;
        end;
    end;

    return v29;
end;

local function SetRowSelected(p35: string?, p36: boolean) -- Line: 252
    -- upvalues: u4 (copy), u17 (copy), Color3_new_ret (copy), RarityColors (copy)
    local v37;

    if p35 then
        v37 = u4.Rows[p35] or nil;
    else
        v37 = nil;
    end;

    if not v37 then
        return;
    end;

    local v38 = p35 and u17[p35] or nil;
    local Background = v37:FindFirstChild("Background");

    if Background then
        Background = Background:FindFirstChildWhichIsA("UIStroke");
    end;

    if Background then
        local v39;

        if p36 then
            v39 = Color3_new_ret;
        else
            if v38 then
                v38 = v38.Rarity;
            end;

            local v40 = v38 and RarityColors[v38] or nil;
            v39 = v40 and v40.TextColor3 or Color3_new_ret;
        end;

        Background.Color = v39;
    end;
end;

local function PaintRow(p41: any, p42: any, p43: number) -- Line: 264
    -- upvalues: RarityColors (copy), Color3_new_ret (copy), RarityGradient (copy)
    local v44;

    if p42.IsEquipment then
        v44 = p42.GUID;
    else
        v44 = (p42.SourceField or "?") .. "/" .. (p42.SourceId or (p42.ItemId or "?"));
    end;

    p41.Name = "Row_" .. v44;
    p41.LayoutOrder = p43;
    local Rarity = p42.Rarity;
    local v45 = Rarity and RarityColors[Rarity] or nil;
    local v46 = v45 and v45.TextColor3 or Color3_new_ret;
    local Item_Name = p41:FindFirstChild("Item_Name");

    if Item_Name then
        local v47 = p42.DisplayName or "???";
        local v48 = p42.ForgeLevel or 0;
        local v49 = p42.EnchantLevel or 0;

        if v48 > 0 then
            v47 = v47 .. " +" .. v48;
        elseif v49 > 0 then
            v47 = v47 .. " +" .. v49;
        end;

        Item_Name.Text = v47;
        Item_Name.TextColor3 = v46;
        Item_Name.Visible = true;
    end;

    local Item_Level = p41:FindFirstChild("Item_Level");

    if Item_Level then
        Item_Level.Text = "lvl. " .. (p42.LevelReq or 1);
        Item_Level.Visible = p42.IsEquipment == true;
    end;

    local Amount = p41:FindFirstChild("Amount");

    if Amount then
        Amount.Text = "x" .. (p42.OwnedCount or 0);
        Amount.Visible = p42.IsEquipment ~= true;
    end;

    local Forge_Level = p41:FindFirstChild("Forge_Level");

    if Forge_Level then
        local v50 = p42.ForgeLevel or 0;
        Forge_Level.Text = "+" .. v50;
        Forge_Level.Visible = v50 > 0;
    end;

    local Lock_Image = p41:FindFirstChild("Lock_Image");

    if Lock_Image then
        Lock_Image.Visible = p42.Locked == true;
    end;

    local ItemImage = p41:FindFirstChild("ItemImage");

    if ItemImage then
        local v51 = p42.Icon or "";
        ItemImage.Image = v51;
        ItemImage.Visible = v51 ~= "";
    end;

    for _, v in { "ViewportFrame", "Equipped", "Delete_Cover", "Item_Tier" } do
        local v52 = p41:FindFirstChild(v);

        if v52 then
            v52.Visible = false;
        end;
    end;

    local Background = p41:FindFirstChild("Background");

    if Background then
        Background = Background:FindFirstChildWhichIsA("UIStroke");
    end;

    if Background then
        Background.Color = v46;
    end;

    RarityGradient.apply(p41, p42.Rarity);
    p41.Visible = true;
end;

local function ShowInfo(p53) -- Line: 329
    -- upvalues: RarityColors (copy), Color3_new_ret (copy), u19 (copy), u6 (ref), EquipmentStatLines (copy)
    local Rarity = p53.Rarity;
    local v54 = Rarity and RarityColors[Rarity] or nil;
    local v55 = v54 and v54.TextColor3 or Color3_new_ret;

    if u19.itemInfoName then
        local v56 = p53.DisplayName or "???";
        local v57 = p53.ForgeLevel or 0;
        local v58 = p53.EnchantLevel or 0;

        if v57 > 0 then
            v56 = v56 .. " +" .. v57;
        elseif v58 > 0 then
            v56 = v56 .. " +" .. v58;
        end;

        u19.itemInfoName.Text = v56;
        u19.itemInfoName.TextColor3 = v55;
    end;

    if u19.itemInfoRarity then
        u19.itemInfoRarity.Text = p53.Rarity or "Common";
        u19.itemInfoRarity.TextColor3 = v55;
    end;

    if u19.itemInfoImage then
        local v59 = p53.Icon or "";
        u19.itemInfoImage.Image = v59;
        u19.itemInfoImage.Visible = v59 ~= "";
    end;

    if p53.IsEquipment then
        if u19.itemInfoDescFrame then
            u19.itemInfoDescFrame.Visible = false;
        end;

        if u19.itemInfoStatsTitle then
            u19.itemInfoStatsTitle.Visible = true;
        end;

        if u19.itemInfoStats then
            u19.itemInfoStats.Visible = true;
        end;

        if u19.itemInfoStats and u19.itemInfoStatTemplate then
            local v60;

            if p53.Slot and u6.Data.Equipment then
                v60 = u6.Data.Equipment[p53.Slot] or nil;
            else
                v60 = nil;
            end;

            if type(v60) ~= "table" then
                v60 = nil;
            end;

            EquipmentStatLines.render(u19.itemInfoStats, u19.itemInfoStatTemplate, {
                Slot = p53.Slot,
                BaseDamage = p53.BaseDamage,
                GuaranteedStat = p53.GuaranteedStat,
                ForgeBonuses = p53.ForgeBonuses,
                StatLines = p53.StatLines
            }, v60);
        end;
    else
        if u19.itemInfoStatsTitle then
            u19.itemInfoStatsTitle.Visible = false;
        end;

        if u19.itemInfoStats then
            u19.itemInfoStats.Visible = false;
        end;

        if u19.itemInfoDescFrame then
            u19.itemInfoDescFrame.Visible = true;
        end;

        if u19.itemInfoDesc then
            u19.itemInfoDesc.Text = p53.Description or "";
        end;
    end;
end;

local function ClearInfo() -- Line: 376
    -- upvalues: u19 (copy), Color3_new_ret (copy)
    if u19.itemInfoName then
        u19.itemInfoName.Text = "";
        u19.itemInfoName.TextColor3 = Color3_new_ret;
    end;

    if u19.itemInfoRarity then
        u19.itemInfoRarity.Text = "";
    end;

    if u19.itemInfoImage then
        u19.itemInfoImage.Visible = false;
    end;

    if u19.itemInfoStatsTitle then
        u19.itemInfoStatsTitle.Visible = false;
    end;

    if u19.itemInfoStats then
        u19.itemInfoStats.Visible = false;
    end;

    if u19.itemInfoDescFrame then
        u19.itemInfoDescFrame.Visible = false;
    end;
end;

local function UpdateActionButtons() -- Line: 389
    -- upvalues: u19 (copy), u9 (ref), u12 (ref), u17 (copy), u16 (ref)
    if not u19.actionButtons then
        return;
    end;

    local v61 = u9 == "Store" and "STORE" or "WITHDRAW";
    local v62 = u12 and u17[u12] or nil;
    local v63 = 0;

    if v62 then
        if v62.IsEquipment then
            for _, v in u16 do
                if v.IsEquipment then
                    v63 = v63 + 1;
                end;
            end;
        else
            v63 = v62.OwnedCount or 0;
        end;
    end;

    local v64 = {
        Action_1 = math.min(1, v63),
        Action_10 = math.min(10, v63),
        Action_All = v63
    };

    for i, v in u19.actionButtons do
        local TextLabel = v:FindFirstChild("TextLabel");

        if TextLabel then
            TextLabel.Text = v61;
        end;

        local Amount = v:FindFirstChild("Amount");

        if Amount then
            Amount.Text = "x" .. v64[i];
        end;
    end;
end;

local function RefreshCapacity() -- Line: 423
    -- upvalues: u19 (copy), u6 (ref)
    if not u19.capacityLabel then
        return;
    end;

    local Data = u6.Data;
    u19.capacityLabel.Text = string.format("Storage Limit: %d/%d", Data.BankEquipment and (#Data.BankEquipment or 0) or 0, Data.MaxBankSlots or 50);
end;

local function SelectEntry(p65: string) -- Line: 435
    -- upvalues: u12 (ref), SetRowSelected (copy), u17 (copy), ShowInfo (ref), UpdateActionButtons (ref)
    if u12 == p65 then
        return;
    end;

    SetRowSelected(u12, false);
    u12 = p65;
    SetRowSelected(p65, true);
    local v66 = u17[p65];

    if v66 then
        ShowInfo(v66);
    end;

    UpdateActionButtons();
end;

local function BuildLeftList() -- Line: 447
    -- upvalues: u4 (copy), u17 (copy), u19 (copy), u15 (ref), BuildEntries (copy), u11 (ref), u10 (ref), u16 (ref), PaintRow (copy), SelectEntry (ref), RevealCascade (copy), u12 (ref), SetRowSelected (copy), ShowInfo (ref), ClearInfo (ref), RefreshCapacity (ref), UpdateActionButtons (ref)
    for _, v in u4.Rows do
        if v and v.Parent then
            v:Destroy();
        end;
    end;

    table.clear(u4.Rows);
    table.clear(u17);

    if not (u19.rowTemplate and u19.leftSelection) then
        return;
    end;

    u15 = u15 + 1;
    local u67 = u15;
    local v68 = {};

    for _, v in BuildEntries() do
        local v69;

        if u11 and v.Rarity ~= u11 then
            v69 = false;
        elseif u10 == "Equipment" then
            v69 = v.IsEquipment == true;
        elseif u10 == "Materials" then
            v69 = v.Category == "Material";
        elseif u10 == "Items" then
            v69 = not v.IsEquipment and v.Category ~= "Material";
        else
            v69 = true;
        end;

        if v69 then
            table.insert(v68, v);
        end;
    end;

    table.sort(v68, function(p70, p71) -- Line: 465
        if p70.LayoutOrder == p71.LayoutOrder then
            return (p70.DisplayName or "") < (p71.DisplayName or "");
        end;

        return p70.LayoutOrder < p71.LayoutOrder;
    end);
    u16 = v68;
    local v72 = {};

    for i, v in v68 do
        local v73 = u19.rowTemplate:Clone();
        PaintRow(v73, v, i);
        local u74;

        if v.IsEquipment then
            u74 = v.GUID;
        else
            u74 = (v.SourceField or "?") .. "/" .. (v.SourceId or (v.ItemId or "?"));
        end;

        local Selection_Button = v73:FindFirstChild("Selection_Button");

        if Selection_Button then
            Selection_Button.MouseButton1Click:Connect(function() -- Line: 481
                -- upvalues: SelectEntry (ref), u74 (copy)
                SelectEntry(u74);
            end);
        end;

        v73.Parent = u19.leftSelection;
        u4.Rows[u74] = v73;
        u17[u74] = v;
        table.insert(v72, v73);
    end;

    RevealCascade.play(v72, {
        isCurrent = function() -- Line: 493, Name: isCurrent
            -- upvalues: u19 (ref), u15 (ref), u67 (copy)
            return u19.frame.Visible and u15 == u67;
        end
    });

    if not (u12 and u17[u12]) then
        local v75;

        if v68[1] then
            local v76 = v68[1];
            local v77;

            if v76.IsEquipment then
                v77 = v76.GUID;
            else
                v77 = (v76.SourceField or "?") .. "/" .. (v76.SourceId or (v76.ItemId or "?"));
            end;

            v75 = v77 or nil;
        else
            v75 = nil;
        end;

        u12 = v75;
    end;

    if u12 and u17[u12] then
        SetRowSelected(u12, true);
        ShowInfo(u17[u12]);
    else
        ClearInfo();
    end;

    RefreshCapacity();
    UpdateActionButtons();
end;

local function QueueRebuild() -- Line: 516
    -- upvalues: u14 (ref), u19 (copy), BuildLeftList (ref)
    if u14 then
        return;
    end;

    u14 = true;
    task.defer(function() -- Line: 519
        -- upvalues: u14 (ref), u19 (ref), BuildLeftList (ref)
        u14 = false;

        if u19.frame and u19.frame.Visible then
            BuildLeftList();
        end;
    end);
end;

local function SwitchMode(p78: string) -- Line: 531
    -- upvalues: u9 (ref), TabStyles (copy), u19 (copy), u12 (ref), BuildLeftList (ref)
    if u9 == p78 then
        return;
    end;

    u9 = p78;
    TabStyles.setGradientTabActive(u19.storeButton, u9 == "Store");
    TabStyles.setGradientTabActive(u19.withdrawButton, u9 == "Withdraw");
    u12 = nil;
    BuildLeftList();
end;

local function SetCategory(p79: string) -- Line: 540
    -- upvalues: u10 (ref), u19 (copy), u1 (copy), TabStyles (copy), BuildLeftList (ref)
    if u10 == p79 then
        return;
    end;

    u10 = p79;

    if u19.tabsFrame then
        for _, v in u1 do
            TabStyles.setStateActive(u19.tabsFrame:FindFirstChild(v), v == u10);
        end;
    end;

    BuildLeftList();
end;

local function SetRarityFilter(p80: string?) -- Line: 552
    -- upvalues: u11 (ref), TabStyles (copy), u19 (copy), u18 (copy), BuildLeftList (ref)
    if p80 ~= nil and u11 == p80 then
        p80 = nil;
    end;

    u11 = p80;
    TabStyles.setStateActive(u19.allRarityButton, u11 == nil);

    for i, v in u18 do
        TabStyles.setStateActive(v, u11 == i);
    end;

    BuildLeftList();
end;

local function BuildRarityTabs() -- Line: 566
    -- upvalues: u19 (copy), RarityData (copy), TabStyles (copy), SetRarityFilter (ref), u18 (copy)
    if not (u19.rarityTabTemplate and u19.rarityTabsFrame) then
        return;
    end;

    for i, v in RarityData.GearRarityTabs do
        local v81 = u19.rarityTabTemplate:Clone();
        v81.Name = "Rarity_" .. v;
        v81.LayoutOrder = i;
        v81.Visible = true;
        local u82 = v;

        for _, v2 in { "Active", "Inactive" } do
            local v83 = v81:FindFirstChild(v2);

            if v83 then
                v83 = v83:FindFirstChild("Text");
            end;

            if v83 then
                v83.Text = u82;
            end;
        end;

        TabStyles.setStateActive(v81, false);
        v81.MouseButton1Click:Connect(function() -- Line: 581
            -- upvalues: SetRarityFilter (ref), u82 (copy)
            SetRarityFilter(u82);
        end);
        v81.Parent = u19.rarityTabsFrame;
        u18[u82] = v81;
    end;
end;

local function OnActionClicked(p84: number) -- Line: 595
    -- upvalues: u13 (ref), u7 (ref), u12 (ref), u17 (copy), u8 (ref), u9 (ref), u16 (ref), u3 (copy)
    if u13 or not u7 then
        return;
    end;

    local v85 = u12 and u17[u12] or nil;

    if not v85 then
        if u8 then
            u8:Show("Custom", "Select an item first!");
        end;

        return;
    end;

    local u86 = u9 == "Store";
    local u87 = false;
    local v88;

    if v85.IsEquipment then
        if p84 == 1 then
            u87 = true;

            if u86 then
                v88 = u7:DepositEquipment(v85.GUID);
            else
                v88 = u7:WithdrawEquipment(v85.GUID);
            end;
        else
            local v89 = p84 == 0 and (1 / 0) or p84;
            local v90 = {};

            for _, v in u16 do
                if v.IsEquipment then
                    table.insert(v90, v.GUID);

                    if v89 <= #v90 then
                        break;
                    end;
                end;
            end;

            if #v90 == 0 then
                if u8 then
                    u8:Show("Custom", "Nothing to move!");
                end;

                return;
            end;

            if u86 then
                v88 = u7:DepositEquipmentBatch(v90);
            else
                v88 = u7:WithdrawEquipmentBatch(v90);
            end;
        end;
    elseif u86 then
        v88 = u7:DepositCount(v85.SourceField, v85.SourceId, p84);
    else
        v88 = u7:WithdrawCount(v85.SourceField, v85.SourceId, p84);
    end;

    u13 = true;
    v88:andThen(function(p91, p92, p93) -- Line: 640
        -- upvalues: u87 (ref), u86 (copy), u8 (ref), u3 (ref)
        local v94;

        if u87 then
            v94 = p91 and 1 or 0;
        else
            p92 = p93;
            v94 = p92 or 0;
        end;

        if p91 and v94 > 0 then
            local string_format_ret = string.format("%s %d item%s!%s", u86 and "Stored" or "Withdrew", v94, v94 == 1 and "" or "s", p92 == "BankFull" and " (bank full)" or (p92 == "InventoryFull" and " (inventory full)" or ""));

            if u8 then
                u8:Show("Custom", string_format_ret);
            end;
        else
            local v95 = u3[p92] or "Transfer failed.";

            if u8 then
                u8:Show("Custom", v95);
            end;
        end;
    end):catch(function(p96) -- Line: 664
        warn("[Storage] Transfer failed:", p96);
    end):finally(function() -- Line: 666
        -- upvalues: u13 (ref)
        u13 = false;
    end);
end;

function u4._Init(p97) -- Line: 675
    -- upvalues: u5 (ref), u6 (ref), Registry (copy), u7 (ref), Knit (copy), u8 (ref), u19 (copy), u1 (copy), TabStyles (copy), u10 (ref), SetCategory (ref), BuildRarityTabs (ref), SetRarityFilter (ref), OnActionClicked (ref), SwitchMode (ref), u2 (copy), QueueRebuild (ref), BuildLeftList (ref)
    u5 = p97;
    u6 = Registry:Get("PlayerData");
    u7 = Knit.GetService("BankService");
    pcall(function() -- Line: 680
        -- upvalues: u8 (ref), Knit (ref)
        u8 = Knit.GetController("NotificationController");
    end);
    u19.frame = u5.Frames:WaitForChild("Storage");
    u19.storeButton = u19.frame:WaitForChild("Store");
    u19.withdrawButton = u19.frame:WaitForChild("Withdraw");
    local Contents = u19.frame:WaitForChild("Contents");
    local LeftSection = Contents:WaitForChild("LeftSection");
    local RightSection = Contents:WaitForChild("RightSection");
    u19.leftSelection = LeftSection:WaitForChild("Selection");
    u19.rowTemplate = u19.leftSelection:WaitForChild("TemplateFrame");
    u19.rowTemplate.Visible = false;
    u19.tabsFrame = LeftSection:FindFirstChild("Tabs");

    if u19.tabsFrame then
        local Cosmetics = u19.tabsFrame:FindFirstChild("Cosmetics");

        if Cosmetics then
            Cosmetics.Visible = false;
        end;

        for _, v in u1 do
            local v98 = u19.tabsFrame:FindFirstChild(v);

            if v98 then
                TabStyles.setStateActive(v98, v == u10);
                v98.MouseButton1Click:Connect(function() -- Line: 705
                    -- upvalues: SetCategory (ref), v (copy)
                    SetCategory(v);
                end);
            end;
        end;
    end;

    u19.rarityTabsFrame = LeftSection:FindFirstChild("RarityTabs");

    if u19.rarityTabsFrame then
        u19.allRarityButton = u19.rarityTabsFrame:FindFirstChild("All");
        u19.rarityTabTemplate = u19.rarityTabsFrame:FindFirstChild("Template");

        if u19.rarityTabTemplate then
            u19.rarityTabTemplate.Visible = false;
        end;

        BuildRarityTabs();

        if u19.allRarityButton then
            TabStyles.setStateActive(u19.allRarityButton, true);
            u19.allRarityButton.MouseButton1Click:Connect(function() -- Line: 723
                -- upvalues: SetRarityFilter (ref)
                SetRarityFilter(nil);
            end);
        end;
    end;

    u19.itemInfo = RightSection:WaitForChild("ItemInfo");
    u19.itemInfoName = u19.itemInfo:FindFirstChild("ItemName");
    local Info = u19.itemInfo:FindFirstChild("Info");

    if Info then
        local Rarity = Info:FindFirstChild("Rarity");

        if Rarity then
            Rarity = Rarity:FindFirstChild("Info");
        end;

        u19.itemInfoRarity = Rarity;
        u19.itemInfoDescFrame = Info:FindFirstChild("Description");
        local v99 = u19.itemInfoDescFrame and u19.itemInfoDescFrame:FindFirstChild("Info");
        u19.itemInfoDesc = v99;
        u19.itemInfoImage = Info:FindFirstChild("ItemImage");
        u19.itemInfoStatsTitle = Info:FindFirstChild("StatsTitle");
        u19.itemInfoStats = Info:FindFirstChild("Stats");

        if u19.itemInfoStats then
            u19.itemInfoStatTemplate = u19.itemInfoStats:FindFirstChild("Template");

            if u19.itemInfoStatTemplate then
                u19.itemInfoStatTemplate.Visible = false;
            end;
        end;
    else
        warn("[Storage] ItemInfo.Info not found");
    end;

    local Button = u19.itemInfo:FindFirstChild("Button");

    if Button then
        u19.actionButtons = {};

        for i, v in {
            Action_1 = 1,
            Action_10 = 10,
            Action_All = 0
        } do
            local v100 = Button:FindFirstChild(i);

            if v100 then
                u19.actionButtons[i] = v100;
                v100.MouseButton1Click:Connect(function() -- Line: 760
                    -- upvalues: OnActionClicked (ref), v (copy)
                    OnActionClicked(v);
                end);
            end;
        end;
    else
        warn("[Storage] ItemInfo.Button not found");
    end;

    local SellInfo = RightSection:FindFirstChild("SellInfo");

    if SellInfo then
        SellInfo.Visible = false;
    end;

    u19.itemInfo.Visible = true;
    local StorageLimit = u19.frame:FindFirstChild("StorageLimit");

    if StorageLimit and StorageLimit:IsA("TextLabel") then
        u19.capacityLabel = StorageLimit;
    end;

    u19.storeButton.MouseButton1Click:Connect(function() -- Line: 781
        -- upvalues: SwitchMode (ref)
        SwitchMode("Store");
    end);
    u19.withdrawButton.MouseButton1Click:Connect(function() -- Line: 782
        -- upvalues: SwitchMode (ref)
        SwitchMode("Withdraw");
    end);
    TabStyles.setGradientTabActive(u19.storeButton, true);
    TabStyles.setGradientTabActive(u19.withdrawButton, false);
    u6:OnChange(function(p101, p102) -- Line: 787
        -- upvalues: u2 (ref), QueueRebuild (ref)
        if u2[p102[1]] then
            QueueRebuild();
        end;
    end);
    u19.frame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 795
        -- upvalues: u19 (ref), BuildLeftList (ref)
        if u19.frame.Visible then
            BuildLeftList();
        end;
    end);
end;

return u4;