--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ChestSpinner
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.ChestSpinner
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local ChestData = require(ReplicatedStorage.GameInfo.ChestData);
require(ReplicatedStorage.Modules.SharedUtils);
local LootChestData = require(ReplicatedStorage.GameInfo.LootChestData);
local u1 = {
    Weapon = 15,
    Hero = 20,
    Title = 25,
    Stars = 20,
    Item = 25,
    Cash_25 = 40,
    Cash_10 = 40,
    Cash_5 = 40,
    UpgradeStone = 30,
    ProtectionScroll = 18,
    Crystal = 30
};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;

local function GetSettingsController() -- Line: 38
    -- upvalues: u6 (ref), Knit (copy)
    if not u6 then
        local success, result = pcall(function() -- Line: 40
            -- upvalues: Knit (ref)
            return Knit.GetController("SettingsController");
        end);

        if success then
            u6 = result;
        end;
    end;

    return u6;
end;

local function ShouldSkipAnimation() -- Line: 50
    -- upvalues: u6 (ref), Knit (copy)
    if not u6 then
        local success, result = pcall(function() -- Line: 40
            -- upvalues: Knit (ref)
            return Knit.GetController("SettingsController");
        end);

        if success then
            u6 = result;
        end;
    end;

    local v7 = u6;

    if v7 then
        return v7:ShouldSkipChestSpin();
    end;

    return false;
end;

local function GetDisplayWeight(p8) -- Line: 56
    -- upvalues: u1 (copy)
    if u1[p8.Id] then
        return u1[p8.Id];
    end;

    if p8.Type == "Cash" then
        if p8.Amount == 25000 then
            return 40;
        end;

        if p8.Amount == 5000 then
            return 40;
        end;
    end;

    return u1[p8.Type] or 20;
end;

local function GetChestItems(p9) -- Line: 72
    -- upvalues: ChestData (copy)
    local Chest = ChestData.GetChest(p9);

    return not Chest and {} or Chest.Contents;
end;

local function BuildItemStrip(p10, p11) -- Line: 78
    -- upvalues: ChestData (copy), u1 (copy)
    local Chest = ChestData.GetChest(p10);
    local v12 = not Chest and {} or Chest.Contents;
    local v13 = {};

    for i = 1, 40 do
        local v14;

        if i == 30 then
            table.insert(v13, p11);
            v14 = i;
        else
            v14 = i;
            local v15 = 0;

            for _, v in ipairs(v12) do
                local v16;

                if u1[v.Id] then
                    v16 = u1[v.Id];
                elseif v.Type == "Cash" then
                    if v.Amount == 25000 then
                        v16 = u1.Cash_25 or 30;
                    elseif v.Amount == 5000 then
                        v16 = u1.Cash_5 or 30;
                    else
                        v16 = u1[v.Type] or 20;
                    end;
                else
                    v16 = u1[v.Type] or 20;
                end;

                v15 = v15 + v16;
            end;

            local v17 = math.random() * v15;
            local v18 = 0;

            for _, v in ipairs(v12) do
                local v19;

                if u1[v.Id] then
                    v19 = u1[v.Id];
                elseif v.Type == "Cash" then
                    if v.Amount == 25000 then
                        v19 = u1.Cash_25 or 30;
                    elseif v.Amount == 5000 then
                        v19 = u1.Cash_5 or 30;
                    else
                        v19 = u1[v.Type] or 20;
                    end;
                else
                    v19 = u1[v.Type] or 20;
                end;

                v18 = v18 + v19;

                if v17 <= v18 then
                    table.insert(v13, v);
                    break;
                end;
            end;
        end;
    end;

    return v13;
end;

local function GetSpinnerIcon(p20) -- Line: 108
    -- upvalues: LootChestData (copy)
    if p20.Type == "UpgradeStone" then
        if p20.MinRarity and LootChestData.UpgradeStoneImages[p20.MinRarity] then
            return LootChestData.UpgradeStoneImages[p20.MinRarity];
        end;

        if p20.StoneRarity and LootChestData.UpgradeStoneImages[p20.StoneRarity] then
            return LootChestData.UpgradeStoneImages[p20.StoneRarity];
        end;

        return LootChestData.RewardIcons.UpgradeStone;
    end;

    if p20.Type == "Crystal" then
        local string_gsub_ret = string.gsub(p20.Id, " Crystal", "");

        if LootChestData.UpgradeStoneImages[string_gsub_ret] then
            return LootChestData.UpgradeStoneImages[string_gsub_ret];
        end;

        return LootChestData.RewardIcons.UpgradeStone;
    end;

    if p20.Type == "ProtectionScroll" then
        return LootChestData.RewardIcons.ProtectionScroll;
    end;

    if p20.Type == "Stars" then
        return LootChestData.RewardIcons.Stars;
    end;

    return p20.Type ~= "Cash" and "" or LootChestData.RewardIcons.Cash;
