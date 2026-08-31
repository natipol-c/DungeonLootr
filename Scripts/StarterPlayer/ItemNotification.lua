--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ItemNotification
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.ItemNotification
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local GameInfo = ReplicatedStorage:WaitForChild("GameInfo");
local KeyData = require(GameInfo:WaitForChild("KeyData"));
local PackageData = require(GameInfo:WaitForChild("PackageData"));
local QuestItemData = require(GameInfo:WaitForChild("QuestItemData"));
local ClassItemData = require(GameInfo:WaitForChild("ClassItemData"));
local ItemData = require(GameInfo:WaitForChild("ItemData"));
local BuffPotionData = require(GameInfo:WaitForChild("BuffPotionData"));
local ConsumableData = require(GameInfo:WaitForChild("ConsumableData"));
local MutationData = require(GameInfo:WaitForChild("MutationData"));
local Image_Data = require(GameInfo:WaitForChild("Image_Data"));
local RarityColors = require(ReplicatedStorage:WaitForChild("SharedDictionaries"):WaitForChild("RarityColors"));
local u1 = {};
local TweenInfo_new_ret = TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.In);
local TweenInfo_new_ret3 = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.In);
local Color3_fromRGB_ret = Color3.fromRGB(80, 255, 120);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 80, 80);
local Color3_fromRGB_ret3 = Color3.fromRGB(255, 255, 80);

local function ResolveMaterialVisuals(p2: string) -- Line: 109
    -- upvalues: ItemData (copy), RarityColors (copy), Image_Data (copy)
    local Material = ItemData.GetMaterial(p2);

    if Material then
        local v3 = Material.Rarity and RarityColors[Material.Rarity];

        return (Material.Icon == nil or Material.Icon == "") and "rbxassetid://84358227802152" or (Material.Icon or "rbxassetid://84358227802152"), v3 and v3.TextColor3 or nil;
    end;

    local v4 = Image_Data.Crystals and Image_Data.Crystals[p2];

    if v4 and v4 ~= "" then
        return v4, nil;
    end;

    return "rbxassetid://84358227802152", nil;
end;

