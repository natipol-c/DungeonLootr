--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     IdentifierController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.IdentifierController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local UIController = require(script.Parent.UIController);
local Registry = require(script.Parent.Registry);
local RarityGradient = require(ReplicatedStorage.Modules.RarityGradient);
local GameInfo = ReplicatedStorage:WaitForChild("GameInfo");
local EquipmentTemplates = require(GameInfo:WaitForChild("EquipmentTemplates"));
local EquipmentData = require(GameInfo:WaitForChild("EquipmentData"));
local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
local Image_Data = require(GameInfo:WaitForChild("Image_Data"));
local RarityIndex = require(GameInfo:WaitForChild("RarityData")).RarityIndex;
local u1 = {
    All = nil,
    Head = {
        Head = true
    },
    Body = {
        Body = true
    },
    Rings = {
        Ring = true
    }
};
local v2 = Knit.CreateController({
    Name = "IdentifierController"
});
local _ = Players.LocalPlayer;
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
local u18 = false;
local u19 = nil;
local u20 = "All";
local u21 = "";
local u22 = {};
local u23 = {};
local u24 = {};
local u25 = nil;
local u26 = nil;
local u27 = nil;
local u28 = nil;
local u29 = nil;
local u30 = false;
local u31 = nil;

local function ShowIdentifyPointer() -- Line: 133
    -- upvalues: u30 (ref), u28 (ref)
    if u30 then
        return;
    end;

    if not u28 then
        return;
    end;

    local Guide_Targets = workspace:FindFirstChild("Guide_Targets");

    if not Guide_Targets then
        return;
    end;

    local Identify_Area = Guide_Targets:FindFirstChild("Identify_Area");

    if not Identify_Area then
        return;
    end;

    local v32 = Identify_Area:FindFirstChild("Pointer") or (Identify_Area.PrimaryPart or Identify_Area);

    if not v32 then
        return;
    end;

    u30 = true;
    u28:ShowGuidePointer(v32);
end;

local function ClearIdentifyPointer() -- Line: 150
    -- upvalues: u30 (ref), u28 (ref)
    if not u30 then
        return;
    end;

    u30 = false;

    if u28 then
        u28:HideGuidePointer();
    end;
end;

local function MatchesFilter(p33: userdata) -- Line: 161
    -- upvalues: u1 (copy), u20 (ref), u21 (ref)
    local v34 = u1[u20];

    if v34 and not v34[p33.Slot] then
        return false;
    end;

    if u21 ~= "" then
        local string_lower_ret = string.lower(p33.DisplayName);

        if not string.find(string_lower_ret, string.lower(u21), 1, true) then
            return false;
        end;
    end;

    return true;
end;

local function ApplyFilterAndSearch() -- Line: 178
    -- upvalues: u24 (copy), u23 (copy), MatchesFilter (copy)
    for i, v in u24 do
        local v35 = u23[i];

        if v35 then
            v.Visible = MatchesFilter(v35);
        end;
    end;
end;

local function PopulateStatInfo(p36: userdata, p37: userdata) -- Line: 188
    -- upvalues: EquipmentData (copy)
    for _, child in p36:GetChildren() do
        if child.Name ~= "Ignore" and (child.Name ~= "Stat_Template" and not (child:IsA("UIListLayout") or child:IsA("UIPadding"))) then
            child:Destroy();
        end;
    end;

    local Stat_Template = p36:FindFirstChild("Stat_Template");

    if not Stat_Template then
        return;
    end;

    local v38 = 0;

    if p37.Slot == "Ring" and p37.BaseDamage then
        local v39 = Stat_Template:Clone();
        v39.Name = "Stat_BaseDamage";
        v39.Text = EquipmentData.FormatStat("SoulBaseDamage", p37.BaseDamage);
        v39.RichText = true;
        v39.LayoutOrder = v38;
        v39.Visible = true;
        v39.Parent = p36;
        v38 = v38 + 1;
    end;

    if p37.StatLines then
        for _, v in p37.StatLines do
            local v40 = Stat_Template:Clone();
            v40.Name = "Stat_" .. v.Key;
            v40.Text = v.Formatted;
            v40.RichText = true;
            v40.LayoutOrder = v38;
            v40.Visible = true;
            v40.Parent = p36;
            v38 = v38 + 1;
        end;
    end;
