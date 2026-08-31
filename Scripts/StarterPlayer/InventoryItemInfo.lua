--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     InventoryItemInfo
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.InventoryItemInfo
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local RarityGradient = require(ReplicatedStorage.Modules.RarityGradient);
local EquipmentStatLines = require(script.Parent.Parent.ClientUtils.EquipmentStatLines);
local u1 = {};
local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
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
local u22 = false;
local u23 = {};
local u24 = nil;
local u25 = false;
local u26 = 0;

function u1.ResetDeleteConfirm() -- Line: 77
    -- upvalues: u25 (ref), u26 (ref), u21 (ref)
    u25 = false;
    u26 = u26 + 1;

    if u21 then
        u21.Text = "Delete";
    end;
end;

local function PopulateStats(p27) -- Line: 91
    -- upvalues: u2 (ref), EquipmentStatLines (copy), u13 (ref), u14 (ref)
    local v28;

    if p27.Slot and not u2.IsItemEquipped(p27.GUID or "") then
        v28 = u2.PlayerData.Data.Equipment[p27.Slot];
    else
        v28 = nil;
    end;

    EquipmentStatLines.render(u13, u14, p27, v28);
end;

local function IsItemDeletable(p29) -- Line: 111
    -- upvalues: u2 (ref)
    if p29.IsClassItem then
        return false;
    end;

    local v30;

    if p29.IsEquipment == true and p29.Locked ~= true then
        v30 = not u2.IsItemEquipped(p29.GUID or "");
    else
        v30 = false;
    end;

    return v30;
end;

local function NeedsWarningDelete(p31) -- Line: 120
    if (p31.ForgeLevel or 0) >= 1 then
        return true;
    end;

    local Rarity = p31.Rarity;

    return Rarity == "Mythic" and true or Rarity == "Celestial";
end;

local function DoDeleteSelected(p32) -- Line: 126
    -- upvalues: u3 (ref), Knit (copy), u2 (ref)
    if not u3 then
        return;
    end;

    local v33, v34 = u3:DeleteItem(p32.GUID):await();

    if v33 and v34 then
        local Controller = Knit.GetController("SoundController");

        if Controller then
            Controller:Play("UI_Delete");
        end;

        u2.OnClosed();
    end;
end;

local function OnDeleteClicked() -- Line: 136
    -- upvalues: u24 (ref), u2 (ref), u1 (copy), Knit (copy), DoDeleteSelected (copy), u25 (ref), u26 (ref), u21 (ref)
    local v35 = u24;

    if v35 then
        local v36;

        if v35.IsClassItem or (v35.IsEquipment ~= true or v35.Locked == true) then
            v36 = false;
        else
            v36 = not u2.IsItemEquipped(v35.GUID or "");
        end;

        if v36 then
            local v37;

            if (v35.ForgeLevel or 0) >= 1 then
                v37 = true;
            else
                local Rarity = v35.Rarity;
                v37 = Rarity == "Mythic" and true or Rarity == "Celestial";
            end;

            if v37 then
                u1.ResetDeleteConfirm();

                if not Knit.GetController("WarningController"):Prompt({
                    ConfirmText = "Delete",
                    DenyText = "Cancel",
                    Message = `Delete <b>{v35.DisplayName}</b>?\nThis cannot be undone.`
                }) then
                    return;
                end;

                DoDeleteSelected(v35);

                return;
            end;

            if u25 then
                DoDeleteSelected(v35);

                return;
            end;

            u25 = true;
            u26 = u26 + 1;
            local u38 = u26;

            if u21 then
                u21.Text = "Confirm?";
            end;

            task.delay(3, function() -- Line: 157
                -- upvalues: u26 (ref), u38 (copy), u1 (ref)
                if u26 == u38 then
                    u1.ResetDeleteConfirm();
                end;
            end);
        end;
    end;
end;

local function IsItemActionable(p39) -- Line: 174
    return (p39.IsEquipment == true or (p39.IsCosmetic == true or p39.IsClassItem == true)) and true or p39.Usable == true;
end;

