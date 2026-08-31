--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     InventoryStatInfo
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.InventoryStatInfo
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StatInfoData = require(ReplicatedStorage.GameInfo.StatInfoData);
local Class_Data = require(ReplicatedStorage.Classes.Class_Data);
local u1 = {};
local u2 = { "InventorySection", "StatUpgrade", "Loadouts" };
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = {};
local u9 = {};

local function GetRingBonusDamage() -- Line: 66
    -- upvalues: u4 (ref)
    local v10 = u4.Data.Equipment and u4.Data.Equipment.Ring;

    return (type(v10) ~= "table" or not v10.GUID) and 0 or (v10.Stats and (v10.Stats.BonusDamage or 0) or 0) + (v10.ForgeBonuses and v10.ForgeBonuses.BonusDamage or 0);
end;

local function ResolveValue(p11) -- Line: 75
    -- upvalues: u4 (ref), Class_Data (copy), StatInfoData (copy)
    local v12 = u4.Data.ComputedStats or {};
    local v13 = u4.Data.ActiveClass or "";
    local v14;

    if v13 == "" then
        v14 = nil;
    else
        v14 = Class_Data.Get(v13) or nil;
    end;

    local v15 = u4.Data.Equipment and u4.Data.Equipment.Ring;

    return StatInfoData.ResolveValue(p11, v12, v14, (type(v15) ~= "table" or not v15.GUID) and 0 or (v15.Stats and (v15.Stats.BonusDamage or 0) or 0) + (v15.ForgeBonuses and v15.ForgeBonuses.BonusDamage or 0));
end;

function u1.Refresh() -- Line: 88
    -- upvalues: u5 (ref), StatInfoData (copy), u8 (copy), ResolveValue (copy)
    if not u5 then
        return;
    end;

    for _, v in StatInfoData.Entries do
        local v16 = u8[v.Key];

        if v16 and v16.amount then
            local v17, v18 = StatInfoData.ResolveDisplay(v, ResolveValue(v));
            local v19 = StatInfoData.FormatValue(v, v17);

            if v18 then
                v19 = v19 .. " <font color=\"#FFD75A\">(MAX)</font>" or v19;
            end;

            v16.amount.Text = v19;
        end;
    end;
end;

local function BuildRows() -- Line: 106
    -- upvalues: u6 (ref), u7 (ref), StatInfoData (copy), u8 (copy)
    if not (u6 and u7) then
        return;
    end;

    for i, v in StatInfoData.Entries do
        local v20 = StatInfoData.Get(v);
        local v21 = u7:Clone();
        v21.Name = "Stat_" .. v.Key;
        v21.LayoutOrder = i;
        v21.Visible = true;
        local Title = v21:FindFirstChild("Title");

        if Title then
            Title.Text = v20.DisplayName;
        end;

        local Info = v21:FindFirstChild("Info");

        if Info then
            Info.RichText = true;
            Info.Text = v20.Description;
        end;

        local Amount = v21:FindFirstChild("Amount");

        if Amount then
            Amount.RichText = true;
        end;

        v21.Parent = u6;
        u8[v.Key] = {
            frame = v21,
            amount = Amount
        };
    end;
end;

local function ShowStatInfo() -- Line: 140
    -- upvalues: u5 (ref), u3 (ref), u2 (copy), u1 (copy)
    if not u5 then
        return;
    end;

    u3.OnPanelOpened();

    if u3.ContentsFrame then
        for _, v in u2 do
            local v22 = u3.ContentsFrame:FindFirstChild(v);

            if v22 then
                v22.Visible = false;
            end;
        end;
    end;

    u5.Visible = true;
    u1.Refresh();
end;

local function ShowEquipmentView() -- Line: 157
    -- upvalues: u5 (ref), u3 (ref)
    if not u5 then
        return;
    end;

    u5.Visible = false;

    if u3.InvSectionFrame then
        u3.InvSectionFrame.Visible = true;
    end;
end;

u1.ShowEquipmentView = ShowEquipmentView;

local function ToggleStatInfo() -- Line: 165
    -- upvalues: u5 (ref), u3 (ref), ShowStatInfo (copy)
    if u5 and u5.Visible then
        if not u5 then
            return;
        end;

        u5.Visible = false;

        if u3.InvSectionFrame then
            u3.InvSectionFrame.Visible = true;
        end;
    else
        ShowStatInfo();
    end;
end;

function u1.Setup(p23) -- Line: 177
    -- upvalues: u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), BuildRows (copy), ToggleStatInfo (copy), ShowEquipmentView (copy), u9 (copy), u1 (copy)
    u3 = p23;
    u4 = u3.PlayerData;
    u5 = u3.StatInfoFrame;

    if not u5 then
        warn("[InventoryStatInfo] Contents.StatInfo NOT FOUND — Stat Info panel unavailable!");

        return;
    end;

    local Container = u5:FindFirstChild("Container");

    if Container then
        Container = Container:FindFirstChild("ScrollingFrame");
    end;

    u6 = Container;
    local v24 = u6 and u6:FindFirstChild("Template");
    u7 = v24;

    if u7 then
        u7.Visible = false;
    end;

    BuildRows();
    local StatInfoButton = u3.StatInfoButton;

    if StatInfoButton and StatInfoButton:IsA("GuiButton") then
        StatInfoButton.MouseButton1Click:Connect(ToggleStatInfo);
    else
        warn("[InventoryStatInfo] StatInfo toggle button NOT FOUND — cannot open the panel!");
    end;

    local Buttons = u5:FindFirstChild("Buttons");
    local v25;

    if Buttons then
        v25 = Buttons:FindFirstChild("Inventory");
    else
        v25 = Buttons;
    end;

    if v25 and v25:IsA("GuiButton") then
        v25.MouseButton1Click:Connect(ShowEquipmentView);
    end;

    if Buttons then
        Buttons = Buttons:FindFirstChild("Stats");
    end;

    if Buttons and Buttons:IsA("GuiButton") then
        Buttons.MouseButton1Click:Connect(function() -- Line: 216
            -- upvalues: u5 (ref), u3 (ref)
            u5.Visible = false;

            if u3.ShowStatUpgrade then
                u3.ShowStatUpgrade();
            end;
        end);
    end;

    if u3.InventoryFrame then
        local PropertyChangedSignal = u3.InventoryFrame:GetPropertyChangedSignal("Visible");
        table.insert(u9, PropertyChangedSignal:Connect(function() -- Line: 224
            -- upvalues: u3 (ref), u5 (ref)
            if not u3.InventoryFrame.Visible then
                if not u5 then
                    return;
                end;

                u5.Visible = false;

                if u3.InvSectionFrame then
                    u3.InvSectionFrame.Visible = true;
                end;
            end;
        end));
    end;

    u5.Visible = false;
    u1.Refresh();
end;

function u1.Destroy() -- Line: 236
    -- upvalues: u9 (copy), u8 (copy)
    for _, v in u9 do
        v:Disconnect();
    end;

    table.clear(u9);

    for _, v in u8 do
        if v.frame then
            v.frame:Destroy();
        end;
    end;

    table.clear(u8);
end;

return u1;