--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CraftingController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.CraftingController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CraftingData = require(ReplicatedStorage.GameInfo.CraftingData);
local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local Knit = require(ReplicatedStorage.Packages.Knit);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local RevealCascade = require(script.Parent.Parent.ClientUtils.RevealCascade);
local UIController = require(script.Parent.Parent.Controllers.UIController);
local ItemIndex = require(script.Parent.ItemIndex);
local Color3_new_ret = Color3.new(1, 1, 1);
local Color3_fromRGB_ret = Color3.fromRGB(100, 255, 100);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 100, 100);
local v1 = {};
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
local u22 = "All";
local u23 = nil;
local u24 = false;
local u25 = {};
local u26 = {};
local u27 = 0;

local function getMaterials() -- Line: 64
    -- upvalues: u3 (ref)
    return u3.Data and u3.Data.CraftingMaterials or {};
end;

local function getOwned(p28: string) -- Line: 68
    -- upvalues: u3 (ref)
    return (u3.Data and u3.Data.CraftingMaterials or {})[p28] or 0;
end;

local function getCoins() -- Line: 72
    -- upvalues: u3 (ref)
    return u3.Data and u3.Data.Currency or 0;
end;

local function rarityColor(p29: string?) -- Line: 77
    -- upvalues: RarityColors (copy), Color3_new_ret (copy)
    if p29 then
        p29 = RarityColors[p29];
    end;

    return p29 and p29.TextColor3 or Color3_new_ret;
end;

local function computeMax(p30) -- Line: 83
    -- upvalues: u3 (ref)
    local v31 = (p30.CoinCost or 0) <= 0 and (1 / 0) or math.floor((u3.Data and u3.Data.Currency or 0) / p30.CoinCost);

    for _, v in p30.Materials do
        if (v.Amount or 0) > 0 then
            local math_floor_ret = math.floor(((u3.Data and u3.Data.CraftingMaterials or {})[v.Id] or 0) / v.Amount);
            v31 = math.min(v31, math_floor_ret);
        end;
    end;

    return math.min(v31 == (1 / 0) and 100 or v31, 100);
end;

local function setButtonEnabled(p32: userdata, p33: boolean) -- Line: 100
    p32.Active = p33;
    p32.AutoButtonColor = p33;
    local Background = p32:FindFirstChild("Background");

    if Background and Background:IsA("ImageLabel") then
        Background.ImageTransparency = p33 and 0 or 0.5;
    end;
end;

local function applySelectionVisuals(p34: userdata, p35: any) -- Line: 113
    -- upvalues: RarityColors (copy), Color3_new_ret (copy)
    local Rarity = p35.Rarity;

    if Rarity then
        Rarity = RarityColors[Rarity];
    end;

    local v36 = Rarity and Rarity.TextColor3 or Color3_new_ret;

    for _, v in { "Active", "InActive" } do
        local v37 = p34:FindFirstChild(v);

        if v37 then
            local TitleName = v37:FindFirstChild("TitleName");

            if TitleName and TitleName:IsA("TextLabel") then
                TitleName.Text = p35.Name;
                TitleName.TextColor3 = v36;
            end;

            local Background = v37:FindFirstChild("Background");

            if Background then
                Background = Background:FindFirstChild("Stars");
            end;

            if Background then
                for _, child in Background:GetChildren() do
                    if child:IsA("ImageLabel") then
                        child.ImageColor3 = v36;
                    end;
                end;
            end;
        end;
    end;
end;

local function refreshSelectionStates() -- Line: 138
    -- upvalues: u25 (copy), u23 (ref)
    for i, v in u25 do
        local v38 = i == u23;
        local Active = v:FindFirstChild("Active");
        local InActive = v:FindFirstChild("InActive");

        if Active then
            Active.Visible = v38;
        end;

        if InActive then
            InActive.Visible = not v38;
        end;
    end;
end;

