--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Shop
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.Shop
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = nil;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
game:GetService("GuiService");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local GameInfo = ReplicatedStorage:WaitForChild("GameInfo");
local Index = require(GameInfo:WaitForChild("ItemData")).Index;
require(ReplicatedStorage.SharedDictionaries.RarityColors);
require(GameInfo:WaitForChild("RarityData"));
local Cosmetic_Manager = require(ReplicatedStorage.Globals.Modules.Cosmetic_Manager);
local CosmeticData = require(GameInfo:WaitForChild("CosmeticData"));
local MonetizationList = require(GameInfo:WaitForChild("MonetizationList"));
local ChestData = require(GameInfo:WaitForChild("ChestData"));
local LootChestData = require(GameInfo:WaitForChild("LootChestData"));
local u3 = {
    Class_Data = require(ReplicatedStorage.Classes.Class_Data),
    Weld_Manager = require(ReplicatedStorage.Globals.Modules.Weld_Manager)
};
local Registry = require(script.Parent.Parent.Controllers.Registry);
local Knit = require(ReplicatedStorage.Packages.Knit);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local maid = require(ReplicatedStorage.Packages.maid);
require(script.Parent.Parent.Controllers.UIController);
local u4 = nil;
local u5 = {};
local _ = Players.LocalPlayer;
local u6 = false;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = {
    ProtectHero = true,
    DungeonRevive = true,
    UnlockBase = true
};
local u12 = {};

local function GetShopScroll() -- Line: 136
    -- upvalues: u5 (copy), u1 (ref)
    local v13 = u5.ShopFrame or u1 and u1.Frames:FindFirstChild("Shop");

    if not v13 then
        return nil;
    end;

    local Contents = v13:FindFirstChild("Contents");

    if Contents then
        return Contents;
    end;

    local Body = v13:FindFirstChild("Body");

    if Body then
        Body = Body:FindFirstChild("ScrollingFrame");
    end;

    return Body;
end;

local function UpdateServerLuckFrame() -- Line: 145
    -- upvalues: GetShopScroll (copy), ReplicatedStorage (copy), MonetizationList (copy)
    local v14 = GetShopScroll();

    if v14 then
        v14 = v14:FindFirstChild("ServerLuck");
    end;

    if not v14 then
        return;
    end;

    local Value = ReplicatedStorage.ServerState.Luck.Value;
    local v15 = Value + 1;
    v14.CurrentMult.Text = v15 < ReplicatedStorage.Configuration.MAX_SERVER_LUCK.Value and (`{Value}x &gt; <font color="rgb(255, 226, 36)">{v15}x</font>` or "MAX") or "MAX";
    local AllIds = MonetizationList.ServerLuck.GetAllIds();

    if AllIds[v15] then
        v14.Buy.RobuxAmount.Text = AllIds[v15][2];
    end;
end;

local function SetupStarterPack() -- Line: 162
    -- upvalues: GetShopScroll (copy), ReplicatedStorage (copy), Index (copy), SharedUtils (copy)
    local v16 = GetShopScroll();

    if v16 then
        v16 = v16:FindFirstChild("StarterPack");
    end;

    if v16 then
        v16 = v16:FindFirstChild("List");
    end;

    if v16 then
        v16 = v16:FindFirstChild("CharacterTemplate");
    end;

    if not v16 then
        return;
    end;

    local Value = ReplicatedStorage.Configuration.STARTER_PACK_ITEM.Value;

    if Value == "" or not Value then
        warn("Starter pack item ID is not set.", ReplicatedStorage.Assets.Configuration:GetFullName());
    end;

    local v17 = Index[Value];

    if not v17 then
        warn("Starter pack item info not found for ID:", Value, "— skipping starter pack character display.");

        return;
    end;

    SharedUtils.LoadItemViewport(v16.ViewportFrame, Value);
    v16.NameText.Text = v17.Name;
end;

local u18 = maid.new();
local u19 = false;

local function FormatCountdown(p20: number) -- Line: 189
    local math_floor_ret = math.floor(p20 / 3600);
    local math_floor_ret2 = math.floor(p20 % 3600 / 60);
    local math_floor_ret3 = math.floor(p20 % 60);

    return string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, math_floor_ret3);
end;

local function UpdateFreeChests() -- Line: 196
    -- upvalues: GetShopScroll (copy), u2 (ref), ChestData (copy), u18 (copy), RunService (copy), UpdateFreeChests (copy)
    local v21 = GetShopScroll();

    if v21 then
        v21 = v21:FindFirstChild("Gear1");
    end;

    if v21 then
        v21 = v21:FindFirstChild("Free_Chests");
    end;

    if not v21 then
        return;
    end;

    local Claim_Text = v21:FindFirstChild("Claim_Text");

    if not Claim_Text then
        return;
    end;

    local v22 = u2.Data.Rebirths or 0;
    local FreeChests = u2.Data.FreeChests;
    local v23 = FreeChests and (FreeChests.ClaimedIds or {}) or {};
    local u24 = FreeChests and (FreeChests.ResetTimestamp or 0) or 0;
    print(FreeChests);
    local v25;

    if u24 > 0 then
        local v26 = os.time() - u24;
        v25 = math.max(0, ChestData.FREE_CHEST_RESET_INTERVAL - v26);
    else
        v25 = 0;
    end;

    local v27 = #v23 > 0;

    for _, v in ipairs(ChestData.FreeChests) do
        local v28 = v21:FindFirstChild(v.ButtonName);

        if v28 then
            local v29 = v28:FindFirstChildWhichIsA("TextLabel");

            if v29 then
                local table_find_ret = table.find(v23, v.ButtonName == "Buy1" and 1 or (v.ButtonName == "Buy2" and 2 or 3));

                if v27 and v25 <= 0 then
                    table_find_ret = nil;
                end;

                if table_find_ret then
                    v29.Text = "CLAIMED";
                    v28.AutoButtonColor = false;
                elseif v22 < v.RequiredRebirth then
                    v29.Text = `REBIRTH {v.RequiredRebirth}`;
                    v28.AutoButtonColor = false;
                else
                    v29.Text = "CLAIM";
                    v28.AutoButtonColor = true;
                end;
            end;
        end;
    end;

    if v27 and v25 > 0 then
        u18:DoCleaning();
        u18:GiveTask(RunService.Heartbeat:Connect(function() -- Line: 253
            -- upvalues: u24 (copy), ChestData (ref), Claim_Text (copy), u18 (ref), UpdateFreeChests (ref)
            local v30 = os.time() - u24;
            local math_max_ret = math.max(0, ChestData.FREE_CHEST_RESET_INTERVAL - v30);

            if math_max_ret <= 0 then
                Claim_Text.Text = "OPEN A CHEST!";
                u18:DoCleaning();
                UpdateFreeChests();

                return;
            end;

            local math_floor_ret = math.floor(math_max_ret / 3600);
            local math_floor_ret2 = math.floor(math_max_ret % 3600 / 60);
            local math_floor_ret3 = math.floor(math_max_ret % 60);
            Claim_Text.Text = string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, math_floor_ret3);
        end));

        return;
    end;

    u18:DoCleaning();
    Claim_Text.Text = "OPEN A CHEST!";
end;

local function SetupFreeChests() -- Line: 272
    -- upvalues: GetShopScroll (copy), Knit (copy), ChestData (copy), u19 (ref), u2 (ref), UpdateFreeChests (copy), u4 (ref)
    local v31 = GetShopScroll();

    if v31 then
        v31 = v31:FindFirstChild("Gear1");
    end;

    if v31 then
        v31 = v31:FindFirstChild("Free_Chests");
    end;

    if not v31 then
        return;
    end;

    local Service = Knit.GetService("ChestService");

    for i, v in ipairs(ChestData.FreeChests) do
        local v32 = v31:FindFirstChild(v.ButtonName);

        if v32 then
            v32.MouseButton1Click:Connect(function() -- Line: 287
                -- upvalues: u19 (ref), u2 (ref), v (copy), Knit (ref), i (copy), Service (copy)
                if u19 then
                    return;
                end;

                if (u2.Data.Rebirths or 0) < v.RequiredRebirth then
                    Knit.GetController("NotificationController"):Show("NOT_ENOUGH_REBIRTHS", v.RequiredRebirth);

                    return;
                end;

                if table.find(u2.Data.FreeChests and u2.Data.FreeChests.ClaimedIds or {}, i) then
                    Knit.GetController("NotificationController"):Show("Custom", "Already claimed! Wait for reset.", 5, Color3.new(1, 0.8, 0), Color3.new(0.4, 0.3, 0), "Error");

                    return;
                end;

                u19 = true;
                local v33, v34 = Service:ClaimFreeChest(i);

                if not v33 then
                    if v34 == "NOT_ENOUGH_REBIRTHS" then
                        Knit.GetController("NotificationController"):Show("NOT_ENOUGH_REBIRTHS", v.RequiredRebirth);
                    elseif v34 == "ALREADY_CLAIMED" then
                        Knit.GetController("NotificationController"):Show("Custom", "Already claimed! Wait for reset.", 5, Color3.new(1, 0.8, 0), Color3.new(0.4, 0.3, 0), "Error");
                    end;
                end;

                u19 = false;
            end);
        else
            warn("[Shop] Free chest button not found:", v.ButtonName);
        end;
    end;

    u2:OnChange(function(p35, p36, p37, p38) -- Line: 333
        -- upvalues: UpdateFreeChests (ref), u4 (ref)
        if p36[1] == "FreeChests" or p36[1] == "Rebirths" then
            UpdateFreeChests();
            u4:Update("Shop");
        end;
    end);
    UpdateFreeChests();
    task.delay(5, UpdateFreeChests);
