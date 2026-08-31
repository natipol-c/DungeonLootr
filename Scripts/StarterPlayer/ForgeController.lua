--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ForgeController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.ForgeController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local EquipmentData = require(ReplicatedStorage.GameInfo.EquipmentData);
local EquipmentTemplates = require(ReplicatedStorage.GameInfo.EquipmentTemplates);
local ForgeData = require(ReplicatedStorage.GameInfo.ForgeData);
local RarityData = require(ReplicatedStorage.GameInfo.RarityData);
local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
local Image_Data = require(ReplicatedStorage.GameInfo.Image_Data);
local MonetizationList = require(ReplicatedStorage.GameInfo.MonetizationList);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local Knit = require(ReplicatedStorage.Packages.Knit);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local UIController = require(script.Parent.Parent.Controllers.UIController);
local ForgeAnimator = require(script.Parent.Parent.ClientUtils.ForgeAnimator);
local RarityGradient = require(ReplicatedStorage.Modules.RarityGradient);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = false;
local u10 = false;
local u11 = false;
local u12 = false;
local u13 = false;
local u14 = false;
local u15 = {};
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = nil;
local u26 = nil;
local u27 = nil;
local u28 = nil;
local u29 = nil;
local u30 = nil;
local u31 = nil;
local u32 = nil;
local u33 = nil;
local u34 = nil;
local u35 = nil;
local u36 = nil;
local u37 = nil;
local u38 = nil;
local u39 = nil;
local u40 = nil;
local u41 = nil;
local u42 = nil;
local u43 = nil;
local u44 = nil;
local u45 = nil;
local u46 = nil;
local u47 = nil;
local u48 = nil;
local u49 = nil;
local u50 = nil;
local u51 = nil;
local u52 = nil;
local u53 = nil;
local u54 = nil;
local u55 = nil;
local u56 = nil;
local u57 = {
    Success = Color3.fromRGB(80, 255, 80),
    Failed = Color3.fromRGB(255, 80, 80),
    Forging = Color3.fromRGB(200, 200, 255),
    Default = Color3.fromRGB(255, 255, 255),
    Max = Color3.fromRGB(255, 215, 90)
};
local Color3_fromRGB_ret = Color3.fromRGB(255, 70, 70);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 210, 40);
local Color3_fromRGB_ret3 = Color3.fromRGB(90, 255, 90);
local Color3_fromRGB_ret4 = Color3.fromRGB(133, 106, 57);
local Color3_fromRGB_ret5 = Color3.fromRGB(110, 110, 110);
local TweenInfo_new_ret = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u58 = {
    Head = 1,
    Body = 2,
    Ring = 3
};
local u59 = { "Head", "Body", "Ring" };
local u60 = {
    Head = "Helmet_List",
    Body = "Body_List",
    Ring = "Ring_List"
};
local RarityIndex = RarityData.RarityIndex;

local function FindItemByGUID(p61: string) -- Line: 175
    -- upvalues: u2 (ref), u59 (copy)
    local Data = u2.Data;

    if Data.EquipmentInventory then
        for _, v in Data.EquipmentInventory do
            if type(v) == "table" and v.GUID == p61 then
                return v;
            end;
        end;
    end;

    if Data.Equipment then
        for _, v in u59 do
            local v62 = Data.Equipment[v];

            if type(v62) == "table" and v62.GUID == p61 then
                return v62;
            end;
        end;
    end;

    return nil;
end;

local function GetEquipmentImage(p63: string) -- Line: 199
    -- upvalues: Image_Data (copy), EquipmentTemplates (copy)
    if Image_Data.Equipment and Image_Data.Equipment[p63] then
        return Image_Data.Equipment[p63];
    end;

    local Template = EquipmentTemplates.GetTemplate(p63);

    return Template and Template.ImageId or "";
end;

local function GetItemBaseName(p64) -- Line: 208
    -- upvalues: EquipmentTemplates (copy)
    local Template = EquipmentTemplates.GetTemplate(p64.ItemId);

    return Template and Template.DisplayName or p64.ItemId;
end;

local function GetItemDisplayName(p65) -- Line: 215
    -- upvalues: EquipmentTemplates (copy), ForgeData (copy)
    local Template = EquipmentTemplates.GetTemplate(p65.ItemId);
    local v66 = Template and Template.DisplayName or p65.ItemId;
    local v67 = p65.ForgeLevel or 0;

    if v67 > 0 then
        v66 = v66 .. " " .. ForgeData.GetLevelName(v67);
    end;

    return v66;
end;

local function SetActionEnabled(p68: userdata, p69: boolean) -- Line: 229
    local Button = p68:FindFirstChild("Button");

    if Button then
        Button.Active = p69;
        Button.AutoButtonColor = p69;
        local Item = Button:FindFirstChild("Item");

        if Item then
            Item.ImageTransparency = p69 and 0 or 0.5;
        end;
    end;
end;

local function SetReforgeEnabled(p70: boolean, p71: boolean) -- Line: 245
    -- upvalues: u23 (ref), Image_Data (copy)
    if not u23 then
        return;
    end;

    u23.Active = p70;
    u23.AutoButtonColor = p70;
    local Status = u23:FindFirstChild("Status");

    if Status and Status:IsA("ImageLabel") then
        Status.Image = p71 and Image_Data.ForgeUI.On or Image_Data.ForgeUI.Off;
    end;
end;

local function ApplyCheckVisual(p72: userdata?, p73: boolean, p74: boolean?) -- Line: 259
    -- upvalues: Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret5 (copy), TweenService (copy), TweenInfo_new_ret (copy)
    if not p72 then
        return;
    end;

    local v75 = p73 and p72:GetAttribute("On") or p72:GetAttribute("Off");
    local v76 = p73 and Color3_fromRGB_ret4 or Color3_fromRGB_ret5;

    if p74 then
        if typeof(v75) == "UDim2" then
            p72.Position = v75;
        end;

        p72.BackgroundColor3 = v76;

        return;
    end;

    local v77 = {
        BackgroundColor3 = v76
    };

    if typeof(v75) == "UDim2" then
        v77.Position = v75;
    end;

    TweenService:Create(p72, TweenInfo_new_ret, v77):Play();
end;

local function UpdateSelectedHeader() -- Line: 278
    -- upvalues: u7 (ref), u18 (ref), EquipmentTemplates (copy), ForgeData (copy), RarityColors (copy), u57 (copy), u21 (ref), Image_Data (copy), u20 (ref)
    if not u7 then
        u18.Text = "";
        u18.TextColor3 = u57.Default;
        u21.Image = "";
        u21.Visible = false;
        u20.Visible = true;

        return;
    end;

    local v78 = u7;
    local Template = EquipmentTemplates.GetTemplate(v78.ItemId);
    local v79 = Template and Template.DisplayName or v78.ItemId;
    local v80 = v78.ForgeLevel or 0;

    if v80 > 0 then
        v79 = v79 .. " " .. ForgeData.GetLevelName(v80);
    end;

    u18.Text = "Selected: " .. v79;
    local v81 = RarityColors[u7.Rarity];
    u18.TextColor3 = v81 and v81.TextColor3 or u57.Default;
    local ItemId = u7.ItemId;
    local v82;

    if Image_Data.Equipment and Image_Data.Equipment[ItemId] then
        v82 = Image_Data.Equipment[ItemId];
    else
        local Template2 = EquipmentTemplates.GetTemplate(ItemId);
        v82 = Template2 and Template2.ImageId or "";
    end;

    u21.Image = v82;
    u21.Visible = true;
    u20.Visible = false;
end;

local function FormatCoins(p83: number) -- Line: 301
    -- upvalues: SharedUtils (copy)
    if p83 >= 10000000 then
        return SharedUtils.FormatNumber(p83);
    end;

    return SharedUtils.FormatWithCommas(p83);
end;

local function PercentColor(p84: number) -- Line: 310
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy)
    local math_clamp_ret = math.clamp(p84, 0, 1);

    if math_clamp_ret <= 0.5 then
        return Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret2, math_clamp_ret / 0.5);
    end;

    return Color3_fromRGB_ret2:Lerp(Color3_fromRGB_ret3, (math_clamp_ret - 0.5) / 0.5);