end;

local function PopulateContainer(p21, p22, p23) -- Line: 142
    -- upvalues: u4 (ref), GetSpinnerIcon (copy)
    for _, child in ipairs(p21:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    local ItemContainer = u4.ItemContainer;

    for i, v in ipairs(p23) do
        if i % 5 == 0 then
            task.wait();
        end;

        local v24 = ItemContainer:FindFirstChild(v.Id);

        if not v24 and v.Type == "Cash" then
            if v.Amount == 25000 then
                v24 = ItemContainer:FindFirstChild("Cash_25");
            elseif v.Amount == 10000 then
                v24 = ItemContainer:FindFirstChild("Cash_10");
            elseif v.Amount == 5000 then
                v24 = ItemContainer:FindFirstChild("Cash_5");
            end;
        end;

        local v25 = v24 or ItemContainer:FindFirstChild("Item_Frame");

        if v25 then
            local v26 = v25:Clone();
            v26.Name = v.Id .. "_" .. i;
            v26.LayoutOrder = i;
            v26.Visible = true;

            if v.Type == "Hero" then
                local HERO_LOADER = v26:FindFirstChild("HERO_LOADER", true);

                if HERO_LOADER then
                    HERO_LOADER:SetAttribute("ModelName", v.Id);
                end;

                local ItemName = v26:FindFirstChild("ItemName");

                if ItemName then
                    ItemName.Text = v.DisplayName or v.Id;
                end;
            elseif v.Type == "Weapon" then
                local WEAPON_LOADER = v26:FindFirstChild("WEAPON_LOADER", true);

                if WEAPON_LOADER then
                    WEAPON_LOADER:SetAttribute("WeaponId", v.Id);
                end;
            elseif v.Type == "Title" then
                local TitleName = v26:FindFirstChild("TitleName");

                if TitleName then
                    TitleName.Text = v.DisplayName or v.Id;
                end;
            elseif v.Type == "Stars" then
                local Icon = v26:FindFirstChild("Icon");

                if Icon then
                    local v27 = GetSpinnerIcon(v);

                    if v27 and v27 ~= "" then
                        Icon.Image = v27;
                    end;
                end;

                local Amount = v26:FindFirstChild("Amount");

                if Amount then
                    local Amount2 = v.Amount;

                    if type(Amount2) == "table" then
                        Amount2 = math.random(Amount2[1], Amount2[2]);
                    end;

                    Amount.Text = tostring(Amount2 or 0);
                end;
            elseif v.Type == "UpgradeStone" or (v.Type == "Crystal" or v.Type == "ProtectionScroll") then
                local Icon = v26:FindFirstChild("Icon");

                if Icon then
                    local v28 = GetSpinnerIcon(v);

                    if v28 and v28 ~= "" then
                        Icon.Image = v28;
                    end;
                end;

                local ItemName = v26:FindFirstChild("ItemName");

                if ItemName then
                    ItemName.Text = v.DisplayName or v.Id;
                end;

                local Chance = v26:FindFirstChild("Chance");

                if Chance then
                    Chance.Visible = false;
                end;
            end;

            v26.Parent = p21;
        else
            warn("[ChestSpinner] No template found for item:", v.Id, v.Type);
        end;
    end;
end;

local function CalculateTargetOffset(p29, p30) -- Line: 244
    local v31 = nil;

    for _, child in ipairs(p30:GetChildren()) do
        if child:IsA("Frame") and child.LayoutOrder == 30 then
            v31 = child;
            break;
        end;
    end;

    if v31 then
        return -(v31.AbsolutePosition.X + v31.AbsoluteSize.X / 2 - (p29.AbsolutePosition.X + p29.AbsoluteSize.X / 2) + math.random(-10, 10));
    end;

    warn("[ChestSpinner] Winner item not found!");

    return 0;
end;

local function PlaySingleSpinner(p32, p33, p34, u35) -- Line: 266
    -- upvalues: BuildItemStrip (copy), PopulateContainer (copy), CalculateTargetOffset (copy), TweenService (copy)
    local ItemContainer = p32.ItemContainer;
    PopulateContainer(ItemContainer, p33, (BuildItemStrip(p33, p34)));
    ItemContainer.Position = UDim2.new(0, 0, 0, 0);
    task.wait();
    task.wait();
    local v36 = CalculateTargetOffset(p32, ItemContainer);
    local v37 = 4 + math.random() * 0.5;
    local v38 = TweenService:Create(ItemContainer, TweenInfo.new(v37, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, v36, 0, 0)
    });
    v38:Play();
    v38.Completed:Connect(function() -- Line: 295
        -- upvalues: u35 (copy)
        task.delay(0.5, function() -- Line: 296
            -- upvalues: u35 (ref)
            if u35 then
                u35();
            end;
        end);
    end);