local function refreshDynamic() -- Line: 152
    -- upvalues: u23 (ref), CraftingData (copy), u17 (ref), SharedUtils (copy), u3 (ref), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), u26 (copy), computeMax (copy), u18 (ref), u19 (ref)
    if not u23 then
        return;
    end;

    local v39 = CraftingData.Resolve(u23);

    if not v39 then
        return;
    end;

    if u17 then
        u17.Text = SharedUtils.FormatCashString(v39.CoinCost);
        u17.TextColor3 = (u3.Data and u3.Data.Currency or 0) >= v39.CoinCost and Color3_fromRGB_ret or Color3_fromRGB_ret2;
    end;

    for _, v in u26 do
        local v40 = (u3.Data and u3.Data.CraftingMaterials or {})[v.matId] or 0;
        local Amount = v.clone:FindFirstChild("Amount");

        if Amount and Amount:IsA("TextLabel") then
            Amount.Text = string.format("%d/%d", v40, v.required);
            Amount.TextColor3 = v.required <= v40 and Color3_fromRGB_ret or Color3_fromRGB_ret2;
        end;
    end;

    local v41 = computeMax(v39);

    if u18 then
        local Amount = u18:FindFirstChild("Amount");

        if Amount and Amount:IsA("TextLabel") then
            Amount.Text = "x" .. v39.Amount;
        end;

        local v42 = u18;
        local v43 = v41 >= 1;
        v42.Active = v43;
        v42.AutoButtonColor = v43;
        local Background = v42:FindFirstChild("Background");

        if Background and Background:IsA("ImageLabel") then
            Background.ImageTransparency = v43 and 0 or 0.5;
        end;
    end;

    if u19 then
        local Amount = u19:FindFirstChild("Amount");

        if Amount and Amount:IsA("TextLabel") then
            Amount.Text = "x" .. v41;
        end;

        local v44 = u19;
        local v45 = v41 >= 1;
        v44.Active = v45;
        v44.AutoButtonColor = v45;
        local Background = v44:FindFirstChild("Background");

        if Background and Background:IsA("ImageLabel") then
            Background.ImageTransparency = v45 and 0 or 0.5;
        end;
    end;
end;

local function buildRequirements(u46: string, p47: any) -- Line: 188
    -- upvalues: u26 (copy), CraftingData (copy), u21 (ref), RarityColors (copy), Color3_new_ret (copy), u6 (ref), ItemIndex (copy), u20 (ref), RevealCascade (copy), u7 (ref), u23 (ref)
    for _, v in u26 do
        v.clone:Destroy();
    end;

    table.clear(u26);
    local v48 = {};

    for i, v in p47.Materials do
        local v49 = CraftingData.ResolveMaterial(v.Id);
        local v50 = u21:Clone();
        v50.Name = "Req_" .. i;
        v50.Visible = true;
        v50.LayoutOrder = i;
        v50.ZIndex = 1000 - i;
        local ItemImage = v50:FindFirstChild("ItemImage");

        if ItemImage and (ItemImage:IsA("ImageLabel") and v49.Icon ~= "") then
            ItemImage.Image = v49.Icon;
        end;

        local Item_Name = v50:FindFirstChild("Item_Name");

        if Item_Name and Item_Name:IsA("TextLabel") then
            Item_Name.Text = v49.Name;
            local Rarity = v49.Rarity;

            if Rarity then
                Rarity = RarityColors[Rarity];
            end;

            Item_Name.TextColor3 = Rarity and Rarity.TextColor3 or Color3_new_ret;
        end;

        local Selection_Button = v50:FindFirstChild("Selection_Button");

        if Selection_Button and (Item_Name and u6) then
            Item_Name.Visible = true;
            u6:BindHoverScale(Selection_Button, Item_Name, {
                HiddenScale = 0,
                ShownScale = 1
            });
        end;

        local Item_Level = v50:FindFirstChild("Item_Level");

        if Item_Level then
            Item_Level.Visible = false;
        end;

        ItemIndex.BindCard(v50, v.Id, "Crafting");
        v50.Parent = u20;
        table.insert(u26, {
            clone = v50,
            matId = v.Id,
            required = v.Amount
        });
        table.insert(v48, v50);
    end;

    RevealCascade.play(v48, {
        isCurrent = function() -- Line: 241, Name: isCurrent
            -- upvalues: u7 (ref), u23 (ref), u46 (copy)
            return u7.Visible and u23 == u46;
        end
    });
end;