end;

local function SetUpgradeGradient(p85: string) -- Line: 320
    -- upvalues: u54 (ref)
    if not u54 then
        return;
    end;

    for i, v in u54 do
        v.Enabled = i == p85;
    end;
end;

local function UpdateBalance() -- Line: 329
    -- upvalues: u53 (ref), u2 (ref), SharedUtils (copy)
    if not u53 then
        return;
    end;

    local v86 = u2.Data and u2.Data.Currency or 0;

    if v86 >= 1000000000 then
        u53.Text = SharedUtils.FormatNumber(v86);

        return;
    end;

    u53.Text = SharedUtils.FormatWithCommas(v86);
end;

local function UpdateReforgeAmount() -- Line: 341
    -- upvalues: u24 (ref), u2 (ref), ForgeData (copy)
    if not u24 then
        return;
    end;

    u24.Text = "x" .. ((u2.Data and u2.Data.CraftingMaterials or {})[ForgeData.REFORGE_MATERIAL_ID] or 0);
end;

local function GetProtectionScrollCount() -- Line: 349
    -- upvalues: u2 (ref)
    return u2.Data and u2.Data.ProtectionScrolls or 0;
end;

local function GetPurityStoneCount() -- Line: 352
    -- upvalues: u2 (ref), ForgeData (copy)
    local v87 = u2.Data and u2.Data.QuestItems;

    return v87 and v87[ForgeData.PURITY_ITEM_ID] or 0;
end;

local function SetModifierStatus(p88: userdata?, p89: boolean) -- Line: 358
    -- upvalues: Image_Data (copy)
    if not p88 then
        return;
    end;

    local Status = p88:FindFirstChild("Status");

    if Status and Status:IsA("ImageLabel") then
        Status.Image = p89 and Image_Data.ForgeUI.On or Image_Data.ForgeUI.Off;
    end;
end;

local function UpdateModifierAmounts() -- Line: 370
    -- upvalues: u2 (ref), ForgeData (copy), u31 (ref), u30 (ref), u11 (ref), Image_Data (copy), u12 (ref)
    local v90 = u2.Data and u2.Data.ProtectionScrolls or 0;
    local v91 = u2.Data and u2.Data.QuestItems;
    local v92 = v91 and v91[ForgeData.PURITY_ITEM_ID] or 0;

    if u31 then
        local Amount = u31:FindFirstChild("Amount");

        if Amount and Amount:IsA("TextLabel") then
            Amount.Text = "x" .. v90;
        end;
    end;

    if u30 then
        local Amount = u30:FindFirstChild("Amount");

        if Amount and Amount:IsA("TextLabel") then
            Amount.Text = "x" .. v92;
        end;
    end;

    if u11 and v90 < 1 then
        u11 = false;
        local v93 = u31;

        if v93 then
            local Status = v93:FindFirstChild("Status");

            if Status and Status:IsA("ImageLabel") then
                Status.Image = Image_Data.ForgeUI.Off;
            end;
        end;
    end;

    if u12 and v92 < 1 then
        u12 = false;
        local v94 = u30;

        if not v94 then
            return;
        end;

        local Status = v94:FindFirstChild("Status");

        if Status and Status:IsA("ImageLabel") then
            Status.Image = Image_Data.ForgeUI.Off;
        end;
    end;
end;

local function UpdateModifierStatuses() -- Line: 392
    -- upvalues: u31 (ref), u11 (ref), Image_Data (copy), u30 (ref), u12 (ref)
    local v95 = u31;
    local v96 = u11;

    if v95 then
        local Status = v95:FindFirstChild("Status");

        if Status and Status:IsA("ImageLabel") then
            Status.Image = v96 and Image_Data.ForgeUI.On or Image_Data.ForgeUI.Off;
        end;
    end;

    local v97 = u30;
    local v98 = u12;

    if not v97 then
        return;
    end;

    local Status = v97:FindFirstChild("Status");

    if Status and Status:IsA("ImageLabel") then
        Status.Image = v98 and Image_Data.ForgeUI.On or Image_Data.ForgeUI.Off;
    end;
end;

local function SetSkipAnimationVisual(p99: boolean, p100: boolean?) -- Line: 398
    -- upvalues: u38 (ref), u57 (copy), ApplyCheckVisual (copy), u39 (ref)
    if u38 then
        u38.TextColor3 = p99 and u57.Success or u57.Failed;
    end;

    ApplyCheckVisual(u39, p99, p100);
end;

local function UpdateActionInfo() -- Line: 408
    -- upvalues: u8 (ref), u32 (ref), u57 (copy), u33 (ref), u34 (ref), u35 (ref), u36 (ref), u12 (ref), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), SharedUtils (copy), Image_Data (copy), ForgeData (copy)
    local v101 = u8;

    if v101 then
        if v101.IsMaxed then
            if u32 then
                u32.Text = "MAX";
                u32.TextColor3 = u57.Default;
            end;

            if u33 then
                u33.Text = "—";
                u33.TextColor3 = u57.Default;
            end;

            if u34 then
                u34.Text = "—";
                u34.TextColor3 = u57.Default;
            end;

            if u35 then
                u35.Text = "—";
                u35.TextColor3 = u57.Default;
            end;

            if u36 then
                u36.Visible = false;

                return;
            end;
        else
            if u32 then
                local v102 = v101.NextSuccessRate or 0;
                local v103 = u12 and v101.EnhanceApplies == true;

                if v103 then
                    v102 = math.min(v102 + (v101.PurityBonus or 0), 1);
                end;

                u32.Text = math.floor(v102 * 100 + 0.5) .. "%";
                local v104 = v103 and u57.Success;

                if not v104 then
                    local math_clamp_ret = math.clamp(v102, 0, 1);

                    if math_clamp_ret <= 0.5 then
                        v104 = Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret2, math_clamp_ret / 0.5);
                    else
                        v104 = Color3_fromRGB_ret2:Lerp(Color3_fromRGB_ret3, (math_clamp_ret - 0.5) / 0.5);
                    end;
                end;

                u32.TextColor3 = v104;
            end;

            if u33 then
                if v101.NextMilestoneAffix then
                    u33.Text = "NEW!";
                    u33.TextColor3 = u57.Success;
                else
                    u33.Text = "—";
                    u33.TextColor3 = u57.Default;
                end;
            end;

            if u34 then
                local v105 = v101.NextCoinCost or 0;
                local v106;

                if v105 >= 10000000 then
                    v106 = SharedUtils.FormatNumber(v105);
                else
                    v106 = SharedUtils.FormatWithCommas(v105);
                end;

                u34.Text = v106;
                u34.TextColor3 = (v101.CoinsOwned or 0) >= (v101.NextCoinCost or 0) and u57.Success or u57.Failed;
            end;

            if u35 then
                u35.Text = "x" .. (v101.NextMaterialCost or 0);
                u35.TextColor3 = (v101.MaterialsOwned or 0) >= (v101.NextMaterialCost or 0) and u57.Success or u57.Failed;
            end;

            if u36 then
                local v107 = Image_Data.Ingots[v101.Rarity];
                u36.Image = v107 or "";
                u36.Visible = v107 ~= nil;
                u36:SetAttribute("Tip", v101.Rarity and ForgeData.GetUpgradeMaterialId(v101.Rarity) or "");
            end;
        end;

        return;
    end;

    if u32 then
        u32.Text = "";
        u32.TextColor3 = u57.Default;
    end;

    if u33 then
        u33.Text = "";
        u33.TextColor3 = u57.Default;
    end;

    if u34 then
        u34.Text = "";
        u34.TextColor3 = u57.Default;
    end;

    if u35 then
        u35.Text = "";
        u35.TextColor3 = u57.Default;
    end;

    if u36 then
        u36.Visible = false;
    end;
end;

