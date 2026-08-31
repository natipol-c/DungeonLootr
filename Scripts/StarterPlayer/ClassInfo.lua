--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ClassInfo
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.ClassInfo
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Packages.Knit);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local UIController = require(script.Parent.Parent.Controllers.UIController);
local spr = require(script.Parent.Parent.ClientUtils.spr);
local RevealCascade = require(script.Parent.Parent.ClientUtils.RevealCascade);
local LevelData = require(ReplicatedStorage.GameInfo.LevelData);
local Class_Data = require(ReplicatedStorage.Classes.Class_Data);
local ClassMasteryData = require(ReplicatedStorage.GameInfo.ClassMasteryData);
local PrestigeData = require(ReplicatedStorage.GameInfo.PrestigeData);
local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
local RarityData = require(ReplicatedStorage.GameInfo.RarityData);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local Image_Data = require(ReplicatedStorage.GameInfo.Image_Data);
local ClassObtainment = require(ReplicatedStorage.GameInfo.ClassObtainment);
local Rarity_Gradients = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Rarity_Gradients", 5);
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
local u43 = {};
local u44 = {};
local u45 = {};
local u46 = {};
local u47 = {};
local u48 = nil;
local u49 = "All";
local u50 = {
    Rare = "Rare",
    Epic = "Epic",
    Legendary = "Legendary",
    Mythic = "Mythic",
    Celestial = "Celestial",
    NonExistent = "Exotic"
};
local u51 = 0;
local u52 = { {
        key = "ClassInfo",
        label = "Class Info"
    }, {
        key = "SkillInfo",
        label = "Skill Info"
    }, {
        key = "MasteryInfo",
        label = "Mastery Info"
    }, {
        key = "MasteryPassive",
        label = "Mastery Passive"
    } };
local u53 = u52;
local u54 = 1;
local u55 = 0;
local u56 = { "STR", "DEX", "VIT", "INT", "LCK" };
local RarityIndex = RarityData.RarityIndex;
local u57 = #RarityData.RarityOrder + 1;
local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(100, 255, 100);
local Color3_fromRGB_ret3 = Color3.fromRGB(255, 255, 100);
local Color3_fromRGB_ret4 = Color3.fromRGB(85, 255, 130);
local Color3_fromRGB_ret5 = Color3.fromRGB(255, 70, 70);
local u58 = {
    STR = "Strength",
    DEX = "Dexterity",
    VIT = "Vitality",
    INT = "Intelligence",
    LCK = "Luck"
};
local u59 = nil;

local function GetMastery(p60: string) -- Line: 194
    -- upvalues: u3 (ref)
    local ClassMastery = u3.Data.ClassMastery;

    if ClassMastery then
        return ClassMastery[p60];
    end;

    return nil;
end;

local function GetEffectiveMasteryLevel(p61: string) -- Line: 203
    -- upvalues: u3 (ref)
    local ClassMastery = u3.Data.ClassMastery;
    local v62;

    if ClassMastery then
        v62 = ClassMastery[p61];
    else
        v62 = nil;
    end;

    return not v62 and 1 or math.max(v62.Level or 1, v62.HighestLevel or 0);
end;

local function GetMilestoneLevels(p63: string) -- Line: 210
    -- upvalues: ClassMasteryData (copy)
    local v64 = ClassMasteryData.Milestones[p63];

    if not v64 then
        return {};
    end;

    local v65 = {};

    for i in v64 do
        table.insert(v65, i);
    end;

    table.sort(v65);

    return v65;
end;

local function GetNextMilestone(p66: string) -- Line: 223
    -- upvalues: u3 (ref), GetMilestoneLevels (copy)
    local ClassMastery = u3.Data.ClassMastery;
    local v67;

    if ClassMastery then
        v67 = ClassMastery[p66];
    else
        v67 = nil;
    end;

    local v68 = not v67 and 1 or math.max(v67.Level or 1, v67.HighestLevel or 0);

    for _, v in GetMilestoneLevels(p66) do
        if v68 < v then
            return v;
        end;
    end;

    return nil;
end;

local function ClearClones(p69: table) -- Line: 234
    for _, v in p69 do
        v:Destroy();
    end;

    table.clear(p69);
end;

local function ApplyRarityTextGradient(p70: userdata?, p71: string?, p72: boolean?) -- Line: 246
    -- upvalues: Rarity_Gradients (copy), RarityColors (copy)
    if not p70 then
        return;
    end;

    local RarityGradient = p70:FindFirstChild("RarityGradient");

    if RarityGradient and RarityGradient:IsA("UIGradient") then
        RarityGradient:Destroy();
    end;

    local v73 = p71 and Rarity_Gradients and Rarity_Gradients:FindFirstChild(p71);

    if not (v73 and v73:IsA("UIGradient")) then
        if p72 then
            p70.TextColor3 = Color3.new(1, 1, 1);

            return;
        end;

        if p71 then
            p71 = RarityColors[p71];
        end;

        p70.TextColor3 = p71 and p71.TextColor3 or Color3.fromRGB(230, 230, 230);

        return;
    end;

    local v74 = v73:Clone();
    v74.Name = "RarityGradient";
    v74.Enabled = true;
    v74.Parent = p70;
    p70.TextColor3 = Color3.new(1, 1, 1);