end;

local u39 = {
    FrozenChest = "FrozenChest",
    MoltenChest = "MoltenChest",
    CoyoteChest = "CoyoteChest"
};
local u40 = {
    Weapon = "Weapon_Frame",
    Hero = "Hero_Frame",
    Title = "Title_Frame",
    Stars = "Stars_Frame"
};

local function FormatChance(p41, p42) -- Line: 364
    local v43 = p41 / p42 * 100;

    if v43 >= 1 then
        return string.format("%.0f%%", v43);
    end;

    return string.format("%.2f%%", v43);
end;

local function GetRewardIcon(p44) -- Line: 378
    -- upvalues: LootChestData (copy)
    if p44.Type == "UpgradeStone" then
        if p44.MinRarity and LootChestData.UpgradeStoneImages[p44.MinRarity] then
            return LootChestData.UpgradeStoneImages[p44.MinRarity];
        end;

        if p44.StoneRarity and LootChestData.UpgradeStoneImages[p44.StoneRarity] then
            return LootChestData.UpgradeStoneImages[p44.StoneRarity];
        end;

        return LootChestData.RewardIcons.UpgradeStone;
    end;

    if p44.Type ~= "Crystal" then
        if p44.Type == "ProtectionScroll" then
            return LootChestData.RewardIcons.ProtectionScroll;
        end;

        return p44.Type ~= "Cash" and "" or LootChestData.RewardIcons.Cash;
    end;

    local string_gsub_ret = string.gsub(p44.Id, " Crystal", "");

    if LootChestData.UpgradeStoneImages[string_gsub_ret] then
        return LootChestData.UpgradeStoneImages[string_gsub_ret];
    end;

    return LootChestData.RewardIcons.UpgradeStone;
end;