local function ClearStatRows() -- Line: 485
    -- upvalues: u49 (ref), u50 (ref)
    for _, child in u49:GetChildren() do
        if child:IsA("Frame") and (child ~= u50 and child.Name ~= "end_padding") then
            child:Destroy();
        end;
    end;
end;

local function PopulateStatsView() -- Line: 494
    -- upvalues: u6 (ref), FindItemByGUID (copy), u56 (ref), u7 (ref), UpdateSelectedHeader (copy), u3 (ref), u8 (ref), EquipmentData (copy), u51 (ref), SharedUtils (copy), u52 (ref), ForgeData (copy), ClearStatRows (copy), u50 (ref), Image_Data (copy), u57 (copy), u49 (ref), u22 (ref), u54 (ref), u23 (ref), u24 (ref), u2 (ref), UpdateModifierAmounts (copy), UpdateActionInfo (copy), u53 (ref)
    if not u6 then
        return;
    end;

    local v108 = FindItemByGUID(u6);

    if not v108 then
        u56();

        return;
    end;

    u7 = v108;
    UpdateSelectedHeader();
    local success, result = pcall(function() -- Line: 506
        -- upvalues: u3 (ref), u6 (ref)
        return u3:GetForgeInfo(u6):expect();
    end);

    if not (success and result) then
        warn("[ForgeController] GetForgeInfo failed:", result);

        return;
    end;

    u8 = result;
    local v109 = result.ForgeLevel or 0;
    local v110 = result.ForgeBonuses or {};
    local v111 = result.ProjectedBonuses or {};
    local v112 = EquipmentData.ComputeItemGearScoreWithBonuses(v108, v110);
    u51.Current.Text = SharedUtils.FormatWithCommas(v112);

    if result.IsMaxed then
        u51.Upgrade.Text = SharedUtils.FormatWithCommas(v112);
    else
        local v113 = EquipmentData.ComputeItemGearScoreWithBonuses(v108, v111);
        u51.Upgrade.Text = SharedUtils.FormatWithCommas(v113);
    end;

    if result.IsMaxed then
        u52.Upgrade.Text = ForgeData.GetLevelName(v109) .. " (MAX)";
    else
        u52.Upgrade.Text = ForgeData.GetLevelName(v109) .. " → " .. ForgeData.GetLevelName(v109 + 1);
    end;

    local v114 = {};

    if v108.BaseDamage then
        table.insert(v114, {
            Key = "BaseDamage",
            IsBaseDamage = true,
            Value = v108.BaseDamage
        });
    end;

    if v108.GuaranteedStat and v108.GuaranteedStat.StatKey then
        table.insert(v114, {
            Key = v108.GuaranteedStat.StatKey,
            Value = v108.GuaranteedStat.Value
        });
    end;

    if v108.Stats then
        for i, v in v108.Stats do
            table.insert(v114, {
                Key = i,
                Value = v
            });
        end;
    end;

    ClearStatRows();
    local v115 = nil;

    for i, v in v114 do
        local v116 = v.IsBaseDamage and "SoulBaseDamage" or v.Key;
        local v117 = u50:Clone();
        v117.Name = "Stat_" .. v.Key;
        v117.LayoutOrder = i;
        v117.Visible = true;
        local Icon = v117.Main.Icon;
        Icon.StatName.Text = EquipmentData.StatDisplayNames[v116] or v.Key;
        Icon.Info.Text = EquipmentData.StatDescriptions[v116] or "";
        local StatIcon = Image_Data.GetStatIcon(v116, v108.Slot);

        if StatIcon then
            Icon.Image = StatIcon;
        end;

        local UpgradeArrow = v117.Main.UpgradeArrow;
        local v118 = v110[v.Key] or 0;
        local v119 = v.Value + v118;
        UpgradeArrow.Current.Text = EquipmentData.FormatStatValue(v116, v119, v108.Slot);
        UpgradeArrow.Percentage.Text = "";
        local v120;

        if result.IsMaxed then
            v120 = v119;
        else
            v120 = v.Value + (v111[v.Key] or v118);
        end;

        if v120 == v119 then
            UpgradeArrow.After.Text = "MAX";
            UpgradeArrow.After.TextColor3 = u57.Max;
        else
            UpgradeArrow.After.Text = EquipmentData.FormatStatValue(v116, v120, v108.Slot);
            UpgradeArrow.After.TextColor3 = u57.Default;

            if not result.IsMaxed and (not v115 and v119 ~= 0) then
                v115 = (v120 - v119) / math.abs(v119) * 100;
            end;
        end;

        v117.Parent = u49;
    end;

    if not result.IsMaxed and v115 then
        u52.Upgrade.RichText = true;
        u52.Upgrade.Text = u52.Upgrade.Text .. string.format("  <font color=\"rgb(120,220,120)\">(%+.1f%% all stats)</font>", v115);
    end;

    if not result.AffixCapped and result.LevelsUntilAffix then
        local LevelsUntilAffix = result.LevelsUntilAffix;
        local v121 = u50:Clone();
        v121.Name = "Stat_NewAffix";
        v121.LayoutOrder = #v114 + 1;
        v121.Visible = true;
        local Icon = v121.Main.Icon;
        Icon.StatName.Text = "New Stat Affix";
        Icon.Info.Text = LevelsUntilAffix == 1 and "In 1 Level" or "In " .. LevelsUntilAffix .. " Levels";
        local UpgradeArrow = v121.Main.UpgradeArrow;
        UpgradeArrow.Current.Text = "???";
        UpgradeArrow.Current.TextColor3 = u57.Default;
        UpgradeArrow.After.Text = "";
        UpgradeArrow.Percentage.Text = "";
        v121.Parent = u49;
    end;

    local v122 = result.CanForge and not result.IsMaxed;
    local Button = u22:FindFirstChild("Button");

    if Button then
        Button.Active = v122;
        Button.AutoButtonColor = v122;
        local Item = Button:FindFirstChild("Item");

        if Item then
            Item.ImageTransparency = v122 and 0 or 0.5;
        end;
    end;

    local v123 = v122 and "Can" or "Cannot";

    if u54 then
        for i, v in u54 do
            v.Enabled = i == v123;
        end;
    end;

    local v124 = (result.ReforgeStonesOwned or 0) >= (result.ReforgeCost or 0);
    local v125 = result.CanReforge == true;

    if u23 then
        u23.Active = v125;
        u23.AutoButtonColor = v125;
        local Status = u23:FindFirstChild("Status");

        if Status and Status:IsA("ImageLabel") then
            Status.Image = v124 and Image_Data.ForgeUI.On or Image_Data.ForgeUI.Off;
        end;
    end;

    if u24 then
        u24.Text = "x" .. ((u2.Data and u2.Data.CraftingMaterials or {})[ForgeData.REFORGE_MATERIAL_ID] or 0);
    end;

    UpdateModifierAmounts();
    UpdateActionInfo();

    if not u53 then
        return;
    end;

    local v126 = u2.Data and u2.Data.Currency or 0;

    if v126 >= 1000000000 then
        u53.Text = SharedUtils.FormatNumber(v126);

        return;
    end;

    u53.Text = SharedUtils.FormatWithCommas(v126);
end;