end;

local function GetCardFlatColor(p75: string?) -- Line: 276
    -- upvalues: RarityColors (copy)
    if p75 then
        p75 = RarityColors[p75];
    end;

    if p75 then
        p75 = p75.TextColor3;
    end;

    return p75;
end;

local function ApplyCardText(p76: userdata, p77: string, p78) -- Line: 283
    for _, v in { "Active", "InActive" } do
        local v79 = p76:FindFirstChild(v);

        if v79 then
            local Text = v79:FindFirstChild("Text");

            if Text then
                Text.Text = p77;

                if p78 then
                    Text.TextColor3 = p78;
                end;
            end;
        end;
    end;
end;

local function CreateClassCard(u80: string, p81: number) -- Line: 296
    -- upvalues: Class_Data (copy), u10 (ref), ApplyCardText (copy), RarityColors (copy), u59 (ref), u9 (ref), u43 (copy)
    local v82 = Class_Data.Get(u80);

    if v82 then
        local v83 = u10:Clone();
        v83.Name = u80;
        v83.LayoutOrder = p81 or 0;
        v83.Visible = true;
        local Rarity = v82.Rarity;

        if Rarity then
            Rarity = RarityColors[Rarity];
        end;

        if Rarity then
            Rarity = Rarity.TextColor3;
        end;

        ApplyCardText(v83, u80, Rarity);
        local Active = v83:FindFirstChild("Active");
        local InActive = v83:FindFirstChild("InActive");

        if Active then
            Active.Visible = false;
        end;

        if InActive then
            InActive.Visible = true;
        end;

        v83.MouseButton1Click:Connect(function() -- Line: 314
            -- upvalues: u59 (ref), u80 (copy)
            u59(u80);
        end);
        v83.Parent = u9;
        u43[u80] = v83;

        return v83;
    end;
end;

local function RefreshClassList() -- Line: 324
    -- upvalues: u43 (copy), u48 (ref)
    for i, v in u43 do
        local v84 = i == u48;
        local Active = v:FindFirstChild("Active");
        local InActive = v:FindFirstChild("InActive");

        if Active then
            Active.Visible = v84;
        end;

        if InActive then
            InActive.Visible = not v84;
        end;
    end;
end;

local function BuildClassList() -- Line: 344
    -- upvalues: u3 (ref), u47 (copy), Class_Data (copy), RarityIndex (copy), u57 (copy)
    local v85 = u3 and u3.Data and u3.Data.ActiveClass;
    table.clear(u47);

    for _, v in Class_Data.GetAllClassNames() do
        local v86 = Class_Data.Get(v);

        if not v86 or (not v86.IndexHidden or v == v85) then
            table.insert(u47, v);
        end;
    end;

    table.sort(u47, function(p87, p88) -- Line: 355
        -- upvalues: RarityIndex (ref), Class_Data (ref), u57 (ref)
        local v89 = RarityIndex[Class_Data.GetRarity(p87) or ""] or u57;
        local v90 = RarityIndex[Class_Data.GetRarity(p88) or ""] or u57;

        if v89 == v90 then
            return p87 < p88;
        end;

        return v89 < v90;
    end);
end;

local function RebuildClassList() -- Line: 363
    -- upvalues: u43 (copy), u51 (ref), u49 (ref), u50 (copy), u47 (copy), Class_Data (copy), CreateClassCard (copy), RefreshClassList (copy), RevealCascade (copy), u4 (ref)
    local v91 = u43;

    for _, v in v91 do
        v:Destroy();
    end;

    table.clear(v91);
    u51 = u51 + 1;
    local u92 = u51;
    local u93 = u49;
    local v94 = u50[u49];
    local v95 = 0;
    local v96 = {};

    for _, v in u47 do
        if not v94 or (Class_Data.GetRarity(v) or "") == v94 then
            v95 = v95 + 1;
            local v97 = CreateClassCard(v, v95);

            if v97 then
                table.insert(v96, v97);
            end;
        end;
    end;

    RefreshClassList();
    RevealCascade.play(v96, {
        isCurrent = function() -- Line: 390, Name: isCurrent
            -- upvalues: u4 (ref), u51 (ref), u92 (copy), u49 (ref), u93 (copy)
            local Visible = u4.Visible;

            if Visible then
                if u51 == u92 then
                    Visible = u49 == u93;
                else
                    Visible = false;
                end;
            end;

            return Visible;
        end
    });
end;

local function SetActiveTab(p98: string) -- Line: 398
    -- upvalues: u49 (ref), u11 (ref), RebuildClassList (copy)
    u49 = p98;

    if u11 then
        for _, child in u11:GetChildren() do
            if child:IsA("GuiButton") then
                local v99 = child.Name == p98;
                local Active = child:FindFirstChild("Active");
                local Inactive = child:FindFirstChild("Inactive");

                if Active then
                    Active.Visible = v99;
                end;

                if Inactive then
                    Inactive.Visible = not v99;
                end;
            end;
        end;
    end;

    RebuildClassList();
end;