local function clearDetail() -- Line: 248
    -- upvalues: u23 (ref), u11 (ref), u15 (ref), u13 (ref), u16 (ref), u17 (ref), u26 (copy), u18 (ref), u19 (ref)
    u23 = nil;

    if u11 then
        u11.Text = "";
    end;

    if u15 then
        u15.Text = "";
    end;

    if u13 then
        u13.Text = "";
    end;

    if u16 then
        u16.Image = "";
        u16.Visible = false;
    end;

    if u17 then
        u17.Text = "";
    end;

    for _, v in u26 do
        v.clone:Destroy();
    end;

    table.clear(u26);

    if u18 then
        local v51 = u18;
        v51.Active = false;
        v51.AutoButtonColor = false;
        local Background = v51:FindFirstChild("Background");

        if Background and Background:IsA("ImageLabel") then
            Background.ImageTransparency = 0.5;
        end;
    end;

    if u19 then
        local v52 = u19;
        v52.Active = false;
        v52.AutoButtonColor = false;
        local Background = v52:FindFirstChild("Background");

        if Background and Background:IsA("ImageLabel") then
            Background.ImageTransparency = 0.5;
        end;
    end;
end;

local function selectRecipe(p53: string) -- Line: 262
    -- upvalues: CraftingData (copy), u23 (ref), u11 (ref), RarityColors (copy), Color3_new_ret (copy), u13 (ref), u14 (ref), u15 (ref), u16 (ref), buildRequirements (copy), refreshDynamic (copy), refreshSelectionStates (copy)
    local v54 = CraftingData.Resolve(p53);

    if not v54 then
        return;
    end;

    u23 = p53;

    if u11 then
        u11.Text = v54.Name;
        local Rarity = v54.Rarity;

        if Rarity then
            Rarity = RarityColors[Rarity];
        end;

        u11.TextColor3 = Rarity and Rarity.TextColor3 or Color3_new_ret;
    end;

    if u13 then
        u13.Text = v54.Rarity;
        local Rarity = v54.Rarity;

        if Rarity then
            Rarity = RarityColors[Rarity];
        end;

        u13.TextColor3 = Rarity and Rarity.TextColor3 or Color3_new_ret;
    end;

    if u14 then
        u14.Visible = v54.ShowDescription ~= false;
    end;

    if u15 then
        u15.Text = v54.Description;
    end;

    if u16 then
        u16.Image = v54.Icon or "";
        u16.Visible = (v54.Icon or "") ~= "";
    end;

    buildRequirements(p53, v54);
    refreshDynamic();
    refreshSelectionStates();
end;

local function buildSelectionList() -- Line: 289
    -- upvalues: u25 (copy), u27 (ref), u22 (ref), CraftingData (copy), u9 (ref), applySelectionVisuals (copy), selectRecipe (copy), u8 (ref), RevealCascade (copy), u7 (ref), clearDetail (copy)
    for _, v in u25 do
        v:Destroy();
    end;

    table.clear(u25);
    u27 = u27 + 1;
    local u55 = u27;
    local u56 = u22;
    local ByCategory = CraftingData.GetByCategory(u22);
    local v57 = {};

    for i, v in ByCategory do
        local v58 = CraftingData.Resolve(v);
        local v59 = u9:Clone();
        v59.Name = v;
        v59.Visible = true;
        v59.LayoutOrder = i;
        applySelectionVisuals(v59, v58);
        v59.MouseButton1Click:Connect(function() -- Line: 308
            -- upvalues: selectRecipe (ref), v (copy)
            selectRecipe(v);
        end);
        v59.Parent = u8;
        u25[v] = v59;
        table.insert(v57, v59);
    end;

    RevealCascade.play(v57, {
        isCurrent = function() -- Line: 318, Name: isCurrent
            -- upvalues: u7 (ref), u27 (ref), u55 (copy), u22 (ref), u56 (copy)
            local Visible = u7.Visible;

            if Visible then
                if u27 == u55 then
                    Visible = u22 == u56;
                else
                    Visible = false;
                end;
            end;

            return Visible;
        end
    });

    if #ByCategory > 0 then
        selectRecipe(ByCategory[1]);

        return;
    end;

    clearDetail();
end;

local function setActiveTab(p60: string) -- Line: 334
    -- upvalues: u22 (ref), u10 (ref), buildSelectionList (copy)
    u22 = p60;

    for _, child in u10:GetChildren() do
        if child:IsA("GuiButton") then
            local v61 = child.Name == p60;
            local Active = child:FindFirstChild("Active");
            local Inactive = child:FindFirstChild("Inactive");

            if Active then
                Active.Visible = v61;
            end;

            if Inactive then
                Inactive.Visible = not v61;
            end;
        end;
    end;

    buildSelectionList();