local function PopulateItemGrid() -- Line: 671
    -- upvalues: u47 (ref), u48 (ref), u2 (ref), u59 (copy), ForgeData (copy), u58 (copy), RarityIndex (copy), RarityColors (copy), EquipmentTemplates (copy), u57 (copy), Image_Data (copy), u9 (ref), u10 (ref), u55 (ref)
    for _, child in u47:GetChildren() do
        if child:IsA("Frame") and (child ~= u48 and child.Name ~= "InvisiblePadding") then
            child:Destroy();
        end;
    end;

    local Data = u2.Data;
    local v127 = Data.PlayerLevel or 1;
    local v128 = {};
    local v129 = {};

    if Data.Equipment then
        for _, v in u59 do
            local v130 = Data.Equipment[v];

            if type(v130) == "table" and (v130.GUID and (v130.Identified ~= false and ForgeData.IsForgeable(v130.ItemId))) then
                table.insert(v128, v130);
                v129[v130.GUID] = true;
            end;
        end;
    end;

    if Data.EquipmentInventory then
        for _, v in Data.EquipmentInventory do
            if type(v) == "table" and (v.GUID and (v.Identified ~= false and ForgeData.IsForgeable(v.ItemId))) then
                table.insert(v128, v);
            end;
        end;
    end;

    table.sort(v128, function(p131, p132) -- Line: 704
        -- upvalues: u58 (ref), RarityIndex (ref)
        local v133 = u58[p131.Slot] or 9;
        local v134 = u58[p132.Slot] or 9;

        if v133 ~= v134 then
            return v133 < v134;
        end;

        local v135 = RarityIndex[p131.Rarity] or 0;
        local v136 = RarityIndex[p132.Rarity] or 0;

        if v135 == v136 then
            return (p131.ForgeLevel or 0) > (p132.ForgeLevel or 0);
        end;

        return v136 < v135;
    end);

    for i, v in v128 do
        local GUID = v.GUID;
        local v137 = RarityColors[v.Rarity];
        local v138 = u48:Clone();
        v138.Name = "ForgeItem_" .. GUID;
        v138.LayoutOrder = i;
        v138.Visible = true;
        local Item_Name = v138:FindFirstChild("Item_Name");

        if Item_Name then
            local Template = EquipmentTemplates.GetTemplate(v.ItemId);
            Item_Name.Text = Template and Template.DisplayName or v.ItemId;
            Item_Name.TextColor3 = v137 and v137.TextColor3 or u57.Default;
        end;

        local Forge_Level = v138:FindFirstChild("Forge_Level");

        if Forge_Level then
            local v139 = v.ForgeLevel or 0;

            if v139 > 0 then
                Forge_Level.Text = "+" .. v139;
                Forge_Level.Visible = true;
            else
                Forge_Level.Visible = false;
            end;
        end;

        local Item_Tier = v138:FindFirstChild("Item_Tier");

        if Item_Tier then
            local Tier = EquipmentTemplates.GetTier(v.ItemId);

            if Tier then
                Item_Tier.Text = "T" .. Tier;
                Item_Tier.Visible = true;
            else
                Item_Tier.Visible = false;
            end;
        end;

        local Item_Level = v138:FindFirstChild("Item_Level");

        if Item_Level then
            if v.LevelReq and v.LevelReq > 0 then
                Item_Level.Text = "Lvl. " .. v.LevelReq;
                Item_Level.TextColor3 = v127 < v.LevelReq and Color3.fromRGB(255, 75, 75) or Color3.fromRGB(180, 180, 180);
                Item_Level.Visible = true;
            else
                Item_Level.Visible = false;
            end;
        end;

        local ItemImage = v138:FindFirstChild("ItemImage");

        if ItemImage then
            local ItemId = v.ItemId;
            local v140;

            if Image_Data.Equipment and Image_Data.Equipment[ItemId] then
                v140 = Image_Data.Equipment[ItemId];
            else
                local Template = EquipmentTemplates.GetTemplate(ItemId);
                v140 = Template and Template.ImageId or "";
            end;

            ItemImage.Image = v140;
        end;

        local Lock_Image = v138:FindFirstChild("Lock_Image");

        if Lock_Image then
            Lock_Image.Visible = v.Locked == true;
        end;

        local Amount = v138:FindFirstChild("Amount");

        if Amount then
            if v129[GUID] then
                Amount.Text = "Equipped";
                Amount.TextColor3 = u57.Success;
                Amount.Visible = true;
            else
                Amount.Visible = false;
            end;
        end;

        local Background = v138:FindFirstChild("Background");

        if Background then
            Background = Background:FindFirstChild("Stroke");
        end;

        if Background and v137 then
            Background.Color = v137.BackgroundColor3;
        end;

        local Delete_Cover = v138:FindFirstChild("Delete_Cover");

        if Delete_Cover then
            Delete_Cover.Visible = false;
        end;

        local Selection_Button = v138:FindFirstChild("Selection_Button");

        if Selection_Button then
            Selection_Button.MouseButton1Click:Connect(function() -- Line: 806
                -- upvalues: u9 (ref), u10 (ref), u55 (ref), GUID (copy)
                if u9 or u10 then
                    return;
                end;

                u55(GUID);
            end);
        end;

        v138.Parent = u47;
    end;
end;

local function ShowStatsView() -- Line: 818
    -- upvalues: u46 (ref), u45 (ref)
    u46.Visible = false;
    u45.Visible = true;
end;

local function ShowSelectionView() -- Line: 823
    -- upvalues: PopulateItemGrid (copy), u45 (ref), u46 (ref)
    PopulateItemGrid();
    u45.Visible = false;
    u46.Visible = true;
end;

local u141 = false;
local u142 = false;

local function SetIndexView(p143: boolean) -- Line: 838
    -- upvalues: u141 (ref), u142 (ref), u46 (ref), u28 (ref), u29 (ref), u45 (ref), u23 (ref), u30 (ref), u31 (ref), u27 (ref), u26 (ref), PopulateItemGrid (copy)
    u141 = p143;

    if p143 then
        u142 = u46.Visible;

        if u28 then
            u28.Visible = false;
        end;

        if u29 then
            u29.Visible = false;
        end;

        u45.Visible = false;
        u46.Visible = false;

        if u23 then
            u23.Visible = false;
        end;

        if u30 then
            u30.Visible = false;
        end;

        if u31 then
            u31.Visible = false;
        end;

        if u27 then
            u27.Visible = true;
        end;

        if u26 then
            u26.Text = "Forge";
        end;
    else
        if u27 then
            u27.Visible = false;
        end;

        if u28 then
            u28.Visible = true;
        end;

        if u29 then
            u29.Visible = true;
        end;

        if u23 then
            u23.Visible = true;
        end;

        if u30 then
            u30.Visible = true;
        end;

        if u31 then
            u31.Visible = true;
        end;

        if u142 then
            PopulateItemGrid();
            u45.Visible = false;
            u46.Visible = true;
        else
            u46.Visible = false;
            u45.Visible = true;
        end;

        if u26 then
            u26.Text = "Index";
        end;
    end;
end;

local function PopulateAffixList(p144: string, p145: userdata) -- Line: 878
    -- upvalues: ForgeData (copy), EquipmentData (copy), RarityIndex (copy), RarityGradient (copy), CollectionService (copy)
    local Template = p145:FindFirstChild("Template");

    if not Template then
        return;
    end;

    Template.Visible = false;

    for _, child in p145:GetChildren() do
        if child.Name == "AffixRow" then
            child:Destroy();
        end;
    end;

    local v146 = ForgeData.FORGE_AFFIX_POOLS[p144];

    if type(v146) ~= "table" then
        return;
    end;

    local v147 = {};

    for _, v in v146 do
        local AffixRarity = ForgeData.GetAffixRarity(v);
        table.insert(v147, {
            Key = v,
            Name = EquipmentData.StatDisplayNames[v] or v,
            Rarity = AffixRarity,
            Rank = RarityIndex[AffixRarity] or 0
        });
    end;

    table.sort(v147, function(p148, p149) -- Line: 905
        if p148.Rank == p149.Rank then
            return p148.Name < p149.Name;
        end;

        return p148.Rank < p149.Rank;
    end);

    for i, v in v147 do
        local v150 = Template:Clone();
        v150.Name = "AffixRow";
        v150.LayoutOrder = i;
        v150.Visible = true;
        local AffixName = v150:FindFirstChild("AffixName");

        if AffixName then
            AffixName.Text = v.Name;
        end;

        local Chance = v150:FindFirstChild("Chance");

        if Chance then
            Chance.Visible = false;
        end;

        RarityGradient.apply(v150, v.Rarity);
        local v151 = EquipmentData.StatDescriptions[v.Key];

        if v151 then
            v150:SetAttribute("Tip", v151);

            if not CollectionService:HasTag(v150, "ToolTip") then
                CollectionService:AddTag(v150, "ToolTip");
            end;
        end;

        v150.Parent = p145;
    end;
