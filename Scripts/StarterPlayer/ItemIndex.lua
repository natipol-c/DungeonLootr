--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ItemIndex
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.ItemIndex
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UIController = require(script.Parent.Parent.Controllers.UIController);
local ItemIndexData = require(ReplicatedStorage.GameInfo.ItemIndexData);
local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
local RarityGradient = require(ReplicatedStorage.Modules.RarityGradient);
local u1 = {};
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
local u14 = {};
local u15 = {};
local u16 = "All";
local u17 = nil;
local Color3_fromRGB_ret = Color3.fromRGB(255, 210, 70);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 255, 255);

local function RarityTextColor(p18: string?) -- Line: 72
    -- upvalues: RarityColors (copy)
    local v19 = p18 and RarityColors[p18] or nil;

    return v19 and v19.TextColor3 or Color3.fromRGB(255, 255, 255);
end;

local function SetCardSelected(p20: userdata?, p21: boolean) -- Line: 79
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
    if not p20 then
        return;
    end;

    local Background = p20:FindFirstChild("Background");

    if Background then
        Background = Background:FindFirstChildOfClass("UIStroke");
    end;

    if Background then
        Background.Color = p21 and Color3_fromRGB_ret or Color3_fromRGB_ret2;
        Background.Transparency = p21 and 0 or 0.5;
    end;
end;

local function FillCard(p22: userdata, p23: any) -- Line: 93
    -- upvalues: RarityGradient (copy), Color3_fromRGB_ret2 (copy)
    p22.Name = p23.Id;
    p22.Visible = true;
    p22.LayoutOrder = p23.LayoutOrder;
    local ViewportFrame = p22:FindFirstChild("ViewportFrame");

    if ViewportFrame then
        ViewportFrame.Visible = false;
    end;

    local ItemImage = p22:FindFirstChild("ItemImage");

    if ItemImage then
        local Icon = p23.Icon;

        if Icon and (Icon ~= "" and Icon ~= "rbxassetid://0") then
            ItemImage.Image = Icon;
            ItemImage.Visible = true;
        else
            ItemImage.Visible = false;
        end;
    end;

    local Item_Name = p22:FindFirstChild("Item_Name");

    if Item_Name then
        Item_Name.Text = p23.Name;
        Item_Name.TextColor3 = Color3.new(1, 1, 1);
        RarityGradient.set(Item_Name, p23.Rarity, 90);
    end;

    local ColorFrame = p22:FindFirstChild("ColorFrame");

    if ColorFrame then
        RarityGradient.set(ColorFrame, p23.Rarity);
    end;

    for _, v in { "Amount", "Item_Level", "Item_Tier", "Equipped", "Forge_Level", "Lock_Image", "Delete_Cover" } do
        local v24 = p22:FindFirstChild(v);

        if v24 then
            v24.Visible = false;
        end;
    end;

    if not p22 then
        return;
    end;

    local Background = p22:FindFirstChild("Background");

    if Background then
        Background = Background:FindFirstChildOfClass("UIStroke");
    end;

    if Background then
        Background.Color = Color3_fromRGB_ret2;
        Background.Transparency = 0.5;
    end;
end;

local function BuildCards() -- Line: 136
    -- upvalues: ItemIndexData (copy), u6 (ref), FillCard (copy), u1 (copy), u5 (ref), u14 (copy)
    for _, v in ItemIndexData.GetByTab("All") do
        local v25 = ItemIndexData.Resolve(v);

        if v25 then
            local v26 = u6:Clone();
            FillCard(v26, v25);
            local Selection_Button = v26:FindFirstChild("Selection_Button");

            if Selection_Button and Selection_Button:IsA("GuiButton") then
                Selection_Button.Visible = true;
                Selection_Button.MouseButton1Click:Connect(function() -- Line: 148
                    -- upvalues: u1 (ref), v (copy)
                    u1.Select(v);
                end);
            end;

            v26.Parent = u5;
            u14[v] = v26;
        end;
    end;