local function PopulateChestContents(p45) -- Line: 411
    -- upvalues: u39 (copy), ChestData (copy), u40 (copy), SharedUtils (copy), LootChestData (copy), GetRewardIcon (copy)
    for i, v in u39 do
        local v46 = p45:FindFirstChild(i);

        if v46 then
            local v47 = v46:FindFirstChildWhichIsA("ScrollingFrame");

            if v47 then
                local Chest = ChestData.GetChest(v);

                if Chest then
                    local Item_Frame = v47:FindFirstChild("Item_Frame");

                    if Item_Frame then
                        local v48 = 0;

                        for _, v2 in ipairs(Chest.Contents) do
                            v48 = v48 + v2.Chance;
                        end;

                        for _, v2 in ipairs(Chest.Contents) do
                            local v49 = u40[v2.Type];

                            if v49 then
                                local v50 = v47:FindFirstChild(v49);

                                if v50 then
                                    local Chance = v50:FindFirstChild("Chance");

                                    if Chance then
                                        local v51 = v2.Chance / v48 * 100;
                                        local v52;

                                        if v51 >= 1 then
                                            v52 = string.format("%.0f%%", v51);
                                        else
                                            v52 = string.format("%.2f%%", v51);
                                        end;

                                        Chance.Text = v52;
                                    end;
                                end;
                            end;
                        end;

                        local v53 = {};

                        for _, v2 in ipairs(Chest.Contents) do
                            if v2.Type == "Cash" then
                                local Amount = v2.Amount;

                                if type(Amount) == "table" then
                                    table.insert(v53, Amount[1]);
                                    table.insert(v53, Amount[2]);
                                else
                                    table.insert(v53, Amount);
                                end;
                            end;
                        end;

                        local v54 = 0;

                        for _, v2 in ipairs(Chest.Contents) do
                            if v2.Type == "Cash" then
                                v54 = v54 + v2.Chance;
                            end;
                        end;

                        local v55 = {};

                        if #v53 > 0 then
                            table.sort(v53);
                            local v56 = v53[1];
                            local v57 = v53[#v53];
                            local v58;

                            if v56 == v57 then
                                v58 = SharedUtils.FormatCashString(v56) .. " CASH";
                            else
                                v58 = SharedUtils.FormatCashString(v56) .. " - " .. SharedUtils.FormatCashString(v57) .. " CASH";
                            end;

                            table.insert(v55, {
                                DisplayName = v58,
                                Icon = LootChestData.RewardIcons.Cash,
                                Chance = v54
                            });
                        end;

                        for _, v2 in ipairs(Chest.Contents) do
                            if not u40[v2.Type] and v2.Type ~= "Cash" then
                                local v59 = {
                                    DisplayName = v2.DisplayName or v2.Id,
                                    Icon = GetRewardIcon(v2),
                                    Chance = v2.Chance
                                };
                                table.insert(v55, v59);
                            end;
                        end;

                        for _, child in v47:GetChildren() do
                            if child:IsA("Frame") and child:GetAttribute("DynamicChestItem") then
                                child:Destroy();
                            end;
                        end;

                        Item_Frame.Visible = false;
                        local v60 = 5;

                        for _, v2 in ipairs(v55) do
                            local v61 = Item_Frame:Clone();
                            v61.Name = "DynamicItem_" .. v60;
                            v61:SetAttribute("DynamicChestItem", true);
                            v61.LayoutOrder = v60;
                            v61.Visible = true;
                            local Icon = v61:FindFirstChild("Icon");

                            if Icon and (v2.Icon and v2.Icon ~= "") then
                                Icon.Image = v2.Icon;
                            end;

                            local v62 = v2;

                            for _, child in v61:GetChildren() do
                                if child:IsA("TextLabel") and child.Name ~= "Chance" then
                                    child.Text = v62.DisplayName;
                                    break;
                                end;
                            end;

                            local Chance = v61:FindFirstChild("Chance");

                            if Chance then
                                local v63 = v62.Chance / v48 * 100;
                                local v64;

                                if v63 >= 1 then
                                    v64 = string.format("%.0f%%", v63);
                                else
                                    v64 = string.format("%.2f%%", v63);
                                end;

                                Chance.Text = v64;
                            end;

                            v61.Parent = v47;
                            v60 = v60 + 1;
                        end;
                    else
                        warn("[Shop] No Item_Frame template in:", i);
                    end;
                else
                    warn("[Shop] No ChestData for:", v);
                end;
            else
                warn("[Shop] No ScrollingFrame in:", i);
            end;
        else
            warn("[Shop] Chest frame not found:", i);
        end;
    end;
end;

local function MarkButtonOwned(p65: userdata) -- Line: 563
    local RobuxAmount = p65:FindFirstChild("RobuxAmount");

    if RobuxAmount then
        RobuxAmount.Text = "OWNED";
    end;

    local ImageLabel = p65:FindFirstChild("ImageLabel");

    if ImageLabel then
        ImageLabel.Visible = false;
    end;

    p65.AutoButtonColor = false;
    p65.Active = false;
end;

local Players2 = game:GetService("Players");
local CFrame_new_ret = CFrame.new(Vector3.new(0, 0.5, -12), Vector3.new(0, 0.5, 0));
local CFrame_new_ret2 = CFrame.new(0, 0.5, 0);
local u66 = { {
        FrameName = "ArchonBundle",
        SetId = "Forge Archon",
        RemovePiece = "Forge Archon Top Slim"
    }, {
        FrameName = "EclipseBundle",
        SetId = "Eclipse"
    }, {
        FrameName = "EastSeasBundle",
        RotateSets = { "Astral Body", "White Rose", "Gray Rose", "Martial", "Martial Dragon" }
    }, {
        FrameName = "JetstreamBundle",
        SetId = "Jetstream",
        IdleAnimationId = "rbxassetid://87511690849407"
    } };
local u67 = { {
        FrameName = "ForgeArchon",
        SetId = "Forge Archon",
        AuraSetId = "Forge Archon Aura",
        RemovePiece = "Forge Archon Top Slim"
    }, {
        FrameName = "Eclipse",
        SetId = "Eclipse",
        AuraSetId = "Eclipse Aura"
    }, {
        FrameName = "SeaDemon",
        SetId = "Sea Demon"
    }, {
        FrameName = "BlackSwordsman",
        SetId = "Black Swordsman"
    }, {
        FrameName = "SunClad",
        SetId = "Sun Clad"
    }, {
        FrameName = "Guildmaster",
        SetId = "Guildmaster"
    } };
local u68 = {};

local function WeldViewportAccessories(p69: userdata) -- Line: 628
    for _, child in p69:GetChildren() do
        if child:IsA("Accessory") then
            local Handle = child:FindFirstChild("Handle");

            if Handle and not Handle:FindFirstChildOfClass("Weld") then
                local v70 = Handle:FindFirstChildOfClass("Attachment");

                if v70 then
                    for _, child2 in p69:GetChildren() do
                        if child2:IsA("BasePart") then
                            local v71 = child2:FindFirstChild(v70.Name);

                            if v71 and v71:IsA("Attachment") then
                                Handle.CFrame = child2.CFrame * v71.CFrame * v70.CFrame:Inverse();
                                local Weld = Instance.new("Weld");
                                Weld.Part0 = child2;
                                Weld.Part1 = Handle;
                                Weld.C0 = v71.CFrame;
                                Weld.C1 = v70.CFrame;
                                Weld.Parent = Handle;
                                break;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

local function ApplyCosmeticSetToClone(p72: userdata, p73: string, p74: string?) -- Line: 660
    -- upvalues: Cosmetic_Manager (copy), CosmeticData (copy), WeldViewportAccessories (copy)
    Cosmetic_Manager.ClearAll(p72);
    local v75 = {};

    for _, v in CosmeticData.Slots do
        if p74 and (p74 ~= "" and v == "Aura") then
            v75[v] = p74;
        elseif Cosmetic_Manager.SetHasSlot(p73, v) then
            v75[v] = p73;
        else
            v75[v] = "";
        end;
    end;

    Cosmetic_Manager.ApplyAll(p72, v75);
    WeldViewportAccessories(p72);
end;

local function StartBundleRotation(u76, u77) -- Line: 683
    -- upvalues: u5 (copy), ApplyCosmeticSetToClone (copy)
    if not u76.RotateSets or #u76.RotateSets <= 1 then
        return;
    end;

    u77.rotationId = (u77.rotationId or 0) + 1;
    local rotationId = u77.rotationId;
    task.spawn(function() -- Line: 689
        -- upvalues: u77 (copy), rotationId (copy), u5 (ref), u76 (copy), ApplyCosmeticSetToClone (ref)
        while u77.rotationId == rotationId do
            task.wait(5);

            if u77.rotationId ~= rotationId then
                return;
            end;

            if not u5.ShopFrame.Visible then
                return;
            end;

            if not (u77.clone and u77.clone.Parent) then
                return;
            end;

            u77.rotationIndex = u77.rotationIndex % #u76.RotateSets + 1;
            ApplyCosmeticSetToClone(u77.clone, u76.RotateSets[u77.rotationIndex]);
        end;
    end);
end;

local function SetupBundleViewport(p78, p79) -- Line: 702
    -- upvalues: GetShopScroll (copy), Players2 (copy), CFrame_new_ret2 (copy), ApplyCosmeticSetToClone (copy), ReplicatedStorage (copy), u3 (copy), CFrame_new_ret (copy), u68 (copy)
    local v80 = p79 or GetShopScroll();

    if v80 then
        v80 = v80:FindFirstChild(p78.FrameName);
    end;

    if not v80 then
        warn("[Shop] Bundle frame not found:", p78.FrameName);

        return;
    end;

    local v81 = v80:FindFirstChildWhichIsA("ViewportFrame");

    if not v81 then
        warn("[Shop] No ViewportFrame in", p78.FrameName);

        return;
    end;

    local Character = Players2.LocalPlayer.Character;

    if not Character then
        return;
    end;

    local Archivable = Character.Archivable;
    Character.Archivable = true;
    local v82 = Character:Clone();
    Character.Archivable = Archivable;

    for _, descendant in v82:GetDescendants() do
        if descendant:IsA("BaseScript") or (descendant:IsA("Tool") or (descendant:IsA("ForceField") or descendant:IsA("BillboardGui"))) then
            descendant:Destroy();
        end;
    end;

    local WorldModel = Instance.new("WorldModel");
    WorldModel.Parent = v81;
    v82.Parent = WorldModel;
    v82:PivotTo(CFrame_new_ret2);
    local v83 = p78.SetId or p78.RotateSets and p78.RotateSets[1];

    if not (v83 or p78.ClassShowcase) then
        warn("[Shop] BUNDLE_VIEWPORTS entry missing SetId, RotateSets, and ClassShowcase:", p78.FrameName);

        return;
    end;

    if v83 then
        ApplyCosmeticSetToClone(v82, v83, p78.AuraSetId);
    end;

    if p78.RemovePiece then
        local v84 = v82:FindFirstChild("Torso") or v82:FindFirstChild("UpperTorso");
        local v85 = v84 and v84:FindFirstChild(p78.RemovePiece);

        if v85 then
            v85:Destroy();
        end;
    end;

    if p78.ClassShowcase then
        for _, descendant in v82:GetDescendants() do
            if descendant:HasTag("Weapon_Mesh") then
                descendant:Destroy();
            end;
        end;

        local v86 = ReplicatedStorage.Classes:FindFirstChild(p78.ClassShowcase);

        if v86 then
            v86 = v86:FindFirstChild("Prefabs");
        end;

        if v86 then
            v86 = v86:FindFirstChild("Holder");
        end;

        if v86 then
            local v87 = u3.Class_Data.Get(p78.ClassShowcase) or {};
            u3.Weld_Manager.Weld(v86, v82, "ShopViewport_Holder", {
                WeldOverrides = v87.WeldOverrides,
                Motor6D_Overrides = v87.Motor6D_Overrides,
                SkipDefaultWelds = v87.SkipDefaultWelds
            });
        else
            warn("[Shop] ClassShowcase Holder not found for class:", p78.ClassShowcase);
        end;
    end;

    local Camera = Instance.new("Camera");
    Camera.FieldOfView = 30;
    Camera.CFrame = CFrame_new_ret;
    Camera.Parent = v81;
    v81.CurrentCamera = Camera;
    local v88 = nil;
    local v89 = v82:FindFirstChildOfClass("Humanoid");

    if v89 then
        local v90 = v89:FindFirstChildOfClass("Animator");

        if not v90 then
            v90 = Instance.new("Animator");
            v90.Parent = v89;
        end;

        local IdleAnimationId = p78.IdleAnimationId;

        if not IdleAnimationId and p78.ClassShowcase then
            local v91 = u3.Class_Data.Get(p78.ClassShowcase);
            IdleAnimationId = v91 and v91.AnimationOverrides and v91.AnimationOverrides.idle;
        end;

        local v92;

        if IdleAnimationId then
            v92 = Instance.new("Animation");
            v92.AnimationId = IdleAnimationId;
        else
            v92 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Idle_Animations") and ReplicatedStorage.Assets.Idle_Animations:FindFirstChild("Hitman_Idle");
        end;

        if v92 then
            v88 = v90:LoadAnimation(v92);
            v88.Looped = true;
            v88:Play();
        else
            warn("[Shop] Hitman_Idle animation not found at ReplicatedStorage.Assets.Idle_Animations.Hitman_Idle");
        end;
    end;

    u68[p78.StateKey or p78.FrameName] = {
        setup = true,
        rotationIndex = 1,
        rotationId = 0,
        clone = v82,
        animTrack = v88
    };
end;

local function GetCosmeticScroll() -- Line: 854
    -- upvalues: GetShopScroll (copy)
    local v93 = GetShopScroll();

    if v93 then
        v93 = v93:FindFirstChild("Cosmetics");
    end;

    if v93 then
        v93 = v93:FindFirstChild("ScrollingFrame");
    end;

    return v93;
end;

local function BuildCosmeticViewports() -- Line: 860
    -- upvalues: GetShopScroll (copy), u67 (copy), u68 (copy), SetupBundleViewport (copy), u5 (copy), ApplyCosmeticSetToClone (copy)
    local v94 = GetShopScroll();

    if v94 then
        v94 = v94:FindFirstChild("Cosmetics");
    end;

    if v94 then
        v94 = v94:FindFirstChild("ScrollingFrame");
    end;

    if not v94 then
        return;
    end;

    for _, v in u67 do
        local u95 = u68[v.FrameName];

        if u95 and u95.setup then
            if u95.animTrack then
                u95.animTrack:Play();
            end;
        else
            SetupBundleViewport(v, v94);
            u95 = u68[v.FrameName];
        end;

        if u95 and (v.RotateSets and v.RotateSets) then
            if #v.RotateSets > 1 then
                u95.rotationId = (u95.rotationId or 0) + 1;
                local rotationId = u95.rotationId;
                task.spawn(function() -- Line: 689
                    -- upvalues: u95 (copy), rotationId (copy), u5 (ref), v (copy), ApplyCosmeticSetToClone (ref)
                    while u95.rotationId == rotationId do
                        task.wait(5);

                        if u95.rotationId ~= rotationId then
                            return;
                        end;

                        if not u5.ShopFrame.Visible then
                            return;
                        end;

                        if not (u95.clone and u95.clone.Parent) then
                            return;
                        end;

                        u95.rotationIndex = u95.rotationIndex % #v.RotateSets + 1;
                        ApplyCosmeticSetToClone(u95.clone, v.RotateSets[u95.rotationIndex]);
                    end;
                end);
            end;
        end;
    end;
end;

local function TeardownCosmeticViewports() -- Line: 877
    -- upvalues: GetShopScroll (copy), u67 (copy), u68 (copy)
    local v96 = GetShopScroll();

    if v96 then
        v96 = v96:FindFirstChild("Cosmetics");
    end;

    if v96 then
        v96 = v96:FindFirstChild("ScrollingFrame");
    end;

    for _, v in u67 do
        local u97 = u68[v.FrameName];

        if u97 then
            u97.rotationId = (u97.rotationId or 0) + 1;

            if u97.animTrack then
                pcall(function() -- Line: 884
                    -- upvalues: u97 (copy)
                    u97.animTrack:Stop();
                end);
            end;

            u68[v.FrameName] = nil;
        end;

        local v98;

        if v96 then
            v98 = v96:FindFirstChild(v.FrameName);
        else
            v98 = v96;
        end;

        if v98 then
            v98 = v98:FindFirstChildWhichIsA("ViewportFrame");
        end;

        if v98 then
            for _, child in v98:GetChildren() do
                if child:IsA("WorldModel") or child:IsA("Camera") then
                    child:Destroy();
                end;
            end;
        end;
    end;
end;

local u101 = {
    GrandSovereign = {
        ProductKey = "GrandSovereignPack",
        Viewports = { {
                FrameName = "Main",
                StateKey = "GrandSovereign/Main",
                SetId = "Grand Founder",
                ClassShowcase = "Founder"
            }, {
                FrameName = "GrandFounder",
                SetId = "Grand Founder"
            }, {
                FrameName = "GrandImperator",
                SetId = "Grand Imperator"
            }, {
                FrameName = "GrandInquisitor",
                SetId = "Grand Inquisitor"
            } },

        FetchSold = function(u99) -- Line: 937, Name: FetchSold
            -- upvalues: Knit (copy)
            local success, result = pcall(function() -- Line: 938
                -- upvalues: Knit (ref)
                return Knit.GetService("MonetizationService"):GetGrandSovereignSold();
            end);

            if success and result then
                result:andThen(function(p100) -- Line: 942
                    -- upvalues: u99 (copy)
                    if typeof(p100) == "number" then
                        u99.soldCount = p100;
                    end;
                end);
            end;
        end
    },
    ShadowMonarch = {
        ProductKey = "ShadowMonarchBundle",
        Viewports = { {
                FrameName = "Main",
                StateKey = "ShadowMonarch/Main",
                ClassShowcase = "Shadow Vagrant"
            } }
    }
};

local function GetLimitedPackScroll(p102: string) -- Line: 957
    -- upvalues: GetShopScroll (copy)
    local v103 = GetShopScroll();

    if v103 then
        v103 = v103:FindFirstChild(p102);
    end;

    if v103 then
        v103 = v103:FindFirstChild("ScrollingFrame");
    end;

    return v103;
end;

local function FormatPackCountdown(p104: number) -- Line: 963
    local math_floor_ret = math.floor(p104);
    local math_max_ret = math.max(0, math_floor_ret);
    local math_floor_ret2 = math.floor(math_max_ret / 86400);
    local v105 = math_max_ret % 86400;
    local math_floor_ret3 = math.floor(v105 / 3600);
    local v106 = v105 % 3600;
    local math_floor_ret4 = math.floor(v106 / 60);

    return string.format("%02d:%02d:%02d:%02d", math_floor_ret2, math_floor_ret3, math_floor_ret4, v106 % 60);
end;

local function StartLimitedPackCountdown(u107: string) -- Line: 972
    -- upvalues: u101 (copy), MonetizationList (copy), GetShopScroll (copy)
    local u108 = u101[u107];
    u108.countdownToken = (u108.countdownToken or 0) + 1;
    local countdownToken = u108.countdownToken;
    local u109 = MonetizationList[u108.ProductKey];
    local u110;

    if u109 then
        u110 = u109.UnlockTime;
    else
        u110 = u109;
    end;

    if u109 then
        u109 = u109.EndTime;
    end;

    local v111 = GetShopScroll();

    if v111 then
        v111 = v111:FindFirstChild(u107);
    end;

    if v111 then
        v111 = v111:FindFirstChild("ScrollingFrame");
    end;

    if v111 then
        v111 = v111:FindFirstChild("Main");
    end;

    if v111 then
        v111 = v111:FindFirstChild("Robux");
    end;

    if v111 then
        v111.Visible = false;
    end;

    if u108.FetchSold then
        u108.FetchSold(u108);
    end;

    task.spawn(function() -- Line: 994
        -- upvalues: countdownToken (copy), u108 (copy), u107 (copy), GetShopScroll (ref), u110 (copy), u109 (copy)
        local v112 = 0;

        while countdownToken == u108.countdownToken do
            local v113 = u107;
            local v114 = GetShopScroll();

            if v114 then
                v114 = v114:FindFirstChild(v113);
            end;

            if v114 then
                v114 = v114:FindFirstChild("ScrollingFrame");
            end;

            if v114 then
                v114 = v114:FindFirstChild("Main");
            end;

            local v115;

            if v114 then
                v115 = v114:FindFirstChild("UnlockTime");
            else
                v115 = v114;
            end;

            local v116;

            if v114 then
                v116 = v114:FindFirstChild("Robux");
            else
                v116 = v114;
            end;

            if v115 and v115:IsA("TextLabel") then
                local os_time_ret = os.time();

                if u110 and os_time_ret < u110 then
                    local math_floor_ret = math.floor(u110 - os_time_ret);
                    local math_max_ret = math.max(0, math_floor_ret);
                    local math_floor_ret2 = math.floor(math_max_ret / 86400);
                    local v117 = math_max_ret % 86400;
                    local math_floor_ret3 = math.floor(v117 / 3600);
                    local v118 = v117 % 3600;
                    local math_floor_ret4 = math.floor(v118 / 60);
                    v115.Text = "Available in: " .. string.format("%02d:%02d:%02d:%02d", math_floor_ret2, math_floor_ret3, math_floor_ret4, v118 % 60);

                    if v116 then
                        v116.Visible = false;
                    end;
                elseif u109 and u109 <= os_time_ret then
                    v115.Text = "Offer has ended";

                    if v116 then
                        v116.Visible = false;
                    end;
                elseif u108.FetchSold then
                    v115.Text = u108.soldCount and "Total Sold: " .. u108.soldCount or "Total Sold: ...";

                    if v116 then
                        v116.Visible = true;
                    end;
                else
                    local v119;

                    if u109 then
                        local math_floor_ret = math.floor(u109 - os_time_ret);
                        local math_max_ret = math.max(0, math_floor_ret);
                        local math_floor_ret2 = math.floor(math_max_ret / 86400);
                        local v120 = math_max_ret % 86400;
                        local math_floor_ret3 = math.floor(v120 / 3600);
                        local v121 = v120 % 3600;
                        local math_floor_ret4 = math.floor(v121 / 60);
                        v119 = "Offer ends in: " .. string.format("%02d:%02d:%02d:%02d", math_floor_ret2, math_floor_ret3, math_floor_ret4, v121 % 60) or "Available now!";
                    else
                        v119 = "Available now!";
                    end;

                    v115.Text = v119;

                    if v116 then
                        v116.Visible = true;
                    end;
                end;
            end;

            if v114 then
                v114 = v114:FindFirstChild("Owner_Notice");
            end;

            if v114 and v114:IsA("GuiObject") then
                local v122;

                if u108.ownerEligible == true and v116 ~= nil then
                    v122 = v116.Visible;
                else
                    v122 = false;
                end;

                v114.Visible = v122;
            end;

            task.wait(1);
            v112 = v112 + 1;

            if v112 >= 30 then
                v112 = 0;

                if u108.FetchSold then
                    u108.FetchSold(u108);
                end;
            end;
        end;
    end);
end;

local function StopLimitedPackCountdown(p123: string) -- Line: 1038
    -- upvalues: u101 (copy)
    local v124 = u101[p123];
    v124.countdownToken = (v124.countdownToken or 0) + 1;
end;

local u125 = nil;

local function SetupShadowMonarchClaim() -- Line: 1053
    -- upvalues: u101 (copy), GetShopScroll (copy), u125 (ref), Knit (copy)
    local ShadowMonarch = u101.ShadowMonarch;
    ShadowMonarch.ownerEligible = false;
    local v126 = GetShopScroll();

    if v126 then
        v126 = v126:FindFirstChild("ShadowMonarch");
    end;

    if v126 then
        v126 = v126:FindFirstChild("ScrollingFrame");
    end;

    if v126 then
        v126 = v126:FindFirstChild("Main");
    end;

    local u127;

    if v126 then
        u127 = v126:FindFirstChild("Robux");
    else
        u127 = v126;
    end;

    local u128;

    if v126 then
        u128 = v126:FindFirstChild("Owner_Notice");
    else
        u128 = v126;
    end;

    if u128 then
        u128.Visible = false;
    end;

    if not (v126 and u127) then
        return;
    end;

    u127:SetAttribute("SuppressPurchasePrompt", true);

    if u125 then
        u125:Disconnect();
    end;

    u125 = u127.MouseButton1Click:Connect(function() -- Line: 1070
        -- upvalues: ShadowMonarch (copy), u127 (copy), Knit (ref), u128 (copy)
        if not ShadowMonarch.ownerEligible then
            return;
        end;

        ShadowMonarch.ownerEligible = false;
        local RobuxAmount = u127:FindFirstChild("RobuxAmount");

        if RobuxAmount then
            RobuxAmount.Text = "Claiming...";
        end;

        local success, result = pcall(function() -- Line: 1076
            -- upvalues: Knit (ref)
            return Knit.GetService("MonetizationService"):ClaimShadowMonarchFree();
        end);

        if success and result then
            result:andThen(function(p129) -- Line: 1084
                -- upvalues: RobuxAmount (copy), u127 (ref), u128 (ref), ShadowMonarch (ref)
                if p129 then
                    if RobuxAmount then
                        RobuxAmount.Text = "Owned";
                    end;

                    local Icon = u127:FindFirstChild("Icon");

                    if Icon then
                        Icon.Visible = false;
                    end;

                    if u128 then
                        u128.Visible = false;
                    end;
                else
                    ShadowMonarch.ownerEligible = true;

                    if RobuxAmount then
                        RobuxAmount.Text = "Claim";
                    end;
                end;
            end):catch(function() -- Line: 1094
                -- upvalues: ShadowMonarch (ref), RobuxAmount (copy)
                ShadowMonarch.ownerEligible = true;

                if RobuxAmount then
                    RobuxAmount.Text = "Claim";
                end;
            end);

            return;
        end;

        ShadowMonarch.ownerEligible = true;

        if RobuxAmount then
            RobuxAmount.Text = "Claim";
        end;
    end);
    local success, result = pcall(function() -- Line: 1101
        -- upvalues: Knit (ref)
        return Knit.GetService("MonetizationService"):GetShadowMonarchOwnerInfo();
    end);

    if success and result then
        result:andThen(function(p130) -- Line: 1108
            -- upvalues: u127 (copy), ShadowMonarch (copy)
            local v131 = p130 or {};
            local RobuxAmount = u127:FindFirstChild("RobuxAmount");
            local Icon = u127:FindFirstChild("Icon");

            if v131.isDevOwner and not v131.alreadyClaimed then
                ShadowMonarch.ownerEligible = true;

                if RobuxAmount then
                    RobuxAmount.Text = "Claim";
                end;

                if Icon then
                    Icon.Visible = false;
                end;
            else
                ShadowMonarch.ownerEligible = false;
                u127:SetAttribute("SuppressPurchasePrompt", false);

                if v131.alreadyClaimed then
                    if RobuxAmount then
                        RobuxAmount.Text = "Owned";
                    end;

                    if Icon then
                        Icon.Visible = false;
                    end;
                end;
            end;
        end):catch(function() -- Line: 1126
            -- upvalues: u127 (copy)
            u127:SetAttribute("SuppressPurchasePrompt", false);
        end);

        return;
    end;

    u127:SetAttribute("SuppressPurchasePrompt", false);
end;

local function TeardownShadowMonarchClaim() -- Line: 1131
    -- upvalues: u101 (copy), u125 (ref), GetShopScroll (copy)
    u101.ShadowMonarch.ownerEligible = false;

    if u125 then
        u125:Disconnect();
        u125 = nil;
    end;

    local v132 = GetShopScroll();

    if v132 then
        v132 = v132:FindFirstChild("ShadowMonarch");
    end;

    if v132 then
        v132 = v132:FindFirstChild("ScrollingFrame");
    end;

    if v132 then
        v132 = v132:FindFirstChild("Main");
    end;

    if v132 then
        local Owner_Notice = v132:FindFirstChild("Owner_Notice");

        if Owner_Notice then
            Owner_Notice.Visible = false;
        end;

        local Robux = v132:FindFirstChild("Robux");

        if Robux then
            Robux:SetAttribute("SuppressPurchasePrompt", false);
        end;
    end;
end;

local function BuildLimitedPackViewports(p133: string) -- Line: 1148
    -- upvalues: GetShopScroll (copy), u101 (copy), u68 (copy), SetupBundleViewport (copy), StartLimitedPackCountdown (copy), SetupShadowMonarchClaim (copy)
    local v134 = GetShopScroll();

    if v134 then
        v134 = v134:FindFirstChild(p133);
    end;

    if v134 then
        v134 = v134:FindFirstChild("ScrollingFrame");
    end;

    if not v134 then
        return;
    end;

    for _, v in u101[p133].Viewports do
        local v135 = u68[v.StateKey or v.FrameName];

        if v135 and v135.setup then
            if v135.animTrack then
                v135.animTrack:Play();
            end;
        else
            SetupBundleViewport(v, v134);
        end;
    end;

    StartLimitedPackCountdown(p133);

    if p133 == "ShadowMonarch" then
        SetupShadowMonarchClaim();
    end;
end;

local function TeardownLimitedPackViewports(p136: string) -- Line: 1165
    -- upvalues: u101 (copy), TeardownShadowMonarchClaim (copy), GetShopScroll (copy), u68 (copy)
    local v137 = u101[p136];
    v137.countdownToken = (v137.countdownToken or 0) + 1;

    if p136 == "ShadowMonarch" then
        TeardownShadowMonarchClaim();
    end;

    local v138 = GetShopScroll();

    if v138 then
        v138 = v138:FindFirstChild(p136);
    end;

    if v138 then
        v138 = v138:FindFirstChild("ScrollingFrame");
    end;

    for _, v in u101[p136].Viewports do
        local v139 = v.StateKey or v.FrameName;
        local u140 = u68[v139];

        if u140 then
            u140.rotationId = (u140.rotationId or 0) + 1;

            if u140.animTrack then
                pcall(function() -- Line: 1177
                    -- upvalues: u140 (copy)
                    u140.animTrack:Stop();
                end);
            end;

            u68[v139] = nil;
        end;

        local v141;

        if v138 then
            v141 = v138:FindFirstChild(v.FrameName);
        else
            v141 = v138;
        end;

        if v141 then
            v141 = v141:FindFirstChildWhichIsA("ViewportFrame");
        end;

        if v141 then
            for _, child in v141:GetChildren() do
                if child:IsA("WorldModel") or child:IsA("Camera") then
                    child:Destroy();
                end;
            end;
        end;
    end;
end;

local function UpdateExtraPotions() -- Line: 1195
    -- upvalues: GetShopScroll (copy), u2 (ref), MonetizationList (copy)
    local v142 = GetShopScroll();

    if not v142 then
        return;
    end;

    local Gamepass1 = v142:FindFirstChild("Gamepass1");

    if not Gamepass1 then
        return;
    end;

    local Extra_Potions = Gamepass1:FindFirstChild("Extra_Potions");

    if not Extra_Potions then
        return;
    end;

    local Buy = Extra_Potions:FindFirstChild("Buy");

    if not Buy then
        return;
    end;

    local v143 = u2.Data.PermanentItems or {};
    local v144 = table.find(v143, "ExtraPotions1") ~= nil;

    if not v144 or table.find(v143, "ExtraPotions2") == nil then
        if v144 then
            Buy:SetAttribute("ProductName", "ExtraPotions2");
            local RobuxAmount = Buy:FindFirstChild("RobuxAmount");
            local u145 = RobuxAmount and MonetizationList.ExtraPotions2;

            if u145 then
                local success, result = pcall(function() -- Line: 1220
                    -- upvalues: u145 (copy)
                    return game:GetService("MarketplaceService"):GetProductInfo(u145.Id, Enum.InfoType.Product);
                end);

                if success and result then
                    RobuxAmount.Text = tostring(result.PriceInRobux);
                end;
            end;

            local ImageLabel = Buy:FindFirstChild("ImageLabel");

            if ImageLabel then
                ImageLabel.Visible = true;
            end;

            Buy.AutoButtonColor = true;
            Buy.Active = true;
        end;

        return;
    end;

    local RobuxAmount = Buy:FindFirstChild("RobuxAmount");

    if RobuxAmount then
        RobuxAmount.Text = "OWNED";
    end;

    local ImageLabel = Buy:FindFirstChild("ImageLabel");

    if ImageLabel then
        ImageLabel.Visible = false;
    end;

    Buy.AutoButtonColor = false;
    Buy.Active = false;
end;

local u147 = {
    {
        FrameName = "ReleaseBundle",
        DataKey = "OwnedReleaseBundle"
    },
    {
        FrameName = "ProtectionUpgradeBundle",
        DataKey = "OwnedProtectionUpgradeBundle"
    },
    {
        FrameName = "Founders Bundle",
        DataKey = "OwnedFoundersBundle"
    },
    {
        FrameName = "DevelopersBundle",

        CheckFn = function(p146) -- Line: 1245, Name: CheckFn
            return table.find(p146.ClassItems or {}, "Shadow Monarch\'s Dagger") ~= nil;
        end
    },
    {
        FrameName = "ArchonBundle",
        DataKey = "OwnedArchonBundle"
    },
    {
        FrameName = "EclipseBundle",
        DataKey = "OwnedEclipseBundle"
    },
    {
        FrameName = "EastSeasBundle",
        DataKey = "OwnedEastSeasBundle"
    },
    {
        FrameName = "JetstreamBundle",
        DataKey = "OwnedJetstreamBundle"
    },
    {
        FrameName = "SupporterBundle",
        DataKey = "OwnedSupporterBundle"
    }
};

local function UpdateOwnedBundles() -- Line: 1257
    -- upvalues: GetShopScroll (copy), u147 (copy), u2 (ref)
    local v148 = GetShopScroll();

    if not v148 then
        return;
    end;

    for _, v in u147 do
        local v149 = v148:FindFirstChild(v.FrameName);

        if v149 then
            local Buy = v149:FindFirstChild("Buy");

            if Buy then
                local RobuxAmount = Buy:FindFirstChild("RobuxAmount");

                if RobuxAmount then
                    local v150 = false;

                    if v.CheckFn then
                        v150 = v.CheckFn(u2.Data);
                    elseif v.DataKey then
                        v150 = u2.Data[v.DataKey];
                    end;

                    if v150 then
                        RobuxAmount.Text = "OWNED";
                        Buy.AutoButtonColor = false;
                    end;
                end;
            end;
        end;
    end;
end;

local u151 = { {
        FrameName = "FoundersBundle",
        StockKey = "Founders"
    }, {
        FrameName = "DevelopersBundle",
        StockKey = "Developers"
    } };

local function UpdateLimitedBundleStock() -- Line: 1291
    -- upvalues: Knit (copy), GetShopScroll (copy), u151 (copy)
    local v152, v153 = Knit.GetService("ShopService"):GetLimitedBundleStock():await();

    if not (v152 and v153) then
        return;
    end;

    local v154 = GetShopScroll();

    if not v154 then
        return;
    end;

    for _, v in u151 do
        local v155 = v154:FindFirstChild(v.FrameName);

        if v155 then
            local Amount_Left = v155:FindFirstChild("Amount_Left");

            if Amount_Left then
                local v156 = v153[v.StockKey] or 0;

                if v156 > 0 then
                    Amount_Left.Text = `[{v156} LEFT]`;
                else
                    Amount_Left.Text = "[SOLD OUT]";
                end;
            end;
        end;
    end;
end;

local function SetGiftingVisuals(p157: boolean) -- Line: 1317
    -- upvalues: u5 (copy), u9 (ref)
    local ShopFrame = u5.ShopFrame;
    local v158 = ShopFrame:FindFirstChildOfClass("UIStroke");

    if v158 then
        local Default = v158:FindFirstChild("Default");
        local Gifting = v158:FindFirstChild("Gifting");

        if Default and Default:IsA("UIGradient") then
            Default.Enabled = not p157;
        end;

        if Gifting and Gifting:IsA("UIGradient") then
            Gifting.Enabled = p157;
        end;
    end;

    local Background_Gradient = ShopFrame:FindFirstChild("Background_Gradient");
    local v159 = Background_Gradient and Background_Gradient:GetAttribute(p157 and "Gifting" or "Default");

    if v159 then
        Background_Gradient.BackgroundColor3 = v159;
    end;

    if u9 then
        u9.Visible = p157;
    end;
end;

local function SetGiftingModeOnButtons(p160: boolean) -- Line: 1351
    -- upvalues: u5 (copy), CollectionService (copy)
    local ShopFrame = u5.ShopFrame;

    for _, v in CollectionService:GetTagged("PRODUCT_BUTTON") do
        if v:IsDescendantOf(ShopFrame) then
            v:SetAttribute("GiftingMode", p160 or nil);
        end;
    end;
end;

local function SetBlockedProductButtons(p161: boolean) -- Line: 1361
    -- upvalues: u5 (copy), CollectionService (copy), u11 (copy), u12 (copy)
    local ShopFrame = u5.ShopFrame;

    if p161 then
        for _, v in CollectionService:GetTagged("PRODUCT_BUTTON") do
            if v:IsDescendantOf(ShopFrame) then
                local Attribute = v:GetAttribute("ProductName");

                if Attribute and u11[Attribute] then
                    if not u12[v] then
                        u12[v] = {
                            AutoButtonColor = v.AutoButtonColor,
                            Active = v.Active
                        };
                    end;

                    v.AutoButtonColor = false;
                    v.Active = false;
                end;
            end;
        end;

        return;
    end;

    for i, v in u12 do
        if i and i.Parent then
            i.AutoButtonColor = v.AutoButtonColor;
            i.Active = v.Active;
        end;
    end;

    table.clear(u12);
end;

local function ApplyGiftRecipient(p162: userdata) -- Line: 1397
    -- upvalues: Knit (copy), u7 (ref), u6 (ref), u9 (ref), SetGiftingVisuals (copy), SetGiftingModeOnButtons (copy), SetBlockedProductButtons (copy)
    local v163, v164, v165 = Knit.GetService("ShopService"):SetGiftTarget(p162.UserId):await();

    if not (v163 and v164) then
        warn((`[Shop] SetGiftTarget failed for {p162.Name}: {tostring(v165)}`));
        Knit.GetController("NotificationController"):Show("Custom", "Couldn\'t start gifting — try again!", 5, Color3.new(1, 0.8, 0), Color3.new(0.4, 0.3, 0), "Error");

        return;
    end;

    u7 = p162;
    u6 = true;

    if u9 then
        u9.Text = "Gifting to: " .. p162.Name;
    end;

    SetGiftingVisuals(true);
    SetGiftingModeOnButtons(true);
    SetBlockedProductButtons(true);
end;

local function ExitGiftingMode() -- Line: 1430
    -- upvalues: u6 (ref), u7 (ref), u10 (ref), SetGiftingVisuals (copy), SetGiftingModeOnButtons (copy), u5 (copy), u12 (copy), Knit (copy)
    u6 = false;
    u7 = nil;

    if u10 and u10:IsOpen() then
        u10:Close();
    end;

    SetGiftingVisuals(false);
    SetGiftingModeOnButtons(false);
    local _ = u5.ShopFrame;

    for i, v in u12 do
        if i and i.Parent then
            i.AutoButtonColor = v.AutoButtonColor;
            i.Active = v.Active;
        end;
    end;

    table.clear(u12);
    Knit.GetService("ShopService"):SetGiftTarget(0);
end;

local function OpenGiftPicker() -- Line: 1448
    -- upvalues: u10 (ref), u7 (ref), ApplyGiftRecipient (copy)
    if u10 then
        u10:Open({
            Header = "GIFT",
            Subtitle = "Select a player to gift",
            SelectedUserId = u7 and u7.UserId or nil,

            OnSelect = function(p166: userdata) -- Line: 1458, Name: OnSelect
                -- upvalues: ApplyGiftRecipient (ref)
                ApplyGiftRecipient(p166);
            end
        });

        return;
    end;

    warn("[Shop] PlayerListController unavailable — cannot open gift picker");
end;

local u167 = { "Bundles", "GrandSovereign", "ShadowMonarch", "GamePass", "DevProducts", "Cosmetics" };
local u168 = {
    Bundles = "Bundles",
    GamePass = "Gamepasses",
    DevProducts = "Dev Products",
    Cosmetics = "Cosmetics",
    GrandSovereign = "Grand Sovereign",
    ShadowMonarch = "Shadow Monarch"
};
local u169 = 1;
local u170 = nil;
local u171 = nil;
local u172 = nil;
local u173 = nil;
local u174 = nil;

local function GetCenteredCategory() -- Line: 1494
    -- upvalues: GetShopScroll (copy), u167 (copy)
    local v175 = GetShopScroll();

    if not v175 or v175.AbsoluteWindowSize.X <= 0 then
        return nil;
    end;

    local v176 = v175.AbsolutePosition.X + v175.AbsoluteWindowSize.X / 2;
    local v177 = nil;
    local v178 = nil;

    for _, v in u167 do
        local v179 = v175:FindFirstChild(v);

        if v179 then
            local math_abs_ret = math.abs(v179.AbsolutePosition.X + v179.AbsoluteSize.X / 2 - v176);

            if not v177 or math_abs_ret < v177 then
                v178 = v;
                v177 = math_abs_ret;
            end;
        end;
    end;

    return v178;
end;

local function SyncCosmeticViewports() -- Line: 1515
    -- upvalues: GetCenteredCategory (copy), u174 (ref), TeardownCosmeticViewports (copy), u101 (copy), TeardownLimitedPackViewports (copy), BuildCosmeticViewports (copy), BuildLimitedPackViewports (copy)
    local v180 = GetCenteredCategory();

    if v180 == u174 then
        return;
    end;

    if u174 == "Cosmetics" then
        TeardownCosmeticViewports();
    elseif u174 and u101[u174] then
        TeardownLimitedPackViewports(u174);
    end;

    u174 = v180;

    if v180 == "Cosmetics" then
        BuildCosmeticViewports();

        return;
    end;

    if v180 and u101[v180] then
        BuildLimitedPackViewports(v180);
    end;
end;

local function CenterCategory(p181: string, p182: boolean?) -- Line: 1537
    -- upvalues: GetShopScroll (copy), CenterCategory (copy), u170 (ref), TweenService (copy)
    local v183 = GetShopScroll();
    local v184;

    if v183 then
        v184 = v183:FindFirstChild(p181);
    else
        v184 = v183;
    end;

    if not (v183 and v184) then
        return;
    end;

    if v183.AbsoluteWindowSize.X <= 0 then
        task.defer(CenterCategory, p181, false);

        return;
    end;

    local v185 = v184.AbsolutePosition.X - v183.AbsolutePosition.X + v183.CanvasPosition.X + v184.AbsoluteSize.X / 2 - v183.AbsoluteWindowSize.X / 2;
    local math_max_ret = math.max(0, v183.AbsoluteCanvasSize.X - v183.AbsoluteWindowSize.X);
    local math_clamp_ret = math.clamp(v185, 0, math_max_ret);
    local Vector2_new_ret = Vector2.new(math_clamp_ret, v183.CanvasPosition.Y);

    if u170 then
        u170:Cancel();
        u170 = nil;
    end;

    if p182 == false then
        v183.CanvasPosition = Vector2_new_ret;

        return;
    end;

    u170 = TweenService:Create(v183, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        CanvasPosition = Vector2_new_ret
    });
    u170:Play();