end;

local function PopulateAffixIndex() -- Line: 941
    -- upvalues: u27 (ref), u60 (copy), PopulateAffixList (copy)
    if not u27 then
        return;
    end;

    for i, v in u60 do
        local v152 = u27:FindFirstChild(v);

        if v152 then
            PopulateAffixList(i, v152);
        end;
    end;
end;

u55 = function(p153: string) -- Line: 952
    -- upvalues: FindItemByGUID (copy), u6 (ref), u7 (ref), u46 (ref), u45 (ref), PopulateStatsView (copy)
    local v154 = FindItemByGUID(p153);

    if not v154 then
        warn("[ForgeController] Item not found:", p153);

        return;
    end;

    u6 = p153;
    u7 = v154;
    u46.Visible = false;
    u45.Visible = true;
    PopulateStatsView();
end;

u56 = function() -- Line: 968
    -- upvalues: u6 (ref), u7 (ref), u8 (ref), UpdateSelectedHeader (copy), ClearStatRows (copy), u51 (ref), u52 (ref), u22 (ref), u23 (ref), Image_Data (copy), u54 (ref), UpdateActionInfo (copy), u53 (ref), u2 (ref), SharedUtils (copy), u24 (ref), ForgeData (copy), UpdateModifierAmounts (copy), u31 (ref), u11 (ref), u30 (ref), u12 (ref), u46 (ref), u45 (ref)
    u6 = nil;
    u7 = nil;
    u8 = nil;
    UpdateSelectedHeader();
    ClearStatRows();
    u51.Current.Text = "";
    u51.Upgrade.Text = "";
    u52.Upgrade.Text = "";
    local Button = u22:FindFirstChild("Button");

    if Button then
        Button.Active = false;
        Button.AutoButtonColor = false;
        local Item = Button:FindFirstChild("Item");

        if Item then
            Item.ImageTransparency = 0.5;
        end;
    end;

    if u23 then
        u23.Active = false;
        u23.AutoButtonColor = false;
        local Status = u23:FindFirstChild("Status");

        if Status and Status:IsA("ImageLabel") then
            Status.Image = Image_Data.ForgeUI.Off;
        end;
    end;

    if u54 then
        for i, v in u54 do
            v.Enabled = i == "Inactive";
        end;
    end;

    UpdateActionInfo();

    if u53 then
        local v155 = u2.Data and u2.Data.Currency or 0;

        if v155 >= 1000000000 then
            u53.Text = SharedUtils.FormatNumber(v155);
        else
            u53.Text = SharedUtils.FormatWithCommas(v155);
        end;
    end;

    if u24 then
        u24.Text = "x" .. ((u2.Data and u2.Data.CraftingMaterials or {})[ForgeData.REFORGE_MATERIAL_ID] or 0);
    end;

    UpdateModifierAmounts();
    local v156 = u31;
    local v157 = u11;

    if v156 then
        local Status = v156:FindFirstChild("Status");

        if Status and Status:IsA("ImageLabel") then
            Status.Image = v157 and Image_Data.ForgeUI.On or Image_Data.ForgeUI.Off;
        end;
    end;

    local v158 = u30;
    local v159 = u12;

    if v158 then
        local Status = v158:FindFirstChild("Status");

        if Status and Status:IsA("ImageLabel") then
            Status.Image = v159 and Image_Data.ForgeUI.On or Image_Data.ForgeUI.Off;
        end;
    end;

    u46.Visible = false;
    u45.Visible = true;
end;

local function ExecuteForge() -- Line: 993
    -- upvalues: u9 (ref), u6 (ref), u22 (ref), u23 (ref), Image_Data (copy), u18 (ref), u57 (copy), u3 (ref), u11 (ref), u12 (ref), ForgeAnimator (copy), u13 (ref), PopulateStatsView (copy)
    if u9 then
        return;
    end;

    if not u6 then
        return;
    end;

    u9 = true;
    local Button = u22:FindFirstChild("Button");

    if Button then
        Button.Active = false;
        Button.AutoButtonColor = false;
        local Item = Button:FindFirstChild("Item");

        if Item then
            Item.ImageTransparency = 0.5;
        end;
    end;

    if u23 then
        u23.Active = false;
        u23.AutoButtonColor = false;
        local Status = u23:FindFirstChild("Status");

        if Status and Status:IsA("ImageLabel") then
            Status.Image = Image_Data.ForgeUI.Off;
        end;
    end;

    u18.Text = "Forging...";
    u18.TextColor3 = u57.Forging;
    local success, result = pcall(function() -- Line: 1010
        -- upvalues: u3 (ref), u6 (ref), u11 (ref), u12 (ref)
        return u3:ForgeItem(u6, {
            Protect = u11,
            Enhance = u12
        }):expect();
    end);

    if not success or type(result) ~= "table" then
        warn("[ForgeController] ForgeItem error:", result);
        result = {
            Success = false,
            NewLevel = 0
        };
    end;

    local success2, result2 = pcall(ForgeAnimator.Play, result, u13);

    if not success2 then
        warn("[ForgeController] ForgeAnimator error:", result2);
    end;

    u9 = false;
    PopulateStatsView();
end;

local function AutoForgeNotify(p160: string) -- Line: 1037
    -- upvalues: Knit (copy)
    local Controller = Knit.GetController("NotificationController");

    if Controller then
        Controller:Show("Custom", p160, 3, Color3.fromRGB(255, 200, 80), Color3.fromRGB(60, 45, 15), "Error");
    end;
end;

local function PlayerOwnsAutoForge() -- Line: 1049
    -- upvalues: MonetizationList (copy), LocalPlayer (copy), u2 (ref)
    local AutoForge = MonetizationList.AutoForge;

    if not (AutoForge and AutoForge.DoesPlayerOwn) then
        return false;
    end;

    local success, result = pcall(AutoForge.DoesPlayerOwn, LocalPlayer, u2.Data);

    if success then
        success = result == true;
    end;

    return success;
end;

local function SetAutoForgeStatusVisual(p161: boolean, p162: boolean?) -- Line: 1058
    -- upvalues: u41 (ref), u57 (copy), ApplyCheckVisual (copy), u42 (ref)
    if u41 then
        if p161 then
            u41.Text = "Auto Forge - ON";
            u41.TextColor3 = u57.Success;
            u41.Visible = true;
        else
            u41.Visible = false;
        end;
    end;

    ApplyCheckVisual(u42, p161, p162);
end;

local function SetAutoForgeButtons(p163: boolean) -- Line: 1072
    -- upvalues: u44 (ref), u43 (ref)
    if u44 then
        u44.Visible = not p163;
    end;

    if u43 then
        u43.Visible = p163;
    end;
end;

local function StopAutoForge(p164: boolean?) -- Line: 1079
    -- upvalues: u10 (ref), u44 (ref), u43 (ref), u41 (ref), ApplyCheckVisual (copy), u42 (ref)
    u10 = false;

    if u44 then
        u44.Visible = true;
    end;

    if u43 then
        u43.Visible = false;
    end;

    if u41 then
        u41.Visible = false;
    end;

    ApplyCheckVisual(u42, false, p164);
end;

