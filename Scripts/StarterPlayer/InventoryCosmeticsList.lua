--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     InventoryCosmeticsList
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.InventoryCosmeticsList
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CosmeticData = require(ReplicatedStorage.GameInfo.CosmeticData);
local RarityData = require(ReplicatedStorage.GameInfo.RarityData);
local RarityGradient = require(ReplicatedStorage.Modules.RarityGradient);
local RevealCascade = require(script.Parent.Parent.ClientUtils.RevealCascade);
local Color3_new_ret = Color3.new(1, 1, 1);
local RarityIndex = RarityData.RarityIndex;
local u1 = {};
local u2 = {};

for i, v in CosmeticData.Catalog do
    if v.IncludedSets then
        local v3 = i;

        for _, v2 in v.IncludedSets do
            u1[v2] = v3;
        end;
    end;
end;

local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = {};
local u10 = 0;

local function BuildGroups() -- Line: 79
    -- upvalues: u4 (ref), CosmeticData (copy), u1 (copy), RarityIndex (copy)
    local v11 = u4 and u4.Data.OwnedCosmetics;

    if not v11 then
        return {};
    end;

    local v12 = {};

    for _, v in v11 do
        v12[v] = true;
    end;

    local v13 = {};

    for _, v in v11 do
        local v14 = CosmeticData.Get(v);

        if v14 then
            local v15 = u1[v];

            if not (v15 and v12[v15]) then
                local v16 = {
                    [v] = true
                };
                local v17;

                if v14.IncludedSets then
                    v17 = v;

                    for _, v2 in v14.IncludedSets do
                        v16[v2] = true;
                    end;
                else
                    v17 = v;
                end;

                table.insert(v13, {
                    SetId = v17,
                    Entry = v14,
                    Members = v16
                });
            end;
        end;
    end;

    table.sort(v13, function(p18, p19) -- Line: 108
        -- upvalues: RarityIndex (ref)
        local v20 = RarityIndex[p18.Entry.Rarity] or 1;
        local v21 = RarityIndex[p19.Entry.Rarity] or 1;

        if v20 == v21 then
            return (p18.Entry.DisplayName or p18.SetId) < (p19.Entry.DisplayName or p19.SetId);
        end;

        return v20 < v21;
    end);

    return v13;
end;

local function ClearRows() -- Line: 122
    -- upvalues: u9 (copy)
    for _, v in u9 do
        if v.Parent then
            v:Destroy();
        end;
    end;

    table.clear(u9);
end;

local function BuildRow(p22: string, p23: string?, p24: string?, p25: number, p26: function) -- Line: 132
    -- upvalues: u6 (ref), Color3_new_ret (copy), RarityGradient (copy), u5 (ref), u9 (copy)
    local v27 = u6:Clone();
    v27.Name = "Row_" .. p22;
    v27.LayoutOrder = p25;
    v27.Visible = true;
    local Frame = v27:FindFirstChild("Frame");

    if Frame then
        local ItemName = Frame:FindFirstChild("ItemName");

        if ItemName then
            ItemName.Text = p22;
        end;

        local Rarity = Frame:FindFirstChild("Rarity");

        if Rarity then
            if p23 then
                Rarity.Text = p23;
                Rarity.TextColor3 = Color3_new_ret;
                RarityGradient.set(Rarity, p23);
                Rarity.Visible = true;
            else
                Rarity.Visible = false;
            end;
        end;

        local ItemImage = Frame:FindFirstChild("ItemImage");

        if ItemImage then
            ItemImage.Image = p24 or "";
            ItemImage.Visible = (p24 or "") ~= "";
        end;
    end;

    local Select = v27:FindFirstChild("Select");

    if Select then
        Select.Visible = false;
        v27.MouseEnter:Connect(function() -- Line: 170
            -- upvalues: Select (copy)
            Select.Visible = true;
        end);
        v27.MouseLeave:Connect(function() -- Line: 173
            -- upvalues: Select (copy)
            Select.Visible = false;
        end);
    end;

    v27.MouseButton1Click:Connect(p26);
    v27.Parent = u5;
    table.insert(u9, v27);
end;

local function BuildList() -- Line: 186
    -- upvalues: u9 (copy), u6 (ref), u5 (ref), u10 (ref), BuildRow (copy), u2 (copy), u8 (ref), BuildGroups (copy), RevealCascade (copy)
    for _, v in u9 do
        if v.Parent then
            v:Destroy();
        end;
    end;

    table.clear(u9);

    if not (u6 and u5) then
        return;
    end;

    u10 = u10 + 1;
    local u28 = u10;
    BuildRow("All", nil, nil, 1, function() -- Line: 194
        -- upvalues: u2 (ref), u8 (ref)
        u2.Hide();

        if u8 then
            u8(nil);
        end;
    end);

    for i, v in BuildGroups() do
        local Members = v.Members;
        BuildRow(v.Entry.DisplayName or v.SetId, v.Entry.Rarity or "Common", v.Entry.Icon or "", i + 1, function() -- Line: 206
            -- upvalues: u2 (ref), u8 (ref), Members (copy)
            u2.Hide();

            if u8 then
                u8(Members);
            end;
        end);
    end;

    RevealCascade.play(table.clone(u9), {
        isCurrent = function() -- Line: 216, Name: isCurrent
            -- upvalues: u5 (ref), u10 (ref), u28 (copy)
            return u5.Visible and u10 == u28;
        end
    });
end;

function u2.Show() -- Line: 228
    -- upvalues: u5 (ref), u7 (ref), BuildList (copy)
    if not u5 then
        return;
    end;

    u7.Visible = false;
    u5.Visible = true;
    BuildList();
end;

function u2.Hide() -- Line: 236
    -- upvalues: u5 (ref), u7 (ref)
    if not u5 then
        return;
    end;

    u5.Visible = false;
    u7.Visible = true;
end;

function u2.IsShowing() -- Line: 242
    -- upvalues: u5 (ref)
    local v29;

    if u5 == nil then
        v29 = false;
    else
        v29 = u5.Visible;
    end;

    return v29;
end;

function u2.Setup(p30) -- Line: 251
    -- upvalues: u4 (ref), u8 (ref), u7 (ref), u5 (ref), u6 (ref)
    u4 = p30.PlayerData;
    u8 = p30.OnGroupSelected;
    local ItemPanel = p30.ItemPanel;
    u7 = ItemPanel:WaitForChild("ItemGrid");
    u5 = ItemPanel:FindFirstChild("CosmeticsList");

    if not u5 then
        warn("[InventoryCosmeticsList] ItemPanel.CosmeticsList NOT FOUND — set-list view unavailable");

        return;
    end;

    u6 = u5:WaitForChild("Template");
    u6.Visible = false;
    u5.Visible = false;
end;

return u2;