end;

local function SetTabButtonSelected(p27: userdata?, p28: boolean) -- Line: 161
    if not p27 then
        return;
    end;

    local Active = p27:FindFirstChild("Active");
    local Inactive = p27:FindFirstChild("Inactive");

    if Active then
        Active.Visible = p28;
    end;

    if Inactive then
        Inactive.Visible = not p28;
    end;
end;

local function ApplyTabFilter() -- Line: 171
    -- upvalues: u14 (copy), ItemIndexData (copy), u16 (ref), u15 (copy)
    for i, v in u14 do
        local v29 = ItemIndexData.Get(i);

        if u16 == "All" then
            v29 = true;
        elseif v29 then
            v29 = v29.Tab == u16;
        end;

        v.Visible = v29;
    end;

    for i, v in u15 do
        local v30 = i == u16;

        if v then
            local Active = v:FindFirstChild("Active");
            local Inactive = v:FindFirstChild("Inactive");

            if Active then
                Active.Visible = v30;
            end;

            if Inactive then
                Inactive.Visible = not v30;
            end;
        end;
    end;
end;

local function SetTab(p31: string) -- Line: 182
    -- upvalues: u16 (ref), ApplyTabFilter (copy)
    u16 = p31;
    ApplyTabFilter();
end;

local function ScrollToCard(u32: userdata) -- Line: 190
    -- upvalues: u5 (ref)
    if not (u32 and u32.Visible) then
        return;
    end;

    if pcall(function() -- Line: 192
        -- upvalues: u32 (copy), u5 (ref)
        local v33 = u32.AbsolutePosition.Y - u5.AbsolutePosition.Y + u5.CanvasPosition.Y - (u5.AbsoluteWindowSize.Y - u32.AbsoluteSize.Y) * 0.5;
        local math_max_ret = math.max(0, u5.AbsoluteCanvasSize.Y - u5.AbsoluteWindowSize.Y);
        u5.CanvasPosition = Vector2.new(0, (math.clamp(v33, 0, math_max_ret)));
    end) then
    end;
end;

function u1.Select(p34: string) -- Line: 203
    -- upvalues: ItemIndexData (copy), u17 (ref), u14 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), u8 (ref), RarityGradient (copy), u9 (ref), u10 (ref), RarityColors (copy), u11 (ref), u12 (ref), u13 (ref)
    local v35 = ItemIndexData.Resolve(p34);

    if not v35 then
        return false;
    end;

    local v36 = u17 and u14[u17] and u14[u17];

    if v36 then
        local Background = v36:FindFirstChild("Background");

        if Background then
            Background = Background:FindFirstChildOfClass("UIStroke");
        end;

        if Background then
            Background.Color = Color3_fromRGB_ret2;
            Background.Transparency = 0.5;
        end;
    end;

    u17 = p34;
    local v37 = u14[p34];

    if v37 and v37 then
        local Background = v37:FindFirstChild("Background");

        if Background then
            Background = Background:FindFirstChildOfClass("UIStroke");
        end;

        if Background then
            Background.Color = Color3_fromRGB_ret or Color3_fromRGB_ret2;
            Background.Transparency = 0;
        end;
    end;

    if u8 then
        u8.Text = v35.Name;
        u8.TextColor3 = Color3.new(1, 1, 1);
        RarityGradient.set(u8, v35.Rarity);
    end;

    if u9 then
        local Icon = v35.Icon;

        if Icon and (Icon ~= "" and Icon ~= "rbxassetid://0") then
            u9.Image = Icon;
            u9.Visible = true;
        else
            u9.Visible = false;
        end;
    end;

    if u10 then
        u10.Text = v35.Rarity;
        local Rarity = v35.Rarity;
        local v38 = Rarity and RarityColors[Rarity] or nil;
        u10.TextColor3 = v38 and v38.TextColor3 or Color3.fromRGB(255, 255, 255);
    end;

    if u11 then
        u11.Text = v35.Description;
    end;

    if u12 then
        u12.Text = v35.Obtain;
    end;

    if u13 then
        RarityGradient.set(u13, v35.Rarity);
    end;

    return true;