local function StartAutoForge() -- Line: 1089
    -- upvalues: u10 (ref), u6 (ref), u8 (ref), AutoForgeNotify (copy), u41 (ref), u57 (copy), u42 (ref), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret5 (copy), TweenService (copy), TweenInfo_new_ret (copy), u44 (ref), u43 (ref), u9 (ref), ExecuteForge (copy)
    if u10 then
        return;
    end;

    if not (u6 and u8) then
        AutoForgeNotify("Select an item to Auto Forge.");

        return;
    end;

    if u8.IsMaxed then
        AutoForgeNotify("This item is already at max Forge level.");

        return;
    end;

    if not u8.CanForge then
        AutoForgeNotify("Not enough materials to Auto Forge.");

        return;
    end;

    u10 = true;

    if u41 then
        u41.Text = "Auto Forge - ON";
        u41.TextColor3 = u57.Success;
        u41.Visible = true;
    end;

    local v165 = u42;

    if v165 then
        local v166 = v165:GetAttribute("On") or v165:GetAttribute("Off");
        local v167 = {
            BackgroundColor3 = Color3_fromRGB_ret4 or Color3_fromRGB_ret5
        };

        if typeof(v166) == "UDim2" then
            v167.Position = v166;
        end;

        TweenService:Create(v165, TweenInfo_new_ret, v167):Play();
    end;

    if u44 then
        u44.Visible = false;
    end;

    if u43 then
        u43.Visible = true;
    end;

    task.spawn(function() -- Line: 1108
        -- upvalues: u10 (ref), u6 (ref), u8 (ref), u9 (ref), ExecuteForge (ref), u44 (ref), u43 (ref), u41 (ref), u42 (ref), Color3_fromRGB_ret5 (ref), TweenService (ref), TweenInfo_new_ret (ref)
        while u10 and (u6 and (u8 and (not u8.IsMaxed and u8.CanForge))) do
            if u9 then
                task.wait();
            else
                ExecuteForge();
                task.wait(0.05);
            end;
        end;

        u10 = false;

        if u44 then
            u44.Visible = true;
        end;

        if u43 then
            u43.Visible = false;
        end;

        if u41 then
            u41.Visible = false;
        end;

        local v168 = u42;

        if not v168 then
            return;
        end;

        local Attribute = v168:GetAttribute("Off");
        local v169 = {
            BackgroundColor3 = Color3_fromRGB_ret5
        };

        if typeof(Attribute) == "UDim2" then
            v169.Position = Attribute;
        end;

        TweenService:Create(v168, TweenInfo_new_ret, v169):Play();
    end);
end;

local function ExecuteReforge() -- Line: 1131
    -- upvalues: u9 (ref), u6 (ref), u18 (ref), u57 (copy), u3 (ref), u4 (ref), PopulateStatsView (copy)
    if u9 then
        return;
    end;

    if not u6 then
        return;
    end;

    u9 = true;
    u18.Text = "Reforging...";
    u18.TextColor3 = u57.Forging;
    local success, result = pcall(function() -- Line: 1139
        -- upvalues: u3 (ref), u6 (ref)
        return u3:ReforgeItem(u6):expect();
    end);

    if success and (type(result) == "table" and result.Success) then
        u4:Play("Enchant");
        u18.Text = "Affixes rerolled!";
        u18.TextColor3 = u57.Success;
    else
        u18.Text = success and (type(result) == "table" and result.Message) or "Reforge failed";
        u18.TextColor3 = u57.Failed;
    end;

    task.wait(0.6);
    u9 = false;
    PopulateStatsView();
end;