end;

local function UpdateCategoryLabels() -- Line: 1574
    -- upvalues: u167 (copy), u169 (ref), u171 (ref), u168 (copy), u172 (ref), u173 (ref)
    local v186 = #u167;
    local v187 = u167[(u169 - 2) % v186 + 1];
    local v188 = u167[u169 % v186 + 1];
    local v189 = u167[u169];

    if u171 then
        u171.Text = u168[v187];
    end;

    if u172 then
        u172.Text = u168[v189];
    end;

    if u173 then
        u173.Text = u168[v188];
    end;
end;

local function ShowCategory(p190: number, p191: boolean?) -- Line: 1586
    -- upvalues: u167 (copy), u169 (ref), u171 (ref), u168 (copy), u172 (ref), u173 (ref), CenterCategory (copy)
    u169 = (p190 - 1) % #u167 + 1;
    local v192 = #u167;
    local v193 = u167[(u169 - 2) % v192 + 1];
    local v194 = u167[u169 % v192 + 1];
    local v195 = u167[u169];

    if u171 then
        u171.Text = u168[v193];
    end;

    if u172 then
        u172.Text = u168[v195];
    end;

    if u173 then
        u173.Text = u168[v194];
    end;

    CenterCategory(u167[u169], p191);
end;

local function SetupCategoryCarousel() -- Line: 1597
    -- upvalues: u5 (copy), u171 (ref), u173 (ref), u172 (ref), u169 (ref), u167 (copy), u168 (copy), CenterCategory (copy), GetShopScroll (copy), SyncCosmeticViewports (copy)
    local ShopFrame = u5.ShopFrame;
    local CycleBack = ShopFrame:FindFirstChild("CycleBack");
    local CycleForward = ShopFrame:FindFirstChild("CycleForward");
    local PageDisplay = ShopFrame:FindFirstChild("PageDisplay");
    local v196;

    if CycleBack then
        v196 = CycleBack:FindFirstChild("TextLabel");
    else
        v196 = CycleBack;
    end;

    u171 = v196;
    local v197;

    if CycleForward then
        v197 = CycleForward:FindFirstChild("TextLabel");
    else
        v197 = CycleForward;
    end;

    u173 = v197;
    local v198;

    if PageDisplay then
        v198 = PageDisplay:FindFirstChild("TextLabel");
    else
        v198 = PageDisplay;
    end;

    u172 = v198;

    if CycleForward then
        CycleForward.MouseButton1Click:Connect(function() -- Line: 1608
            -- upvalues: u169 (ref), u167 (ref), u171 (ref), u168 (ref), u172 (ref), u173 (ref), CenterCategory (ref)
            u169 = (u169 + 1 - 1) % #u167 + 1;
            local v199 = #u167;
            local v200 = u167[(u169 - 2) % v199 + 1];
            local v201 = u167[u169 % v199 + 1];
            local v202 = u167[u169];

            if u171 then
                u171.Text = u168[v200];
            end;

            if u172 then
                u172.Text = u168[v202];
            end;

            if u173 then
                u173.Text = u168[v201];
            end;

            CenterCategory(u167[u169], nil);
        end);
    end;

    if CycleBack then
        CycleBack.MouseButton1Click:Connect(function() -- Line: 1613
            -- upvalues: u169 (ref), u167 (ref), u171 (ref), u168 (ref), u172 (ref), u173 (ref), CenterCategory (ref)
            u169 = (u169 - 1 - 1) % #u167 + 1;
            local v203 = #u167;
            local v204 = u167[(u169 - 2) % v203 + 1];
            local v205 = u167[u169 % v203 + 1];
            local v206 = u167[u169];

            if u171 then
                u171.Text = u168[v204];
            end;

            if u172 then
                u172.Text = u168[v206];
            end;

            if u173 then
                u173.Text = u168[v205];
            end;

            CenterCategory(u167[u169], nil);
        end);
    end;

    if PageDisplay then
        PageDisplay.MouseButton1Click:Connect(function() -- Line: 1618
            -- upvalues: u169 (ref), u167 (ref), u171 (ref), u168 (ref), u172 (ref), u173 (ref), CenterCategory (ref)
            u169 = (u169 - 1) % #u167 + 1;
            local v207 = #u167;
            local v208 = u167[(u169 - 2) % v207 + 1];
            local v209 = u167[u169 % v207 + 1];
            local v210 = u167[u169];

            if u171 then
                u171.Text = u168[v208];
            end;

            if u172 then
                u172.Text = u168[v210];
            end;

            if u173 then
                u173.Text = u168[v209];
            end;

            CenterCategory(u167[u169], nil);
        end);
    end;

    local v211 = GetShopScroll();

    if v211 then
        v211:GetPropertyChangedSignal("CanvasPosition"):Connect(SyncCosmeticViewports);
    end;

    u169 = 1;
    local v212 = #u167;
    local v213 = u167[(u169 - 2) % v212 + 1];
    local v214 = u167[u169 % v212 + 1];
    local v215 = u167[u169];

    if u171 then
        u171.Text = u168[v213];
    end;

    if u172 then
        u172.Text = u168[v215];
    end;

    if u173 then
        u173.Text = u168[v214];
    end;