local function RefreshSelectedHeader() -- Line: 417
    -- upvalues: u48 (ref), Class_Data (copy), u3 (ref), u7 (ref), ApplyRarityTextGradient (copy), u8 (ref), Image_Data (copy), u19 (ref), u20 (ref), u21 (ref), GetMilestoneLevels (copy), u22 (ref), u23 (ref), ClassObtainment (copy)
    if not u48 then
        return;
    end;

    local v100 = Class_Data.Get(u48);

    if not v100 then
        return;
    end;

    local v101 = u48;
    local ClassMastery = u3.Data.ClassMastery;
    local v102;

    if ClassMastery then
        v102 = ClassMastery[v101];
    else
        v102 = nil;
    end;

    local v103 = v102 and v102.Level or 1;
    local Rarity = v100.Rarity;

    if u7 then
        u7.Text = u48;
        ApplyRarityTextGradient(u7, Rarity, true);
    end;

    if u8 then
        local ClassIcon = Image_Data.GetClassIcon(v100.DamageType);

        if ClassIcon then
            u8.Image = ClassIcon;
            u8.Visible = true;
        else
            u8.Visible = false;
        end;
    end;

    if u19 then
        u19.Text = Rarity or "Rare";
        ApplyRarityTextGradient(u19, Rarity);
    end;

    if u20 then
        u20.Text = tostring(v103);
    end;

    if u21 then
        local v104 = u48;
        local ClassMastery2 = u3.Data.ClassMastery;
        local v105;

        if ClassMastery2 then
            v105 = ClassMastery2[v104];
        else
            v105 = nil;
        end;

        local v106 = not v105 and 1 or math.max(v105.Level or 1, v105.HighestLevel or 0);
        local v107 = nil;

        for _, v in GetMilestoneLevels(v104) do
            if v106 < v then
                v107 = v;
                break;
            end;
        end;

        u21.Text = v107 and "Level " .. v107 or "Maxed";
    end;

    if u22 then
        u22.Text = v100.DamageType or "Physical";
    end;

    if u23 then
        u23.Text = ClassObtainment.Get(u48, v100);
    end;
end;

local function RefreshXPBar(p108: boolean?) -- Line: 472
    -- upvalues: u48 (ref), u3 (ref), PrestigeData (copy), LevelData (copy), u17 (ref), spr (copy), u55 (ref), u18 (ref)
    if not u48 then
        return;
    end;

    local v109 = u48;
    local ClassMastery = u3.Data.ClassMastery;
    local v110;

    if ClassMastery then
        v110 = ClassMastery[v109];
    else
        v110 = nil;
    end;

    local v111 = v110 and (v110.Level or 1) or 1;
    local v112 = v110 and v110.XP or 0;
    local v113 = u3.Data.ClassPrestige and u3.Data.ClassPrestige[u48];
    local XPRequiredMultiplier = PrestigeData.GetXPRequiredMultiplier(v113 and v113.Prestiges or 0);
    local v114;

    if LevelData.CLASS_LEVEL_CAP <= v111 then
        v114 = 1;
    else
        local v115 = LevelData.GetClassXPForLevel(v111 + 1) * XPRequiredMultiplier;
        local math_floor_ret = math.floor(v115);
        v114 = (math_floor_ret == (1 / 0) or math_floor_ret <= 0) and 1 or math.clamp(v112 / math_floor_ret, 0, 1);
    end;

    if u17 then
        if p108 then
            spr.stop(u17, "Size");
            u17.Size = UDim2.fromScale(v114, 1);
        else
            local math_abs_ret = math.abs(v114 - u55);

            if v114 < u55 or math_abs_ret >= 0.1 then
                spr.target(u17, 0.85, 3, {
                    Size = UDim2.fromScale(v114, 1)
                });
            else
                spr.target(u17, 1, 8, {
                    Size = UDim2.fromScale(v114, 1)
                });
            end;
        end;

        u55 = v114;
    end;

    if u18 then
        if LevelData.CLASS_LEVEL_CAP <= v111 then
            u18.Text = "EXP: MAX";

            return;
        end;

        local v116 = LevelData.GetClassXPForLevel(v111 + 1) * XPRequiredMultiplier;
        u18.Text = "EXP: " .. v112 .. " / " .. math.floor(v116);
    end;
end;

local function RefreshHeadlineStats() -- Line: 524
    -- upvalues: u48 (ref), Class_Data (copy), SharedUtils (copy), u24 (ref), u25 (ref), u26 (ref), u27 (ref)
    if not u48 then
        return;
    end;

    local v117 = Class_Data.Get(u48);

    if not v117 then
        return;
    end;

    local ClassCombatPreview = SharedUtils.GetClassCombatPreview(v117);

    if u24 then
        u24.Text = SharedUtils.FormatNumber(ClassCombatPreview.Health);
    end;

    if u25 then
        u25.Text = "Health";
    end;

    if u26 then
        u26.Text = SharedUtils.FormatNumber(ClassCombatPreview.Attack);
    end;

    if u27 then
        u27.Text = "Attack";
    end;
end;