end;

local function notifyReason(p62: string?) -- Line: 350
    -- upvalues: Knit (copy), Color3_fromRGB_ret2 (copy)
    local success, result = pcall(function() -- Line: 351
        -- upvalues: Knit (ref)
        return Knit.GetController("NotificationController");
    end);

    if not (success and result) then
        return;
    end;

    if p62 == "NOT_ENOUGH_CURRENCY" then
        result:Show("NO_CASH");

        return;
    end;

    if p62 == "NOT_ENOUGH_MATERIALS" then
        result:Show("Custom", "Not enough materials!", 3, Color3_fromRGB_ret2, Color3.fromRGB(80, 30, 30), "Error");

        return;
    end;

    if p62 and p62 ~= "TOO_FAST" then
        result:Show("Custom", "Craft failed.", 3, Color3_fromRGB_ret2, Color3.fromRGB(80, 30, 30), "Error");
    end;
end;

local function doCraft(p63: number) -- Line: 367
    -- upvalues: u24 (ref), u23 (ref), CraftingData (copy), u3 (ref), Knit (copy), Color3_fromRGB_ret2 (copy), u4 (ref), u5 (ref), refreshDynamic (copy), notifyReason (copy)
    if u24 or not u23 then
        return;
    end;

    if p63 < 1 then
        return;
    end;

    u24 = true;
    local v64 = u23;
    local v65 = CraftingData.Get(v64);

    if v65 and (v65.OutputType == "Equipment" and u3) then
        local Data = u3.Data;
        local v66 = (Data.MaxInventorySlots or 60) - (Data.EquipmentInventory and #Data.EquipmentInventory or 0);

        if v66 <= 0 then
            local success, result = pcall(function() -- Line: 388
                -- upvalues: Knit (ref)
                return Knit.GetController("NotificationController");
            end);

            if success and result then
                result:Show("Custom", "Inventory full — make room before crafting equipment.", 4, Color3_fromRGB_ret2, Color3.fromRGB(80, 30, 30), "Error");
            end;

            u24 = false;

            return;
        end;

        if v66 < 5 and not Knit.GetController("WarningController"):Prompt({
            ConfirmText = "Craft Anyway",
            DenyText = "Cancel",
            Message = `Your inventory is nearly full — <b>{v66}</b> slot(s) free.\nCrafted gear that doesn't fit will overflow to Loot Storage.\nCraft anyway?`
        }) then
            u24 = false;

            return;
        end;
    end;

    local v67, v68, v69 = u4:Craft(v64, p63):await();
    u24 = false;

    if v67 and v68 then
        if u5 then
            pcall(function() -- Line: 419
                -- upvalues: u5 (ref)
                u5:Play("Craft");
            end);
        end;

        if u23 == v64 then
            refreshDynamic();
        end;
    else
        notifyReason(v69);
    end;
end;

local function doCraftMax() -- Line: 430
    -- upvalues: u23 (ref), CraftingData (copy), computeMax (copy), Knit (copy), Color3_fromRGB_ret2 (copy), doCraft (copy)
    if not u23 then
        return;
    end;

    local v70 = CraftingData.Resolve(u23);

    if not v70 then
        return;
    end;

    local v71 = computeMax(v70);

    if v71 >= 1 then
        doCraft(v71);

        return;
    end;

    local success, result = pcall(function() -- Line: 351
        -- upvalues: Knit (ref)
        return Knit.GetController("NotificationController");
    end);

    if success then
        if not result then
            return;
        end;

        result:Show("Custom", "Not enough materials!", 3, Color3_fromRGB_ret2, Color3.fromRGB(80, 30, 30), "Error");
    end;
end;

function v1._Init(p72) -- Line: 444
    -- upvalues: u2 (ref), u3 (ref), Registry (copy), u4 (ref), Knit (copy), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), setActiveTab (copy), doCraft (copy), u23 (ref), CraftingData (copy), computeMax (copy), Color3_fromRGB_ret2 (copy), UIController (copy), u22 (ref), refreshDynamic (copy)
    u2 = p72;
    u3 = Registry:Get("PlayerData");
    u4 = Knit.GetService("CraftingService");
    u5 = Knit.GetController("SoundController");
    u6 = Knit.GetController("UIAnimationController");
    u7 = u2.Frames:WaitForChild("Crafting");
    local Contents = u7:WaitForChild("Contents");
    local LeftSection = Contents:WaitForChild("LeftSection");
    u8 = LeftSection:WaitForChild("Selection");
    u9 = u8:WaitForChild("Template");
    u9.Visible = false;
    u10 = LeftSection:WaitForChild("Tabs");
    local ItemInfo = Contents:WaitForChild("RightSection"):WaitForChild("ItemInfo");
    u11 = ItemInfo:WaitForChild("ItemName");
    u12 = ItemInfo:WaitForChild("Info");
    local v73 = u12:FindFirstChild("Rarity") and u12.Rarity:FindFirstChild("Info");
    u13 = v73;
    u14 = u12:FindFirstChild("Description");
    local v74 = u14 and u14:FindFirstChild("Info");
    u15 = v74;
    u16 = u12:FindFirstChild("ItemImage");
    u17 = ItemInfo:FindFirstChild("CoinCost");
    local Button = ItemInfo:WaitForChild("Button");
    u18 = Button:WaitForChild("Craft");
    u19 = Button:WaitForChild("CraftMax");
    u20 = ItemInfo:WaitForChild("Requirements"):WaitForChild("ScrollingFrame");
    u21 = u20:WaitForChild("TemplateFrame");
    u21.Visible = false;

    for _, child in u10:GetChildren() do
        if child:IsA("GuiButton") then
            child.MouseButton1Click:Connect(function() -- Line: 484
                -- upvalues: setActiveTab (ref), child (copy)
                setActiveTab(child.Name);
            end);
        end;
    end;

    u18.MouseButton1Click:Connect(function() -- Line: 491
        -- upvalues: doCraft (ref)
        doCraft(1);
    end);
    u19.MouseButton1Click:Connect(function() -- Line: 492
        -- upvalues: u23 (ref), CraftingData (ref), computeMax (ref), Knit (ref), Color3_fromRGB_ret2 (ref), doCraft (ref)
        if not u23 then
            return;
        end;

        local v75 = CraftingData.Resolve(u23);

        if not v75 then
            return;
        end;

        local v76 = computeMax(v75);

        if v76 < 1 then
            local success, result = pcall(function() -- Line: 351
                -- upvalues: Knit (ref)
                return Knit.GetController("NotificationController");
            end);

            if success then
                if not result then
                    return;
                end;

                result:Show("Custom", "Not enough materials!", 3, Color3_fromRGB_ret2, Color3.fromRGB(80, 30, 30), "Error");
            end;
        else
            doCraft(v76);
        end;
    end);

    if not UIController.getByName("Crafting") then
        local u77 = UIController.new(u7);
        local Exit = u7:FindFirstChild("Exit");

        if Exit then
            Exit.MouseButton1Click:Connect(function() -- Line: 502
                -- upvalues: u77 (ref)
                u77:close();
            end);
        end;
    end;

    local Forge = u7:FindFirstChild("Forge");

    if Forge and Forge:IsA("GuiButton") then
        Forge.MouseButton1Click:Connect(function() -- Line: 509
            -- upvalues: u2 (ref), UIController (ref)
            local Forge2 = u2.Frames:FindFirstChild("Forge");

            if not Forge2 then
                return;
            end;

            (UIController.getByName("Forge") or UIController.new(Forge2)):open();
        end);
    end;

    u7:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 518
        -- upvalues: u7 (ref), setActiveTab (ref), u22 (ref)
        if u7.Visible then
            setActiveTab(u22);
        end;
    end);
    u3:OnChange(function(p78, p79) -- Line: 525
        -- upvalues: u7 (ref), u23 (ref), refreshDynamic (ref)
        if not u7.Visible then
            return;
        end;

        local v80 = p79[1];

        if (v80 == "CraftingMaterials" or (v80 == "Currency" or (v80 == "Packs" or (v80 == "Potions" or v80 == "BuffPotions")))) and u23 then
            refreshDynamic();
        end;
    end);
    setActiveTab(u22);
end;

return v1;