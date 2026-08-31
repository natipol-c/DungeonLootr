--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     TitleIndex
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.TitleIndex
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local UIController = require(script.Parent.Parent.Controllers.UIController);
local TitleData = require(ReplicatedStorage.GameInfo.TitleData);
local RarityData = require(ReplicatedStorage.GameInfo.RarityData);
local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
local Image_Data = require(ReplicatedStorage.GameInfo.Image_Data);
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
local u22 = nil;

local function GetTitleService() -- Line: 79
    -- upvalues: u22 (ref), Knit (copy)
    if not u22 then
        u22 = Knit.GetService("TitleService");
    end;

    return u22;
end;

local u23 = {};
local u24 = {};
local u25 = nil;
local u26 = "All";
local u27 = { "STR", "DEX", "VIT", "INT", "LCK" };
local Color3_fromRGB_ret = Color3.fromRGB(100, 255, 100);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 80, 80);
local Color3_fromRGB_ret3 = Color3.fromRGB(85, 255, 0);
local Color3_fromRGB_ret4 = Color3.fromRGB(255, 60, 60);
local Color3_fromRGB_ret5 = Color3.fromRGB(85, 255, 85);
local Color3_fromRGB_ret6 = Color3.fromRGB(255, 70, 70);

local function ApplyTitleStyle(p28: userdata, p29: any) -- Line: 112
    p28.TextColor3 = p29.Color;
    local v30 = p28:FindFirstChildOfClass("UIStroke");

    if not v30 then
        v30 = Instance.new("UIStroke");
        v30.Parent = p28;
    end;

    v30.Color = p29.StrokeColor or Color3.fromRGB(0, 0, 0);
    v30.Transparency = p29.StrokeTransparency or 0;
    local v31 = p28:FindFirstChildOfClass("UIGradient");

    if not p29.ColorSequence then
        if v31 then
            v31.Enabled = false;
        end;

        return;
    end;

    if not v31 then
        v31 = Instance.new("UIGradient");
        v31.Parent = p28;
    end;

    v31.Color = p29.ColorSequence;
    v31.Rotation = p29.GradientRotation or 0;
    v31.Enabled = true;
end;

local function RarityColorFor(p32: string, p33: any) -- Line: 142
    -- upvalues: RarityColors (copy)
    local v34 = RarityColors[p32];

    if v34 and v34.TextColor3 then
        return v34.TextColor3;
    end;

    return p33 and p33.Color or Color3.fromRGB(255, 255, 255);
end;

local function GetDisplayText(p35: string, p36: any) -- Line: 153
    -- upvalues: u3 (ref)
    local Text = p36.Text;

    if p36.Dynamic and u3 then
        local v37 = u3.Data[p36.Dynamic] or 0;

        if v37 > 0 then
            Text = p36.Text .. " #" .. v37;
        end;
    end;

    return Text;
end;

local function IsOwned(p38: string) -- Line: 165
    -- upvalues: u3 (ref)
    return table.find(u3.Data.UnlockedTitles, p38) ~= nil;
end;

local function ClearStatClones() -- Line: 173
    -- upvalues: u24 (copy)
    for _, v in u24 do
        v:Destroy();
    end;

    table.clear(u24);
end;

local function PopulateTitleStatInfo() -- Line: 181
    -- upvalues: u24 (copy), u25 (ref), TitleData (copy), u10 (ref), Color3_fromRGB_ret2 (copy), u9 (ref), u27 (copy), Color3_fromRGB_ret (copy)
    for _, v in u24 do
        v:Destroy();
    end;

    table.clear(u24);

    if not u25 then
        return;
    end;

    local v39 = TitleData.Titles[u25];

    if not v39 then
        return;
    end;

    local StatBuffs = v39.StatBuffs;

    if StatBuffs and next(StatBuffs) then
        local v40 = 0;

        for _, v in u27 do
            local v41 = StatBuffs[v];

            if v41 ~= nil then
                v40 = v40 + 1;
                local v42 = u10:Clone();
                v42.Text = "+" .. v41 .. " " .. v;
                v42.TextColor3 = Color3_fromRGB_ret;
                v42.LayoutOrder = v40;
                v42.Visible = true;
                v42.Parent = u9;
                table.insert(u24, v42);
            end;
        end;

        return;
    end;

    local v43 = u10:Clone();
    v43.Text = "None";
    v43.TextColor3 = Color3_fromRGB_ret2;
    v43.LayoutOrder = 1;
    v43.Visible = true;
    v43.Parent = u9;
    table.insert(u24, v43);
end;