local function RefreshBaseStats() -- Line: 539
    -- upvalues: u44 (copy), u48 (ref), u28 (ref), u29 (ref), Class_Data (copy), u3 (ref), ClassMasteryData (copy), u56 (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy)
    local v118 = u44;

    for _, v in v118 do
        v:Destroy();
    end;

    table.clear(v118);

    if not (u48 and (u28 and u29)) then
        return;
    end;

    local v119 = Class_Data.Get(u48);

    if not v119 then
        return;
    end;

    local v120 = v119.BaseStats or {};
    local v121 = u48;
    local ClassMastery = u3.Data.ClassMastery;
    local v122;

    if ClassMastery then
        v122 = ClassMastery[v121];
    else
        v122 = nil;
    end;

    local v123, v124;

    if v122 then
        local v125 = {
            [u48] = v122
        };
        v123 = ClassMasteryData.GetGlobalStatBonuses(v125);
        v124 = ClassMasteryData.GetActiveStatBonuses(v125, u48);
    else
        v123 = {
            STR = 0,
            DEX = 0,
            VIT = 0,
            INT = 0,
            LCK = 0
        };
        v124 = {
            STR = 0,
            DEX = 0,
            VIT = 0,
            INT = 0,
            LCK = 0
        };
    end;

    for _, v in u56 do
        local v126 = v120[v] or 0;
        local v127 = v123[v] or 0;
        local v128 = v124[v] or 0;
        local v129 = u29:Clone();
        v129.Visible = true;

        if v127 > 0 then
            v129.Text = "+" .. v126 + v127 .. " " .. v;
            v129.TextColor3 = Color3_fromRGB_ret3;
        elseif v128 > 0 then
            v129.Text = "+" .. v126 + v128 .. " " .. v;
            v129.TextColor3 = Color3_fromRGB_ret2;
        else
            v129.Text = "+" .. v126 .. " " .. v;
            v129.TextColor3 = Color3_fromRGB_ret;
        end;

        v129.Parent = u28;
        table.insert(u44, v129);
    end;
end;

local function RefreshClassInfoPage(p130: boolean?) -- Line: 584
    -- upvalues: RefreshXPBar (copy), RefreshHeadlineStats (copy), RefreshBaseStats (copy)
    RefreshXPBar(p130);
    RefreshHeadlineStats();
    RefreshBaseStats();
end;

local function RefreshSkillsView() -- Line: 593
    -- upvalues: u45 (copy), u48 (ref), u30 (ref), u31 (ref), Class_Data (copy)
    local v131 = u45;

    for _, v in v131 do
        v:Destroy();
    end;

    table.clear(v131);

    if not (u48 and (u30 and u31)) then
        return;
    end;

    local v132 = Class_Data.Get(u48);

    if not v132 then
        return;
    end;

    local v133 = v132.Skills or {};
    local v134 = v132.SkillInfo or {};

    for i = 1, 4 do
        local v135 = v133[i];
        local v136;

        if v135 then
            local v137 = v134[i] or {};
            local v138 = u31:Clone();
            v138.Name = v135;
            v138.Visible = true;
            local Title = v138:FindFirstChild("Title");

            if Title then
                Title.Text = v135;
            end;

            local Description = v138:FindFirstChild("Description");

            if Description then
                Description.Text = v137.Description or "";
            end;

            local Stats = v138:FindFirstChild("Stats");

            if Stats then
                local Damage = Stats:FindFirstChild("Damage");

                if Damage then
                    if v137.TotalMultiplier then
                        if type(v137.TotalMultiplier) == "number" then
                            Damage.Text = "x" .. string.format("%.1f", v137.TotalMultiplier);
                        else
                            Damage.Text = tostring(v137.TotalMultiplier);
                        end;

                        Damage.Visible = true;
                    else
                        Damage.Visible = false;
                    end;
                end;

                local Type = Stats:FindFirstChild("Type");

                if Type then
                    if v137.Protection then
                        Type.Text = v137.Protection;
                        Type.Visible = true;
                    else
                        Type.Visible = false;
                    end;
                end;
            end;

            v138.Parent = u30;
            table.insert(u45, v138);
            v136 = i;
        else
            v136 = i;
        end;
    end;
end;

local function HumanizePassiveId(p139: string) -- Line: 660
    return p139:gsub("_", " ");
end;

local function GetMasteryPassive(p140: string) -- Line: 671
    -- upvalues: ClassMasteryData (copy), Class_Data (copy)
    local v141 = ClassMasteryData.Milestones[p140];

    if not v141 then
        return nil;
    end;

    local v142 = nil;
    local v143 = nil;

    for i, v in v141 do
        local v144 = i;

        for _, v2 in v do
            if v2.Type == "Passive" and (v2.PassiveId and (not v142 or v144 < v142)) then
                v143 = v2.PassiveId;
                v142 = v144;
            end;
        end;
    end;

    if not v143 then
        return nil;
    end;

    local v145 = Class_Data.Get(p140);
    local v146;

    if v145 then
        v146 = v145.Skills;
    else
        v146 = v145;
    end;

    if v145 then
        v145 = v145.SkillInfo;
    end;

    local v147 = nil;

    if v146 then
        v146 = v146[5];
    end;

    if type(v146) == "string" then
        v147 = v146:gsub("^%s*%b()%s*", "");
    end;

    if not v147 or v147 == "" then
        v147 = v143:gsub("_", " ");
    end;

    return {
        Name = v147,
        Description = v145 and (v145[5] and v145[5].Description) or "",
        Level = v142
    };