function u1.Populate(p40) -- Line: 181
    -- upvalues: u4 (ref), u24 (ref), u1 (copy), u7 (ref), RarityGradient (copy), u8 (ref), u9 (ref), u16 (ref), u2 (ref), u17 (ref), u11 (ref), u10 (ref), u12 (ref), u13 (ref), EquipmentStatLines (copy), u14 (ref), u15 (ref), u18 (ref), u19 (ref), u20 (ref)
    if not u4 then
        return;
    end;

    u24 = p40;
    u1.ResetDeleteConfirm();

    if u7 then
        local DisplayName = p40.DisplayName;

        if p40.IsEquipment then
            local v41 = p40.ForgeLevel or 0;
            local v42 = p40.EnchantLevel or 0;

            if v41 > 0 then
                DisplayName = DisplayName .. " +" .. v41;
            elseif v42 > 0 then
                DisplayName = DisplayName .. " +" .. v42;
            end;
        end;

        u7.Text = DisplayName;
        u7.TextColor3 = Color3.new(1, 1, 1);
        RarityGradient.set(u7, p40.Rarity);
    end;

    if u8 then
        if RarityGradient.colorSequence(p40.Rarity) then
            u8.Text = p40.Rarity;
            u8.TextColor3 = Color3.new(1, 1, 1);
            u8.Visible = true;
            RarityGradient.set(u8, p40.Rarity);
        else
            u8.Visible = false;
        end;
    end;

    if u9 then
        local Icon = p40.Icon;

        if Icon and (Icon ~= "" and Icon ~= "rbxassetid://0") then
            u9.Image = Icon;
            u9.Visible = true;
        else
            u9.Visible = false;
        end;
    end;

    if u16 then
        local v43;

        if u2.IsCardEquipped == nil then
            v43 = false;
        else
            v43 = u2.IsCardEquipped(p40) or false;
        end;

        u16.Visible = v43;
    end;

    if u17 then
        if p40.IsEquipment and (p40.LevelReq and p40.LevelReq > 0) then
            u17.Text = "Lvl. " .. p40.LevelReq;
            u17.TextColor3 = (u2.PlayerData.Data.PlayerLevel or 1) < p40.LevelReq and Color3.fromRGB(255, 75, 75) or Color3.fromRGB(180, 180, 180);
            u17.Visible = true;
        else
            u17.Visible = false;
        end;
    end;

    if p40.IsEquipment then
        if u11 then
            u11.Visible = false;
        end;

        if u10 then
            u10.Visible = false;
        end;

        if u12 then
            u12.Visible = true;
        end;

        if u13 then
            u13.Visible = true;
        end;

        local v44;

        if p40.Slot and not u2.IsItemEquipped(p40.GUID or "") then
            v44 = u2.PlayerData.Data.Equipment[p40.Slot];
        else
            v44 = nil;
        end;

        EquipmentStatLines.render(u13, u14, p40, v44);

        if u15 then
            local v45 = p40.ForgeLevel or 0;

            if v45 >= 1 then
                u15.Text = "Forge Lvl. " .. v45;
                u15.Visible = true;
            else
                u15.Visible = false;
            end;
        end;
    elseif p40.IsCosmetic then
        if u12 then
            u12.Visible = false;
        end;

        if u13 then
            u13.Visible = false;
        end;

        if u15 then
            u15.Visible = false;
        end;

        if u10 then
            u10.Visible = false;
        end;

        if u11 then
            u11.Visible = false;
        end;
    else
        if u12 then
            u12.Visible = false;
        end;

        if u13 then
            u13.Visible = false;
        end;

        if u15 then
            u15.Visible = false;
        end;

        if u10 then
            u10.Visible = true;
        end;

        if u11 then
            u11.Visible = true;
            u11.Text = p40.Description or "";
        end;
    end;

    local v46 = (p40.IsEquipment == true or (p40.IsCosmetic == true or p40.IsClassItem == true)) and true or p40.Usable == true;

    if u18 then
        u18.Visible = v46;
    end;

    if v46 and u19 then
        u19.Text = u2.GetContextualActionText(p40);
    end;

    if u20 then
        local v47;

        if p40.IsClassItem or (p40.IsEquipment ~= true or p40.Locked == true) then
            v47 = false;
        else
            v47 = not u2.IsItemEquipped(p40.GUID or "");
        end;

        u20.Visible = v47;
    end;
end;

local function CancelTweens() -- Line: 303
    -- upvalues: u23 (copy)
    for _, v in u23 do
        v:Cancel();
    end;

    table.clear(u23);
end;

