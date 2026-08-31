--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DungeonLootController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.DungeonLootController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Registry = require(script.Parent.Registry);
local RarityGradient = require(ReplicatedStorage.Modules.RarityGradient);
local GameInfo = ReplicatedStorage:WaitForChild("GameInfo");
local EquipmentTemplates = require(GameInfo:WaitForChild("EquipmentTemplates"));
local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
local Image_Data = require(GameInfo:WaitForChild("Image_Data"));
local ItemData = require(GameInfo:WaitForChild("ItemData"));
local QuestItemData = require(GameInfo:WaitForChild("QuestItemData"));
local PackageData = require(GameInfo:WaitForChild("PackageData"));
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local v1 = Knit.CreateController({
    Name = "DungeonLootController"
});
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = {};
local u6 = {};
local u7 = false;
local u8 = {};
local u9 = {};
local u10 = nil;

local function UpdateFrameVisibility() -- Line: 93
    -- upvalues: u2 (ref), u5 (copy), u7 (ref)
    if u2 then
        u2.Visible = next(u5) ~= nil and true or u7;
    end;
end;

local function CreateCard(p11: userdata) -- Line: 104
    -- upvalues: u4 (ref), EquipmentTemplates (copy), RarityColors (copy), Image_Data (copy), RarityGradient (copy), u3 (ref), u5 (copy)
    local GUID = p11.GUID;
    local v12 = p11.Identified == true;
    local v13 = u4:Clone();
    v13.Name = GUID;
    v13.Visible = true;
    local Template = EquipmentTemplates.GetTemplate(p11.ItemId);
    local Item_Name = v13:FindFirstChild("Item_Name");

    if Item_Name then
        if v12 then
            Item_Name.Text = Template and Template.DisplayName or (p11.ItemId or "");
            local v14 = RarityColors[p11.Rarity or "Common"];

            if v14 then
                Item_Name.TextColor3 = v14.TextColor3 or Color3.new(1, 1, 1);
            end;
        else
            Item_Name.Text = "";
        end;
    end;

    local ViewportFrame = v13:FindFirstChild("ViewportFrame");
    local ItemImage = v13:FindFirstChild("ItemImage");

    if ViewportFrame then
        ViewportFrame.Visible = false;
    end;

    if ItemImage then
        local v15 = Image_Data.Equipment and Image_Data.Equipment[p11.ItemId] or (Template and Template.ImageId or "");

        if v15 and (v15 ~= "" and v15 ~= "rbxassetid://0") then
            ItemImage.Image = v15;
        end;

        ItemImage.ImageColor3 = v12 and Color3.new(1, 1, 1) or Color3.new(0, 0, 0);
        ItemImage.Visible = true;
    end;

    local v16 = v13:FindFirstChildOfClass("UIStroke");
    RarityGradient.toggle(v16, p11.Rarity or "Common");
    local RebirthLock = v13:FindFirstChild("RebirthLock");

    if RebirthLock then
        RebirthLock.Visible = false;
    end;

    local OwnedLabel = v13:FindFirstChild("OwnedLabel");

    if OwnedLabel then
        OwnedLabel.Visible = false;
    end;

    local Lock_Image = v13:FindFirstChild("Lock_Image");

    if Lock_Image then
        Lock_Image.Visible = false;
    end;

    local Item_Level = v13:FindFirstChild("Item_Level");

    if Item_Level then
        if p11.LevelReq and p11.LevelReq > 0 then
            Item_Level.Text = "Lvl. " .. p11.LevelReq;
            Item_Level.Visible = true;
        else
            Item_Level.Visible = false;
        end;
    end;

    local Selection_Button = v13:FindFirstChild("Selection_Button");

    if Selection_Button then
        Selection_Button.Active = false;
    end;

    v13.Parent = u3;
    u5[GUID] = v13;
end;

local function Refresh() -- Line: 183
    -- upvalues: u10 (ref), u3 (ref), u4 (ref), u5 (copy), CreateCard (copy), u2 (ref), u7 (ref)
    if not u10 then
        return;
    end;

    if not (u3 and u4) then
        return;
    end;

    local LootBag = u10.Data.LootBag;
    local v17 = {};

    if LootBag then
        for _, v in LootBag do
            if type(v) == "table" and v.GUID then
                v17[v.GUID] = true;
            end;
        end;
    end;

    for i, v in u5 do
        if not v17[i] then
            v:Destroy();
            u5[i] = nil;
        end;
    end;

    if LootBag then
        for _, v in LootBag do
            if type(v) == "table" and (v.GUID and not u5[v.GUID]) then
                CreateCard(v);
            end;
        end;
    end;

    if u2 then
        u2.Visible = next(u5) ~= nil and true or u7;
    end;