end;

local function RefreshMasteryPassiveView() -- Line: 714
    -- upvalues: u48 (ref), Class_Data (copy), GetMasteryPassive (copy), u36 (ref), ApplyRarityTextGradient (copy), u37 (ref), u38 (ref), u39 (ref), u40 (ref), u3 (ref), u41 (ref), u42 (ref)
    if not u48 then
        return;
    end;

    local v148 = Class_Data.Get(u48);

    if not v148 then
        return;
    end;

    local v149 = GetMasteryPassive(u48);

    if not v149 then
        return;
    end;

    if u36 then
        u36.Text = v148.Rarity or "Rare";
        ApplyRarityTextGradient(u36, v148.Rarity);
    end;

    if u37 then
        u37.Text = v148.DamageType or "Physical";
    end;

    if u38 then
        u38.Text = v149.Name;
    end;

    if u39 then
        u39.Text = v149.Description;
    end;

    if u40 then
        local v150 = u48;
        local ClassMastery = u3.Data.ClassMastery;
        local v151;

        if ClassMastery then
            v151 = ClassMastery[v150];
        else
            v151 = nil;
        end;

        local v152 = (not v151 and 1 or math.max(v151.Level or 1, v151.HighestLevel or 0)) >= v149.Level;
        u40.Text = v152 and "UNLOCKED" or "LOCKED - Reach Level: " .. v149.Level;

        if u41 then
            u41.Enabled = not v152;
        end;

        if u42 then
            u42.Enabled = v152;
        end;
    end;
end;

local function DescribeBonus(p153, p154) -- Line: 744
    -- upvalues: u58 (copy)
    local Type = p153.Type;

    if Type ~= "SkillDamage" then
        if Type == "Stat" then
            return string.format("+%d %s", p153.Value or 0, u58[p153.Stat] or (p153.Stat or ""));
        end;

        if Type == "CooldownReduction" then
            return string.format("All skill cooldowns -%d%%", p153.Value or 0);
        end;

        return Type ~= "Passive" and (Type == "ItemReward" and "Grants an item reward" or "Mastery bonus") or "Unlocks passive: " .. (p153.PassiveId or "Passive"):gsub("_", " ");
    end;

    local math_floor_ret = math.floor((p153.Bonus or 0) * 100 + 0.5);

    if p154 then
        p154 = p154.Skills;
    end;

    local v155 = p154 and p153.Slot and p154[p153.Slot];

    if v155 then
        return string.format("%s damage +%d%%", v155, math_floor_ret);
    end;

    return string.format("Skill %d damage +%d%%", p153.Slot or 0, math_floor_ret);
end;