end;

function u1.Open(p39) -- Line: 249
    -- upvalues: u4 (ref), u2 (ref), UIController (copy)
    local v40 = p39 or {};

    if not u4 then
        return;
    end;

    local onReturn = v40.onReturn;
    local returnTo = v40.returnTo;
    u4.onClose = nil;

    if onReturn or returnTo then
        function u4.onClose() -- Line: 259
            -- upvalues: u4 (ref), onReturn (copy), u2 (ref), returnTo (copy), UIController (ref)
            u4.onClose = nil;
            task.defer(function() -- Line: 263
                -- upvalues: onReturn (ref), u2 (ref), returnTo (ref), UIController (ref)
                if onReturn then
                    onReturn();

                    return;
                end;

                local v41 = u2.Frames:FindFirstChild(returnTo);

                if not v41 then
                    return;
                end;

                local v42 = UIController.getByName(returnTo) or UIController.new(v41);

                if v42 then
                    v42:open();
                end;
            end);
        end;
    end;

    if v40.hideOnOpen then
        v40.hideOnOpen.Visible = false;
    end;

    u4:open();
end;

function u1.OpenToItem(p43: string, p44: any) -- Line: 286
    -- upvalues: u1 (copy), ItemIndexData (copy), u4 (ref), u16 (ref), ApplyTabFilter (copy), u14 (copy), u5 (ref)
    u1.Open(p44);
    local v45 = ItemIndexData.Get(p43);

    if not v45 then
        u4.onClose = nil;

        return false;
    end;

    u16 = v45.Tab;
    ApplyTabFilter();
    u1.Select(p43);
    local u46 = u14[p43];

    if u46 and (u46 and u46.Visible) then
        pcall(function() -- Line: 192
            -- upvalues: u46 (copy), u5 (ref)
            local v47 = u46.AbsolutePosition.Y - u5.AbsolutePosition.Y + u5.CanvasPosition.Y - (u5.AbsoluteWindowSize.Y - u46.AbsoluteSize.Y) * 0.5;
            local math_max_ret = math.max(0, u5.AbsoluteCanvasSize.Y - u5.AbsoluteWindowSize.Y);
            u5.CanvasPosition = Vector2.new(0, (math.clamp(v47, 0, math_max_ret)));
        end);
    end;

    return true;
end;

function u1.HasItem(p48: string?) -- Line: 305
    -- upvalues: ItemIndexData (copy)
    local v49;

    if p48 == nil then
        v49 = false;
    else
        v49 = ItemIndexData.Get(p48) ~= nil;
    end;

    return v49;
end;

function u1.BindCard(u50: userdata?, p51: string?, p52: any) -- Line: 325
    -- upvalues: u1 (copy)
    if not u50 then
        return false;
    end;

    local v53 = u1.HasItem(p51);
    u50:SetAttribute("ItemIndexId", v53 and p51 and p51 or nil);

    if not u50:GetAttribute("ItemIndexBound") then
        local v54 = p52;
        local u55 = type(v54) == "string" and {
            returnTo = v54
        } or v54 or {};
        local v56;

        if u50:IsA("GuiButton") then
            v56 = u50;
        else
            v56 = u50:FindFirstChild("Selection_Button") or u50:FindFirstChild("Button");

            if not (v56 and v56:IsA("GuiButton")) then
                v56 = u50:FindFirstChildWhichIsA("GuiButton");
            end;
        end;

        if not v56 then
            v56 = Instance.new("TextButton");
            v56.Name = "ItemIndex_ClickTarget";
            v56.Text = "";
            v56.BackgroundTransparency = 1;
            v56.AutoButtonColor = false;
            v56.Size = UDim2.fromScale(1, 1);
            v56.ZIndex = 50;
            v56.Parent = u50;
        end;

        u50:SetAttribute("ItemIndexBound", true);
        v56.MouseButton1Click:Connect(function() -- Line: 365
            -- upvalues: u50 (copy), u1 (ref), u55 (ref)
            local Attribute = u50:GetAttribute("ItemIndexId");

            if Attribute then
                u1.OpenToItem(Attribute, u55);
            end;
        end);
    end;

    return v53;