return {
    _Init = function(p170) -- Line: 1163, Name: _Init
        -- upvalues: u1 (ref), u2 (ref), Registry (copy), u3 (ref), Knit (copy), u4 (ref), u5 (ref), u16 (ref), u17 (ref), u45 (ref), u46 (ref), u18 (ref), u28 (ref), u19 (ref), u20 (ref), u21 (ref), u29 (ref), u22 (ref), u32 (ref), u33 (ref), u34 (ref), u35 (ref), u36 (ref), CollectionService (copy), u37 (ref), u38 (ref), u39 (ref), u40 (ref), u41 (ref), u42 (ref), u43 (ref), u44 (ref), u23 (ref), u24 (ref), u27 (ref), u25 (ref), u26 (ref), u30 (ref), u31 (ref), PopulateAffixIndex (copy), u54 (ref), u53 (ref), u47 (ref), u48 (ref), u49 (ref), u50 (ref), u51 (ref), u52 (ref), u11 (ref), u12 (ref), u141 (ref), u142 (ref), PopulateItemGrid (copy), u56 (ref), u10 (ref), Color3_fromRGB_ret5 (copy), TweenService (copy), TweenInfo_new_ret (copy), u9 (ref), SetIndexView (copy), UIController (copy), u6 (ref), Image_Data (copy), ForgeData (copy), UpdateActionInfo (copy), u13 (ref), u57 (copy), Color3_fromRGB_ret4 (copy), MonetizationList (copy), LocalPlayer (copy), AutoForgeNotify (copy), StartAutoForge (copy), u8 (ref), u14 (ref), ExecuteForge (copy), u15 (copy), ExecuteReforge (copy), SharedUtils (copy), UpdateModifierAmounts (copy), PopulateStatsView (copy)
        u1 = p170;
        u2 = Registry:Get("PlayerData");
        u3 = Knit.GetService("ForgeService");
        u4 = Knit.GetController("SoundController");
        pcall(function() -- Line: 1170
            -- upvalues: u5 (ref), Knit (ref)
            u5 = Knit.GetController("WarningController");
        end);
        u16 = u1.Frames:WaitForChild("Forge");
        u17 = u16:WaitForChild("Contents");
        u45 = u17:WaitForChild("StatsView");
        u46 = u17:WaitForChild("SelectionView");
        u18 = u45:WaitForChild("ItemName");
        u28 = u17:WaitForChild("ItemHolder");
        u19 = u28.Container.Add;
        u20 = u19.Button.Add;
        u21 = u19.ItemImage;
        u19.ViewportFrame.Visible = false;
        u29 = u17:WaitForChild("Buttons");
        u22 = u29.Upgrade;
        u32 = u22:WaitForChild("SuccessChance");
        u33 = u22:WaitForChild("AffixChance");
        u34 = u22:WaitForChild("CoinCost");
        u35 = u22:WaitForChild("MaterialCost");
        u36 = u22:WaitForChild("Material_Image");

        if not CollectionService:HasTag(u36, "ToolTip") then
            CollectionService:AddTag(u36, "ToolTip");
        end;

        u37 = u22:FindFirstChild("SkipAnimation");
        u38 = u22:FindFirstChild("SkipAnimationText");
        local v171 = u37 and u37:FindFirstChild("Check");
        u39 = v171;
        u40 = u22:FindFirstChild("AutoForge");
        u41 = u22:FindFirstChild("AutoForge_Status");
        local v172 = u40 and u40:FindFirstChild("Check");
        u42 = v172;
        u43 = u22:FindFirstChild("Stop");
        u44 = u22:FindFirstChild("Button");
        u23 = u16:WaitForChild("Reforge");
        u24 = u23:WaitForChild("Amount");
        local ItemImage = u23:FindFirstChild("ItemImage");

        if ItemImage and not CollectionService:HasTag(ItemImage, "ToolTip") then
            CollectionService:AddTag(ItemImage, "ToolTip");
        end;

        u27 = u17:WaitForChild("Affixes");
        u25 = u16:WaitForChild("Index");
        u26 = u25:WaitForChild("TextLabel");
        u30 = u16:WaitForChild("Enhance");
        u31 = u16:WaitForChild("Protect");
        u31:SetAttribute(
            "Tip",
            "Protect: consume a Protection Scroll to stop failed forges from lowering the item\'s level. Consumed win or lose."
        );
        u30:SetAttribute(
            "Tip",
            "Enhance: consume a Purity Stone to raise this forge\'s success chance. Consumed win or lose."
        );

        for _, v in { u31, u30 } do
            if not CollectionService:HasTag(v, "ToolTip") then
                CollectionService:AddTag(v, "ToolTip");
            end;
        end;

        PopulateAffixIndex();
        local Item = u22.Button:WaitForChild("Item");
        u54 = {
            Can = Item:WaitForChild("Can"),
            Cannot = Item:WaitForChild("Cannot"),
            Inactive = Item:WaitForChild("Inactive")
        };
        u53 = u16:WaitForChild("Balance");
        u47 = u46:WaitForChild("ItemGrid");
        u48 = u47:WaitForChild("TemplateFrame");
        u48.Visible = false;
        u49 = u45.StatNames.Contents.Main;
        u50 = u49:WaitForChild("StatTemplate");
        u50.Visible = false;
        u51 = u45.Header.Score;
        u52 = u45.Header.Level;
        u16:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 1266
            -- upvalues: u16 (ref), u11 (ref), u12 (ref), u141 (ref), u27 (ref), u28 (ref), u29 (ref), u23 (ref), u30 (ref), u31 (ref), u142 (ref), PopulateItemGrid (ref), u45 (ref), u46 (ref), u26 (ref), u56 (ref), u10 (ref), u44 (ref), u43 (ref), u41 (ref), u42 (ref), Color3_fromRGB_ret5 (ref), TweenService (ref), TweenInfo_new_ret (ref)
            if not u16.Visible then
                u10 = false;

                if u44 then
                    u44.Visible = true;
                end;

                if u43 then
                    u43.Visible = false;
                end;

                if u41 then
                    u41.Visible = false;
                end;

                local v173 = u42;

                if not v173 then
                    return;
                end;

                local Attribute = v173:GetAttribute("Off");
                local v174 = {
                    BackgroundColor3 = Color3_fromRGB_ret5
                };

                if typeof(Attribute) == "UDim2" then
                    v174.Position = Attribute;
                end;

                TweenService:Create(v173, TweenInfo_new_ret, v174):Play();

                return;
            end;

            u11 = false;
            u12 = false;
            u141 = false;

            if u27 then
                u27.Visible = false;
            end;

            if u28 then
                u28.Visible = true;
            end;

            if u29 then
                u29.Visible = true;
            end;

            if u23 then
                u23.Visible = true;
            end;

            if u30 then
                u30.Visible = true;
            end;

            if u31 then
                u31.Visible = true;
            end;

            if u142 then
                PopulateItemGrid();
                u45.Visible = false;
                u46.Visible = true;
            else
                u46.Visible = false;
                u45.Visible = true;
            end;

            if u26 then
                u26.Text = "Index";
            end;

            u56();
        end);
        u25.MouseButton1Click:Connect(function() -- Line: 1278
            -- upvalues: u9 (ref), u10 (ref), SetIndexView (ref), u141 (ref)
            if u9 or u10 then
                return;
            end;

            SetIndexView(not u141);
        end);
        local Crafting = u16:FindFirstChild("Crafting");

        if Crafting and Crafting:IsA("GuiButton") then
            Crafting.MouseButton1Click:Connect(function() -- Line: 1286
                -- upvalues: u1 (ref), UIController (ref)
                local Crafting2 = u1.Frames:FindFirstChild("Crafting");

                if not Crafting2 then
                    return;
                end;

                (UIController.getByName("Crafting") or UIController.new(Crafting2)):open();
            end);
        end;

        u19.Button.MouseButton1Click:Connect(function() -- Line: 1295
            -- upvalues: u9 (ref), u10 (ref), u46 (ref), u6 (ref), u45 (ref), PopulateItemGrid (ref)
            if u9 or u10 then
                return;
            end;

            if u46.Visible and u6 then
                u46.Visible = false;
                u45.Visible = true;

                return;
            end;

            PopulateItemGrid();
            u45.Visible = false;
            u46.Visible = true;
        end);
        u31.MouseButton1Click:Connect(function() -- Line: 1305
            -- upvalues: u9 (ref), u10 (ref), u11 (ref), u2 (ref), Knit (ref), u31 (ref), Image_Data (ref)
            if u9 or u10 then
                return;
            end;

            if not u11 and (u2.Data and u2.Data.ProtectionScrolls or 0) < 1 then
                Knit.GetController("NotificationController"):Show("Custom", "No Protection Scrolls!", 3, Color3.fromRGB(255, 100, 100), Color3.fromRGB(80, 30, 30), "Error");

                return;
            end;

            u11 = not u11;
            local v175 = u31;
            local v176 = u11;

            if not v175 then
                return;
            end;

            local Status = v175:FindFirstChild("Status");

            if Status and Status:IsA("ImageLabel") then
                Status.Image = v176 and Image_Data.ForgeUI.On or Image_Data.ForgeUI.Off;
            end;
        end);
        u30.MouseButton1Click:Connect(function() -- Line: 1318
            -- upvalues: u9 (ref), u10 (ref), u12 (ref), u2 (ref), ForgeData (ref), Knit (ref), u30 (ref), Image_Data (ref), UpdateActionInfo (ref)
            if u9 or u10 then
                return;
            end;

            if not u12 then
                local v177 = u2.Data and u2.Data.QuestItems;

                if (v177 and v177[ForgeData.PURITY_ITEM_ID] or 0) < 1 then
                    Knit.GetController("NotificationController"):Show("Custom", "No Purity Stones!", 3, Color3.fromRGB(255, 100, 100), Color3.fromRGB(80, 30, 30), "Error");

                    return;
                end;
            end;

            u12 = not u12;
            local v178 = u30;
            local v179 = u12;

            if v178 then
                local Status = v178:FindFirstChild("Status");

                if Status and Status:IsA("ImageLabel") then
                    Status.Image = v179 and Image_Data.ForgeUI.On or Image_Data.ForgeUI.Off;
                end;
            end;

            UpdateActionInfo();
        end);

        if u37 and u37:IsA("GuiButton") then
            u37.MouseButton1Click:Connect(function() -- Line: 1336
                -- upvalues: u13 (ref), u38 (ref), u57 (ref), u39 (ref), Color3_fromRGB_ret4 (ref), Color3_fromRGB_ret5 (ref), TweenService (ref), TweenInfo_new_ret (ref)
                u13 = not u13;
                local v180 = u13;

                if u38 then
                    u38.TextColor3 = v180 and u57.Success or u57.Failed;
                end;

                local v181 = u39;

                if not v181 then
                    return;
                end;

                local v182 = v180 and v181:GetAttribute("On") or v181:GetAttribute("Off");
                local v183 = {
                    BackgroundColor3 = v180 and Color3_fromRGB_ret4 or Color3_fromRGB_ret5
                };

                if typeof(v182) == "UDim2" then
                    v183.Position = v182;
                end;

                TweenService:Create(v181, TweenInfo_new_ret, v183):Play();
            end);
        end;

        if u40 and u40:IsA("GuiButton") then
            u40.MouseButton1Click:Connect(function() -- Line: 1344
                -- upvalues: u9 (ref), MonetizationList (ref), LocalPlayer (ref), u2 (ref), Knit (ref), u10 (ref), u44 (ref), u43 (ref), u41 (ref), u42 (ref), Color3_fromRGB_ret5 (ref), TweenService (ref), TweenInfo_new_ret (ref), u6 (ref), AutoForgeNotify (ref), u5 (ref), StartAutoForge (ref)
                if u9 then
                    return;
                end;

                local AutoForge = MonetizationList.AutoForge;
                local v184;

                if AutoForge and AutoForge.DoesPlayerOwn then
                    local v185;
                    v184, v185 = pcall(AutoForge.DoesPlayerOwn, LocalPlayer, u2.Data);

                    if v184 then
                        v184 = v185 == true;
                    end;
                else
                    v184 = false;
                end;

                if not v184 then
                    local v186 = MonetizationList.AutoForge and MonetizationList.AutoForge.GamepassId;

                    if v186 then
                        Knit.GetController("MarketplaceController"):PromptGamepass(v186);
                    end;

                    return;
                end;

                if not u10 then
                    if not u6 then
                        AutoForgeNotify("Select an item to Auto Forge.");

                        return;
                    end;

                    if u5 then
                        if not u5:Prompt({
                            Message = "<b>Auto Forge</b> will continuously forge your selected item until it maxes or you run out of <b>materials or currency</b>.\n\nStart Auto Forge?",
                            ConfirmText = "Auto Forge",
                            DenyText = "Cancel"
                        }) then
                            return;
                        end;

                        if u10 or (u9 or not u6) then
                            return;
                        end;
                    end;

                    StartAutoForge();

                    return;
                end;

                u10 = false;

                if u44 then
                    u44.Visible = true;
                end;

                if u43 then
                    u43.Visible = false;
                end;

                if u41 then
                    u41.Visible = false;
                end;

                local v187 = u42;

                if not v187 then
                    return;
                end;

                local Attribute = v187:GetAttribute("Off");
                local v188 = {
                    BackgroundColor3 = Color3_fromRGB_ret5
                };

                if typeof(Attribute) == "UDim2" then
                    v188.Position = Attribute;
                end;

                TweenService:Create(v187, TweenInfo_new_ret, v188):Play();
            end);
        end;

        if u43 and u43:IsA("GuiButton") then
            u43.MouseButton1Click:Connect(function() -- Line: 1388
                -- upvalues: u10 (ref), u44 (ref), u43 (ref), u41 (ref), u42 (ref), Color3_fromRGB_ret5 (ref), TweenService (ref), TweenInfo_new_ret (ref)
                u10 = false;

                if u44 then
                    u44.Visible = true;
                end;

                if u43 then
                    u43.Visible = false;
                end;

                if u41 then
                    u41.Visible = false;
                end;

                local v189 = u42;

                if not v189 then
                    return;
                end;

                local Attribute = v189:GetAttribute("Off");
                local v190 = {
                    BackgroundColor3 = Color3_fromRGB_ret5
                };

                if typeof(Attribute) == "UDim2" then
                    v190.Position = Attribute;
                end;

                TweenService:Create(v189, TweenInfo_new_ret, v190):Play();
            end);
        end;

        u22.Button.MouseButton1Click:Connect(function() -- Line: 1394
            -- upvalues: u9 (ref), u6 (ref), u8 (ref), Knit (ref), u11 (ref), u5 (ref), u14 (ref), ExecuteForge (ref)
            if u9 then
                return;
            end;

            if not u6 then
                return;
            end;

            if u8 and not u8.CanForge then
                Knit.GetController("NotificationController"):Show("Custom", "Not enough materials!", 3, Color3.fromRGB(255, 100, 100), Color3.fromRGB(80, 30, 30), "Error");

                return;
            end;

            if u11 and (u8 and (u8.ProtectApplies and (u5 and not u14))) then
                if not u5:Prompt({
                    Message = "A <b>Protection Scroll</b> will be consumed on this forge <b>whether it succeeds or fails</b>.\n\nIt stops a failed attempt from lowering the item\'s level.\n\nContinue?",
                    ConfirmText = "Forge",
                    DenyText = "Cancel"
                }) then
                    return;
                end;

                if u9 or not u6 then
                    return;
                end;

                u14 = true;
            end;

            ExecuteForge();
        end);
        u23.MouseButton1Click:Connect(function() -- Line: 1426
            -- upvalues: u9 (ref), u10 (ref), u6 (ref), u8 (ref), u5 (ref), u15 (ref), ExecuteReforge (ref), ForgeData (ref)
            if u9 or u10 then
                return;
            end;

            if not u6 then
                return;
            end;

            if not (u8 and u8.CanReforge) then
                return;
            end;

            local v191 = u6;

            if not u5 or u15[v191] then
                ExecuteReforge();

                return;
            end;

            local v192 = u8.ReforgeCost or 0;
            local string_format_ret = string.format("Reforging rerolls <b>ALL</b> of this item\'s stat affixes at once — the affix TYPES can change (e.g. Skill Crit → Bonus Damage), and different affixes may be selected.\n\nCost: <b>%d</b> Reforge Stone%s.", v192, v192 == 1 and "" or "s");

            if (u8.ForgeLevel or 0) >= ForgeData.REFORGE_HIGH_COST_LEVEL then
                string_format_ret = string_format_ret .. string.format("\n\n<b>Heads up:</b> this item is past <b>+%d</b>, so each reforge consumes <b>%d</b> Reforge Stones instead of %d.", ForgeData.REFORGE_HIGH_COST_LEVEL - 1, ForgeData.REFORGE_HIGH_COST, ForgeData.REFORGE_LOW_COST);
            end;

            if not u5:Prompt({
                ConfirmText = "Reforge",
                DenyText = "Cancel",
                Message = string_format_ret
            }) then
                return;
            end;

            if u9 then
                return;
            end;

            if u6 ~= v191 then
                return;
            end;

            if not (u8 and u8.CanReforge) then
                return;
            end;

            u15[v191] = true;
            ExecuteReforge();
        end);
        u2:OnChange(function(p193, p194) -- Line: 1478
            -- upvalues: u16 (ref), u53 (ref), u2 (ref), SharedUtils (ref), u24 (ref), ForgeData (ref), UpdateModifierAmounts (ref), u9 (ref), u141 (ref), u10 (ref), u46 (ref), PopulateItemGrid (ref), u6 (ref), PopulateStatsView (ref)
            if p194[1] ~= "EquipmentInventory" and (p194[1] ~= "Equipment" and (p194[1] ~= "CraftingMaterials" and (p194[1] ~= "Currency" and p194[1] ~= "ProtectionScrolls"))) and p194[1] ~= "QuestItems" or not u16.Visible then
                return;
            end;

            if p194[1] == "Currency" and u53 then
                local v195 = u2.Data and u2.Data.Currency or 0;

                if v195 >= 1000000000 then
                    u53.Text = SharedUtils.FormatNumber(v195);
                else
                    u53.Text = SharedUtils.FormatWithCommas(v195);
                end;
            end;

            if p194[1] == "CraftingMaterials" and u24 then
                u24.Text = "x" .. ((u2.Data and u2.Data.CraftingMaterials or {})[ForgeData.REFORGE_MATERIAL_ID] or 0);
            end;

            if p194[1] == "ProtectionScrolls" or p194[1] == "QuestItems" then
                UpdateModifierAmounts();
            end;

            if u9 or (u141 or u10) then
                return;
            end;

            if u46.Visible then
                PopulateItemGrid();

                return;
            end;

            if u6 then
                PopulateStatsView();
            end;
        end);
        u141 = false;

        if u27 then
            u27.Visible = false;
        end;

        if u28 then
            u28.Visible = true;
        end;

        if u29 then
            u29.Visible = true;
        end;

        if u23 then
            u23.Visible = true;
        end;

        if u30 then
            u30.Visible = true;
        end;

        if u31 then
            u31.Visible = true;
        end;

        if u142 then
            PopulateItemGrid();
            u45.Visible = false;
            u46.Visible = true;
        else
            u46.Visible = false;
            u45.Visible = true;
        end;

        if u26 then
            u26.Text = "Index";
        end;

        u56();

        if u24 then
            u24.Text = "x" .. ((u2.Data and u2.Data.CraftingMaterials or {})[ForgeData.REFORGE_MATERIAL_ID] or 0);
        end;

        UpdateModifierAmounts();
        local v196 = u31;
        local v197 = u11;

        if v196 then
            local Status = v196:FindFirstChild("Status");

            if Status and Status:IsA("ImageLabel") then
                Status.Image = v197 and Image_Data.ForgeUI.On or Image_Data.ForgeUI.Off;
            end;
        end;

        local v198 = u30;
        local v199 = u12;

        if v198 then
            local Status = v198:FindFirstChild("Status");

            if Status and Status:IsA("ImageLabel") then
                Status.Image = v199 and Image_Data.ForgeUI.On or Image_Data.ForgeUI.Off;
            end;
        end;

        local v200 = u13;

        if u38 then
            u38.TextColor3 = v200 and u57.Success or u57.Failed;
        end;

        local v201 = u39;

        if v201 then
            local v202 = v200 and v201:GetAttribute("On") or v201:GetAttribute("Off");

            if typeof(v202) == "UDim2" then
                v201.Position = v202;
            end;

            v201.BackgroundColor3 = v200 and Color3_fromRGB_ret4 or Color3_fromRGB_ret5;
        end;

        u10 = false;

        if u44 then
            u44.Visible = true;
        end;

        if u43 then
            u43.Visible = false;
        end;

        if u41 then
            u41.Visible = false;
        end;

        local v203 = u42;

        if not v203 then
            return;
        end;

        local Attribute = v203:GetAttribute("Off");

        if typeof(Attribute) == "UDim2" then
            v203.Position = Attribute;
        end;

        v203.BackgroundColor3 = Color3_fromRGB_ret5;
    end
};