end;

local function BuildItemList() -- Line: 236
    -- upvalues: u29 (ref), EquipmentTemplates (copy), Image_Data (copy), EquipmentData (copy), RarityIndex (copy), u22 (copy)
    local v41 = {};
    local Data = u29.Data;
    local LootStorage = Data.LootStorage;

    if LootStorage then
        for _, v in LootStorage do
            if type(v) == "table" and v.GUID then
                local Template = EquipmentTemplates.GetTemplate(v.ItemId);
                local v42 = Template and Template.DisplayName or (v.ItemId or "Unknown");
                local v43 = Image_Data.Equipment and Image_Data.Equipment[v.ItemId] or (Template and Template.ImageId or "");
                local v44 = v.Identified == true;
                local v45, v46;

                if v44 and v.Stats then
                    v45 = v;
                    v46 = {};

                    for i, v3 in v.Stats do
                        local v47 = {
                            Key = i,
                            Value = v3,
                            Formatted = EquipmentData.FormatStat(i, v3, v45.Slot)
                        };
                        table.insert(v46, v47);
                    end;
                else
                    v45 = v;
                    v46 = nil;
                end;

                local v48 = {
                    GUID = v45.GUID,
                    ItemId = v45.ItemId,
                    DisplayName = v42,
                    Slot = v45.Slot,
                    Rarity = v45.Rarity or "Common",
                    LevelReq = v45.LevelReq or 0,
                    Icon = v43,
                    IsIdentified = v44,
                    StatLines = v46
                };
                local v49;

                if v44 then
                    v49 = v45.BaseDamage or nil;
                else
                    v49 = nil;
                end;

                v48.BaseDamage = v49;
                v48.LayoutOrder = 50 + (RarityIndex[v45.Rarity] or 0);
                table.insert(v41, v48);
            end;
        end;
    end;

    local EquipmentInventory = Data.EquipmentInventory;

    if EquipmentInventory then
        for _, v in EquipmentInventory do
            if type(v) == "table" and (v.GUID and u22[v.GUID]) then
                local Template = EquipmentTemplates.GetTemplate(v.ItemId);
                local v50 = Template and Template.DisplayName or (v.ItemId or "Unknown");
                local v51 = Image_Data.Equipment and Image_Data.Equipment[v.ItemId] or (Template and Template.ImageId or "");
                local v52 = {};
                local v53;

                if v.Stats then
                    v53 = v;

                    for i, v3 in v.Stats do
                        local v54 = {
                            Key = i,
                            Value = v3,
                            Formatted = EquipmentData.FormatStat(i, v3, v53.Slot)
                        };
                        table.insert(v52, v54);
                    end;
                else
                    v53 = v;
                end;

                table.insert(v41, {
                    IsIdentified = true,
                    GUID = v53.GUID,
                    ItemId = v53.ItemId,
                    DisplayName = v50,
                    Slot = v53.Slot,
                    Rarity = v53.Rarity or "Common",
                    LevelReq = v53.LevelReq or 0,
                    Icon = v51,
                    StatLines = v52,
                    BaseDamage = v53.BaseDamage,
                    LayoutOrder = 50 + (RarityIndex[v53.Rarity] or 0)
                });
            end;
        end;
    end;

    table.sort(v41, function(p55, p56) -- Line: 327
        if p55.LayoutOrder == p56.LayoutOrder then
            return p55.DisplayName < p56.DisplayName;
        end;

        return p55.LayoutOrder < p56.LayoutOrder;
    end);

    return v41;
end;