end;

function u1._Init(p57) -- Line: 378
    -- upvalues: u2 (ref), u3 (ref), u7 (ref), u5 (ref), u6 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u4 (ref), UIController (copy), ItemIndexData (copy), u15 (copy), u16 (ref), ApplyTabFilter (copy), BuildCards (copy), u1 (copy)
    u2 = p57;
    u3 = u2.Frames:FindFirstChild("ItemIndex");

    if not u3 then
        warn("[ItemIndex] Frames.ItemIndex missing — panel not initialised.");

        return;
    end;

    local Contents = u3:WaitForChild("Contents");
    local RightSection = Contents:WaitForChild("RightSection");
    u7 = RightSection:WaitForChild("Tabs");
    u5 = RightSection:WaitForChild("ItemGrid");
    u6 = u5:WaitForChild("TemplateFrame");
    u6.Visible = false;
    local v58 = u5:FindFirstChildOfClass("UIGridLayout");

    if v58 then
        v58.SortOrder = Enum.SortOrder.LayoutOrder;
    end;

    local Profile = Contents:WaitForChild("LeftSection"):WaitForChild("Profile");
    local InfoFrame = Profile:WaitForChild("InfoFrame");
    local Info = InfoFrame:WaitForChild("Info");
    u8 = Profile:FindFirstChild("ItemName");
    u9 = Profile:FindFirstChild("ItemImage");
    local v59 = Info:FindFirstChild("Rarity") and Info.Rarity:FindFirstChild("Info");
    u10 = v59;
    u11 = Info:FindFirstChild("Description");
    u12 = Info:FindFirstChild("Obtain");
    u13 = InfoFrame:FindFirstChild("ColorFrame");
    u3.Visible = false;
    u4 = UIController._cached[u3] or UIController.new(u3);
    local Exit = u3:FindFirstChild("Exit");

    if Exit and Exit:IsA("GuiButton") then
        Exit.MouseButton1Click:Connect(function() -- Line: 415
            -- upvalues: u4 (ref)
            u4:close();
        end);
    end;

    local Inventory = u3:FindFirstChild("Inventory");

    if Inventory and Inventory:IsA("GuiButton") then
        Inventory.Activated:Connect(function() -- Line: 424
            -- upvalues: u4 (ref), u2 (ref), UIController (ref)
            u4.onClose = nil;
            local Inventory2 = u2.Frames:FindFirstChild("Inventory");
            local ByName = UIController.getByName("Inventory");

            if ByName then
                Inventory2 = ByName;
            elseif Inventory2 then
                Inventory2 = UIController.new(Inventory2);
            end;

            if Inventory2 then
                Inventory2:open();
            end;
        end);
    end;

    for _, v in ItemIndexData.Tabs do
        local v60 = u7:FindFirstChild(v);

        if v60 and v60:IsA("GuiButton") then
            u15[v] = v60;
            v60.MouseButton1Click:Connect(function() -- Line: 437
                -- upvalues: v (copy), u16 (ref), ApplyTabFilter (ref)
                u16 = v;
                ApplyTabFilter();
            end);
        end;
    end;

    BuildCards();
    u16 = "All";
    ApplyTabFilter();
    local ByTab = ItemIndexData.GetByTab("All");

    if ByTab[1] then
        u1.Select(ByTab[1]);
    end;
end;

return u1;