function u1._Init(p5) -- Line: 128
    -- upvalues: Registry (copy), TweenService (copy), TweenInfo_new_ret2 (copy), TweenInfo_new_ret3 (copy), SharedUtils (copy), TweenInfo_new_ret (copy), Knit (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), u1 (copy), Color3_fromRGB_ret3 (copy), KeyData (copy), PackageData (copy), ResolveMaterialVisuals (copy), ItemData (copy), QuestItemData (copy), RarityColors (copy), ClassItemData (copy), Image_Data (copy), BuffPotionData (copy), ConsumableData (copy), ReplicatedStorage (copy), MutationData (copy)
    local u6 = Registry:Get("PlayerData");
    local NotificationList = p5.HUD:FindFirstChild("NotificationList");

    if not NotificationList then
        warn("[ItemNotification] HUD.NotificationList not found");

        return;
    end;

    local CanvasGroup = NotificationList:FindFirstChild("CanvasGroup");

    if not (CanvasGroup and CanvasGroup:IsA("CanvasGroup")) then
        warn("[ItemNotification] CanvasGroup template not found in NotificationList");

        return;
    end;

    if not CanvasGroup:FindFirstChild("Template") then
        warn("[ItemNotification] CanvasGroup.Template not found — template not rewired?");

        return;
    end;

    CanvasGroup.Visible = false;
    local CanvasGroup_old = NotificationList:FindFirstChild("CanvasGroup_old");

    if CanvasGroup_old then
        CanvasGroup_old.Visible = false;
    end;

    if not NotificationList:FindFirstChildWhichIsA("UIListLayout") then
        local UIListLayout = Instance.new("UIListLayout");
        UIListLayout.FillDirection = Enum.FillDirection.Vertical;
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
        UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
        UIListLayout.Padding = UDim.new(0, 4);
        UIListLayout.Parent = NotificationList;
    end;

    local u7 = 0;
    local u8 = {};
    local u9 = {};

    local function ExpireToast(u10) -- Line: 186
        -- upvalues: u9 (copy), u8 (copy), TweenService (ref), TweenInfo_new_ret2 (ref), TweenInfo_new_ret3 (ref)
        if not u10 or u10.Exiting then
            return;
        end;

        u10.Exiting = true;

        if u10.MergeKey and u9[u10.MergeKey] == u10 then
            u9[u10.MergeKey] = nil;
        end;

        local Thread = u10.Thread;
        u10.Thread = nil;

        if Thread and coroutine.running() ~= Thread then
            pcall(task.cancel, Thread);
        end;

        local Notif = u10.Notif;
        local Scale = u10.Scale;

        local function drop() -- Line: 206
            -- upvalues: u8 (ref), u10 (copy)
            local table_find_ret = table.find(u8, u10);

            if table_find_ret then
                table.remove(u8, table_find_ret);
            end;
        end;

        if not (Notif and Notif.Parent) then
            local table_find_ret = table.find(u8, u10);

            if table_find_ret then
                table.remove(u8, table_find_ret);
            end;

            return;
        end;

        if Scale then
            TweenService:Create(Scale, TweenInfo_new_ret2, {
                Scale = 0
            }):Play();
        end;

        local v11 = TweenService:Create(Notif, TweenInfo_new_ret3, {
            GroupTransparency = 1
        });
        v11:Play();
        v11.Completed:Once(function() -- Line: 221
            -- upvalues: u8 (ref), u10 (copy), Notif (copy)
            local table_find_ret = table.find(u8, u10);

            if table_find_ret then
                table.remove(u8, table_find_ret);
            end;

            if Notif.Parent then
                Notif:Destroy();
            end;
        end);
    end;

    local function ArmLifetime(u12, p13) -- Line: 232
        -- upvalues: ExpireToast (copy)
        local Thread = u12.Thread;
        u12.Thread = nil;

        if Thread and coroutine.running() ~= Thread then
            pcall(task.cancel, Thread);
        end;

        u12.Thread = task.delay(p13, function() -- Line: 238
            -- upvalues: ExpireToast (ref), u12 (copy)
            ExpireToast(u12);
        end);
    end;

    local function applyAmount(p14: any, p15: number?, p16) -- Line: 244
        -- upvalues: SharedUtils (ref)
        if not p14 then
            return;
        end;

        if not p15 or math.abs(p15) <= 1 then
            p14.Visible = false;

            return;
        end;

        p14.Text = (p15 > 0 and "+" or "-") .. SharedUtils.FormatNumber((math.abs(p15)));
        p14.TextColor3 = p16;
        p14.Visible = true;
    end;

    local function show(p17: string?, p18: string, p19, p20: number?, p21: string?, u22: table?) -- Line: 272
        -- upvalues: u9 (copy), SharedUtils (ref), TweenService (ref), TweenInfo_new_ret (ref), ArmLifetime (copy), u8 (copy), ExpireToast (copy), CanvasGroup (copy), u7 (ref), NotificationList (copy), Knit (ref)
        if p21 and p20 then
            local v23 = u9[p21];

            if v23 and (not v23.Exiting and (v23.Notif and v23.Notif.Parent)) then
                v23.Amount = (v23.Amount or 0) + p20;
                local ItemAmount = v23.ItemAmount;
                local Amount = v23.Amount;
                local v24 = v23.TextColor or p19;

                if ItemAmount then
                    if Amount and math.abs(Amount) > 1 then
                        ItemAmount.Text = (Amount > 0 and "+" or "-") .. SharedUtils.FormatNumber((math.abs(Amount)));
                        ItemAmount.TextColor3 = v24;
                        ItemAmount.Visible = true;
                    else
                        ItemAmount.Visible = false;
                    end;
                end;

                if v23.Scale then
                    v23.Scale.Scale = 0.85;
                    TweenService:Create(v23.Scale, TweenInfo_new_ret, {
                        Scale = 1
                    }):Play();
                end;

                ArmLifetime(v23, 2.5);

                return;
            end;
        end;

        if #u8 >= 7 then
            for _, v in u8 do
                if not v.Exiting then
                    ExpireToast(v);
                    break;
                end;
            end;
        end;

        local v25 = CanvasGroup:Clone();
        u7 = u7 + 1;
        v25.LayoutOrder = u7;
        local Template = v25:FindFirstChild("Template");
        local v26;

        if Template then
            v26 = Template:FindFirstChild("Frame");
        else
            v26 = Template;
        end;

        if not v26 then
            v25:Destroy();
            warn("[ItemNotification] template clone missing Template.Frame");

            return;
        end;

        local ItemImage = v26:FindFirstChild("ItemImage");

        if ItemImage then
            if p17 and p17 ~= "" then
                ItemImage.Image = p17;
                ItemImage.Visible = true;
            else
                ItemImage.Visible = false;
            end;
        end;

        local ItemName = v26:FindFirstChild("ItemName");

        if ItemName then
            ItemName.Text = p18;
            ItemName.TextColor3 = p19;
        end;

        local ItemAmount = v26:FindFirstChild("ItemAmount");

        if ItemAmount then
            if p20 and math.abs(p20) > 1 then
                ItemAmount.Text = (p20 > 0 and "+" or "-") .. SharedUtils.FormatNumber((math.abs(p20)));
                ItemAmount.TextColor3 = p19;
                ItemAmount.Visible = true;
            else
                ItemAmount.Visible = false;
            end;
        end;

        local v27 = Template:FindFirstChildWhichIsA("UIScale");

        if v27 then
            v27.Scale = 0;
        end;

        v25.GroupTransparency = 1;
        v25.Visible = true;
        v25.Parent = NotificationList;
        local v28 = {
            Exiting = false,
            Notif = v25,
            Scale = v27
        };

        if p21 then
            v28.MergeKey = p21;
            v28.ItemAmount = ItemAmount;
            v28.TextColor = p19;
            v28.Amount = p20;
            u9[p21] = v28;
        end;

        table.insert(u8, v28);

        if v27 then
            TweenService:Create(v27, TweenInfo_new_ret, {
                Scale = 1
            }):Play();
        end;

        TweenService:Create(v25, TweenInfo_new_ret, {
            GroupTransparency = 0
        }):Play();

        if u22 and (u22.sound and u22.sound ~= "") then
            pcall(function() -- Line: 374
                -- upvalues: Knit (ref), u22 (copy)
                local Controller = Knit.GetController("SoundController");

                if Controller then
                    Controller:Play(u22.sound);
                end;
            end);
        end;

        ArmLifetime(v28, 0.3 + (u22 and u22.holdTime or 2.5));
    end;

    function u1.ShowCurrency(p29: number) -- Line: 389
        -- upvalues: show (copy), Color3_fromRGB_ret (ref), Color3_fromRGB_ret2 (ref)
        if p29 == 0 then
            return;
        end;

        show("rbxassetid://74935697538651", "Coins", p29 > 0 and Color3_fromRGB_ret or Color3_fromRGB_ret2, p29);
    end;

    function u1.ShowStars(p30: number) -- Line: 398
        -- upvalues: show (copy), Color3_fromRGB_ret3 (ref), Color3_fromRGB_ret2 (ref)
        if p30 == 0 then
            return;
        end;

        show("rbxassetid://114723613835661", "Stars", p30 > 0 and Color3_fromRGB_ret3 or Color3_fromRGB_ret2, p30);
    end;

    function u1.ShowItem(p31: string, p32: string?, p33, p34: number?) -- Line: 411
        -- upvalues: show (copy)
        show(p32 or "rbxassetid://84358227802152", p31, p33 or Color3.new(1, 1, 1), p34);
    end;

    function u1.ShowClassItem(p35: string, p36: string?, p37) -- Line: 421
        -- upvalues: show (copy)
        show(p36 or "rbxassetid://84358227802152", p35, p37 or Color3.new(1, 1, 1), nil, nil, {
            holdTime = 8,
            sound = "UI_LegendaryChest"
        });
    end;

    function u1.ShowPlayerXP(p38: number) -- Line: 430
        -- upvalues: show (copy)
        if p38 <= 0 then
            return;
        end;

        show(nil, "EXP", Color3.new(1, 1, 1), p38, "PlayerXP");
    end;

    function u1.ShowClassXP(p39: number) -- Line: 438
        -- upvalues: show (copy)
        if p39 <= 0 then
            return;
        end;

        show(nil, "Class EXP", Color3.new(1, 1, 1), p39, "ClassXP");
    end;

    local u40 = u6.Data.Currency or 0;
    local u41 = u6.Data.Stars or 0;
    local u42 = {};
    local Keys = u6.Data.Keys;

    if Keys then
        for i, v in Keys do
            u42[i] = v;
        end;
    end;

    local u43 = {};
    local Packs = u6.Data.Packs;

    if Packs then
        for i, v in Packs do
            u43[i] = v;
        end;
    end;

    local u44 = {};
    local BuffPotions = u6.Data.BuffPotions;

    if BuffPotions then
        for i, v in BuffPotions do
            u44[i] = v;
        end;
    end;

    local u45 = {};
    local Consumables = u6.Data.Consumables;

    if Consumables then
        for i, v in Consumables do
            u45[i] = v;
        end;
    end;

    local u46 = {};
    local CraftingMaterials = u6.Data.CraftingMaterials;

    if CraftingMaterials then
        for i, v in CraftingMaterials do
            u46[i] = v;
        end;
    end;

    local u47 = {};
    local QuestItems = u6.Data.QuestItems;

    if QuestItems then
        for i, v in QuestItems do
            u47[i] = v;
        end;
    end;

    local u48 = {};
    local u49 = {};
    local u50 = {};
    local u51 = {};
    local u52 = false;
    local u53 = {};
    local ClassItems = u6.Data.ClassItems;

    if ClassItems then
        for _, v in ClassItems do
            u53[v] = true;
        end;
    end;

    local function keyIdToTier(p54: string) -- Line: 526
        return p54 == "Master" and "Master" or (tonumber(p54:sub(2)) or 1);
    end;

    u6:OnChange(function(p55, p56) -- Line: 535
        -- upvalues: u6 (copy), u40 (ref), u1 (ref), u41 (ref), u42 (copy), KeyData (ref), u43 (copy), PackageData (ref), u46 (copy), u50 (copy), ResolveMaterialVisuals (ref), ItemData (ref), u47 (copy), u48 (copy), QuestItemData (ref), RarityColors (ref), u53 (copy), ClassItemData (ref), Image_Data (ref), u44 (copy), BuffPotionData (ref), u45 (copy), ConsumableData (ref)
        local v57 = p56[1];

        if v57 == "Currency" then
            local v58 = u6.Data.Currency or 0;
            local v59 = v58 - u40;
            u40 = v58;

            if v59 ~= 0 then
                u1.ShowCurrency(v59);
            end;
        elseif v57 == "Stars" then
            local v60 = u6.Data.Stars or 0;
            local v61 = v60 - u41;
            u41 = v60;

            if v61 ~= 0 then
                u1.ShowStars(v61);
            end;
        elseif v57 == "Keys" and p56[2] then
            local v62 = p56[2];
            local Keys2 = u6.Data.Keys;
            local v63 = Keys2 and (Keys2[v62] or 0) or 0;
            local v64 = u42[v62] or 0;
            u42[v62] = v63;
            local v65 = v63 - v64;

            if v65 ~= 0 then
                local v66 = v62 == "Master" and "Master" or (tonumber(v62:sub(2)) or 1);
                local KeyName = KeyData.GetKeyName(v66);
                local KeyColor = KeyData.GetKeyColor(v66);
                local KeyIcon = KeyData.GetKeyIcon(v66);
                u1.ShowItem(KeyName, KeyIcon, KeyColor, v65);
            end;
        elseif v57 == "Packs" and p56[2] then
            local v67 = p56[2];
            local Packs2 = u6.Data.Packs;
            local v68 = Packs2 and (Packs2[v67] or 0) or 0;
            local v69 = u43[v67] or 0;
            u43[v67] = v68;
            local v70 = v68 - v69;

            if v70 > 0 then
                local v71 = PackageData.Get(v67);

                if v71 then
                    v67 = v71.Name or v67;
                end;

                u1.ShowItem(v67, v71 and v71.Icon or nil, Color3.fromRGB(255, 200, 80), v70);
            end;
        else
            if v57 == "CraftingMaterials" then
                local v72 = u6.Data.CraftingMaterials or {};

                for i, v in v72 do
                    local v73 = (v or 0) - (u46[i] or 0);
                    u46[i] = v;

                    if v73 > 0 then
                        if u50[i] then
                            u50[i] = nil;
                        else
                            local v74, v75 = ResolveMaterialVisuals(i);
                            local Material = ItemData.GetMaterial(i);
                            local v76;

                            if Material then
                                v76 = Material.Name or i;
                            else
                                v76 = i;
                            end;

                            u1.ShowItem(v76, v74, v75 or Color3.fromRGB(150, 215, 255), v73);
                        end;
                    end;
                end;

                for i in u46 do
                    if v72[i] == nil then
                        u46[i] = nil;
                    end;
                end;

                return;
            end;

            if v57 == "QuestItems" and p56[2] then
                local v77 = p56[2];
                local QuestItems2 = u6.Data.QuestItems;
                local v78 = QuestItems2 and (QuestItems2[v77] or 0) or 0;
                local v79 = u47[v77] or 0;
                u47[v77] = v78;
                local v80 = v78 - v79;

                if v80 > 0 then
                    if u48[v77] then
                        u48[v77] = nil;

                        return;
                    end;

                    local v81 = QuestItemData.Get(v77);

                    if v81 then
                        v77 = v81.DisplayName or v77;
                    end;

                    local v82;

                    if v81 then
                        v82 = v81.Icon or nil;
                    else
                        v82 = nil;
                    end;

                    if v81 then
                        v81 = RarityColors[v81.Rarity];
                    end;

                    local v83 = v81 and v81.TextColor3 or Color3.fromRGB(180, 80, 255);
                    u1.ShowItem(v77, v82, v83, v80);
                end;
            else
                if v57 == "ClassItems" then
                    for _, v in u6.Data.ClassItems or {} do
                        if not u53[v] then
                            u53[v] = true;
                            local v84 = ClassItemData.Get(v);
                            local v85;

                            if v84 then
                                v85 = RarityColors[v84.Rarity];
                            else
                                v85 = v84;
                            end;

                            local v86 = v85 and v85.TextColor3 or Color3.fromRGB(255, 100, 100);
                            local v87 = Image_Data.Class_Items or {};
                            local v88 = v84 and v84.Icon or v87[string.gsub(v, "%s", "")];

                            if not v88 and (v84 and v84.ClassName) then
                                v88 = v87[string.gsub(v84.ClassName, "%s", "")];
                            end;

                            u1.ShowClassItem(v, v88, v86);
                        end;
                    end;

                    return;
                end;

                if v57 == "BuffPotions" then
                    local v89 = u6.Data.BuffPotions or {};

                    for i, v in v89 do
                        local v90 = (v or 0) - (u44[i] or 0);
                        u44[i] = v;

                        if v90 > 0 then
                            local Potion = BuffPotionData.GetPotion(i);
                            local v91;

                            if Potion then
                                v91 = Potion.Name or i;
                            else
                                v91 = i;
                            end;

                            u1.ShowItem(v91, Potion and Potion.Icon or nil, Color3.fromRGB(120, 200, 255), v90);
                        end;
                    end;

                    for i in u44 do
                        if v89[i] == nil then
                            u44[i] = nil;
                        end;
                    end;

                    return;
                end;

                if v57 == "Consumables" then
                    local v92 = u6.Data.Consumables or {};

                    for i, v in v92 do
                        local v93 = (v or 0) - (u45[i] or 0);
                        u45[i] = v;

                        if v93 > 0 then
                            local Consumable = ConsumableData.GetConsumable(i);
                            local v94;

                            if Consumable then
                                v94 = Consumable.Name or i;
                            else
                                v94 = i;
                            end;

                            local v95;

                            if Consumable then
                                v95 = Consumable.Icon or nil;
                            else
                                v95 = nil;
                            end;

                            local v96 = Consumable and Consumable.Rarity and RarityColors[Consumable.Rarity];
                            local v97 = v96 and v96.TextColor3 or Color3.fromRGB(255, 215, 120);
                            u1.ShowItem(v94, v95, v97, v93);
                        end;
                    end;

                    for i in u45 do
                        if v92[i] == nil then
                            u45[i] = nil;
                        end;
                    end;
                end;
            end;
        end;
    end);
    Knit.GetService("LevelService").XPGained:Connect(function(p98, p99, p100) -- Line: 730
        -- upvalues: u1 (ref)
        if p100 then
            u1.ShowClassXP(p98);

            return;
        end;

        u1.ShowPlayerXP(p98);
    end);
    ReplicatedStorage:WaitForChild("WorldRewardNotify").OnClientEvent:Connect(function(p101: string, p102: string?, p103) -- Line: 740
        -- upvalues: u1 (ref)
        u1.ShowItem(p101, p102, p103);
    end);
    Knit.GetService("ConsumableService").ConsumableUsed:Connect(function(p104, p105, p106) -- Line: 749
        -- upvalues: MutationData (ref), Knit (ref)
        if p104 ~= "AspectGem" or (not p105 or p105 == "") then
            return;
        end;

        local ClassWeaponAspect = MutationData.GetClassWeaponAspect(p105);

        if ClassWeaponAspect then
            p105 = ClassWeaponAspect.DisplayName or p105;
        end;

        local v107 = ClassWeaponAspect and ClassWeaponAspect.Color or Color3.fromRGB(255, 215, 120);
        local Controller = Knit.GetController("NotificationController");

        if Controller then
            Controller:Show("Custom", `Rolled the {p105} aspect!`, 4, v107, v107:Lerp(Color3.new(0, 0, 0), 0.7), "GiftReceived");
        end;
    end);
    Knit.GetService("RunEarningsService").EarningsUpdated:Connect(function(p108) -- Line: 773
        -- upvalues: u52 (ref), u48 (copy), u49 (copy), u50 (copy), u51 (copy), ResolveMaterialVisuals (ref), ItemData (ref), u1 (ref), QuestItemData (ref), RarityColors (ref)
        if not (p108 and p108.Active) then
            u52 = false;

            return;
        end;

        if not u52 then
            u52 = true;
            table.clear(u48);
            table.clear(u49);
            table.clear(u50);
            table.clear(u51);
        end;

        local v109 = p108.PendingMaterials or {};

        for i, v in v109 do
            local v110 = (v or 0) - (u51[i] or 0);
            u51[i] = v;

            if v110 > 0 then
                local v111, v112 = ResolveMaterialVisuals(i);
                local Material = ItemData.GetMaterial(i);
                local v113;

                if Material then
                    v113 = Material.Name or i;
                else
                    v113 = i;
                end;

                u50[i] = true;
                u1.ShowItem(v113, v111, v112 or Color3.fromRGB(150, 215, 255), v110);
            end;
        end;

        for i in u51 do
            if v109[i] == nil then
                u51[i] = nil;
            end;
        end;

        local v114 = p108.QuestItems or {};

        for i, v in v114 do
            local v115 = (v or 0) - (u49[i] or 0);
            u49[i] = v;

            if v115 > 0 then
                local v116 = QuestItemData.Get(i);

                if not (v116 and v116.GrantedOnDrop) then
                    local v117;

                    if v116 then
                        v117 = v116.DisplayName or i;
                    else
                        v117 = i;
                    end;

                    local v118;

                    if v116 then
                        v118 = v116.Icon or nil;
                    else
                        v118 = nil;
                    end;

                    if v116 then
                        v116 = RarityColors[v116.Rarity];
                    end;

                    local v119 = v116 and v116.TextColor3 or Color3.fromRGB(180, 80, 255);
                    u48[i] = true;
                    u1.ShowItem(v117, v118, v119, v115);
                end;
            end;
        end;

        for i in u49 do
            if v114[i] == nil then
                u49[i] = nil;
            end;
        end;
    end);
    Registry:Register("ItemNotification", u1);
    print("[ItemNotification] Initialized");
end;

return u1;