end;

local function SetEarningsCard(p18: string, p19: string, p20: string, p21: string?, p22: number) -- Line: 226
    -- upvalues: u6 (copy), u4 (ref), u3 (ref), RarityColors (copy), RarityGradient (copy)
    local v23 = u6[p18];

    if not v23 then
        v23 = u4:Clone();
        v23.Name = "Earn_" .. p18;
        v23.Visible = true;
        v23.LayoutOrder = p22;
        local ViewportFrame = v23:FindFirstChild("ViewportFrame");

        if ViewportFrame then
            ViewportFrame.Visible = false;
        end;

        local Selection_Button = v23:FindFirstChild("Selection_Button");

        if Selection_Button then
            Selection_Button.Active = false;
        end;

        for _, v in { "RebirthLock", "OwnedLabel", "Lock_Image", "Item_Level" } do
            local v24 = v23:FindFirstChild(v);

            if v24 then
                v24.Visible = false;
            end;
        end;

        v23.Parent = u3;
        u6[p18] = v23;
    end;

    local ItemImage = v23:FindFirstChild("ItemImage");

    if ItemImage then
        ItemImage.Image = p19 or "";
        ItemImage.ImageColor3 = Color3.new(1, 1, 1);
        ItemImage.Visible = true;
    end;

    local Item_Name = v23:FindFirstChild("Item_Name");

    if Item_Name then
        Item_Name.Text = p20;
        local v25;

        if p21 then
            v25 = RarityColors[p21] or nil;
        else
            v25 = nil;
        end;

        Item_Name.TextColor3 = v25 and v25.TextColor3 or Color3.new(1, 1, 1);
    end;

    local v26 = v23:FindFirstChildOfClass("UIStroke");
    RarityGradient.toggle(v26, p21);
end;

local function RemoveEarningsCard(p27: string) -- Line: 272
    -- upvalues: u6 (copy)
    local v28 = u6[p27];

    if v28 then
        v28:Destroy();
        u6[p27] = nil;
    end;
end;