local function RefreshMasteryView() -- Line: 776
    -- upvalues: u46 (copy), u48 (ref), u33 (ref), u34 (ref), Class_Data (copy), u3 (ref), GetMilestoneLevels (copy), ClassMasteryData (copy), DescribeBonus (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret5 (copy)
    local v156 = u46;

    for _, v in v156 do
        v:Destroy();
    end;

    table.clear(v156);

    if not (u48 and (u33 and u34)) then
        return;
    end;

    local v157 = Class_Data.Get(u48);

    if not v157 then
        return;
    end;

    local v158 = u48;
    local ClassMastery = u3.Data.ClassMastery;
    local v159;

    if ClassMastery then
        v159 = ClassMastery[v158];
    else
        v159 = nil;
    end;

    local v160 = not v159 and 1 or math.max(v159.Level or 1, v159.HighestLevel or 0);

    for _, v in GetMilestoneLevels(u48) do
        local v161 = v;
        local v162 = {};

        for _, v2 in ClassMasteryData.GetMilestonesAtLevel(u48, v) do
            table.insert(v162, DescribeBonus(v2, v157));
        end;

        local v163 = u34:Clone();
        v163.Name = "Milestone_" .. v161;
        v163.LayoutOrder = v161;
        v163.Visible = true;
        local Title = v163:FindFirstChild("Title");

        if Title then
            Title.Text = "LEVEL " .. v161;
        end;

        local Description = v163:FindFirstChild("Description");

        if Description then
            Description.Text = table.concat(v162, "   •   ");
        end;

        local Status = v163:FindFirstChild("Status");

        if Status then
            local v164 = v161 <= v160;
            Status.Text = v164 and "UNLOCKED" or "LOCKED";
            Status.TextColor3 = v164 and Color3_fromRGB_ret4 or Color3_fromRGB_ret5;
        end;

        v163.Parent = u33;
        table.insert(u46, v163);
    end;
end;

local function RebuildActivePages() -- Line: 822
    -- upvalues: u53 (ref), u52 (copy), u48 (ref), GetMasteryPassive (copy), u54 (ref)
    u53 = {};

    for _, v in u52 do
        if v.key == "MasteryPassive" then
            if u48 and GetMasteryPassive(u48) then
                table.insert(u53, v);
            end;
        else
            table.insert(u53, v);
        end;
    end;

    if u54 > #u53 then
        u54 = 1;
    end;
end;

local function ShowPageFrame(p165: string) -- Line: 839
    -- upvalues: u12 (ref), u13 (ref), u32 (ref), u35 (ref)
    if u12 then
        u12.Visible = p165 == "ClassInfo";
    end;

    if u13 then
        u13.Visible = p165 == "SkillInfo";
    end;

    if u32 then
        u32.Visible = p165 == "MasteryInfo";
    end;

    if u35 then
        u35.Visible = p165 == "MasteryPassive";
    end;
end;

local function RefreshCurrentPage(p166: boolean?) -- Line: 847
    -- upvalues: u48 (ref), u53 (ref), u54 (ref), RefreshXPBar (copy), RefreshHeadlineStats (copy), RefreshBaseStats (copy), RefreshSkillsView (copy), RefreshMasteryView (copy), RefreshMasteryPassiveView (copy)
    if not u48 then
        return;
    end;

    local v167 = u53[u54];

    if v167 then
        v167 = v167.key;
    end;

    if v167 == "ClassInfo" then
        RefreshXPBar(p166);
        RefreshHeadlineStats();
        RefreshBaseStats();

        return;
    end;

    if v167 == "SkillInfo" then
        RefreshSkillsView();

        return;
    end;

    if v167 == "MasteryInfo" then
        RefreshMasteryView();

        return;
    end;

    if v167 == "MasteryPassive" then
        RefreshMasteryPassiveView();
    end;
end;

local function SetPage(p168: number) -- Line: 864
    -- upvalues: u53 (ref), u54 (ref), u12 (ref), u13 (ref), u32 (ref), u35 (ref), u14 (ref), u16 (ref), u15 (ref), u48 (ref), RefreshXPBar (copy), RefreshHeadlineStats (copy), RefreshBaseStats (copy), RefreshSkillsView (copy), RefreshMasteryView (copy), RefreshMasteryPassiveView (copy)
    local v169 = #u53;

    if v169 == 0 then
        return;
    end;

    local v170 = (p168 - 1) % v169 + 1;
    u54 = v170;
    local key = u53[v170].key;

    if u12 then
        u12.Visible = key == "ClassInfo";
    end;

    if u13 then
        u13.Visible = key == "SkillInfo";
    end;

    if u32 then
        u32.Visible = key == "MasteryInfo";
    end;

    if u35 then
        u35.Visible = key == "MasteryPassive";
    end;

    if u14 then
        u14.Text = u53[v170].label;
    end;

    local v171 = v170 % v169 + 1;
    local v172 = (v170 - 2) % v169 + 1;

    if u16 then
        u16.Text = u53[v171].label;
    end;

    if u15 then
        u15.Text = u53[v172].label;
    end;

    if not u48 then
        return;
    end;

    local v173 = u53[u54];

    if v173 then
        v173 = v173.key;
    end;

    if v173 == "ClassInfo" then
        RefreshXPBar(true);
        RefreshHeadlineStats();
        RefreshBaseStats();

        return;
    end;

    if v173 == "SkillInfo" then
        RefreshSkillsView();

        return;
    end;

    if v173 == "MasteryInfo" then
        RefreshMasteryView();

        return;
    end;

    if v173 == "MasteryPassive" then
        RefreshMasteryPassiveView();
    end;
end;

u59 = function(p174: string) -- Line: 887, Name: SelectClass
    -- upvalues: u48 (ref), RebuildActivePages (copy), RefreshSelectedHeader (copy), RefreshClassList (copy), SetPage (copy), u54 (ref)
    u48 = p174;
    RebuildActivePages();
    RefreshSelectedHeader();
    RefreshClassList();
    SetPage(u54);
end;

local function RefreshSelectedInfo() -- Line: 902
    -- upvalues: u48 (ref), RefreshSelectedHeader (copy), u53 (ref), u54 (ref), RefreshXPBar (copy), RefreshHeadlineStats (copy), RefreshBaseStats (copy), RefreshSkillsView (copy), RefreshMasteryView (copy), RefreshMasteryPassiveView (copy)
    if not u48 then
        return;
    end;

    RefreshSelectedHeader();

    if not u48 then
        return;
    end;

    local v175 = u53[u54];

    if v175 then
        v175 = v175.key;
    end;

    if v175 == "ClassInfo" then
        RefreshXPBar(nil);
        RefreshHeadlineStats();
        RefreshBaseStats();

        return;
    end;

    if v175 == "SkillInfo" then
        RefreshSkillsView();

        return;
    end;

    if v175 == "MasteryInfo" then
        RefreshMasteryView();

        return;
    end;

    if v175 == "MasteryPassive" then
        RefreshMasteryPassiveView();
    end;
end;

function v1._Init(p176) -- Line: 910
    -- upvalues: u2 (ref), u3 (ref), Registry (copy), u4 (ref), u6 (ref), u7 (ref), u8 (ref), u12 (ref), u13 (ref), u32 (ref), u14 (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), u22 (ref), u23 (ref), u24 (ref), u25 (ref), u26 (ref), u27 (ref), u28 (ref), u29 (ref), u30 (ref), u31 (ref), u33 (ref), u34 (ref), u35 (ref), u36 (ref), u37 (ref), u38 (ref), u39 (ref), u40 (ref), u41 (ref), u42 (ref), u9 (ref), u11 (ref), u10 (ref), u5 (ref), UIController (copy), ReplicatedStorage (copy), SetPage (copy), u54 (ref), BuildClassList (copy), SetActiveTab (copy), u49 (ref), u43 (copy), u59 (ref), u47 (copy), u50 (copy), Class_Data (copy), u48 (ref), RefreshSelectedHeader (copy), u53 (ref), RefreshXPBar (copy), RefreshHeadlineStats (copy), RefreshBaseStats (copy), RefreshSkillsView (copy), RefreshMasteryView (copy), RefreshMasteryPassiveView (copy)
    u2 = p176;
    u3 = Registry:Get("PlayerData");
    u4 = u2.Frames:FindFirstChild("Class");

    if not u4 then
        warn("[ClassInfo] Frames.Class not found");

        return;
    end;

    local Contents = u4:FindFirstChild("Contents");
    local v177;

    if Contents then
        v177 = Contents:FindFirstChild("LeftSection");
    else
        v177 = Contents;
    end;

    if Contents then
        Contents = Contents:FindFirstChild("RightSection");
    end;

    if v177 then
        v177 = v177:FindFirstChild("Profile");
    end;

    u6 = v177;

    if not (u6 and Contents) then
        warn("[ClassInfo] Frames.Class.Contents layout missing (LeftSection.Profile / RightSection)");

        return;
    end;

    u7 = u6:FindFirstChild("ClassName");
    u8 = u6:FindFirstChild("Class_Icon");
    u12 = u6:FindFirstChild("ClassInfo");
    u13 = u6:FindFirstChild("SkillInfo");
    u32 = u6:FindFirstChild("MasteryInfo");
    local PageDisplay = u6:FindFirstChild("PageDisplay");

    if PageDisplay then
        PageDisplay = PageDisplay:FindFirstChild("Title");
    end;

    u14 = PageDisplay;
    local CycleBack = u6:FindFirstChild("CycleBack");
    local CycleForward = u6:FindFirstChild("CycleForward");
    local v178;

    if CycleBack then
        v178 = CycleBack:FindFirstChild("Preview");
    else
        v178 = CycleBack;
    end;

    u15 = v178;
    local v179;

    if CycleForward then
        v179 = CycleForward:FindFirstChild("Preview");
    else
        v179 = CycleForward;
    end;

    u16 = v179;

    if u12 then
        local EXPbar = u12:FindFirstChild("EXPbar");

        if EXPbar then
            local Path = EXPbar:FindFirstChild("Path");

            if Path then
                Path = Path:FindFirstChild("Fill");
            end;

            u17 = Path;
            u18 = EXPbar:FindFirstChild("Info");
        end;

        local Info = u12:FindFirstChild("Info");

        if Info then
            local Rarity = Info:FindFirstChild("Rarity");

            if Rarity then
                Rarity = Rarity:FindFirstChild("Info");
            end;

            u19 = Rarity;
            local ClassLvl = Info:FindFirstChild("ClassLvl");

            if ClassLvl then
                ClassLvl = ClassLvl:FindFirstChild("Info");
            end;

            u20 = ClassLvl;
            local Reward = Info:FindFirstChild("Reward");

            if Reward then
                Reward = Reward:FindFirstChild("Info");
            end;

            u21 = Reward;
            local Archetype = Info:FindFirstChild("Archetype");

            if Archetype then
                Archetype = Archetype:FindFirstChild("Archetype");
            end;

            u22 = Archetype;
            u23 = Info:FindFirstChild("Obtain");
        end;

        local Stats = u12:FindFirstChild("Stats");

        if Stats then
            local Info2 = Stats:FindFirstChild("Info");
            local v180;

            if Info2 then
                v180 = Info2:FindFirstChild("1");
            else
                v180 = Info2;
            end;

            if Info2 then
                Info2 = Info2:FindFirstChild("2");
            end;

            local v181;

            if v180 then
                v181 = v180:FindFirstChild("Icon");
            else
                v181 = v180;
            end;

            if v181 then
                v181 = v181:FindFirstChild("Amount");
            end;

            u24 = v181;

            if v180 then
                v180 = v180:FindFirstChild("Category");
            end;

            u25 = v180;
            local v182;

            if Info2 then
                v182 = Info2:FindFirstChild("Icon");
            else
                v182 = Info2;
            end;

            if v182 then
                v182 = v182:FindFirstChild("Amount");
            end;

            u26 = v182;

            if Info2 then
                Info2 = Info2:FindFirstChild("Category");
            end;

            u27 = Info2;
            u28 = Stats:FindFirstChild("Stats");
            local v183 = u28 and u28:FindFirstChild("Template");
            u29 = v183;

            if u29 then
                u29.Visible = false;
            end;
        end;
    end;

    if u13 then
        u30 = u13:FindFirstChild("Content");
        local v184 = u30 and u30:FindFirstChild("SkillTemplate");
        u31 = v184;

        if u31 then
            u31.Visible = false;
        end;
    end;

    if u32 then
        u33 = u32:FindFirstChild("ScrollingFrame");
        local v185 = u33 and u33:FindFirstChild("Template");
        u34 = v185;

        if u34 then
            u34.Visible = false;
        end;
    end;

    u35 = u6:FindFirstChild("MasteryPassive");
    local v186 = u35 and u35:FindFirstChild("Info");

    if v186 then
        local Rarity = v186:FindFirstChild("Rarity");

        if Rarity then
            Rarity = Rarity:FindFirstChild("Info");
        end;

        u36 = Rarity;
        local Archetype = v186:FindFirstChild("Archetype");

        if Archetype then
            Archetype = Archetype:FindFirstChild("Archetype");
        end;

        u37 = Archetype;
        u38 = v186:FindFirstChild("MasterySkillName");
        u39 = v186:FindFirstChild("MasterySkillDescription");
        u40 = v186:FindFirstChild("Status");

        if u40 then
            u41 = u40:FindFirstChild("Locked");
            u42 = u40:FindFirstChild("Unlocked");
        end;
    end;

    u9 = Contents:FindFirstChild("Selection");

    if not u9 then
        warn("[ClassInfo] Frames.Class.Contents.RightSection.Selection missing");

        return;
    end;

    u11 = Contents:FindFirstChild("Tabs");
    u10 = u9:FindFirstChild("ClassTemplate") or u9:FindFirstChild("1");

    if not u10 then
        warn("[ClassInfo] Selection has no ClassTemplate / placeholder to clone");

        return;
    end;

    u10.Name = "ClassTemplate";
    u10.Visible = false;

    for _, child in u9:GetChildren() do
        if child ~= u10 and (child:IsA("GuiButton") and tonumber(child.Name)) then
            child:Destroy();
        end;
    end;

    u4.Visible = false;
    u5 = UIController._cached[u4] or UIController.new(u4);
    local v187 = u4:FindFirstChild("Exit") or u4:FindFirstChild("Close");

    if v187 then
        v187.MouseButton1Click:Connect(function() -- Line: 1055
            -- upvalues: u5 (ref)
            u5:close();
        end);
    end;

    local Inventory = u4:FindFirstChild("Inventory");

    if Inventory and Inventory:IsA("GuiButton") then
        Inventory.Activated:Connect(function() -- Line: 1064
            -- upvalues: ReplicatedStorage (ref), u2 (ref), UIController (ref)
            if ReplicatedStorage:GetAttribute("IsDungeon") == true then
                return;
            end;

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

    if CycleForward then
        CycleForward.MouseButton1Click:Connect(function() -- Line: 1078
            -- upvalues: SetPage (ref), u54 (ref)
            SetPage(u54 + 1);
        end);
    end;

    if CycleBack then
        CycleBack.MouseButton1Click:Connect(function() -- Line: 1083
            -- upvalues: SetPage (ref), u54 (ref)
            SetPage(u54 - 1);
        end);
    end;

    BuildClassList();

    if u11 then
        for _, child in u11:GetChildren() do
            if child:IsA("GuiButton") then
                child.MouseButton1Click:Connect(function() -- Line: 1099
                    -- upvalues: SetActiveTab (ref), child (copy)
                    SetActiveTab(child.Name);
                end);
            end;
        end;
    end;

    SetActiveTab(u49);
    SetPage(1);
    local ActiveClass = u3.Data.ActiveClass;

    if ActiveClass and (ActiveClass ~= "" and u43[ActiveClass]) then
        u59(ActiveClass);
    elseif u47[1] then
        u59(u47[1]);
    end;

    u4:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 1131
        -- upvalues: u4 (ref), BuildClassList (ref), u3 (ref), u50 (ref), u49 (ref), Class_Data (ref), SetActiveTab (ref), u43 (ref), u59 (ref)
        if not u4.Visible then
            return;
        end;

        BuildClassList();
        local ActiveClass2 = u3.Data.ActiveClass;

        if ActiveClass2 and ActiveClass2 ~= "" then
            local v188 = u50[u49];

            if v188 and (Class_Data.GetRarity(ActiveClass2) or "") ~= v188 then
                u49 = "All";
            end;
        end;

        SetActiveTab(u49);

        if ActiveClass2 and (ActiveClass2 ~= "" and u43[ActiveClass2]) then
            u59(ActiveClass2);
        end;
    end);
    u3:OnChange(function(p189, p190) -- Line: 1154
        -- upvalues: u48 (ref), RefreshSelectedHeader (ref), u53 (ref), u54 (ref), RefreshXPBar (ref), RefreshHeadlineStats (ref), RefreshBaseStats (ref), RefreshSkillsView (ref), RefreshMasteryView (ref), RefreshMasteryPassiveView (ref)
        local v191 = p190[1];

        if (v191 == "ClassMastery" or (v191 == "ActiveClass" or (v191 == "OwnedClasses" or v191 == "ClassPrestige"))) and u48 then
            if not u48 then
                return;
            end;

            RefreshSelectedHeader();

            if not u48 then
                return;
            end;

            local v192 = u53[u54];

            if v192 then
                v192 = v192.key;
            end;

            if v192 == "ClassInfo" then
                RefreshXPBar(nil);
                RefreshHeadlineStats();
                RefreshBaseStats();

                return;
            end;

            if v192 == "SkillInfo" then
                RefreshSkillsView();

                return;
            end;

            if v192 == "MasteryInfo" then
                RefreshMasteryView();

                return;
            end;

            if v192 == "MasteryPassive" then
                RefreshMasteryPassiveView();
            end;
        end;
    end);
end;

return v1;