end;

local function PlaySpinners(u39, p40) -- Line: 304
    -- upvalues: u3 (ref), u4 (ref), u5 (ref), PlaySingleSpinner (copy), Knit (copy)
    local Chests = u3.Chests;

    for _, child in ipairs(Chests:GetChildren()) do
        if child:IsA("Frame") and child ~= u4 then
            child:Destroy();
        end;
    end;

    u5:open();
    local u41 = #p40;
    local v42 = {};
    local u43 = 0;

    for i, v in ipairs(p40) do
        local v44 = u4:Clone();
        v44.Name = "Scroller_" .. i;
        v44.LayoutOrder = i;
        v44.Visible = true;
        v44.Parent = Chests;
        table.insert(v42, {
            scroller = v44,
            reward = v
        });

        if i < #p40 then
            task.wait();
        end;
    end;

    for i, v in ipairs(v42) do
        task.delay((i - 1) * 0.5, function() -- Line: 337
            -- upvalues: PlaySingleSpinner (ref), v (copy), u39 (copy), u43 (ref), u41 (copy), u5 (ref), Chests (copy), u4 (ref), Knit (ref)
            PlaySingleSpinner(v.scroller, u39, v.reward, function() -- Line: 338
                -- upvalues: u43 (ref), u41 (ref), u5 (ref), Chests (ref), u4 (ref), Knit (ref)
                u43 = u43 + 1;

                if u41 <= u43 then
                    task.delay(1.5, function() -- Line: 342
                        -- upvalues: u5 (ref), Chests (ref), u4 (ref), Knit (ref)
                        u5:close();

                        for _, child in ipairs(Chests:GetChildren()) do
                            if child:IsA("Frame") and child ~= u4 then
                                child:Destroy();
                            end;
                        end;

                        Knit.GetService("ChestService"):ConfirmRewards();
                    end);
                end;
            end);
        end);
    end;
end;

local function ShowInstantRewards(p45, p46) -- Line: 360
    -- upvalues: Knit (copy)
    local Controller = Knit.GetController("NotificationController");

    if Controller then
        local v47 = {};

        for _, v in ipairs(p46) do
            table.insert(v47, v.DisplayName or (v.Id or v.Type));
        end;

        Controller:Show("Custom", "Received: " .. table.concat(v47, ", "), 4, Color3.new(0.298039, 1, 0.235294), Color3.new(0.258823, 0.513725, 0.160784), "Ting");
    end;

    Knit.GetService("ChestService"):ConfirmRewards();
end;

return function(p48, p49) -- Line: 388
    -- upvalues: u2 (ref), u3 (ref), u4 (ref), u5 (ref), Knit (copy), u6 (ref), ShowInstantRewards (copy), PlaySpinners (copy)
    u2 = p48;
    u3 = u2.Frames:FindFirstChild("Chest_RNG") or u2.Frames:WaitForChild("Chest_RNG");
    u4 = u3.Chests:FindFirstChild("Template_Scroller");

    if u4 then
        u4.Visible = false;
    end;

    u5 = require(script.Parent.Parent.Controllers.UIController).new(u3);
    Knit.GetService("ChestService").ChestRolled:Connect(function(p50, p51) -- Line: 400
        -- upvalues: u6 (ref), Knit (ref), ShowInstantRewards (ref), PlaySpinners (ref)
        if not u6 then
            local success, result = pcall(function() -- Line: 40
                -- upvalues: Knit (ref)
                return Knit.GetController("SettingsController");
            end);

            if success then
                u6 = result;
            end;
        end;

        local v52 = u6;
        local v53;

        if v52 then
            v53 = v52:ShouldSkipChestSpin();
        else
            v53 = false;
        end;

        if v53 then
            ShowInstantRewards(p50, p51);

            return;
        end;

        PlaySpinners(p50, p51);
    end);
end;