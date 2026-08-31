--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     InventoryStatUpgrade
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.InventoryStatUpgrade
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local StatData = require(ReplicatedStorage.GameInfo.StatData);
local Class_Data = require(ReplicatedStorage.Classes.Class_Data);
local u1 = {};
local u2 = {
    Physical = "STR",
    Ranged = "DEX",
    Magic = "INT"
};
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = {};

local function Notify(p12: string) -- Line: 66
    -- upvalues: u6 (ref)
    if not u6 then
        return;
    end;

    u6:Show("Custom", p12, 3, Color3.fromRGB(255, 200, 80), Color3.fromRGB(60, 45, 15), "Error");
end;

local function GetRequestedAmount() -- Line: 77
    -- upvalues: u10 (ref)
    if not u10 then
        return 1;
    end;

    local v13 = tonumber(u10.Text) or 0;
    local math_floor_ret = math.floor(v13);

    return math_floor_ret < 1 and 1 or math_floor_ret;
end;

function u1.Refresh() -- Line: 85
    -- upvalues: u7 (ref), u5 (ref), u9 (ref), u8 (ref), StatData (copy)
    if not (u7 and u5) then
        return;
    end;

    local SkillPoints, v14 = u5:GetSkillPoints();

    if u9 then
        u9.Text = "SP: " .. tostring(v14);
    end;

    if not u8 then
        return;
    end;

    for _, v in StatData.Order do
        local v15 = u8:FindFirstChild(v);

        if v15 then
            local Lvl = v15:FindFirstChild("Lvl");

            if Lvl then
                Lvl.Text = tostring(SkillPoints[v] or 0);
            end;
        end;
    end;
end;

function u1.RefreshRecommendations() -- Line: 107
    -- upvalues: u8 (ref), u4 (ref), Class_Data (copy), u2 (copy), StatData (copy)
    if not (u8 and u4) then
        return;
    end;

    local v16 = u4.Data.ActiveClass or "";
    local v17 = v16 ~= "" and Class_Data.Get(v16) or nil;
    local v18 = u2[v17 and v17.DamageType or "Physical"];

    for _, v in StatData.Order do
        local v19 = u8:FindFirstChild(v);

        if v19 then
            local v20 = v == v18;
            local Background = v19:FindFirstChild("Background");

            if Background then
                Background = Background:FindFirstChild("Recommend");
            end;

            if Background then
                Background.Visible = v20;
            end;

            local Recommended = v19:FindFirstChild("Recommended");

            if Recommended then
                Recommended.Visible = v20;
            end;
        end;
    end;
end;

local function ShowStatUpgradeView() -- Line: 137
    -- upvalues: u7 (ref), u3 (ref), u1 (copy)
    if not (u7 and u3.InvSectionFrame) then
        return;
    end;

    u3.OnPanelOpened();
    u3.InvSectionFrame.Visible = false;
    u7.Visible = true;
    u1.Refresh();
end;

u1.Show = ShowStatUpgradeView;

local function ShowEquipmentView() -- Line: 151
    -- upvalues: u7 (ref), u3 (ref)
    if not (u7 and u3.InvSectionFrame) then
        return;
    end;

    u7.Visible = false;
    u3.InvSectionFrame.Visible = true;
end;

u1.ShowEquipmentView = ShowEquipmentView;