local function RefreshButtons() -- Line: 227
    -- upvalues: u16 (ref), u18 (ref), u25 (ref), u11 (ref), u12 (ref), u14 (ref), u13 (ref), u15 (ref), TitleData (copy), u3 (ref), u17 (ref), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy)
    local function SetChatTagVisible(p44: boolean) -- Line: 229
        -- upvalues: u16 (ref), u18 (ref)
        u16.Visible = p44;

        if u18 then
            u18.Visible = p44;
        end;
    end;

    if not u25 then
        u11.Visible = false;
        u12.Visible = true;
        u14.Visible = true;
        u16.Visible = false;

        if u18 then
            u18.Visible = false;
        end;

        u13.Text = "DISPLAY";
        u15.Text = "EQUIP";

        return;
    end;

    local v45 = TitleData.Titles[u25];

    if table.find(u3.Data.UnlockedTitles, u25) == nil then
        u11.Visible = true;
        u12.Visible = false;
        u14.Visible = false;
        u16.Visible = false;

        if u18 then
            u18.Visible = false;
        end;

        return;
    end;

    u11.Visible = false;
    u12.Visible = true;
    u14.Visible = true;
    u13.Text = u3.Data.EquippedTitle == u25 and "UNDISPLAY" or "DISPLAY";
    local v46 = v45 and v45.StatBuffs and next(v45.StatBuffs);
    local v47 = u3.Data.EquippedStatsTitle or "";

    if v46 then
        if v47 == u25 then
            u15.Text = "UNEQUIP";
        else
            u15.Text = "EQUIP";
        end;
    else
        u15.Text = "NO STATS";
    end;

    local v48 = TitleData.IsChatTagEligible(v45);
    u16.Visible = v48;

    if u18 then
        u18.Visible = v48;
    end;

    if v48 then
        if (u3.Data.EquippedChatTagTitle or "") == u25 then
            u17.Text = "ENABLED";
            u17.TextColor3 = Color3_fromRGB_ret3;

            return;
        end;

        u17.Text = "DISABLED";
        u17.TextColor3 = Color3_fromRGB_ret4;
    end;
end;

local function SelectTitle(p49: string) -- Line: 293
    -- upvalues: u25 (ref), TitleData (copy), u6 (ref), u3 (ref), ApplyTitleStyle (copy), u7 (ref), RarityColors (copy), u8 (ref), PopulateTitleStatInfo (copy), RefreshButtons (copy)
    u25 = p49;
    local v50 = TitleData.Titles[p49];

    if not v50 then
        return;
    end;

    local Text = v50.Text;

    if v50.Dynamic and u3 then
        local v51 = u3.Data[v50.Dynamic] or 0;

        if v51 > 0 then
            Text = v50.Text .. " #" .. v51;
        end;
    end;

    u6.Text = Text;
    ApplyTitleStyle(u6, v50);
    u7.Text = v50.Rarity;
    local v52 = RarityColors[v50.Rarity];
    local v53;

    if v52 and v52.TextColor3 then
        v53 = v52.TextColor3;
    else
        v53 = v50 and v50.Color or Color3.fromRGB(255, 255, 255);
    end;

    u7.TextColor3 = v53;
    u8.Text = v50.HowToObtain or "W.I.P";
    PopulateTitleStatInfo();
    RefreshButtons();
end;