local function CreateBodyTemplate(p57: userdata) -- Line: 340
    -- upvalues: u8 (ref), RarityColors (copy), u29 (ref), RarityGradient (copy), u31 (ref), u5 (ref), u24 (copy)
    local GUID = p57.GUID;
    local v58 = u8:Clone();
    v58.Name = GUID;
    v58.Visible = true;
    local Item_Name = v58:FindFirstChild("Item_Name");

    if Item_Name then
        if p57.IsIdentified then
            Item_Name.Text = p57.DisplayName;
            local v59 = RarityColors[p57.Rarity];

            if v59 then
                Item_Name.TextColor3 = v59.TextColor3 or Color3.new(1, 1, 1);
            end;
        else
            Item_Name.Text = "";
        end;
    end;

    local Item_Level = v58:FindFirstChild("Item_Level");

    if Item_Level then
        if p57.LevelReq and p57.LevelReq > 0 then
            Item_Level.Text = "Lvl. " .. p57.LevelReq;
            Item_Level.Visible = true;

            if (u29.Data.PlayerLevel or 1) < p57.LevelReq then
                Item_Level.TextColor3 = Color3.fromRGB(255, 75, 75);
            else
                Item_Level.TextColor3 = Color3.fromRGB(180, 180, 180);
            end;
        else
            Item_Level.Visible = false;
        end;
    end;

    local ViewportFrame = v58:FindFirstChild("ViewportFrame");
    local ItemImage = v58:FindFirstChild("ItemImage");

    if ViewportFrame then
        ViewportFrame.Visible = false;
    end;

    if ItemImage then
        local Icon = p57.Icon;

        if Icon and (Icon ~= "" and Icon ~= "rbxassetid://0") then
            ItemImage.Image = Icon;
        end;

        if p57.IsIdentified then
            ItemImage.ImageColor3 = Color3.new(1, 1, 1);
        else
            ItemImage.ImageColor3 = Color3.new(0, 0, 0);
        end;

        ItemImage.Visible = true;
    end;

    local v60 = v58:FindFirstChildOfClass("UIStroke");
    RarityGradient.toggle(v60, p57.Rarity);
    local RebirthLock = v58:FindFirstChild("RebirthLock");

    if RebirthLock then
        RebirthLock.Visible = false;
    end;

    local OwnedLabel = v58:FindFirstChild("OwnedLabel");

    if OwnedLabel then
        OwnedLabel.Visible = false;
    end;

    local Lock_Image = v58:FindFirstChild("Lock_Image");

    if Lock_Image then
        Lock_Image.Visible = false;
    end;

    local Selection_Button = v58:FindFirstChild("Selection_Button");

    if Selection_Button then
        Selection_Button.MouseButton1Click:Connect(function() -- Line: 416
            -- upvalues: u31 (ref), GUID (copy)
            u31(GUID);
        end);
    end;

    v58.LayoutOrder = p57.LayoutOrder or 0;
    v58.Parent = u5;
    u24[GUID] = v58;

    return v58;
end;

local function UpdateBodyTemplate(p61: userdata, p62: userdata) -- Line: 429
    -- upvalues: RarityColors (copy), u29 (ref), RarityGradient (copy)
    local Item_Name = p61:FindFirstChild("Item_Name");

    if Item_Name then
        if p62.IsIdentified then
            Item_Name.Text = p62.DisplayName;
            local v63 = RarityColors[p62.Rarity];

            if v63 then
                Item_Name.TextColor3 = v63.TextColor3 or Color3.new(1, 1, 1);
            end;
        else
            Item_Name.Text = "";
        end;
    end;

    local Item_Level = p61:FindFirstChild("Item_Level");

    if Item_Level then
        if p62.LevelReq and p62.LevelReq > 0 then
            Item_Level.Text = "Lvl. " .. p62.LevelReq;
            Item_Level.Visible = true;

            if (u29.Data.PlayerLevel or 1) < p62.LevelReq then
                Item_Level.TextColor3 = Color3.fromRGB(255, 75, 75);
            else
                Item_Level.TextColor3 = Color3.fromRGB(180, 180, 180);
            end;
        else
            Item_Level.Visible = false;
        end;
    end;

    local ItemImage = p61:FindFirstChild("ItemImage");

    if ItemImage then
        if p62.IsIdentified then
            ItemImage.ImageColor3 = Color3.new(1, 1, 1);
        else
            ItemImage.ImageColor3 = Color3.new(0, 0, 0);
        end;

        ItemImage.Visible = true;
    end;

    local v64 = p61:FindFirstChildOfClass("UIStroke");
    RarityGradient.toggle(v64, p62.Rarity);