function u1.Show() -- Line: 308
    -- upvalues: u4 (ref), u22 (ref), u23 (copy), u2 (ref), TweenService (copy), TweenInfo_new_ret (copy), u5 (ref)
    if not u4 then
        return;
    end;

    if u22 then
        return;
    end;

    u22 = true;

    for _, v in u23 do
        v:Cancel();
    end;

    table.clear(u23);
    u2.SetVanityView(false);
    u4.Visible = true;
    local v48 = TweenService:Create(u4, TweenInfo_new_ret, {
        GroupTransparency = 0
    });
    table.insert(u23, v48);
    v48:Play();

    if u5 then
        local v49 = TweenService:Create(u4, TweenInfo_new_ret, {
            Position = u5
        });
        table.insert(u23, v49);
        v49:Play();
    end;
end;

function u1.Hide() -- Line: 327
    -- upvalues: u4 (ref), u22 (ref), u23 (copy), u2 (ref), TweenService (copy), TweenInfo_new_ret (copy), u6 (ref)
    if not u4 then
        return;
    end;

    if not u22 then
        return;
    end;

    u22 = false;

    for _, v in u23 do
        v:Cancel();
    end;

    table.clear(u23);
    u2.SetVanityView(true);
    local v50 = TweenService:Create(u4, TweenInfo_new_ret, {
        GroupTransparency = 1
    });
    table.insert(u23, v50);
    v50.Completed:Once(function(p51) -- Line: 338
        -- upvalues: u22 (ref), u4 (ref)
        if p51 == Enum.PlaybackState.Completed and not u22 then
            u4.Visible = false;
        end;
    end);
    v50:Play();

    if u6 then
        local v52 = TweenService:Create(u4, TweenInfo_new_ret, {
            Position = u6
        });
        table.insert(u23, v52);
        v52:Play();
    end;
end;

function u1.Setup(p53, p54) -- Line: 355
    -- upvalues: u2 (ref), u3 (ref), Knit (copy), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), OnDeleteClicked (copy), u22 (ref), u1 (copy)
    u2 = p54;
    u3 = Knit.GetService("EquipmentService");

    if p53 then
        p53 = p53:FindFirstChild("ItemInfo");
    end;

    u4 = p53;

    if not u4 then
        return;
    end;

    u5 = u4:GetAttribute("ShowPosition");
    u6 = u4:GetAttribute("HidePosition");
    u7 = u4:FindFirstChild("ItemName");
    u8 = u4:FindFirstChild("Rarity");
    u9 = u4:FindFirstChild("ItemImage");
    u10 = u4:FindFirstChild("DescriptionTitle");
    u11 = u4:FindFirstChild("Description");
    u12 = u4:FindFirstChild("StatsTitle");
    u13 = u4:FindFirstChild("Stats");
    local v55 = u13 and u13:FindFirstChild("Template");
    u14 = v55;
    u15 = u4:FindFirstChild("ForgeLevel");
    u16 = u4:FindFirstChild("Equipped");
    u17 = u4:FindFirstChild("ItemLevel");

    if u14 then
        u14.Visible = false;
    end;

    if u16 then
        u16.Visible = false;
    end;

    if u17 then
        u17.Visible = false;
    end;

    u18 = u4:FindFirstChild("Equip");
    local v56 = u18 and u18:FindFirstChild("Title");
    u19 = v56;

    if u18 and u18:IsA("GuiButton") then
        u18.MouseButton1Click:Connect(function() -- Line: 383
            -- upvalues: u2 (ref)
            u2.OnUseClicked();
        end);
    end;

    u20 = u4:FindFirstChild("Delete");
    local v57 = u20 and u20:FindFirstChild("Title");
    u21 = v57;

    if u20 and u20:IsA("GuiButton") then
        u20.MouseButton1Click:Connect(OnDeleteClicked);
    end;

    local Exit = u4:FindFirstChild("Exit");

    if Exit and Exit:IsA("GuiButton") then
        Exit.MouseButton1Click:Connect(function() -- Line: 396
            -- upvalues: u2 (ref)
            u2.OnClosed();
        end);
    end;

    if u6 then
        u4.Position = u6;
    end;

    u4.GroupTransparency = 1;
    u4.Visible = false;
    u22 = false;
    u1.ResetDeleteConfirm();
end;

return u1;