local function SetCardOwnedVisual(p54: userdata, p55: boolean) -- Line: 320
    -- upvalues: Image_Data (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret6 (copy)
    local Active = p54:FindFirstChild("Active");
    local InActive = p54:FindFirstChild("InActive");

    if Active then
        Active.Visible = p55;
    end;

    if InActive then
        InActive.Visible = not p55;
    end;

    local Lock = p54:FindFirstChild("Lock");

    if Lock and Lock:IsA("ImageLabel") then
        Lock.Image = p55 and Image_Data.UI.Unlocked or Image_Data.UI.Lock;
        Lock.ImageColor3 = p55 and Color3_fromRGB_ret5 or Color3_fromRGB_ret6;
    end;
end;

local function StyleCardLabels(p56: userdata, p57: string, p58: any) -- Line: 335
    -- upvalues: u3 (ref), ApplyTitleStyle (copy)
    for _, v in { "Active", "InActive" } do
        local v59 = p56:FindFirstChild(v);

        if v59 then
            local TitleName = v59:FindFirstChild("TitleName");

            if TitleName then
                local Text = p58.Text;

                if p58.Dynamic and u3 then
                    local v60 = u3.Data[p58.Dynamic] or 0;

                    if v60 > 0 then
                        Text = p58.Text .. " #" .. v60;
                    end;
                end;

                TitleName.Text = Text;
                ApplyTitleStyle(TitleName, p58);
            end;
        end;
    end;
end;

local function CreateTitleCard(u61: string, p62: any) -- Line: 348
    -- upvalues: u5 (ref), StyleCardLabels (copy), SetCardOwnedVisual (copy), u3 (ref), SelectTitle (copy), RarityData (copy), u4 (ref), u23 (copy)
    local v63 = u5:Clone();
    v63.Name = u61;
    v63.Visible = true;
    StyleCardLabels(v63, u61, p62);
    SetCardOwnedVisual(v63, table.find(u3.Data.UnlockedTitles, u61) ~= nil);
    v63.MouseButton1Click:Connect(function() -- Line: 357
        -- upvalues: SelectTitle (ref), u61 (copy)
        SelectTitle(u61);
    end);
    v63.LayoutOrder = RarityData.RarityIndex[p62.Rarity] or 1000;
    v63.Parent = u4;
    u23[u61] = v63;
end;

local function LoadTitles() -- Line: 370
    -- upvalues: TitleData (copy), u3 (ref), CreateTitleCard (copy)
    for i, v in TitleData.Titles do
        if TitleData.IsIndexVisible(i, table.find(u3.Data.UnlockedTitles, i) ~= nil) then
            CreateTitleCard(i, v);
        end;
    end;
end;

local function RefreshTitleCards() -- Line: 381
    -- upvalues: u23 (copy), SetCardOwnedVisual (copy), u3 (ref)
    for i, v in u23 do
        SetCardOwnedVisual(v, table.find(u3.Data.UnlockedTitles, i) ~= nil);
    end;
end;

local function EnsureVisibleCards() -- Line: 390
    -- upvalues: TitleData (copy), u23 (copy), u3 (ref), CreateTitleCard (copy)
    for i, v in TitleData.Titles do
        if not u23[i] and TitleData.IsIndexVisible(i, table.find(u3.Data.UnlockedTitles, i) ~= nil) then
            CreateTitleCard(i, v);
        end;
    end;
end;

local function SetFilterButtonSelected(p64: userdata?, p65: boolean) -- Line: 402
    if not p64 then
        return;
    end;

    for _, v in { "Background", "Outline" } do
        local v66 = p64:FindFirstChild(v);

        if v66 then
            local Active = v66:FindFirstChild("Active");
            local Inactive = v66:FindFirstChild("Inactive");

            if Active then
                Active.Enabled = p65;
            end;

            if Inactive then
                Inactive.Enabled = not p65;
            end;
        end;
    end;
end;

local function ApplyTitleFilter() -- Line: 417
    -- upvalues: u23 (copy), u26 (ref), u3 (ref), SetFilterButtonSelected (copy), u19 (ref), u20 (ref)
    for i, v in u23 do
        if u26 == "Unlocked" then
            v.Visible = table.find(u3.Data.UnlockedTitles, i) ~= nil;
        elseif u26 == "Locked" then
            v.Visible = table.find(u3.Data.UnlockedTitles, i) == nil;
        else
            v.Visible = true;
        end;
    end;

    SetFilterButtonSelected(u19, u26 == "Unlocked");
    SetFilterButtonSelected(u20, u26 == "Locked");
end;

local function SetTitleFilter(p67: string) -- Line: 433
    -- upvalues: u26 (ref), ApplyTitleFilter (copy)
    u26 = u26 == p67 and "All" or p67;
    ApplyTitleFilter();
end;

function v1._Init(p68) -- Line: 440
    -- upvalues: u2 (ref), u3 (ref), Registry (copy), UIController (copy), u4 (ref), u5 (ref), u19 (ref), u20 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref), u21 (ref), Knit (copy), RefreshButtons (copy), LoadTitles (copy), u26 (ref), ApplyTitleFilter (copy), u25 (ref), u22 (ref), TitleData (copy), EnsureVisibleCards (copy), u23 (copy), SetCardOwnedVisual (copy)
    u2 = p68;
    u3 = Registry:Get("PlayerData");
    local TitleIndex = u2.Frames.TitleIndex;
    local Contents = TitleIndex.Contents;
    local Inventory = TitleIndex:FindFirstChild("Inventory");

    if Inventory and Inventory:IsA("GuiButton") then
        Inventory.Activated:Connect(function() -- Line: 451
            -- upvalues: u2 (ref), UIController (ref)
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

    local Profile = Contents.LeftSection.Profile;
    u4 = Contents.RightSection.Selection;
    u5 = u4:FindFirstChild("Template");
    u5.Visible = false;
    u19 = Contents.RightSection:FindFirstChild("Unlocked");
    u20 = Contents.RightSection:FindFirstChild("Locked");
    u6 = Profile:FindFirstChild("ClassName");
    u7 = Profile.Info.Rarity.Info;
    u8 = Profile.Info.Description.Info;
    u9 = Profile.Stats;
    u10 = u9:FindFirstChild("Template");
    u10.Visible = false;
    local Button = Profile.Button;
    u11 = Button.Locked;
    u12 = Button.Display;
    u13 = u12:FindFirstChild("TextLabel");
    u14 = Button.Equip;
    u15 = u14:FindFirstChild("TextLabel");
    u16 = Button.ChatTag;
    u17 = u16:FindFirstChild("TextLabel");
    u18 = Profile.Info:FindFirstChild("ChatTag");
    u16.Visible = false;

    if u18 then
        u18.Visible = false;
    end;

    pcall(function() -- Line: 490
        -- upvalues: u21 (ref), Knit (ref)
        u21 = Knit.GetController("NotificationController");
    end);
    u6.Text = "Select a title";
    u7.Text = "";
    u8.Text = "";
    RefreshButtons();
    LoadTitles();

    if u19 then
        u19.MouseButton1Click:Connect(function() -- Line: 505
            -- upvalues: u26 (ref), ApplyTitleFilter (ref)
            u26 = u26 == "Unlocked" and "All" or "Unlocked";
            ApplyTitleFilter();
        end);
    end;

    if u20 then
        u20.MouseButton1Click:Connect(function() -- Line: 510
            -- upvalues: u26 (ref), ApplyTitleFilter (ref)
            u26 = u26 == "Locked" and "All" or "Locked";
            ApplyTitleFilter();
        end);
    end;

    ApplyTitleFilter();
    u12.MouseButton1Click:Connect(function() -- Line: 517
        -- upvalues: u25 (ref), u3 (ref), u22 (ref), Knit (ref)
        if not u25 then
            return;
        end;

        if table.find(u3.Data.UnlockedTitles, u25) == nil then
            return;
        end;

        local EquippedTitle = u3.Data.EquippedTitle;

        if not u22 then
            u22 = Knit.GetService("TitleService");
        end;

        local v69 = u22;

        if EquippedTitle == u25 then
            v69:UnequipTitle();

            return;
        end;

        v69:EquipTitle(u25);
    end);
    u14.MouseButton1Click:Connect(function() -- Line: 532
        -- upvalues: u25 (ref), u3 (ref), TitleData (ref), u21 (ref), u22 (ref), Knit (ref)
        if not u25 then
            return;
        end;

        if table.find(u3.Data.UnlockedTitles, u25) == nil then
            return;
        end;

        local v70 = TitleData.Titles[u25];

        if not (v70 and (v70.StatBuffs and next(v70.StatBuffs))) then
            if u21 then
                u21:Show("Custom", "This title has no stats!");
            end;

            return;
        end;

        local v71 = u3.Data.EquippedStatsTitle or "";

        if not u22 then
            u22 = Knit.GetService("TitleService");
        end;

        local v72 = u22;

        if v71 == u25 then
            v72:UnequipStatsTitle();

            return;
        end;

        v72:EquipStatsTitle(u25);
    end);
    u16.MouseButton1Click:Connect(function() -- Line: 555
        -- upvalues: u25 (ref), u3 (ref), TitleData (ref), u22 (ref), Knit (ref)
        if not u25 then
            return;
        end;

        if table.find(u3.Data.UnlockedTitles, u25) == nil then
            return;
        end;

        if not TitleData.IsChatTagEligible(TitleData.Titles[u25]) then
            return;
        end;

        local v73 = u3.Data.EquippedChatTagTitle or "";

        if not u22 then
            u22 = Knit.GetService("TitleService");
        end;

        local v74 = u22;

        if v73 == u25 then
            v74:UnequipChatTag();

            return;
        end;

        v74:EquipChatTag(u25);
    end);
    u11.MouseButton1Click:Connect(function() -- Line: 573
        -- upvalues: u21 (ref)
        if u21 then
            u21:Show("Custom", "You haven\'t unlocked this title yet!");
        end;
    end);
    u3:OnChange(function(p75, p76) -- Line: 580
        -- upvalues: EnsureVisibleCards (ref), u23 (ref), SetCardOwnedVisual (ref), u3 (ref), ApplyTitleFilter (ref), u25 (ref), RefreshButtons (ref)
        local v77 = p76[1];

        if v77 == "UnlockedTitles" or (v77 == "EquippedTitle" or (v77 == "EquippedStatsTitle" or v77 == "EquippedChatTagTitle")) then
            EnsureVisibleCards();

            for i, v in u23 do
                SetCardOwnedVisual(v, table.find(u3.Data.UnlockedTitles, i) ~= nil);
            end;

            ApplyTitleFilter();

            if u25 then
                RefreshButtons();
            end;
        end;
    end);
end;

return v1;