end;

local function ClearItemInfo() -- Line: 480
    -- upvalues: u6 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref)
    if not u6 then
        return;
    end;

    u6.Visible = false;

    if u10 then
        u10.Text = "";
    end;

    if u11 then
        u11.Image = "";
        u11.Visible = false;
    end;

    if u12 then
        u12.Visible = false;
    end;

    if u13 then
        u13.Text = "";
        u13.Visible = false;
    end;

    if u14 then
        u14.Text = "";
        u14.Visible = false;
    end;

    if u15 then
        u15.Visible = false;
    end;
end;

local function UpdateItemInfo(p65: string) -- Line: 493
    -- upvalues: u23 (copy), u6 (ref), u10 (ref), RarityColors (copy), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), PopulateStatInfo (copy)
    local v66 = u23[p65];

    if not (v66 and u6) then
        return;
    end;

    u6.Visible = true;

    if u10 then
        if v66.IsIdentified then
            u10.Text = v66.DisplayName;
            local v67 = RarityColors[v66.Rarity];
            u10.TextColor3 = v67 and v67.TextColor3 or Color3.new(1, 1, 1);
        else
            u10.Text = "";
        end;
    end;

    if u11 then
        local Icon = v66.Icon;

        if Icon and (Icon ~= "" and Icon ~= "rbxassetid://0") then
            u11.Image = Icon;
        end;

        if v66.IsIdentified then
            u11.ImageColor3 = Color3.new(1, 1, 1);
        else
            u11.ImageColor3 = Color3.new(0, 0, 0);
        end;

        u11.Visible = true;
    end;

    if u12 then
        u12.Visible = not v66.IsIdentified;
    end;

    if u13 then
        if v66.LevelReq and v66.LevelReq > 0 then
            u13.Text = "Item Level: " .. v66.LevelReq;
            u13.Visible = true;
        else
            u13.Visible = false;
        end;
    end;

    if u14 then
        u14.Text = "Rarity: " .. v66.Rarity;
        u14.Visible = true;
        local v68 = RarityColors[v66.Rarity];

        if v68 then
            u14.TextColor3 = v68.TextColor3 or Color3.new(1, 1, 1);
        end;
    end;

    if u15 then
        if v66.IsIdentified and v66.StatLines then
            u15.Visible = true;
            PopulateStatInfo(u15, v66);

            return;
        end;

        u15.Visible = false;
    end;
end;

u31 = function(p69: string) -- Line: 564
    -- upvalues: u19 (ref), u6 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), UpdateItemInfo (copy)
    if u19 ~= p69 then
        u19 = p69;
        UpdateItemInfo(p69);

        return;
    end;

    u19 = nil;

    if not u6 then
        return;
    end;

    u6.Visible = false;

    if u10 then
        u10.Text = "";
    end;

    if u11 then
        u11.Image = "";
        u11.Visible = false;
    end;

    if u12 then
        u12.Visible = false;
    end;

    if u13 then
        u13.Text = "";
        u13.Visible = false;
    end;

    if u14 then
        u14.Text = "";
        u14.Visible = false;
    end;

    if u15 then
        u15.Visible = false;
    end;
end;