function u1.Setup(p21) -- Line: 158
    -- upvalues: u3 (ref), u4 (ref), u5 (ref), Knit (copy), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (copy), ShowEquipmentView (copy), StatData (copy), ShowStatUpgradeView (copy), u1 (copy)
    u3 = p21;
    u4 = u3.PlayerData;
    u5 = Knit.GetController("StatController");
    pcall(function() -- Line: 162
        -- upvalues: u6 (ref), Knit (ref)
        u6 = Knit.GetController("NotificationController");
    end);
    u7 = u3.StatUpgradeFrame;

    if not u7 then
        return;
    end;

    local Container = u7:FindFirstChild("Container");
    local v22;

    if Container then
        v22 = Container:FindFirstChild("Abilities");
    else
        v22 = Container;
    end;

    u8 = v22;
    local v23;

    if Container then
        v23 = Container:FindFirstChild("StatPoints");
    else
        v23 = Container;
    end;

    u9 = v23;

    if u9 then
        u9.RichText = true;
    end;

    if Container then
        Container = Container:FindFirstChild("SP_Amount");
    end;

    if Container and Container:IsA("TextBox") then
        u10 = Container;
        local u24 = false;
        local PropertyChangedSignal = u10:GetPropertyChangedSignal("Text");
        table.insert(u11, PropertyChangedSignal:Connect(function() -- Line: 181
            -- upvalues: u24 (ref), u10 (ref)
            if u24 then
                return;
            end;

            local string_gsub_ret = string.gsub(u10.Text, "%D", "");

            if string_gsub_ret ~= u10.Text then
                u24 = true;
                u10.Text = string_gsub_ret;
                u24 = false;
            end;
        end));
    end;

    local Buttons = u7:FindFirstChild("Buttons");

    if Buttons then
        local Equipment = Buttons:FindFirstChild("Equipment");

        if Equipment and Equipment:IsA("GuiButton") then
            Equipment.MouseButton1Click:Connect(ShowEquipmentView);
        end;

        local Back = Buttons:FindFirstChild("Back");

        if Back and Back:IsA("GuiButton") then
            Back.MouseButton1Click:Connect(ShowEquipmentView);
        end;

        local Reset = Buttons:FindFirstChild("Reset");

        if Reset and Reset:IsA("GuiButton") then
            Reset.MouseButton1Click:Connect(function() -- Line: 208
                -- upvalues: Knit (ref), u5 (ref), u6 (ref)
                if not Knit.GetController("WarningController"):Prompt({
                    Message = "Reset all allocated Skill Points?\nEvery point is refunded.",
                    ConfirmText = "Reset",
                    DenyText = "Cancel"
                }) then
                    return;
                end;

                local v25, v26 = u5:Respec();

                if v25 then
                    Knit.GetController("SoundController"):Play("Click");

                    return;
                end;

                if not u6 then
                    return;
                end;

                u6:Show("Custom", v26 == "NotEnoughGold" and "Not enough Coins to reset." or (v26 == "NothingToRespec" and "No points to reset." or "Could not reset points."), 3, Color3.fromRGB(255, 200, 80), Color3.fromRGB(60, 45, 15), "Error");
            end);
        end;

        local Auto = Buttons:FindFirstChild("Auto");

        if Auto and Auto:IsA("GuiButton") then
            Auto.MouseButton1Click:Connect(function() -- Line: 235
                -- upvalues: u5 (ref), u6 (ref), Knit (ref), StatData (ref)
                local v27, v28, v29 = u5:AutoAllocate();

                if v27 then
                    Knit.GetController("SoundController"):Play("Click");

                    if v29 then
                        local v30 = StatData.Get(v29.PrimaryStat);
                        local v31 = StatData.Get(v29.SecondaryStat);

                        if u6 and (v30 and v31) then
                            u6:Show("Custom", string.format("Allocated %d %s and %d %s.", v29.PrimaryAmount, v30.DisplayName, v29.SecondaryAmount, v31.DisplayName), 3, Color3.fromRGB(76, 255, 60), Color3.fromRGB(66, 131, 41), "Ting");
                        end;
                    end;

                    return;
                end;

                if not u6 then
                    return;
                end;

                u6:Show("Custom", v28 == "NoPoints" and "No Skill Points to spend." or "Could not auto-allocate.", 3, Color3.fromRGB(255, 200, 80), Color3.fromRGB(60, 45, 15), "Error");
            end);
        end;
    end;

    if u8 then
        for _, v in StatData.Order do
            local v32 = u8:FindFirstChild(v);

            if v32 then
                local v33 = StatData.Get(v);
                local Title = v32:FindFirstChild("Title");

                if Title and v33 then
                    Title.Text = v33.DisplayName;
                end;

                local Info = v32:FindFirstChild("Info");

                if Info and v33 then
                    Info.RichText = true;
                    Info.Text = v33.Description;
                end;

                local Buttons2 = v32:FindFirstChild("Buttons");
                local v34;

                if Buttons2 then
                    v34 = Buttons2:FindFirstChild("Add");
                else
                    v34 = Buttons2;
                end;

                if v34 and v34:IsA("GuiButton") then
                    v34.MouseButton1Click:Connect(function() -- Line: 282
                        -- upvalues: u5 (ref), v (copy), u10 (ref), u6 (ref)
                        local v35;

                        if u10 then
                            local v36 = tonumber(u10.Text) or 0;
                            local math_floor_ret = math.floor(v36);
                            v35 = math_floor_ret < 1 and 1 or math_floor_ret;
                        else
                            v35 = 1;
                        end;

                        if not u5:AllocatePoints(v, v35) then
                            if not u6 then
                                return;
                            end;

                            u6:Show("Custom", "No Skill Points to spend.", 3, Color3.fromRGB(255, 200, 80), Color3.fromRGB(60, 45, 15), "Error");
                        end;
                    end);
                end;

                if Buttons2 then
                    Buttons2 = Buttons2:FindFirstChild("Remove");
                end;

                if Buttons2 and Buttons2:IsA("GuiButton") then
                    Buttons2.MouseButton1Click:Connect(function() -- Line: 294
                        -- upvalues: u5 (ref), v (copy), u10 (ref), u6 (ref)
                        local v37;

                        if u10 then
                            local v38 = tonumber(u10.Text) or 0;
                            local math_floor_ret = math.floor(v38);
                            v37 = math_floor_ret < 1 and 1 or math_floor_ret;
                        else
                            v37 = 1;
                        end;

                        if not u5:DeallocatePoints(v, v37) then
                            if not u6 then
                                return;
                            end;

                            u6:Show("Custom", "No allocated points to remove.", 3, Color3.fromRGB(255, 200, 80), Color3.fromRGB(60, 45, 15), "Error");
                        end;
                    end);
                end;
            end;
        end;
    end;

    if u3.ButtonsFrame then
        local Stats = u3.ButtonsFrame:FindFirstChild("Stats");

        if Stats and Stats:IsA("GuiButton") then
            Stats.MouseButton1Click:Connect(ShowStatUpgradeView);
        end;
    end;

    local PropertyChangedSignal = u3.InventoryFrame:GetPropertyChangedSignal("Visible");
    table.insert(u11, PropertyChangedSignal:Connect(function() -- Line: 313
        -- upvalues: u3 (ref), u7 (ref)
        if not u3.InventoryFrame.Visible and u7 then
            if not u3.InvSectionFrame then
                return;
            end;

            u7.Visible = false;
            u3.InvSectionFrame.Visible = true;
        end;
    end));

    if u7 and u3.InvSectionFrame then
        u7.Visible = false;
        u3.InvSectionFrame.Visible = true;
    end;

    u1.Refresh();
    u1.RefreshRecommendations();
end;

function u1.Destroy() -- Line: 325
    -- upvalues: u11 (copy)
    for _, v in u11 do
        v:Disconnect();
    end;

    table.clear(u11);
end;

return u1;