end;

function u5._Init(p216) -- Line: 1637
    -- upvalues: u1 (ref), u5 (copy), u2 (ref), Registry (copy), u4 (ref), Knit (copy), ChestData (copy), u8 (ref), u9 (ref), u10 (ref), u6 (ref), ExitGiftingMode (copy), OpenGiftPicker (copy), Players2 (copy), u7 (ref), SetupCategoryCarousel (copy), UpdateOwnedBundles (copy), UpdateExtraPotions (copy), UpdateLimitedBundleStock (copy), u167 (copy), u169 (ref), u171 (ref), u168 (copy), u172 (ref), u173 (ref), CenterCategory (copy), u66 (copy), u68 (copy), SetupBundleViewport (copy), ApplyCosmeticSetToClone (copy), TeardownCosmeticViewports (copy), u101 (copy), TeardownLimitedPackViewports (copy), u174 (ref)
    u1 = p216;
    u5.ShopFrame = p216.Frames.Shop;
    u2 = Registry:Get("PlayerData");
    u4 = Knit.GetController("NoticeController");
    u4:Register("Shop", u1.HUD.Left.Shop.Notice_Icon, function() -- Line: 1647
        -- upvalues: u2 (ref), ChestData (ref)
        local v217 = u2.Data.Rebirths or 0;
        local FreeChests = u2.Data.FreeChests;
        local v218 = FreeChests and (FreeChests.ClaimedIds or {}) or {};
        local v219 = FreeChests and FreeChests.ResetTimestamp or 0;
        local v220 = #v218 > 0 and (v219 > 0 and os.time() - v219 >= ChestData.FREE_CHEST_RESET_INTERVAL) and {} or v218;

        for i, v in ipairs(ChestData.FreeChests) do
            if v.RequiredRebirth <= v217 and not table.find(v220, i) then
                return true;
            end;
        end;

        return false;
    end);
    u8 = u5.ShopFrame:FindFirstChild("Gift_Button") or u5.ShopFrame:FindFirstChild("Gift");
    u9 = u5.ShopFrame:FindFirstChild("GiftingTo");
    pcall(function() -- Line: 1685
        -- upvalues: u10 (ref), Knit (ref)
        u10 = Knit.GetController("PlayerListController");
    end);

    if u8 then
        u8.MouseButton1Click:Connect(function() -- Line: 1689
            -- upvalues: u6 (ref), ExitGiftingMode (ref), OpenGiftPicker (ref)
            if u6 then
                ExitGiftingMode();

                return;
            end;

            OpenGiftPicker();
        end);
    end;

    if u9 then
        u9.Visible = false;
    end;

    Players2.PlayerRemoving:Connect(function(p221) -- Line: 1704
        -- upvalues: u6 (ref), u7 (ref), ExitGiftingMode (ref), Knit (ref)
        if not u6 or p221 ~= u7 then
            return;
        end;

        local Name = p221.Name;
        ExitGiftingMode();
        Knit.GetController("NotificationController"):Show("Custom", Name .. " left the game — gifting cancelled", 5, Color3.new(1, 0.8, 0), Color3.new(0.4, 0.3, 0), "Error");
    end);
    SetupCategoryCarousel();
    UpdateOwnedBundles();
    UpdateExtraPotions();
    UpdateLimitedBundleStock();
    u2:OnChange(function(p222, p223) -- Line: 1727
        -- upvalues: UpdateOwnedBundles (ref), UpdateLimitedBundleStock (ref), UpdateExtraPotions (ref)
        if p223[1] == "OwnedFoundersBundle" or (p223[1] == "OwnedProtectionUpgradeBundle" or (p223[1] == "OwnedReleaseBundle" or (p223[1] == "OwnedArchonBundle" or (p223[1] == "OwnedEclipseBundle" or (p223[1] == "OwnedEastSeasBundle" or (p223[1] == "OwnedJetstreamBundle" or (p223[1] == "OwnedSupporterBundle" or p223[1] == "ClassItems"))))))) then
            UpdateOwnedBundles();
            UpdateLimitedBundleStock();
        end;

        if p223[1] == "PermanentItems" then
            UpdateExtraPotions();
        end;
    end);
    u5.ShopFrame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 1738
        -- upvalues: u5 (ref), u167 (ref), u169 (ref), u171 (ref), u168 (ref), u172 (ref), u173 (ref), CenterCategory (ref), u66 (ref), u68 (ref), SetupBundleViewport (ref), ApplyCosmeticSetToClone (ref), TeardownCosmeticViewports (ref), u101 (ref), TeardownLimitedPackViewports (ref), u174 (ref), u6 (ref), u10 (ref), ExitGiftingMode (ref)
        if not u5.ShopFrame.Visible then
            for _, v in u66 do
                local v224 = u68[v.FrameName];

                if v224 and (v224.animTrack and v224.animTrack.IsPlaying) then
                    v224.animTrack:Stop();
                end;
            end;

            TeardownCosmeticViewports();

            for i in u101 do
                TeardownLimitedPackViewports(i);
            end;

            u174 = nil;

            if u6 or u10 and u10:IsOpen() then
                ExitGiftingMode();
            end;

            return;
        end;

        u169 = 0 % #u167 + 1;
        local v225 = #u167;
        local v226 = u167[(u169 - 2) % v225 + 1];
        local v227 = u167[u169 % v225 + 1];
        local v228 = u167[u169];

        if u171 then
            u171.Text = u168[v226];
        end;

        if u172 then
            u172.Text = u168[v228];
        end;

        if u173 then
            u173.Text = u168[v227];
        end;

        CenterCategory(u167[u169], false);

        for _, v in u66 do
            local u229 = u68[v.FrameName];

            if u229 and u229.setup then
                if u229.animTrack then
                    u229.animTrack:Play();
                end;
            else
                SetupBundleViewport(v);
                u229 = u68[v.FrameName];
            end;

            if u229 and v.RotateSets then
                if #v.RotateSets > 1 then
                    u229.rotationId = (u229.rotationId or 0) + 1;
                    local rotationId = u229.rotationId;
                    task.spawn(function() -- Line: 689
                        -- upvalues: u229 (copy), rotationId (copy), u5 (ref), v (copy), ApplyCosmeticSetToClone (ref)
                        while u229.rotationId == rotationId do
                            task.wait(5);

                            if u229.rotationId ~= rotationId then
                                return;
                            end;

                            if not u5.ShopFrame.Visible then
                                return;
                            end;

                            if not (u229.clone and u229.clone.Parent) then
                                return;
                            end;

                            u229.rotationIndex = u229.rotationIndex % #v.RotateSets + 1;
                            ApplyCosmeticSetToClone(u229.clone, v.RotateSets[u229.rotationIndex]);
                        end;
                    end);
                end;
            end;
        end;
    end);
end;

return u5;