local function RefreshBody() -- Line: 579
    -- upvalues: u18 (ref), u29 (ref), BuildItemList (copy), u24 (copy), u23 (copy), CreateBodyTemplate (copy), UpdateBodyTemplate (copy), MatchesFilter (copy), u19 (ref), UpdateItemInfo (copy), u6 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref)
    if not u18 then
        return;
    end;

    if not u29 then
        return;
    end;

    local v70 = BuildItemList();
    local v71 = {};

    for _, v in v70 do
        v71[v.GUID] = true;
    end;

    for i, v in u24 do
        if not v71[i] then
            v:Destroy();
            u24[i] = nil;
            u23[i] = nil;
        end;
    end;

    for _, v in v70 do
        local GUID = v.GUID;
        u23[GUID] = v;

        if u24[GUID] then
            UpdateBodyTemplate(u24[GUID], v);
        else
            CreateBodyTemplate(v);
        end;

        local v72 = u24[GUID];

        if v72 then
            v72.Visible = MatchesFilter(v);
        end;
    end;

    if u19 then
        if u23[u19] then
            UpdateItemInfo(u19);

            return;
        end;

        u19 = nil;

        if not u6 then
            return;
        end;

        u6.Visible = false;

        if u10 then
            u10.Text = "";
        end;

        if u11 then
            u11.Image = "";
            u11.Visible = false;
        end;

        if u12 then
            u12.Visible = false;
        end;

        if u13 then
            u13.Text = "";
            u13.Visible = false;
        end;

        if u14 then
            u14.Text = "";
            u14.Visible = false;
        end;

        if u15 then
            u15.Visible = false;
        end;
    end;
end;

local function OnIdentifySingle() -- Line: 633
    -- upvalues: u19 (ref), u25 (ref), u22 (copy), u26 (ref), RefreshBody (copy), u23 (copy), UpdateItemInfo (copy), u27 (ref)
    if not u19 then
        return;
    end;

    if not u25 then
        return;
    end;

    if u22[u19] then
        return;
    end;

    local u73 = u19;
    task.spawn(function() -- Line: 642
        -- upvalues: u25 (ref), u73 (copy), u22 (ref), u26 (ref), RefreshBody (ref), u23 (ref), u19 (ref), UpdateItemInfo (ref), u27 (ref)
        local v74, v75, v76 = u25:CollectSingle(u73):await();

        if not v74 then
            return;
        end;

        if v75 and type(v76) == "table" then
            u22[u73] = true;

            if u26 then
                pcall(function() -- Line: 652
                    -- upvalues: u26 (ref)
                    u26:Play("Ting");
                end);
            end;

            RefreshBody();

            if u23[u73] then
                u19 = u73;
                UpdateItemInfo(u73);
            end;
        elseif not v75 and (v76 == "InventoryFull" and u27) then
            u27:Show("IDENTIFY_INVENTORY_FULL");
        end;
    end);
end;

local function OnIdentifyAll() -- Line: 674
    -- upvalues: u25 (ref), u22 (copy), u26 (ref), RefreshBody (copy), u19 (ref), u23 (copy), UpdateItemInfo (copy), u29 (ref), u27 (ref)
    if not u25 then
        return;
    end;

    task.spawn(function() -- Line: 677
        -- upvalues: u25 (ref), u22 (ref), u26 (ref), RefreshBody (ref), u19 (ref), u23 (ref), UpdateItemInfo (ref), u29 (ref), u27 (ref)
        local v77, v78, v79 = u25:CollectAll():await();

        if not v77 then
            return;
        end;

        if v78 and type(v79) == "table" then
            for _, v in v79 do
                if type(v) == "table" and v.GUID then
                    u22[v.GUID] = true;
                end;
            end;

            if u26 then
                pcall(function() -- Line: 691
                    -- upvalues: u26 (ref)
                    u26:Play("Ting");
                end);
            end;

            RefreshBody();

            if u19 and u23[u19] then
                UpdateItemInfo(u19);
            end;

            local v80 = u29 and u29.Data.LootStorage;

            if v80 and (#v80 > 0 and u27) then
                u27:Show("IDENTIFY_INVENTORY_FULL");
            end;
        elseif not v78 and (v79 == "InventoryFull" and u27) then
            u27:Show("IDENTIFY_INVENTORY_FULL");
        end;
    end);
end;

local function OnClose() -- Line: 722
    -- upvalues: u18 (ref), u24 (copy), u23 (copy), u22 (copy), u19 (ref), u6 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref)
    u18 = false;

    for _, v in u24 do
        v:Destroy();
    end;

    table.clear(u24);
    table.clear(u23);
    table.clear(u22);
    u19 = nil;

    if not u6 then
        return;
    end;

    u6.Visible = false;

    if u10 then
        u10.Text = "";
    end;

    if u11 then
        u11.Image = "";
        u11.Visible = false;
    end;

    if u12 then
        u12.Visible = false;
    end;

    if u13 then
        u13.Text = "";
        u13.Visible = false;
    end;

    if u14 then
        u14.Text = "";
        u14.Visible = false;
    end;

    if u15 then
        u15.Visible = false;
    end;