local function UpdateEarnings(p29) -- Line: 281
    -- upvalues: u4 (ref), u3 (ref), u7 (ref), u8 (copy), u9 (copy), u6 (copy), u2 (ref), u5 (copy), QuestItemData (copy), SetEarningsCard (copy), SharedUtils (copy), PackageData (copy), Image_Data (copy), ItemData (copy)
    if not (u4 and u3) then
        return;
    end;

    if not (p29 and p29.Active) then
        u7 = false;
        table.clear(u8);
        table.clear(u9);

        for i in u6 do
            local v30 = u6[i];

            if v30 then
                v30:Destroy();
                u6[i] = nil;
            end;
        end;

        if u2 then
            u2.Visible = next(u5) ~= nil and true or u7;
        end;

        return;
    end;

    u7 = true;
    table.clear(u8);
    local v31 = {};

    for i, v in p29.QuestItems or {} do
        if type(v) == "number" and v > 0 then
            table.insert(v31, i);
        end;
    end;

    table.sort(v31);
    local v32 = {};

    for i, v in ipairs(v31) do
        local v33 = "Quest:" .. v;
        v32[v33] = true;
        local v34 = QuestItemData.Get(v);
        local v35 = v34 and (v34.Rarity or "Mythic") or "Mythic";
        local v36 = v34 and (v34.Icon or "") or "";

        if not (v34 and v34.GrantedOnDrop) then
            local v37;

            if v34 then
                v37 = v34.DisplayName or v;
            else
                v37 = v;
            end;

            u8[v] = v37;
        end;

        SetEarningsCard(v33, v36, SharedUtils.FormatWithCommas(p29.QuestItems[v]), v35, -1100 + i);
    end;

    for i in u6 do
        if i:sub(1, 6) == "Quest:" and not v32[i] then
            local v38 = u6[i];

            if v38 then
                v38:Destroy();
                u6[i] = nil;
            end;
        end;
    end;

    local v39 = {};

    for i, v in p29.Packages or {} do
        if type(v) == "number" and v > 0 then
            table.insert(v39, i);
        end;
    end;

    table.sort(v39);
    local v40 = {};

    for i, v in ipairs(v39) do
        local v41 = "Pack:" .. v;
        v40[v41] = true;
        local v42 = PackageData.Get(v);
        local v43 = v42 and (v42.Rarity or "Mythic") or "Mythic";
        SetEarningsCard(v41, v42 and v42.Icon or "", SharedUtils.FormatWithCommas(p29.Packages[v]), v43, -1050 + i);
    end;

    for i in u6 do
        if i:sub(1, 5) == "Pack:" and not v40[i] then
            local v44 = u6[i];

            if v44 then
                v44:Destroy();
                u6[i] = nil;
            end;
        end;
    end;

    SetEarningsCard("Coins", Image_Data.Rewards.Cash, SharedUtils.FormatWithCommas(p29.Coins or 0), "Common", -1000);

    if (p29.Stars or 0) > 0 then
        SetEarningsCard("Stars", Image_Data.Rewards.Stars, SharedUtils.FormatWithCommas(p29.Stars), "Common", -999);
    else
        local Stars = u6.Stars;

        if Stars then
            Stars:Destroy();
            u6.Stars = nil;
        end;
    end;

    table.clear(u9);
    local v45 = {};

    for i, v in p29.Materials or {} do
        if type(v) == "number" and v > 0 then
            v45[i] = (v45[i] or 0) + v;
        end;
    end;

    for i, v in p29.PendingMaterials or {} do
        if type(v) == "number" and v > 0 then
            v45[i] = (v45[i] or 0) + v;
            local Material = ItemData.GetMaterial(i);
            local v46;

            if Material then
                v46 = Material.Name or i;
            else
                v46 = i;
            end;

            u9[i] = v46;
        end;
    end;

    local v47 = {};

    for i in v45 do
        table.insert(v47, i);
    end;

    table.sort(v47);
    local v48 = {};

    for i, v in ipairs(v47) do
        local v49 = "Mat:" .. v;
        v48[v49] = true;
        local Material = ItemData.GetMaterial(v);
        local v50 = Material and (Material.Rarity or "Common") or "Common";
        SetEarningsCard(v49, Material and Material.Icon or "", SharedUtils.FormatWithCommas(v45[v]), v50, -900 + i);
    end;

    for i in u6 do
        if i:sub(1, 4) == "Mat:" and not v48[i] then
            local v51 = u6[i];

            if v51 then
                v51:Destroy();
                u6[i] = nil;
            end;
        end;
    end;

    if u2 then
        u2.Visible = next(u5) ~= nil and true or u7;
    end;
end;

function v1.GetPendingQuestItemNames(p52) -- Line: 428
    -- upvalues: u7 (ref), u8 (copy)
    local v53 = {};

    if u7 then
        for _, v in u8 do
            table.insert(v53, v);
        end;

        table.sort(v53);
    end;

    return v53;
end;

function v1.GetPendingMaterialNames(p54) -- Line: 445
    -- upvalues: u7 (ref), u9 (copy)
    local v55 = {};

    if u7 then
        for _, v in u9 do
            table.insert(v55, v);
        end;

        table.sort(v55);
    end;

    return v55;
end;

function v1.KnitInit(p56) -- Line: 458
    -- upvalues: Knit (copy), u2 (ref), u3 (ref), u4 (ref)
    u2 = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("HUD"):FindFirstChild("Dungeon_Loot");

    if not u2 then
        warn("[DungeonLootController] Dungeon_Loot frame not found in Main.HUD");

        return;
    end;

    local Loot_Frame = u2:FindFirstChild("Loot_Frame");

    if Loot_Frame then
        u3 = Loot_Frame;
        u4 = Loot_Frame:FindFirstChild("Item_Template");

        if u4 then
            u4.Visible = false;
        end;
    end;

    u2.Visible = false;
end;

function v1.KnitStart(p57) -- Line: 483
    -- upvalues: u10 (ref), Registry (copy), Refresh (copy), Knit (copy), UpdateEarnings (copy)
    u10 = Registry:Get("PlayerData");

    if not u10 then
        warn("[DungeonLootController] PlayerData not available");

        return;
    end;

    u10:OnChange(function(p58, p59) -- Line: 493
        -- upvalues: Refresh (ref)
        if p59[1] == "LootBag" then
            Refresh();
        end;
    end);
    Refresh();
    Knit.GetService("RunEarningsService").EarningsUpdated:Connect(function(p60) -- Line: 505
        -- upvalues: UpdateEarnings (ref)
        UpdateEarnings(p60);
    end);
end;

return v1;