end;

function v2.Open(p81) -- Line: 740
    -- upvalues: u18 (ref), u3 (ref), u30 (ref), u28 (ref), u22 (copy), RefreshBody (copy)
    if u18 then
        return;
    end;

    if not u3 then
        warn("[IdentifierController] Open() aborted — identifierUI is nil");

        return;
    end;

    if u30 then
        u30 = false;

        if u28 then
            u28:HideGuidePointer();
        end;
    end;

    table.clear(u22);
    u3:open();
    u18 = true;
    RefreshBody();
end;

function v2.Close(p82) -- Line: 761
    -- upvalues: u18 (ref), u3 (ref)
    if not u18 then
        return;
    end;

    if not u3 then
        return;
    end;

    u3:close();
end;

function v2.Toggle(p83) -- Line: 770
    -- upvalues: u18 (ref)
    if u18 then
        p83:Close();

        return;
    end;

    p83:Open();
end;

function v2.IsOpen(p84) -- Line: 779
    -- upvalues: u18 (ref)
    return u18;
end;

local function SetupFilters() -- Line: 785
    -- upvalues: u7 (ref), u1 (copy), u20 (ref), u24 (copy), u23 (copy), MatchesFilter (copy)
    if not u7 then
        return;
    end;

    local Filters = u7:FindFirstChild("Filters");

    if not Filters then
        return;
    end;

    for _, child in Filters:GetChildren() do
        if child:IsA("Frame") or child:IsA("TextButton") then
            local Name = child.Name;

            if u1[Name] == nil and Name ~= "All" then
                child.Visible = false;
            else
                local Button = child:FindFirstChild("Button");

                if Button then
                    local v85 = child:FindFirstChildOfClass("UIStroke");

                    if v85 then
                        v85 = v85:FindFirstChildOfClass("UIGradient");
                    end;

                    if v85 then
                        v85.Enabled = Name == "All";
                    end;

                    Button.MouseButton1Click:Connect(function() -- Line: 814
                        -- upvalues: u20 (ref), Name (copy), Filters (copy), u24 (ref), u23 (ref), MatchesFilter (ref)
                        u20 = Name;

                        for _, child2 in Filters:GetChildren() do
                            if (child2:IsA("Frame") or child2:IsA("TextButton")) and child2.Visible then
                                local v86 = child2:FindFirstChildOfClass("UIStroke");

                                if v86 then
                                    v86 = v86:FindFirstChildOfClass("UIGradient");
                                end;

                                if v86 then
                                    v86.Enabled = child2.Name == Name;
                                end;
                            end;
                        end;

                        for i, v in u24 do
                            local v87 = u23[i];

                            if v87 then
                                v.Visible = MatchesFilter(v87);
                            end;
                        end;
                    end);
                end;
            end;
        end;
    end;
end;

local function SetupSearch() -- Line: 833
    -- upvalues: u7 (ref), u21 (ref), u24 (copy), u23 (copy), MatchesFilter (copy)
    if not u7 then
        return;
    end;

    local Search = u7:FindFirstChild("Search");

    if not Search then
        return;
    end;

    local u88 = Search:FindFirstChildOfClass("TextBox");

    if not u88 then
        return;
    end;

    u88:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 842
        -- upvalues: u21 (ref), u88 (copy), u24 (ref), u23 (ref), MatchesFilter (ref)
        u21 = u88.Text;

        for i, v in u24 do
            local v89 = u23[i];

            if v89 then
                v.Visible = MatchesFilter(v89);
            end;
        end;
    end);
end;

function v2.KnitInit(p90) -- Line: 850
    -- upvalues: Knit (copy), u4 (ref), u3 (ref), UIController (copy), OnClose (copy), u5 (ref), u8 (ref), u6 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u7 (ref), u16 (ref), u19 (ref), u25 (ref), u22 (copy), u26 (ref), RefreshBody (copy), u23 (copy), UpdateItemInfo (copy), u27 (ref), u17 (ref), u29 (ref), SetupFilters (copy), SetupSearch (copy)
    u4 = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("Frames"):FindFirstChild("Identifier");

    if not u4 then
        warn("[IdentifierController] Identifier frame not found in Main.Frames");

        return;
    end;

    u4.Visible = false;
    u3 = UIController._cached[u4] or UIController.new(u4);
    u3.onClose = OnClose;
    u5 = u4:FindFirstChild("Body");
    u8 = u5 and u5:FindFirstChild("Item_Template");

    if u8 then
        u8.Visible = false;
    end;

    u6 = u4:FindFirstChild("Item_Info");

    if u6 then
        u9 = u6:FindFirstChild("Item_Frame");

        if u9 then
            u10 = u9:FindFirstChild("Item_Name");
            u11 = u9:FindFirstChild("ItemImage");
        end;

        u12 = u6:FindFirstChild("Status");
        u13 = u6:FindFirstChild("Item_Level");
        u14 = u6:FindFirstChild("Rarity");
        u15 = u6:FindFirstChild("Stat_Info");
    end;

    u7 = u4:FindFirstChild("Top_Bar");
    local Identify_Single = u4:FindFirstChild("Identify_Single");
    u16 = Identify_Single and (Identify_Single:FindFirstChildOfClass("ImageButton") or Identify_Single:FindFirstChildOfClass("TextButton"));

    if u16 then
        u16.MouseButton1Click:Connect(function() -- Line: 903
            -- upvalues: u19 (ref), u25 (ref), u22 (ref), u26 (ref), RefreshBody (ref), u23 (ref), UpdateItemInfo (ref), u27 (ref)
            if not u19 then
                return;
            end;

            if not u25 then
                return;
            end;

            if u22[u19] then
                return;
            end;

            local u91 = u19;
            task.spawn(function() -- Line: 642
                -- upvalues: u25 (ref), u91 (copy), u22 (ref), u26 (ref), RefreshBody (ref), u23 (ref), u19 (ref), UpdateItemInfo (ref), u27 (ref)
                local v92, v93, v94 = u25:CollectSingle(u91):await();

                if not v92 then
                    return;
                end;

                if v93 and type(v94) == "table" then
                    u22[u91] = true;

                    if u26 then
                        pcall(function() -- Line: 652
                            -- upvalues: u26 (ref)
                            u26:Play("Ting");
                        end);
                    end;

                    RefreshBody();

                    if u23[u91] then
                        u19 = u91;
                        UpdateItemInfo(u91);
                    end;
                elseif not v93 and (v94 == "InventoryFull" and u27) then
                    u27:Show("IDENTIFY_INVENTORY_FULL");
                end;
            end);
        end);
    end;

    local Identify_All = u4:FindFirstChild("Identify_All");
    u17 = Identify_All and (Identify_All:FindFirstChildOfClass("ImageButton") or Identify_All:FindFirstChildOfClass("TextButton"));

    if u17 then
        u17.MouseButton1Click:Connect(function() -- Line: 914
            -- upvalues: u25 (ref), u22 (ref), u26 (ref), RefreshBody (ref), u19 (ref), u23 (ref), UpdateItemInfo (ref), u29 (ref), u27 (ref)
            if not u25 then
                return;
            end;

            task.spawn(function() -- Line: 677
                -- upvalues: u25 (ref), u22 (ref), u26 (ref), RefreshBody (ref), u19 (ref), u23 (ref), UpdateItemInfo (ref), u29 (ref), u27 (ref)
                local v95, v96, v97 = u25:CollectAll():await();

                if not v95 then
                    return;
                end;

                if v96 and type(v97) == "table" then
                    for _, v in v97 do
                        if type(v) == "table" and v.GUID then
                            u22[v.GUID] = true;
                        end;
                    end;

                    if u26 then
                        pcall(function() -- Line: 691
                            -- upvalues: u26 (ref)
                            u26:Play("Ting");
                        end);
                    end;

                    RefreshBody();

                    if u19 and u23[u19] then
                        UpdateItemInfo(u19);
                    end;

                    local v98 = u29 and u29.Data.LootStorage;

                    if v98 and (#v98 > 0 and u27) then
                        u27:Show("IDENTIFY_INVENTORY_FULL");
                    end;
                elseif not v96 and (v97 == "InventoryFull" and u27) then
                    u27:Show("IDENTIFY_INVENTORY_FULL");
                end;
            end);
        end);
    end;

    local Exit = u4:FindFirstChild("Exit");

    if Exit then
        Exit.MouseButton1Click:Connect(function() -- Line: 923
            -- upvalues: u3 (ref)
            if u3 then
                u3:close();
            end;
        end);
    end;

    SetupFilters();
    SetupSearch();

    if not u6 then
        return;
    end;

    u6.Visible = false;

    if u10 then
        u10.Text = "";
    end;

    if u11 then
        u11.Image = "";
        u11.Visible = false;
    end;

    if u12 then
        u12.Visible = false;
    end;

    if u13 then
        u13.Text = "";
        u13.Visible = false;
    end;

    if u14 then
        u14.Text = "";
        u14.Visible = false;
    end;

    if u15 then
        u15.Visible = false;
    end;
end;

function v2.KnitStart(u99) -- Line: 938
    -- upvalues: u29 (ref), Registry (copy), u26 (ref), Knit (copy), u27 (ref), u28 (ref), u25 (ref), u18 (ref), RefreshBody (copy), ShowIdentifyPointer (copy), u30 (ref)
    u29 = Registry:Get("PlayerData");
    pcall(function() -- Line: 943
        -- upvalues: u26 (ref), Knit (ref)
        u26 = Knit.GetController("SoundController");
    end);
    pcall(function() -- Line: 946
        -- upvalues: u27 (ref), Knit (ref)
        u27 = Knit.GetController("NotificationController");
    end);
    pcall(function() -- Line: 949
        -- upvalues: u28 (ref), Knit (ref)
        u28 = Knit.GetController("DialogueController");
    end);
    local success, result = pcall(function() -- Line: 953
        -- upvalues: Knit (ref)
        return Knit.GetService("EquipmentService");
    end);

    if success and result then
        u25 = result;
    else
        warn("[IdentifierController] EquipmentService not available");
    end;

    if u29 then
        u29:OnChange(function(p100, p101) -- Line: 964
            -- upvalues: u18 (ref), RefreshBody (ref), u29 (ref), ShowIdentifyPointer (ref), u30 (ref), u28 (ref)
            local v102 = p101[1];

            if u18 and (v102 == "LootStorage" or v102 == "EquipmentInventory") then
                RefreshBody();
            end;

            if v102 == "LootStorage" and ((u29.Data.PlayerLevel or 1) < 10 and not u18) then
                local LootStorage = u29.Data.LootStorage;

                if LootStorage and #LootStorage > 0 then
                    ShowIdentifyPointer();

                    return;
                end;

                if not u30 then
                    return;
                end;

                u30 = false;

                if u28 then
                    u28:HideGuidePointer();
                end;
            end;
        end);

        if (u29.Data.PlayerLevel or 1) < 10 then
            local LootStorage = u29.Data.LootStorage;

            if LootStorage and #LootStorage > 0 then
                ShowIdentifyPointer();
            end;
        end;
    end;

    task.spawn(function() -- Line: 997
        -- upvalues: u99 (copy)
        local v103 = workspace:WaitForChild("Prompts"):WaitForChild("Identifier"):FindFirstChildOfClass("ProximityPrompt");

        if not v103 then
            warn("[IdentifierController] No ProximityPrompt found inside workspace.Prompts.Identifier");

            return;
        end;

        v103.PromptShown:Connect(function() -- Line: 1005
            -- upvalues: u99 (ref)
            u99:Open();
        end);
        v103.PromptHidden:Connect(function() -- Line: 1008
            -- upvalues: u99 (ref)
            u99:Close();
        end);
        v103.Triggered:Connect(function() -- Line: 1011
            -- upvalues: u99 (ref)
            u99:Toggle();
        end);
    end);
end;

return v2;